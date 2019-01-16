import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(
    title: "Calculadora de IMC",
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoResultado = "";
  TextEditingController pesoController = new TextEditingController();
  TextEditingController alturaController = new TextEditingController();

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void _resetarCampos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _textoResultado = "";
    });
  }

  void _calcular() {
    setState(() {

      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);
      String imcFormatado = imc.toStringAsPrecision(2);

      if (imc < 18.6) {
        _textoResultado = "Abaixo do Peso (IMC: $imcFormatado)";
      } else if (imc >= 18.6 && imc < 24.9) {
        _textoResultado = "Peso Ideal (IMC: $imcFormatado)";
      } else if (imc >= 24.9 && imc < 29.9) {
        _textoResultado = "Levemente Acima do Peso (IMC: $imcFormatado)";
      } else if (imc >= 29.9 && imc < 34.9) {
        _textoResultado = "Obesidade Grau I (IMC: $imcFormatado)";
      } else if (imc >= 34.9 && imc < 39.9) {
        _textoResultado = "Obesidade Grau II (IMC: $imcFormatado)";
      } else if (imc >= 40) {
        _textoResultado = "Obesidade Grau III (IMC: $imcFormatado)";
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calculadora de IMC"),
        centerTitle: false,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              _resetarCampos();
            }
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: new Form(
          key: _formKey,
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new Icon(Icons.person,
                  size: 120,
                  color: Colors.red,
                ),
                new TextFormField(
                  controller: pesoController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira seu Peso";
                    }
                  },
                  decoration: new InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: new TextStyle(
                          color: Colors.black
                      )
                  ),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.red,
                      fontSize: 20.0
                  ),
                ),
                new TextFormField(
                  controller: alturaController,
                  keyboardType: TextInputType.number,
                  validator: (valor) {
                    if (valor.isEmpty) {
                      return "Insira sua Altura";
                    }
                  },
                  decoration: new InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: new TextStyle(
                          color: Colors.black
                      )
                  ),
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      color: Colors.red,
                      fontSize: 20.0
                  ),
                ),
                new Padding(padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: new Container(
                    height: 50,
                    child: new RaisedButton(
                        child: new Text("Calcular",
                          style: new TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                        ),
                        color: Colors.red,
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calcular();
                          }
                        }
                    ),
                  ),
                ),
                new Text(_textoResultado,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.red,
                        fontSize: 20
                    )
                )
              ]
          ),
        )
      )
    );
  }
}
