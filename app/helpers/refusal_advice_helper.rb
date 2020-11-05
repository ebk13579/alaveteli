# Helpers for rendering help page refusal advice
module RefusalAdviceHelper
  def refusal_advice_questions(questions)
    questions.
      map { |question| refusal_advice_question(question) }.
      join.
      html_safe
  end

  def refusal_advice_question(question)
    render partial: 'help/refusal_advice/question',
           locals: { question: question }
  end

  def refusal_advice_radio(question, option)
    tag.div do
      id =  "#{ question.id }_#{ option.value }"

      radio_button_tag(id, question.id, false, id: id) +
        label_tag(id, option.label)
    end
  end

  def refusal_advice_checkbox(question, option)
    tag.div do
      id =  "#{ question.id }_#{ option.value }"

      check_box_tag(id, question.id, false, id: id) +
        label_tag(id, option.label)
    end
  end
end
