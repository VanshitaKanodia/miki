import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miki/models/Response.dart';
import 'package:miki/screens/data_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _mainController = TextEditingController();
  final DatabaseReference _databaseReference = FirebaseDatabase.instance
      .reference();
  String textResponse = '';
  bool isLoading = false;

  Future<Response?> makeChatRequest() async {
    String input = _mainController.text;

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer API_KEY',
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": input}]
    });

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final result = Response.fromJson(jsonResponse);
        setState(() {
          textResponse = result.choices[0].message.content;
        });
        return result;
      } else {}
    } catch (e) {
      textResponse = 'Error occurred: $e';
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    return null;
  }

  @override
  void dispose() {
    _mainController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mikki'),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter Text',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: _mainController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Text here',
                        // border: InputBorder.none,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: makeChatRequest,
                child: const Text('Send Request'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  saveInDB(_mainController.text, textResponse);
                },
                child: const Text('Save the chat'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DataScreen()));
                },
                child: const Text('History'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Response:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child:  isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                margin: EdgeInsets.all(10),
                child: Text(textResponse,
                  style: TextStyle(
                      color: Colors.black
                  ),),
              ),
            )
          )
        ],
      ),
    );
  }

  void saveInDB(String question, String answer) {
    final DatabaseReference _database =
    FirebaseDatabase.instance.reference().child("chatgpt");

    _database.push().set({'question': question, 'answer': textResponse}).then((
        value) {
      print('Data Added successfully.');
    }).catchError((onError) {
      print("Error occurred $onError");
    });
  }
}
