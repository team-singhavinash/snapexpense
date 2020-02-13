import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:snapexpenses/controller/addrecord_store.dart';
import 'package:snapexpenses/model/addrecord_moor.dart';
import 'package:snapexpenses/router/router.gr.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

AddRecordController _addRecordController;

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _strikeComment;

  _HomeState() {
    print("homestate");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _addRecordController = AddRecordController();
    
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //this row widget is for background color 
         Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Expanded(
                flex: 7,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          //end here banckground color
        Observer(
          builder: (_) {
            print(_addRecordController.recordList);
            //print("updateting"+_addRecordController.state.toString());
            return ModalProgressHUD(
              inAsyncCall: false,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  title: Text(
                    null == null ? 'All records' : "",
                    style: TextStyle(fontSize: 14),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    FlatButton(
                      child: Icon(
                        FontAwesomeIcons.calendar,
                        size: 20,
                      ),
                      onPressed: () async {
                        print( _addRecordController.filterFakeId());
                        // _selectDate(context);
//                await FirebaseAuth.instance.signOut();
//                Navigator.pushReplacement(
//                    context, MaterialPageRoute(builder: (context) => Login()));
                      },
                    ),
                  ],
                ),
                body: Observer(
                  builder: (_) {
                    List<Addrecord> v =_addRecordController.recordStream1.value;
                    print(_addRecordController.id);
                    //
                    if (v != null)
                      return ListView.builder(
                        itemCount: v.length,
                        itemBuilder: (_, int index) {
                          return Container(                             //this is for padding top and bottom
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Stack(children: <Widget>[
                              Text('${_addRecordController.recordList.toString()}'),
                              Container(
                                padding: EdgeInsets.only(
                                  left: 60,
                                  right: 10,
                                ),
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        bottomLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                        bottomRight: Radius.circular(16.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5, 5),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                  child: ExpansionTile(
                                    title: Container(
                                      height: 65,
                                      padding: EdgeInsets.only(left: 37),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                timeago.format(v[index].timestamp),
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            //condtion to check strike
                                            v[index].strike == null ||
                                                    v[index].strike == false
                                                ? Text(
                                                    //condtion to check description
                                                    v[index].desc == null
                                                        ? 'Description not added'
                                                        : v[index].desc,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : Text(
                                                    v[index].desc == null
                                                        ? 'Description not added'
                                                        : v[index].desc,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  ),

                                            Text(
                                              v[index].expenseTag == null
                                                  ? ''
                                                  : v[index].expenseTag,
                                              style: TextStyle(
                                                  fontSize: 12, color: Colors.grey),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  FlutterMoneyFormatter(
                                                          amount: double.parse(
                                                              v[index]
                                                                  .amount
                                                                  .toString()),
                                                          settings:
                                                              MoneyFormatterSettings(
                                                                  symbol: 'Rs.'))
                                                      .output
                                                      .symbolOnLeft,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.red,
                                                      fontSize: 17)),
                                            ),
                                          ]),
                                    ),
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              GestureDetector(
                                                child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 12),
                                                    child: Material(
                                                      elevation: 3,
                                                      shape: CircleBorder(),
                                                      child: CircleAvatar(
                                                        radius: 16,
                                                        child: Icon(
                                                          FontAwesomeIcons.trash,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    )),
                                                onTap: () async {
                                                  print("Button pressesd");
                                                  Addrecord oldrecord;
                                                  oldrecord = Addrecord(
                                                      amount: v[index].amount,
                                                      id: v[index].id,
                                                      desc: v[index].desc,
                                                      timestamp: v[index].timestamp,
                                                      expenseTag:
                                                          v[index].expenseTag,
                                                      imgPath: v[index].imgPath,
                                                      strike: v[index].strike,
                                                      strikeComment:
                                                          v[index].strikeComment);
                                                  _addRecordController
                                                      .deleteRecord(oldrecord);
                                                },
                                              ),

                                              v[index].expenseTag == 'Borrow' ||
                                                      v[index].expenseTag == 'Lend'
                                                  ? v[index].strike == null ||
                                                          v[index].strike == false
                                                      ? GestureDetector(
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets.only(
                                                                      left: 10,
                                                                      right: 12,
                                                                      top: 10,
                                                                      bottom: 10),
                                                              child: Material(
                                                                elevation: 6,
                                                                shape:
                                                                    CircleBorder(),
                                                                child: CircleAvatar(
                                                                  backgroundColor:
                                                                      Colors.white,
                                                                  radius: 16,
                                                                  child: Icon(
                                                                    FontAwesomeIcons
                                                                        .strikethrough,
                                                                    size: 18,
                                                                    color:
                                                                        Colors.red,
                                                                  ),
                                                                ),
                                                              )),
                                                          onTap: () async {
                                                            showDialog(
                                                                context: context,
                                                                barrierDismissible:
                                                                    false,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'Enter Comments'),
                                                                    content: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        Expanded(
                                                                          child:
                                                                              TextField(
                                                                            autofocus:
                                                                                true,
                                                                            decoration:
                                                                                InputDecoration(hintText: 'eg.Return money by Phonepay'),
                                                                            onChanged:
                                                                                (v) {
                                                                              _strikeComment =
                                                                                  v;
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        child: Text(
                                                                            'Cancel'),
                                                                        onPressed: () => Router
                                                                            .navigator
                                                                            .pop(),
                                                                      ),
                                                                      FlatButton(
                                                                        child: Text(
                                                                          'Strike',
                                                                          style: TextStyle(
                                                                              color:
                                                                                  Colors.green),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Addrecord
                                                                              updaterecord;
                                                                          updaterecord = Addrecord(
                                                                              amount: v[index]
                                                                                  .amount,
                                                                              id: v[index]
                                                                                  .id,
                                                                              desc: v[index]
                                                                                  .desc,
                                                                              timestamp: v[index]
                                                                                  .timestamp,
                                                                              expenseTag: v[index]
                                                                                  .expenseTag,
                                                                              imgPath: v[index]
                                                                                  .imgPath,
                                                                              strike: true,
                                                                              strikeComment:
                                                                                  _strikeComment);
                                                                          print(
                                                                              updaterecord);
                                                                          _addRecordController
                                                                              .updateRecord(
                                                                                  updaterecord);
                                                                          Router
                                                                              .navigator
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                        )
                                                      : Text('')
                                                  : //else
                                                  Text('') //else
                                            ],
                                          ),

                                          //description part
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                             Column(
                                               children: <Widget>[
                                                  Container(
                                                    width: 210,
                                                child: Text(
                                                  v[index].desc == null
                                                      ? 'Description not added'
                                                      : v[index].desc,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                               ],
                                             ),
                                              v[index].strike != null ||
                                                      v[index].strike == true
                                                  ? Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          child: Icon(
                                                            FontAwesomeIcons
                                                                .quoteLeft,
                                                            size: 15,
                                                          ),
                                                          padding: EdgeInsets.only(
                                                              right: 8),
                                                        ),
                                                        Container(
                                                          width: 190,
                                                          padding: EdgeInsets.only(
                                                              top: 10, bottom: 10),
                                                          child: Text(
                                                            v[index].strikeComment ==
                                                                    null
                                                                ? ''
                                                                : v[index]
                                                                    .strikeComment,
                                                            style: TextStyle(
                                                                fontStyle: FontStyle
                                                                    .italic),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : Text(''),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 40, top: 8),
                                child: GestureDetector(
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black12,
                                          offset: Offset(5, 5),
                                          blurRadius: 4.0,
                                        ),
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(v[index].imgPath),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer('/data/user/0/com.snapexpenses.snapexpenses/app_flutter/snaps/${snapshot.data[0][index]['file_name']}')));
                                  },
                                ),
                              ),
                            ]),
                          );
                        },
                      );
                    else
                      return Text("loading");
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _onButtonPressed(), //setState(() {}),
                  tooltip: 'Increment Counter',
                  child: Icon(Icons.add),
                ),
              ),
            );
          }
        ),
      ],
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.white, //Color(0xff737373),
            height: 180,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white, //Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Open Camera'),
                    onTap: () {
                      Navigator.pop(context);
                      Router.navigator
                          .pushReplacementNamed(Router.addRecord, arguments: 1);
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.image),
                    title: Text('Open Gallery'),
                    onTap: () {
                      Navigator.pop(context);
                      Router.navigator
                          .pushReplacementNamed(Router.addRecord, arguments: 0);
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.times),
                    title: Text('Cancel'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
