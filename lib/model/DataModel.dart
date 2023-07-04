import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import '../screen/FirstScreen.dart';
import '../setting/Geolocator.dart';
part 'DataModel.freezed.dart';
part 'DataModel.g.dart';

@Freezed()
class SubwayModel with _$SubwayModel{
  const factory SubwayModel({
    required String subname,
    required String engname,
    required double lat,
    required double lng,
    required String line_ui,
    required int subwayid,
    required String line,
    required String heading,
    @Default(false) bool? isSelected,
    @Default(0.0) num? km,

  }) = _SubwayModel;
  factory SubwayModel.fromJson(Map<String, Object?> json) => _$SubwayModelFromJson(json);
}
extension MutableSubwayModelExtension on SubwayModel {
  SubwayModel setKm(double newKm) {
    return copyWith(km: newKm);
  }
}

/// json file에서 데이터를 가져옴
final dataProviderInside = FutureProvider<List<SubwayModel>>((ref) async {
  final  jsonData = await rootBundle.loadString('assets/test.json');
  final List<dynamic> data = jsonDecode(jsonData)['subwaydata'];
  return data.map((e) => SubwayModel.fromJson(e)).toList();
});

/// subwayname, line을 사용자가 선택한 이후에 결과를 가지고 데이터 필터링
class DataController extends StateNotifier<List<SubwayModel>>{
  DataController() : super([]);

  void searchSubway(subwayModels, name) {
    final searchResults = subwayModels.where((e) => e.subname == name).toList();
    state = searchResults;
    print(state);
  }
}

final infoProvider = StateNotifierProvider<DataController, List<SubwayModel>>((ref) => DataController());

enum SubwayFilter {
  A, B, T,
}
final typeFilter = StateProvider((_) => SubwayFilter.A);

/// store sub data
final subInfoProvider = Provider<List<SubwayModel>>((ref) {
  final filter = ref.watch(typeFilter); /// selector A,B,T
  final subwayinfo = ref.watch(infoProvider); ///  filter

  switch (filter) {
    case SubwayFilter.A:
      box.write('nameA',subwayinfo.elementAtOrNull(0)?.subname);
      box.write('latA',subwayinfo.elementAtOrNull(0)?.lat);
      box.write('lngA',subwayinfo.elementAtOrNull(0)?.lng);
      box.write('engnameA',subwayinfo.elementAtOrNull(0)?.engname);
      print('A');
      return subwayinfo.toList();
    case SubwayFilter.B:
      box.write('nameB',subwayinfo.elementAtOrNull(0)?.subname);
      box.write('latB',subwayinfo.elementAtOrNull(0)?.lat);
      box.write('lngB',subwayinfo.elementAtOrNull(0)?.lng);
      box.write('engnameB',subwayinfo.elementAtOrNull(0)?.engname);
      print('B');
      return subwayinfo.toList();
    case SubwayFilter.T:
      box.write('nameT',subwayinfo.elementAtOrNull(0)?.subname);
      box.write('latT',subwayinfo.elementAtOrNull(0)?.lat);
      box.write('lngT',subwayinfo.elementAtOrNull(0)?.lng);
      box.write('engnameT',subwayinfo.elementAtOrNull(0)?.engname);
      print('T');
      return subwayinfo;
  }
});

/// store line data




class subDataController extends StateNotifier<List<SubwayModel>>{
  subDataController() : super([]);

  void searchSubway(subwayModels, name, line) {
    final searchResults = subwayModels.
    where((e) => e.subname == name && e.line_ui == line).toList();
    state = searchResults;
    print(state);
  }
}

final infoProviderB = StateNotifierProvider<subDataController,
    List<SubwayModel>>((ref) => subDataController());

final subInfoProviderB = Provider<List<SubwayModel>>((ref) {
  final filter = ref.watch(typeFilter); /// selector A,B,T
  final subwayinfo = ref.watch(infoProviderB); ///  filter

  switch (filter) {
    case SubwayFilter.A:
      box.write('lineA',subwayinfo.elementAtOrNull(0)?.line_ui);
      box.write('sublistA',subwayinfo.elementAtOrNull(0)?.subwayid.toString());
      box.write('lineAA',subwayinfo.elementAtOrNull(0)?.line);
      print('AA');
      return subwayinfo.toList();
    case SubwayFilter.B:
      box.write('lineB',subwayinfo.elementAtOrNull(0)?.line_ui);
      box.write('sublistB',subwayinfo.elementAtOrNull(0)?.subwayid);
      box.write('lineBB',subwayinfo.elementAtOrNull(0)?.line);
      print('BB');
      return subwayinfo.toList();
    case SubwayFilter.T:
      box.write('lineT',subwayinfo.elementAtOrNull(0)?.line_ui);
      box.write('sublistT',subwayinfo.elementAtOrNull(0)?.subwayid);
      box.write('lineTT',subwayinfo.elementAtOrNull(0)?.line);
      print('TT');
      return subwayinfo;
  }
});



/// distance calculator
final latlngProvider = FutureProvider.autoDispose.family<List<SubwayModel>,List<SubwayModel>>((ref,data) async {

  final Distance _distance = Distance();
  final location = ref.watch(locationProvider);
  for (var i = 0; i < data.length; i++) {
    final km = _distance.as(
        LengthUnit.Kilometer,
        LatLng(location.value!.latitude, location.value!.longitude),
        LatLng(data[i].lat, data[i].lng));
    data[i] = data[i].setKm(km);
  }
  data.sort((a, b) => a.km!.compareTo(b.km!));
  return data.where((element) => element.line_ui.contains(
      'Line4')).toList();
});
