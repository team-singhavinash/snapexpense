import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:path/path.dart';
import 'package:snapexpenses/controller/addrecord_store.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
import 'package:snapexpenses/router/router.gr.dart';

import '../router/router.gr.dart';

final _formKeyUpload = GlobalKey<FormState>();

final FocusNode _amountFocus = FocusNode();
final FocusNode _descFocus = FocusNode();

class AddRecord extends StatelessWidget {
  // intilizing controller
  final AddRecordController controller;
  final int imageSelectionOption;
  AddRecord({@required this.imageSelectionOption, @required this.controller}) {
    if (imageSelectionOption == null && controller.uploadImage != null) {
      //do nothing here cos we back from camera app
    } else {
      //non camera
      controller.setImageSelection(this.imageSelectionOption);
      //this logic is for not allow if user select camera or gallery and somehow not receving image
    }
    if (imageSelectionOption != 2 && controller.uploadImage == null) {
      Router.navigator.pop();
    }
  }
  int _amnt;
  String _desc;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return Stack(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Add Expense',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              backgroundColor: Colors.black26,
              elevation: 0,
            ),
            body: Center(
                child: ListView(
              children: <Widget>[
                enableUpload(context),
              ],
            )),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (_formKeyUpload.currentState.validate()) {
                  _formKeyUpload.currentState.save();
                  // setState(() {
                  //   _saving = true;
                  // });
                  controller.uploadFile().then((v) async {
                    controller.insertRecord(Addrecord(
                        amount: _amnt,
                        timestamp: controller.dateset == null
                            ? DateTime.now()
                            : controller.dateset,
                        desc: _desc,
                        expenseTag: controller.selected,
                        imgPath: controller.uploadImage == null
                            ? null
                            : await controller.getFilePath +
                                basename(controller.uploadImage.path)));
                    //Router.navigator.pop();
                    Router.navigator.pop(Router.home);
                  });

                  // setState(() {
                  //   _saving = false;
                  // });
                  //print("yahoo");
                }
              },
              backgroundColor: Colors.red,
              tooltip: 'Upload Now',
              child: Icon(Icons.save),
            ),
          ),
        ],
      );
    });
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    return showDatePicker(
        context: context,
        initialDate:
            controller.dateset == null ? DateTime.now() : controller.dateset,
        firstDate: DateTime(1993, 1),
        lastDate: DateTime(2101));
  }

  Widget enableUpload(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          controller.uploadImage != null
              ? Material(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  elevation: 3,
                  child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(controller.uploadImage),
                        ),
                      )),
                )
              : Text(""),
          // Center(
          //   child: Text(
          //     'Enter the Amount and short Description(optional)',
          //     style: TextStyle(color: Colors.grey, fontSize: 14),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: _formKeyUpload,
            child: Column(children: <Widget>[
              Card(
                elevation: 3,
                child: TextFormField(
                  onSaved: (v) {
                    _amnt = int.parse(v);
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _amountFocus,
                  onFieldSubmitted: (v) {
                    _amountFocus.unfocus();
                    FocusScope.of(context).requestFocus(_descFocus);
                  },
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(8.0),
                      errorStyle: TextStyle(height: 2),
                      prefix: Text("Rs. ")),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Amount*';
                    } else {
                      if (int.parse(value) <= 0) {
                        return "Amount must be greater than 0";
                      } else if (int.parse(value) > 99999999) {
                        return "Amount is not allowed";
                      } else
                        return null;
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                elevation: 3,
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.sentences,
                  onSaved: (v) {
                    if (v.isEmpty)
                      _desc = null;
                    else
                      _desc = v;
                  },
                  focusNode: _descFocus,
                  onFieldSubmitted: (v) {
                    _descFocus.unfocus();
                  },
                  maxLines: 8,
                  maxLength: 280,
//                      textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: 'Short Description',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                    helperStyle: TextStyle(height: 2.0),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                  onTap: () async {
                    controller.filterDate(await _selectDate(context));
                  },
                  child: Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          SizedBox(width: 8,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              DateFormat("EEE, MMM d, yyyy").format(
                                  controller.dateset == null
                                      ? DateTime.now()
                                      : controller.dateset),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              // Align(
              //   child: Text('Add Tag'),
              //   alignment: Alignment.centerLeft,
              // ),
              // RadioButtonGroup(
              //     picked: controller.selected,
              //     labels: <String>[
              //       "Borrow",
              //       "Lend",
              //       "Splash Out",
              //     ],
              //     onSelected: (String selected) {
              //       print(selected);
              //       controller.setTags(selected);
              //     }),
            ]),
          ),
        ],
      ),
    );
  }
}
