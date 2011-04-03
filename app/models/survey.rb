class Survey < ActiveRecord::Base

  validates_uniqueness_of :name

  after_save :ensure_at_most_one_survey_is_open

  def ensure_at_most_one_survey_is_open
    # this should not be a perf. bottle-neck since there will not be more than a handful surveys
    if Survey.all.find_all{|s| s.status==:open}.count > 1
      raise "At most one survey can be open at a time!"
    end
  end

  def close!
    if closeable?
      self.closed_at= DateTime.now
      self.save
    else
      raise "Survey ist not closeable."
    end
  end

  def open?
    self.status == :open
  end

  def open!
    if openable?
      self.opened_at= DateTime.now
      self.save
    else
      raise "Survey ist not openable."
    end
  end

  def status
    if not opened_at and not closed_at
      :new
    elsif opened_at and not closed_at
      :open
    else
      :closed
    end
  end

  def editable?
    true
  end

  def openable?
    if not opened_at
      true
    else
      false
    end
  end

  def closeable?
    if opened_at and (not closed_at)
      true
    else
      false
    end
  end

  def destroyabel?
    if opened_at or closed_at
      false
    else
      true
    end
  end

end
