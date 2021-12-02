import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:projeto_livro/tempo_leitura.dart';
import 'package:projeto_livro/themes.dart';

class AdicionarTeste extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdicionarTesteState();
  }
}

enum Formato { fisico, ebook }

class AdicionarTesteState extends State<AdicionarTeste> {
  @override
  void initState() {
    super.initState();
  }

  // ignore: unused_field
  String _titulo = ' ';
  // ignore: unused_field
  String _autor = ' ';
  String format = 'fisico';
  // ignore: unused_field
  int _nCapitulos = 0;
  // ignore: unused_field
  int _nPaginas = 0;
  Formato? _formato;
//  bool _flag = false;
  bool isChecked = false;
  final _controller = TextEditingController();
  // ignore: unused_field
  late String _dataInicio;
  // ignore: non_constant_identifier_names
  DateFormat format_data = DateFormat('dd/MM/yyyy');
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final theme2 = ThemeData(
      unselectedWidgetColor:
          Color.fromRGBO(189, 92, 120, 1.0), // radio nao selecionado
      backgroundColor: Color.fromRGBO(38, 32, 46, 1.0),
      scaffoldBackgroundColor: Color.fromRGBO(113, 50, 96, 1.0),
      fontFamily: 'Oswald',
      primaryColor: Color.fromRGBO(158, 185, 177, 1.0),
      hintColor: Color.fromRGBO(189, 92, 120, 1.0),
      accentColor: Color.fromRGBO(189, 92, 120, 1.0),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(158, 185, 177, 1.0)),
      colorScheme: ColorScheme.light().copyWith(
        primary: Color.fromRGBO(158, 185, 177, 1.0),
        secondary: Color.fromRGBO(189, 92, 120, 1.0),
        onSurface: Colors.white, // texto calendario
      ),
      iconTheme: IconThemeData(color: Color.fromRGBO(189, 92, 120, 1.0)),
      dialogBackgroundColor:
          Color.fromRGBO(38, 32, 46, 1.0), // background calendario
      textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: 24, color: Colors.white),
        headline1: TextStyle(
            fontFamily: 'LobsterTwo',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 38,
            color: Color.fromRGBO(158, 185, 177, 1.0)),
      ));
  final theme = ThemeData(
      unselectedWidgetColor: Colors.pink.shade100, // radio nao selecionado
      backgroundColor: pPrimaryColor,
      scaffoldBackgroundColor: Color.fromRGBO(71, 40, 54, 1.0),
      fontFamily: 'Oswald',
      primaryColor: Colors.teal.shade400,
      hintColor: Colors.pink.shade100,
      accentColor: Colors.pink.shade100,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: Colors.teal.shade400),
      colorScheme: ColorScheme.light().copyWith(
        primary: Colors.teal.shade400,
        secondary: Colors.pink.shade100,
        onSurface: Color.fromRGBO(71, 40, 54, 1.0),
      ), // tetxo calenario
      dialogBackgroundColor: Colors.white, //
      iconTheme: IconThemeData(color: Colors.pink.shade100),
      textTheme: TextTheme(
          bodyText1:
              TextStyle(fontSize: 24, color: Color.fromRGBO(71, 40, 54, 1.0)),
          headline1: TextStyle(
              fontFamily: 'LobsterTwo',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 38,
              color: Colors.teal.shade400),
          bodyText2: TextStyle(color: Colors.orange, fontSize: 23)));

  Widget _buildTitulo() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
          fontSize: 28, color: Theme.of(context).textTheme.bodyText1?.color),
      decoration: new InputDecoration(
          hintText: 'Título',
          hintStyle: TextStyle(
            fontSize: 28,
            color: Theme.of(context).hintColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          )),
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
      style: TextStyle(
          fontSize: 24, color: Theme.of(context).textTheme.bodyText1?.color),
      decoration: new InputDecoration(
          hintText: 'Autor',
          hintStyle: TextStyle(
            fontSize: 24,
            color: Theme.of(context).hintColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).accentColor),
          )),
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
    return Column(
      children: [
        ListTile(
          title: Text(
            'Físico',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 18),
          ),
          leading: Radio<Formato>(
            value: Formato.fisico,
            groupValue: _formato,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (Formato? value) {
              setState(() {
                _formato = value;
                format = 'fisico';
              });
            },
          ),
        ),
        ListTile(
            title: Text('Ebook',
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 18)),
            leading: Radio<Formato>(
              value: Formato.ebook,
              groupValue: _formato,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (Formato? value) {
                setState(() {
                  _formato = value;
                  format = 'ebook';
                });
              },
            ))
      ],
    );
  }

  Widget _buildData() {
    return DateTimeFormField(
      dateFormat: format_data,
      lastDate: DateTime.now(),
      dateTextStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 20),
      decoration: InputDecoration(
        hintText: 'Selecione a data',
        hintStyle: TextStyle(
          color: Theme.of(context).hintColor,
        ),
        errorStyle: TextStyle(color: Colors.red),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        suffixIcon: Icon(
          Icons.event_note,
          color: Theme.of(context).primaryColor,
        ),
      ),
      mode: DateTimeFieldPickerMode.date,
      onDateSelected: (DateTime value) {
        // _dataInicio = value;
        //  _flag = true;

        var datafor = format_data.format(value);
        _dataInicio = datafor;
      },
      validator: (DateTime? value) {
        if (_dataInicio.isEmpty) {
          return 'Data de Início deve ser preenchido';
        }
      },
    );
  }

  Widget _buildPaginas() {
    return TextFormField(
      textCapitalization: TextCapitalization.words,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyText1?.color,
        fontSize: 22,
      ),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      ),
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
        checkColor: Theme.of(context).backgroundColor,
        activeColor: Theme.of(context).accentColor,
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
      style: TextStyle(
          fontSize: 22, color: Theme.of(context).textTheme.bodyText1?.color),
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
        ),
      ),
      onChanged: (String? value) {
        _nCapitulos = int.parse(value!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('pt'),
      ],
      theme: Theme.of(context), //CustomTheme.lightTheme,
      // darkTheme: CustomTheme.darkTheme,
      // themeMode: currentTheme.currentTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 30),
            child: Text(
              'Adicionar Livro',
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          Container(
            height: MediaQuery.of(context).size.height + 80,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
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
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                  _buildFormato(),
                  //  _buildFormato2(),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          padding: EdgeInsets.only(top: 25),
                          child: Text(
                            'Data de Início:',
                            style: Theme.of(context).textTheme.bodyText1,
                          ))),
                  _buildData(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        padding: EdgeInsets.only(top: 25),
                        child: Row(children: <Widget>[
                          Text(
                            'Nº de Páginas:',
                            style: Theme.of(context).textTheme.bodyText1,
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
                              color: isChecked
                                  ? Theme.of(context).textTheme.bodyText1?.color
                                  : Colors.grey,
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
          backgroundColor:
              Theme.of(context).floatingActionButtonTheme.backgroundColor,
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
            Icons.arrow_forward_ios, color: Theme.of(context).accentColor,
            //  color: Colors.pink[100],
          ),
        ),
      ),
    );
  }
}
