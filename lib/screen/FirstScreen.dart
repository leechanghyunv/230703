
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_combine_backend_230630/custom/CustomButton.dart';
import 'package:test_combine_backend_230630/screen/LinePickerA.dart';
import '../custom/SubwayInput.dart';
import '../custom/TextFrame.dart';
import '../model/DataModel.dart';

final box = GetStorage();

class FirstScreen extends ConsumerStatefulWidget {
  const FirstScreen({super.key});

  @override
  ConsumerState<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends ConsumerState<FirstScreen> {

  String subline = '';

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;///  896.0 IPHONE11
    final selector = ref.watch(typeFilter);
    final data = ref.watch(dataProviderInside);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                  comment: 'comment',
                  onPressed: () {
                    Get.dialog(
                        AlertDialog(
                          content: data.when(
                              loading: () => const Center(
                                  child: TextFrame(comment: '실시간 위치정보를 받을 수 없습니다')),
                              error: (err, stack) => Text(err.toString()),
                              data: (data){
                                return SubwayInput((value) {
                                  ref.read(typeFilter.notifier).update((state) => SubwayFilter.A);
                                  ref.read(infoProvider.notifier).searchSubway(data,value);
                                  Get.dialog(
                                    LinePickerA(),
                                  );
                                });
                              }
                          ),
                          actions: [
                            StatefulBuilder(builder: (__, StateSetter setState){
                              return CustomButton(comment: 'comment',
                                  onPressed: (){
                                    setState(() {});
                                    Navigator.pop(context);
                                  });
                            })
                          ],
                        )
                    );
                  }
              ),
              Container(
                child: Column(
                  children: [
                    TextFrame(comment: box.read('nameA') ?? ''),
                    TextFrame(comment: box.read('engnameA') ?? ''),
                    TextFrame(comment: box.read('lineA') ?? ''),
                    TextFrame(comment: box.read('codeA') ?? ''),
                    TextFrame(comment: box.read('lineAA') ?? ''),
                    TextFrame(comment: box.read('sublistA') ?? ''),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


