import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operation = "";

  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _output = "0";
        _input = "";
        _num1 = 0;
        _num2 = 0;
        _operation = "";
      } else if (value == "=") {
        _num2 = double.tryParse(_input) ?? 0;

        switch (_operation) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "x":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            _output = _num2 != 0 ? (_num1 / _num2).toString() : "Erro";
            break;
          default:
            break;
        }

        _input = "";
        _operation = "";
      } else if (value == "+" || value == "-" || value == "x" || value == "/") {
        _num1 = double.tryParse(_input) ?? 0;
        _operation = value;
        _input = "";
      } else {
        _input += value;
        _output = _input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double buttonSize = MediaQuery.of(context).size.width / 4;

    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.black12,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, index) {
                List<String> buttons = [
                  "7", "8", "9", "/",
                  "4", "5", "6", "x",
                  "1", "2", "3", "-",
                  "C", "0", "=", "+"
                ];
                String value = buttons[index];

                return GestureDetector(
                  onTap: () => _buttonPressed(value),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: value == "C"
                          ? Colors.redAccent
                          : value == "="
                              ? Colors.green
                              : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
