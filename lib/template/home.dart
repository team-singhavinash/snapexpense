import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState() {
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
        Observer(builder: (_) {
          Future<DateTime> _selectDate(BuildContext context) async {
            return showDatePicker(
                context: context,
                initialDate: _addRecordController.dateset == null
                    ? DateTime.now()
                    : _addRecordController.dateset,
                firstDate: DateTime(1993, 1),
                lastDate: DateTime(2101));
          }

          //print("updateting"+_addRecordController.state.toString());
          return ModalProgressHUD(
            color: Colors.black,
            inAsyncCall: _addRecordController.filterLoader ??_addRecordController.state,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: Text(
                  _addRecordController.dateset == null
                      ? 'All records'
                      : DateFormat('dd-MM-yy')
                          .format(_addRecordController.dateset),
                  style: TextStyle(fontSize: 16),
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
                      _addRecordController
                          .filterDate(await _selectDate(context));
                    },
                  ),
                ],
              ),
              body: Observer(
                builder: (_) {
                  _addRecordController.filterAllRecord;
                  //null handling here
                  List<Addrecord> v =
                      _addRecordController.recordStream.value == null
                          ? []
                          : _addRecordController.recordStream.value;
                  print(_addRecordController.state);
                  print(_addRecordController.dateset);
                  print(v);

                  return PageView.builder(
                      reverse: true,
                      onPageChanged: (index) {
                        print((0 - index) + 1);
                        print("above");
                        _addRecordController.setFiterLoader(true);
                        print(DateTime.now()
                            .add(Duration(days: (0 - index) + 1)));
                        if ((0 - index) + 1 == 1) {
                          _addRecordController.filterDate(null);
                        } else
                          _addRecordController.filterDate(DateTime.now()
                              .add(Duration(days: (0 - index) + 1)));
                      },
                      itemBuilder: (context, postion) {
                        if (v.isNotEmpty)
                          return ListView.builder(
                            itemCount: v.length,
                            itemBuilder: (_, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: Stack(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Material(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        elevation: 3,
                                        child: ListTile(
                                          isThreeLine: true,
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35.0, top: 15),
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
                                                )),
                                          ),
                                          subtitle: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 35, top: 5, bottom: 15),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        minHeight: 65),
                                                    child: Text(
                                                      v[index].desc == null
                                                          ? 'Description not added'
                                                          : v[index].desc,
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Text(
                                                      timeago.format(
                                                          v[index].timestamp),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),

                                    //image for expense
                                    Padding(
                                      padding: EdgeInsets.only(top: 20),
                                      child: Material(
                                        shape: CircleBorder(),
                                        elevation: 4,
                                        child: Container(
                                          child: GestureDetector(
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: v[index].imgPath ==
                                                          null
                                                      ? AssetImage(
                                                          'assets/noattachment.png')
                                                      : FileImage(
                                                          File(
                                                            v[index].imgPath,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              if (v[index].imgPath != null)
                                                Router.navigator.pushNamed(
                                                    Router.imageViewer,
                                                    arguments:
                                                        v[index].imgPath);
                                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer('/data/user/0/com.snapexpenses.snapexpenses/app_flutter/snaps/${snapshot.data[0][index]['file_name']}')));
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    //end of image here

                                    //action button here
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 85, left: 30),
                                      child: Column(
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(
                                              FontAwesomeIcons.trashAlt,
                                              color: Colors.black26,
                                              size: 18,
                                            ),
                                            onPressed: () async {
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
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: Text(
                                                      "Do you want to Delete ?"),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          Router.navigator
                                                              .pop();
                                                        },
                                                        child: Text("No")),
                                                    FlatButton(
                                                        onPressed: () {
                                                          _addRecordController
                                                              .deleteRecord(
                                                                  oldrecord);
                                                          Router.navigator
                                                              .pop();
                                                        },
                                                        child: Text("Yes")),
                                                  ],
                                                ),
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    //end of action button
                                  ],
                                ),
                              );
                              // return Container(
                              //   //this is for padding top and bottom
                              //   padding: EdgeInsets.only(top: 5, bottom: 5),
                              //   child: Stack(children: <Widget>[
                              //     Container(
                              //       padding: EdgeInsets.only(
                              //         left: 60,
                              //         right: 10,
                              //       ),
                              //       child: Container(
                              //         padding: EdgeInsets.only(right: 5),
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.only(
                              //               topLeft: Radius.circular(16.0),
                              //               bottomLeft: Radius.circular(16.0),
                              //               topRight: Radius.circular(16.0),
                              //               bottomRight: Radius.circular(16.0)),
                              //           // boxShadow: [
                              //           //   BoxShadow(
                              //           //     color: Colors.black12,
                              //           //     offset: Offset(5, 5),
                              //           //     blurRadius: 4.0,
                              //           //   ),
                              //           // ],
                              //         ),
                              //         child: ExpansionTile(
                              //           title: Container(
                              //             height: 65,
                              //             padding: EdgeInsets.only(left: 37),
                              //             child: Column(
                              //                 crossAxisAlignment:
                              //                     CrossAxisAlignment.start,
                              //                 children: <Widget>[
                              //                   Align(
                              //                     alignment: Alignment.topRight,
                              //                     child: Text(
                              //                       timeago.format(
                              //                           v[index].timestamp),
                              //                       style: TextStyle(
                              //                           fontSize: 12,
                              //                           color: Colors.grey),
                              //                     ),
                              //                   ),
                              //                   //condtion to check strike
                              //                   v[index].strike == null ||
                              //                           v[index].strike == false
                              //                       ? Text(
                              //                           //condtion to check description
                              //                           v[index].desc == null
                              //                               ? 'Description not added'
                              //                               : v[index].desc,
                              //                           overflow: TextOverflow
                              //                               .ellipsis,
                              //                           style: TextStyle(
                              //                             color: Colors.black,
                              //                             fontSize: 14,
                              //                           ),
                              //                         )
                              //                       : Text(
                              //                           v[index].desc == null
                              //                               ? 'Description not added'
                              //                               : v[index].desc,
                              //                           overflow: TextOverflow
                              //                               .ellipsis,
                              //                           style: TextStyle(
                              //                             color: Colors.black,
                              //                             fontSize: 14,
                              //                             decoration:
                              //                                 TextDecoration
                              //                                     .lineThrough,
                              //                           ),
                              //                         ),

                              //                   Text(
                              //                     v[index].expenseTag == null
                              //                         ? ''
                              //                         : v[index].expenseTag,
                              //                     style: TextStyle(
                              //                         fontSize: 12,
                              //                         color: Colors.grey),
                              //                   ),
                              //                   Align(
                              //                     alignment:
                              //                         Alignment.centerRight,
                              //                     child: Text(
                              //                         FlutterMoneyFormatter(
                              //                                 amount: double
                              //                                     .parse(v[
                              //                                             index]
                              //                                         .amount
                              //                                         .toString()),
                              //                                 settings:
                              //                                     MoneyFormatterSettings(
                              //                                         symbol:
                              //                                             'Rs.'))
                              //                             .output
                              //                             .symbolOnLeft,
                              //                         style: TextStyle(
                              //                             fontWeight:
                              //                                 FontWeight.bold,
                              //                             color: Colors.red,
                              //                             fontSize: 17)),
                              //                   ),
                              //                 ]),
                              //           ),
                              //           children: <Widget>[
                              //             Row(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: <Widget>[
                              //                 Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: <Widget>[
                              //                     GestureDetector(
                              //                       child: Container(
                              //                           padding:
                              //                               EdgeInsets.only(
                              //                                   left: 10,
                              //                                   right: 12),
                              //                           child: Material(
                              //                             elevation: 3,
                              //                             shape: CircleBorder(),
                              //                             child: CircleAvatar(
                              //                               radius: 16,
                              //                               child: Icon(
                              //                                 FontAwesomeIcons
                              //                                     .trash,
                              //                                 size: 18,
                              //                               ),
                              //                             ),
                              //                           )),
                              //                       onTap: () async {
                              //                         print("Button pressesd");
                              //                         Addrecord oldrecord;
                              //                         oldrecord = Addrecord(
                              //                             amount:
                              //                                 v[index].amount,
                              //                             id: v[index].id,
                              //                             desc: v[index].desc,
                              //                             timestamp: v[index]
                              //                                 .timestamp,
                              //                             expenseTag: v[index]
                              //                                 .expenseTag,
                              //                             imgPath:
                              //                                 v[index].imgPath,
                              //                             strike:
                              //                                 v[index].strike,
                              //                             strikeComment: v[
                              //                                     index]
                              //                                 .strikeComment);
                              //                         showDialog(
                              //                           context: context,
                              //                           builder: (_) =>
                              //                               AlertDialog(
                              //                             title: Text(
                              //                                 "Do you want to Delete ?"),
                              //                             actions: <Widget>[
                              //                               FlatButton(
                              //                                   onPressed: () {
                              //                                     Router
                              //                                         .navigator
                              //                                         .pop();
                              //                                   },
                              //                                   child:
                              //                                       Text("No")),
                              //                               FlatButton(
                              //                                   onPressed: () {
                              //                                     _addRecordController
                              //                                         .deleteRecord(
                              //                                             oldrecord);
                              //                                     Router
                              //                                         .navigator
                              //                                         .pop();
                              //                                   },
                              //                                   child: Text(
                              //                                       "Yes")),
                              //                             ],
                              //                           ),
                              //                         );
                              //                       },
                              //                     ),

                              //                     v[index].expenseTag ==
                              //                                 'Borrow' ||
                              //                             v[index].expenseTag ==
                              //                                 'Lend'
                              //                         ? v[index].strike ==
                              //                                     null ||
                              //                                 v[index].strike ==
                              //                                     false
                              //                             ? GestureDetector(
                              //                                 child: Container(
                              //                                     padding: EdgeInsets.only(
                              //                                         left: 10,
                              //                                         right: 12,
                              //                                         top: 10,
                              //                                         bottom:
                              //                                             10),
                              //                                     child:
                              //                                         Material(
                              //                                       elevation:
                              //                                           6,
                              //                                       shape:
                              //                                           CircleBorder(),
                              //                                       child:
                              //                                           CircleAvatar(
                              //                                         backgroundColor:
                              //                                             Colors
                              //                                                 .white,
                              //                                         radius:
                              //                                             16,
                              //                                         child:
                              //                                             Icon(
                              //                                           FontAwesomeIcons
                              //                                               .strikethrough,
                              //                                           size:
                              //                                               18,
                              //                                           color: Colors
                              //                                               .red,
                              //                                         ),
                              //                                       ),
                              //                                     )),
                              //                                 onTap: () async {
                              //                                   showDialog(
                              //                                       context:
                              //                                           context,
                              //                                       barrierDismissible:
                              //                                           false,
                              //                                       builder:
                              //                                           (BuildContext
                              //                                               context) {
                              //                                         return AlertDialog(
                              //                                           title: Text(
                              //                                               'Enter Comments'),
                              //                                           content:
                              //                                               Row(
                              //                                             children: <
                              //                                                 Widget>[
                              //                                               Expanded(
                              //                                                 child: TextField(
                              //                                                   autofocus: true,
                              //                                                   decoration: InputDecoration(hintText: 'eg.Return money by Phonepay'),
                              //                                                   onChanged: (v) {
                              //                                                     _strikeComment = v;
                              //                                                   },
                              //                                                 ),
                              //                                               ),
                              //                                             ],
                              //                                           ),
                              //                                           actions: <
                              //                                               Widget>[
                              //                                             FlatButton(
                              //                                               child:
                              //                                                   Text('Cancel'),
                              //                                               onPressed: () =>
                              //                                                   Router.navigator.pop(),
                              //                                             ),
                              //                                             FlatButton(
                              //                                               child:
                              //                                                   Text(
                              //                                                 'Strike',
                              //                                                 style: TextStyle(color: Colors.green),
                              //                                               ),
                              //                                               onPressed:
                              //                                                   () {
                              //                                                 Addrecord updaterecord;
                              //                                                 updaterecord = Addrecord(amount: v[index].amount, id: v[index].id, desc: v[index].desc, timestamp: v[index].timestamp, expenseTag: v[index].expenseTag, imgPath: v[index].imgPath, strike: true, strikeComment: _strikeComment);
                              //                                                 print(updaterecord);
                              //                                                 _addRecordController.updateRecord(updaterecord);
                              //                                                 Router.navigator.pop();
                              //                                               },
                              //                                             ),
                              //                                           ],
                              //                                         );
                              //                                       });
                              //                                 },
                              //                               )
                              //                             : Text('')
                              //                         : //else
                              //                         Text('') //else
                              //                   ],
                              //                 ),

                              //                 //description part
                              //                 Column(
                              //                   crossAxisAlignment:
                              //                       CrossAxisAlignment.start,
                              //                   children: <Widget>[
                              //                     Column(
                              //                       children: <Widget>[
                              //                         Container(
                              //                           width: 210,
                              //                           child: Text(
                              //                             v[index].desc == null
                              //                                 ? 'Description not added'
                              //                                 : v[index].desc,
                              //                             style: TextStyle(
                              //                               color: Colors.black,
                              //                               fontSize: 14,
                              //                             ),
                              //                           ),
                              //                         ),
                              //                       ],
                              //                     ),
                              //                     v[index].strike != null ||
                              //                             v[index].strike ==
                              //                                 true
                              //                         ? Row(
                              //                             children: <Widget>[
                              //                               Padding(
                              //                                 child: Icon(
                              //                                   FontAwesomeIcons
                              //                                       .quoteLeft,
                              //                                   size: 15,
                              //                                 ),
                              //                                 padding: EdgeInsets
                              //                                     .only(
                              //                                         right: 8),
                              //                               ),
                              //                               Container(
                              //                                 width: 190,
                              //                                 padding: EdgeInsets
                              //                                     .only(
                              //                                         top: 10,
                              //                                         bottom:
                              //                                             10),
                              //                                 child: Text(
                              //                                   v[index].strikeComment ==
                              //                                           null
                              //                                       ? ''
                              //                                       : v[index]
                              //                                           .strikeComment,
                              //                                   style: TextStyle(
                              //                                       fontStyle:
                              //                                           FontStyle
                              //                                               .italic),
                              //                                 ),
                              //                               )
                              //                             ],
                              //                           )
                              //                         : Text(''),
                              //                   ],
                              //                 ),
                              //               ],
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       padding: EdgeInsets.only(left: 40, top: 8),
                              //       child: GestureDetector(
                              //         child: Container(
                              //           height: 60,
                              //           width: 60,
                              //           decoration: BoxDecoration(
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.black12,
                              //                 offset: Offset(5, 5),
                              //                 blurRadius: 4.0,
                              //               ),
                              //             ],
                              //             shape: BoxShape.circle,
                              //             image: DecorationImage(
                              //               fit: BoxFit.cover,
                              //               image: v[index].imgPath == null
                              //                   ? AssetImage(
                              //                       'assets/noattachment.png')
                              //                   : FileImage(
                              //                       File(
                              //                         v[index].imgPath,
                              //                       ),
                              //                     ),
                              //             ),
                              //           ),
                              //         ),
                              //         onTap: () {
                              //           if(v[index].imgPath!=null)
                              //           Router.navigator.pushNamed(
                              //             Router.imageViewer,
                              //             arguments: v[index].imgPath
                              //           );
                              //           //Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageViewer('/data/user/0/com.snapexpenses.snapexpenses/app_flutter/snaps/${snapshot.data[0][index]['file_name']}')));
                              //         },
                              //       ),
                              //     ),
                              //   ]),
                              // );
                            },
                          );
                        else
                          return Container(
                            child: Align(
                              child: Text(
                                "No transaction today!",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black87),
                              ),
                              alignment: Alignment.topCenter,
                            ),
                            padding: EdgeInsets.only(top: 25),
                          );
                      });
                },
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () => Router.navigator.pushNamed(Router.cameraScreen,
                    arguments: _addRecordController),
                //Router.navigator.pushNamed(Router.addRecord, arguments: AddRecordArguments(imageSelectionOption: 1,controller: _addRecordController)),
                tooltip: 'Add record from Camera',
                child: Icon(Icons.camera,color: Colors.red,size: 40,),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(right: 40, left: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 45),
                        child: MaterialButton(
                          minWidth: 40,
                          onPressed: () => Router.navigator.pushNamed(
                              Router.addRecord,
                              arguments: AddRecordArguments(
                                  imageSelectionOption: 2,
                                  controller: _addRecordController)),
                          child: Image(image: AssetImage('assets/icon_nophoto.png'),height: 30,)
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
