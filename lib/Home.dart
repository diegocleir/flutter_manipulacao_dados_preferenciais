import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _textoSalvo = "Nada salvo!";
  TextEditingController _controllerCampo = TextEditingController();

  _salvar() async {

    String valorDigitado = _controllerCampo.text;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nome", valorDigitado);

    print("opracao (salvar): $valorDigitado");

  }

  _recuperar() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _textoSalvo = prefs.getString("nome") ?? "Sem valor";
    });

  }

  _remover() async {

    final prefs = await SharedPreferences.getInstance();
    prefs.remove("nome");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manipulação de dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              _textoSalvo,
              style: TextStyle(
                fontSize: 20
              ),
            ),
            TextField(
              controller: _controllerCampo,
              decoration: InputDecoration(
                labelText: "Digite algo",
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: _salvar,
                    child: Text("Salvar"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
                  ),
                ),
                ElevatedButton(
                    onPressed: _recuperar,
                    child: Text("Recuperar")
                ),
                ElevatedButton(
                    onPressed: _remover,
                    child: Text("Remover")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
