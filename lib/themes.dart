import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:projeto_livro/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color pBackgroundColor = Color.fromRGBO(71, 40, 54, 1.0);
Color pScaffold = Colors.white;
Color pPrimaryColor = Colors.teal.shade400;
Color pSecondaryColor = Colors.pink.shade100;
Color pFontColor = Color.fromRGBO(71, 40, 54, 1.0);

SharedPreferences pref = SharedPreferences as SharedPreferences;

class Themes extends StatefulWidget {
  const Themes({Key? key}) : super(key: key);

  @override
  _ThemesState createState() => _ThemesState();
}

class _ThemesState extends State<Themes> {
  Future<void> saveColor() async {
    pref = await SharedPreferences.getInstance();
    pref.setInt('background', pBackgroundColor.value);
    pref.setInt('scaffold', pScaffold.value);
    pref.setInt('primary', pPrimaryColor.value);
    pref.setInt('secondary', pSecondaryColor.value);
    pref.setInt('font', pFontColor.value);
  }

  void getIcone() {
    pagIni = Icon(
      LineIcons.bookOpen,
      color: pPrimaryColor,
      size: 30,
    );
    adicioinar = Icon(
      LineIcons.plus,
      color: pPrimaryColor,
      size: 30,
    );
    sprint = Icon(
      Icons.timer,
      color: pPrimaryColor,
      size: 30,
    );
  }

