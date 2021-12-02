import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:projeto_livro/atualizar.dart';
import 'package:projeto_livro/concluido.dart';
import 'package:projeto_livro/databaseHelper.dart';
import 'package:projeto_livro/livro.dart';
import 'package:projeto_livro/main.dart';

import 'package:projeto_livro/themes.dart';

class Leitura extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LeituraState();
  }
}

class LeituraState extends State<Leitura> {
  int? selectId;
  late bool format;
  int _currentIndex = 0;
  late bool zeroh;
  late bool zerom;
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  Widget _buildCard() {
    return FutureBuilder<List<Livro>>(
        future: DatabaseHelper.instance.getLivros(),
        builder: (BuildContext context, AsyncSnapshot<List<Livro>> snapshot) {
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
                  padding: EdgeInsets.all(30),
                  child: Card(
                    elevation: 0,
                    color: pScaffold,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: pSecondaryColor, width: 2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50, bottom: 60),
                      child: Center(
                        child: Text('Não há leituras em andamento',
                            style: TextStyle(color: pFontColor, fontSize: 20)),
                      ),
                    ),
                  ),
                )
              : CarouselSlider(
                  items: snapshot.data!.map((livros) {
                    if (livros.formato == 'fisico') {
                      format = true;
                    } else {
                      format = false;
                    }
                    if (livros.horasEstimadas == 0) {
                      zeroh = true;
                    } else
                      zeroh = false;
                    if (livros.minutosEstimados == 0) {
                      zerom = true;
                    } else
                      zerom = false;
                    return GestureDetector(
                        child: Card(
                            elevation: 0,
                            color: pScaffold,
                            shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: pSecondaryColor, width: 2),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Icon(
                                              format
                                                  ? MdiIcons
                                                      .bookOpenPageVariantOutline
                                                  : MdiIcons.bookOpen,
                                              color: pPrimaryColor,
                                              size: 50),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            title: Text(
                                              '${livros.titulo}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: pFontColor),
                                            ),
                                            subtitle: Text(
                                              livros.autor,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: pSecondaryColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Tempo Restante: ',
                                        style: TextStyle(
                                            fontSize: 18, color: pFontColor),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        zeroh
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  '  ${livros.minutosEstimados} minutos ',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: pFontColor),
                                                ),
                                              )
                                            : zerom
                                                ? Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                        ' ${livros.horasEstimadas} horas ',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: pFontColor)),
                                                  )
                                                : Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      ' ${livros.horasEstimadas}h ${livros.minutosEstimados}min ',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: pFontColor),
                                                    ),
                                                  ),
                                        Align(
                                          child: Text(
                                            '${livros.porcentagem}%',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontFamily: 'Oswald',
                                                color: pFontColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Atualizar(livro: livros)));
                        });
                  }).toList(),
                  options: CarouselOptions(
                    height: 200,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    pauseAutoPlayOnTouch: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getColor(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Oswald',
              accentColor: pPrimaryColor,
              /*   colorScheme: ColorScheme.light().copyWith(
            primary: Colors.teal.shade400,
            secondary: Colors.teal.shade400,
          )*/
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                backgroundColor: pBackgroundColor,
                body: ListView(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 30.0),
                    child: Text(
                      'Libba',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color: pPrimaryColor),
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
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 40, right: 40),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text('Minhas Leituras: ',
                                style: TextStyle(
                                    fontFamily: 'LobsterTwo',
                                    fontSize: 26,
                                    fontStyle: FontStyle.italic,
                                    color: pPrimaryColor)),
                          ),
                        ),
                        Container(
                          child: _buildCard(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: 25, left: 25, top: 25, bottom: 10),
                          /* child: Divider(
                            thickness: 1,
                            color: pSecondaryColor,
                          ),*/
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: [
                              Card(
                                elevation: 0,
                                color: pScaffold,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: pPrimaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                    title: Text('Leituras Concluídas ',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 18,
                                            color: pFontColor)),
                                    trailing: Icon(
                                      MdiIcons.bookshelf,
                                      color: pSecondaryColor,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Concluido()));
                                    }),
                              ),
                              Card(
                                elevation: 0,
                                color: pScaffold,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: pPrimaryColor, width: 2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ListTile(
                                    title: Text('Mudar Tema ',
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 18,
                                            color: pFontColor)),
                                    trailing: Icon(
                                      MdiIcons.palette,
                                      color: pSecondaryColor,
                                      size: 35,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Themes()));
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ])),
          );
        });
  }
}
