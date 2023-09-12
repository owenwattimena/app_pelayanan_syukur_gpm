import 'package:flutter/material.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:intl/intl.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../bootstrap/helpers.dart';

class JadwalWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final DateTime tanggal;
  final String jam;
  final String alamat;
  const JadwalWidget(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.tanggal,
      required this.jam,
      required this.alamat
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: 60,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  Text(title, softWrap: false, overflow: TextOverflow.ellipsis)
                      .setColor(context,
                          (color) => ThemeColor.get(context).surfaceContent)
                      .setStyle(TextStyle(fontWeight: FontWeight.w900)),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16.0,
                  ),
                  SizedBox(width: 5),
                  Text("${DateFormat('yyyy-MM-dd').format(tanggal)} - $jam")
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                  maxWidth: 250,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.map,
                      size: 16.0,
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        alamat,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
