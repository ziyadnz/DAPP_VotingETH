import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'votemodel.dart';

class Eth extends StatefulWidget {
  String e = "ETH";
  @override
  _EthState createState() => _EthState();
}

class _EthState extends State<Eth> {
  @override
  Widget build(BuildContext context) {
    var listeth = Provider.of<votemodel>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Hero(
          tag: 'eth',
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/eth.jpg'), //change picture proportion to 16:9
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'You will choose the ETH',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        background: Paint()..color = Colors.amber),
                  ),
                  Text(
                    'asdasd',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        background: Paint()..color = Colors.amber),
                  ),
                  RaisedButton(
                    onPressed: () {
                      listeth.addTask("ETH");
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
