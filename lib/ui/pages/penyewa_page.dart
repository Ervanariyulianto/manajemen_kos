import 'package:flutter_kos/models/catatan.dart';
import 'package:flutter_kos/shared/shared_preferences.dart';
import 'package:flutter_kos/shared/snackbar.dart';
import 'package:flutter_kos/shared/theme.dart';
import 'package:flutter_kos/ui/pages/widgets/button.dart';
import 'package:flutter_kos/ui/pages/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class PenyewaPage extends StatefulWidget {
  const PenyewaPage({super.key});

  @override
  State<PenyewaPage> createState() => _PenyewaPageState();
}

enum TipeTransaksi { pengeluaran, pemasukan }

class _PenyewaPageState extends State<PenyewaPage> {
  final TextEditingController tanggalControl = TextEditingController();
  final TextEditingController namaControl = TextEditingController();
  final TextEditingController AlamatControl = TextEditingController();
  final TextEditingController teleponControl = TextEditingController();
  final TextEditingController catatanControl = TextEditingController();

  List<Catatan> catatatItems = [];
  final formKey = GlobalKey<FormState>();
  TipeTransaksi? group = TipeTransaksi.pemasukan;

  String kategori = '';

  void save(BuildContext context, String tanggal, String kategori,
      String tipeTransaki, int jumlah, String catatan) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = const Uuid().v1();

    catatatItems.add(Catatan(
      id: id,
      tanggal: tanggal,
      tipeTransaksi: tipeTransaki,
      kategori: kategori,
      jumlah: jumlah,
      catatan: catatan,
    ));

    CustomSnackBar.showToast(context, 'Berhasil disimpan!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Penghuni'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/menu');
          },
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    title: 'Tanggal',
                    controller: tanggalControl,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickerDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickerDate != null) {
                        String formatDate =
                            DateFormat('dd MMMM yyyy').format(pickerDate);

                        setState(() {
                          tanggalControl.text = formatDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Kategori',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: kategori == ''
                          ? Text(
                              'Pilih Kategori',
                              style: blackTextStyle.copyWith(
                                fontWeight: medium,
                              ),
                            )
                          : Text(
                              kategori,
                              style: blackTextStyle.copyWith(
                                fontWeight: medium,
                              ),
                            ),
                      isDense: true,
                      isExpanded: true,
                      items: [
                        'Kamar 1',
                        'Kamar 2',
                        'Kamar 3',
                        'Kamar 4',
                        'Kamar 5',
                      ].map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: blackTextStyle.copyWith(fontWeight: medium),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          kategori = value.toString();
                        });
                      },
                    )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Nama Penghuni',
                    controller: namaControl,
                  ),
                  Text(
                    'Jenis Kelamin',
                    style: blackTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'laki-Laki',
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                      ),
                    ),
                    leading: Radio<TipeTransaksi>(
                      value: TipeTransaksi.pengeluaran,
                      groupValue: group,
                      onChanged: (value) {
                        setState(() {
                          group = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Perempuan',
                      style: blackTextStyle.copyWith(
                        fontWeight: regular,
                      ),
                    ),
                    leading: Radio<TipeTransaksi>(
                      value: TipeTransaksi.pemasukan,
                      groupValue: group,
                      onChanged: (value) {
                        setState(() {
                          group = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFormField(
                    title: 'Telepon',
                    controller: teleponControl,
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Alamat',
                    controller: AlamatControl,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFillButton(
                    title: 'Simpan',
                    onPressed: () {
                      if (kategori.isEmpty &&
                          tanggalControl.text.isEmpty &&
                          namaControl.text.isEmpty &&
                          AlamatControl.text.isEmpty &&
                          teleponControl.text.isEmpty &&
                          catatanControl.text.isEmpty) {
                        CustomSnackBar.showToast(
                            context, 'Inputan masih kosong!');
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Info'),
                              content: const Text('Yakin ingin simpan!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Batal'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    save(
                                        context,
                                        tanggalControl.text,
                                        kategori,
                                        group.toString().split('.').last,
                                        int.parse(catatanControl.text),
                                        catatanControl.text);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Ya'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
