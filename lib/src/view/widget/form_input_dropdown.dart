import 'package:myrscm/constant.dart';
import 'package:flutter/material.dart';
import 'package:myrscm/src/model/list_data_model.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
class FormShowModal extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final List<DefaultRowModel> data;

  FormShowModal({this.label, this.controller, this.data});

  @override
  _FormShowModalState createState() => _FormShowModalState(label, controller,data);
}

class _FormShowModalState extends State<FormShowModal> {
  final String label;
  final TextEditingController controller;
  final List<DefaultRowModel> data;

  _FormShowModalState(this.label, this.controller, this.data);

  DefaultRowModel selectedValue;
  List<DropdownMenuItem<DefaultRowModel>> itemList = new List<DropdownMenuItem<DefaultRowModel>>();

  @override
  void initState() {
    data.forEach((row){
      itemList.add(DropdownMenuItem<DefaultRowModel>(
        child: Text(row.content),
        value: row,
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        title: Text(label,
            style: TextStyle(
                color: defaultAppbarColor,
                fontSize: 13,
                letterSpacing: 0.5
            )
        ),
        subtitle: Theme(
            data: Theme.of(context).copyWith(
              primaryColor: defaultAppbarColor,
              cursorColor: defaultAppbarColor,
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: Builder(
                builder: (context) => SearchableDropdown.single(
                  items: itemList,
                  value: selectedValue,
                  hint: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text("Pilih ${label.toLowerCase()}")
                  ),
                  searchHint: Text("Cari ${label.toLowerCase()}",style: TextStyle(color: defaultAppbarColor, fontSize: 18, fontWeight: FontWeight.w700)),
                  onChanged: (value) {
                    DefaultRowModel row = value;
                    setState(() {
                      controller.text = '${row.id}_${row.content}';
                      print('Selected: ${controller.text}');
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                )
            )
        )
    );
  }
}
