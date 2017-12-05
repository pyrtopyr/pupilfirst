FactoryBot.define do
  factory :timeline_event_type do
    sample_text { Faker::Lorem.words(10).join ' ' }
    proof_required { Faker::Lorem.words(10).join ' ' }
    badge File.open(Rails.root.join('spec', 'support', 'uploads', 'timeline_event_types', 'default.png'))
    sequence(:key) { |n| "#{Faker::Lorem.word}-#{n}" }
    role { TimelineEventType::ROLE_OTHER }
    title { Faker::Lorem.words(2).join ' ' }

    factory :tet_team_formed do
      key 'team_formed'
      role 'Product'
      title 'Team Formed'
    end

    factory :tet_new_product_deck do
      key 'new_product_deck'
      role 'Product'
      title 'New Product Deck'
      suggested_stage 'moved_to_idea_discovery'
    end

    factory :tet_one_liner do
      key 'one_liner'
      role 'Product'
      title 'Set New One-Liner'
      suggested_stage 'moved_to_idea_discovery,moved_to_customer_validation'
    end

    factory :tet_joined do
      key TimelineEventType::TYPE_JOINED_SV_CO
      role 'Product'
      title 'Joined SV.CO'
      suggested_stage 'moved_to_idea_discovery'
    end

    factory :tet_end_iteration do
      key TimelineEventType::TYPE_END_ITERATION
      role 'Product'
      title 'End of Iteration'
    end

    trait :founder_update do
      key TimelineEventType::TYPE_FOUNDER_UPDATE
      role TimelineEventType::ROLE_FOUNDER
      title 'Founder Update'
    end

    trait :team_update do
      key TimelineEventType::TYPE_TEAM_UPDATE
      role TimelineEventType::ROLE_TEAM
      title 'Team Update'
    end
  end
end
