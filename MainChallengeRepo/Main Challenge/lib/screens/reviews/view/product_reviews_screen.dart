import 'package:flutter/material.dart';


class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
   State<ProductReviewsScreen> createState() => _ProductReviewsScreenState(); 
}
class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  // Sample data - In a real app, this would come from your data source
  late final ReviewStats stats = ReviewStats(
    averageRating: 4.6,
    totalReviews: 120,
    ratingDistribution: {
      5: 70,
      4: 30,
      3: 10,
      2: 5,
      1: 5,
    },
  );

  late final List<Review> reviews = [
    Review(
      userName: "Arman Rokni",
      userImage: "https://example.com/avatar1.jpg",
      rating: 4,
      comment: "A cool gray cap in soft cssorduro...",
      timeAgo: "36s ago",
    ),
    // Add more reviews as needed
  ];

  void _handleAddReview() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => AddReviewWidget(
        productName: "Product Name",
        productBrand: "Brand Name",
        productImage: "https://example.com/product.jpg",
        onSubmit: (Review review) {
          setState(() {
            reviews.insert(0, review);
            // Update stats accordingly
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: _ProductReviewWidget(
          stats: stats,
          reviews: reviews,
          onAddReview: _handleAddReview,
        ),
      ),
    );
  }
}

class ReviewStats {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;

  ReviewStats({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
  });
}

class Review {
  final String userName;
  final String userImage;
  final double rating;
  final String comment;
  final String timeAgo;

  Review({
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.comment,
    required this.timeAgo,
  });
}

class _ProductReviewWidget extends StatelessWidget {
  final ReviewStats stats;
  final List<Review> reviews;
  final VoidCallback onAddReview;

  const _ProductReviewWidget({
    Key? key,
    required this.stats,
    required this.reviews,
    required this.onAddReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReviewHeader(),
        _buildRatingDistribution(),
        _buildAddReviewButton(),
        const Divider(),
        _buildReviewsList(),
      ],
    );
  }

  Widget _buildReviewHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stats.averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Based on ${stats.totalReviews} Reviews',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: List.generate(
                5,
                (index) => Icon(
                  Icons.star,
                  color: index < stats.averageRating.floor()
                      ? Colors.amber
                      : Colors.grey.shade300,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingDistribution() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: List.generate(5, (index) {
          final starCount = 5 - index;
          final count = stats.ratingDistribution[starCount] ?? 0;
          final percentage = stats.totalReviews > 0
              ? (count / stats.totalReviews) * 100
              : 0.0;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                Text(
                  '$starCount Star',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: percentage / 100,
                      backgroundColor: Colors.grey.shade200,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.amber),
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAddReviewButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onAddReview,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Row(
            children: [
              Icon(Icons.add_circle_outline),
              SizedBox(width: 8),
              Text('Add Review'),
              Spacer(),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewsList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(review.userImage),
                    radius: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          review.userName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          review.timeAgo,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        Icons.star,
                        size: 16,
                        color: index < review.rating
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(review.comment),
            ],
          ),
        );
      },
    );
  }
}

// Add Review Form Widget
class AddReviewWidget extends StatefulWidget {
  final String productName;
  final String productBrand;
  final String productImage;
  final Function(Review) onSubmit;

  const AddReviewWidget({
    Key? key,
    required this.productName,
    required this.productBrand,
    required this.productImage,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<AddReviewWidget> createState() => _AddReviewWidgetState();
}

class _AddReviewWidgetState extends State<AddReviewWidget> {
  double _rating = 0;
  final _titleController = TextEditingController();
  final _reviewController = TextEditingController();
  bool _recommend = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Image.network(
                widget.productImage,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(widget.productBrand),
              subtitle: Text(widget.productName),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your overall rating of this product',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () => setState(() => _rating = index + 1),
                  child: Icon(
                    Icons.star,
                    size: 32,
                    color: index < _rating
                        ? Colors.amber
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Set a Title for your review',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              maxLength: 3000,
              decoration: const InputDecoration(
                labelText: 'What did you like or dislike?',
                border: OutlineInputBorder(),
              ),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Would you recommend this product?'),
              value: _recommend,
              onChanged: (value) => setState(() => _recommend = value),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Here you would typically validate and submit
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit Review'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
