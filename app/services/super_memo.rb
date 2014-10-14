class SuperMemo < Struct.new(:previous_interval, :ef, :typo_count, :time, :translated_text_length, :numb_correct_answers)

=begin
Градация качества ответа
0 - нет ответа
1 - неверный ответ
2 - верный ответ с опечатками(2-3 раза опечатался)
3 - верный ответ с опечатками(1 раз опечатался)
4 - верный ответ, не уложился в промежуток времени
5 - верный ответ, уложился в промежуток времени
=end

  def qualify_answer
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

=begin
Как мы будем менять EF и интервал в зависимости от качества ответа:
при 0 - 1 - не трогаем EF и интервал если меньше 3 ошибок подряд, если больше, то сбрасываем значения аттрибутов
при 2 - не трогаем EF, интервал уменьшаем (interval = interval / ef)
при 3 - EF уменьшается, интервал увеличиваем
при 4 - EF не меняется, интервал увеоичиваем
при 5 - увеличиваем EF и интервал
=end

  def e_factor
    result = typo_count <= 1 ? calculate_e_factor : ef
    [result, 1.3].max
  end

  def interval
    result = if typo_count <= 1
              case numb_correct_answers
              when 0..1
                1
              when 2
                6
              else
                previous_interval * e_factor
              end
            else 
              [previous_interval/ef, 1].max
            end
    [result, 365].min        
  end

  private
  
  def calculate_e_factor
    # Эта формула взята тут http://www.supermemo.com/english/ol/sm2.htm и немного доработана, 
    # чтобы учитывать при расчете время ответа юзера 
    ef - (0.02 * qualify_answer**2 - 0.28 * qualify_answer + 0.8) * time_factor 
  end

  def time_factor
    translated_text_length * 1000.0 / time.to_i
  end

end


