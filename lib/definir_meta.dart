import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_livro/databaseHelper.dart';
import 'package:projeto_livro/livro.dart';
import 'package:projeto_livro/main.dart';
import 'package:projeto_livro/themes.dart';

class DefinirMeta extends StatefulWidget {
  final String titulo;
  final String autor;
  final String data;
  final String formato;
  final int paginas;
  final int capitulos;
  final bool checked;
  final int horasEstimadas;
  final int minutosEstimados;
  final double paginaspormin;

  DefinirMeta({
    required this.titulo,
    required this.autor,
    required this.formato,
    required this.data,
    required this.paginas,
    required this.capitulos,
    required this.checked,
    required this.horasEstimadas,
    required this.minutosEstimados,
    required this.paginaspormin,
  });
  @override
  State<StatefulWidget> createState() {
    return DefinirMetaState();
  }
}

class DefinirMetaState extends State<DefinirMeta> {
  late String _titulo;
  late String _autor;
  late String _data;
  late String _formato;
  late int _paginas;
  late int _capitulos;
  late bool _checked;
  late int _horasEstimadas;
  late int _minutosEstimados;
  late double _paginaspormin;
  // Variaveis locais
  late String _datametaformatada;
  DateFormat format_data = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late int _meta;
  late String _tipometa = '';
  bool inicio = true;
  late String _temcapitulo;
  late String _dataInicio = _data.toString();
  int _paginaslidas = 0;
  int _capituloslidos = 0;
  int _porcentagem = 0;
  late bool metabool;
  String _dias = '';
  bool um = false;
  int dia = 0;
  bool zeroh = false;
  bool zerom = false;
  int horasEstimadas = 0;
  int minutosEstimados = 0;
  int horasmeta = 0;
  int minutosmeta = 0;
  bool tipometa = false;
  late DateTime metaemdia;
  @override
  void initState() {
    _titulo = widget.titulo;
    _autor = widget.autor;
    _data = widget.data;
    _formato = widget.formato;
    _paginas = widget.paginas;
    _capitulos = widget.capitulos;
    _checked = widget.checked;
    _horasEstimadas = widget.horasEstimadas;
    _minutosEstimados = widget.minutosEstimados;
    _paginaspormin = widget.paginaspormin;

    super.initState();
    if (_checked == true) {
      _temcapitulo = 'sim';
    } else {
      _temcapitulo = 'nao';
    }
    if (_tipometa == 'paginas') {
      tipometa = true;
    } else {
      tipometa = false;
    }
  }

  void tempometa() {
    setState(() {
      double temp = (_meta / _paginaspormin) / 60;
      horasmeta = temp.toInt();
      minutosmeta = (((temp - horasmeta) * 0.60) * 100).toInt();
      if (horasmeta == 0) {
        zeroh = true;
      } else {
        zeroh = false;
      }
      if (minutosmeta == 0) {
        zerom = true;
      } else {
        zerom = false;
      }
    });
  }

// Tempo da meta

  //Calculo das Estatisticas Paginas
  void estatisticasPaginas(_meta) {
    setState(() {
      //dias
      double dias = _paginas / _meta;
      _dias = (dias.toInt()).toString();
      double rest = dias - int.parse(_dias);
      if (rest > 0) {
        _dias = (int.parse(_dias) + 1).toString();
        dia = (int.parse(_dias));
      }
      if (_dias == '1') {
        _dias = '1 dia';
        um = true;
      }
    });
  }

  //Calculo das Estatisticas Capitulos
  void estatisticasCapitulos(_meta) {
    setState(() {
      //dias
      double dias = _capitulos / _meta;
      _dias = (dias.toInt()).toString();
      double rest = dias - int.parse(_dias);
      if (rest > 0) {
        _dias = (int.parse(_dias) + 1).toString();
        dia = (int.parse(_dias));
      }
      if (_dias == '1') {
        _dias = '1 dia';
        um = true;
      }
    });
  }

