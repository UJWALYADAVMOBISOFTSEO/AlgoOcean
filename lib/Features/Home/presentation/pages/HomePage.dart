import 'package:algoocean/Features/Home/data/model/HomeModal.dart';
import 'package:algoocean/Features/Home/presentation/bloc/home_bloc.dart';
import 'package:algoocean/Global/colors.dart';
import 'package:algoocean/Screens/CartPage.dart';
import 'package:algoocean/Screens/Historypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../CommonWidgets/CustomButton.dart';
import '../../../../CommonWidgets/image_helper.dart';
import '../../../../core/utils/progress_loader.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeBloc _dataBloc = HomeBloc();
  HomeModal _modal = HomeModal();
  bool isLoading = false;
  List<String> imageUrls = []; // List to store image URLs locally

  @override
  void initState() {
    _dataBloc.add(const HomeData());
    _loadImagesLocally(); // Load stored images on initialization
    super.initState();
  }

  // Load stored images from SharedPreferences
  Future<void> _loadImagesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final storedImages = prefs.getStringList('imageUrls') ?? [];
    setState(() {
      imageUrls = storedImages;
    });
  }

  // Save image URL to SharedPreferences
  Future<void> _saveImageLocally(String imageUrl) async {
    final prefs = await SharedPreferences.getInstance();
    imageUrls.remove(imageUrl);
    imageUrls.add(imageUrl);
    prefs.setStringList('imageUrls', imageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        ///This Is To Remove StatusBar Color
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY,
          centerTitle: true,
          title: Text(
            'Algo-ocean',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.history,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()));
              },
            ),
          ],
        ),
        body: _buildhome(context),
      ),
    ));
  }

  Widget _buildhome(BuildContext context) => BlocConsumer(
      bloc: _dataBloc,
      builder: (context, state) =>
          (isLoading == false) ? _homeLayout(context) : _loadingState(context),
      listener: _listenStateHome);

  void _listenStateHome(BuildContext context, HomeState state) {
    if (state is HomeLoading) {
      showProgressDialog(context);
      isLoading = true;
    }
    if (state is HomeSuccess) {
      hideProgressDialog(context);
      _modal = state.homeModal;
      isLoading = false;
      _saveImageLocally(_modal.message ?? '');
    }
    if (state is HomeError) {
      hideProgressDialog(context);
      isLoading = false;
    }
  }

  Widget _homeLayout(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 400,
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: PRIMARY, width: 2),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: ImageHelper(
                image: _modal.message ?? '',
                imageType: ImageType.network,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: 'Fetch Data',
                  ontap: () {
                    _saveImageLocally(_modal.message ?? '');
                    _dataBloc.add(const HomeData());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _loadingState(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, PRIMARY]),
      ),
    );
  }
}
