class ConciergeController < ApplicationController
  def index
    @locker = Locker.all
    @bag = Bag.all
    @random_guest_bag = Bag.unchecked.first if Bag.unchecked.exists?
    if Bag.checked.exists?
      @random_guest_ticket = Bag.checked.all.order('random()').first
    else
      @bag = Bag.small.first
      @bag.update_attributes(locker_id: 1)
      @random_guest_ticket = Bag.checked.all.order('random()').first if @bag.save
      flash[:notice] = "This is the General Manager's gym bag - please do not remove it."
      flash[:alert] = nil
    end
  end

  def store_bag
    if Locker.empty.count == 0
      respond_to do |format|
        format.html { redirect_to(:root, alert: "There are no more empty lockers - please go to the Venetian Casino, where they can check your bag."   
          )}
      end    
    else
      check_bag
    end
  end

  def check_bag
    @bag = Bag.find(params[:id])
    if @bag.size == 'small'
      if Locker.small.empty.exists?
        locker_id = Locker.small.empty.first.id
      elsif Locker.medium.empty.exists?
        locker_id = Locker.medium.empty.first.id
      elsif Locker.large.empty.exists?
        locker_id = Locker.large.empty.first.id
      else
        flash[:notice] = "We don't have any open lockers."
      end
    end
    if @bag.size == 'medium'
      if Locker.medium.empty.exists?
        locker_id = Locker.medium.empty.first.id
      elsif Locker.large.empty.exists?
        locker_id = Locker.large.empty.first.id
      else
        flash[:notice] = "We don't have any open lockers."
      end
    end
    if @bag.size == 'large'
      if Locker.large.empty.exists?
        locker_id = Locker.large.empty.first.id
      else
        flash[:notice] = "We don't have any open lockers."
       end
    end
    @bag.update_attributes(locker_id: locker_id)
    if @bag.save
    	ticket = Locker.where(id: locker_id).first.id.to_s
      respond_to do |format|
        format.html { redirect_to(
        	root_path(ticket: ticket), 
        	notice: 'Please check this bag into locker #' + Locker.where(id: locker_id).first.id.to_s + ', which is a ' + Locker.where(id: locker_id).first.size.to_s + ' locker.')
      }
      end
    end
  end

  def retrieve_bag
    @bag = Bag.find(params[:id])
    locker_id = Bag.find(params[:id]).locker_id
    @bag.update_attributes(locker_id: nil)
    if @bag.save
      respond_to do |format|
        format.html { 
        	redirect_to(
        		:root, 
        		alert: 'Great! The bag was successfully returned from locker #' + 
        			Locker.where(id: locker_id).first.id.to_s + 
      				', which was a ' + 
      				Locker.where(id: locker_id).first.size.to_s + 
      				' locker.'
        	)
        }
      end
    end
  end
end
