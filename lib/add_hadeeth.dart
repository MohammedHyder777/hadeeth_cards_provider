import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ahadeeth_model.dart';

List tempAdd = [];

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  /// ***********************************************************************
  /// Styles
  ///************************************************ */
  final TextStyle labelStyle = const TextStyle(
    fontFamily: 'Scheherazade New',
    fontSize: 18,
    color: Colors.blue,
  );

  final TextStyle fieldStyle = const TextStyle(
    fontFamily: 'Scheherazade New',
    fontSize: 19,
  );

  final TextStyle bTxtStyle = const TextStyle(
      fontFamily: 'Reem Kufi', fontSize: 14, color: Colors.white);

  ///
  /// Text Editing Controllers
  ///

  final rawiCont = TextEditingController();
  final hadeethCont = TextEditingController();
  final degreeCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة حديث'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          Text(
            'راوي الحديث أو رواته:',
            style: labelStyle,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 7,
          ),
          TextField(
            textDirection: TextDirection.rtl,
            style: fieldStyle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: rawiCont,
          ),
          const SizedBox(
            height: 25,
          ),

          Text(
            'نص الحديث:',
            style: labelStyle,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 7,
          ),
          TextField(
            maxLines: null,
            minLines: null,
            textDirection: TextDirection.rtl,
            style: fieldStyle,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            controller: hadeethCont,
          ),
          const SizedBox(
            height: 25,
          ),

          Text(
            'تخريجه ودرجته:',
            style: labelStyle,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(
            height: 7,
          ),
          TextField(
            textDirection: TextDirection.rtl,
            style: fieldStyle,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: degreeCont,
          ),
          /* ******************* Buttons ************************ */
          ////////// زر إفراغ ////////////////////////////////////////////////////
          const SizedBox(
            height: 7,
          ),
          ButtonBar(alignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton.icon(
              onPressed: () {
                rawiCont.clear();
                hadeethCont.clear();
                degreeCont.clear();
              },
              icon: const Icon(CupertinoIcons.rectangle_stack),
              label: Text('إفراغ', style: bTxtStyle),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 13)),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  overlayColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
            ),
            ////////// زر إضافة ////////////////////////////////////////////////////
            Consumer<AhadeethModel>(
              builder: (context, value, child) => ElevatedButton.icon(
                onPressed: () {
                  // If the fields are empty:
                  if (rawiCont.text == '' ||
                      hadeethCont.text == '' ||
                      degreeCont.text == '') {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Align(
                              alignment: Alignment.topRight,
                              child: Text('تنبيه'),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  color: Colors.amber[800],
                                  size: 50,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'املأ جميع الحقول قبل إنشاء بطاقة حديث جديدة.',
                                  style: labelStyle,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                )
                              ],
                            ),
                            actionsAlignment: MainAxisAlignment.center,
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'عُلِم',
                                    style: bTxtStyle,
                                  ))
                            ],
                          );
                        });
                  }
                  // If they are not empty
                  else {
                    Hadeeth h = Hadeeth(
                      rawi: rawiCont.text,
                      hadeeth: hadeethCont.text,
                      degree: degreeCont.text,
                    );
                    value.addHadeeth(h);
                    rawiCont.clear();
                    hadeethCont.clear();
                    degreeCont.clear();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'أُضيفت بطاقة جديدة',
                                  style: labelStyle,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          );
                        });
                  }
                },
                icon: const Icon(Icons.check),
                label: Text('إضافة', style: bTxtStyle),
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 13)),
                    // backgroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)))),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
