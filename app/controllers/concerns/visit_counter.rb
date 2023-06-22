# frozen_string_literal: true

module VisitCounter
  private

  def reset_visits
    set_visits(0)
  end

  def increment_and_get_visits
    increment_visits
    get_visits
  end

  def increment_visits
    set_visits(get_visits + 1)
  end

  def set_visits(count)
    session[:visit_counter] = count
  end

  def get_visits
    session[:visit_counter] = 0 if session[:visit_counter].nil?
    session[:visit_counter]
  end
end
