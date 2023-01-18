module BatchApplicantHelper

  def change_color(call_logs)
    call_logs.count > 3 ? 'danger' : 'primary'
  end
end
