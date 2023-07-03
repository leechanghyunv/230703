
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_combine_backend_230630/custom/CustomButton.dart';
import 'package:test_combine_backend_230630/screen/LinePickerA.dart';
import '../custom/SubwayInput.dart';
import '../custom/TextFrame.dart';
import '../model/DataModel.dart';


class FirstScreen extends ConsumerWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    double appHeight = MediaQuery.of(context).size.height;///  896.0 IPHONE11
    final filtered = ref.watch(infoProvider);
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
                              return SubwayInput((p) {
                                ref.read(infoProvider.notifier).searchSubway(data,p);
                                Get.dialog(
                                   LinePickerA(),
                                );
                              });
                          }
                        ),
                      )
                    );
                  }
              ),

            ],
          ),
        ),
      ),
    );
  }
}
