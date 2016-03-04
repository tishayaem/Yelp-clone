def sign_up(email: 'example@example.com', password: '12345678')
  visit '/restaurants'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def sign_in(email: 'example@example.com', password: '12345678')
  visit '/restaurants'
  click_link 'Sign in'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end

def sign_out
  click_link 'Sign out'
end

def create_restaurant(name: 'Byron')
  click_link 'Add a restaurant'
  fill_in 'Name', with: name
  click_button 'Create Restaurant'
end

def write_review
  click_link 'Review Byron'
  fill_in 'Thoughts', with: 'Pretty good'
  click_button 'Leave Review'
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end

def delete_restaurant
  click_link 'Delete Byron'
end
