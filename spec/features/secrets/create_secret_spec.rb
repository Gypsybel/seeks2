require 'rails_helper'
RSpec.describe 'creating a secret' do
  it 'creates a new secret and redirects to profile page' do
    user = create_user
    log_in user
    fill_in 'New Secret', with: 'My secret'
    click_button 'Create Secret'
    expect(current_path).to eq("/users/#{user.id}")
    expect(page).to have_text('My secret')
  end
end
