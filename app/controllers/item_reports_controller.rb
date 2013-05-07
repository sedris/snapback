class ItemReportsController < ApplicationController

  # GET /item_reports/1
  # GET /item_reports/1.json
  def show
    @item_report = ItemReport.find(params[:id])

    respond_to do |format|
      format.js {}
      #format.html # show.html.erb
      #format.json { render json: @item_report }
    end
  end

  # GET /item_reports/new
  # GET /item_reports/new.json
  def new
    @item = Item.find(params[:id])
    @item_report = ItemReport.new

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @item_report }
    end
  end

  # POST /item_reports
  # POST /item_reports.json
  def create
    @item_report = ItemReport.new(:item_id => params[:item_id], :user_id=>current_user.id, :description => params[:description])

    respond_to do |format|
      if @item_report.save
        format.html { redirect_to request.referer, notice: 'Item report was successfully created.' }
        format.json { render json: @item_report, status: :created, location: @item_report }
      else
        format.html { render action: "new" }
        format.json { render json: @item_report.errors, status: :unprocessable_entity }
      end
    end
  end
end
