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
  AddRecord({@required this.imageSelectionOption,@required this.controller}) {
    controller.setImageSelection(this.imageSelectionOption);
    if(imageSelectionOption!=2 && controller.uploadImage==null){
      Router.navigator.pop();
    }
  }
  int _amnt;
  String _desc;
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: false,
        child: Observer(builder: (context) {
          return Stack(
            children: <Widget>[
              controller.uploadImage != null
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(controller.uploadImage),
                            fit: BoxFit.cover),
                      ),
                    )
                  : Scaffold(
                      backgroundColor: Colors.red,
                      body: Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          "No Attachment",
                          style: TextStyle(fontSize: 20, color: Colors.white70),
                        ),
                      ),
                    ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
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
                            timestamp: controller.dateset == null ? DateTime.now() : controller.dateset,
                            desc: _desc,
                            expenseTag: controller.selected,
                            imgPath: controller.uploadImage==null?null:await controller.getFilePath +
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
        }));
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
    return Stack(
      children: <Widget>[
        // Image.file(_image, fit: BoxFit.cover),
        Padding(
          child: Container(
            padding: EdgeInsets.all(20),
            //height: (MediaQuery.of(context).size.height / 3) * 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Add Expense',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'Enter the Amount and short Description(optional)',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKeyUpload,
                  child: Column(children: <Widget>[
                    TextFormField(
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
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Amount';
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
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
                      maxLength: 150,
//                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: 'Short Description',
                        //border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () async {
                          controller.filterDate(await _selectDate(context));
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
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
                              Divider(
                                color: Colors.grey,
                                height: 20,
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: Text('Add Tag'),
                      alignment: Alignment.centerLeft,
                    ),
                    RadioButtonGroup(
                        picked: controller.selected,
                        labels: <String>[
                          "Borrow",
                          "Lend",
                          "Splash Out",
                        ],
                        onSelected: (String selected) {
                          print(selected);
                          controller.setTags(selected);
                        }),
                  ]),
                ),
              ],
            ),
          ),
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        ),
      ],
    );
  }
}
