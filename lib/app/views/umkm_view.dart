import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/umkm_controller.dart';
import 'umkm_form_page.dart';

class UmkmView extends StatelessWidget {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UmkmController());
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar UMKM")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.umkmList.isEmpty) {
          return const Center(child: Text("Belum ada data UMKM"));
        }
        return RefreshIndicator(
          onRefresh: controller.fetchUmkm,
          child: ListView.builder(
            itemCount: controller.umkmList.length,
            itemBuilder: (context, index) {
              final item = controller.umkmList[index];
              return ListTile(
                leading: CircleAvatar(child: Text(item.id?.toString() ?? "?")),
                title: Text(item.namaUmkm),
                subtitle: Text(item.alamat ?? "-"),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => UmkmFormPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}