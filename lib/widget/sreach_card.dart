import 'package:flutter/material.dart';

import '../theme.dart';
import '../util/dimensions.dart';
import '../views/screen/dashboard/cari_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: size.height * 0.090,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: bg2Color,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CariScreen(),
                    ),
                  );
                },
                child: Container(
                  height: size.height * 0.070,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      // aksi yang ingin dilakukan ketika tombol ditekan
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CariScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Pencarian',
                              style: primaryTextStyle.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE,
                                color: bg2Color,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CariScreen(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.search,
                              color: bg2Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
