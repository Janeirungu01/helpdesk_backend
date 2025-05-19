require 'faker'

User.destroy_all

BRANCHES = ["Fedha", "Utawala", "Machakos", "Kitengela", "Tassia"]
USERTYPES = ["Client", "Agent", "Admin"]

users = [
  {
    email: "admin@example.com",
    password: "password123",
    username: "admin_user",
    fullname: "Admin User",
    usertype: "Admin",
    branches: BRANCHES
  },
  {
    email: "agent1@example.com",
    password: "password123",
    username: "agent_john",
    fullname: "John Agent",
    usertype: "Agent",
    branches: ["Fedha", "Utawala"]
  },
  {
    email: "client1@example.com",
    password: "password123",
    username: "client_jane",
    fullname: "Jane Client",
    usertype: "Client",
    branches: ["Machakos"]
  }
]

# Add 5 random clients and 3 random agents
5.times do
  users << {
    email: Faker::Internet.unique.email,
    password: "password123",
    username: Faker::Internet.unique.username(specifier: 5..10),
    fullname: Faker::Name.name,
    usertype: "Client",
    branches: [BRANCHES.sample]
  }
end

3.times do
  users << {
    email: Faker::Internet.unique.email,
    password: "password123",
    username: Faker::Internet.unique.username(specifier: 5..10),
    fullname: Faker::Name.name,
    usertype: "Agent",
    branches: BRANCHES.sample(2)
  }
end

users.each do |attrs|
  User.create!(
    email: attrs[:email],
    password: attrs[:password],
    password_confirmation: attrs[:password],
    username: attrs[:username],
    fullname: attrs[:fullname],
    usertype: attrs[:usertype],
    branches: attrs[:branches]
  )
end

Article.create!([
  {
    question: "How to reset my password?",
    answer: "Click on 'Forgot Password' at the login page.",
    category: "Authentication",
    tags: ["password", "reset", "login"]
  },
  {
    question: "How to submit a ticket?",
    answer: "Go to the Tickets page and click on 'Add Ticket'.",
    category: "Support",
    tags: ["ticket", "support"]
  }
])


puts "Seeded #{User.count} users."