25.times { User.create(name: Faker::Name.name, bio: Faker::ChuckNorris.fact, email: Faker::Internet.free_email, password: 123456) }
50.times { Post.create(content: Faker::Lorem.paragraph, user_id: (rand*25).ceil) }
100.times { Friendship.create(sender_id: (rand*25).ceil, receiver_id: (rand*25).ceil, pending: rand.round) }
200.times { Comment.create(content: Faker::Lorem.sentence, user_id: (rand*25).ceil, post_id: (rand*50).ceil) }
400.times { Like.create(user_id: (rand*25).ceil, liked_id: (rand*50).ceil, liked_type: "Post") }
800.times { Like.create(user_id: (rand*25).ceil, liked_id: (rand*200).ceil, liked_type: "Comment") }
