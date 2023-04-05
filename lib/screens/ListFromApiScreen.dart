import 'dart:convert';
import 'package:flutter_practice/models/ScreenArguments.dart';
import 'package:flutter_practice/routes/Routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_practice/models/UserDetails.dart';

class ListFromApiScreen extends StatefulWidget {
  const ListFromApiScreen({Key? key}) : super(key: key);

  @override
  State<ListFromApiScreen> createState() => _ListFromApiScreen();
}

class _ListFromApiScreen extends State<ListFromApiScreen> {
  Future<List<UserDetails>> fetchDetails() async {
    final response = await http.get(Uri.parse(
        'https://brotherlike-navies.000webhostapp.com/people/people.php'));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => UserDetails.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {

    void navigateToDetailScreen(String? title,String? avatar){
      Navigator.pushNamed(context, userDetails,
        arguments: ScreenArguments(title??" no title",avatar??  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThwH3uhjDlPyydY9SCwGkPqeF4s1esHTEM2Q&usqp=CAU')
      );
    }



    return FutureBuilder(
      future: fetchDetails(),
      builder: (context, AsyncSnapshot<List<UserDetails>> list) {
        if (list.connectionState == ConnectionState.done) {
          if (list.data == null) {
            return const Center(child: Text('Something went wrong'));
          }

          return ListView.builder(
              itemCount: list.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(list.data![index].name.toString()),
                  leading:  CircleAvatar(
                      backgroundImage:
                      NetworkImage(list.data![index].avatar.toString()),),
                  subtitle: Text(list.data![index].amount.toString()),
                  onTap: ()=>{
                    navigateToDetailScreen(list.data![index].name,list.data![index].avatar)
                  },
                );
              });
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
