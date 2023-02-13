import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  var _storedImage = File('assets/images/placeHolder.jpeg');

  Future<void> _takePicture() async {
    var imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (imageFile == null) return;
    setState(() {
      _storedImage = File((imageFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedImage);
  }

  Future<void> _pickPicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
    setState(() {
      _storedImage = File((imageFile as XFile).path);
    });
    //final appDir = await syspath.getApplicationDocumentsDirectory();
    //final fileName = path.basename((imageFile as XFile).path);
    //final savedImage = await _storedImage.copy('$appDir/$fileName');
    widget.onSelectImage(_storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 200,
          width: 200,
          child: Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () => _takePicture(),
              icon: const Icon(Icons.camera),
              label: const Text('Take a picture'),
            ),
            TextButton.icon(
              onPressed: () => _pickPicture(),
              icon: const Icon(Icons.image),
              label: const Text('Pick from gallery'),
            )
          ],
        )),
      ],
    );
  }
}
