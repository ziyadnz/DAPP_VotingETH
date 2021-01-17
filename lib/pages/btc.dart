import 'package:Blockchain/pages/votemodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Btc extends StatefulWidget {
  String a = "BTC";
  @override
  _BtcState createState() => _BtcState();
}

class _BtcState extends State<Btc> {
  @override
  Widget build(BuildContext context) {
    var listbtc = Provider.of<votemodel>(context);
    print("list btc");
    print(listbtc.httpClient);
    print(listbtc);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: 'btc',
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/btc.jpg'), //change picture proportion to 16:9
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'You will choose the BTC',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        background: Paint()..color = Colors.amber),
                  ),
                  Text(
                    '"listbtc.todos[0].voteCount"',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        background: Paint()..color = Colors.amber),
                  ),
                  RaisedButton(
                    onPressed: () {
                      listbtc.addTask("BTC");
                    },
                    focusColor: Colors.black,
                    focusElevation: 2,
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text('VOTE'),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
