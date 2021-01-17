import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class votemodel extends ChangeNotifier {
  int btcvote = 0;
  int ethvote = 0;
  final String _rpcUrl = "http://192.168.1.41:7545";
  final String _wsUrl = "ws://192.168.1.41:7545/";
  final String _privateKey =
      "ea7e030959481f96d8d549d9e2886d429aaf964b9ddc8c6613be01df0f5fa108";
  var httpClient = new Client();
  Web3Client _client;
  String _abiCode; //
  Credentials _credentials;
  EthereumAddress _contracAdress; //deplpyed adress
  EthereumAddress _ownAddress;
  DeployedContract _contract;
  ContractFunction _taskCount; //.sol uint
  ContractFunction _voters; //.sol deki mappingler için
  ContractFunction _candidates; //.sol deki mappingler için
  ContractFunction _addCandidate; //.sol function
  ContractFunction _vote; //.sol function
  ContractEvent _votedEvent; //.sol deki tek event

  //constructor
  votemodel() {
    initiateSetup();
  }
  Future<void> initiateSetup() async {
    _client = Web3Client(
      _rpcUrl,
      httpClient,
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getAbi();
    await getCredentials();
    await getDeoployedContract();
  }

  Future<void> getAbi() async {
    //srcabisteki abi alma
    String abiStringFile =
        await rootBundle.loadString("src/abis/Blockchain.json");

    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]); // to
    print(_abiCode);
    print("éabicode up");
    _contracAdress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]
        ["address"]); // to get contract deploy adress

    print(_contracAdress);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
    _ownAddress = await _credentials.extractAddress();
  }

  Future<void> getDeoployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Blockchain"), _contracAdress);
    _taskCount =
        _contract.function("candidatesCount"); //.sol deki variable burada
    print(_taskCount);
    _vote = _contract.function("vote"); //.soldeki fonksiyonlar
    //    _addCandidate = _contract.function("addCandidate"); //.soldeki fonksiyonlar
    _candidates = _contract.function("candidates"); //.sol deki mappingler
    print(_candidates);
    print("candidates");
    _voters = _contract.function("voters"); //.sol d eki mappingler
    print(_voters.toString());
    print("voters");
    _votedEvent = _contract.event("votedEvent"); //.sol EVENT

    //verify call
    print(await _client.call(
        contract: _contract,
        function: _taskCount,
        params: [])); //burada sayısını print ettik
  }

  getTodos() async {
    List<dynamic> totaltaskList = await _client
        .call(contract: _contract, function: _taskCount, params: []);

    BigInt totaltask = totaltaskList[0];
    print(totaltask);
    for (var i = 0; i < totaltask.toInt(); i++) {
      var temp = await _client.call(
          contract: _contract, function: _candidates, params: [BigInt.from(i)]);
      btcvote = Task(voteCount: temp[2]).voteCount;
      ethvote=Task(voteCount: temp[1]).voteCount;
      print("btcvote");
      print(btcvote);
      print("ethvote");
            print(ethvote);

      // todos.add(Task(id: temp[0], name: temp[1], voteCount: temp[2]));
    }
  }

//HATAAAAAAA
  addTask(String taskNameData) async {
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _contract.function("addCandidate"),
            parameters: [taskNameData]));
    getTodos();
  }
}

class Task {
  int id;
  String name;
  int voteCount;

  Task({this.id, this.name, this.voteCount}); //constructor
}
