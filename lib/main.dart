import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: "OpenSans",
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(fontFamily: "Quicksand", fontSize: 20),
              button: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(fontFamily: "OpenSans", fontSize: 20),
                ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<transaction> transactions = [];
  bool _showChart = false;

  List<transaction> get recentTransations {
    return transactions.where((element) {
      return element.day.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void addNewTransaction(String txtitle, double txamount, DateTime currdate) {
    final newtx = transaction(
        title: txtitle,
        amount: txamount,
        day: currdate,
        id: DateTime.now().toString());
    setState(() {
      transactions.add(newtx);
    });
  }

  void startnewtransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final isLandsacape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(title: Text('Expenses App'), actions: [
      IconButton(
          onPressed: () {
            startnewtransaction(context);
          },
          icon: Icon(Icons.add))
    ]);
    final txList = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(transactions, _deleteTransaction));

    return Scaffold(
      appBar: appbar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (isLandsacape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Show Chart "),
                Switch(
                    value: _showChart,
                    onChanged: (switchval) {
                      setState(() {
                        _showChart = switchval;
                      });
                    }),
              ],
            ),
          if (!isLandsacape)
            Container(
                height: (MediaQuery.of(context).size.height -
                        appbar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.3,
                padding: EdgeInsets.all(10),
                child: Chart(recentTransations)),
          if (!isLandsacape) txList,
          if (isLandsacape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                            appbar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.7,
                    padding: EdgeInsets.all(10),
                    child: Chart(recentTransations))
                : txList,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: IconButton(
              onPressed: () {
                startnewtransaction(context);
              },
              icon: Icon(Icons.add))),
    );
  }
}
