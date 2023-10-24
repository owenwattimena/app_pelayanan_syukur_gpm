import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../bootstrap/helpers.dart';
import '/app/controllers/akun_controller.dart';
import './profile_page.dart';
import './login_page.dart';

class AkunPage extends NyStatefulWidget {
  static const path = '/akun';

  AkunPage({Key? key}) : super(key: key);

  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends NyState<AkunPage> {
  final AkunController controller = AkunController();

  @override
  init() async {
    super.init();
    controller.getUser();
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
          child: Column(children: [
            Container(
              padding:
                  EdgeInsets.only(top: 30, right: 30, bottom: 30, left: 30),
              color: ThemeColor.get(context).primaryContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Profil")
                          .bodySmall(context)
                          .setStyle(TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14))
                          .setColor(context, (color) => color.background),
                    ],
                  ),
                  Obx(() => Text(
                          "${controller.user.value?.namalengkap ?? '...'}")
                      .bodySmall(context)
                      .setStyle(
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                      .setColor(context, (color) => color.background)),
                  Obx(() => Text("${controller.user.value?.email ?? '...'}")
                      .bodySmall(context)
                      .setColor(context, (color) => color.background)),
                ],
              ),
            ),
            Expanded(
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(30),
                    color: ThemeColor.get(context).background,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              routeTo(ProfilePage.path);
                             },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Profile'),
                                Icon(Icons.keyboard_arrow_right)
                              ],
                            ),
                          ),
                          // Divider(),
                          // Row(
                          //   children: [Text('Notifikasi')],
                          // ),
                          Divider(),
                          ElevatedButton(
                            onPressed: () async {
                              await Auth.remove();
                              routeTo(LoginPage.path, navigationType: NavigationType.pushAndForgetAll);
                            },
                            child: Text(!isLoading(name: 'login')
                                ? "KELUAR"
                                : "Proses..."),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ThemeColor.get(context)
                                  .buttonLogout, // Atur warna latar belakang tombol
                              textStyle: TextStyle(
                                  fontSize: 18), // Atur gaya teks tombol
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))
          ]),
        ),
      ),
    );
  }
}
