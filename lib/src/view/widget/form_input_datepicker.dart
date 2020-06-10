import 'package:intl/intl.dart';
import 'package:myrscm/constant.dart';
import 'package:flutter/material.dart';
class FormDatePickerWidget extends StatefulWidget {

  final String label;
  final TextEditingController controller;
  FormDatePickerWidget({this.label, this.controller});

  @override
  _FormDatePickerWidgetState createState() => _FormDatePickerWidgetState();
}

class _FormDatePickerWidgetState extends State<FormDatePickerWidget> {
  var formatter = new DateFormat('yyyy-MM-dd');
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
        subtitle: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: defaultAppbarColor,
              accentColor: defaultAppbarColor,
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.accent
              ),
            ),
            child: Builder(
                builder: (context) => TextFormField(
                  maxLines: 1,
                  controller: widget.controller,
                  readOnly: true,
                  onTap: (){
                    showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now()).then((val){
                          if(val != null){
                            String formatted = formatter.format(val);
                            print(formatted);
                            widget.controller.text = formatted;
                          }
                    }).catchError((e)=> print(e));
                  },
                  validator: (value) {
                    if (value.isEmpty) return '${widget.label} tidak boleh kosong!';
                    if (value.contains(defaultRegex,0)) return 'Terdapat karakter yang tidak diizinkan!';
                    return null;
                  },
                )
            )
        )
    );
  }
}