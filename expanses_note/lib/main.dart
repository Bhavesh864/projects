import 'dart:io';

import 'package:flutter/material.dart';

import 'widgets/new_transactions.dart';
import 'widgets/transactions_list.dart';
import 'widgets/chart.dart';
import 'models/transaction.dart';

void main() {
  // Restrict user not be able to switch landscape mode-------------
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Remove Debug Banner
      debugShowCheckedModeBanner: false,

      title: 'Personal Expenses',
      home: MyHomePage(),

      //Text theme for all pages
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.teal,
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

        //Appbar theme for all pages
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  //Current txs on tx list
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 700,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Laptop',
    //   amount: 4000,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  //Last 7 days txs
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((userTx) {
      return userTx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //Change state with new txs
  _addNewTransactions(String txTitle, double txAmount, DateTime choosenTime) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choosenTime);

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  //Pop up bottom sheet to add tx
  void _startAddNewTransactions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransactions(_addNewTransactions);
        });
  }

  _deleteTransactions(String id) {
    setState(() {
      return _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Show Chart'),
        Switch.adaptive(
            value: _showChart,
            onChanged: (value) {
              setState(() {
                _showChart = value;
              });
            })
      ]),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Personal Expenses'),
      //Add new expanse icon
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _startAddNewTransactions(context);
          },
          icon: Icon(Icons.add),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = _buildAppBar();

    //TransactionList
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionsList(_userTransactions, _deleteTransactions),
    );

    return Scaffold(
      //AppBar
      appBar: appBar,

      //Body with charts and tx list
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandScape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
            if (!isLandScape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar,
                txListWidget,
              ),
          ],
        ),
      ),
      //Add new expanse button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _startAddNewTransactions(context);
              },
            ),
    );
  }
}
