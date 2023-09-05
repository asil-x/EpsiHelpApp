import 'package:flutter/material.dart';

import '../colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final String imagePath;
  final bool isImageOnline;

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.imagePath = "",
    this.isImageOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 2,
      leading: BackButton(
        color: kPurple,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          isImageOnline
              ? CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      imagePath.isNotEmpty ? NetworkImage(imagePath) : null,
                  backgroundColor: kGrey,
                  child: imagePath.isEmpty
                      ? const Icon(Icons.person, color: Colors.black)
                      : null,
                )
              : CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      imagePath.isNotEmpty ? NetworkImage(imagePath) : null,
                  backgroundColor: kGrey,
                  child: imagePath.isEmpty
                      ? const Icon(Icons.person, color: Colors.black)
                      : null,
                ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
