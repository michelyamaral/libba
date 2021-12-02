import 'dart:async';

import 'package:flutter/material.dart';
import 'package:projeto_livro/definir_meta.dart';
import 'package:projeto_livro/themes.dart';

class TempoLeitura extends StatefulWidget {
  final String titulo;
  final String autor;
  final String data;
  final String formato;
  final int paginas;
  final int capitulos;
  final bool checked;

  TempoLeitura({
    required this.titulo,
    required this.autor,
    required this.formato,
    required this.data,
    required this.paginas,
    required this.capitulos,
    required this.checked,
  });
  @override
  State<StatefulWidget> createState() {
    return TempoLeituraState();
  }
}

class TempoLeituraState extends State<TempoLeitura> {
  // ignore: unused_field
  late String _titulo;
  // ignore: unused_field
  late String _autor;
  // ignore: unused_field
  late String _data;
  // ignore: unused_field
  late String _formato;
  // ignore: unused_field
  late int _paginas;
  // ignore: unused_field
  late int _capitulos;
  // ignore: unused_field
  late bool _checked;
  // ignore: unused_field
// ignore: unused_local_variable
  Duration duracao = Duration();
  // ignore: unused_local_variable
  Timer? timer;
  String tempo = '0';
  double temp = 0;
  int horasEstimadas = 0;
  int minutosEstimados = 0;
  double pgMin = 0;
  bool starttext = false;
  bool zeroh = false;
  bool zerom = false;
  @override
  void initState() {
    _titulo = widget.titulo;
    _autor = widget.autor;
    _data = widget.data;
    _formato = widget.formato;
    _paginas = widget.paginas;
    _capitulos = widget.capitulos;
    _checked = widget.checked;

    super.initState();

    reset();
  }

  Widget txtTempo() {
    return starttext
        ? Column(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Text('Tempo total estimado: ',
                              style:
                                  TextStyle(fontSize: 28, color: pFontColor)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            zeroh
                                ? Text(
                                    '  $minutosEstimados minutos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: pFontColor,
                                    ),
                                  )
                                : zerom
                                    ? Text(' $horasEstimadas horas',
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: pFontColor,
                                        ))
                                    : Text(
                                        ' ${horasEstimadas}h ${minutosEstimados}min',
                                        style: TextStyle(
                                          fontSize: 28,
                                          color: pFontColor,
                                        ))
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          )
        : Text('');
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  void addTimer() {
    final adicionaSeg = 1;
    setState(() {
      final segundos = duracao.inSeconds + adicionaSeg;
      duracao = Duration(seconds: segundos);
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTimer());
  }

  void reset() {
    setState(() => duracao = Duration());
  }

  void pausaTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() => timer?.cancel());
  }

  void tempoformato(duracao) {
    String digitos(int n) => n.toString().padLeft(2, '0');
    var min = digitos(duracao.inMinutes.remainder(60));
    var seg = digitos(duracao.inSeconds.remainder(60));
    // ignore: unused_local_variable
    String mins = min.toString();
    // ignore: unused_local_variable
    String segs = seg.toString();
    tempo = '$min.$seg';
    double tempoTimer = double.parse(tempo);
    pgMin = 1 / tempoTimer;
    double horas = (_paginas / pgMin) / 60;
    int totalHoras = horas.toInt();
    double minutos = (horas - totalHoras) * 0.60;
    int minut = (minutos * 100).toInt();
    horasEstimadas = totalHoras;
    minutosEstimados = minut;
    if (horasEstimadas == 0) {
      zeroh = true;
    } else {
      zeroh = false;
    }
    if (minutosEstimados == 0) {
      zerom = true;
    } else {
      zerom = false;
    }
  }

  Widget _buildRelogio() {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final minutos = doisDigitos(duracao.inMinutes.remainder(60));
    final segundos = doisDigitos(duracao.inSeconds.remainder(60));
    return Text(
      '$minutos:$segundos',
      style: TextStyle(fontSize: 55, color: pFontColor),
    );
  }

  Widget _buildBotoes() {
    final andamento = timer == null ? false : timer!.isActive;
    final completo = duracao.inSeconds == 0;
    //var botao = false;

    return andamento || !completo
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(andamento ? Icons.pause_circle : Icons.play_circle),
                color: pPrimaryColor,
                iconSize: 50,
                onPressed: () {
                  if (andamento) {
                    pausaTimer(resets: false);
                    tempoformato(duracao);
                    starttext = true;
                  } else {
                    startTimer(resets: false);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.replay_circle_filled),
                color: pBackgroundColor,
                iconSize: 50,
                onPressed: () {
                  stopTimer();
                  starttext = false;
                  duracao = Duration();
                  tempoformato(duracao);
                },
              ),
            ],
          )
        : ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                backgroundColor:
                    MaterialStateProperty.all<Color>(pPrimaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ))),
            child: Text(
              'COMEÇAR',
              style: TextStyle(fontSize: 26, color: pFontColor),
            ),
            onPressed: () {
              startTimer();
              //starttext = true;
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Oswald',
            colorScheme: ColorScheme.light().copyWith(
              primary: pPrimaryColor,
              secondary: pPrimaryColor,
            )),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: pBackgroundColor,
          body: ListView(children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: pSecondaryColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Tempo de Leitura',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'LobsterTwo',
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: pPrimaryColor),
                      ),
                    ])),
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
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: Column(children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                        color: pFontColor, fontFamily: 'Oswald', fontSize: 24),
                    children: [
                      TextSpan(
                          text:
                              'Para determinar o tempo total de leitura, comece o cronometro e leia uma página de'),
                      TextSpan(
                          text: ' $_titulo',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Leia na velocidade que você lê normalmente',
                          style: TextStyle(
                            fontSize: 24,
                            color: pPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ))),
                SizedBox(
                  width: 300.0,
                  height: 40.0,
                ),
                Container(
                  width: 250,
                  height: 200,
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: pSecondaryColor,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(children: [
                    Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(top: 20),
                          child: _buildRelogio(),
                        )),
                    _buildBotoes(),
                  ]),
                ),
                SizedBox(
                  width: 300.0,
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: txtTempo(),
                ),
              ]),
            )
          ]),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {
              if (horasEstimadas > 0 || minutosEstimados > 0)
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DefinirMeta(
                                titulo: _titulo,
                                autor: _autor,
                                formato: _formato,
                                data: _data,
                                paginas: _paginas,
                                capitulos: _capitulos,
                                checked: _checked,
                                horasEstimadas: horasEstimadas,
                                minutosEstimados: minutosEstimados,
                                paginaspormin: pgMin,
                              ))),
                },
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: pSecondaryColor,
            ),
          ),
        ));
  }
}