  Widget _buildDefault() {
    return GestureDetector(
      onTap: () {
        setState(() {
          pBackgroundColor = Color.fromRGBO(71, 40, 54, 1.0);
          pScaffold = Colors.white;
          pPrimaryColor = Colors.teal.shade400;
          pSecondaryColor = Colors.pink.shade100;
          pFontColor = Color.fromRGBO(71, 40, 54, 1.0);
          saveColor();
          getIcone();
        });
      },
      child: Card(
        color: pScaffold,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: pSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Padrão',
                style: TextStyle(
                    fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromRGBO(71, 40, 54, 1.0),
                    size: 30,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.teal[400],
                    size: 30,
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.pink[100],
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarryOn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          pBackgroundColor = Color.fromRGBO(113, 50, 96, 1.0);
          pScaffold = Color.fromRGBO(38, 32, 46, 1.0);
          pPrimaryColor = Color.fromRGBO(158, 185, 177, 1.0);
          pSecondaryColor = Color.fromRGBO(189, 92, 120, 1.0);
          pFontColor = Colors.white;
          saveColor();
          getIcone();
        });
      },
      child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sempre em Frente',
                  style: TextStyle(
                      fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(113, 50, 96, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(158, 185, 177, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(189, 92, 120, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildQuinzeDias() {
    return GestureDetector(
      onTap: () {
        setState(() {
          pBackgroundColor = Color.fromRGBO(232, 111, 154, 1.0);
          pScaffold = Colors.white;
          pPrimaryColor = Color.fromRGBO(244, 232, 72, 1.0);
          pSecondaryColor = Color.fromRGBO(95, 196, 180, 1.0);
          pFontColor = Color.fromRGBO(4, 4, 4, 1.0);
          saveColor();
          getIcone();
        });
      },
      child: Card(
        color: pScaffold,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: pSecondaryColor, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quinze dias',
                style: TextStyle(
                    fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromRGBO(232, 111, 154, 1.0),
                    size: 30,
                  ),
                  Icon(
                    Icons.circle,
                    color: Color.fromRGBO(244, 232, 72, 1.0),
                    size: 30,
                  ),
                  Icon(
                    Icons.circle,
                    color: Color.fromRGBO(95, 196, 180, 1.0),
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVidentes() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(77, 67, 94, 1.0);
            pScaffold = Color.fromRGBO(28, 18, 27, 1.0);
            pPrimaryColor = Color.fromRGBO(236, 190, 95, 1.0);
            pSecondaryColor = Color.fromRGBO(155, 157, 171, 1.0);
            pFontColor = Colors.white;
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Os Videntes',
                  style: TextStyle(
                      fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(77, 67, 94, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(236, 190, 95, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(155, 157, 171, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildCrepusculo() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(18, 20, 34, 1.0);
            pScaffold = Colors.white;
            pPrimaryColor = Color.fromRGBO(164, 45, 50, 1.0);
            pSecondaryColor = Color.fromRGBO(60, 68, 72, 1.0);
            pFontColor = Color.fromRGBO(18, 20, 34, 1.0);
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Crepúsculo',
                  style: TextStyle(
                      fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(18, 20, 34, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(164, 45, 50, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(60, 68, 72, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildPercyJackson() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(15, 71, 60, 1.0);
            pScaffold = Color.fromRGBO(185, 203, 155, 1.0);
            pPrimaryColor = Color.fromRGBO(251, 239, 175, 1.0);
            pSecondaryColor = Color.fromRGBO(85, 145, 111, 1.0);
            pFontColor = Color.fromRGBO(4, 4, 4, 1.0);
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'O Ladrão de Raios',
                    style: TextStyle(
                        fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(15, 71, 60, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(251, 239, 175, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(85, 145, 111, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGuerradosTronos() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(14, 59, 77, 1.0);
            pScaffold = Color.fromRGBO(210, 226, 232, 1.0);
            pPrimaryColor = Color.fromRGBO(93, 192, 215, 1.0);
            pSecondaryColor = Color.fromRGBO(1, 123, 162, 1.0);
            pFontColor = Color.fromRGBO(14, 59, 77, 1.0);
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Guerra dos Tronos',
                    style: TextStyle(
                        fontFamily: 'Oswald', fontSize: 18, color: pFontColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(14, 59, 77, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(93, 192, 215, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(1, 123, 162, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildJaneEyre() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(177, 32, 39, 1.0);
            pScaffold = Color.fromRGBO(234, 221, 204, 1.0);
            pPrimaryColor = Color.fromRGBO(70, 187, 189, 1.0);
            pSecondaryColor = Color.fromRGBO(201, 104, 87, 1.0);
            pFontColor = Color.fromRGBO(4, 4, 4, 1.0);
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jane Eyre',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: pFontColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(177, 32, 39, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(70, 187, 189, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(201, 104, 87, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildMisery() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(47, 61, 75, 1.0);
            pScaffold = Color.fromRGBO(201, 197, 211, 1.0);
            pPrimaryColor = Color.fromRGBO(148, 170, 191, 1.0);
            pSecondaryColor = Color.fromRGBO(172, 32, 61, 1.0);
            pFontColor = Color.fromRGBO(4, 4, 4, 1.0);
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Misery',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: pFontColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(47, 61, 75, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(148, 170, 191, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(172, 32, 61, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildAssassinato() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(193, 26, 54, 1.0);
            pScaffold = Color.fromRGBO(18, 39, 74, 1.0);
            pPrimaryColor = Color.fromRGBO(247, 197, 65, 1.0);
            pSecondaryColor = Color.fromRGBO(31, 129, 163, 1.0);
            pFontColor = Colors.white;
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Assassinato no Expresso',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: pFontColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(193, 26, 54, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(247, 197, 65, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(31, 129, 163, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildMissPeregrine() {
    return GestureDetector(
        onTap: () {
          setState(() {
            pBackgroundColor = Color.fromRGBO(18, 18, 18, 1.0);
            pScaffold = Color.fromRGBO(55, 55, 55, 1.0);
            pPrimaryColor = Color.fromRGBO(150, 150, 150, 1.0);
            pSecondaryColor = Color.fromRGBO(213, 213, 213, 1.0);
            pFontColor = Colors.white;
            saveColor();
            getIcone();
          });
        },
        child: Card(
          color: pScaffold,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: pSecondaryColor, width: 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Orfanato da Srta. Peregrine',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontSize: 18,
                    color: pFontColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(18, 18, 18, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(150, 150, 150, 1.0),
                      size: 30,
                    ),
                    Icon(
                      Icons.circle,
                      color: Color.fromRGBO(213, 213, 213, 1.0),
                      size: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        highlightColor: pSecondaryColor,
        accentColor: pPrimaryColor,
      ),
      home: Scaffold(
        backgroundColor: pBackgroundColor,
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  'Temas',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontFamily: 'LobsterTwo',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
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
            padding: EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 150),
            child: Scrollbar(
              radius: Radius.circular(30),
              thickness: 4,
              // isAlwaysShown: true,
              child: ListView(
                children: [
                  _buildDefault(),
                  _buildPercyJackson(),
                  _buildGuerradosTronos(),
                  _buildCarryOn(),
                  _buildMissPeregrine(),
                  _buildCrepusculo(),
                  _buildQuinzeDias(),
                  _buildVidentes(),
                  _buildJaneEyre(),
                  _buildAssassinato(),
                  _buildMisery(),
                ],
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: pPrimaryColor,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          child: Icon(Icons.check, color: pSecondaryColor),
        ),
      ),
    );
  }
}
