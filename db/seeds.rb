# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
will = User.create!(email: 'willashley23@gmail.com')
test2 = User.create!(email: 'funnylol3@gmail.com')
test3 = User.create!(email: 'iloverails@gmail.com')

will_url = ShortenedUrl.create_for_user_and_long_url!(will, "www.yahoo.com")
test_url2 = ShortenedUrl.create_for_user_and_long_url!(test2, "www.reddit.com")
test_url3 = ShortenedUrl.create_for_user_and_long_url!(test3, "www.buzzfeed.com")

Visit.record_visit!(will, will_url)
Visit.record_visit!(test2, test_url2)
Visit.record_visit!(test3, test_url3)
