import 'package:flutter/material.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

class DetailedPlannedTrips extends StatefulWidget {
  DetailedPlannedTrips(
      {required this.amount,
      required this.things,
      required this.imagePath,
      required this.members,
      required this.placeName,
      required this.date,
      required this.userName});

  final String? placeName;
  final String? things;
  final String? imagePath;
  final String? amount;
  final String? members;
  final String? date;
  final String? userName;

  @override
  State<DetailedPlannedTrips> createState() => _DetailedPlannedTripsState();
}

class _DetailedPlannedTripsState extends State<DetailedPlannedTrips> {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
    Future<void> refresh() async {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
      });
    }
  int? income = 0;
  int? expense = 0;

  TextEditingController _rate = TextEditingController();
  TextEditingController _transaction = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final amt = int.parse(widget.amount!);
    final memb = int.parse(widget.members!);
    double perAmt = amt / memb;
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(35, 35, 35, 1),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${widget.userName}.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Total Budget',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            '₹ ${widget.amount}.',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Members : ${widget.members}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Date :${widget.date}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Place : ${widget.placeName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 575,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red,)
                        ),
                        child: Center(
                          child: Text('Devisible amount for per person is : $perAmt',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30,),
                      RefreshIndicator(
                        key: _refreshIndicatorKey,
                        onRefresh: refresh,
                        child: FutureBuilder<List<Transactions>>(
                          future: getTransactions(widget.placeName!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(
                                    'Error: ${snapshot.error}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                        
                              final transactions = snapshot.data;
                              if (transactions != null) {
                                return transactions.isEmpty
                              ? Center(
                                  child: Text(
                                    'No transactions you have made.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    )
                                  ),
                                )
                              : Container(
                                  height: 350,
                                  width: double.infinity,
                                  child: ListView.separated(
                                    itemBuilder: (ctx, index) {
                                      final transaction = transactions[index];
                                      return Container(
                                        color: Colors.grey,
                                        child: ListTile(
                                          title: Text(transaction.credit!,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),),
                                          trailing: Text(transaction.amt.toString(),
                                          style: TextStyle(
                                          color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (ctx, index) {
                                      return Divider();
                                    },
                                    itemCount: transactions.length,
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    'No transactions you have made yet.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Container(
                                  height: 250,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _transaction,
                                          decoration: InputDecoration(
                                              labelText: 'Transaction',
                                              border: OutlineInputBorder()),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          controller: _rate,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: 'Amount',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (widget.amount != null &&
                                                widget.placeName != null) {
                                              final amount = int.parse(_rate.text);
                                              final place = widget.placeName!;
                                              await addTransactionToPlace(
                                              place,
                                              amount, 
                                              _transaction.text,
                                              widget.date!,
                                              widget.imagePath!,
                                              widget.members!,
                                              widget.things!
                                              );
                                              print('place is $place');
                                              Navigator.pop(context);
                                            } else {
                                              print(
                                                  'Amount or placeName is null');
                                            }
                                          },
                                          child: Text('Add'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
