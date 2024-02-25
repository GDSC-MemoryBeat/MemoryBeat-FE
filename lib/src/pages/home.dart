import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class TutorialDialog extends StatelessWidget {
  final List<Map<String, String>> messages = [
    {"image": "assets/images/green_one.PNG", "text": "If you see green, \njust straighten your index finger!"},
    {"image": "assets/images/blue_mem.PNG", "text": "If you see blue, \nstraighten your thumb and pinky!"},
    {"image": "assets/images/red_green.PNG", "text": "If you see red, make a fist!\nBoth hands come out in random colors!"},
    {"image": "assets/images/score_example.PNG", "text": "You get 1 point \nfor every set of fingers you get!"},
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Tutorial",style: TextStyle(fontFamily: 'baloo'),),
      content: Container(
        width: double.maxFinite,
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(messages[index]["image"]!),
                  SizedBox(height: 10),
                  Text(messages[index]["text"]!,style: TextStyle(fontFamily: "baloo",fontWeight:FontWeight.bold),),
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("OK"),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 81, 121, 94), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Memory Beat 텍스트
            Container(
              width: double.infinity,
              //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              child: Text(
                'Memory Beat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 70,
                  fontFamily: 'baloo',
                ),
              ),
            ),
            // Logo 이미지
            //Container(
              //width: double.infinity,
              //padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              //child: SvgPicture.asset(
                //'assets/images/logo.svg',
                //height: MediaQuery.of(context).size.height * 0.3,
              //),
            //),
            SizedBox(height: 50),
            // Start 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewWidget(),
                  ),
                );
              },
              child: Text('Start',style: TextStyle(fontFamily: 'baloo',fontWeight: FontWeight.bold,fontSize: 45,),),
            ),
            SizedBox(height: 20),
            // Tutorial 버튼
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TutorialDialog();
                  },
                );
              },
              child: Text('Tutorial',style: TextStyle(fontFamily: 'baloo',fontWeight: FontWeight.bold,fontSize: 45,),),
            ),
          ],
        ),
      ),
    );
  }
}


class WebViewWidget extends StatefulWidget {
  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  void initState() {
    _launchURL();
    fetchData(); // API 데이터 가져오기
    super.initState();
  }
Future<void> fetchData() async {
    var url = Uri.https('https://192.168.1.117:8080', '/api/combo', {'q': '{http}'});
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
      var combo = jsonResponse['combo'];
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('combo: $combo');
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
    } else {
      print('2222222222222222222222222222222222222222222222222222');
      print('2222222222222222222222222222222222222222222222222222');
      print('Request failed with status: ${response.statusCode}.');
    }
  }
  void _launchURL() async {
    const url = 'https://192.168.1.117:8080/';
   if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    } Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  
  
  @override
  Widget build(BuildContext context) {
    // 빈 컨테이너 대신 홈 화면으로 이동
    return Container();
  }
}