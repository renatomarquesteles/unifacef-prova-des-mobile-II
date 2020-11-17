import 'package:flutter/material.dart';
import 'package:prova2bim/model/aviao.dart';
import 'package:prova2bim/db/database_helper.dart';
import 'package:prova2bim/ui/aviao_screen.dart';

class ListViewAviao extends StatefulWidget {
  @override
  _ListViewAviaoState createState() => new _ListViewAviaoState();
}

class _ListViewAviaoState extends State<ListViewAviao> {
  List<Aviao> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getAvioes().then((avioes) {
      setState(() {
        avioes.forEach((aviao) {
          items.add(Aviao.fromMap(aviao));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastrar Avião',
      home: Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/airplane.png',
                  fit: BoxFit.cover,
                  height: 40.0,
                ),
                Container(
                    margin: EdgeInsets.only(left: 20.0),
                    child: Text('Lista de aviões',
                        style: TextStyle(color: Colors.deepPurple[900]))),
              ]),
          backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: NetworkImage('https://wallpaperaccess.com/full/884784.jpg'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: [
                      Divider(height: 5.0),
                      ListTile(
                        //isThreeLine: true,
                        title: Text(
                          '${items[position].modelo} - ${items[position].ano}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),

                        subtitle: Row(
                          children: [
                            Text(' ${items[position].companhia} |',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                )),
                            Text(' ${items[position].passageiros} passageiros',
                                style: new TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                )),
                            IconButton(
                                icon: const Icon(Icons.remove_circle_outline,
                                    color: Colors.red),
                                onPressed: () => _deleteAviao(
                                    context, items[position], position)),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15.0,
                          child: Text(
                            '${items[position].id}',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () => _navigateToAviao(context, items[position]),
                      ),
                    ],
                  );
                }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewAviao(context),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }

  void _deleteAviao(BuildContext context, Aviao aviao, int position) async {
    db.deleteAviao(aviao.id).then((avioes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToAviao(BuildContext context, Aviao aviao) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AviaoScreen(aviao)),
    );
    if (result == 'update') {
      db.getAvioes().then((avioes) {
        setState(() {
          items.clear();
          avioes.forEach((aviao) {
            items.add(Aviao.fromMap(aviao));
          });
        });
      });
    }
  }

  void _createNewAviao(BuildContext context) async {
    // Aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AviaoScreen(Aviao('', '', '', ''))),
    );

    // Se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getAvioes().then((avioes) {
        setState(() {
          items.clear();
          avioes.forEach((aviao) {
            items.add(Aviao.fromMap(aviao));
          });
        });
      });
    }
  }
}
