import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'pages/addnote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:diabites_buddy/pages/home.dart';
import 'package:diabites_buddy/pages/editnote.dart';
import 'package:diabites_buddy/pages/splashScreen.dart';
import 'common/google_sign_in.dart';
import 'package:diabites_buddy/common/theme_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  Color _primaryColor = Color.fromARGB(245, 40, 145, 0);
  Color _accentColor = Color.fromARGB(245, 119, 177, 224);
  Color _background = Color.fromARGB(245, 58, 130, 224);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login UI',
        theme: ThemeData(
          primaryColor: Color.fromARGB(245, 40, 145, 0),
          scaffoldBackgroundColor: Colors.grey.shade100,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Color.fromARGB(245, 119, 177, 224)),
        ),
        home: SplashScreen(
          title: 'dele',
        ),
      ),
    );
  }
}
// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   final Stream<QuerySnapshot> _usersStream =
//       FirebaseFirestore.instance.collection('notes').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (_) => addnote()));
//         },
//         child: Icon(
//           Icons.add,
//         ),
//       ),
//       appBar: AppBar(
//         title: Text('todo'),
//       ),
//       body: StreamBuilder(
//         stream: _usersStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("something is wrong");
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (_, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             editnote(docid: snapshot.data!.docs[index]),
//                       ),
//                     );
//                   },
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(
//                           left: 3,
//                           right: 3,
//                         ),
//                         child: ListTile(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             side: BorderSide(
//                               color: Colors.black,
//                             ),
//                           ),
//                           title: Text(
//                             snapshot.data!.docChanges[index].doc['title'],
//                             style: TextStyle(
//                               fontSize: 20,
//                             ),
//                           ),
//                           subtitle: Text(
//                             snapshot.data!.docChanges[index].doc['content'],
//                             style: TextStyle(
//                               fontSize: 15,
//                             ),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                             vertical: 12,
//                             horizontal: 16,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
