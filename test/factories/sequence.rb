FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :avatar, :name, :description, :state] do |n|
    "string#{n}"
  end
  sequence(:email) { |n| "person#{n}@example.com" }
  sequence(:expired_at) { |n| Date.current + n.day }
end
