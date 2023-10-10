import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quran/quran.dart';
import 'package:quran/surah_data.dart';
import 'package:quransurah_sharedpreferences/utils/CustomWidget.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quransurah_sharedpreferences/utils/SharedPreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Surah extends StatefulWidget {
  int indexnum;
  Surah(this.indexnum, {super.key});

  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  CustomWidget cus = CustomWidget();
  final _scrollController = FixedExtentScrollController();

  List<String> ind = [];
  List<String> surahind = [];
  late bool click;

  @override
  void initState() {
    super.initState();
    Sharedpreference().getindexList().then((indx) {
      setState(() {
        ind = indx;
        print(ind);
      });
    });
    Sharedpreference().getindexnameList().then((srhindex) {
      surahind = srhindex;
      print(surahind);

      int lastIndex = -1;
      for (int i = surahind.length - 1; i >= 0; i--) {
        if (surahind[i] == widget.indexnum.toString()) {
          lastIndex = i;
          break;
        }
      }

      if (lastIndex != -1) {
        int inn = int.parse(ind.elementAt(lastIndex)) ?? 0;
        print(inn);

        Future.delayed(Duration(milliseconds: 1), () {
          _scrollController.jumpToItem(inn);
          click = true;
        });
      } else {
        click = false;
        setState(() {});
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: cus.paddingCus(
        EdgeInsets.all(10),
        Column(
          children: [
            cus.paddingCus(
              EdgeInsets.all(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 22,
                        color: Colors.black,
                      )),
                  cus.textCus("بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ", 29,
                      FontWeight.bold),
                ],
              ),
            ),
            Container(
              height: 3,
              color: Colors.black,
            ),
            Expanded(
                child: cus.paddingCus(
              EdgeInsets.all(20),
              ClickableListWheelScrollView(
                scrollController: _scrollController,
                itemHeight: 400,
                itemCount: quran.getVerseCount(widget.indexnum),
                onItemTapCallback: (index) async {
                  click = true;
                  final prefs = await SharedPreferences.getInstance();
                  print("onItemTapCallback index: $index");
                  String indx = index.toString();
                  String surahindx = widget.indexnum.toString();
                  ind.add(indx);
                  surahind.add(surahindx);
                  prefs.setStringList(
                      'index', ind.map((e) => e.toString()).toList());
                  prefs.setStringList(
                      'surahIndex', surahind.map((e) => e.toString()).toList());
                  setState(() {});
                },
                child: ListWheelScrollView.useDelegate(
                  controller: _scrollController,
                  itemExtent: 400,
                  overAndUnderCenterOpacity: 0.5,
                  perspective: 0.002,
                  onSelectedItemChanged: (index) async {
                    print("onSelectedItemChanged index: $index");
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final itemColor = click
                          ? (index == _scrollController.selectedItem
                              ? Colors.blue
                              : Colors.white)
                          : Colors.white;
                      return cus.paddingCus(
                        EdgeInsets.all(12),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: itemColor,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: cus.paddingCus(
                            EdgeInsets.all(12),
                            cus.textCus2(
                                quran.getVerse(widget.indexnum, index + 1),
                                24,
                                FontWeight.bold),
                          ),
                        ),
                      );
                    },
                    childCount: quran.getVerseCount(widget.indexnum),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
