require 'rails_helper'
RSpec.describe 'new secret' do
  it 'provides form in user profile page to create a new secret' do
    user = create_user
    log_in user
    expect(page).to have_field('New Secret')
  end
end
