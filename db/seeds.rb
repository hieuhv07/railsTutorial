User.create!(name: "Ho Viet Hieu",
						 email: "hieuhv97@gmail.com",
						 password: "qqqqqq",
						 password_confirmation: "qqqqqq",
						 admin: true,
						 activated: true,
						 activated_at: Time.zone.now)
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.com"
	password = "qqqqqq"
	User.create!(
			name: name,
			email: email,
			password: password,
			password_confirmation: password,
			activated: true,
			activated_at: Time.zone.now
		)
end

users = User.order(:created_at).take(6)
50.times do 
	content = Faker::Lorem.sentence(5)
	users.each {|user| user.microposts.create!(content: content)}
end