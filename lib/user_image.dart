import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'round_image.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class UserImage extends StatefulWidget{

  final Function(String imageUrl) onFileChanged;

  UserImage({required this.onFileChanged});
  @override
  _UserImageState createState() => _UserImageState();
}

class _UserImageState extends State<UserImage>
{
  final ImagePicker _picker = ImagePicker();
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null)
          Icon(Icons.image, size: 60, color: Colors.amber)
        else
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundImage.url(
              imageUrl!,
              width: 150,
              height: 150,
            )
          ),
        InkWell(
          onTap: () => _selectPhoto(),
          child: Padding(
            padding: EdgeInsets.all(0.0),
            child: Text(imageUrl != null ? 'Поменять фото' : 'Выбрать фото')
          ) // СТИЛЬ
        )
      ],
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(context: context, builder:
        (context) => BottomSheet(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          ListTile(leading: Icon(Icons.camera), title: Text('Камера'), onTap:(){
            Navigator.of(context).pop();
            _pickImage(ImageSource.camera);}
          ),
          ListTile(leading: Icon(Icons.folder), title: Text('Выбрать из устройства'),
              onTap:(){
            Navigator.of(context).pop();
            _pickImage(ImageSource.gallery);}
          )
        ]
      ),
          onClosing: () {},
    ));
  }

  Future _pickImage (ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null){
      return;
    }
    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path,
    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }
    file = await compressImage(file.path, 35);
    await _uploadFile(file.path);
  }
  
  Future<File> compressImage (String path, int quality) async{
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path,
        newPath, quality: quality);

    return result!;
  }

  Future _uploadFile (String path) async {
    final ref = storage.FirebaseStorage.instance.ref().child(
        'images').child ('${DateTime.now().toIso8601String() + p.basename(path)}');
    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();
    setState(() {
      imageUrl = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}