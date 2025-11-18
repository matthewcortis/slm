import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../equipment/card_item_option.dart';
import '../equipment/card_item_device.dart';
import '../bottomsheet/bottomsheet_select.dart';

class DanhMucThietBiVaVatTu extends StatefulWidget {
  final String? selectedType; // 'Hy-Brid' hoặc 'On-grid'
  final String? selectedPhase; // '1', '3', ...

  const DanhMucThietBiVaVatTu({
    super.key,
    this.selectedType,
    this.selectedPhase,
  });

  @override
  State<DanhMucThietBiVaVatTu> createState() => _DanhMucThietBiVaVatTuState();
}

class _DanhMucThietBiVaVatTuState extends State<DanhMucThietBiVaVatTu> {
  // segmented choice
  bool _apMai = true;
  List<String> get _selectedTags {
    final tags = <String>[];

    if (widget.selectedType != null && widget.selectedType!.isNotEmpty) {
      tags.add(widget.selectedType!); // Hy-Brid / On-grid
    }

    final phase = widget.selectedPhase;
    if (phase != null && phase.isNotEmpty) {
      // Map phase "1" -> "Một pha", còn lại -> "Ba pha"
      final phaseLabel = phase == '1' ? 'Một pha' : 'Ba pha';
      tags.add(phaseLabel);
    }

    return tags;
  }

  void _openProductBottomSheet(
    BuildContext context, {
    required String categoryLabel,
  }) {
    showSelectProductBottomSheet(
      context,
      type: widget.selectedType, // ← nhận từ constructor
      phase: widget.selectedPhase, // ← nhận từ constructor
      categoryLabel: categoryLabel, // ← nhận từ OptionCard
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF8F8F8), // BG1
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tiêu đề
              Text(
                'Danh mục thiết bị và vật tư',
                style: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 18,
                  height: 28 / 18,
                  letterSpacing: 0,
                  color: Color(0xFF4F4F4F),
                ),
              ),

              const SizedBox(height: 12),

              // Dòng "Đã chọn" + tags
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Đã chọn:',
                    style: TextStyle(
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      height: 20 / 14,
                      color: Color(0xFF848484), // G4
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedTags
                          .map((t) => _TagChip(label: t))
                          .toList(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Khối 4 lựa chọn
              Column(
                children: [
                  OptionCard(
                    title: 'Tấm quang năng',
                    items: [
                      SolarMaxCartCard(
                        image: AssetImage('assets/images/product.png'),
                        title: 'Tủ điện NLMT SolarMax',
                        modeTag: 'Hy-Brid',
                        congSuat: '1 pha',
                        chiSoIp: 'IP66',
                        khoiLuong: '24 kg',
                        baoHanh: '05 năm',
                        priceText: '9.999.999đ',
                        quantity: 1,
                        onIncrease: () {},
                        onDecrease: () {},
                      ),
                    ],
                    onChange: () {
                      _openProductBottomSheet(
                        context,
                        categoryLabel: 'Tấm quang năng',
                      );
                    },
                  ),
                  SizedBox(height: 12),
                  OptionCard(title: 'Biến tần'),
                  SizedBox(height: 12),
                  OptionCard(title: 'Pin lưu trữ'),
                  SizedBox(height: 12),
                  OptionCard(title: 'Hình thức lắp đặt'),
                ],
              ),

              const SizedBox(height: 16),

              // Áp mái / Khung sắt
              Row(
                children: [
                  Expanded(
                    child: SegmentPill(
                      label: 'Áp mái',
                      selected: _apMai,
                      onTap: () => setState(() => _apMai = true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SegmentPill(
                      label: 'Khung sắt',
                      selected: !_apMai,
                      onTap: () => setState(() => _apMai = false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AnimatedSize(
                alignment: Alignment.topCenter, // Mở từ trên xuống
                clipBehavior: Clip.none,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: _apMai
                    ? const SizedBox.shrink()
                    : const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: _GiaKhungSatFrame(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0x33B5B5B5), // Gray G3, 20% opacity
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(color: const Color(0xFFF3F3F3)), // Gray G1
        // Hiệu ứng "glass" nhẹ
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 2,
            spreadRadius: -1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'SF Pro',
            fontWeight: FontWeight.w400,
            fontSize: 12,
            height: 18 / 12,
            color: Color(0xFF4F4F4F), // Gray G5
          ),
        ),
      ),
    );
  }
}

class _GiaKhungSatFrame extends StatelessWidget {
  const _GiaKhungSatFrame();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 398),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _LabeledField(
              label: 'Giá bán khung sắt',
              hint: 'Nhập giá bán khung sắt',
            ),
            SizedBox(height: 12),
            _LabeledField(
              label: 'Giá nhân công khung sắt',
              hint: 'Nhập giá Nhân công khung sắt',
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 76, // 20 label + 8 gap + 48 field
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 20 / 14,
              color: Color(0xFF4F4F4F),
            ),
          ),
          const SizedBox(height: 8),
          // field full width theo cha, vẫn giới hạn maxWidth=398 nhờ ConstrainedBox phía trên
          Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x26D1D1D1),
                  offset: Offset(0, 15),
                  blurRadius: 34,
                ),
                BoxShadow(
                  color: Color(0x21D1D1D1),
                  offset: Offset(0, 61),
                  blurRadius: 61,
                ),
                BoxShadow(
                  color: Color(0x14D1D1D1),
                  offset: Offset(0, 137),
                  blurRadius: 82,
                ),
                BoxShadow(
                  color: Color(0x0DD1D1D1),
                  offset: Offset(0, 244),
                  blurRadius: 98,
                ),
                BoxShadow(
                  color: Color(0x00D1D1D1),
                  offset: Offset(0, 382),
                  blurRadius: 107,
                ),
              ],
            ),
            child: TextFormField(
              keyboardType: TextInputType.number, // hiển thị bàn phím số
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // chỉ cho nhập số
              ],
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400, // Regular
                  fontSize: 16,
                  height: 24 / 16,
                  letterSpacing: 0,
                  color: Color(0xFF848484), // Gray-G4
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
