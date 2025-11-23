import '../../api/api_service.dart';

import '../model/extesion.dart'; // extension VatTu.toDeviceModel()
import '../model/product_device_model.dart';
import '../model/category.dart';

import '../../model/tron_goi.dart'; // chứa VatTu, VatTuFilterResponse

class DeviceRepository {
  Future<List<VatTu>> _fetch(String ma) async {
    final body = {
      "filters": [
        {
          "fieldName": "nhomVatTu.ma",
          "operation": "EQUALS",
          "value": ma,
          "logicType": "AND",
        },
      ],
      "sorts": [
        {"fieldName": "taoLuc", "direction": "ASC"},
      ],
      "page": 0,
      "size": 1000,
    };

    final res = await ApiService.post("/basic-api/vat-tu/filter", body);

    // Dùng model VatTuFilterResponse (model mới)
    final parsed = VatTuFilterResponse.fromJson(res as Map<String, dynamic>);
    return parsed.items; // List<VatTu>
  }

  Future<List<ProductDeviceModel>> getPanels() async {
    final data = await _fetch("TAM_PIN");
    return data.map((e) => e.toDeviceModel()).toList();
  }

  Future<List<ProductDeviceModel>> getInverters() async {
    final data = await _fetch("BIEN_TAN");
    return data.map((e) => e.toDeviceModel()).toList();
  }

  Future<List<ProductDeviceModel>> getBatteries() async {
    final data = await _fetch("PIN_LUU_TRU");
    return data.map((e) => e.toDeviceModel()).toList();
  }
}

Future<List<CategoryModel>> loadAllCategories() async {
  final repo = DeviceRepository();

  final results = await Future.wait([
    repo.getPanels(), // TAM_PIN
    repo.getInverters(), // BIEN_TAN
    repo.getBatteries(), // PIN_LUU_TRU
  ]);

  final panels = results[0];
  final inverters = results[1];
  final batteries = results[2];

  return [
    CategoryModel(
      id: 1,
      categoryName: 'Tấm quang năng',
      categoryIcon: 'assets/images/ja.png',
      categoryDes: 'Các tấm pin chất lượng cao, hiệu suất tối ưu.',
      products: panels,
    ),
    CategoryModel(
      id: 2,
      categoryName: 'Biến tần',
      categoryIcon: 'assets/images/soliss.png',
      categoryDes: 'Biến tần công nghệ mới, bền bỉ.',
      products: inverters,
    ),
    CategoryModel(
      id: 3,
      categoryName: 'Pin Lithium',
      categoryIcon: 'assets/images/dyness.png',
      categoryDes: 'Pin lưu trữ hiện đại, an toàn, tuổi thọ cao.',
      products: batteries,
    ),
  ];
}

Future<CategoryModel> loadCategoryById(int id) async {
  final repo = DeviceRepository();

  switch (id) {
    case 1:
      return CategoryModel(
        id: 1,
        categoryName: 'Tấm quang năng',
        categoryIcon: 'assets/images/ja.png',
        categoryDes: 'Các tấm pin chất lượng cao, hiệu suất tối ưu.',
        products: await repo.getPanels(),
      );

    case 2:
      return CategoryModel(
        id: 2,
        categoryName: 'Biến tần',
        categoryIcon: 'assets/images/soliss.png',
        categoryDes: 'Biến tần công nghệ mới, bền bỉ.',
        products: await repo.getInverters(),
      );

    case 3:
      return CategoryModel(
        id: 3,
        categoryName: 'Pin Lithium',
        categoryIcon: 'assets/images/dyness.png',
        categoryDes: 'Pin lưu trữ hiện đại, an toàn, tuổi thọ cao.',
        products: await repo.getBatteries(),
      );

    default:
      return CategoryModel(
        id: 0,
        categoryName: 'Danh mục khác',
        categoryIcon: 'assets/icons/default.png',
        categoryDes: 'Các thiết bị khác.',
        products: [],
      );
  }
}
