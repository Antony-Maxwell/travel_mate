
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_mate/Services/notifi_service.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';
import 'package:travel_mate/provider/navigation_Provider.dart';
import 'package:travel_mate/provider/providerClass.dart';
import 'package:travel_mate/screens/sideMenuScreens/aboutUs.dart';
import 'package:travel_mate/widgets/adminWidgets/adminMain.dart';
import 'package:travel_mate/screens/bottom_menu_screens/createTrips.dart';
import 'package:travel_mate/authenthication/login.dart';
import 'package:travel_mate/authenthication/signUp.dart';
import 'package:travel_mate/authenthication/splashScreen.dart';
import 'package:travel_mate/screens/bottom_menu_screens/user_home.dart';
import 'package:travel_mate/widgets/homePageWidgets/homeBottomBar.dart';
import 'package:travel_mate/widgets/placeAssigns.dart';
import 'package:timezone/data/latest.dart' as tz;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  
  Hive
    ..registerAdapter(UserAdapter())
    ..registerAdapter(UsersavedLocationAdapter())
    ..registerAdapter(PlaceListAdapter())
    // ..registerAdapter(uploadedDetailsAdapter());
    ..registerAdapter(UserPlannedTripsAdapter())
    ..registerAdapter(BestPlacesAdapter())
    ..registerAdapter(MostVisitedAdapter())
    ..registerAdapter(FavouriteAdapter())
    ..registerAdapter(NewAddedAdapter())
    ..registerAdapter(FamousAdapter())
    ..registerAdapter(HiddenAdapter())
    ..registerAdapter(PlaceStatusAdapter())
    ..registerAdapter(TransactionsAdapter())
    ..registerAdapter(CommentsAdapter());

  
  await Hive.openBox<UsersavedLocation>('locations');
  await Hive.openBox<User>('users'); // Open the box for User
  await Hive.openBox<PlaceList>('places');
  await Hive.openBox<UserPlannedTrips>('plannedTrips');
  await Hive.openBox<BestPlaces>('bestPlace');
  await Hive.openBox<MostVisited>('mostVisited');
  await Hive.openBox<Favourite>('favourite');
  await Hive.openBox<NewAdded>('newAdded');
  await Hive.openBox<Famous>('famous');
  await Hive.openBox<Hidden>('hidden');
  await Hive.openBox<Comments>('comments');

  await initializePlaceData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => TripStateNotifier()),
      ],
      child: MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splashScreen',
        routes: {
          '/splashScreen' : (context) => splashScreen(),
          '/signUp': (context) => signUp(),
          '/login': (context) => LoginScreen(),
          '/userMain': (context) => userMain(),
          '/adminMain' :(context) => adminMain(),
          '/bottomMenu' :(context) => homeBottomBar(),
          '/createTrips' :(context) => createTrips(),
          '/aboutUs' : (context) => AboutUsScreen(),
        },
      ),
    );
  }
}
