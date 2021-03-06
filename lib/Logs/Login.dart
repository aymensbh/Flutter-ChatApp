import 'dart:async';
import 'package:chat_pfe/Logs/Signup.dart';
import 'package:chat_pfe/main.dart';
import 'package:flutter/material.dart';

PageController pagecontroller;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    pagecontroller = new PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: PageView(
        controller: pagecontroller,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[LoginPage(), Signup()],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password;
  // TextEditingController _emailCrt;
  bool _obs = true;
  bool _busy = false;

  // @override
  // void initState() {
  //   _emailCrt=new TextEditingController();
  //   super.initState();
  // }

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          margin: MediaQuery.of(context).padding,
          // padding: EdgeInsets.only(bottom: ),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/bg2.jpeg",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin:
                    EdgeInsets.only(top: 45, left: 35, right: 35, bottom: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 6,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.only(top: 15, left: 22, bottom: 20),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                              fontSize: 50,
                              fontFamily: 'poiret',
                              color: Color.fromRGBO(150, 150, 150, 1)),
                        ),
                      ),
                      Container(
                        child: Form(
                          key: key,
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35)),
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: TextFormField(
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: Icon(Icons
                                          .account_circle), //----------------------------------------
                                      hintText: 'Email',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.black),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      )),
                                  onSaved: (input) {
                                    _email = input.trim();
                                  },
                                  validator: (input) {
                                    if (input.isEmpty)
                                      return 'provide an email';
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35)),
                                margin: EdgeInsets.only(
                                    left: 15, right: 15, top: 8),
                                child: TextFormField(
                                  onFieldSubmitted: (input) {
                                    validate();
                                  },
                                  cursorWidth: 1,
                                  cursorColor: Colors.black,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'product'),
                                  obscureText:
                                      _obs, //--------------------------------------------
                                  decoration: InputDecoration(
                                      alignLabelWithHint: true,
                                      contentPadding: EdgeInsets.all(
                                          10), //--------------------------------------------
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _obs = !_obs;
                                          });
                                        },
                                        child: Icon(Icons.remove_red_eye),
                                      ), //----------------------------------------
                                      // prefixIcon: Icon(Icons.vpn_key), //----------------------------------------
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'product'),
                                      errorStyle:
                                          TextStyle(color: Colors.black),
                                      fillColor:
                                          Color.fromRGBO(240, 240, 250, 1),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      )),

                                  onSaved: (input) {
                                    _password = input;
                                  },

                                  validator: (input) {
                                    if (input.length < 6)
                                      return 'provide 6 characters';
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: 40, bottom: 40, left: 8, right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Color.fromRGBO(76, 184, 196, 1),
                                Color.fromRGBO(60, 211, 173, 1)
                              ]),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: this._busy
                                ? null
                                : () async {
                                    setState(() => this._busy = true);
                                    await validate();
                                    setState(() => this._busy = false);
                                  },
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                                padding: EdgeInsets.only(
                                    left: 106, right: 106, top: 8, bottom: 8),
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'product',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        onPressed: this._busy
                            ? null
                            : () async {
                                setState(() => this._busy = true);
                                pagecontroller.animateToPage(1,
                                    curve: Curves.ease,
                                    duration: Duration(milliseconds: 500));
                                setState(() => this._busy = false);
                              },
                        child: Text(
                          "new user? SIGN UP",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'product',
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> validate() async {
    BuildContext dialogCtx;
    if (key.currentState.validate()) {
      key.currentState.save();
      showDialog(
          context: context,
          builder: (dcontext) {
            dialogCtx = dcontext;
            return SimpleDialog(
              title: Text("Loading.."),
              titlePadding: EdgeInsets.all(8),
              contentPadding: EdgeInsets.all(12),
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              ],
            );
          });
      await firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((onValue) {
        Navigator.of(dialogCtx).pop(true);
      }).catchError((onError) {
        Navigator.of(dialogCtx).pop(true);
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                title: Text(
                  "Ops! Something went wrong..",
                ),
                content: Text(
                  "Having Trubble signing with this email or password..!",
                  maxLines: 3,
                ),
                //  Text(onError.toString(),maxLines: 3,overflow: TextOverflow.ellipsis,),
                actions: <Widget>[
                  FlatButton(
                      child: Text("Retry"),
                      onPressed: () => Navigator.pop(context))
                ],
              );
            });
      });
    }
  }

  // Future<FirebaseUser> _googleSignIn() async {
  //   final curUser = this._user ?? await kFirebaseAuth.currentUser();
  //   if (curUser != null && !curUser.isAnonymous) {
  //     return curUser;
  //   }
  //   final googleUser = await kGoogleSignIn.signIn();
  //   final googleAuth = await googleUser.authentication;
  //   // Note: user.providerData[0].photoUrl == googleUser.photoUrl.
  //   final user = await kFirebaseAuth.signInWithGoogle(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   kFirebaseAnalytics.logLogin();
  //   setState(() => this._user = user);
  //   return user;
  // }
}
