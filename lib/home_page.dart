// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var response;
  var url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
  var data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    response = await http.get(Uri.parse(url));
    data = jsonDecode(response.body)["drinks"];
    print(data.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          "Game Of Thrones",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.width > 800 ? 30 : 20),
        ),
      ),
      body: data == null
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width > 800 ? 150 : 60,
                    backgroundImage:
                        NetworkImage("${data[69]["strDrinkThumb"]}"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "${data[69]["strDrink"]}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            MediaQuery.of(context).size.width > 600 ? 25 : 15),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              MediaQuery.of(context).size.width > 600 ? 3 : 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                data[index]["strDrinkThumb"],
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "${data[index]["strDrink"]}",
                                    style: TextStyle(
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    "${data[index]["idDrink"]}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          color: Colors.white,
                        );
                      },
                      itemCount: data.length,
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
