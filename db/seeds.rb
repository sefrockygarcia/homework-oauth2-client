user = User.where(email: 'admin@example.com', admin: true).first_or_initialize
user.name = 'Jane Doe'
user.password = 'password'
user.save!