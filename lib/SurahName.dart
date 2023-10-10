import 'package:flutter/material.dart';
import 'package:quransurah_sharedpreferences/Surah.dart';
import 'package:quransurah_sharedpreferences/utils/CustomWidget.dart';
import 'package:quran/quran.dart' as quran;

class SurahName extends StatefulWidget {
  const SurahName({super.key});

  @override
  State<SurahName> createState() => _SurahNameState();
}

class _SurahNameState extends State<SurahName> {
  CustomWidget cus = CustomWidget();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cus.paddingCus(
        EdgeInsets.all(10),
        Column(
          children: [
            cus.paddingCus(
              EdgeInsets.all(10),
              cus.textCus("بِسْمِ ٱللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ", 29,
                  FontWeight.bold),
            ),
            Container(
              height: 3,
              color: Colors.black,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: quran.totalSurahCount,
                itemBuilder: (context, index) {
                  return cus.paddingCus(
                    EdgeInsets.all(13),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Surah(index + 1),
                            ));
                      },
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.lightBlue,
                        ),
                        child: cus.paddingCus(
                          EdgeInsets.all(10),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              cus.textCus1(quran.getSurahNameEnglish(index + 1),
                                  20, FontWeight.bold),
                              cus.textCus1(quran.getSurahNameArabic(index + 1),
                                  16, FontWeight.normal),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
