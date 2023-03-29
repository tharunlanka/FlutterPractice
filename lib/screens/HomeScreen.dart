import 'package:flutter/material.dart';
import 'package:flutter_practice/screens/utilities/ElevatedButtonWidget.dart';
import 'package:flutter_practice/screens/utilities/TextWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _questionNum = 0;

  var questionList = const [
    {
      "question": "select even number ?",
      "answers": {
        "ans 1": "ans 3",
        "ans 2": "ans 9",
        "ans 3": "ans 4",
      }
    },
    {
      "question": "select odd number ?",
      "answers": {
        "ans 1": "ans 3",
        "ans 2": "ans 2",
        "ans 3": "ans 6",
      }
    },
    {
      "question": "select number div by 2 ?",
      "answers": {
        "ans 1": "ans 15",
        "ans 2": "ans 13",
        "ans 3": "ans 4",
      }
    }
  ];

  void _onAnswered() {
    setState(() {
      _questionNum += 1;
    });
  }

  void _onBackPressed() {
    setState(() {
      _questionNum = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _questionNum < questionList.length
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                textData: questionList[_questionNum]["question"] as String,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 1"]),
                onPressed: _onAnswered,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 2"]),
                onPressed: _onAnswered,
              ),
              ElevatedButtonWidget(
                textData:
                    getData(questionList[_questionNum], ["answers", "ans 3"]),
                onPressed: _onAnswered,
              )
            ],
          )
        : Card(
            margin: const EdgeInsets.all(10),
            color: Colors.green[100],
            shadowColor: Colors.blueGrey,
            elevation: 10,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const TextWidget(textData: "NO Questions to Practice"),
              TextButton(
                  onPressed: _onBackPressed,
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      maximumSize:
                          MaterialStateProperty.all(const Size(200, 100)),
                      elevation: MaterialStateProperty.all(8),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10))),
                  child: const Text(
                    "Back T0 Home",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))
            ]),
          );
  }
}

dynamic getData(Map data, List<String> list) {
  dynamic dataTemp = data;
  if (list.isNotEmpty) {
    for (int x = 0; x < list.length; x++) {
      dataTemp = dataTemp[list[x]];
    }
  }
  return dataTemp;
}
