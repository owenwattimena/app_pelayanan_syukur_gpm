import 'package:flutter/material.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/jadwal_widget.dart';
import '/app/controllers/kelahiran_controller.dart';

class KelahiranPage extends NyStatefulWidget {
  static const path = '/kelahiran';

  KelahiranPage({Key? key}) : super(key: key);

  @override
  _KelahiranPageState createState() => _KelahiranPageState();
}

class _KelahiranPageState extends NyState<KelahiranPage> {
  final KelahiranController controller = KelahiranController();

  @override
  init() async {
    super.init();
    controller.getKelahiran();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeColor.get(context).primaryContent,
        child: SafeArea(
            child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 20),
              color: ThemeColor.get(context).primaryContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: ThemeColor.get(context).background,
                          )),
                      Text("Kelahiran")
                          .bodySmall(context)
                          .setStyle(TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                          .setColor(context, (color) => color.background),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Pelayanan Kelahiran")
                        .bodySmall(context)
                        .setColor(context, (color) => color.background),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              color: ThemeColor.get(context).background,
              child: SingleChildScrollView(
                child: Obx(() => controller.kelahiranList.value != null
                    ? Column(
                        children: controller.kelahiranList.value!
                            .map((item) => JadwalWidget(
                                  imagePath:
                                      'public/assets/images/star_image.jpg',
                                  title: "${item.nama}",
                                  tanggal: DateTime.parse("${item.tanggal}"),
                                  jam: "${item.jam}",
                                  alamat: "${item.alamat}",
                                ))
                            .toList(),
                      )
                    : SizedBox()),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
