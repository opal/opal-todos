require 'vendor/model'

class Todo < Model
  attribute :title
  attribute :completed

  def destroy
    trigger :destroy
  end

  def toggle
    @completed = !@completed
    # save
  end
end