import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '../../app/models/api_return_value.dart';
import '../../app/models/sektor.dart';
import '../../app/models/unit.dart';
import '../../app/models/user.dart';
import '../widgets/input_widget.dart';
import '/app/controllers/register_controller.dart';
import '../../bootstrap/helpers.dart';
import 'package:com.wentox.pelayanansyukurgpm/bootstrap/extensions.dart';

class RegisterPage extends NyStatefulWidget {
  final RegisterController controller = RegisterController();

  static const path = '/register';

  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends NyState<RegisterPage> {
  bool _isSektorDataFetched = false;
  bool _isUnitDataFetched = false;
  List<Sektor> cachedSektorData = [];
  List<Unit> cachedUnitData = [];
  Sektor? selectedOption;
  Unit? selectedUnit;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController namaLengkapController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController teleponController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

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
                  Text("Daftar")
                      .headingMedium(context)
                      .setStyle(TextStyle(fontWeight: FontWeight.w900))
                      .setColor(context, (color) => color.background),
                  Text("Daftar untuk mengakses jadwal dan informasi.")
                      .bodySmall(context)
                      .setColor(context, (color) => color.background),
                ],
              ),
            ),
            Positioned(
              top: 169,
              bottom: 0,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputWidget(
                          controller: namaLengkapController,
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
                          label: 'Nomor Telepon',
                          placeholder: 'Masukan Nomor Telepon',
                        ),
                        Text("Sektor"),
                        SizedBox(height: 10),
                        FutureBuilder<List<Sektor>?>(
                            future: _isSektorDataFetched
                                ? Future.value(cachedSektorData)
                                : widget.controller.getSektor(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.waiting &&
                                  cachedSektorData.isEmpty) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<Sektor>? options = snapshot.data ?? [];
                                if (!_isSektorDataFetched) {
                                  cachedSektorData = options;
                                  _isSektorDataFetched = true;
                                }
                                return DropdownButtonFormField<Sektor>(
                                  // value: selectedOption,
                                  value: selectedOption == null
                                      ? selectedOption
                                      : options
                                          .where((i) =>
                                              i.namaSektor ==
                                              selectedOption!.namaSektor)
                                          .first,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Sektor tidak boleh kosong';
                                    }
                                    return null;
                                  },
                                  onChanged: (Sektor? newValue) {
                                    // Update the selected option when the user makes a selection
                                    setState(() {
                                      selectedOption = newValue;
                                    });
                                  },
                                  items: options
                                      .map<DropdownMenuItem<Sektor>>((option) {
                                    return DropdownMenuItem<Sektor>(
                                      key: Key(option.namaSektor!),
                                      value: option,
                                      child: Text(option.namaSektor!),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                    // labelText: 'Select an option',
                                    hintText: "Pilih Sektor",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ThemeColor.get(context)
                                                .primaryContent,
                                            width: 10),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );
                              }
                            }),
                        SizedBox(height: 10),
                        (selectedOption != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Unit"),
                                  SizedBox(height: 10),
                                  FutureBuilder<List<Unit>?>(
                                      future: _isUnitDataFetched
                                          ? Future.value(cachedUnitData)
                                          : widget.controller
                                              .getUnit(selectedOption!.id!),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                                ConnectionState.waiting &&
                                            cachedUnitData.isEmpty) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          List<Unit>? options =
                                              snapshot.data ?? [];
                                          if (!_isUnitDataFetched) {
                                            cachedUnitData = options;
                                            _isSektorDataFetched = true;
                                          }
                                          return DropdownButtonFormField<Unit>(
                                            // value: selectedOption,
                                            value: selectedUnit == null
                                                ? selectedUnit
                                                : options
                                                    .where((i) =>
                                                        i.namaUnit ==
                                                        selectedUnit!.namaUnit)
                                                    .first,
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Unit tidak boleh kosong';
                                              }
                                              return null;
                                            },
                                            onChanged: (Unit? newValue) {
                                              // Update the selected option when the user makes a selection
                                              setState(() {
                                                selectedUnit = newValue;
                                              });
                                            },
                                            items: options
                                                .map<DropdownMenuItem<Unit>>(
                                                    (option) {
                                              return DropdownMenuItem<Unit>(
                                                key: Key(option.namaUnit!),
                                                value: option,
                                                child: Text(option.namaUnit!),
                                              );
                                            }).toList(),
                                            decoration: InputDecoration(
                                              // labelText: 'Select an option',
                                              hintText: "Pilih Unit",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ThemeColor.get(
                                                              context)
                                                          .primaryContent,
                                                      width: 10),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          );
                                        }
                                      }),
                                  SizedBox(height: 10),
                                ],
                              )
                            : SizedBox(),
                        InputWidget(
                          controller: usernameController,
                          label: 'Username',
                          placeholder: 'Masukan Username',
                        ),
                        InputWidget(
                            controller: passwordController,
                            label: 'Password',
                            placeholder: 'Masukan Password',
                            obsecureText: true),
                        SizedBox(height: 35),
                        ElevatedButton(
                          
                          onPressed: isLoading(name: 'register') ? null : _submitForm,
                          child: Text(isLoading(name: 'register') ? "Proses..." :"DAFTAR"),
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
                        SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("LOGIN"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: ThemeColor.get(context)
                                .primaryContent, // Atur warna latar belakang tombol
                            textStyle: TextStyle(
                                fontSize: 18), // Atur gaya teks tombol
                            minimumSize: const Size.fromHeight(50),
                            side: BorderSide(
                                color: ThemeColor.get(context).primaryContent,
                                width: 2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                        ),
                      ],
                    ),
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
      setLoading(true, name: 'register');
      // Form is valid, proceed with form submission
      _formKey.currentState!.save(); // Save the form fields' values
      ApiReturnValue? result = await widget.controller.register(User(
        namalengkap: namaLengkapController.text,
        email: emailController.text,
        telepon: teleponController.text,
        idUnit: selectedUnit!.id,
        username: usernameController.text,
        password: passwordController.text,
      ));
      setLoading(false, name: 'register');
      if(result != null)
      {
        if(result.status)
        {
          showToastSuccess(description: result.message!);
        }else{
          showToastSorry(description: result.message!);
        }
      }
      
    }
  }
}
