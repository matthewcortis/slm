import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/quote/step_progress.dart';
import './combo_selection_fragment.dart';
import './equipment_selection_fragment.dart'; // chứa DanhMucScreen
// import './product_list_screen.dart'; // giả định bạn tách file

class TaoBaoGiaScreen extends StatefulWidget {
  const TaoBaoGiaScreen({super.key});

  @override
  State<TaoBaoGiaScreen> createState() => _TaoBaoGiaScreenState();
}

class _TaoBaoGiaScreenState extends State<TaoBaoGiaScreen> {
  int _step = 1; // 1: chọn combo, 2: chọn loại (Hy-Brid/On-grid), 3: danh mục
  bool _hasSelection = false;
  Map<String, dynamic>? _selectedCombo;

  String? _selectedType; // 'Hy-Brid' | 'On-grid'
  bool _hasType = false; // có sản phẩm thuộc loại đang chọn

  void _handleSelectionChanged(bool hasSelection, Map<String, dynamic>? combo) {
    setState(() {
      _hasSelection = hasSelection;
      _selectedCombo = combo;
      _selectedType = null;
      _hasType = false;
    });
  }

  // nhận từ ProductListScreen khi user đổi tab loại
  void _onTypeSelected(String type, bool hasAny) {
    setState(() {
      _selectedType = hasAny ? type : null;
      _hasType = hasAny;
    });
  }

  void _goNext() {
    switch (_step) {
      case 1:
        if (_hasSelection && _selectedCombo != null) {
          final list = (_selectedCombo?['products'] as List?) ?? [];
          if (list.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Combo chưa có sản phẩm. Vui lòng chọn combo khác.',
                ),
              ),
            );
            return;
          }
          final hasHybrid = list.any((e) => e['type'] == 'Hy-Brid');
          final hasOnGrid = list.any((e) => e['type'] == 'On-grid');

          setState(() {
            _selectedType = hasHybrid
                ? 'Hy-Brid'
                : (hasOnGrid ? 'On-grid' : null);
            _hasType = _selectedType != null;
            _step = 2;
          });
        }
        break;
      case 2:
        if (_selectedType != null && _hasType) {
          setState(() => _step = 3);
        }
        break;
      case 3:
        // sang màn danh mục/thiết bị
        _submitQuote(); // không push DanhMucScreen lần nữa
        break;
    }
  }

  void _submitQuote() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã tạo báo giá')));
  }

  void _handleBack() {
    if (_step > 1) {
      setState(() => _step -= 1);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // tính CTA theo bước
    final String ctaLabel = _step == 3 ? 'Tạo báo giá' : 'Tiếp tục';
    final bool ctaEnabled = switch (_step) {
      1 => _hasSelection && _selectedCombo != null,
      2 => _selectedType != null && _hasType,
      _ => true,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // HEADER
              Container(
                height: 48.w,
                margin: EdgeInsets.only(bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16.w),
                      child: _CircleButton(
                        size: 48.w,
                        onTap: _handleBack,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 18.w,
                          color: const Color(0xFFFF3B30),
                        ),
                      ),
                    ),
                    const Text(
                      'Tạo báo giá',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4F4F4F),
                      ),
                    ),
                    SizedBox(width: 48.w),
                  ],
                ),
              ),

              // STEP PROGRESS
              Container(
                margin: EdgeInsets.only(bottom: 8.h),
                child: StepProgressHeader(currentStep: _step),
              ),

              // NỘI DUNG
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 8.h),
                  child: _buildBody(),
                ),
              ),

              // CTA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 56.h,
                margin: EdgeInsets.only(top: 12.h, bottom: 12.h),
                child: PrimaryButton(
                  label: ctaLabel, // <-- dùng label tính ở trên
                  enabled: ctaEnabled,
                  onPressed: ctaEnabled ? _goNext : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_step == 1) {
      return ComboSelectionFragment(
        onSelectionChanged: _handleSelectionChanged,
      );
    }
    if (_step == 2) {
      return ProductListScreen(
        comboProducts: (_selectedCombo?['products'] as List?) ?? [],
        comboName: _selectedCombo?['text'] ?? '',
        onTypeSelected: _onTypeSelected, // <-- thêm callback
        initialIsHybrid: _selectedType == 'Hy-Brid',
      );
    }

    return const DanhMucScreen();
  }
}

// Button tròn tái sử dụng
class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.size,
    required this.onTap,
    required this.child,
  });

  final double size;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
