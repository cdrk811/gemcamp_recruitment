module BatchApplicantHelper

  def change_color(call_logs)
    call_logs.size > 3 ? 'danger' : 'primary'
  end
end
