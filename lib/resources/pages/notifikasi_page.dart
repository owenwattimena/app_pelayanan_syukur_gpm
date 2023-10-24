import 'package:com.wentox.pelayanansyukurgpm/app/models/api_return_value.dart';
import 'package:com.wentox.pelayanansyukurgpm/app/networking/api_service.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/notifikasi.dart';
import '../../app/models/user.dart';
import '../../app/respositories/auth_repository.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/notif_widget.dart';
import '/app/controllers/notifikasi_controller.dart';

class NotifikasiPage extends NyStatefulWidget {
  final NotifikasiController controller = NotifikasiController();

  static const path = '/notifikasi';

  NotifikasiPage({Key? key}) : super(key: key);

  @override
  _NotifikasiPageState createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends NyState<NotifikasiPage> {
  AuthRepository _authRepo = AuthRepository();
  ApiService _apiService = ApiService();
  List<Notifikasi?> _notifikasi = [];
  @override
  init() async {
    super.init();
    getNotifikasi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getNotifikasi() async
  {
    User? user = Auth.user();

    ApiReturnValue? result =await _apiService.fetchNotifikasiData(token: _authRepo.token, idUnit: user!.idUnit ?? 0);

    if(result != null)
    {
        if(result.status)
        {
          setState(() {
            _notifikasi = result.value as List<Notifikasi?>;
          });
        }

    }
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
                      Row(
                        children: [
                          Text("Notifikasi")
                              .bodySmall(context)
                              .setStyle(TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14))
                              .setColor(context, (color) => color.background),
                        ],
                      ),
                    ],
                  ),
                  Text("")
                      .bodySmall(context)
                      .setStyle(
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                      .setColor(context, (color) => color.primaryContent),
                  Text("")
                      .bodySmall(context)
                      .setColor(context, (color) => color.primaryContent),
                ],
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              color: ThemeColor.get(context).background,
              child: SingleChildScrollView(
                child: Column(children: (_notifikasi.isEmpty) ? [Text("Tidak data data.")] :  _notifikasi.map((item) => NotifWidget(judul: "${item?.judul}", isi: "${item?.isi}", createdAt: "${item?.createdAt}",)).toList() ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}
