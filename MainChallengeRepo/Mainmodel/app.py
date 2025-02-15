from flask import Flask, request, jsonify
import pandas as pd
import re
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)

def recommend_books(user_input, top_n=5):
    # Load dataset
    df = pd.read_excel('Mainmodel/updated.xlsx')
    df.dropna(subset=['description', 'author', 'Mood', 'rating', 'price', 'page_count', 'title'], inplace=True)
    df = df.astype(str)

    # Preprocess the user input
    user_input = str(user_input).lower()
    print(user_input)

    # Initialize filters
    mood_filter = None
    author_filter = None
    price_filter = None
    rating_filter = None
    # List of moods with synonyms and common misspellings
    mood_synonyms = {
    "Fiction": [
        "novel", "story", "tale", "narrative", "fable", "parable", "literature", "plot", 
        "fictional", "make-believe", "prose", "fction", "ficiton", "nobel", "fictian", "fictin",
        "To Kill a Mockingbird", "The Great Gatsby", "1984", "Pride and Prejudice", "Moby-Dick"
    ],

    "Mystery & Detective": [
        "mysteries", "crime", "detective", "thriller", "whodunit", "clue", "investigation", 
        "suspense", "forensic", "murder", "suspect", "case", "intrigue", "covert", "mystry", "deective", "triller",
        "Sherlock Holmes", "Gone Girl", "The Girl with the Dragon Tattoo", "Big Little Lies", "The Da Vinci Code"
    ],

    "Fantasy": [
        "magical", "mythical", "sorcery", "wizards", "dragons", "elves", "fairy tale", "mythology", 
        "spell", "enchantment", "realm", "alternate reality", "witchcraft", "fanatsy", "fentesy",
        "Harry Potter", "The Lord of the Rings", "The Hobbit", "A Game of Thrones", "Percy Jackson"
    ],

    "Science Fiction": [
        "sci-fi", "scifi", "sifi", "sci fi", "futuristic", "space", "alien", "robot", "cyberpunk", 
        "time travel", "parallel universe", "AI", "dystopia", "steampunk", "sciece fiction", "sifi", "scince ficton",
        "Dune", "The Hitchhiker’s Guide to the Galaxy", "Ender's Game", "Brave New World", "Neuromancer"
    ],

    "Romance": [
        "love", "romantic", "relationships", "passion", "affection", "heart", "dating", "soulmate", 
        "flirtation", "courtship", "proposal", "amour", "romanec", "romnce", "rommance",
        "Pride and Prejudice", "The Notebook", "Me Before You", "It Ends With Us", "Twilight"
    ],

    "Self-Help": [
        "self improvement", "personal development", "self growth", "motivation", "productivity", 
        "mindset", "goal-setting", "confidence", "positivity", "mental toughness", "success", 
        "mindfulness", "coaching", "selfhlep", "selp-help", "selp halp", "selfhel",
        "Atomic Habits", "The 7 Habits of Highly Effective People", "The Power of Now", "The Subtle Art of Not Giving a F*ck"
    ],

    "Biography & Autobiography": [
        "life story", "memoir", "bio", "autobio", "historical figure", "legacy", "diary", 
        "chronicle", "notable", "personal story", "true story", "historical account", "journey",
        "The Diary of a Young Girl", "Steve Jobs", "Educated", "Becoming", "Long Walk to Freedom"
    ],

    "Business & Economics": [
        "entrepreneurship", "finance", "economy", "marketing", "startup", "investment", 
        "strategy", "corporate", "leadership", "stocks", "wealth", "trade", "bussiness", "busness",
        "Rich Dad Poor Dad", "The Lean Startup", "The Intelligent Investor", "Zero to One", "Think and Grow Rich"
    ],

    "Psychology": [
        "mental health", "mind", "psyche", "cognitive", "subconscious", "therapy", "behavior", 
        "neuroscience", "emotions", "stress", "depression", "psychoanalysis", "counseling",
        "Thinking, Fast and Slow", "The Power of Habit", "The Psychopath Test", "Quiet", "The Man Who Mistook His Wife for a Hat"
    ],

    "Thrillers": [
        "suspense", "action", "adventure", "intense", "crime", "espionage", "assassin", 
        "chase", "conspiracy", "danger", "hostage", "spy", "dark", "twist", "gripping", "thriler", "trhiller",
        "The Girl on the Train", "The Silent Patient", "The Woman in the Window", "Gone Girl", "Before I Go to Sleep"
    ],

    "Cooking": [
        "recipes", "food", "culinary", "cookbok", "coocking", "eat", "baking", "chef", 
        "gourmet", "cuisine", "flavors", "ingredients", "meal prep", "nutrition", "cookbook",
        "Salt, Fat, Acid, Heat", "The Joy of Cooking", "Mastering the Art of French Cooking", "The Food Lab"
    ],

    "History": [
        "past", "history", "historical", "ancient", "civilization", "archaeology", "dynasty", 
        "war", "heritage", "revolution", "historian", "chronology", "relics", "artifacts",
        "Sapiens", "Guns, Germs, and Steel", "A People's History of the United States", "The Silk Roads"
    ],

    "Sports": [
        "athletics", "games", "sporting", "competition", "fitness", "training", "workout", 
        "stadium", "championship", "league", "olympics", "tournament", "athlete", "exercise",
        "Moneyball", "The Boys in the Boat", "Open (Andre Agassi)", "Shoe Dog", "Born to Run"
    ],

    "Technology & Engineering": [
        "tech", "engineering", "innovation", "robotics", "automation", "cybersecurity", "AI", 
        "machine learning", "network", "virtual reality", "computing", "hacking", "invention",
        "The Innovators", "Hackers & Painters", "Code", "The Singularity is Near", "How to Create a Mind"
    ]
}


    # Check for mood in the input
    for mood, synonyms in mood_synonyms.items():
        if any(syn in user_input for syn in [mood.lower()] + [s.lower() for s in synonyms]):
            mood_filter = mood
            break

    # List of author indicators with misspellings
    author_keywords = ["author", "by", "writer", "written by", "auther", "writter"]
    for keyword in author_keywords:
        if keyword in user_input:
            author_filter = user_input.split(keyword)[-1].strip()
            break

    # Price-related indicators
    price_indicators = ["under", "over", "less than", "more than", "cheaper than", "expensive", "affordable"]
    price_match = re.findall(r'(\d+)', user_input)  # Extract numerical values

    if price_match:
        price_value = float(price_match[0])

        if any(kw in user_input for kw in ["under", "less than", "cheaper than"]):
            price_filter = ("<=", price_value)
        elif any(kw in user_input for kw in ["over", "more than", "expensive"]):
            price_filter = (">=", price_value)
    # Rating-related indicators
    rating_indicators = ["rating", "rated", "stars", "star"]
    rating_match = re.findall(r'(\d+\.?\d*)', user_input)  # Extract numerical values

    if rating_match:
        rating_value = float(rating_match[0])

        if any(kw in user_input for kw in ["at least", "minimum", "above"]):
            rating_filter = (">=", rating_value)
        elif any(kw in user_input for kw in ["below", "under", "less than"]):
            rating_filter = ("<=", rating_value)
        else:
            rating_filter = (">=", rating_value)  # Default to at least the specified rating
    # Apply filters to the dataset
    filtered_df = df.copy()

    if mood_filter:
        filtered_df = filtered_df[filtered_df['Mood'].str.contains(mood_filter, case=False, na=False)]

    if author_filter:
        filtered_df = filtered_df[filtered_df['author'].str.contains(author_filter, case=False, na=False)]

    if price_filter:
        operator, value = price_filter
        if operator == "<=":
            filtered_df = filtered_df[filtered_df['price'].astype(float) <= value]
        elif operator == ">=":
            filtered_df = filtered_df[filtered_df['price'].astype(float) >= value]
    if rating_filter:
        operator, value = rating_filter
        if operator == "<=":
            filtered_df = filtered_df[filtered_df['rating'].astype(float) <= value]
        elif operator == ">=":
            filtered_df = filtered_df[filtered_df['rating'].astype(float) >= value]

    # If any of the filters are not satisfied, return no books
    if (mood_filter and filtered_df.empty) or (author_filter and filtered_df.empty) or (price_filter and filtered_df.empty):
        print("\nNo books found matching all your criteria.")
        return []

    # Use TF-IDF to match user input with book descriptions
    tfidf = TfidfVectorizer(stop_words='english')
    tfidf_matrix = tfidf.fit_transform(filtered_df['description'])
    user_tfidf = tfidf.transform([user_input])

    # Calculate cosine similarity between user input and book descriptions
    cosine_sim = cosine_similarity(user_tfidf, tfidf_matrix).flatten()

    # Add similarity scores to the filtered dataframe
    filtered_df['similarity'] = cosine_sim

    # Rank the filtered results by similarity and rating
    filtered_df = filtered_df.sort_values(by=['similarity', 'rating'], ascending=[False, False])

    # Save the top N recommendations
    
    if len(filtered_df) > 0:
        
        print(f"\n📚 Top {top_n} Recommended Books:")
        for i, row in filtered_df.head(top_n).iterrows():
            print(f"{i+1}. {row['title']} by {row['author']} (Mood: {row['Mood']}, Price: ${row['price']}, Rating: {row['rating']}, Similarity: {row['similarity']:.2f})")
    else:
        print("\nNo books found matching your criteria.")
    recommendations = []
    if len(filtered_df) > 0:
        for i, row in filtered_df.head(top_n).iterrows():
            book = {
                "title": row['title'],
                "author": row['author'],
                "mood": row['Mood'],
                "price": float(row['price']),
                "rating": float(row['rating']),
                "similarity": float(row['similarity'])
            }
            recommendations.append(book)

    return recommendations


@app.route('/recommend', methods=['POST'])
def recommend():
    data = request.json
    user_input = data.get('query')
    top_n = data.get('top_n', 5)

    recommendations = recommend_books(user_input, top_n)

    return jsonify({"recommendations": recommendations})


if __name__ == '__main__':
    app.run(debug=True)
