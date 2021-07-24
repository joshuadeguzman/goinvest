import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_tracker/common/go_button/go_button.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _portfolioStream =
      FirebaseFirestore.instance.collection('portfolios').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 250,
              color: Color(0xFF0047FF),
            ),
            Container(
              margin: const EdgeInsets.only(top: 72),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hey Joshua 👋',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              margin: const EdgeInsets.only(
                top: 170,
                left: 24,
                right: 24,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 20,
                    color: Colors.black.withOpacity(0.05),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('You have'),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\$0',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Text(
                      '+ 0% today',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: Color(0xFF01DB99),
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 350),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _portfolioStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['ticker_id']),
                              subtitle: Text(data['purchase_price']),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 24),
                child: GoButton(
                  title: 'Add stock',
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
