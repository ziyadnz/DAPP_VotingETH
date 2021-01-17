import 'package:Blockchain/MyHomePage.dart';
import 'package:Blockchain/pages/btc.dart';
import 'package:Blockchain/pages/votemodel.dart';
import 'package:Blockchain/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => votemodel(),
          child: MaterialApp(
        title: 'VOTING',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Login(),
      ),
    );
  }
}

class Login extends StatefulWidget {
  static var mail;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController MailController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();

  bool _isLoading = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Log In'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              //if image is not ok remove all container
              height: height,
              width: width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/vs.jpg'), //change picture proportion to 16:9
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFieldContainer(MailController, 80, "email",
                      Icon(Icons.person), TextInputType.emailAddress, false),
                  TextFieldContainer(PasswordController, 80, "password",
                      Icon(Icons.person), TextInputType.visiblePassword, true),
                  ButtonStyleLogin(context),
                ],
              ),
            ),
    );
  }

  ButtonStyleLogin(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isLoading = true;
        });
        AuthService authService = new AuthService();
        authService
            .signIn(MailController.text, PasswordController.text)
            .then((value) {
          setState(() {
            _isLoading = false;
          });
          print('myadress');
          print(value.adress);
          Login.mail = value.email;
          if (value.adress == 99) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MyHomePage()));
          } else {
            error(context);
          }
        }).catchError((e) {
          setState(() {
            print('what is going on');
            _isLoading = false;
          });
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              content: Text(e),
              backgroundColor: Colors.red,
            ),
          );
        });
      },
      child: new Container(
        //   height: AnimationTranstion.uzunlukFonksiyonu(40, context),
        //   width: AnimationTranstion.genislikFonksiyonu(152, context),
        decoration: BoxDecoration(
          color: Color(0xff329D9C),
          borderRadius: BorderRadius.circular(6.00),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: new Text(
            "Log in",
            textAlign: TextAlign.center,
            //      style: GoogleFonts.montserrat(
            //          fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
      ),
    );
  }

  TextFieldContainer(TextEditingController controller, int limit, String Baslik,
      Icon icon_exp, TextInputType type, bool obscure) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextField(
        obscureText: obscure,
        controller: controller,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: new InputDecoration(
          focusColor: Color(0xff329D9C),
          focusedBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Color(0xff329D9C))),
          enabledBorder: new OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(color: Color(0xff329D9C))),
          filled: true,
          prefixIcon: icon_exp,
          fillColor: Colors.white,
          labelText: Baslik,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        keyboardType: type,
      ),
    );
  }

  void error(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: "Something went wrong:(",
      desc: "Please try again",
      btnOkText: "OK",
      btnOkColor: Colors.red,
      btnOkOnPress: () {},
    )..show();
  }
}
