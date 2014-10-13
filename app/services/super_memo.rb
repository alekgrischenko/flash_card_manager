class SuperMemo < Struct.new(:old_interval, :ef, :numb_correct_answers)

  def quality_answer(typo_count, time_factor)
    case typo_count
    when 0
      if time_factor > 0.5
        5
      else
        4
      end
    when 1
      3
    end
  end

  def e_factor(typo_count, time_factor)
    if typo_count <= 1
      e_factor = ef - (0.02 * quality_answer(typo_count, time_factor)**2 - 0.28 * quality_answer(typo_count, time_factor) + 0.8) * time_factor
    else 
      e_factor = ef
    end
    e_factor > 1.3 ? e_factor : 1.3
  end

  def interval(typo_count, time_factor)
    if typo_count <= 1
      case numb_correct_answers
      when 0..1
        1
      when 2
        6
      else
        old_interval * e_factor(typo_count, time_factor) < 365 ? old_interval * e_factor(typo_count, time_factor) : 365
      end
    else 
      old_interval/ef > 1 ? old_interval/ef : 1
    end
  end

end
