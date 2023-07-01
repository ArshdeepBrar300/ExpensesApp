import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<transaction> transactionlist;
  final Function _deleteTransaction;
  TransactionList(this.transactionlist, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactionlist.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "No transaction Yet!",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : Container(
            height: 800,
            child: ListView.builder(
              itemCount: transactionlist.length,
              itemBuilder: (context, indx) {
                return Card(
                    elevation: 7,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: FittedBox(
                                child: Text(
                                    transactionlist[indx].amount.toString())),
                          )),
                      title: Text(
                        transactionlist[indx].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactionlist[indx].day),
                      ),
                      trailing: MediaQuery.of(context).size.width > 500
                          ? TextButton.icon(
                              onPressed: () {
                                _deleteTransaction(transactionlist[indx].id);
                              },
                              icon: Icon(Icons.delete),
                              label: Text('Delete this transaction'))
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                _deleteTransaction(transactionlist[indx].id);
                              },
                            ),
                    )
                    // child: Row(
                    //   children: [
                    //     Container(
                    //         margin: EdgeInsets.all(20),
                    //         padding: EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //             border:
                    //                 Border.all(color: Colors.purple, width: 3)),
                    //         child: Text(
                    //           '\$' +
                    //               transactionlist[indx].amount.toStringAsFixed(2),
                    //           style: Theme.of(context).textTheme.headline6,
                    //         )),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           transactionlist[indx].title,
                    //           textAlign: TextAlign.left,
                    //           style: TextStyle(
                    //               fontSize: 15, fontWeight: FontWeight.bold),
                    //         ),
                    //         Text(
                    //           DateFormat.yMMMd()
                    //               .format(transactionlist[indx].day),
                    //           style: TextStyle(
                    //               color: Color.fromARGB(255, 48, 46, 46),
                    //               fontSize: 12),
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    );
              },
            ),
          );
  }
}
