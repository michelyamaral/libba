import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:projeto_livro/main.dart';
import 'package:projeto_livro/notificationservice.dart';
import 'package:projeto_livro/themes.dart';
//import 'package:projeto_livro/notification_ap1.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Sprint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SprintState();
  }
}

class SprintState extends State<Sprint> {
  // ignore: unused_local_variable
  Duration duracao = Duration();
  Duration sprint = Duration(minutes: 45);
  // ignore: unused_local_variable
  Timer? timer;
  bool isOn = false;
  bool not = false;
  int alarmId = 1;
  String dropdownValue = "45 minutos";
  bool acabou = false;
  DateTime dt = DateTime.now();
  int tempo = 0;
  @override
  void initState() {
    super.initState();
    reset();
    tz.initializeTimeZones();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationService.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      {stopTimer(), acabou = false, stopAlarm()};

  void sprintTempo() {
    /*if (dropdownValue == '3 segundos') {
      duracao = Duration(seconds: 3);
      sprint = Duration(seconds: 3);
      tempo = 3;
    } else */
    if (dropdownValue == '30 minutos') {
      duracao = Duration(minutes: 30);
      sprint = Duration(minutes: 30);
    } else if (dropdownValue == '45 minutos') {
      duracao = Duration(minutes: 45);
      sprint = Duration(minutes: 45);
    } else {
      duracao = Duration(minutes: 50);
      sprint = Duration(minutes: 50);
    }
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  void addTimer() {
    final adicionaSeg = -1;
    setState(() {
      final segundos = duracao.inSeconds + adicionaSeg;
      if (segundos < 0) {
        timer?.cancel();
        fireAlarm();
        NotificationService().showNotification(5, 'Fim do Sprint',
            'Sprint de $dropdownValue finalizado!', 'payload');
        acabou = true;
        not = true;
      } else {
        duracao = Duration(seconds: segundos);
      }
    });
  }

  fireAlarm() {
    FlutterRingtonePlayer.playAlarm(looping: true);
  }

  stopAlarm() {
    FlutterRingtonePlayer.stop();
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTimer());
    /* NotificationService().showNotification(
        2, 'Fim do Sprint', 'Sprint de $dropdownValue finalizado!', 1); */
  }

  void reset() {
    setState(() => duracao = sprint);
  }

  void pausaTimer({bool resets = true}) {
    if (resets) {
      reset();
    }
    setState(() => timer?.cancel());
  }

  Widget _buildRelogio() {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final minutos = doisDigitos(duracao.inMinutes.remainder(60));
    final segundos = doisDigitos(duracao.inSeconds.remainder(60));
    return Text(
      '$minutos:$segundos',
      style: TextStyle(fontSize: 65, color: pFontColor),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
          sprintTempo();
        });
      },
      dropdownColor: pSecondaryColor,
      icon: Icon(
        Icons.arrow_drop_down,
        color: pPrimaryColor,
        size: 40,
      ),
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(30)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: pSecondaryColor,
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
      style: TextStyle(
        fontSize: 20,
        color: pFontColor,
        fontFamily: 'Oswald',
      ),
      items: <String>['30 minutos', '45 minutos', '50 minutos']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: pFontColor, fontFamily: 'Oswald'),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBotoes() {
    final andamento = timer == null ? false : timer!.isActive;
    //final completo = duracao.inSeconds == 0;

    return acabou
        ? Center(
            child: SizedBox(
            width: 150,
            height: 50,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(pPrimaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ))),
              child: Text(
                'CONCLUIR',
                style: TextStyle(color: pSecondaryColor, fontSize: 20),
              ),
              onPressed: () {
                stopAlarm();
                NotificationService().cancelAllNotifications();
                setState(() {
                  acabou = false;
                  //not = false;
                  duracao = sprint;
                });
              },
            ),
          ))
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(andamento ? Icons.pause_circle : Icons.play_circle),
                color: pSecondaryColor,
                iconSize: 50,
                onPressed: () {
                  if (andamento) {
                    pausaTimer(resets: false);
                  } else {
                    startTimer(resets: false);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.replay_circle_filled),
                color: pPrimaryColor,
                iconSize: 50,
                onPressed: () {
                  stopTimer();
                  duracao = sprint;
                },
              ),
            ],
          );
  }

  Widget _buildCirculo() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: duracao.inSeconds / sprint.inSeconds,
              strokeWidth: 12,
              valueColor: AlwaysStoppedAnimation(pPrimaryColor),
              backgroundColor: pSecondaryColor,
            ),
            Center(
              child: _buildRelogio(),
            )
          ],
        ),
      );

  Widget _buildTexto() {
    return Text(
        'Selecione o tempo do Sprint, durante esse tempo se concentre na sua leitura',
        style: TextStyle(
          fontSize: 22,
          color: pFontColor,
        ),
        textAlign: TextAlign.center);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getColor(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                      padding: EdgeInsets.only(top: 15.0, left: 30.0),
                      child: Text('Sprint',
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
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: pScaffold,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                      child: Column(
                        children: <Widget>[
                          _buildTexto(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: _buildDropdown(),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _buildCirculo(),
                          SizedBox(
                            height: 15,
                          ),
                          _buildBotoes(),
                        ],
                      ),
                    )
                  ])));
        });
  }
}
