import 'package:flutter/material.dart';
// import 'package:faker/faker.dart';

// global var
// final faker = new Faker();
class Siswa {
  static int idSiswa = 0;

  static int setIdSiswa(){
    idSiswa++;
    return idSiswa;
  }
}
// class Siswa {
//   static int idSiswa = 0;
//   String nama;
//   String kelas;
//   String nisn;

//   Siswa({required this.nama, required this.kelas, required this.nisn}) {
//     idSiswa++;
//   }

//   Map<String, dynamic>> getSiswa(){
//     return 
//     {
//       "idSiswa" : 1,
//       "nama" : "Naufal Parama Rafif",
//       "kelas" : "XI PPLG 3",
//       "nisn" : 34343242,
//     };
//   }
// }

List<Map<String, dynamic>> listDataSiswa = [
{
  "idSiswa" : Siswa.setIdSiswa(),
  "nama" : "Naufal Parama Rafif",
  "kelas" : "XI PPLG 3",
  "nisn" : 34343242,
},
{
  "idSiswa" : Siswa.setIdSiswa(),
  "nama" : "Osama bin Laden",
  "kelas" : "XI PPLG 2",
  "nisn" : 34343243,
},
{
  "idSiswa" : Siswa.setIdSiswa(),
  "nama" : "Bayu Setiawati",
  "kelas" : "X PPLG 1",
  "nisn" : 34343244,
},];

class BelajarCRUDSederhana extends StatefulWidget {
  BelajarCRUDSederhana({super.key});

  @override
  State<BelajarCRUDSederhana> createState() => _BelajarCRUDSederhanaState();
}

enum CrudOperation { show, edit, delete }

class _BelajarCRUDSederhanaState extends State<BelajarCRUDSederhana> {
  CrudOperation? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Siswa", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'Nama',
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Kelas',
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'NISN',
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Action',
              ),
            ),
          ),
        ],
        rows: listDataSiswa.map((data) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text("${data["nama"]}")),
              DataCell(Text('${data["kelas"]}')),
              DataCell(Text('${data["nisn"]}')),
              DataCell(
                PopupMenuButton<CrudOperation>(
                  onSelected: (CrudOperation item) {
                    if(item == CrudOperation.show){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyShowScreen(nama: data["nama"], kelas: data["kelas"], nisn: data["nisn"], idSiswa: data["idSiswa"],),
                        ),
                      );
                    } else if (item == CrudOperation.edit){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyEditScreen(nama: data["nama"], kelas: data["kelas"], nisn: data["nisn"], idSiswa: data["idSiswa"],),
                        ),
                      );
                    } else if (item == CrudOperation.delete){
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Hapus Data Siswa'),
                          content: Text('Apakah anda ingin mengapus data siswa yang bernama ${data["nama"]}'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  listDataSiswa.removeWhere((element) => element["nama"] == data["nama"]);
                                });
                                Navigator.pop(context);
                              },
                              child: const Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<CrudOperation>>[
                    const PopupMenuItem<CrudOperation>(
                      value: CrudOperation.show,
                      child: ListTile(
                        leading: Icon(Icons.remove_red_eye_outlined),
                        title: Text('Detail'),
                      ),
                    ),
                    const PopupMenuItem<CrudOperation>(
                      value: CrudOperation.edit,
                      child: ListTile(
                        leading: Icon(Icons.edit),
                        title: Text('Ubah'),
                      ),
                    ),
                    const PopupMenuItem<CrudOperation>(
                      value: CrudOperation.delete,
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text('Hapus'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green[600],
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyAddScreen(),
            ),
          );
        },
        label: Text("+ Tambah Data", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class MyShowScreen extends StatelessWidget {
  const MyShowScreen({super.key, required this.nama, required this.kelas, required this.nisn, required this.idSiswa});
  final String nama;
  final String kelas;
  final int nisn;
  final int idSiswa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Siswa", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID Siswa: $idSiswa"),
            Text("Nama: $nama"),
            Text("Kelas: $kelas"),
            Text("NISN $nisn"),
          ],
        ),
      ),
    );
  }
}

class MyAddScreen extends StatefulWidget {
  const MyAddScreen({super.key});

  @override
  State<MyAddScreen> createState() => _MyAddScreenState();
}

class _MyAddScreenState extends State<MyAddScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController namaController = TextEditingController();
  TextEditingController kelasController = TextEditingController();
  TextEditingController nisnController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    kelasController.dispose();
    nisnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Siswa", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: namaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Nama Siswa',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kelasController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kelas siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Kelas Siswa',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: nisnController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NISN siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan NISN Siswa',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    tambahDataSiswa(nama: namaController.text, kelas: kelasController.text, nisn: int.parse(nisnController.text), idSiswa: Siswa.setIdSiswa());
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BelajarCRUDSederhana()),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEditScreen extends StatefulWidget {
  const MyEditScreen({super.key, required this.nama, required this.kelas, required this.nisn, required this.idSiswa});
  final String nama;
  final String kelas;
  final int nisn;
  final int idSiswa;

  @override
  State<MyEditScreen> createState() => _MyEditScreenState();
}

class _MyEditScreenState extends State<MyEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController kelasController;
  late TextEditingController nisnController;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.nama);
    kelasController = TextEditingController(text: widget.kelas);
    nisnController = TextEditingController(text: "${widget.nisn}");
  }

  @override
  void dispose() {
    namaController.dispose();
    kelasController.dispose();
    nisnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data Siswa", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: namaController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Nama Siswa',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: kelasController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kelas siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan Kelas Siswa',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: nisnController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NISN siswa tidak boleh kosong!';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Masukkan NISN Siswa',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    ubahDataSiswa(nama: namaController.text, kelas: kelasController.text, nisn: int.parse(nisnController.text), idSiswa: widget.idSiswa);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BelajarCRUDSederhana()),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void ubahDataSiswa({required String nama, required String kelas, required int nisn, required int idSiswa}) {
  for (var siswa in listDataSiswa) {
    if (idSiswa == siswa['idSiswa']) {
      siswa["nama"] = nama;
      siswa["kelas"] = kelas;
      siswa["nisn"] = nisn;
    }
  }
}

void tambahDataSiswa({required String nama, required String kelas, required int nisn, required int idSiswa}) {
  listDataSiswa.add(
    {
      "idSiswa" : Siswa.setIdSiswa(),
      "nama" : nama,
      "kelas" : kelas,
      "nisn" : nisn,
    },
  );
}