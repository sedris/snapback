class RemindersController < ApplicationController
  
  # return all reminders
  def index
    @reminders = Reminder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reminders }
    end
  end

  # show a particular reminder
  def show
    @reminder = Return.find(params[:return_id]).reminder
    @return = Return.find(params[:return_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reminder }
    end
  end

  # form for creating a new reminder
  def new
    @reminder = Reminder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reminder }
    end
  end

  # edit a reminder
  def edit
    @reminder = Return.find(params[:return_id]).reminder
    @return = Return.find(params[:return_id])
  end

  # create a reminder
  def create
    @reminder = Reminder.new(params[:reminder])

    respond_to do |format|
      if @reminder.save
        format.html { redirect_to @reminder, notice: 'Reminder was successfully created.' }
        format.json { render json: @reminder, status: :created, location: @reminder }
      else
        format.html { render action: "new" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reminders/1
  # PUT /reminders/1.json
  def update
    @reminder = Return.find(params[:return_id]).reminder
    @return = Return.find(params[:return_id])

    respond_to do |format|
      if @reminder.update_attributes(params[:reminder]) and @reminder.update_attributes(:frequency=>params[:frequency])
        format.html { redirect_to return_reminders_path(@return), notice: 'Reminder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1
  # DELETE /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url }
      format.json { head :no_content }
    end
  end
end
