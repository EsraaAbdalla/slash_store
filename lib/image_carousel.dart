// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:slash_store/component/dot_indicator.dart';
import 'package:slash_store/component/hide_button.dart';

class ImageCarousel extends StatefulWidget {
  final List<dynamic> imagePaths;
  final String name;
  final String brandName;
  final String des;
  final int id; // Added id property
  final List<int> prices;
  final String brandLogo;

  const ImageCarousel(
      {super.key,
      required this.imagePaths,
      required this.name,
      required this.des,
      required this.id,
      required this.prices,
      required this.brandLogo,
      required this.brandName});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final CarouselController _carouselController = CarouselController();

  int _currentPageIndex = 0;
  // Add a function to show the bottom sheet
  void _showBottomSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(30.0), // Adjust the radius as needed
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.des,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Image.network(
                      widget.brandLogo,
                      width: 50,
                      height: 50,
                    ),
                  ],
                ),
              ),
              const HideButton(),
              // SliderButton(
              //   action: () {
              //     // Action to close the bottom sheet
              //     Navigator.pop(context);
              //   },
              //   label: const Text(
              //     'cancel Description',
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //         color: Color(0xff4a4a4a),
              //         fontWeight: FontWeight.w500,
              //         fontSize: 17),
              //   ),
              //   icon: null,
              //   buttonColor: Colors.transparent,
              // ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Product details', // Your title here
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: 300.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false, // Disable infinite scrolling
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              viewportFraction: 0.4,
              onPageChanged: (index, reason) {
                // Update the current page when the page changes
                _currentPageIndex = index % widget.imagePaths.length;
                setState(() {});
              },
            ),
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                width: double.infinity, // Set a specific width
                height: 300.0, // Set a specific height
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        16.0), // Set circular border radius
                    child: Image.network(
                      widget.imagePaths[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Small Images Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => GestureDetector(
                onTap: () {
                  _carouselController.animateToPage(index);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: _currentPageIndex == index
                          ? Colors.yellow
                          : Colors.transparent,
                      width: 2,
                    ),
                    // shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(widget.imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.name,
                  maxLines: 2, // Limit to 2 lines
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set text color to white

                    overflow: TextOverflow
                        .ellipsis, // Show ellipsis (...) for overflow
                  ),
                ),
                Image.network(
                  widget.brandLogo,
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'EGP ${widget.prices.join(", ")}',
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white,
                    // Limit to 2 lines
                    overflow: TextOverflow
                        .ellipsis, // Show ellipsis (...) for overflow // Set text color to white
                  ),
                ),
                Text(
                  widget.brandName,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 20,
                    // fontWeight: FontWeight.bold,
                    color: Colors.white, //Set text color to white
                    // Limit to 2 lines
                    overflow: TextOverflow
                        .ellipsis, // Show ellipsis (...) for overflow
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imagePaths.length,
              (index) => DotIndicator(
                index: index,
                isSelected: _currentPageIndex == index,
                onTap: () {
                  _carouselController.animateToPage(index);
                },
              ),
            ),
          ),
          const Spacer(),
          // Add a button to trigger the bottom sheet
          Container(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _showBottomSheet();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(105, 104, 104, 1),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        _showBottomSheet();
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                        size: 20,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
