import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Item {
  String? url;
  String? file;
  String? desc;

  Item({
    this.url,
    this.desc,
    this.file,
  });
}

class DataInfo {
  final Item data = Item();

  DataInfo({
    data,
  });
}

class DataItem extends StatefulWidget {
  final DataInfo dataInfo;
  const DataItem({super.key, required this.dataInfo});

  @override
  State<DataItem> createState() => _DataItemState();
}

class _DataItemState extends State<DataItem> {
  XFile? file;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children: [
            InkWell(
              onTap: () async {
                var picker = ImagePicker();
                var image = await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  setState(() {
                    widget.dataInfo.data.url = '*';
                    widget.dataInfo.data.file = image.path;
                    file = image;
                  });
                }
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: file != null ? Image.file(File(file!.path)) : const SizedBox.shrink(),
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Expanded(
                child: Container(
                    alignment: Alignment.topLeft,
                    color: Colors.amber,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('입력하세요.'),
                        TextFormField(
                          initialValue: widget.dataInfo.data.desc,
                          onChanged: (String value) {
                            widget.dataInfo.data.desc = value;
                          },
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
