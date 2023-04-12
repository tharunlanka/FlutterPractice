
import 'package:hive/hive.dart';

import '../models/People.dart';

class PeopleAdapter extends TypeAdapter<People> {
  @override
  final typeId = 0;

  @override
  People read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return People(
      name: fields[0] as String,
      country: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, People obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.country);
  }
}