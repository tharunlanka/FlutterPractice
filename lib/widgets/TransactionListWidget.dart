import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ListTranscations.dart';

class TransactionListWidget extends StatefulWidget {
  final List<ListTranscations> transactions;
  final Function deleteTx;

  const TransactionListWidget(this.transactions, this.deleteTx, {super.key});

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  var isCardOpened = false;

  void _onItemTapped(bool clicked) {
    setState(() {
      isCardOpened = clicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const Text(
                  'No transactions added yet!',
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/no_data_img.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () => _onItemTapped(true),
                child: Card(
                  color: isCardOpened ? Colors.white : Colors.blue,
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${widget.transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd()
                          .format(widget.transactions[index].date!),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () =>
                          widget.deleteTx(widget.transactions[index].id),
                    ),
                  ),
                ),
              );
            },
            itemCount: widget.transactions.length,
          );
  }
}
