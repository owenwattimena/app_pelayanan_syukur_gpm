import 'package:flutter/material.dart';

import '../../bootstrap/helpers.dart';

class InputWidget extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool obsecureText;
  final TextEditingController controller;
  const InputWidget(
      {Key? key,
      required this.label,
      required this.placeholder,
      this.obsecureText = false,
      required this.controller})
      : super(key: key);

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.label}"),
        SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value!.isEmpty) {
              return '${widget.label} tidak boleh kosong';
            }
            return null;
          },
          obscureText: widget.obsecureText,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              // Border luar
              borderRadius:
                  BorderRadius.circular(10), // Atur radius sudut border
            ),
            focusedBorder: OutlineInputBorder(
              // Border saat dalam keadaan focus
              borderSide: BorderSide(
                  color: Colors.blue, width: 2.0), // Warna dan lebar border
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              // Border saat dalam keadaan normal
              borderSide: BorderSide(
                  color: ThemeColor.get(context).primaryContent, width: 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: '${widget.placeholder}', // Placeholder teks
          ),
          // Tambahkan validator dan fungsi lainnya sesuai kebutuhan Anda
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
