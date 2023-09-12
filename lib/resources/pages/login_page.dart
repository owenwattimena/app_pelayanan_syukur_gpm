import 'package:flutter/material.dart';
import 'package:com.wentox.pelayanansyukurgpm/app/models/user.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';
// import 'package:com.wentox.pelayanansyukurgpm/resources/pages/register_page.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../bootstrap/helpers.dart';
import '../widgets/input_widget.dart';
import '/app/controllers/login_controller.dart';
import 'main_page.dart';

class LoginPage extends NyStatefulWidget {
  static const path = '/login';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends NyState<LoginPage> {
  final LoginController controller = LoginController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  init() async {
    super.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: ThemeColor.get(context).primaryContent,
          child: SafeArea(
              child: Stack(children: [
            Container(
              padding: EdgeInsets.all(30),
              height: 210,
              color: ThemeColor.get(context).primaryContent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'public/assets/app_icon/logo-alarm.png',
                        width: 44,
                      ),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("JADWAL PELAYANAN")
                              .bodySmall(context)
                              .setStyle(TextStyle(fontWeight: FontWeight.bold))
                              .setColor(context, (color) => color.background),
                          Text("JEMAAT GPM")
                              .bodySmall(context)
                              .setStyle(TextStyle(fontWeight: FontWeight.bold))
                              .setColor(context, (color) => color.background),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Login")
                      .headingMedium(context)
                      .setStyle(TextStyle(fontWeight: FontWeight.w900))
                      .setColor(context, (color) => color.background),
                  Text("Masuk untuk memulai sesi.")
                      .bodySmall(context)
                      .setColor(context, (color) => color.background),
                ],
              ),
            ),
            Positioned(
              top: 169,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ThemeColor.get(context).background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(
                          50)), // Atur radius sesuai keinginan Anda
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputWidget(
                        controller: usernameController,
                        label: 'Username',
                        placeholder: 'Masukan Username',
                      ),
                      InputWidget(
                        controller: passwordController,
                        label: 'Password',
                        placeholder: 'Masukan Password',
                        obsecureText: true,
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        onPressed:
                            !isLoading(name: 'login') ? _submitForm : null,
                        child: Text(
                            !isLoading(name: 'login') ? "LOGIN" : "Proses..."),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.get(context)
                              .primaryContent, // Atur warna latar belakang tombol
                          textStyle:
                              TextStyle(fontSize: 18), // Atur gaya teks tombol
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // OutlinedButton(
                      //   onPressed: () {
                      //     routeTo(RegisterPage.path);
                      //   },
                      //   child: Text("DAFTAR"),
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: ThemeColor.get(context)
                      //         .primaryContent, // Atur warna latar belakang tombol
                      //     textStyle:
                      //         TextStyle(fontSize: 18), // Atur gaya teks tombol
                      //     minimumSize: const Size.fromHeight(50),
                      //     side: BorderSide(
                      //         color: ThemeColor.get(context).primaryContent,
                      //         width: 2),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(
                      //           10), // Adjust the radius as needed
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ])),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setLoading(true, name: 'login');
      // Form is valid, proceed with form submission
      _formKey.currentState!.save(); // Save the form fields' values
      final result = await controller.doLogin(User(
          username: usernameController.text,
          password: passwordController.text));
      setLoading(false, name: 'login');
      if (result.status) {
        User _user = (result.value as User);
        print("ID ${_user.id}");
        print("NAMA ${_user.namalengkap}");
        print("EMAIL ${_user.email}");
        print("USERNAME ${_user.username}");
        print("TOKEN ${_user.token}");
        await Auth.set(_user);
        routeTo(MainPage.path, navigationType: NavigationType.pushReplace);
        // showToastSuccess(description: result.message!);
      } else {
        showToastSorry(description: result.message!);
      }
    }
  }
}
