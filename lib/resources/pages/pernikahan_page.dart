import 'package:flutter/material.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/jadwal_widget.dart';
import '/app/controllers/pernikahan_controller.dart';

class PernikahanPage extends NyStatefulWidget {
  static const path = '/pernikahan';

  PernikahanPage({Key? key}) : super(key: key);

  @override
  _PernikahanPageState createState() => _PernikahanPageState();
}

class _PernikahanPageState extends NyState<PernikahanPage> {
  final PernikahanController controller = PernikahanController();

  @override
  init() async {
    super.init();
    controller.getPernikahan();
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
                      Text("Pernikahan")
                          .bodySmall(context)
                          .setStyle(TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                          .setColor(context, (color) => color.background),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Pelayanan Pernikahan")
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
                child: Obx(() => controller.pernikahanList.value != null
                    ? Column(
                        children: controller.pernikahanList.value!
                            .map((item) => JadwalWidget(
                                  imagePath:
                                      'public/assets/images/ring-image.jpg',
                                  title:
                                      "${item.namaPria} \n& ${item.namaWanita}",
                                  tanggal:DateTime.parse("${item.tanggal}"),
                                  usia: "${item.usia}",
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
