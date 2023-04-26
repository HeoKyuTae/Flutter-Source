import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:make_source/dataitem/data_item.dart';
import 'package:path/path.dart';

class Datas extends StatefulWidget {
  const Datas({super.key});

  @override
  State<Datas> createState() => _DatasState();
}

class _DatasState extends State<Datas> {
  List<Widget> list = [];
  int idx = 0;

  add() {
    if (idx == 5) {
      return;
    }

    idx += 1;

    list.add(DataItem(
      dataInfo: DataInfo(
        data: Item(
          url: '',
          desc: '',
        ),
      ),
    ));

    setState(() {});
  }

  check() {
    for (var i = 0; i < list.length; i++) {
      DataItem? dataItem = list[i] as DataItem?;
      if (dataItem != null) {
        DataInfo dataInfo = dataItem.dataInfo;
        print('index : $i');
        print('url : ${dataInfo.data.url ?? ''}');
        print('file : ${dataInfo.data.file ?? ''}');
        print('desc : ${dataInfo.data.desc ?? ''}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                color: Colors.grey.withOpacity(0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        add();
                      },
                      child: const Text('ADD'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        check();
                      },
                      child: const Text('Check'),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return list[index];
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
