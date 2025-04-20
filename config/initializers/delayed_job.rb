module Delayed
  class Job < ActiveRecord::Base
    self.table_name = 'delayed_jobs'
    belongs_to :jobbable, :polymorphic => true
  end
end