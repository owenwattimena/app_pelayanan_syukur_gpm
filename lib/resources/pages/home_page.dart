import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/jadwal_widget.dart';
import '/app/controllers/home_controller.dart';
import '/bootstrap/helpers.dart';
import 'package:nylo_framework/nylo_framework.dart';

import 'kelahiran_page.dart';
import 'pernikahan_page.dart';

class HomePage extends NyStatefulWidget {
  static const path = '/home-page';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends NyState<HomePage> {
  final HomeController controller = HomeController();

  @override
  init() async {
    super.init();
    controller.getUser();
    controller.user.listen((value) {
      if (value != null) {
        controller.getPengaturan();
        controller.getSektorUnit();
        // controller.getPernikahan();
        // controller.getKelahiran();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeColor.get(context).background,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text((controller.user.value == null)
                          ? ''
                          : "Hi, ${controller.user.value!.namalengkap}")
                      .headingMedium(context)
                      .setStyle(TextStyle(fontWeight: FontWeight.w900))),
                  SizedBox(height: 5),
                  Text("Selamat datang!").bodyMedium(context),
                  SizedBox(height: 19),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 17, horizontal: 30),
                    decoration: BoxDecoration(
                      color: ThemeColor.get(context).primaryContent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'public/assets/app_icon/logo-alarm.png',
                          width: 35,
                        ),
                        SizedBox(width: 19),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("JADWAL PELAYANAN")
                                .setColor(
                                    context,
                                    (color) =>
                                        ThemeColor.get(context).background)
                                .setStyle(
                                    TextStyle(fontWeight: FontWeight.w900)),
                            Obx(() => Text(
                                    controller.pengaturan.value?.namaJemaat ??
                                        '')
                                .setColor(
                                    context,
                                    (color) =>
                                        ThemeColor.get(context).background)
                                .setStyle(
                                    TextStyle(fontWeight: FontWeight.w900))),
                            SizedBox(height: 10),
                            Obx(() => Text(
                                    "Unit ${controller.sektorUnit.value?.unit ?? ''}, Sektor ${controller.sektorUnit.value?.sektor ?? ''}")
                                .setColor(
                                    context,
                                    (color) =>
                                        ThemeColor.get(context).background)),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Pernikahan")
                          .setStyle(TextStyle(fontWeight: FontWeight.w900)),
                      GestureDetector(
                          onTap: () {
                            routeTo(PernikahanPage.path);
                          },
                          child: Text("Selengkapnya").setStyle(TextStyle(
                              fontSize: 12,
                              color: ThemeColor.get(context).primaryAccent))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Obx(() => controller.pernikahanList.value != null
                      ? Column(
                          children: controller.pernikahanList.value!
                              .map((item) => JadwalWidget(
                                    imagePath:
                                        'public/assets/images/ring-image.jpg',
                                    title:
                                        "${item.namaPria} & ${item.namaWanita}",
                                    tanggal: DateTime.parse("${item.tanggal}"),
                                    jam: "${item.jam}",
                                    alamat: "${item.alamat}",
                                  ))
                              .toList(),
                        )
                      : SizedBox()),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kelahiran")
                          .setStyle(TextStyle(fontWeight: FontWeight.w900)),
                      GestureDetector(
                          onTap: () {
                            routeTo(KelahiranPage.path);
                          },
                          child: Text("Selengkapnya").setStyle(TextStyle(
                              fontSize: 12,
                              color: ThemeColor.get(context).primaryAccent))),
                    ],
                  ),
                  SizedBox(height: 15),
                  Obx(() => (controller.kelahiranList.value != null)
                      ? Column(
                          children: controller.kelahiranList.value!
                              .map((item) => JadwalWidget(
                                    imagePath:
                                        'public/assets/images/star_image.jpg',
                                    title: '${item.nama}',
                                    tanggal: DateTime.parse("${item.tanggal}"),
                                    jam: "${item.jam}",
                                    alamat: "${item.alamat}",
                                  ))
                              .toList(),
                        )
                      : SizedBox()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
