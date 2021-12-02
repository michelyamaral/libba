import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:projeto_livro/databaseHelper2.dart';

import 'package:projeto_livro/livro_concluido.dart';
import 'package:projeto_livro/main.dart';
import 'package:projeto_livro/themes.dart';

class Concluido extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConcluidoState();
  }
}

class ConcluidoState extends State<Concluido> {
  int? selectId;
  bool diaoudias = true;
  bool formato = true;
  late bool format;
  // ignore: non_constant_identifier_names
  DateFormat format_data = DateFormat('dd/MM/yyyy');
  late int total = 0;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildTotal() {
    return FutureBuilder<List<LivroConcluido>>(
        future: DatabaseHelper2.instance.getConcluidos(),
        builder: (BuildContext context,
            AsyncSnapshot<List<LivroConcluido>> snapshot) {
          if (!snapshot.hasData) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Text('Carregando...',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: pFontColor, fontSize: 20)),
                ),
              ],
            );
          }
          total = snapshot.data!.length;

          return snapshot.data!.isEmpty
              ? SizedBox(height: 0)
              : Column(
                  children: [
                    Divider(
                      color: pPrimaryColor,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total de Livros:",
                                style:
                                    TextStyle(color: pFontColor, fontSize: 24),
                              ),
                              Text(
                                " $total",
                                style:
                                    TextStyle(color: pFontColor, fontSize: 24),
                              ),
                            ],
                          )),
                    )
                  ],
                );
        });
  }

  Widget _buildCard() {
    return FutureBuilder<List<LivroConcluido>>(
      future: DatabaseHelper2.instance.getConcluidos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<LivroConcluido>> snapshot) {
        if (!snapshot.hasData) {
          return Column(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Text('Carregando...',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: pFontColor, fontSize: 20)),
              ),
            ],
          );
        }

        return snapshot.data!.isEmpty
            ? Container(
                padding: EdgeInsets.only(top: 30, bottom: 300),
                child: Card(
                  elevation: 0,
                  color: pScaffold,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: pSecondaryColor, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text('Não há livros concluídos',
                        style: TextStyle(color: pFontColor, fontSize: 20)),
                  ),
                ),
              )
            : Scrollbar(
                radius: Radius.circular(30),
                thickness: 4,
                child: ListView(
                  children: snapshot.data!.map((livrosconcluidos) {
                    if (livrosconcluidos.dias == 1) {
                      diaoudias = true;
                    } else
                      diaoudias = false;
                    if (livrosconcluidos.formato == 'fisico') {
                      formato = true;
                    } else
                      formato = false;

                    return Column(
                      children: [
                        Card(
                          color: pScaffold,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: pSecondaryColor, width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.all(5),
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                /*  IconButton(
                                  icon: Icon(Icons.circle),
                                  color: pSecondaryColor,
                                  onPressed: () {
                                    DatabaseHelper2.instance
                                        .remove(livrosconcluidos.id!);
                                  },
                                ),*/
                                ListTile(
                                  title: Text(
                                    '${livrosconcluidos.titulo}',
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 22,
                                        color: pFontColor),
                                  ),
                                  subtitle: Text(
                                    livrosconcluidos.autor,
                                    //overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Oswald',
                                        fontSize: 18,
                                        color: pPrimaryColor),
                                  ),
                                  trailing: Icon(
                                      formato
                                          ? MdiIcons.bookOpenPageVariantOutline
                                          : MdiIcons.bookOpen,
                                      color: pPrimaryColor,
                                      size: 50),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '${format_data.format(DateTime.parse(livrosconcluidos.dataInicio))}',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 16,
                                            color: pFontColor),
                                      ),
                                      Text(
                                        ' — ',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 16,
                                            color: pFontColor),
                                      ),
                                      Text(
                                        livrosconcluidos.dataFinal,
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 16,
                                            color: pFontColor),
                                      ),
                                      diaoudias
                                          ? Text(
                                              '(${livrosconcluidos.dias.toString()} dia)',
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic,
                                                  color: pFontColor))
                                          : Text(
                                              '(${livrosconcluidos.dias.toString()} dias)',
                                              style: TextStyle(
                                                  fontFamily: 'Oswald',
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic,
                                                  color: pFontColor)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text('Tempo Total: ',
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 16,
                                                color: pFontColor)),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(livrosconcluidos.tempoFinal,
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 16,
                                                color: pFontColor)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  }).toList(),
                ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Oswald',
        highlightColor: pSecondaryColor,
        accentColor: pPrimaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: pBackgroundColor,
          body: ListView(children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 30.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: pSecondaryColor,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  Text(
                    'Concluídos',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontFamily: 'LobsterTwo',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        color: pPrimaryColor),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: pScaffold,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding:
                  EdgeInsets.only(top: 35, left: 30, right: 30, bottom: 160),
              child: Column(
                children: [
                  Expanded(child: _buildCard()),
                  _buildTotal(),
                ],
              ),
            )
          ])),
    );
  }
}
