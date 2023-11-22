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
  final String? name;

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
        name ?? 'Long press to add name...'
    );
  }

  static const String hiveKey = 'chart_setups';
  static Box<ChartsSetup> get hiveBox => Hive.box<ChartsSetup>(hiveKey);

  static openBox() {
    if (!Hive.isBoxOpen(hiveKey)) {
      return Hive.openBox<ChartsSetup>(hiveKey);
    }
  }

  static ChartsSetup? getById(String id) {
    return hiveBox.get(id);
  }

  @override
  save() {
    final itemKey = id;
    return hiveBox.put(itemKey, this);
  }


}