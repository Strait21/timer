import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _stopWatchTimer = StopWatchTimer(
  onChange: (value) {
    final displayTime = StopWatchTimer.getDisplayTime(value);
    //print('displayTime $displayTime');
  },
  onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
  onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
);

  void IconbuttonTest() {
    print("I pressed the button");
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
          
    });

  }
  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  void startTimer() {
    setState(() {
          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    });
  }

  void stopTimer() {
    setState(() {
          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    });
  }

  void resetTimer() {
    setState(() {
          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold( 
      body:Container( 
        child:StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: 0,
          builder: (context, snap) {
            final value = snap.data;
            final displayTime = StopWatchTimer.getDisplayTime(value!);
        return Column(
      
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                displayTime,
                style: const TextStyle(
                fontSize: 40,
                fontFamily: 'Helvetica',
                fontWeight: FontWeight.bold
                ),
              ),
            ),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.play_arrow),
                  onPressed: startTimer,
                  ),
                  IconButton(
                    onPressed: stopTimer, 
                    icon: Icon(Icons.pause)
                  ),
                  IconButton(
                    icon: Icon(Icons.restore_outlined), 
                    onPressed: resetTimer,),  
              ],
            ),
          ]
        );
      },
      )
    )
  );
  }
}
