import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DanhMucThietBiVaVatTu extends StatefulWidget {
  const DanhMucThietBiVaVatTu({super.key});

  @override
  State<DanhMucThietBiVaVatTu> createState() => _DanhMucThietBiVaVatTuState();
}

class _DanhMucThietBiVaVatTuState extends State<DanhMucThietBiVaVatTu> {
  // demo selections
  final List<String> _selectedTags = ['Hy-Brid', 'Một pha'];

  // segmented choice
  bool _apMai = true;

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
                  fontWeight: FontWeight.w600, // tương đương 590
                  fontStyle:
                      FontStyle.normal, // Semibold = normal style + weight 600
                  fontSize: 18,
                  height: 28 / 18, // line-height 28px
                  letterSpacing: 0, // letter-spacing: 0px
                  color: Color(0xFF4F4F4F), // Gray G5
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
                children: const [
                  _OptionCard(title: 'Tấm quang năng'),
                  SizedBox(height: 12),
                  _OptionCard(title: 'Biến tần'),
                  SizedBox(height: 12),
                  _OptionCard(title: 'Pin lưu trữ'),
                  SizedBox(height: 12),
                  _OptionCard(title: 'Hình thức lắp đặt'),
                ],
              ),

              const SizedBox(height: 16),

              // Áp mái / Khung sắt
              Row(
                children: [
                  Expanded(
                    child: _SegmentPill(
                      label: 'Áp mái',
                      selected: _apMai,
                      onTap: () => setState(() => _apMai = true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _SegmentPill(
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
      width: 60,
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

class _OptionCard extends StatelessWidget {
  const _OptionCard({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x42D1D1D1), // 26%
            offset: Offset(0, 15),
            blurRadius: 34,
          ),
          BoxShadow(
            color: Color(0x36D1D1D1), // 21%
            offset: Offset(0, 61),
            blurRadius: 61,
          ),
          BoxShadow(
            color: Color(0x24D1D1D1), // 14%
            offset: Offset(0, 137),
            blurRadius: 82,
          ),
          BoxShadow(
            color: Color(0x14D1D1D1), // 08~10%
            offset: Offset(0, 244),
            blurRadius: 98,
          ),
          BoxShadow(
            color: Color(0x00D1D1D1), // 0%
            offset: Offset(0, 382),
            blurRadius: 107,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w400, // Regular
                fontStyle: FontStyle.normal,
                fontSize: 16,
                height: 24 / 16, // line-height 24px
                letterSpacing: 0, // letter-spacing: 0px
                color: Color(0xFF4F4F4F), // Gray-700
              ),
            ),
          ),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24,
            color: Color(0xFF8E8E93),
          ),
        ],
      ),
    );
  }
}

class _SegmentPill extends StatelessWidget {
  const _SegmentPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 191,
        height: 56,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE6E6E6) : Colors.white, // BG
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? const Color(0xFFDBEBDD)
                : const Color.fromARGB(255, 250, 250, 250),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x42D1D1D1),
              offset: Offset(0, 15),
              blurRadius: 34,
            ),
            BoxShadow(
              color: Color(0x36D1D1D1),
              offset: Offset(0, 61),
              blurRadius: 61,
            ),
            BoxShadow(
              color: Color(0x24D1D1D1),
              offset: Offset(0, 137),
              blurRadius: 82,
            ),
            BoxShadow(
              color: Color(0x14D1D1D1),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // justify-content
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'SF Pro',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                height: 24 / 16,
                color: Color(0xFF4F4F4F),
              ),
            ),
            // chấm trạng thái
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
                border: Border.all(
                  color: const Color.fromARGB(255, 250, 248, 248),
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFF34C759)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? const Color(0xFF34C759)
                          : const Color(0xFFDBEBDD),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
