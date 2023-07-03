import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/DataModel.dart';
import 'TextFrame.dart';

class SubwayInput extends StatelessWidget {

  final void Function(String)? onSelected;

   SubwayInput(this.onSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    double appHeight = MediaQuery.of(context).size.height;///  896.0 IPHONE11
    return Consumer(
        builder: (context, ref, child){
          final subwayData = ref.watch(dataProviderInside);
          return subwayData.when(
                loading: () => const Center(
                    child: TextFrame(comment: '실시간 위치정보를 받을 수 없습니다')),
                error: (err, stack) => Text(err.toString()),
                data: (data) {
                  final filteredname = data.map((e) => e.subname).toSet().toList();
                  return Container(
                    width: appHeight * 0.2791,
                    height: appHeight * 0.07255,
                    child: RawAutocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue){
                        return filteredname.where((String option) {
                          return option.contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (
                          BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted,
                          ){
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: '입력 후 완료버튼을 누르세요',
                            labelText: 'Enter Destination',
                            hintStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(
                              Icons.subway,
                              color: Colors.black,
                            ),
                            suffixIcon: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10.0),
                                onTap: () {
                                  textEditingController.clear();
                                },
                                child: Icon(
                                    Icons.clear,
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      optionsViewBuilder: (
                          BuildContext context,
                          AutocompleteOnSelected<String> onSelected,
                          Iterable<String> options ){
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: SizedBox(
                              width: appHeight * 0.28,
                              height: appHeight * 0.3,
                              child: Container(
                                color: Colors.white,
                                child: ListView.builder(
                                    padding: const EdgeInsets.all(8.0),
                                    itemCount: options.length,
                                    itemBuilder: (BuildContext context, int index){
                                      final String e = options.elementAt(index);
                                      return GestureDetector(
                                        onTap: (){
                                          onSelected(e);
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: ListTile(
                                            title: TextFrame(comment: e),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        );
                      },
                      onSelected: onSelected,
                    ),
                  );
                },

          );
        });



  }
}
