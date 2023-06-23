# frozen_string_literal: true

module VisitCounter

  VISIT_COUNTER = :visit_counter

  private

  def reset_visits
    set_visits(0)
  end

  def increment_visits
    set_visits(get_visits + 1)
  end

  def set_visits(count)
    @visits = count
    session[VISIT_COUNTER] = count
  end

  def get_visits
    session[VISIT_COUNTER] ||= 0
  end
end
