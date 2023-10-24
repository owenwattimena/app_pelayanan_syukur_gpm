import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../bootstrap/helpers.dart';

class NotifWidget extends StatelessWidget {
  final String judul, isi, createdAt;
  NotifWidget({required this.judul, required this.isi, required this.createdAt}) ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset('public/assets/app_icon/notif_icon.png'),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("$judul")
                      .setColor(context,
                          (color) => ThemeColor.get(context).surfaceContent)
                      .setStyle(
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
                  Text("$isi"),
                  SizedBox(height: 5),
                  Text("$createdAt").setStyle(
                          TextStyle(fontSize: 11)),

                ],
              ),
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
