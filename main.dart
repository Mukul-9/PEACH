import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() =>  runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id: (context) => MyHomePage(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        Chat.id: (context) => Chat(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {

  static const String id ='HOMESCREEN' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  width: 100.0,
                  child: Image.asset("assets/images/logoM5.png"),
                ),
              ),
              Text(
                'PEACH',
                style: TextStyle(fontSize: 30.0,),
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          CustomButton(
            text: 'Log In',
            callback: () {
              Navigator.of(context).pushNamed(Login.id);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomButton(
            text: 'Register',
            callback: () {
              Navigator.of(context).pushNamed(Registration.id);
            },
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {

  final VoidCallback callback;
  final String text;

  const CustomButton({Key key, this.callback, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: const Color(0xF2fdcfb0),
        elevation: 4.0,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 45.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[900],),
          ),
        ),
      ),
    );
  }
}

class Registration extends StatefulWidget {

  static const String id ='REGISTRATION' ;
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerUser() async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(user: user,),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        backgroundColor: const Color(0xF2fdcfb0),
        centerTitle: true,
        title:Text(
          "PEACH",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset("assets/images/logoM5.png"),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                hintText: "       A Valid Email...",
                filled: true,
                fillColor: const Color(0x40fdcfb0) ,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
            child: TextField(
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                hintText: "       Pick A Password... ",
                filled: true,
                fillColor: const Color(0x40fdcfb0) ,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const  EdgeInsets.fromLTRB(85, 70, 85, 20),
            child: CustomButton(
              text: "Register",
              callback: () async {
                await registerUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Login extends StatefulWidget {

  static const String id ='LOGIN' ;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loginUser() async {
    AuthResult result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseUser user = result.user;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Chat(user: user,),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey[800],
        ),
        backgroundColor: const Color(0xF2fdcfb0),
        centerTitle: true,
        title:Text(
          "PEACH",
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: 'logo',
              child: Container(
                child: Image.asset("assets/images/logoM5.png"),
              ),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => email = value,
              decoration: InputDecoration(
                hintText: "       Your Email Please...",
                filled: true,
                fillColor: const Color(0x40fdcfb0) ,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 20.0),
            child: TextField(
              autocorrect: false,
              obscureText: true,
              onChanged: (value) => password = value,
              decoration: InputDecoration(
                hintText: "       Password... ",
                filled: true,
                fillColor: const Color(0x40fdcfb0) ,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  borderSide: const BorderSide(
                    color: Colors.orangeAccent ,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: const  EdgeInsets.fromLTRB(85, 70, 85, 20),
            child: CustomButton(
              text: "Login",
              callback: () async {
                await loginUser();
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Chat extends StatefulWidget {

  static const String id ='CHAT' ;
  final FirebaseUser user;

  const Chat({Key key, this.user}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> callback() async {
    if(messageController.text.length > 0){
      await _firestore.collection('messages').add({
        'text': messageController.text,
        'from': widget.user.email,
        'date': DateTime.now().toIso8601String().toString(),
      });
      messageController.clear();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xF2fdcfb0),
        leading: Hero(
          tag: 'logo',
          child: Container(
            child: Image.asset(
              "assets/images/logoM5.png",
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close,
              color: Colors.grey[700],
            ),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData)
                    return Center(
                     child:  CircularProgressIndicator(
                       valueColor: new AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                       backgroundColor: const Color(0xF2fdcfb0),
                     ),
                    );

                  List<DocumentSnapshot> docs = snapshot.data.documents;
                  List<Widget> messages = docs.map(
                    (doc)=> Message(
                      from: doc.data['from'],
                      text: doc.data['text'],
                      me: widget.user.email == doc.data['from'],
                    )).toList();

                  return ListView(
                    controller: scrollController,
                    children: <Widget>[
                      ...messages,
                    ],
                  );
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        onSubmitted: (value) => callback(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0x40fdcfb0) ,
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: const BorderSide(
                              color: Colors.orangeAccent ,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25.0)),
                            borderSide: const BorderSide(
                              color: Colors.orangeAccent ,
                            ),
                          ),
                        ),
                        controller: messageController,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: SendButton(
                      text: "Send",
                      callback: callback,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}


class SendButton extends StatelessWidget{
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.greenAccent,
      onPressed: callback,
      child: Text(text),
    );
  }
}


class Message extends StatelessWidget{
  final String from;
  final String text;
  final bool me;

  const Message({Key key, this.from, this.text, this.me}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: me ?
        CrossAxisAlignment.end :
        CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            from,
          ),
          Material(
            color: me ?
            Color(0xF2fdcfb0) :
            Colors.redAccent[100],
            borderRadius: BorderRadius.circular(10.0),
            elevation: 3.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0,),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}