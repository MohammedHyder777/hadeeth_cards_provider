import 'package:flutter/material.dart';
import 'package:hadeeth_cards_provider/hadeeth_card.dart';
import 'package:hadeeth_cards_provider/intro_screen.dart';
import 'package:provider/provider.dart';

import 'add_hadeeth.dart';
import 'ahadeeth_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AhadeethModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'أحاديث',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            fontFamily: 'Reem Kufi',
            dialogTheme: DialogTheme(
                contentTextStyle: TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 18,
                    color: Colors.indigo[700])),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            )),
        routes: {
          '/': (context) => const MyHomePage(title: 'بطاقات الأحاديث'),
          '/add_page': (context) => const AddPage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool flag = true;
  void changeFlag() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() => flag = false);
  }

  @override
  void initState() {
    super.initState();
    changeFlag();
  }

  /// Show Clear Confirmation Dialog
  void showClearConfirm() {
    // the value has to be passed as a parameter from within the consumer.
    showDialog(
        context: context,
        builder: (context) => Consumer<AhadeethModel>(
                builder: (BuildContext context, value, Widget? child) {
              bool check = value.ahadeeth.isEmpty;
              return check
                  ? AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.info_outline,
                              color: Colors.indigo, size: 50),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'القائمة فارغة لا بطاقة فيها لتُمحى',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    )
                  : AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.question_mark,
                              color: Colors.red, size: 50),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'أترغب في محو جميع البطاقات؟',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: Row(
                                children: const [
                                  Icon(Icons.cancel),
                                  Text('إلغاء'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                // the delay is to avoid showing the content of the dialog when check is true
                                await Future.delayed(
                                    const Duration(milliseconds: 150));
                                value.clear();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.check),
                                  Text('تأكيد')
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
            })); // end of showdialog
  }

  /// Show Reset Confirmation Dialog
  void showResetConfirm() {
    // the value has to be passed as a parameter from within the consumer.
    showDialog(
        context: context,
        builder: (context) => Consumer<AhadeethModel>(
                builder: (BuildContext context, value, Widget? child) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.question_mark, color: Colors.red, size: 50),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'أترغب في استبدال بطاقاتك بالحزمة الأصلية التي تأتي مع البرنامج؟\n إن وافقت فستفقد جميع بياناتك',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.cancel),
                            Text('إلغاء'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          // the delay is to avoid showing the content of the dialog when check is true
                          await Future.delayed(
                              const Duration(milliseconds: 150));
                          value.setToInitAhadeeth();
                        },
                        child: Row(
                          children: const [
                            Icon(Icons.check),
                            Text('إعادة ضبط')
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            })); // end of showdialog
  }

  @override
  Widget build(BuildContext context) {
    return flag
        ? const IntroScreen()
        : Consumer<AhadeethModel>(
            builder: (BuildContext context, value, Widget? child) {
            return Scaffold(
              backgroundColor: const Color.fromARGB(255, 176, 201, 243),
              appBar: AppBar(
                toolbarHeight: 77,
                title: Text(
                  widget.title,
                  textDirection: TextDirection.rtl,
                ),
                shape: const StadiumBorder(),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton(
                      dropdownColor: Colors.indigo[100],
                      elevation: 0,
                      underline: const SizedBox(),
                      onChanged: (String? v) {
                        if (v == '1') {
                          showClearConfirm();
                        }
                        if (v == '2') {
                          showResetConfirm();
                        }
                        if (v == '3') {
                          Navigator.pushNamed(context, '/add_page');
                        }
                      },
                      hint: const Text('مزيد خيارات',
                          style: TextStyle(color: Colors.white)),
                      alignment: AlignmentDirectional.centerEnd,
                      icon: const Icon(Icons.settings,
                          color: Colors.white, size: 27),
                      items: [
                        DropdownMenuItem(
                          value: '1',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.clear_all, color: Colors.indigo[800]),
                              Text('إفراغ القائمة',
                                  style: TextStyle(color: Colors.indigo[800])),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: '2',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.restore_page_outlined,
                                  color: Colors.indigo[800]),
                              Text('إعادة ضبط',
                                  style: TextStyle(color: Colors.indigo[800])),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: '3',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.wysiwyg, color: Colors.indigo[800]),
                              Text('أضف حديثا',
                                  style: TextStyle(color: Colors.indigo[800])),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
              body: ListView(
                children: value.ahadeeth
                    .map(
                      (h) => HadeethCard(
                        h: h,
                        doneFunc: () {
                          setState(() {
                            h.state = h.state == 0 ? 1 : 0;
                            value.saveData();
                          });
                        },
                        destroyFunc: () {
                          value.remove(h);
                        },
                      ),
                    )
                    .toList(),
              ),

              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/add_page');
                },
                tooltip: 'أضف حديثا',
                child: const Icon(
                  Icons.wysiwyg_rounded,
                ),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          });
  }
}
