import 'package:Blockchain/classes/app_user.dart';
import 'package:Blockchain/main.dart';
import 'package:Blockchain/pages/btc.dart';
import 'package:Blockchain/services/auth_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var email = Login.mail;
    return Scaffold(
      appBar: AppBar(
        title: Text('$email'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'btc',
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Btc()),
                );
              },
              child: FittedBox(
                //maybe doesnt work
                fit: BoxFit.cover,
                child: Container(
                  //if image is not ok remove all container
                  height: height,
                  width: width / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/btc.jpg'), //change picture proportion to 16:9
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Hero(
            tag: 'eth',
            child: GestureDetector(
              onTap: () {},
              child: Container(
                //if image is not ok remove all container
                height: height,
                width: width / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/eth.jpg'), //change picture proportion to 16:9
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Submit',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
/*
Bu sayfada ise seçilenleri görceğiz 
Seçtiğimize tıkladıgımızda yeni sayfaya gidip submit butonu gelecek herotag ile yap
*/
