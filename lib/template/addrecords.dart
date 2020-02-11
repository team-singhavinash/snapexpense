import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:path/path.dart';
import 'package:snapexpenses/controller/addrecord_store.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
import 'package:snapexpenses/router/router.gr.dart';

class AddRecord extends StatefulWidget {
  int imageSelectionOption;
  AddRecord(this.imageSelectionOption);
  @override
  _AddRecordState createState() => _AddRecordState(this.imageSelectionOption);
}

class _AddRecordState extends State<AddRecord> {
  // intilizing controller
  AddRecordController controller = AddRecordController();
  int imageSelectionOption;
  _AddRecordState(this.imageSelectionOption){
     getImage(this.imageSelectionOption);
  }
  final _formKeyUpload = GlobalKey<FormState>();
  int _amnt;
  String _desc;
  File _image;
  var camera;
  var _saving = false;
  String _selected = 'Splash Out';
  final FocusNode _amountFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  Future getImage(camera) async {
    var temp;
    if (camera == 1)
      temp = await ImagePicker.pickImage(source: ImageSource.camera);
    else {
      temp = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    if (temp == null) {
      Router.navigator.pop();
    }else{
      setState(() {
       _image=temp;   
      });
     
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        inAsyncCall: _saving,
        child: Stack(
          children: <Widget>[
            _image != null
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image), fit: BoxFit.cover)),
                  )
                : Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Colors.white),
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
                    setState(() {
                      _saving = true;
                    });
                    controller.uploadFile(_image).then((v) async {
                      controller.insertRecord(Addrecord(
                          amount: _amnt,
                          timestamp: DateTime.now(),
                          desc: _desc,
                          expenseTag: _selected,
                          imgPath: await controller.getFilePath +
                              basename(_image.path))
                              );
                             Router.navigator.pop();
                    });

                    setState(() {
                      _saving = false;
                    });
                    print("yahoo");
                  }
                }, //setState(() {}),
                tooltip: 'Upload Now',
                child: Icon(Icons.file_upload),
              ),
            ),
          ],
        ));
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
                    'Add Expenses',
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
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
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
                      validator: (value) {return null;},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      child: Text('Add Tag'),
                      alignment: Alignment.centerLeft,
                    ),
                    RadioButtonGroup(
                        picked: _selected,
                        labels: <String>[
                          "Borrow",
                          "Lend",
                          "Splash Out",
                        ],
                        onSelected: (String selected) {
                          print(selected);
                          setState(() {
                            _selected = selected;
                          });
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
