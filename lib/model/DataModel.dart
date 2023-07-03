import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
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
