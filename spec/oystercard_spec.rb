require 'oystercard'

describe OysterCard do
  subject(:oystercard) { OysterCard.new }
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }

  context '#balance' do
    it 'balance of zero' do
      expect(subject.balance).to eq 0
    end

    context '.top_up' do
      it 'responds with 1 argument' do
        expect(subject).to respond_to(:top_up).with(1).argument
      end

      it 'top up oystercard with 10' do
        expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
      end

      it 'raises error if max balance is exceeded' do
        maximum_balance = OysterCard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
      end

      it 'raises error if top up amount is below minimum value' do
        minimum_balance = OysterCard::MINIMUM_BALANCE
        expect{ subject.top_up(1) }.to raise_error "Unable to top-up below the amount of #{minimum_balance}"
      end
    end

    context '.deduct' do
      it 'responds with 1 arguement' do
        expect(subject).to respond_to(:deduct).with(1).argument
      end

      it 'deducts balance by a specified amount' do
        allow(subject).to receive(:top_up) { 10 }
        expect{ subject.deduct(5) }.to change{ subject.balance }.by (-5)
      end
    end


    context '.touch_out' do
      it 'responds' do
        expect(subject).to respond_to(:touch_out)
      end

    end

    context '#journeys' do
      it 'has an empty list of journeys by default' do
        expect(subject.journeys).to be_empty
      end
    end

    context 'card is topped' do
      let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
      # before :each do
      #   subject.top_up(OysterCard::MAXIMUM_BALANCE)
      # end
      before (:each) { subject.top_up(OysterCard::MAXIMUM_BALANCE) }

        it 'saves entry station to card' do
          expect{ subject.touch_in(entry_station) }.to change{ subject.entry_station }.to entry_station
        end

        it 'is initially not in a journey' do
          expect(subject).not_to be_in_journey
        end

        it 'changes .in_journey? to true' do
          expect{ subject.touch_in(entry_station) }.to change{ subject.in_journey? }.to true
        end

        it 'changes .in_journey? to false' do
          subject.touch_in(entry_station)
          expect{ subject.touch_out(exit_station) }.to change{ subject.in_journey? }.to false
        end

        it 'deducts minimum fare from balance' do
          min_fare = OysterCard::MINIMUM_FARE
          subject.touch_in(entry_station)
          expect { subject.touch_out(exit_station) }.to change{ subject.balance }.by -min_fare
        end

        it ' sets #entry_station to nil on touch_out' do
          subject.touch_in(entry_station)
          expect{ subject.touch_out(exit_station) }.to change{ subject.entry_station }.to be_nil
        end

        it 'add a journey to the card on touch_out' do
          subject.touch_in(entry_station)
          subject.touch_out(exit_station)
          expect(subject.journeys).to include journey
        end

    end

    context 'card balance is below minimum' do

      it 'raises an error on .touch_in' do
        min_fare = OysterCard::MINIMUM_FARE
        expect{ subject.touch_in(entry_station) }.to raise_error("Insufficient funds - minimum fare is £#{min_fare}, current balance is £#{subject.balance}")
      end

    end

  end
end
