import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_b2/test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Test())),
        ),
        title: Text("Login page"),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/sc.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: null,
        ),
        Align(
          alignment: Alignment(0.0, -0.5),
          child: (Image.asset("assets/images/Logo.png")),
        ),
        Align(child: FavoriteIcon())
      ]),
    );
  }
}

// Positioned(
//           top: MediaQuery.of(context).size.width / 4,
//           left: MediaQuery.of(context).size.width / 4,
//           child: (Image.asset("assets/images/Logo.png")))
class FavoriteIcon extends StatefulWidget {
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class Share {
  static final String change = 'false';
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool first = false;

  @override
  void didChangeDependencies() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      this.first = prefs.getBool(Share.change);
      if (this.first == null) {
        this.first = false;
      }
    });
    prefs.setBool(Share.change, !this.first);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: (first)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.face),
                        label: Text("Login with Facebook"),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      width: 250,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.phone_android),
                        label: Text("Login with Phone number"),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, onPrimary: Colors.orange),
                      ),
                    ),
                  )
                ],
              )
            : Column());
  }
}
