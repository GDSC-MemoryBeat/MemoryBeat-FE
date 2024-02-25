import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/widgets.dart';

class ScorePage extends StatelessWidget {
  final List<double> scores;

  // scores 배열에서 최대 값 찾아서 최고 점수로 설정
  ScorePage({this.scores = const [2, 4, 4, 5, 6, 8, 6, 4, 6, 5, 4]});

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
      // 나머지 축 숨기기
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            
            //getTitlesWidget: leftTitleWidgets,
            reservedSize: 36,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color.fromARGB(255, 255, 255, 255)),
      ),
      minX: 0,
      maxX: 9,
      minY: 0,
      //maxY: 10,
      
      lineBarsData: [
        LineChartBarData(
          spots: recentScores.asMap().entries.map((entry) {
            return FlSpot(entry.key.toDouble(), entry.value);
          }).toList(),
          isCurved: true,
          barWidth: 4,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(show: false),
          color: const Color.fromARGB(255, 255, 255, 255),
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
      analysisText = 
"Today, it has increased by $changePercent% compared to last time, well done!";
    } else if (changePercent < 0) {
      analysisText = "Today, it has decreased by ${changePercent.abs()}% compared to last time, keep trying your best!";
    } else {
      analysisText = "It's the same score as last time. Keep up the good work!";
    }

    return Scaffold(
      //appBar: AppBar(
      //  title: Text('Score Page'),
      //),
      backgroundColor: Color.fromARGB(255, 81, 121, 94),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'The Highest Score: $maxScore',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Baloo'),
            ),
            SizedBox(height: 20),
            Text(
              'Score Change Analysis:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Baloo'),
            ),
            Text(
              analysisText,
              style: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Baloo'),
            ),
            SizedBox(height: 20),
            Text(
              'Score Change Graph:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Baloo'),
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
