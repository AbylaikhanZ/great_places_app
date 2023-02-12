import 'dart:io';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

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
    setState(() {
      _storedImage = File((imageFile as XFile).path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename((imageFile as XFile).path);
    final savedImage = await _storedImage.copy('$appDir/$fileName');
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
