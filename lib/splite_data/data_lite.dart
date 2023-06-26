import 'package:flutter/material.dart';
import 'package:make_source/splite_data/detail_view.dart';
import 'package:make_source/splite_data/model/sample.dart';
import 'package:make_source/splite_data/utils/data.dart';

import 'repository/sql_sample_crud_repository.dart';

class DataLite extends StatefulWidget {
  const DataLite({super.key});

  @override
  State<DataLite> createState() => _DataLiteState();
}

class _DataLiteState extends State<DataLite> {
  Future<List<Sample>> _loadSampleList() async {
    return await SqlSampleCrudRepository.getList();
  }

  void createRandomSample() async {
    double value = DataUtils.randomValue();
    var sample =
        Sample(name: DataUtils.makeUUID(), yn: value.toInt() % 2 == 0, value: value, createdAt: DateTime.now());
    await SqlSampleCrudRepository.create(sample);
    update();
  }

  void update() => setState(() {});

  Widget _sampleOne(Sample sample) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailView(
              sample: sample,
            ),
          ),
        );
        update();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: sample.yn ? Colors.green : Colors.red,
                  ),
                ),
                Expanded(
                  child: Text(
                    sample.name,
                    style: const TextStyle(fontSize: 17),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              sample.createdAt.toIso8601String(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sqflite Sample'),
      ),
      body: FutureBuilder(
        future: _loadSampleList(),
        builder: (context, AsyncSnapshot<List<Sample>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Not Support Sqflite.'));
          }
          if (snapshot.hasData) {
            var datas = snapshot.data;
            return ListView(
              children: List.generate(datas!.length, (index) => _sampleOne(datas[index])).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createRandomSample,
        child: const Icon(Icons.add),
      ),
    );
  }
}
