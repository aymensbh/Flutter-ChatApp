import 'package:chat_pfe/Util/EditBio.dart';
import 'package:flutter/material.dart';
import 'package:chat_pfe/Util/KColors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_pfe/main.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  final String firebaseUserId;

  const Profile({Key key, @required this.firebaseUserId}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      backgroundColor: KColors.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(110),
                        color: KColors.popout,
                        // gradient: LinearGradient(
                        //   colors: [KColors.lightPopout, KColors.popout],
                        //   begin: Alignment.topCenter,
                        //   end: Alignment.bottomCenter,
                        // ),
                        // boxShadow: <BoxShadow>[
                        //   BoxShadow(
                        //       blurRadius: 5,
                        //       color: Color.fromRGBO(20, 20, 20, 1),
                        //       offset: Offset(0, 2)),
                        // ],
                      ),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: firestore
                            .collection("User")
                            .document(widget.firebaseUserId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return CircleAvatar(
                              backgroundColor: KColors.secondary,
                              maxRadius: 100,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => new Scaffold(
                                            backgroundColor: KColors.primary,
                                            body: Hero(
                                              tag: "hero",
                                              child: Center(
                                                  child: CachedNetworkImage(
                                                imageUrl: snapshot.data["uimg"],
                                                placeholder: (context, url) {
                                                  return CircularProgressIndicator(
                                                    strokeWidth: 2,
                                                  );
                                                },
                                              )),
                                            ),
                                          ))),
                              child: Hero(
                                  tag: "hero",
                                  child: Container(
                                      padding: EdgeInsets.all(2),
                                      width: 180,
                                      height: 180,
                                      decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(200)
                                          // border: Border.all(co)
                                          ),
                                      alignment: Alignment.center,
                                      child: CircleAvatar(
                                        maxRadius: 180,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                snapshot.data["uimg"]),//firebase url
                                      ))),
                            );
                          }
                        },
                      )),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        OMIcons.addAPhoto,
                        color: KColors.popout,
                      ),
                      onPressed: () => _takePic(ImageSource.gallery),
                    ),
                  )),
              Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: StreamBuilder<DocumentSnapshot>(
                        stream: firestore
                            .collection("User")
                            .document(widget.firebaseUserId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Icon(Icons.more_horiz,
                                size: 40, color: KColors.third);
                          } else {
                            return Text(
                              snapshot.data["uname"] +
                                  " " +
                                  snapshot.data["ulastname"],
                              style:
                                  TextStyle(color: KColors.third, fontSize: 28,fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: firestore
                          .collection("User")
                          .document(widget.firebaseUserId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Icon(Icons.more_horiz,
                              size: 28, color: KColors.fourth);
                        } else {
                          return Text(
                            snapshot.data["uemail"],
                            style: TextStyle(color: KColors.fourth, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10,),
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("Edit bio",style: TextStyle(color: KColors.fourth,fontSize: 16)),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    // boxShadow: <BoxShadow>[
                    //   BoxShadow(
                    //       blurRadius: 5,
                    //       color: Color.fromRGBO(20, 20, 20, 1),
                    //       offset: Offset(0, 2)),
                    // ],
                    color: KColors.secondary,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 10, left: 70, right: 70),
                child: Container(
                  child: InkWell(
                    onLongPress: () => showDialog(
                        context: context,
                        builder: (BuildContext contxt) {
                          return new EditBio();
                        }),
                    child: StreamBuilder<DocumentSnapshot>(
                      stream: firestore
                          .collection("User")
                          .document(widget.firebaseUserId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Icon(Icons.more_horiz,
                              size: 28, color: KColors.fourth);
                        } else {
                          return Text(
                            snapshot.data["ubio"],
                            style: TextStyle(color: KColors.fourth, fontSize: 18),
                            textAlign: TextAlign.center,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("Options",style: TextStyle(color: KColors.fourth,fontSize: 16)),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(LineIcons.bell),
                  maxRadius: 30,
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                title: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 20, color: KColors.third),
                ),
                subtitle: Text("Active or away",
                    style: TextStyle(fontSize: 18, color: KColors.fourth)),
                trailing: Switch(
                  value: true,
                  activeColor: Colors.greenAccent,
                  activeTrackColor: KColors.secondary,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: KColors.secondary,
                  onChanged: (value) {
                    firestore.runTransaction((transactionHandler) async {
                      await firestore
                          .collection("User")
                          .document(firebaseUser.uid)
                          .updateData({"utag": value});
                    });
                  },
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.remove_circle_outline),
                  maxRadius: 30,
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                ),
                contentPadding: EdgeInsets.only(left: 10, right: 10),
                title: Text(
                  "DND",
                  style: TextStyle(fontSize: 20, color: KColors.third),
                ),
                subtitle: Text("Do not disturb",
                    style: TextStyle(fontSize: 18, color: KColors.fourth)),
                trailing: Switch(
                  value: false,
                  activeColor: Colors.greenAccent,
                  activeTrackColor: KColors.secondary,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: KColors.secondary,
                  onChanged: (value) {
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 10),
                padding: EdgeInsets.only(left: 10),
                alignment: Alignment.centerLeft,
                child: Text("Others",style: TextStyle(color: KColors.fourth,fontSize: 16)),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 10),
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(
                      //       blurRadius: 5,
                      //       color: Color.fromRGBO(20, 20, 20, 1),
                      //       offset: Offset(0, 2)),
                      // ],
                    ),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(8),
                    //     border: Border.all(color: KColors.lightPopout)),
                    child: Text(
                      "Sign out",
                      style: TextStyle(color: KColors.lightPopout, fontSize: 24),
                    ),
                  ),
                  onTap: _signOut,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signOut() async {
    // BuildContext dialogCtx;
    // showDialog(
    //       context: context,
    //       builder: (dcontext) {
    //         dialogCtx = dcontext;
    //         return AlertDialog(
    //           title: Text("Loading.."),
    //           content: Container(
    //             child: Center(
    //                         child: CircularProgressIndicator(
    //                       strokeWidth: 2,
    //                     )),
    //           ),
    //         );
    //       });
    firestore.runTransaction((transactionHandler) async {
      await firestore
          .collection("User")
          .document(widget.firebaseUserId)
          .updateData({"utag": false});
    });
    await firebaseAuth.signOut().then((onValue) {
      // Navigator.of(dialogCtx).pop(true);
    });
  }

  Future<void> _takePic(ImageSource source) async {
    File image = await ImagePicker.pickImage(
        source: source, maxWidth: 500, maxHeight: 500);
    _savePic(image, storage_users.child(widget.firebaseUserId)).then((onValue) {
      firestore
          .collection("User")
          .document(widget.firebaseUserId)
          .updateData({"uimg": onValue});
    });
  }

  Future<String> _savePic(File file, StorageReference storage) async {
    StorageUploadTask task = storage.putFile(file);
    StorageTaskSnapshot snapshot = await task.onComplete;
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
