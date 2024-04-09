import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

class BelajarExtractWidget extends StatefulWidget {
  const BelajarExtractWidget({super.key});

  @override
  State<BelajarExtractWidget> createState() => _BelajarExtractWidgetState();
}

class _BelajarExtractWidgetState extends State<BelajarExtractWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Belajar Extract Widget', style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: [
          MyListTile(),
          for(int i = 0; i < 15; i++) ...[
            Divider(height: 0,),
            MyListTile(),
          ]
        ],
      )
    );
  }
}

class MyListTile extends StatelessWidget {
  final faker = Faker();
  late String fakerName = faker.person.name();
  late String fakerSentence = faker.lorem.sentence();

  MyListTile({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(title: fakerName, subtitle: fakerSentence,),
          ),
        );
      },
      leading: CircleAvatar(backgroundColor: Colors.black,),
      title: Text(fakerName),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: Text(fakerSentence, overflow: TextOverflow.ellipsis,)),
          Text('10:00 PM')
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: Colors.black,),
            Text(title),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}