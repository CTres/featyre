user2 = User.create! email: 'ctres1@gmail.com', password: 'test123', password_confirmation: 'test123', username: 'ctres1'
user3 = User.create! email: 'ctres2@gmail.com', password: 'test123', password_confirmation: 'test123', username: 'ctres2'



user_feature = user2.features.create! title: "Asana Ruby Wrapper", tag_list: "ruby, httparty, rails 3", user_id: '1', text: <<-FEATURE
here are the best practices of the asana ruby wrapper feature that we just shipped. Use httparty for complete flexibility. 
FEATURE

user_feature = user3.features.create! title: "mobile web app", tag_list: "html, css", user_id: '1', text: <<-FEATURE
here are the best practices of the asana ruby wrapper feature that we just shipped. Use httparty for complete flexibility. 
FEATURE