user2 = User.create! email: 'ctres1@gmail.com', password: 'test123', password_confirmation: 'test123', username: 'ctressles'
user3 = User.create! email: 'ctres2@gmail.com', password: 'test123', password_confirmation: 'test123', username: 'fapdaddy'



user_feature = user2.features.create! title: "Asana Ruby Wrapper", tag_list: "ruby, httparty, rails 3", user_id: '1', description: 'a simple wrapper for the asana API - takes oauth token', 
url: 'www.notbuildyet.com', text: <<-FEATURE
here are the best practices of the asana ruby wrapper feature that we just shipped. Use httparty for complete flexibility. 
FEATURE

user_feature = user3.features.create! title: "mobile web app", url: 'mobile.github.com', description: 'a slick new mobile interface for github',  tag_list: "html, css", user_id: '1', text: <<-FEATURE
here are the best practices of the asana ruby wrapper feature that we just shipped. Use httparty for complete flexibility. 
FEATURE