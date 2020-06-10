import 'package:myrscm/constant.dart';
import 'package:flutter/material.dart';
class FormInputWidget extends StatefulWidget {

  final String label;
  final TextEditingController controller;
  final bool isPassword;

  FormInputWidget({this.label, this.controller, this.isPassword});

  @override
  _FormInputWidgetState createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        title: Text(widget.label,
            style: TextStyle(
                color: defaultAppbarColor,
                fontSize: 13,
                letterSpacing: 0.5
            )
        ),
        subtitle: TextFormField(
          maxLines: 1,
          obscureText: widget.isPassword,
          controller: widget.controller,
          validator: (value) {
            if (value.isEmpty) return '${widget.label} tidak boleh kosong!';
            if (value.contains(defaultRegex,0)) return 'Terdapat karakter yang tidak diizinkan!';
            return null;
          },
        )
    );
  }
}

