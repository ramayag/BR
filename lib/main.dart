import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List jobs = [];
  CollectionReference jobsref = FirebaseFirestore.instance.collection("jobs");

  getdata() async {
    QuerySnapshot respon = await jobsref.get();
    respon.docs.forEach((element) {
      setState(() {
        jobs.add(element.data());
      });
    });
    print(jobs);
  }

  setdata(){
    CollectionReference jobsre = FirebaseFirestore.instance.collection("jobs");
    jobsre.add({
      "ID" : "4444",
    });

  }

  @override
  void initState() {
    getdata();
    setdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("جميع الفرص"),
        ),
        body: ListView.builder(
          itemCount: jobs.length,
          /////// loop
          itemBuilder: (context, i) {
            return Text(" المرتب :"+" ${jobs[i]["salary"]} ");
          },
        ));
  }
}
