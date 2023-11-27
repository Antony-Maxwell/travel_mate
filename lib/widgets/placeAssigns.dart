import 'package:hive_flutter/hive_flutter.dart';
import 'package:travel_mate/db/functions/functions/db_functions.dart';
import 'package:travel_mate/db/functions/model/category_data_model.dart';
import 'package:travel_mate/db/functions/model/data_model.dart';

Future<void> initializePlaceData() async {
  final placeBox = await Hive.openBox<PlaceList>('places');

  if (placeBox.isEmpty) {
    final hardcodedPlaces = [
      PlaceList(
        placeName: 'Kashmir',
        description:
            'Kashmir is a region in South Asia known for its stunning natural beauty, including picturesque landscapes of mountains, valleys, and lakes. It has been a longstanding source of territorial dispute between India, Pakistan, and China. The region is home to a diverse population and has a rich cultural heritage, with a significant Muslim majority. The Kashmir conflict has led to ongoing tensions and periodic violence in the region for decades.',
        imageUrl: 'assets/images/kashmir.jpg',
      ),
      PlaceList(
        placeName: 'Kodaikanal',
        description:
            'Kodaikanal is a popular hill station located in the Indian state of Tamil Nadu. It is renowned for its cool climate, lush greenery, and scenic beauty, including a picturesque lake, forests, and misty hills. Kodaikanal is a favored tourist destination known for its pleasant weather, trekking opportunities, and various attractions, making it a serene retreat in the Western Ghats of South India.',
        imageUrl: 'assets/images/kodaikanal.jpg',
      ),
      PlaceList(
        placeName: 'Manali',
        description:
            'Manali: A picturesque hill station in Himachal Pradesh, India, nestled in the Himalayas, celebrated for its breathtaking landscapes, adventure sports, and vibrant markets, making it a popular tourist destination year-round.',
        imageUrl: 'assets/images/manali.jpg',
      ),
      PlaceList(
        placeName: 'Munnar',
        description:
            'Munnar: A serene hill station in Kerala, India, known for its tea plantations, misty hills, and lush greenery, offering a tranquil escape into nature.',
        imageUrl: 'assets/images/munnar.jpg',
      ),
      PlaceList(
        placeName: 'Ooty',
        description:
            'Ooty (Ootacamund): Another South Indian hill station located in Tamil Nadu, celebrated for its pleasant climate, botanical gardens, and beautiful Nilgiri hills.',
        imageUrl: 'assets/images/ooty.jpg',
      ),
      PlaceList(
        placeName: 'tajMahal',
        description:
            'Taj Mahal: A world-famous monument in Agra, India, regarded as an architectural masterpiece and symbol of love, built by Emperor Shah Jahan in memory of his wife Mumtaz Mahal.',
        imageUrl: 'assets/images/tajMahal.jpg',
      ),
      // Add more places as needed
    ];

    final allUploadedPlaces = await getAllUploadedPlaces();
    final allPlaces = [...hardcodedPlaces, ...allUploadedPlaces];

    await placeBox.addAll(allPlaces);
  }

  

  final bestBox = await Hive.openBox<BestPlaces>('bestPlace');
  if (bestBox.isEmpty) {
    final bestplaces = [
      BestPlaces(
        placeName: 'Aurangabad, India',
        description:
            'Apart from its proximity to Ajanta and Ellora Caves, Aurangabad is known for Bibi Ka Maqbara, a tomb resembling the Taj Mahal.',
        imageUrl: 'assets/images/aurangabad.jpg',
      ),
      BestPlaces(
        placeName: 'Darjeeling, India',
        description:
            'Known for its tea plantations, Darjeeling offers breathtaking views of the Himalayas. The Darjeeling Himalayan Railway, a UNESCO World Heritage Site, is a popular attraction.',
        imageUrl: 'assets/images/darjeeling.jpg',
      ),
      BestPlaces(
        placeName: 'Delhi, India',
        description:
            "India's capital, Delhi, is a blend of history and modernity. Visit historic sites like the Red Fort and Qutub Minar, as well as explore bustling markets and contemporary culture.",
        imageUrl: 'assets/images/delhi.jpg',
      ),
      BestPlaces(
        placeName: 'Goa, India',
        description:
            'Known for its beautiful beaches and vibrant nightlife, Goa is a popular tourist destination. Visitors can enjoy water sports, explore colonial architecture, and savor delicious seafood.',
        imageUrl: 'assets/images/goa.jpg',
      ),
      BestPlaces(
        placeName: 'Hampi, India',
        description:
            " Hampi is a UNESCO World Heritage Site, known for its fascinating ruins of the Vijayanagara Empire, intricate architecture, and boulder-strewn landscape.",
        imageUrl: 'assets/images/hampi.jpg',
      ),
      BestPlaces(
        placeName: 'HariharFort, India',
        description:
            "Harihar Fort is a historic hill fort in Maharashtra known for its challenging trek. The fort's rugged terrain and steep staircases offer a thrilling hiking experience.",
        imageUrl: 'assets/images/hariharfort6.jpg',
      ),
    ];
    await bestBox.addAll(bestplaces);
  }

  final mostVisitedBox = await Hive.openBox<MostVisited>('mostVisited');
  if (mostVisitedBox.isEmpty) {
    final mostVisitedPlaces = [
      MostVisited(
        placeName: 'Idukki, Kerala',
        description:
            "Idukki is known for its hilly terrain and is home to the Idukki Arch Dam, an engineering marvel. It offers panoramic views and is a great place for nature photography.",
        imageUrl: 'assets/images/idukki.jpg',
      ),
      MostVisited(
        placeName: 'Jaipur, India',
        description:
            " Known as the 'Pink City,' Jaipur is the capital of Rajasthan. It's famous for its historic palaces, forts, and vibrant markets. Amber Fort, Hawa Mahal, and City Palace are some of the must-visit attractions.",
        imageUrl: 'assets/images/jaipur.jpg',
      ),
      MostVisited(
        placeName: 'Jaisalmer, India',
        description:
            "Jaisalmer is famous for its 'Golden Fort,' a massive sandstone fortress, and its desert culture, including camel safaris in the Thar Desert.",
        imageUrl: 'assets/images/jaisalmer.jpg',
      ),
      MostVisited(
        placeName: 'Alappuzha, Kerala',
        description:
            "Kerala's backwaters are a network of interconnected rivers, lakes, and canals. Houseboat cruises through the backwaters offer a tranquil and picturesque experience of Kerala's natural beauty.",
        imageUrl: 'assets/images/keralabackwater.jpg',
      ),
      MostVisited(
        placeName: 'Kolkata, India',
        description:
            "The cultural capital of India, Kolkata offers a rich history, literary heritage, and vibrant arts scene. Victoria Memorial and Howrah Bridge are iconic landmarks.",
        imageUrl: 'assets/images/kolkata.jpg',
      ),
      MostVisited(
        placeName: 'Khajuraho, Madhya Pradesh',
        description:
            "Khajuraho is famous for its group of stunning temples adorned with intricate and erotic sculptures, representing a fusion of art and spirituality.",
        imageUrl: 'assets/images/madhyapradhesh.jpg',
      ),
    ];
    await mostVisitedBox.addAll(mostVisitedPlaces);
  }

  final favouriteBox = await Hive.openBox<Favourite>('favourite');
  if (favouriteBox.isEmpty) {
    final favouritePlaces = [
      Favourite(
        placeName: 'Mahabeleswar, India',
        description:
            " is a popular hill station located in the Western Ghats of Maharashtra, India. It is known for its stunning natural beauty, cool climate, and lush green landscapes.",
        imageUrl: 'assets/images/mahabeleshwar.jpg',
      ),
      Favourite(
        placeName: 'Mamallapuram (Mahabalipuram), Tamil Nadu',
        description:
            "Mamallapuram is known for its rock-cut temples, including the famous Shore Temple, and impressive stone carvings.",
        imageUrl: 'assets/images/mallapuram.jpg',
      ),
      Favourite(
        placeName: 'Mumbai, India',
        description:
            "Mumbai is India's financial and entertainment hub. It offers a mix of historic landmarks, bustling markets, and a vibrant nightlife. Don't miss the Gateway of India and Marine Drive.",
        imageUrl: 'assets/images/mumbai.jpg',
      ),
      Favourite(
        placeName: 'Mysore, Karnataka',
        description:
            "Mysore is famous for its grand Mysore Palace, a beautiful example of Indo-Saracenic architecture. The city is also known for its cultural heritage and silk production.",
        imageUrl: 'assets/images/mysore.jpg',
      ),
      Favourite(
        placeName: 'Pondicherry, ',
        description:
            " Pondicherry, a former French colony, boasts colonial architecture, beautiful beaches, and a serene ambiance.",
        imageUrl: 'assets/images/pondichery.jpg',
      ),
      Favourite(
        placeName: 'Ponmudi, India',
        description:
            " Ponmudi is a hill station near Thiruvananthapuram, known for its lush green hills, meandering streams, and trekking trails. It's an ideal spot for a day trip or a short getaway.",
        imageUrl: 'assets/images/ponmudi.jpg',
      ),
    ];
    await favouriteBox.addAll(favouritePlaces);
  }

  final newAddedBox = await Hive.openBox<NewAdded>('newAdded');
  if (newAddedBox.isEmpty) {
    final newAddedplaces = [
      NewAdded(
        placeName: 'Punjab, India',
        description:
            'Punjab is a northern state in India known for its rich cultural heritage, history, and vibrant traditions.',
        imageUrl: 'assets/images/punjab.jpg',
      ),
      NewAdded(
        placeName: 'Surat, India',
        description:
            " This vast salt desert becomes a surreal, shimmering landscape during the Rann Utsav, a cultural festival. It's also home to unique wildlife.",
        imageUrl: 'assets/images/rann surat.jpg',
      ),
      NewAdded(
        placeName: 'Shimla, India',
        description:
            "Shimla, also known as the 'Queen of Hill Stations,' is a popular hill station in the Himalayas. It offers lush greenery, colonial architecture, and a pleasant climate.",
        imageUrl: 'assets/images/shimla.jpg',
      ),
      NewAdded(
        placeName: 'Thekkady, Kerala',
        description:
            "Thekkady is famous for the Periyar Wildlife Sanctuary, where you can enjoy boat rides and see a variety of wildlife. The surrounding hills and forests provide a serene setting for nature lovers.",
        imageUrl: 'assets/images/thekkady.jpg',
      ),
      NewAdded(
        placeName: 'Udaipur, India',
        description:
            "Udaipur, often called the 'City of Lakes,' is known for its beautiful lakes, palaces, and temples. The City Palace and Lake Pichola are popular attractions.",
        imageUrl: 'assets/images/udaipur.jpg',
      ),
      NewAdded(
        placeName: 'Vagamon, Kerala',
        description:
            "Vagamon is a lesser-known hill station in Kerala, offering lush meadows, pine forests, and pleasant weather. It's an excellent destination for outdoor activities and relaxation.",
        imageUrl: 'assets/images/vagamon.jpg',
      ),
    ];
    await newAddedBox.addAll(newAddedplaces);
  }

  final famousBox = await Hive.openBox<Famous>('famous');
  if (famousBox.isEmpty) {
    final famousPlaces = [
      Famous(
        placeName: 'Varanasi, India',
        description:
            "Varanasi, one of the oldest continuously inhabited cities in the world, is a spiritual center for Hindus. The city is famous for its ghats along the Ganges River, where rituals and ceremonies take place.",
        imageUrl: 'assets/images/varanasi.jpg',
      ),
      Famous(
        placeName: 'Tajmahal, India',
        description:
            "The Taj Mahal is an iconic white marble mausoleum known as a symbol of love. It was built by Emperor Shah Jahan in memory of his wife Mumtaz Mahal. This UNESCO World Heritage Site is admired for its intricate architecture and stunning beauty.",
        imageUrl: 'assets/images/tajMahal.jpg',
      ),
      Famous(
        placeName: 'Hampi, India',
        description:
            "Hampi is a UNESCO World Heritage Site, known for its fascinating ruins of the Vijayanagara Empire, intricate architecture, and boulder-strewn landscape.",
        imageUrl: 'assets/images/hampi.jpg',
      ),
      Famous(
        placeName: 'Jaipur, India',
        description:
            "Known as the 'Pink City,' Jaipur is the capital of Rajasthan. It's famous for its historic palaces, forts, and vibrant markets. Amber Fort, Hawa Mahal, and City Palace are some of the must-visit attractions.",
        imageUrl: 'assets/images/jaipur.jpg',
      ),
      Famous(
        placeName: 'Mysore, India',
        description:
            "Nestled in the Himalayas, Rishikesh is known for its serene ambiance and is a hub for yoga and spirituality. It's also a gateway to adventure sports like white-water rafting.",
        imageUrl: 'assets/images/mysore.jpg',
      ),
      Famous(
        placeName: 'Shimla, India',
        description:
            " Shimla, also known as the 'Queen of Hill Stations,' is a popular hill station in the Himalayas. It offers lush greenery, colonial architecture, and a pleasant climate.",
        imageUrl: 'assets/images/shimla.jpg',
      ),
    ];
    await famousBox.addAll(famousPlaces);
  }

  final hiddenBox = await Hive.openBox<Hidden>('hidden');
  if (hiddenBox.isEmpty) {
    final hiddenPlaces = [
      Hidden(
        placeName: 'Vagamon, Kerala',
        description:
            "Vagamon is a lesser-known hill station in Kerala, offering lush meadows, pine forests, and pleasant weather. It's an excellent destination for outdoor activities and relaxation.",
        imageUrl: 'assets/images/vagamon.jpg',
      ),
      Hidden(
        placeName: 'Ponmudi, Kerala',
        description:
            "Ponmudi is a hill station near Thiruvananthapuram, known for its lush green hills, meandering streams, and trekking trails. It's an ideal spot for a day trip or a short getaway.",
        imageUrl: 'assets/images/ponmudi.jpg',
      ),
      Hidden(
        placeName: 'Alappuzha, Kerala',
        description:
            "Kerala's backwaters are a network of interconnected rivers, lakes, and canals. Houseboat cruises through the backwaters offer a tranquil and picturesque experience of Kerala's natural beauty.",
        imageUrl: 'assets/images/keralabackwater.jpg',
      ),
      Hidden(
        placeName: 'Munnar, Kerala',
        description:
            " Munnar is one of Kerala's most famous hill stations, known for its expansive tea plantations, misty hills, and lush green landscapes. The town offers a tranquil escape into nature with opportunities for trekking and wildlife viewing.",
        imageUrl: 'assets/images/munnar.jpg',
      ),
      Hidden(
        placeName: 'Ooty, TamilNadu',
        description:
            " Ooty, another South Indian hill station located in Tamil Nadu, is celebrated for its pleasant climate, botanical gardens, and beautiful Nilgiri hills.",
        imageUrl: 'assets/images/ooty.jpg',
      ),
      Hidden(
        placeName: 'Kodaikanal, TamilNadu',
        description:
            "Kodaikanal is a popular hill station in Tamil Nadu, renowned for its cool climate, lush greenery, and scenic beauty, including a picturesque lake.",
        imageUrl: 'assets/images/kodaikanal.jpg',
      ),
    ];
    await hiddenBox.addAll(hiddenPlaces);
  }
  
}
