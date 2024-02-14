class Task < ApplicationRecord
  STATE_NEW_TASK = 'new_task'
  STATE_IN_DEVELOPMENT = 'in_development'
  STATE_IN_QA = 'in_qa'
  STATE_IN_CODE_REVIEW = 'in_code_review'
  STATE_READY_FOR_RELEASE = 'ready_for_release'
  STATE_RELEASED = 'released'
  STATE_ARCHIVED = 'archived'
  
  belongs_to :author, class_name: 'User'
  belongs_to :assignee, class_name: 'User', optional: true

  validates :name, presence: true
  validates :description, presence: true, length: { maximum: 500 }
  validates :author, presence: true

  state_machine initial: STATE_NEW_TASK do
    event :develop do
      transition [STATE_NEW_TASK, STATE_IN_QA, STATE_IN_CODE_REVIEW] => STATE_IN_DEVELOPMENT
    end

    event :start_testing do
      transition STATE_IN_DEVELOPMENT => STATE_IN_QA
    end

    event :start_review do
      transition STATE_IN_QA => STATE_IN_CODE_REVIEW
    end

    event :prepare_for_release do
      transition STATE_IN_CODE_REVIEW => STATE_READY_FOR_RELEASE
    end

    event :release do
      transition STATE_READY_FOR_RELEASE => STATE_RELEASED
    end

    event :archive do
      transition [STATE_NEW_TASK, STATE_RELEASED] => STATE_ARCHIVED
    end
  end
end
