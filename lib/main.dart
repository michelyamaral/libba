import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:projeto_livro/adicionar_livro.dart';
import 'package:projeto_livro/leituras.dart';
import 'package:projeto_livro/notificationservice.dart';
import 'package:projeto_livro/sprint.dart';
import 'package:flutter/services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:projeto_livro/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

//notificaçao
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  runApp(new MyApp());
}

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('pt'),
      ],
      home: MyHomePage(),
      //theme: theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
*/
class MyApp extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<void> getColor() async {
  pref = await SharedPreferences.getInstance();
  int? iniback = Color.fromRGBO(71, 40, 54, 1.0).value;
  int? iniscaff = Colors.white.value;
  int? inipri = Colors.teal.shade400.value;
  int? inisec = Colors.pink.shade100.value;
  int? inifon = Color.fromRGBO(71, 40, 54, 1.0).value;
  int? primaryhex = pref.getInt('primary') ?? inipri;
  int? secondaryhex = pref.getInt('secondary') ?? inisec;
  int? backgroundhex = pref.getInt('background') ?? iniback;
  int? scaffoldgex = pref.getInt('scaffold') ?? iniscaff;
  int? fonthex = pref.getInt('font') ?? inifon;
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
  pPrimaryColor = Color(primaryhex).withOpacity(1);
  pSecondaryColor = Color(secondaryhex).withOpacity(1);
  pBackgroundColor = Color(backgroundhex).withOpacity(1);
  pScaffold = Color(scaffoldgex).withOpacity(1);
  pFontColor = Color(fonthex).withOpacity(1);
}

Icon adicioinar = Icon(
  LineIcons.plus,
  size: 30,
);
Icon pagIni = Icon(
  LineIcons.bookOpen,
  size: 30,
);

Icon sprint = Icon(
  Icons.timer,
  size: 30,
);

class _MyHomePageState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    setState(() {
      getColor();
    });
  }

  int currentIndex = 1;
  final telas = [
    AdicionarLivro(),
    Leitura(),
    Sprint(),
  ];

  final itens = <Widget>[
    adicioinar,
    pagIni,
    sprint,
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

    return FutureBuilder(
        future: getColor(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate
              ],
              supportedLocales: [
                const Locale('pt'),
              ],
              theme: ThemeData(
                  iconTheme: IconThemeData(
                color: pPrimaryColor,
              )),
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                  backgroundColor: pBackgroundColor,
                  bottomNavigationBar: CurvedNavigationBar(
                    height: 52,
                    backgroundColor: pScaffold,
                    color: pBackgroundColor,
                    index: currentIndex,
                    items: itens,
                    onTap: (index) => setState(() => this.currentIndex = index),
                  ),
                  body: //telas[currentIndex],
                      IndexedStack(
                    index: currentIndex,
                    children: telas,
                  )));
        });
  }
}
