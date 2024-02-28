// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:path/path.dart' as path;
// import 'package:path_provider/path_provider.dart' as syspaths;


class ImageInput extends StatefulWidget {
  Function onSelectedImage;

  ImageInput(this.onSelectedImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    widget.onSelectedImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storedImage != null
              ? Image.file(_storedImage!,
              fit: BoxFit.cover, width: double.infinity)
              : Text(
            'No Image Taken',
            textAlign: TextAlign.center,
          ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            // textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture, style:TextButton.styleFrom(
            foregroundColor: Theme.of(context).primaryColor,
          ),),

        )
      ],
    );
  }
}
