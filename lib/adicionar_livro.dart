import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:projeto_livro/main.dart';

//import 'package:projeto_livro/adicionar.dart';
import 'package:projeto_livro/tempo_leitura.dart';
import 'package:projeto_livro/themes.dart';

class AdicionarLivro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdicionarLivroState();
  }
}

enum Formato { fisico, ebook }

class AdicionarLivroState extends State<AdicionarLivro> {
  // ignore: unused_field
  String _titulo = ' ';
  // ignore: unused_field
  String _autor = ' ';
  // ignore: unused_field
  late String _dataInicio;
  Formato? _formato;
  // ignore: unused_field
  int _nPaginas = 0;
  // ignore: unused_field
  int _nCapitulos = 0;
  bool _flag = false;
  // ignore: unused_field
  String format = 'fisico';
  // ignore: non_constant_identifier_names
  DateFormat format_data = DateFormat('dd/MM/yyyy');

  bool isChecked = false;
  final _controller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Widget _buildTitulo() {
    return TextFormField(
      cursorColor: pPrimaryColor,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: 'Oswald', fontSize: 28, color: pFontColor),
      decoration: new InputDecoration(
          hintText: 'Título',
          hintStyle: TextStyle(
            fontSize: 28,
            color: pSecondaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          border: UnderlineInputBorder()),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Título deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _titulo = value!;
      },
    );
  }

  Widget _buildAutor() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: 'Oswald', fontSize: 24, color: pFontColor),
      decoration: new InputDecoration(
          hintText: 'Autor',
          hintStyle: TextStyle(
            fontSize: 24,
            color: pSecondaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          border: UnderlineInputBorder()),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Autor deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _autor = value!;
      },
    );
  }

  Widget _buildFormato() {
    return ListTile(
      title: Text('Físico',
          style: TextStyle(color: pFontColor, fontFamily: 'Oswald')),
      leading: Radio<Formato>(
        value: Formato.fisico,
        groupValue: _formato,
        activeColor: pPrimaryColor,
        onChanged: (Formato? value) {
          setState(() {
            _formato = value;
            format = 'fisico';
          });
        },
      ),
    );
  }

  Widget _buildFormato2() {
    return ListTile(
        title: Text(
          'Ebook',
          style: TextStyle(fontFamily: 'Oswald', color: pFontColor),
        ),
        leading: Radio<Formato>(
          value: Formato.ebook,
          groupValue: _formato,
          activeColor: pPrimaryColor,
          onChanged: (Formato? value) {
            setState(() {
              _formato = value;
              format = 'ebook';
            });
          },
        ));
  }

  Widget _buildData() {
    return DateTimeFormField(
      dateFormat: format_data,
      lastDate: DateTime.now(),
      dateTextStyle: TextStyle(color: pFontColor, fontSize: 20),
      decoration: InputDecoration(
        hintText: 'Selecione a data',
        hintStyle: TextStyle(
          color: pSecondaryColor,
          fontFamily: 'Oswald',
        ),
        errorStyle: TextStyle(color: Colors.red),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: pSecondaryColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: pSecondaryColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: pSecondaryColor),
        ),
        suffixIcon: Icon(
          Icons.event_note,
          color: pPrimaryColor,
        ),
      ),
      mode: DateTimeFieldPickerMode.date,
      onDateSelected: (DateTime value) {
        // _dataInicio = value;
        _flag = true;
        // var datafor = format_data.format(value);
        _dataInicio = value.toString();
      },
      validator: (DateTime? value) {
        if (value == null) {
          return 'Data de início deve ser preenchido';
        }
      },
    );
  }

  Widget _buildPaginas() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        fontFamily: 'Oswald',
        color: pFontColor,
        fontSize: 22,
      ),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          border: UnderlineInputBorder()),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Número de Paginas deve ser preenchido';
        }
      },
      onSaved: (String? value) {
        _nPaginas = int.parse(value!);
      },
    );
  }

  Widget _buildCheckbox() {
    return Checkbox(
        checkColor: pScaffold,
        activeColor: pSecondaryColor,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
            _controller.clear();
          });
        });
  }

  Widget _buildCapitulos() {
    return TextField(
      enabled: isChecked,
      controller: _controller,
      textCapitalization: TextCapitalization.words,
      style: TextStyle(fontFamily: 'Oswald', fontSize: 22, color: pFontColor),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: pSecondaryColor),
          ),
          border: UnderlineInputBorder()),
      onChanged: (String? value) {
        _nCapitulos = int.parse(value!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getColor(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
            localizationsDelegates: [GlobalMaterialLocalizations.delegate],
            supportedLocales: [
              const Locale('pt'),
            ],
            theme: ThemeData(
              fontFamily: 'Oswald',
              accentColor: pPrimaryColor,
              colorScheme: ColorScheme.light().copyWith(
                primary: pPrimaryColor,
                // secondary: pSecondaryColor,
                onSurface: pFontColor,
              ),
              dialogBackgroundColor: pScaffold,
              unselectedWidgetColor: pSecondaryColor,
              textSelectionTheme: TextSelectionThemeData(
                  selectionHandleColor: pPrimaryColor,
                  cursorColor: pPrimaryColor,
                  selectionColor: pPrimaryColor),
            ),
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: pBackgroundColor,
              body: ListView(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0, left: 30),
                  child: Text('Adicionar Livro',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                          color: pPrimaryColor)),
                ),
                Padding(padding: EdgeInsets.only(top: 30)),
                Container(
                  height: MediaQuery.of(context).size.height + 80,
                  decoration: BoxDecoration(
                    color: pScaffold,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        _buildTitulo(),
                        _buildAutor(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: EdgeInsets.only(top: 25),
                                child: Text(
                                  'Formato:',
                                  style: TextStyle(
                                      fontSize: 24, color: pFontColor),
                                ))),
                        _buildFormato(),
                        _buildFormato2(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                padding: EdgeInsets.only(top: 25),
                                child: Text(
                                  'Data de Início:',
                                  style: TextStyle(
                                      fontSize: 24, color: pFontColor),
                                ))),
                        _buildData(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.only(top: 25),
                              child: Row(children: <Widget>[
                                Text(
                                  'Nº de Páginas:',
                                  style: TextStyle(
                                      fontSize: 24, color: pFontColor),
                                ),
                              ])),
                        ),
                        _buildPaginas(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              padding: EdgeInsets.only(top: 25),
                              child: Row(children: <Widget>[
                                _buildCheckbox(),
                                Text(
                                  'Nº de Capítulos:',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: isChecked ? pFontColor : Colors.grey,
                                  ),
                                ),
                              ])),
                        ),
                        _buildCapitulos(),
                      ],
                    ),
                  ),
                )
              ]),
              floatingActionButton: FloatingActionButton(
                backgroundColor: pPrimaryColor,
                onPressed: () => {
                  if (!_formkey.currentState!.validate()) {},
                  _formkey.currentState!.save(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TempoLeitura(
                              titulo: _titulo,
                              autor: _autor,
                              formato: format,
                              data: _dataInicio,
                              paginas: _nPaginas,
                              capitulos: _nCapitulos,
                              checked: isChecked,
                            )),
                  ),
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: pSecondaryColor,
                ),
              ),
            ),
          );
        });
  }
}
