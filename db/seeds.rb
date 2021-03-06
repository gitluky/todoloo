# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cap = User.create(email: 'srogers@gmail.com', name: 'CaptainAmerica', password: 'password')
bucky = User.create(email: 'bbarnes@gmail.com', name: 'Bucky', password: 'password')
User.create(email: 'nromanoff@gmail.com', name: 'BlackWidow', password: 'password')
User.create(email: 'thor@gmail.com', name: 'GodOfThunder', password: 'password')
User.create(email: 'bbanner@gmail.com', name: 'StrongestAvenger', password: 'password')
User.create(email: 'nfury@gmail.com', name: 'Fury', password: 'password')
User.create(email: 'cbarton@gmail.com', name: 'Hawkeye', password: 'password')
User.create(email: 'tchalla@gmail.com', name: 'BlankPanter', password: 'password')
User.create(email: 'jrhodes@gmail.com', name: 'WarMachine', password: 'password')
User.create(email: 'wmaximoff@gmail.com', name: 'ScarletWitch', password: 'password')
User.create(email: 'pparker@gmail.com', name: 'SpiderMan', password: 'password')
User.create(email: 'sstrange@gmail.com', name: 'DoctorStrange', password: 'password')
User.create(email: 'swilson@gmail.com', name: 'Falcon', password: 'password')
User.create(email: 'slang@gmail.com', name: 'AntMan', password: 'password')

User.create(email: 'pquill@gmail.com', name: 'Quill', password: 'password')
User.create(email: 'gamora@gmail.com', name: 'Gamora', password: 'password')
User.create(email: 'nebula@gmail.com', name: 'Nebula', password: 'password')
User.create(email: 'drax@gmail.com', name: 'Drax', password: 'password')
User.create(email: 'mantis@gmail.com', name: 'Mantis', password: 'password')
User.create(email: 'groot@gmail.com', name: 'Groot', password: 'password')
User.create(email: 'rocket@gmail.com', name: 'Rocket', password: 'password')

User.create(email: 'acurry@gmail.com', name: 'Arthur', password: 'password')
User.create(email: 'dprince@gmail.com', name: 'Diana', password: 'password')
User.create(email: 'ckent@gmail.com', name: 'Clark', password: 'password')
User.create(email: 'bwayen@gmail.com', name: 'Bruce', password: 'password')
User.create(email: 'ballen@gmail.com', name: 'Barry', password: 'password')

User.create(email: 'reginaphalange@gmail.com', name: 'Phoebe', password: 'password')
User.create(email: 'mgeller@gmail.com', name: 'Monica', password: 'password')
User.create(email: 'rgreen@gmail.com', name: 'Rachel', password: 'password')
User.create(email: 'jtrib@gmail.com', name: 'Joey', password: 'password')
User.create(email: 'cbing@gmail.com', name: 'Chandler', password: 'password')
User.create(email: 'rgeller@gmail.com', name: 'Ross', password: 'password')

User.create(email: 'ecartman@gmail.com', name: 'Cartman', password: 'password')
User.create(email: 'smarsh@gmail.com', name: 'Stan', password: 'password')
User.create(email: 'kbroflovski@gmail.com', name: 'Kyle', password: 'password')
User.create(email: 'kmccormick@gmail.com', name: 'Kenny', password: 'password')

Group.create(name: 'Bucky and Cap', description: 'Bros before heroes.')
bucky_and_cap = Group.find(1)
bucky_and_cap.memberships.create(user: cap)
bucky_and_cap.memberships.create(user: bucky)
bucky_and_cap.announcements.create(title: "Welcome!", content: "Welcome to your new group! You can now start inviting members and creating tasks.")
bucky_and_cap.tasks.create(name: 'Find an Engineer', description: 'My shield and your arm are pretty beat up, we need to find somebody who can fix them.', group: bucky_and_cap, created_by: cap)
bucky_and_cap.tasks.create(name: 'Talk to Tony', description: 'You need to talk to Tony, Steve. He\'s still trying to kill me.', group: bucky_and_cap, created_by: bucky)
bucky_and_cap.tasks.create(name: 'Groceries', description: 'Fridge only has condiments.', group: bucky_and_cap, created_by: cap)