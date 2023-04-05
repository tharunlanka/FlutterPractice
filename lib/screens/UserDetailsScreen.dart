import 'package:flutter/material.dart';

class UserDetailsScreen extends StatelessWidget {
  final String title;
  final String image;

  const UserDetailsScreen({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.network(image,
              // width: 300,
              // height: 150,
              fit: BoxFit.fill),
        ),
        Text(title,textAlign: TextAlign.center,style: const TextStyle(color: Colors.blue)),
        const Spacer(
          flex: 1,
        ),
        TextButton(
          style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () => {Navigator.of(context).pop()},
            child: const Text("Back",style: TextStyle(color: Colors.white),))
      ],
    );
  }
}
