import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/People.dart';

class AddPersonScreen extends StatefulWidget {
  const AddPersonScreen({Key? key}) : super(key: key);

  @override
  State<AddPersonScreen> createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _personFormKey = GlobalKey<FormState>();
  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('peopleBox');
  }

  _addInfo() async {
    People newPerson = People(
      name: _nameController.text,
      country: _countryController.text,
    );
    box.add(newPerson);
    print('Info added to box!');
  }

  String? _fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading:IconButton(
              onPressed: () =>{
              Navigator.of(context).pop()
            },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: const Text('Add Person'),
          ),
      body: Form(
        key: _personFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Name'),
            TextFormField(
              controller: _nameController,
              validator: _fieldValidator,
            ),
            const SizedBox(height: 24.0),
            const Text('Home Country'),
            TextFormField(
              controller: _countryController,
              validator: _fieldValidator,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 24.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_personFormKey.currentState!.validate()) {
                      _addInfo();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
