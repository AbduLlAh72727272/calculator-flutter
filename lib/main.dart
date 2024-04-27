import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorView(),
    );
  }
}

class CalculatorView extends StatefulWidget {
  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";

  final List<String> buttons = [
    'C',
    '+/-',
    '%',
    'DEL',
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    'x',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '+',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black54,
        leading: Icon(Icons.settings, color: Colors.orange),
        title: Text(
          "Calculator",
          style: TextStyle(color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(color: Colors.black54),
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 18.0, right: 12.0),
            child: Text(
              equation,
              style: TextStyle(fontSize: 38, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 10.0, right: 12.0),
            child: Text(
              result,
              style: TextStyle(fontSize: 48, color: Colors.black), // Update the color to black
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.0,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.grey,
                    buttonTapped: () {
                      setState(() {
                        equation = "0";
                        result = "0";
                      });
                    },
                  );
                } else if (index == 1) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.grey,
                    buttonTapped: () {
                      setState(() {
                        if (equation[0] == '-') {
                          equation = equation.substring(1);
                        } else {
                          equation = "-$equation";
                        }
                      });
                    },
                  );
                } else if (index == 2) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.grey,
                    buttonTapped: () {setState(() {
                      equation += "%";
                    });
                    },
                  );
                } else if (index == 3) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.grey,
                    buttonTapped: () {
                      setState(() {
                        equation = equation.substring(0, equation.length - 1);
                        if (equation == "") {
                          equation = "0";
                        }
                      });
                    },
                  );
                } else if (index == 12) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.orange,
                    buttonTapped: () {
                      setState(() {
                        equation += "*";
                      });
                    },
                  );
                } else if (index == 14) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.orange,
                    buttonTapped: () {
                      setState(() {
                        equation += "-";
                      });
                    },
                  );
                } else if (index == 16) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.orange,
                    buttonTapped: () {
                      setState(() {
                        equation += "+";
                      });
                    },
                  );
                } else if (index == 19) {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: Colors.deepOrange,
                    buttonTapped: () {
                      Parser p = Parser();
                      Expression exp = p.parse(equation);
                      ContextModel cm = ContextModel();
                      double eval = exp.evaluate(EvaluationType.REAL, cm);
                      setState(() {
                        result = eval.toString();
                        equation = eval.toString();
                      });
                    },
                  );
                } else {
                  return MyButton(
                    buttonText: buttons[index],
                    buttonColor: index % 2 == 0 ? Colors.white24 : Colors.white,
                    buttonTapped: () {
                      setState(() {
                        equation += buttons[index];
                      });
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Color buttonColor;
  final String buttonText;
  final Function buttonTapped;

  MyButton({required this.buttonColor, required this.buttonText, required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          buttonTapped();
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.all(22.0),
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}