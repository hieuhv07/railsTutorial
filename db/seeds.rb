User.create!(name: "Ho Viet Hieu",
						 email: "hieuhv97@gmail.com",
						 password: "qqqqqq",
						 password_confirmation: "qqqqqq",
						 admin: true)
99.times do |n|
	name = Faker::Name.name
	email = "example-#{n+1}@railstutorial.com"
	password = "qqqqqq"
	User.create!(
			name: name,
			email: email,
			password: password,
			password_confirmation: password
		)
end