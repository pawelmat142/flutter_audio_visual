import 'package:flutter_audio_visual/model/chart_setting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs

part 'charts_setup.g.dart';

@HiveType(typeId: 1)
class ChartsSetup extends HiveObject {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final List<Map<String, dynamic>> chartSettings;

  @HiveField(2)
  final DateTime modified;

  @HiveField(3)
  String? name;

  ChartsSetup(
      this.id,
      this.chartSettings,
      this.modified,
      this.name
  );

  static ChartsSetup create(List<ChartSetting> settings, { String? name }) {
    return ChartsSetup(
        const Uuid().v1(),
        settings.map((setting) => setting.toJson).toList(),
        DateTime.now(),
        name
    );
  }

  static ChartsSetup override(List<ChartSetting> settings, { required String id }) {
    final setup = getById(id)!;
    return ChartsSetup(
        setup.id,
        settings.map((setting) => setting.toJson).toList(),
        DateTime.now(),
        setup.name,
    );
  }

  Future<ChartsSetup> copy() async {
    final result = ChartsSetup(
        const Uuid().v1(),
        chartSettings,
        DateTime.now(),
        name == null ? null : '$name - copy'
    );
    await result.save();
    return result;
  }

  static const String hiveKey = 'chart_setups_4';
  static Box<ChartsSetup> get hiveBox => Hive.box<ChartsSetup>(hiveKey);

  static openBox() {
    if (!Hive.isBoxOpen(hiveKey)) {
      return Hive.openBox<ChartsSetup>(hiveKey);
    }
  }

  static ChartsSetup? getById(String id) {
    return hiveBox.get(id);
  }

  Future<void> save() {
    final itemKey = id;
    return hiveBox.put(itemKey, this);
  }

}