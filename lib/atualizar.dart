import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:projeto_livro/concluido.dart';
import 'package:projeto_livro/databaseHelper.dart';
import 'package:projeto_livro/leituras.dart';
import 'package:projeto_livro/livro.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:projeto_livro/livro_concluido.dart';
import 'package:projeto_livro/main.dart';
import 'package:projeto_livro/themes.dart';

import 'databaseHelper2.dart';

class Atualizar extends StatefulWidget {
  final Livro livro;
  Atualizar({required this.livro});
  @override
  State<StatefulWidget> createState() {
    return AtualizarState();
  }
}

class AtualizarState extends State<Atualizar> {
  TextEditingController _paginasLidas = TextEditingController();
  TextEditingController _capitulosLidos = TextEditingController();
  TextEditingController _meta = TextEditingController();
  TextEditingController _horas = TextEditingController();
  TextEditingController _minutos = TextEditingController();
  // TextEditingController _metac = TextEditingController();
  late Livro _livro;
  bool formatobool = false;
  late int por = 0;
  late int pag;
  late int cap;
  late int metaf;
  late int horasEstimadas;
  late int minutosEstimados;
  late int horasmetanovo;
  late int minutosmetanovo;
  late bool _temcapitulos;
  DateTime datafinal = DateTime.now();
  late DateTime _final;
  // ignore: non_constant_identifier_names
  DateFormat format_data = DateFormat('dd/MM/yyyy');
  late String _dataFinal = format_data.format(datafinal).toString();
  late bool _tipometa;
  int horasmeta = 0;
  int minutosmeta = 0;
  int horastotal = 0;
  int minutostotal = 0;
  late bool _flag;
  late var metaemdia;
  late String _tm;
  String tempoFinal = '';
  int diasmeta = 0;
  String diasmetafinal = '';
  bool um = false;
  String prce = '';
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool metanova = false;
  late int diasentre;
  double dias = 0;
  bool zeroh = false;
  bool zeroh2 = false;
  bool zerom = false;
  bool zerom2 = false;
  late DateTime _dataInicio;
  late String _dataInicioFormatada;
  late String _datametaformatada;
  @override
  void initState() {
    _livro = widget.livro;
    super.initState();
    if (_livro.formato == 'fisico') {
      formatobool = true;
    } else {
      formatobool = false;
    }

    if (_livro.temcapitulos == 'sim') {
      _temcapitulos = true;
    } else {
      _temcapitulos = false;
    }
    if (_livro.tipometa == 'paginas') {
      _tipometa = true;
    } else {
      _tipometa = false;
    }
    if (_livro.horasEstimadas == 0) {
      zeroh2 = true;
    }
    if (_livro.minutosEstimados == 0) {
      zerom2 = true;
    }
    if (_tipometa == true) {
      _tm = 'paginas';
    } else {
      _tm = 'capitulos';
    }
    pag = _livro.paginaslidas;
    cap = _livro.capituloslidos;
    diasmetafinal = _livro.dias;
    _paginasLidas = TextEditingController(text: _livro.paginaslidas.toString());
    _capitulosLidos =
        TextEditingController(text: _livro.capituloslidos.toString());
    _meta = TextEditingController(text: _livro.meta.toString());
    _horas = TextEditingController(text: _livro.horasEstimadas.toString());
    _minutos = TextEditingController(text: _livro.minutosEstimados.toString());
    _dataInicio = DateTime.parse(_livro.dataInicio);
    _dataInicioFormatada = format_data.format(_dataInicio).toString();
    porcentagem(_livro.porcentagem);
    tempo(_livro.paginaslidas);
    tempometa();
    meta();
    emdias();
  }

  void emdias() {
    metaemdia = DateTime.now().add(Duration(days: int.parse(diasmetafinal)));
    _datametaformatada = format_data.format(metaemdia);
  }

