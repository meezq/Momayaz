class Category {
  final String categoryImage;
  final String categoryName;
  final String categoryId;

  final String carCategoryImage;
  final String carCategoryName;
  final String carCategoryId;

  Category({
    required this.categoryImage,
    required this.categoryName,
    required this.categoryId,
     this.carCategoryImage = "",
     this.carCategoryName = "",
     this.carCategoryId = "",
  });
}
