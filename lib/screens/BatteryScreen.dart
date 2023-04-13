import 'package:battery/battery.dart';
import 'package:flutter/material.dart';

class BatteryScreen extends StatefulWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  @override
  State<BatteryScreen> createState() => _BatteryScreen();
}

class _BatteryScreen extends State<BatteryScreen> {
  final _battery = Battery();

  late int batteryLevel=0;
  late String batteryState='';


 @override
  void initState() {
    super.initState();
    getBatteryProp();
  }

  void getBatteryProp() async {
    batteryLevel= await _battery.batteryLevel;
    _battery.onBatteryStateChanged.listen((BatteryState state) {
      batteryState=state.name.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Level'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(' Battery Level ${batteryLevel.toString()}'),
            Text(' Battery State $batteryState'),
          ],
        ),
      ),
    );
  }

}
