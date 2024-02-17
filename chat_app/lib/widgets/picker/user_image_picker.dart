import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function pickedImageFn;

  const UserImagePicker(this.pickedImageFn, {super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  String? _defaultImage;

  void _addImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.pickedImageFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _pickedImage == null
            ? const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMLYACaGIbSwNMTz6AN8Vac6G8NidhAU0QoguP79Q&s'),
              )
            : CircleAvatar(
                radius: 40,
                backgroundImage: FileImage(_pickedImage!),
              ),
        TextButton.icon(onPressed: _addImage, icon: const Icon(Icons.image), label: const Text('Add image'))
      ],
    );
  }
}