  Widget _cardTempoRestante() {
    return Card(
      color: pScaffold,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: pSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tempo restante: ',
              style: TextStyle(
                fontSize: 20,
                color: pFontColor,
              ),
            ),
            Row(
              children: [
                zeroh2
                    ? Text(
                        '  $minutosEstimados minutos',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
                    : zerom2
                        ? Text(' $horasEstimadas horas',
                            style: TextStyle(fontSize: 20, color: pFontColor))
                        : Text(' ${horasEstimadas}h ${minutosEstimados}min',
                            style: TextStyle(fontSize: 20, color: pFontColor))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardDiasEstimados() {
    return Card(
      elevation: 0,
      color: pScaffold,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: pSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dias até o término: ',
              style: TextStyle(fontSize: 20, color: pFontColor),
            ),
            Row(
              children: [
                Text(
                  '$diasmetafinal',
                  style: TextStyle(fontSize: 20, color: pFontColor),
                ),
                um
                    ? Text(
                        ' dia',
                        style: TextStyle(fontSize: 20, color: pFontColor),
                      )
                    : Text(' dias',
                        style: TextStyle(fontSize: 20, color: pFontColor))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _cardDataInicio() {
    return Card(
      elevation: 0,
      color: pScaffold,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: pSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
        child: _builData(),
      ),
    );
  }

  Widget _estimativadata() {
    return Card(
      elevation: 0,
      color: pScaffold,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: pSecondaryColor, width: 1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
          padding: EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Data de término: ',
                  style: TextStyle(fontSize: 20, color: pFontColor)),
              Text('$_datametaformatada',
                  style: TextStyle(fontSize: 20, color: pFontColor)),
            ],
          )),
    );
  }

  Widget _tituloeautor() {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '${_livro.titulo}',
              style: TextStyle(fontSize: 26, color: pFontColor),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              _livro.autor,
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontSize: 20, color: pFontColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardAtualizar() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Páginas: ',
                  style: TextStyle(fontSize: 20, color: pFontColor),
                ),
                Text(
                  ' ${_paginasLidas.text} ',
                  style: TextStyle(fontSize: 24, color: pFontColor),
                ),
                Text(
                  '/${_livro.paginas}',
                  style: TextStyle(fontSize: 24, color: pFontColor),
                ),
              ],
            ),
            _buildCap()
          ],
        ),
      ),
      Container(
        alignment: Alignment.topCenter,
        child: IconButton(
          onPressed: () async {
            await abreDialogo(context);
          },
          color: pSecondaryColor,
          icon: Icon(
            Icons.add_circle,
            size: 40,
            color: pPrimaryColor,
          ),
        ),
      )
    ]);
  }

  void tempototal() {
    double temp = (_livro.paginas / _livro.paginaspormin) / 60;
    horastotal = temp.toInt();
    minutostotal = (((temp - horastotal) * 0.60) * 100).toInt();
    if (horastotal == 0) {
      tempoFinal = '$minutostotal minutos';
    } else if (minutostotal == 0) {
      tempoFinal = '$horastotal horas';
    } else
      tempoFinal = '${horastotal}h ${minutostotal}min';
  }

  void tempometaedit() {
    int tempmeta = (int.parse(_horas.text.toString()) * 60) +
        int.parse(_minutos.text.toString());
    int temptotal = (horastotal * 60) + minutostotal;
    pag = (_livro.paginas * tempmeta) ~/ temptotal;
  }

  void tempometa() {
    setState(() {
      if (metanova == true) {
        double temp = (int.parse(_meta.text) / _livro.paginaspormin) / 60;
        horasmeta = temp.toInt();
        minutosmeta = (((temp - horasmeta) * 0.60) * 100).toInt();
        if (horasmeta == 0) {
          zeroh = true;
        } else
          zeroh = false;
        if (minutosmeta == 0) {
          zerom = true;
        } else
          zerom = false;
      } else {
        double temp = (_livro.meta / _livro.paginaspormin) / 60;
        horasmeta = temp.toInt();
        minutosmeta = (((temp - horasmeta) * 0.60) * 100).toInt();
        if (horasmeta == 0) {
          zeroh = true;
        } else
          zeroh = false;
        if (minutosmeta == 0) {
          zerom = true;
        } else
          zerom = false;
      }
    });
  }

  void meta() {
    setState(() {
      if (_tipometa == true) {
        int pagrest = _livro.paginas - pag;
        if (metanova == true) {
          dias = pagrest / int.parse(_meta.text);
          print(pag);
          print(dias);
        } else {
          dias = pagrest / _livro.meta;
        }

        diasmeta = dias.toInt();
        double rest = dias - diasmeta;

        if (rest > 0) {
          int diasmetad = diasmeta + 1;
          diasmetafinal = diasmetad.toString();
          print(diasmetafinal);
        } else {
          diasmetafinal = diasmeta.toString();
        }
        print(diasmetafinal);
        if (diasmetafinal == '1') {
          um = true;
        } else {
          um = false;
        }
        emdias();
      } else {
        int caprest = _livro.capitulos - cap;
        if (metanova == true) {
          dias = caprest / int.parse(_meta.text);
        } else
          dias = caprest / _livro.meta;
        diasmeta = dias.toInt();
        double rest = dias - diasmeta;
        if (rest > 0) {
          int diasmetad = diasmeta + 1;
          diasmetafinal = diasmetad.toString();
        } else {
          diasmetafinal = diasmeta.toString();
        }
        if (diasmetafinal == '1') {
          um = true;
        } else {
          um = false;
        }
        emdias();
      }
    });
  }

  void tempoateofinal() {
    diasentre = (_final.difference(_dataInicio).inHours / 24).round();
    if (diasentre == 0) {
      diasentre += 1;
    }
  }

  Widget _buildCap() {
    return _temcapitulos
        ? Container(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Text(
                    'Capítulos: ',
                    style: TextStyle(fontSize: 20, color: pFontColor),
                  ),
                  Text(
                    ' ${_livro.capituloslidos} ',
                    style: TextStyle(fontSize: 24, color: pFontColor),
                  ),
                  Text(
                    '/${_livro.capitulos}',
                    style: TextStyle(fontSize: 24, color: pFontColor),
                  ),
                ],
              ),
            ),
          )
        : SizedBox(
            height: 0,
          );
  }

  Widget _builData() {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          'Data de início: ',
          style: TextStyle(
            fontSize: 20,
            color: pFontColor,
          ),
        ),
        Text(
          '$_dataInicioFormatada',
          style: TextStyle(
            fontSize: 20,
            color: pFontColor,
          ),
        )
      ]),
    );
  }

  Widget _metaPaginas() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Meta:',
              style: TextStyle(
                fontSize: 20,
                color: pFontColor,
              ),
            ),
            IconButton(
                onPressed: () {
                  abreDialogoMeta(context);
                },
                icon: Icon(
                  Icons.edit,
                  color: pSecondaryColor,
                )),
          ]),
          metanova
              ? Card(
                  elevation: 0,
                  color: pScaffold,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: pSecondaryColor, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 20, right: 20, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Páginas por dia: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                        Text(
                          '${_meta.text}',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Card(
                  color: pScaffold,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: pSecondaryColor, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 12, left: 20, right: 20, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Páginas por dia: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                        Text(
                          '${_livro.meta} ',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _metaCapitulos() {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              'Meta: ',
              style: TextStyle(
                fontSize: 20,
                color: pFontColor,
              ),
            ),
            IconButton(
                onPressed: () {
                  abreDialogoMeta(context);
                },
                icon: Icon(Icons.edit, color: pSecondaryColor)),
          ]),
          Card(
            elevation: 0,
            color: pScaffold,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: pSecondaryColor, width: 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding:
                  EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 12),
              child: metanova
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Capítulos por dia: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                        Text(
                          '${_meta.text}',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Capítulos por dia: ',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                        Text(
                          '${_livro.meta}',
                          style: TextStyle(
                            fontSize: 20,
                            color: pFontColor,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataFinal() {
    return Form(
      key: _formkey,
      child: DateTimeFormField(
        dateFormat: format_data,
        lastDate: DateTime.now(),
        initialDate: DateTime.now(),
        firstDate: _dataInicio,
        initialValue: DateTime.now(),
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
          _final = value;
          _flag = true;

          tempoateofinal();
          var datafor = format_data.format(value);
          _dataFinal = datafor;
        },
        validator: (DateTime? value) {
          if (value == null) {
            _dataFinal = format_data.format(value!).toString();
            print(_dataFinal);

            _final = DateTime.now();
            print(_final);
            tempoateofinal();
          } else {
            _final = value;
            tempoateofinal();
          }
        },
      ),
    );
  }

  Widget _buildMeta() {
    return _tipometa ? _metaPaginas() : _metaCapitulos();
  }

  Future<void> abreDialogoExcluir(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: pScaffold,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            content: Container(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                'Tem certeza que deseja excluir?',
                style: TextStyle(color: pFontColor, fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: pSecondaryColor,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: pPrimaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: FloatingActionButton(
                      backgroundColor: pPrimaryColor,
                      onPressed: () async {
                        await DatabaseHelper.instance.remove(_livro.id!);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Icon(
                        Icons.check,
                        color: pSecondaryColor,
                      ),
                    ),
                  )
                ],
              )
            ])),
          );
        });
  }

  Future<void> abreDialogoConclucao(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Theme(
                data: ThemeData(
                  fontFamily: 'Oswald',
                  colorScheme: ColorScheme.light().copyWith(
                    primary: pPrimaryColor,
                    secondary: pSecondaryColor,
                    onSurface: pFontColor,
                  ),
                  dialogBackgroundColor: pScaffold,
                  unselectedWidgetColor: pSecondaryColor,
                ),
                child: AlertDialog(
                  backgroundColor: pScaffold,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  content: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Data do término: ',
                            style: TextStyle(color: pFontColor, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _buildDataFinal(),
                      ],
                    ),
                  ),
                  actions: [
                    FloatingActionButton(
                      onPressed: () async {
                        if (!_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                        }

                        //  tempoateofinal();
                        await DatabaseHelper.instance.remove(_livro.id!);
                        DatabaseHelper2.instance.add(LivroConcluido(
                            titulo: _livro.titulo,
                            autor: _livro.autor,
                            formato: _livro.formato,
                            dataInicio: _livro.dataInicio,
                            dataFinal: _dataFinal,
                            tempoFinal: tempoFinal,
                            dias: diasentre));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Concluido()));
                      },
                      backgroundColor: pPrimaryColor,
                      child: Icon(
                        Icons.check,
                        color: pSecondaryColor,
                      ),
                    )
                  ],
                ));
          });
        });
  }

  Future<void> abreDialogoMeta(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Theme(
              data: ThemeData(
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
              child: AlertDialog(
                  backgroundColor: pScaffold,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32))),
                  content: Form(
                      key: _formkey,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Meta:',
                            style: TextStyle(fontSize: 22, color: pFontColor),
                          ),
                        ),
                        _tipometa
                            ? Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Páginas por dia',
                                        style: TextStyle(
                                            fontSize: 22, color: pFontColor)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: _buildMetaPaginas()),
                                  _temcapitulos
                                      ? Align(
                                          alignment: Alignment.bottomLeft,
                                          child: TextButton(
                                              onPressed: () {
                                                setState(() {
                                                  _tipometa = false;
                                                });
                                              },
                                              child: Text(
                                                  'Mudar meta para capítulos por dia',
                                                  style: TextStyle(
                                                      color: pPrimaryColor))),
                                        )
                                      : Text(''),
                                ],
                              )
                            : Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Capítulos por dia',
                                        style: TextStyle(
                                            fontSize: 22, color: pFontColor)),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(left: 30),
                                      child: _buildMetaCapitulos()),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _tipometa = true;
                                          });
                                        },
                                        child: Text(
                                            'Mudar meta para páginas por dia',
                                            style: TextStyle(
                                                color: pPrimaryColor))),
                                  )
                                ],
                              ),
                      ])),
                  actions: <Widget>[
                    FloatingActionButton(
                      backgroundColor: pPrimaryColor,
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          _formkey.currentState!.save();
                        }

                        metanova = true;
                        meta();
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: pSecondaryColor,
                      ),
                    ),
                  ]),
            );
          });
        });
  }

  Widget _buildMetaPaginas() {
    return Row(
      children: [
        Container(
          width: 100,
          child: TextFormField(
            controller: _meta,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'Oswald', fontSize: 28, color: pFontColor),
            validator: (value) {
              if (value!.isEmpty) {
                return "Deve ser preenchido";
              } else if (int.parse(value) > _livro.paginas) {
                pag = 0;
                return 'Número inválido';
              } else if (value == '0') {
                return 'Número inválido';
              } else
                return null;
            },
            onSaved: (String? value) {
              metaf = int.parse(_meta.text);
              metanova = true;
              meta();
              tempometa();
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
        Align(
          alignment: Alignment.center,
          child: Text(
            ' /${_livro.paginas}',
            style: TextStyle(fontSize: 28, color: pFontColor),
          ),
        )
      ],
    );
  }

  Widget _buildMetaCapitulos() {
    return Row(
      children: [
        Container(
          width: 100,
          child: TextFormField(
            controller: _meta,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: 'Oswald', fontSize: 28, color: pFontColor),
            validator: (value) {
              if (value!.isEmpty) {
                return "Deve ser preenchido";
              } else if (int.parse(value) > _livro.capitulos) {
                pag = 0;
                return 'Número inválido';
              } else if (value == '0') {
                return 'Número inválido';
              } else
                return null;
            },
            onSaved: (String? value) {
              metaf = int.parse(_meta.text);
              metanova = true;
              meta();
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
        Align(
          alignment: Alignment.center,
          child: Text(
            ' /${_livro.capitulos}',
            style: TextStyle(fontSize: 28, color: pFontColor),
          ),
        )
      ],
    );
  }

  Future<void> abreDialogo(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return Theme(
            data: ThemeData(
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
            child: AlertDialog(
              backgroundColor: pScaffold,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32))),
              content: Form(
                  key: _formkey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    _temcapitulos
                        ? Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        'Página atual: ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 22, color: pFontColor),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: 100,
                                          child: TextFormField(
                                            cursorColor: pPrimaryColor,
                                            controller: _paginasLidas,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Oswald',
                                                fontSize: 28,
                                                color: pFontColor),
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Deve ser preenchido";
                                              } else if (int.parse(value) >
                                                  _livro.paginas) {
                                                pag = 0;
                                                return 'Número inválido';
                                              } else
                                                return null;
                                            },
                                            onSaved: (String? value) {
                                              if (int.parse(
                                                      _paginasLidas.text) >
                                                  _livro.paginas) {
                                                pag = 0;
                                              } else
                                                pag = int.parse(
                                                    _paginasLidas.text);
                                            },
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: pSecondaryColor),
                                                ),
                                                focusedBorder:
                                                    UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: pSecondaryColor),
                                                ),
                                                border: UnderlineInputBorder()),
                                          ),
                                        ),
                                        Text(
                                          '/ ${_livro.paginas}',
                                          style: TextStyle(
                                              fontSize: 28, color: pFontColor),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Capítulo atual: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 22, color: pFontColor),
                                    )),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: TextFormField(
                                        controller: _capitulosLidos,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 28,
                                            color: pFontColor),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Deve ser preenchido";
                                          } else if (int.parse(value) >
                                              _livro.capitulos) {
                                            cap = 0;
                                            return 'Número inválido';
                                          } else
                                            return null;
                                        },
                                        onSaved: (String? value) {
                                          cap = int.parse(_capitulosLidos.text);
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: pSecondaryColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: pSecondaryColor),
                                            ),
                                            border: UnderlineInputBorder()),
                                      ),
                                    ),
                                    Text(
                                      '/ ${_livro.capitulos}',
                                      style: TextStyle(
                                          fontSize: 28, color: pFontColor),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    'Página atual: ',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 22, color: pFontColor),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 100,
                                      child: TextFormField(
                                        controller: _paginasLidas,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontFamily: 'Oswald',
                                            fontSize: 28,
                                            color: pFontColor),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Deve ser preenchido";
                                          } else if (int.parse(value) >
                                              _livro.paginas) {
                                            pag = 0;
                                            return 'Numero invalido';
                                          } else
                                            return null;
                                        },
                                        onSaved: (String? value) {
                                          pag = int.parse(_paginasLidas.text);
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: pSecondaryColor),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: pSecondaryColor),
                                            ),
                                            border: UnderlineInputBorder()),
                                      ),
                                    ),
                                    Text(
                                      '/ ${_livro.paginas}',
                                      style: TextStyle(
                                          fontSize: 28, color: pFontColor),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                  ])),
              actions: <Widget>[
                FloatingActionButton(
                  backgroundColor: pPrimaryColor,
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      Navigator.of(context).pop();
                      _formkey.currentState!.save();
                    }

                    if (pag > _livro.paginas) {
                      porcentagem(0);
                    } else {
                      porcentagem(pag);
                    }
                    tempo(pag);
                    meta();
                    atualiza();
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: pSecondaryColor,
                  ),
                ),
              ],
            ),
          );
        });
  }

  tempo(int pag) {
    setState(() {
      int rest = _livro.paginas - pag;
      double h1 = (rest / _livro.paginaspormin) / 60;
      int h2 = h1.toInt();
      double m1 = (h1 - h2) * 0.60;
      int m2 = (m1 * 100).toInt();
      horasEstimadas = h2;
      minutosEstimados = m2;
      if (horasEstimadas == 0) {
        zeroh2 = true;
      } else {
        zeroh2 = false;
      }
      if (minutosEstimados == 0) {
        zerom2 = true;
      } else {
        zerom2 = false;
      }

      //atualiza();
    });
  }

  porcentagem(int pag) {
    setState(() {
      double porc = int.parse(_paginasLidas.text) * 100 / _livro.paginas;
      prce = por.toString();
      por = porc.toInt();
    });
  }

  atualiza() {
    setState(() {
      _livro = Livro(
        id: widget.livro.id,
        titulo: _livro.titulo,
        autor: _livro.autor,
        formato: _livro.formato,
        dataInicio: _livro.dataInicio,
        paginas: _livro.paginas,
        capitulos: _livro.capitulos,
        temcapitulos: _livro.temcapitulos,
        horasEstimadas: horasEstimadas,
        minutosEstimados: minutosEstimados,
        paginaspormin: _livro.paginaspormin,
        meta: metanova ? metaf : _livro.meta,
        tipometa: _tm,
        paginaslidas: int.parse(_paginasLidas.text),
        capituloslidos: _temcapitulos ? cap : 0,
        porcentagem: por,
        dias: diasmetafinal,
      );
    });
    DatabaseHelper.instance.update(_livro);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Oswald',
        colorScheme: ColorScheme.light().copyWith(
          primary: pPrimaryColor,
          secondary: pPrimaryColor,
          onSurface: pFontColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: pPrimaryColor,
            cursorColor: pPrimaryColor,
            selectionColor: pPrimaryColor),
        dialogBackgroundColor: pScaffold,
        unselectedWidgetColor: pSecondaryColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: pBackgroundColor,
        body: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: pSecondaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Atualizar ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: pPrimaryColor),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(
                          MdiIcons.trashCanOutline,
                          color: pSecondaryColor,
                          size: 35,
                        ),
                        onPressed: () async {
                          abreDialogoExcluir(context);
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          MdiIcons.checkboxMarkedCircleOutline,
                          color: pSecondaryColor,
                          size: 35,
                        ),
                        onPressed: () async {
                          tempototal();

                          abreDialogoConclucao(context);
                          // _dataFinal = format_data.format(datafinal);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            Container(
              height: MediaQuery.of(context).size.height + 300,
              decoration: BoxDecoration(
                color: pScaffold,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              padding:
                  EdgeInsets.only(top: 40, bottom: 10, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        Icon(
                            formatobool
                                ? MdiIcons.bookOpenPageVariantOutline
                                : MdiIcons.bookOpen,
                            color: pPrimaryColor,
                            size: 80),
                        SizedBox(
                          width: 20,
                        ),
                        _tituloeautor(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      lineHeight: 15.0,
                      percent: _livro.paginaslidas / _livro.paginas,
                      trailing: Text(
                        '${_livro.porcentagem.toString()}%',
                        style: TextStyle(color: pFontColor, fontSize: 18),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      progressColor: pPrimaryColor,
                      backgroundColor: pSecondaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      _cardAtualizar(),
                      Divider(
                        color: pPrimaryColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _cardTempoRestante(),
                      // _cardDiasEstimados(),
                      _cardDataInicio(),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: pPrimaryColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Estimativa de Término: ',
                            style: TextStyle(color: pFontColor, fontSize: 20),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      _estimativadata(),
                      _cardDiasEstimados(),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: pPrimaryColor,
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: _buildMeta(),
                      ),

                      _tipometa
                          ? Card(
                              elevation: 0,
                              color: pScaffold,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: pSecondaryColor, width: 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12, left: 20, right: 20, bottom: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Tempo por dia: ',
                                      style: TextStyle(
                                          fontSize: 20, color: pFontColor),
                                    ),
                                    Row(
                                      children: [
                                        zeroh
                                            ? Text('$minutosmeta minutos',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: pFontColor))
                                            : zerom
                                                ? Text('$horasmeta horas',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: pFontColor))
                                                : Text(
                                                    '${horasmeta}h ${minutosmeta}min',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: pFontColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ))
                          : SizedBox(
                              height: 0,
                            ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: pPrimaryColor,
          onPressed: () async {
            if (_tipometa == true) {
              _tm = 'paginas';
            } else {
              _tm = 'capitulos';
            }
            atualiza();
            tempototal();

            // metanova = false;
            if (_livro.porcentagem == 100) {
              //_dataFinal = format_data.format(datafinal);
              abreDialogoConclucao(context);
            } else
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Leitura()));
          },
          child: Icon(
            Icons.check,
            color: pSecondaryColor,
          ),
        ),
      ),
    );
  }
}
