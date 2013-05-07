class LendsController < ApplicationController
  # GET /lends
  # GET /lends.json
  def index

    if current_user
      @lends_others = Lend.where("user_id != ? and status = 'open'", current_user.id)
      @lends_open = current_user.lends.where("status='open'")
      @lends_pending = current_user.lends.where("status='pending'")
      @tags_open = []
      @lends_open.each do |lend|
        @tags_open << lend.item.tags
      end
      @tags_pending = []
      @lends_pending.each do |lend|
        @tags_pending << lend.item.tags
      end
      @tags_others = []
      @lends_others.each do |lend|
        @tags_others << lend.item.tags
      end
    else
      @lends_others = Lend.where("status = 'open'")
      @lends = Lend.where("status = 'open'")
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lends }
    end
  end

  # GET /lends/1
  # GET /lends/1.json
  def show
    @lend = current_user.lends.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lend }
    end
  end

  # GET /lends/new
  # GET /lends/new.json
  def new
    @lend = current_user.lends.new
    @tags = Tag.all

    respond_to do |format|
      format.js {}
      #format.html # new.html.erb
      #format.json { render json: @lend }
    end
  end

  # GET /lends/1/edit
  def edit
    @lend = current_user.lends.find(params[:id])
  end

  # POST /lends
  # POST /lends.json
  def create
    @lend = current_user.lends.create(params[:lend])
    @lend.update_attributes({:status => "open"})
    @lend.build_item({:name => params[:item_name], :lend_id => current_user.id})
    tags = params[:tags].split(",")
    tags.each do |tag|
      stripped = tag.lstrip.rstrip
      t = Tag.where("tag = ?", stripped)
      if t.empty?
        if !stripped.empty?
          c = current_user.tags.new(:tag => stripped)
          if c.save
            c.items << @lend.item
          end
        end
      else
        t[0].items << @lend.item
      end
    end
    
    respond_to do |format|
      if @lend.save
        format.html { redirect_to lends_path, notice: 'Lend was successfully created.' }
        format.json { render json: @lend, status: :created, location: @lend }

      else
        format.html { render action: "new" }
        format.json { render json: @lend.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /lends/1
  # DELETE /lends/1.json
  def destroy
    @lend = current_user.lends.find(params[:id])
    @bad_return_request = @lend.item.return
    if @bad_return_request != nil 
      @bad_return_request.destroy
    end

    @lend.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def show_image
    @lend = Lend.find(params[:id])

    respond_to do |format|
      format.js
    end
  end
end
