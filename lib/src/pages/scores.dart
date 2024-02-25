import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ScorePage extends StatelessWidget {
  final List<double> scores;

  // scores 배열에서 최대 값 찾아서 최고 점수로 설정
  ScorePage({this.scores = const [130, 580, 850, 345, 593, 230, 483, 493, 750, 750, 800]});

  @override
  Widget build(BuildContext context) {
    // 최고 점수 계산
    double maxScore = scores.isNotEmpty ? scores.reduce((curr, next) => curr > next ? curr : next) : 0;

    // 최근 10개의 데이터 값 추출
    List<double> recentScores = scores.length > 10
        ? scores.sublist(scores.length - 10)
        : scores;

    // 데이터를 이용해 꺽은선 그래프를 생성
    LineChartData data = LineChartData(
  lineBarsData: [
    LineChartBarData(
      spots: recentScores.asMap().entries.map((entry) {
        return FlSpot(entry.key.toDouble(), entry.value);
      }).toList(),
      isCurved: true,
      barWidth: 4,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      //color:Color.fromARGB(a, r, g, b),
      color:Colors.blue
      //colors: [Colors.blue], // 색상을 여기서 설정합니다.
    ),
  ],
);

    // 최근 데이터 분석
    double lastScore = recentScores.last;
    double previousScore = recentScores.length > 1 ? recentScores[recentScores.length - 2] : 0;
    double changePercent = ((lastScore - previousScore) / previousScore) * 100;

    // 분석 결과에 따른 문구 설정
    String analysisText;
    if (changePercent > 0) {
      analysisText = "저번보다 오늘 $changePercent%가 상승했고, 잘했습니다!";
    } else if (changePercent < 0) {
      analysisText = "저번보다 오늘 ${changePercent.abs()}%가 하락했고, 분발해보세요!";
    } else {
      analysisText = "저번과 동일한 점수에요. 계속 힘내세요!";
    }

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Score Page'),
      //),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '최고점: $maxScore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              '점수 변화 분석:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              analysisText,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '점수 변화 추이:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: LineChart(data),
            ),
          ],
        ),
      ),
    );
  }
}
