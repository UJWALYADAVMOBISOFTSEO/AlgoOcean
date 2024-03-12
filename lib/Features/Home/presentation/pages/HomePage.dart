import 'package:algoocean/Features/Home/data/model/HomeModal.dart';
import 'package:algoocean/Features/Home/presentation/bloc/home_bloc.dart';
import 'package:algoocean/Global/colors.dart';
import 'package:algoocean/Screens/Historypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  void initState() {
    _dataBloc.add(const HomeData());
    super.initState();
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
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HistoryPage()));
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                debugPrint('cart Button Clicked');
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  title: 'Fetch Data',
                  ontap: () {
                    _dataBloc.add(const HomeData());
                  },
                ),
                CustomButton(
                  title: 'Add To Cart',
                  ontap: () {
                    debugPrint('abc');
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