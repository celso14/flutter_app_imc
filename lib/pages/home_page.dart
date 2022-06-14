
import 'package:flutter/material.dart';


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String result = 'Informe seus dados';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //function for reset input fields
  void resetFields() {
    weightController.text = '';
    heightController.text = '';

    setState(() {
      result = 'Informe seus dados';
      formKey = GlobalKey<FormState>();
    });
  }

  //function for calculate and show the result
  void calculate() {
    try {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = (weight / (height * height));
      if (imc < 18.6) {
        result = 'Abaixo do peso (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        result = 'Peso ideal (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        result = 'Levemente Acima do Peso (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        result = 'Obesidade Grau I (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        result = 'Obesidade Grau II (IMC: ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        result = 'Obesidade Grau III (IMC: ${imc.toStringAsPrecision(4)})';
      }

      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {});
    } catch (e) {
      setState(() {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("ERROR!"),
            content: const Text("Por favor inserir valores válidos"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: const Color(0xfff00000)),
                child: const Text("Fechar"),
              )
            ],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffDCDCDC),
        appBar: AppBar(
          //APPBAR-Title text
          title: const Text(
            'Calculadora de IMC',
            style: TextStyle(
                color: Color(0xffDCDCDC), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff00CED1),
          //APPBAR-Information Button
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.info),
                tooltip: 'Informações',
                color: const Color(0xffDCDCDC),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("O que é IMC?"),
                      content: const Text(
                          "O IMC é um cálculo simples que permite avaliar se a pessoa está dentro do peso que é considerado ideal para a sua altura. Também conhecido como Índice de Massa Corporal, o IMC é uma fórmula utilizada por vários profissionais de saúde, incluindo médicos, enfermeiros e nutricionistas, para saber, de uma forma rápida, se a pessoa precisa ganhar ou perder peso."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                              primary: const Color(0xff00CED1)),
                          child: const Text("OK"),
                        )
                      ],
                    ),
                  );
                },
              );
            },
          ),
          //APPBAR-Clear Button
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Limpar os campos de texto',
              color: const Color(0xffDCDCDC),
              onPressed: resetFields,
            ),
          ],
        ),
        //Body Content
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Person Icon
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Icon(
                    Icons.person_outline,
                    size: 120,
                    color: Color(0xff00CED1),
                  ),
                ),
                //Input Weight
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Peso (kg)',
                    labelStyle: TextStyle(
                        color: Color(0xff00CED1), fontWeight: FontWeight.bold),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                  controller: weightController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Insira seu peso";
                    }
                  },
                ),
                //SizedBox divider
                const SizedBox(
                  height: 15,
                ),
                //Input Height
                TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Altura (cm)',
                      labelStyle: TextStyle(
                          color: Color(0xff00CED1),
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    controller: heightController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Insira sua altura";
                      }

                    }),
                //Calculate Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        calculate();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff00CED1),
                      padding: const EdgeInsets.all(20),
                    ),
                    child: const Text(
                      'Calcular',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                //Result Text
                Text(
                  result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xff00CED1),
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
