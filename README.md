ToDoLoo

ToDoLoo is a rails web app designed for easy task management. Once a user signs up with their email or via Facebook, they can create or join groups in which they are invited to, and within these groups, they can post group announcements, create tasks, assign the tasks, as well as leave notes under each task to keep the other group members updated.

Pre-requisites:

Ruby 2.4.0 or higher

Installation

Clone this repository and run $'bundle install' to get the required gems listed in the Gemfile.
Run $rake db:migrate to set up the database.
For mock user account data:
a) Adjust the data in the seed file
b) Run $rake db:seed

To set up omniauth-facebook:
1) Create an app at https://developers.facebook.com
2) Add the Facebook Login product.
3) Select Quickstart under Facebook Login.
  a) Select 'Web'.
  b) Set the Site URL to https://localhost:3000/ and click 'Save'.
4) Under the Facebook Login settings, enter https://localhost:3000/auth/facebook/callback into the 'Valid OAuth Redirect URIs' field and click 'Save Changes'.
5) To obtain your FACEBOOK_KEY and FACEBOOK_SECRET, click the Settings dropdown on your app page.
  a) App ID is the FACEBOOK_KEY
  b) App Secret is the FACEBOOK_SECRET
5) In the main directory of ToDoLoo, create a .env file and set:
FACEBOOK_KEY = <App ID>
FACEBOOK_SECRET = <App Secret>

To start up the server:
Run $rails s
Open up localhost:3000.


Contributing Bug reports and pull requests are welcome on GitHub at https://github.com/gitluky/yawdsale. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

License Available as open source under the terms of the MIT License.

Code of Conduct Everyone interacting in the yawdsale project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct.
