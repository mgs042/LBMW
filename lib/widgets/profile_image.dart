import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => EnlargedImageDialog(
            image: NetworkImage(imageUrl),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 150),
        child: Container(
          padding: EdgeInsets.all(4),
          child: CircleAvatar(
            radius: 4,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ),
    );
  }
}

class EnlargedImageDialog extends StatelessWidget {
  final ImageProvider image;

  const EnlargedImageDialog({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxWidth: 400),
        child: Image(image: image),
      ),
    );
  }
}
