class Event {
  final String imagePath;
  final String title;
  final String description;
  final String location;
  final String duration;
  final String punchline1;
  final String punchline2;
  final List<int> categoryIds;
  final List<String> galleryImages;

  const Event({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.punchline1,
    required this.punchline2,
    required this.categoryIds,
    this.galleryImages = const [],
  });
  
}


final fiveKmRunEvent = Event(
  imagePath: 'assets/images/5km01.jpg',
  title: 'Sunrise 5K Challenge',
  description:
      'Join a community run through the city park with hydration stations and post-run snacks.',
  location: 'Green Park, Downtown',
  duration: '2h',
  punchline1: 'Run together, finish stronger.',
  punchline2: 'Open for all fitness levels.',
  categoryIds: [0, 2],
  galleryImages: const [
    'assets/images/5km01.jpg',
    'assets/images/5km02.jpg',
    'assets/images/5km03.jpg',
  ],
);

final cookingEvent = Event(
  imagePath: 'assets/images/cooking01.jpg',
  title: 'Weekend Cooking Workshop',
  description:
      'A hands-on cooking class where you will prepare two signature dishes with a local chef.',
  location: 'Taste Studio Kitchen',
  duration: '3h',
  punchline1: 'Chop, stir, and serve like a pro.',
  punchline2: 'Ingredients and tools provided.',
  categoryIds: [0, 4],
  galleryImages: const [
    'assets/images/cooking01.jpg',
    'assets/images/cooking02.jpg',
    'assets/images/cooking03.jpg',
  ],
);

final musicConcert = Event(
  imagePath: 'assets/images/concert01.jpg',
  title: 'Live Music Night',
  description:
      'Experience an energetic live concert featuring indie bands and guest performers.',
  location: 'City Arena Hall',
  duration: '4h',
  punchline1: 'Feel the rhythm all night.',
  punchline2: 'Doors open at 6:00 PM.',
  categoryIds: [0, 1],
  galleryImages: const [
    'assets/images/concert01.jpg',
    'assets/images/concert02.jpg',
    'assets/images/concert03.jpg',
    'assets/images/concert04.jpg',
  ],
);

final golfCompetition = Event(
  imagePath: 'assets/images/golf01.jpg',
  title: 'Amateur Golf Cup',
  description:
      'Compete in a friendly 18-hole tournament with prizes for top performers.',
  location: 'Lakeside Golf Club',
  duration: '5h',
  punchline1: 'Perfect your swing under pressure.',
  punchline2: 'Register early, limited slots.',
  categoryIds: [0, 3],
  galleryImages: const [
    'assets/images/golf01.jpg',
    'assets/images/golf02.jpg',
    'assets/images/golf03.jpg',
  ],
);

final events = [fiveKmRunEvent, cookingEvent, musicConcert, golfCompetition];

// Keeps compatibility if other files still reference `event`.
final event = events;
