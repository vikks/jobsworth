module Scorable
  def self.included(class_name)
    # Creates a score_rules association on the class
    # represented by 'class_name'
    class_name.class_eval do
      has_many  :score_rules, 
                :as         => :controlled_by,
                :after_add  => :update_tasks_score
    end 
  end

  private

  def update_tasks_score(new_score_rule)
    Task.open.each do |task| 
      task.update_score_with new_score_rule 
      task.save
    end
  end
end
