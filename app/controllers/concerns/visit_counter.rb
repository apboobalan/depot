# frozen_string_literal: true

module VisitCounter
  private

  def reset_visits
    set_visits(0)
  end

  def increment_visits
    set_visits(get_visits + 1)
  end

  def set_visits(count)
    @visits = count
    session[:visit_counter] = count
  end

  def get_visits
    session[:visit_counter] ||= 0
  end
end
