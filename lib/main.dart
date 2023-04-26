import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int times = 1 * 60; // 1min
  late Timer timer;
  String timeView = '0:00:00';
  bool isRunning = false;

  void timeStart() {
    if (isRunning) {
      // 돌고 있는가? => 시간을 멈춤, 상태 변경
      timeStop();
      setState(() {
        isRunning = !isRunning;
      });
    } else {
      // 안돌고 있음 => 돌아감, 변경
      //1초마다 1씩 내려감.. 일정 간격 마다 수행
      setState(() {
        isRunning = !isRunning;
      });
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          timeView = Duration(seconds: times).toString().split('.').first;
          times--;
          if (times < 0) {
            timeStop();
          }
        });
      });
    }

    //1초마다 1씩 내려감.. 일정 간격 마다 수행
  }

  void timeStop() {
    timer.cancel();
  }

  void timeReset() {
    // 초기 시간으로 설정
    // 상태를 변경 false
    setState(() {
      timeStop();
      times = 60;
      isRunning = false;
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  void addTime(int sec) {
    times = times + sec;
    times = times < 0 ? 0 : times;
    setState(() {
      timeView = Duration(seconds: times).toString().split('.').first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton:
            const FloatingActionButton(onPressed: null, child: Icon(Icons.abc)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'my timer',
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                )),
            Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      timeButton(sec: 60, color: Colors.amber),
                      timeButton(
                          sec: 30,
                          color: const Color.fromARGB(255, 214, 213, 209)),
                      timeButton(
                          sec: -30,
                          color: const Color.fromARGB(255, 26, 128, 168)),
                      timeButton(
                          sec: -60,
                          color: const Color.fromARGB(255, 0, 181, 226)),
                    ],
                  ),
                )),
            Flexible(
              flex: 2,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    timeView,
                    style: const TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRunning)
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: const Icon(Icons.pause_circle_rounded))
                      else
                        IconButton(
                            iconSize: 50,
                            onPressed: timeStart,
                            icon: const Icon(Icons.play_circle_rounded)),
                      IconButton(
                          iconSize: 50,
                          onPressed: timeReset,
                          icon: const Icon(Icons.restore_rounded))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector timeButton({
    required int sec,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => addTime(sec),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
            child: Text(
          '$sec',
          style: const TextStyle(fontSize: 50),
        )),
      ),
    );
  }
}
