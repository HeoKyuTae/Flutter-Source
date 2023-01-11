import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final items = [
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00016547c22f4655b7b3b3e0bd773bb01962.png?alt=media&token=34ef6cd6-6bb2-4740-95e7-a1f8c2afada9',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004406cf1de646c884aa6bc046813fae1013.png?alt=media&token=bcb34059-e8c4-4dc6-ba36-ec54edb382b2',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004986a8c49a4f2c8c62e07f033ab6b6685.png?alt=media&token=3f542728-326f-4445-a4a2-dcf4376953ce',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004eb37e1f1048039f42cd4825f111c961.png?alt=media&token=3c9348af-1fa6-4828-9a41-efc17733477d',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0050f485ce3e49b0a702940e12c127ea1364.png?alt=media&token=c6da0e3b-48e4-473d-9216-b9063913b344',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0057b16bc77f43b789a5032837dca7be51.png?alt=media&token=02b515e1-5fad-43de-986e-1bf60f7a7114',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/005e2b00ff344878ab361aed99555776998.png?alt=media&token=e6221fe1-65af-4bab-b198-ad8a484e8c34',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00deb15a3ba040e3835313c485d418201346.png?alt=media&token=fdeec2a4-4254-4334-a55b-967f6d4bb336',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01dec7baf6e24c9c8f344d4c13ddb1657.png?alt=media&token=a27b54a3-9dc6-4e3e-abc7-9aca29fc2894',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01f6cc08802a40f586736159720dbe4c549.png?alt=media&token=58bc0801-615c-4785-8237-c9058e10a675',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/021365e023894435af8478933378674964.png?alt=media&token=22c83ca7-80b9-4584-920c-7372b8672fd8',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/15c6f577086443aaa1c831ef322bc07622.png?alt=media&token=c9f65b6d-7fcd-4e4f-8227-a47798abd8b1',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fbd9736935c42618639b2be2e296c56751.png?alt=media&token=8f7d2c59-55db-47e8-8cec-d9ee7ab105d5',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fea2dee84344b0da5d813aa484a8c5117.png?alt=media&token=b631cc61-6ed3-4045-aa84-22d9825115aa',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3095f00fdd094f75919ba22ec3f8761570.png?alt=media&token=f5db0925-6121-4b99-8120-b1903ba45404',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3cf4d26125ff45ecb2664f537b01972b498.png?alt=media&token=546c8b6d-88c1-466c-a321-7c1463d3b50f',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/4189ba668b8d4995ae1f442f53045fe8145.png?alt=media&token=ed6b27c2-0495-4acc-8801-49f09c104367',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/559ef6b6913d4a4aa0184f0b3ad2f880308.png?alt=media&token=b460cde2-8a1d-4a9b-be5f-cbe3551a67ba',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5e814a628ebd44adb3be84ba6fc0251c111.png?alt=media&token=6de2139a-0fdb-4d0b-9617-7214e47bf760',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5fa01cc7648147deba4909b70944653e153.png?alt=media&token=46f0801c-6ccb-4ad0-b22e-91be596e4644',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00016547c22f4655b7b3b3e0bd773bb01962.png?alt=media&token=34ef6cd6-6bb2-4740-95e7-a1f8c2afada9',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004406cf1de646c884aa6bc046813fae1013.png?alt=media&token=bcb34059-e8c4-4dc6-ba36-ec54edb382b2',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004986a8c49a4f2c8c62e07f033ab6b6685.png?alt=media&token=3f542728-326f-4445-a4a2-dcf4376953ce',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004eb37e1f1048039f42cd4825f111c961.png?alt=media&token=3c9348af-1fa6-4828-9a41-efc17733477d',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0050f485ce3e49b0a702940e12c127ea1364.png?alt=media&token=c6da0e3b-48e4-473d-9216-b9063913b344',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0057b16bc77f43b789a5032837dca7be51.png?alt=media&token=02b515e1-5fad-43de-986e-1bf60f7a7114',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/005e2b00ff344878ab361aed99555776998.png?alt=media&token=e6221fe1-65af-4bab-b198-ad8a484e8c34',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00deb15a3ba040e3835313c485d418201346.png?alt=media&token=fdeec2a4-4254-4334-a55b-967f6d4bb336',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01dec7baf6e24c9c8f344d4c13ddb1657.png?alt=media&token=a27b54a3-9dc6-4e3e-abc7-9aca29fc2894',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01f6cc08802a40f586736159720dbe4c549.png?alt=media&token=58bc0801-615c-4785-8237-c9058e10a675',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/021365e023894435af8478933378674964.png?alt=media&token=22c83ca7-80b9-4584-920c-7372b8672fd8',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/15c6f577086443aaa1c831ef322bc07622.png?alt=media&token=c9f65b6d-7fcd-4e4f-8227-a47798abd8b1',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fbd9736935c42618639b2be2e296c56751.png?alt=media&token=8f7d2c59-55db-47e8-8cec-d9ee7ab105d5',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fea2dee84344b0da5d813aa484a8c5117.png?alt=media&token=b631cc61-6ed3-4045-aa84-22d9825115aa',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3095f00fdd094f75919ba22ec3f8761570.png?alt=media&token=f5db0925-6121-4b99-8120-b1903ba45404',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3cf4d26125ff45ecb2664f537b01972b498.png?alt=media&token=546c8b6d-88c1-466c-a321-7c1463d3b50f',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/4189ba668b8d4995ae1f442f53045fe8145.png?alt=media&token=ed6b27c2-0495-4acc-8801-49f09c104367',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/559ef6b6913d4a4aa0184f0b3ad2f880308.png?alt=media&token=b460cde2-8a1d-4a9b-be5f-cbe3551a67ba',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5e814a628ebd44adb3be84ba6fc0251c111.png?alt=media&token=6de2139a-0fdb-4d0b-9617-7214e47bf760',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5fa01cc7648147deba4909b70944653e153.png?alt=media&token=46f0801c-6ccb-4ad0-b22e-91be596e4644',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00016547c22f4655b7b3b3e0bd773bb01962.png?alt=media&token=34ef6cd6-6bb2-4740-95e7-a1f8c2afada9',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004406cf1de646c884aa6bc046813fae1013.png?alt=media&token=bcb34059-e8c4-4dc6-ba36-ec54edb382b2',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004986a8c49a4f2c8c62e07f033ab6b6685.png?alt=media&token=3f542728-326f-4445-a4a2-dcf4376953ce',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004eb37e1f1048039f42cd4825f111c961.png?alt=media&token=3c9348af-1fa6-4828-9a41-efc17733477d',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0050f485ce3e49b0a702940e12c127ea1364.png?alt=media&token=c6da0e3b-48e4-473d-9216-b9063913b344',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0057b16bc77f43b789a5032837dca7be51.png?alt=media&token=02b515e1-5fad-43de-986e-1bf60f7a7114',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/005e2b00ff344878ab361aed99555776998.png?alt=media&token=e6221fe1-65af-4bab-b198-ad8a484e8c34',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00deb15a3ba040e3835313c485d418201346.png?alt=media&token=fdeec2a4-4254-4334-a55b-967f6d4bb336',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01dec7baf6e24c9c8f344d4c13ddb1657.png?alt=media&token=a27b54a3-9dc6-4e3e-abc7-9aca29fc2894',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01f6cc08802a40f586736159720dbe4c549.png?alt=media&token=58bc0801-615c-4785-8237-c9058e10a675',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/021365e023894435af8478933378674964.png?alt=media&token=22c83ca7-80b9-4584-920c-7372b8672fd8',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/15c6f577086443aaa1c831ef322bc07622.png?alt=media&token=c9f65b6d-7fcd-4e4f-8227-a47798abd8b1',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fbd9736935c42618639b2be2e296c56751.png?alt=media&token=8f7d2c59-55db-47e8-8cec-d9ee7ab105d5',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fea2dee84344b0da5d813aa484a8c5117.png?alt=media&token=b631cc61-6ed3-4045-aa84-22d9825115aa',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3095f00fdd094f75919ba22ec3f8761570.png?alt=media&token=f5db0925-6121-4b99-8120-b1903ba45404',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3cf4d26125ff45ecb2664f537b01972b498.png?alt=media&token=546c8b6d-88c1-466c-a321-7c1463d3b50f',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/4189ba668b8d4995ae1f442f53045fe8145.png?alt=media&token=ed6b27c2-0495-4acc-8801-49f09c104367',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/559ef6b6913d4a4aa0184f0b3ad2f880308.png?alt=media&token=b460cde2-8a1d-4a9b-be5f-cbe3551a67ba',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5e814a628ebd44adb3be84ba6fc0251c111.png?alt=media&token=6de2139a-0fdb-4d0b-9617-7214e47bf760',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5fa01cc7648147deba4909b70944653e153.png?alt=media&token=46f0801c-6ccb-4ad0-b22e-91be596e4644',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00016547c22f4655b7b3b3e0bd773bb01962.png?alt=media&token=34ef6cd6-6bb2-4740-95e7-a1f8c2afada9',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004406cf1de646c884aa6bc046813fae1013.png?alt=media&token=bcb34059-e8c4-4dc6-ba36-ec54edb382b2',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004986a8c49a4f2c8c62e07f033ab6b6685.png?alt=media&token=3f542728-326f-4445-a4a2-dcf4376953ce',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004eb37e1f1048039f42cd4825f111c961.png?alt=media&token=3c9348af-1fa6-4828-9a41-efc17733477d',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0050f485ce3e49b0a702940e12c127ea1364.png?alt=media&token=c6da0e3b-48e4-473d-9216-b9063913b344',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0057b16bc77f43b789a5032837dca7be51.png?alt=media&token=02b515e1-5fad-43de-986e-1bf60f7a7114',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/005e2b00ff344878ab361aed99555776998.png?alt=media&token=e6221fe1-65af-4bab-b198-ad8a484e8c34',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00deb15a3ba040e3835313c485d418201346.png?alt=media&token=fdeec2a4-4254-4334-a55b-967f6d4bb336',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01dec7baf6e24c9c8f344d4c13ddb1657.png?alt=media&token=a27b54a3-9dc6-4e3e-abc7-9aca29fc2894',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01f6cc08802a40f586736159720dbe4c549.png?alt=media&token=58bc0801-615c-4785-8237-c9058e10a675',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/021365e023894435af8478933378674964.png?alt=media&token=22c83ca7-80b9-4584-920c-7372b8672fd8',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/15c6f577086443aaa1c831ef322bc07622.png?alt=media&token=c9f65b6d-7fcd-4e4f-8227-a47798abd8b1',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fbd9736935c42618639b2be2e296c56751.png?alt=media&token=8f7d2c59-55db-47e8-8cec-d9ee7ab105d5',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fea2dee84344b0da5d813aa484a8c5117.png?alt=media&token=b631cc61-6ed3-4045-aa84-22d9825115aa',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3095f00fdd094f75919ba22ec3f8761570.png?alt=media&token=f5db0925-6121-4b99-8120-b1903ba45404',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3cf4d26125ff45ecb2664f537b01972b498.png?alt=media&token=546c8b6d-88c1-466c-a321-7c1463d3b50f',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/4189ba668b8d4995ae1f442f53045fe8145.png?alt=media&token=ed6b27c2-0495-4acc-8801-49f09c104367',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/559ef6b6913d4a4aa0184f0b3ad2f880308.png?alt=media&token=b460cde2-8a1d-4a9b-be5f-cbe3551a67ba',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5e814a628ebd44adb3be84ba6fc0251c111.png?alt=media&token=6de2139a-0fdb-4d0b-9617-7214e47bf760',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5fa01cc7648147deba4909b70944653e153.png?alt=media&token=46f0801c-6ccb-4ad0-b22e-91be596e4644',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00016547c22f4655b7b3b3e0bd773bb01962.png?alt=media&token=34ef6cd6-6bb2-4740-95e7-a1f8c2afada9',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004406cf1de646c884aa6bc046813fae1013.png?alt=media&token=bcb34059-e8c4-4dc6-ba36-ec54edb382b2',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004986a8c49a4f2c8c62e07f033ab6b6685.png?alt=media&token=3f542728-326f-4445-a4a2-dcf4376953ce',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/004eb37e1f1048039f42cd4825f111c961.png?alt=media&token=3c9348af-1fa6-4828-9a41-efc17733477d',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0050f485ce3e49b0a702940e12c127ea1364.png?alt=media&token=c6da0e3b-48e4-473d-9216-b9063913b344',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/0057b16bc77f43b789a5032837dca7be51.png?alt=media&token=02b515e1-5fad-43de-986e-1bf60f7a7114',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/005e2b00ff344878ab361aed99555776998.png?alt=media&token=e6221fe1-65af-4bab-b198-ad8a484e8c34',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/00deb15a3ba040e3835313c485d418201346.png?alt=media&token=fdeec2a4-4254-4334-a55b-967f6d4bb336',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01dec7baf6e24c9c8f344d4c13ddb1657.png?alt=media&token=a27b54a3-9dc6-4e3e-abc7-9aca29fc2894',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/01f6cc08802a40f586736159720dbe4c549.png?alt=media&token=58bc0801-615c-4785-8237-c9058e10a675',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/021365e023894435af8478933378674964.png?alt=media&token=22c83ca7-80b9-4584-920c-7372b8672fd8',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/15c6f577086443aaa1c831ef322bc07622.png?alt=media&token=c9f65b6d-7fcd-4e4f-8227-a47798abd8b1',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fbd9736935c42618639b2be2e296c56751.png?alt=media&token=8f7d2c59-55db-47e8-8cec-d9ee7ab105d5',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/2fea2dee84344b0da5d813aa484a8c5117.png?alt=media&token=b631cc61-6ed3-4045-aa84-22d9825115aa',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3095f00fdd094f75919ba22ec3f8761570.png?alt=media&token=f5db0925-6121-4b99-8120-b1903ba45404',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/3cf4d26125ff45ecb2664f537b01972b498.png?alt=media&token=546c8b6d-88c1-466c-a321-7c1463d3b50f',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/4189ba668b8d4995ae1f442f53045fe8145.png?alt=media&token=ed6b27c2-0495-4acc-8801-49f09c104367',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/559ef6b6913d4a4aa0184f0b3ad2f880308.png?alt=media&token=b460cde2-8a1d-4a9b-be5f-cbe3551a67ba',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5e814a628ebd44adb3be84ba6fc0251c111.png?alt=media&token=6de2139a-0fdb-4d0b-9617-7214e47bf760',
    'https://firebasestorage.googleapis.com/v0/b/fireexx-36e7f.appspot.com/o/5fa01cc7648147deba4909b70944653e153.png?alt=media&token=46f0801c-6ccb-4ad0-b22e-91be596e4644',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GridView.builder(
        itemCount: items.length, //item 개수
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
          childAspectRatio: 1 / 1, //item 의 가로 1, 세로 2 의 비율
        ),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 150,
              height: 150,
              color: Colors.red,
              // child: CachedNetworkImage(
              //   progressIndicatorBuilder: (context, url, progress) => Center(
              //     child: CircularProgressIndicator(
              //       value: progress.progress,
              //     ),
              //   ),
              //   imageUrl: items[index],
              //   // imageUrl:
              //   //     'https://upload.wikimedia.org/wikipedia/commons/2/2a/%22A_present_for_the_mayor.%22_Washington%2C_D.C.%2C_Nov._17._Mayor_Joseph_K._Carson_of_Portland%2C_Ore._today_presented_a_chair_to_Mayor_Fiorello_La_Guardia%2C_of_New_York_City._Mayor_Carson_presented_LCCN2016872616.tif',
              //   // filterQuality: FilterQuality.low,
              //   // imageUrl:
              //   //     'https://firebasestorage.googleapis.com/v0/b/esgwebsite-fc472.appspot.com/o/image159m.tif?alt=media&token=c2bf1dcf-0371-4598-9d65-c69770d009df',
              // )
              child: Image.network(items[index]
                  // filterQuality: FilterQuality.low,
                  ),
            ),
          );
        }, //item 의 반목문 항목 형성
      ),
      /*
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              imageUrl:
                  'https://upload.wikimedia.org/wikipedia/commons/2/2a/%22A_present_for_the_mayor.%22_Washington%2C_D.C.%2C_Nov._17._Mayor_Joseph_K._Carson_of_Portland%2C_Ore._today_presented_a_chair_to_Mayor_Fiorello_La_Guardia%2C_of_New_York_City._Mayor_Carson_presented_LCCN2016872616.tif',
              // imageUrl:
              //     'https://firebasestorage.googleapis.com/v0/b/esgwebsite-fc472.appspot.com/o/image159m.tif?alt=media&token=c2bf1dcf-0371-4598-9d65-c69770d009df',
            );

            return Container(
                child: Image.network(
              'https://firebasestorage.googleapis.com/v0/b/esgwebsite-fc472.appspot.com/o/image159m.tif?alt=media&token=c2bf1dcf-0371-4598-9d65-c69770d009df',
              // filterQuality: FilterQuality.low,
            )
                // 'https://upload.wikimedia.org/wikipedia/commons/2/2a/%22A_present_for_the_mayor.%22_Washington%2C_D.C.%2C_Nov._17._Mayor_Joseph_K._Carson_of_Portland%2C_Ore._today_presented_a_chair_to_Mayor_Fiorello_La_Guardia%2C_of_New_York_City._Mayor_Carson_presented_LCCN2016872616.tif'),
                );
          }),
          */
    ));
  }
}
