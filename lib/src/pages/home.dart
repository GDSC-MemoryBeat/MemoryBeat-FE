import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';



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
    {"image": "assets/images/add_friend_icon.jpg", "text": "초록색이 보이면 검지손가락을 만들어 주세요!"},
    {"image": "assets/images/blue_mem.png", "text": "파란색이 보이면 엄지손가락과 새끼손가락을 펴주세요!"},
    {"image": "assets/images/red_green.png", "text": "빨간색이 보이면 주먹으로 만들어 주세요! 양손의 색깔은 랜덤으로 나옵니다!"},
    {"image": "assets/images/score_example.png", "text": "한번의 손가락 세트를 맞출때마다 점수를 1점씩 얻습니다!"}
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("튜토리얼"),
      content: Container(
        width: double.maxFinite,
        height: 300, // 다이얼로그 높이 조절
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
                  Text(messages[index]["text"]!),
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
          child: Text("확인"),
        ),
      ],
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewWidget(),
                  ),
                );
              },
              child: Text('시작'),
            ),
            SizedBox(height: 20), // 시작 버튼과 튜토리얼 버튼 사이의 간격 조절
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return TutorialDialog();
                  },
                );
              },
              child: Text('튜토리얼'),
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(url:WebUri('https://hjproject.kro.kr:8653/chat/room?roomId=24b5a01a-0c70-4eca-88c4-fcb85c063e88')),
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
        },
      ),
    );
  }
}

