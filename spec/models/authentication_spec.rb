require 'rails_helper'

RSpec.describe Authentication, type: :model do
  it { should validate_presence_of :uid }
  it { should validate_presence_of :provider }
  it { should validate_presence_of :user_id }

  let(:authhash) { { 'provider' => 'test', 'uid' => '21d23dw653', 'info' => {'name' => 'foo', 'email' => 'bar@test.com'} } }

  context '#create_from_hash' do
    context '#with existing user' do
      before :each do
        @user = FactoryGirl.create(:user)
      end
      it 'should link the newly created authentication to the existing user' do
        expect{Authentication.create_from_hash(authhash, @user)}.to change{@user.authentications.count}.from(0).to(1)
      end
    end
  end
end
