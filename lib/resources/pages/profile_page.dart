import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/user.dart';
import '../widgets/input_widget.dart';
import '/app/controllers/profile_controller.dart';
import '../../bootstrap/helpers.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';

class ProfilePage extends NyStatefulWidget {
  static const path = '/profile';

  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends NyState<ProfilePage> {
  final ProfileController controller = ProfileController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  @override
  init() async {
    super.init();
    controller.getUser().then((value) {
      setState(() {
        namaController.text = controller.user.value?.namalengkap ?? '';
        emailController.text = controller.user.value?.email ?? '';
        teleponController.text = controller.user.value?.telepon ?? '';
      });
    });
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
                      Text("Profile")
                          .bodySmall(context)
                          .setStyle(TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18))
                          .setColor(context, (color) => color.background),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Ubah data profile anda")
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
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputWidget(
                          controller: namaController,
                          label: 'Nama Lengkap',
                          placeholder: 'Masukan Nama Lengkap',
                        ),
                        InputWidget(
                          controller: emailController,
                          label: 'Email',
                          placeholder: 'Masukan Email',
                        ),
                        InputWidget(
                          controller: teleponController,
                          label: 'No. Telepon',
                          placeholder: 'Masukan No. Telepon',
                        ),
                        SizedBox(height: 25),
                        ElevatedButton(
                          onPressed:
                              !isLoading(name: 'simpan') ? _submitForm : null,
                          child: Text(!isLoading(name: 'simpan')
                              ? "SIMPAN"
                              : "Proses..."),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeColor.get(context)
                                .primaryContent, // Atur warna latar belakang tombol
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
                    )),
              ),
            ))
          ],
        )),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setLoading(true, name: 'simpan');
      // Form is valid, proceed with form submission
      _formKey.currentState!.save(); // Save the form fields' values
      User userData = controller.user.value!.copyWith(
        namaLengkap: namaController.text,
        email: emailController.text,
        telepon: teleponController.text
      );

      User? user = await controller.updateProfile(userData);
      if(user != null)
      {
        Auth.set(user);
        setLoading(false, name: 'simpan');
        showToastSuccess(description: "Berhasil mengubah profile.");
      }
    } else {
      showToastSorry(description: "Terjadi kesalahan saat mengubah profile.");
    }
  }
}
