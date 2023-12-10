import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<Map<String, dynamic>> textFieldData = [
  {
    "controller": TextEditingController(),
    "label": "Nama",
  },
  {
    "controller": TextEditingController(),
    "label": "Plat Nomor (tanpa spasi)",
  },
];

List<String> listDirectoryName = [
  "Foto Wajah",
  "Foto STNK",
  "Foto Wajah + STNK",
  "Foto Plat Nomor",
  "Foto Motor (tampak depan)",
  "Foto Memakai Helm",
  "Foto Diatas Motor"
];

List<List<Widget>> cardData = [
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.redAccent,
    ),
    Text(listDirectoryName[0]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.amberAccent,
    ),
    Text(listDirectoryName[1]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.greenAccent,
    ),
    Text(listDirectoryName[2]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.blueAccent,
    ),
    Text(listDirectoryName[3]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.pink,
    ),
    Text(listDirectoryName[4]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.orangeAccent,
    ),
    Text(listDirectoryName[5]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
  [
    const Icon(
      CupertinoIcons.photo,
      color: Colors.purpleAccent,
    ),
    Text(listDirectoryName[6]),
    const Icon(CupertinoIcons.checkmark_alt_circle)
  ],
];

List<List<dynamic>> dummyCardData = [
  [
    'Title 1',
    'Sub Title 1',
    'Sub Sub Title 1',
  ],
  [
    'Title 2',
    'Sub Title 2',
    'Sub Sub Title 2',
  ],
  [
    'Title 3',
    'Sub Title 3',
    'Sub Sub Title 3',
  ],
  [
    'Title 4',
    'Sub Title 4',
    'Sub Sub Title 4',
  ],
  [
    'Title 5',
    'Sub Title 5',
    'Sub Sub Title 5',
  ],
  [
    'Title 6',
    'Sub Title 6',
    'Sub Sub Title 6',
  ],
  [
    'Title 7',
    'Sub Title 7',
    'Sub Sub Title 7',
  ],
  [
    'Title 8',
    'Sub Title 8',
    'Sub Sub Title 8',
  ],
];
