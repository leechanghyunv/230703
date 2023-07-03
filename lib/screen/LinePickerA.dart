import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_combine_backend_230630/custom/TextFrame.dart';
import '../model/DataModel.dart';

class LinePickerA extends StatefulWidget {
  const LinePickerA({super.key});

  @override
  State<LinePickerA> createState() => _LinePickerAState();
}

class _LinePickerAState extends State<LinePickerA> {

  late String lineNumber;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Consumer(
          builder: (context,ref,child){
        var filtered = ref.watch(infoProvider);
        return Container(
          height: filtered.length == 1 ? 270
          : filtered.length == 2 ? 320
          : filtered.length == 3 ? 370
          : filtered.length == 4 ? 420
          : filtered.length == 5 ? 470
          : 520,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextFrame(comment: '${filtered[0].subname}'),
              ),
              Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(filtered.length,
                        (index) => CheckboxListTile(
                            title: Row(
                              children: [
                                IconCustom(filtered[index].line_ui),
                                SizedBox(width: 10,),
                                TextFrame(comment: filtered[index].line_ui),
                              ],
                            ),
                            value: filtered[index].isSelected,
                            activeColor: Colors.grey[600],
                            onChanged: (value){
                              if(value != null){
                                filtered = List.from(filtered.map((e) {
                                  if(e.line_ui == filtered[index].line_ui){
                                    lineNumber = filtered[index].line_ui;
                                    print(lineNumber);
                                    Navigator.pop(context);
                                    setState(() {});
                                    return e.copyWith(isSelected: true);
                                  } else {
                                    return e;
                                  }
                                })
                                );
                              }
                            })),
              ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget IconCustom(String line) =>
      Icon(Icons.square,
        color: line == 'Line1' ? const Color(0xff2a4193)
            : line == 'Line2' ? const Color(0xff027a31)
            : line == 'Line3' ? const Color(0xffd75e02)
            : line == 'Line4' ? const Color(0xff028bb9)
            : line == 'Line5' ? const Color(0xff9637b6)
            : line == 'Line6' ? const Color(0xff885408)
            : line == 'Line7' ? const Color(0xff525d02)
            : line == 'Line8' ? const Color(0xfff62d37)
            : line == 'Line9' ? const Color(0xff916a2a)
            : line == '서해' ? const Color(0xff8FC31F)
            : line == '공항' ? const Color(0xff0090D2)
            : line == '경의중앙' ? const Color(0xff77C4A3)
            : line == '경춘' ? const Color(0xff0C8E72)
            : line == '수인분당' ? const Color(0xFFE8E818)
            : line == '신분당' ? const Color(0xffD4003B)
            : line == '경강선' ? const Color(0xff003DA5)
            : line == '인천1선' ? const Color(0xff7CA8D5)
            : line == '인천2선' ? const Color(0xffED8B00)
            : line == '에버라인' ? const Color(0xff6FB245)
            : line == '의정부' ? const Color(0xffFDA600)
            : line == '우이신설' ? const Color(0xffB7C452)
            : line == '김포골드' ? const Color(0xffA17800)
            : line == '신림' ? const Color(0xff6789CA)
            : Colors.black,
      );
}

  

