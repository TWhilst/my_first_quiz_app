import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_first_quiz_app/global_widgets/text_widget.dart';

class CustomTile extends StatelessWidget {
  final String title, imageUrl;
  const CustomTile({Key? key, required this.title, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: EText(text: title),
      leading: CircleAvatar(
        radius: 22,
        foregroundColor: Colors.transparent,
        foregroundImage: CachedNetworkImageProvider(imageUrl),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(Icons.clear),
      ),

    );
  }
}
