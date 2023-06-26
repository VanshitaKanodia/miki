import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:miki/models/stored.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  List<Stored> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase();
  }

  void fetchDataFromFirebase() {
    // _database.child('chatgpt').once().then((DataSnapshot snapshot) {
    //   setState(() {
    //     dataList = List<Stored>.from(snapshot.value);
    //   });
    // })
    // .catchError((error) {
    //   print('Error fetching data: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    final DatabaseReference ref = FirebaseDatabase.instance.ref().child('chatgpt');
    var uid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your search history'),
      ),
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
            Map<dynamic, dynamic> data = snapshot.data!.snapshot.value as dynamic;
            if (data.containsKey(uid)) {
              data.remove(uid);
            }
            dataList = data.entries
                .map((entry) => Stored(
              question: entry.value['question'],
              answer: entry.value['answer'],
            ))
                .toList();
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(dataList[index].question),
                  subtitle: Text(dataList[index].answer),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
