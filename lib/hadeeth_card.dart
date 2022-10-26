
import 'package:flutter/material.dart';
import 'package:hadeeth_cards_provider/ahadeeth_model.dart';
import 'package:provider/provider.dart';

class HadeethCard extends StatelessWidget {
  const HadeethCard(
      {Key? key,
      required this.h,
      required this.doneFunc,
      required this.destroyFunc})
      : super(key: key);

  final Hadeeth h;
  final Function doneFunc;
  final Function destroyFunc;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => Card(
          margin: const EdgeInsets.all(10),
          elevation: 7,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: h.state == 0
              ? Theme.of(context).cardColor
              : const Color.fromARGB(255, 97, 192, 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    destroyFunc();
                  },
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.red[300]),
                      shape: MaterialStateProperty.all(const CircleBorder(
                          side: BorderSide(color: Colors.red)))),
                  child: const Icon(Icons.close),
                ),
                const SizedBox(height: 13),
                Text('عن ${h.rawi} عن النبي ﷺ قال:',
                    textDirection: TextDirection.rtl,
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      color: h.state == 0
                          ? const Color.fromARGB(255, 3, 91, 163)
                          : Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontFamily: 'Scheherazade New',
                    )),
                const SizedBox(height: 7),
                Text('(( ${h.hadeeth} )).',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 6, 19, 133),
                      fontSize: 27,
                      fontFamily: 'Scheherazade New',
                    )),
                const SizedBox(height: 7),
                Text(h.degree,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color:
                            h.state == 0 ? Colors.green[800] : Colors.white,
                        fontSize: 15,
                        fontFamily: 'Scheherazade New',
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 11),
                ElevatedButton(
                  onPressed: () {
                    doneFunc();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(h.state == 0 ? Icons.done : Icons.restart_alt),
                      Text(h.state == 0 ? 'تم حفظه' : ' إعادة ',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Scheherazade New',
                          )),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
