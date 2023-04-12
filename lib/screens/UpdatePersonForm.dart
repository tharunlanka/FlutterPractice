import 'package:flutter/material.dart';
import 'package:flutter_practice/utilities/fieldValidator.dart';
import 'package:hive/hive.dart';

import '../models/People.dart';

class UpdatePersonForm extends StatefulWidget {
  final People people;
  final int index;

  const UpdatePersonForm({Key? key, required this.people, required this.index})
      : super(key: key);

  @override
  State<UpdatePersonForm> createState() => _UpdatePersonFormState();
}

class _UpdatePersonFormState extends State<UpdatePersonForm> {
  late final _nameController;
  late final _countryController;
  final _personFormKey = GlobalKey<FormState>();
  late final Box box;

  _updateInfo() {
    People newPerson = People(
      name: _nameController.text,
      country: _countryController.text,
    );
    box.putAt(widget.index, newPerson);
  }

  @override
  void initState() {
    super.initState();
    box = Hive.box('peopleBox');
    // Show the current values
    _nameController = TextEditingController(text: widget.people.name);
    _countryController = TextEditingController(text: widget.people.country);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _personFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Name'),
              TextFormField(
                controller: _nameController,
                validator: Validator.fieldValidator,
              ),
              const SizedBox(height: 24.0),
              const Text('Home Country'),
              TextFormField(
                controller: _countryController,
                validator: Validator.fieldValidator,
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
                        _updateInfo();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Update'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
