import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import '../screen/FirstScreen.dart';
import 'DataModel.dart';
part 'CodeModel.freezed.dart';
part 'CodeModel.g.dart';

@Freezed()
class CodeModel with _$CodeModel{
  const factory CodeModel({
    @Default("정보없음") @JsonKey(name: 'STATION_CD') String stationCd,
    @Default("정보없음") @JsonKey(name: 'STATION_NM') String subwayname,
    @Default("정보없음") @JsonKey(name: 'LINE_NUM') String line,
    @Default("정보없음") @JsonKey(name: 'FR_CODE') String code,
  }) = _CodeModel;
  factory CodeModel.fromJson(Map<String, Object?> json) => _$CodeModelFromJson(json);
}

final apiCodeProvider = FutureProvider.autoDispose<List<CodeModel>>((ref) async {

  final filter = ref.watch(typeFilter);
  final subwayInfo = ref.watch(infoProvider);
  final subwayInfoB = ref.watch(infoProviderB);

  final String key = '4c6f72784b6272613735677166456d';

  var name = subwayInfo.elementAtOrNull(0)?.subname;

  if(name == '서울'){
    name = '서울역';
  }

  final nameWithoutParentheses = name?.replaceAll(RegExp(r'\([^()]*\)'), '');

  final Url = 'http://openapi.seoul.go.kr:8088/$key/json/SearchInfoBySubwayNameService/1/5/$nameWithoutParentheses';
  final response = await http.get(Uri.parse(Url));
  if(response.statusCode == 200){
    final List<dynamic> jsonBody = jsonDecode(response.body)['SearchInfoBySubwayNameService']['row'];
    var subCode = jsonBody.map((e) => CodeModel.fromJson(e)).toList();
    final index = subCode.indexWhere((e) => e.line == subwayInfoB[0].line);
    var result = subCode[index].stationCd;

    switch (filter){
      case SubwayFilter.A:
        box.write('codeA',result);
        print(result);
        return jsonBody.map((e) => CodeModel.fromJson(e)).toList();
      case SubwayFilter.B:
        box.write('codeB',result);
        print(result);
        return jsonBody.map((e) => CodeModel.fromJson(e)).toList();
      case SubwayFilter.T:
        box.write('codeT',result);
        print(result);
        return jsonBody.map((e) => CodeModel.fromJson(e)).toList();
    }
  } else {
    throw Exception('Failed to load user data');
  }
});

