import 'package:flutter/material.dart';

class BelajarMappingListWidget extends StatelessWidget {
  const BelajarMappingListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> myList = [
      {
        "name" : "Naufal Parama Rafif",
        "age" : 15,
        "favColor" : ["Black", "Red", "Blue", "Black", "Red", "Blue", "Black", "Red", "Blue"],
      },
      {
        "name" : "Yusuf",
        "age" : 17,
        "favColor" : ["Orange", "White", "Pink"],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Belajar Mapping Widget", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: ListView(
        children: myList.map((data) {
          List myFavColor = data["favColor"];
          return Card(
            margin: EdgeInsets.all(15),
            color: const Color.fromARGB(255, 207, 207, 207),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(width: 8,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${data["name"]}"),
                          Text("Age ${data["age"]}"),
                        ],
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: myFavColor.map(
                        (color) {
                          return Container(
                            color: Colors.amber,
                            margin: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Text(color),
                          );
                        }).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}