  //Estatisticas por capitulo
  Widget _buildEstatisticaCapitulos() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meta: ',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                    Text('$_meta capítulos por dia',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                  ])),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimativa de dias: ',
                    style: TextStyle(fontSize: 20, color: pFontColor)),
                um
                    ? Text(
                        '$_dias',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
                    : Text(
                        '$_dias dias',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data de Término: ',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                    Text(_datametaformatada,
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                  ])),
        ],
      ),
    );
  }

  //Estatisticas por pagina
  Widget _buildEstatisticaPaginas() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Meta: ',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                    Text('$_meta páginas por dia',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                  ])),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Tempo da meta: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: pFontColor,
                    )),
              ),
              Row(
                children: [
                  zeroh
                      ? Text(
                          '  $minutosmeta minutos',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        )
                      : zerom
                          ? Text(' $horasmeta horas',
                              style: TextStyle(
                                fontSize: 20,
                                color: pFontColor,
                              ))
                          : Text(' ${horasmeta}h ${minutosmeta}min',
                              style: TextStyle(
                                fontSize: 20,
                                color: pFontColor,
                              ))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Estimativa de dias: ',
                    style: TextStyle(fontSize: 20, color: pFontColor)),
                um
                    ? Text(
                        '$_dias',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
                    : Text(
                        '$_dias dias',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Data de Término: ',
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                    Text(_datametaformatada,
                        style: TextStyle(fontSize: 20, color: pFontColor)),
                  ])),
        ],
      ),
    );
  }

  //Estatisticas no fim da pagina
  Widget _buildEstatisticas() {
    if (_tipometa == 'paginas') {
      metabool = true;
    } else {
      metabool = false;
    }
    //se nao foi definido ainda nao mostra nada
    return inicio
        ? Text('')
        : metabool
            ? Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: _buildEstatisticaPaginas(),
              )
            : Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: _buildEstatisticaCapitulos(),
              );
  }

  void emdias() {
    metaemdia =
        DateTime.parse(_dataInicio).add(Duration(days: int.parse(_dias)));
    _datametaformatada = format_data.format(metaemdia);
  }

  //Titulo da pagina
  Widget _buildTituloPop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: pSecondaryColor,
        ),
        Text(
          'Definir Meta',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'LobsterTwo',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 38,
              color: pPrimaryColor),
        )
      ],
    );
  }

  //Texto inicial
  Widget _buildIntroducao() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'Defina sua meta de leitura pela quantidade de páginas ou capítulos por dia',
            style: TextStyle(fontSize: 24, color: pFontColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Você pode alterar a meta mais tarde',
            style: TextStyle(
                fontSize: 18,
                color: pSecondaryColor,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  //Botão Paginas
  Widget _buildPaginasBotao() {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(pPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ))),
      child: Text(
        'Páginas por dia',
        style: TextStyle(fontSize: 26, color: pScaffold, fontFamily: 'Oswald'),
      ),
      onPressed: () async {
        await abreDialogoPaginas(context);
      },
    );
  }

  //Botão Capitulos
  Widget _buildCapitulosBotao() {
    return ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(pPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          ))),
      child: Text(
        'Capítulos por dia',
        style: TextStyle(fontSize: 26, color: pScaffold),
      ),
      onPressed: () async {
        if (_checked == true && _capitulos != 0) {
          await abreDialogoCapitulos(context);
        }
      },
    );
  }

  //Caixa de dialogo paginas
  Future<void> abreDialogoPaginas(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController controllerpaginas =
              TextEditingController();
          return AlertDialog(
            backgroundColor: pScaffold,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            content: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('Páginas por dia: ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 28,
                            color: pFontColor,
                            fontFamily: 'Oswald')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          cursorColor: pPrimaryColor,
                          controller: controllerpaginas,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 28,
                              color: pFontColor),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Deve ser preenchido";
                            } else if (int.parse(value) > _paginas) {
                              return 'Número inválido';
                            } else if (int.parse(value) == 0) {
                              return 'Número inválido';
                            } else
                              return null;
                          },
                          onSaved: (String? value) {
                            _meta = int.parse(value!);
                            _tipometa = 'paginas';
                            inicio = false;
                            tipometa = true;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: pSecondaryColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: pSecondaryColor),
                              ),
                              border: UnderlineInputBorder()),
                        ),
                      ),
                      Text(
                        '/ $_paginas',
                        style: TextStyle(
                            fontSize: 28,
                            color: pFontColor,
                            fontFamily: 'Oswald'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              FloatingActionButton(
                backgroundColor: pPrimaryColor,
                onPressed: () => {
                  if (_formkey.currentState!.validate())
                    {
                      Navigator.of(context).pop(),
                    },
                  _formkey.currentState!.save(),
                  estatisticasPaginas(_meta),
                  tempometa(),
                  emdias(),
                },
                child: Icon(Icons.arrow_forward_ios, color: pSecondaryColor),
              )
            ],
          );
        });
  }

  //Caixa de dialogo capitulos
  Future<void> abreDialogoCapitulos(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController controllercapitulos =
              TextEditingController();
          return AlertDialog(
            backgroundColor: pScaffold,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))),
            content: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text('Capítulos por dia: ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontSize: 28,
                            color: pFontColor,
                            fontFamily: 'Oswald')),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        child: TextFormField(
                          cursorColor: pPrimaryColor,
                          controller: controllercapitulos,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontFamily: 'Oswald',
                              fontSize: 28,
                              color: pFontColor),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Deve ser preenchido";
                            } else if (int.parse(value) > _capitulos) {
                              return 'Número inválido';
                            } else if (int.parse(value) == 0) {
                              return 'Número inválido';
                            } else
                              return null;
                          },
                          onSaved: (String? value) {
                            _meta = int.parse(value!);
                            _tipometa = 'capitulos';
                            tipometa = false;
                            inicio = false;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: pSecondaryColor),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: pSecondaryColor),
                              ),
                              border: UnderlineInputBorder()),
                        ),
                      ),
                      Text(
                        '/ $_capitulos',
                        style: TextStyle(
                            fontSize: 28,
                            color: pFontColor,
                            fontFamily: 'Oswald'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              FloatingActionButton(
                backgroundColor: pPrimaryColor,
                onPressed: () => {
                  if (_formkey.currentState!.validate())
                    {Navigator.of(context).pop()},
                  _formkey.currentState!.save(),
                  estatisticasCapitulos(_meta),
                  emdias(),
                },
                child: Icon(Icons.arrow_forward_ios, color: pSecondaryColor),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            dialogBackgroundColor: pScaffold,
            unselectedWidgetColor: pPrimaryColor,
            fontFamily: 'Oswald',
            colorScheme: ColorScheme.light().copyWith(
              primary: pPrimaryColor,
              secondary: pPrimaryColor,
            )),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: pBackgroundColor,
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: _buildTituloPop(), //Definir a meta
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 40, left: 30, right: 30),
                decoration: BoxDecoration(
                  color: pScaffold,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Column(
                  children: [
                    _buildIntroducao(),
                    SizedBox(
                      width: 250.0,
                      height: 60.0,
                      child: _buildPaginasBotao(),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250.0,
                      height: 60.0,
                      child: _buildCapitulosBotao(),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    _buildEstatisticas(),
                  ],
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await DatabaseHelper.instance.add(Livro(
                  titulo: _titulo,
                  autor: _autor,
                  formato: _formato,
                  dataInicio: _dataInicio,
                  paginas: _paginas,
                  capitulos: _capitulos,
                  temcapitulos: _temcapitulo,
                  horasEstimadas: _horasEstimadas,
                  minutosEstimados: _minutosEstimados,
                  paginaspormin: _paginaspormin,
                  meta: _meta,
                  tipometa: _tipometa,
                  paginaslidas: _paginaslidas,
                  capituloslidos: _capituloslidos,
                  porcentagem: _porcentagem,
                  dias: um ? '1' : _dias));
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            child: Icon(
              Icons.check,
              color: pSecondaryColor,
            ),
          ),
        ));
  }
}
