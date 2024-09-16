// import 'package:apps/theme.dart';
// import 'package:flutter/material.dart';

// import '../../../../util/dimensions.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({
//     super.key,
//     required this.size,
//   });

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         Container(
//           width: double.infinity,
//           height: size.height * 0.090,
//           color: Theme.of(context).splashColor,
//         ),
//         Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: size.width * 0.8,
//                 height: size.height * 0.055,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(40),
//                 ),
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   onTap: () {
//                     // aksi yang ingin dilakukan ketika tombol ditekan
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Pencarian',
//                           style: primaryTextStyle.copyWith(
//                             fontSize: Dimensions.FONT_SIZE_LARGE,
//                             color: Theme.of(context).splashColor,
//                           ),
//                         ),
//                         Icon(
//                           Icons.search,
//                           color: Theme.of(context).splashColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 3),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const CartScreen(),
//                     ),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.white,
//                   child: Icon(
//                     Icons.notifications,
//                     color: Theme.of(context).splashColor,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
