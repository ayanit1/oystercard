require 'oystercard'

describe OysterCard do
  subject(:oystercard) { OysterCard.new }

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

    context '.touch_in' do
      it 'responds' do
        expect(subject).to respond_to(:touch_in)
      end

    #   it 'changes .in_journey? to true' do
    #     expect{ subject.touch_in }.to change{ subject.in_journey? }.to true
    #   end
    end

    context '.touch_out' do
      it 'responds' do
        expect(subject).to respond_to(:touch_out)
      end

    end

    context 'card is topped' do
      # before :each do
      #   subject.top_up(OysterCard::MAXIMUM_BALANCE)
      # end
      before (:each) { subject.top_up(OysterCard::MAXIMUM_BALANCE) }

        it 'is initially not in a journey' do
          expect(subject).not_to be_in_journey
        end

        it 'changes .in_journey? to true' do
          expect{ subject.touch_in }.to change{ subject.in_journey? }.to true
        end

        it 'changes .in_journey? to false' do
          subject.touch_in
          expect{ subject.touch_out }.to change{ subject.in_journey? }.to false
        end

    end

  end
end
