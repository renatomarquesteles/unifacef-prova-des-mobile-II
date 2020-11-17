import 'package:flutter/material.dart';
import 'package:prova2bim/model/aviao.dart';
import 'package:prova2bim/db/database_helper.dart';

class AviaoScreen extends StatefulWidget {
  final Aviao aviao;
  AviaoScreen(this.aviao);
  @override
  State<StatefulWidget> createState() => new _AviaoScreenState();
}

class _AviaoScreenState extends State<AviaoScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _modeloController;
  TextEditingController _anoController;
  TextEditingController _companhiaController;
  TextEditingController _passageirosController;
  @override
  void initState() {
    super.initState();
    _modeloController = new TextEditingController(text: widget.aviao.modelo);
    _anoController = new TextEditingController(text: widget.aviao.ano);
    _companhiaController =
        new TextEditingController(text: widget.aviao.companhia);
    _passageirosController =
        new TextEditingController(text: widget.aviao.passageiros);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Avião'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: _modeloController,
              decoration: InputDecoration(
                  labelText: 'Modelo',
                  labelStyle: new TextStyle(color: Colors.blue[800])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _anoController,
              decoration: InputDecoration(
                  labelText: 'Ano',
                  labelStyle: new TextStyle(color: Colors.blue[800])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _companhiaController,
              decoration: InputDecoration(
                  labelText: 'Companhia Aérea',
                  labelStyle: new TextStyle(color: Colors.blue[800])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _passageirosController,
              decoration: InputDecoration(
                  labelText: 'Número de passageiros',
                  labelStyle: new TextStyle(color: Colors.blue[800])),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.aviao.id != null)
                  ? Text(
                      'Alterar',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Inserir',
                      style: TextStyle(color: Colors.white),
                    ),
              color: Colors.greenAccent[700],
              onPressed: () {
                if (widget.aviao.id != null) {
                  db
                      .updateAviao(Aviao.fromMap({
                    'id': widget.aviao.id,
                    'modelo': _modeloController.text,
                    'ano': _anoController.text,
                    'companhia': _companhiaController.text,
                    'passageiros': _passageirosController.text
                  }))
                      .then((_) {
                    Navigator.pop(context, 'update');
                  });
                } else {
                  db
                      .inserirAviao(Aviao(
                          _modeloController.text,
                          _anoController.text,
                          _companhiaController.text,
                          _passageirosController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
