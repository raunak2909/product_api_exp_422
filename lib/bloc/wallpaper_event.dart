abstract class WallpaperEvent{}

class GetTrendingWallpaperEvent extends WallpaperEvent{}
class GetSearchWallpaperEvent extends WallpaperEvent{
  String query;
  GetSearchWallpaperEvent({required this.query});
}

