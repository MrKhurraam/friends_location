import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_provider.dart';

class UserImagePicker extends StatelessWidget {
  final UserBloc bloc;

  UserImagePicker({
    required this.bloc,
    super.key,
  });

  // final formKey = GlobalKey<>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: StreamBuilder(
              stream: bloc.imageLink,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Image.network(
                    'https://static.thenounproject.com/png/2413564-200.png',
                    fit: BoxFit.cover,
                  );
                }
                return Container(
                    // width: 100,
                    // height: 100,
                    child: Image.file(
                  snapshot.data!,
                  fit: BoxFit.cover,
                ));
              }),
        ),
        ElevatedButton.icon(
          onPressed: () {
            imagePickerOption(bloc, context);
          },
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }

  imagePickerOption(UserBloc user, context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera, user, context);
                    },
                    icon: Icon(Icons.camera),
                    label: Text("Camera"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery, user, context);
                    },
                    icon: Icon(Icons.image),
                    label: Text("Gallery"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close),
                    label: Text("Cancel"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  pickImage(ImageSource imageType, UserBloc user, context) async {
    final ImagePicker _picker = ImagePicker();
    try {
      final photo = await _picker.pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      user.changeImage(tempImage);
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }
}
