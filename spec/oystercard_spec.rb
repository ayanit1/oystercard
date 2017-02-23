require 'oystercard'

describe OysterCard do
  subject(:oystercard) { described_class.new }
  let (:entry_station) { double :entry_station }
  let (:exit_station) { double :exit_station }

  context '#balance' do
    it 'balance of zero' do
      expect(oystercard.balance).to eq 0
    end

    context '.top_up' do
      it 'responds with 1 argument' do
        expect(oystercard).to respond_to(:top_up).with(1).argument
      end

      it 'top up oystercard with 10' do
        expect{ oystercard.top_up(10) }.to change{ oystercard.balance }.by 10
      end

      it 'raises error if max balance is exceeded' do
        maximum_balance = OysterCard::MAXIMUM_BALANCE
        oystercard.top_up(maximum_balance)
        expect{ oystercard.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
      end

      it 'raises error if top up amount is below minimum value' do
        minimum_balance = OysterCard::MINIMUM_BALANCE
        expect{ oystercard.top_up(1) }.to raise_error "Unable to top-up below the amount of #{minimum_balance}"
      end
    end

    context '.deduct' do
      it 'responds with 1 arguement' do
        expect(oystercard).to respond_to(:deduct_from_balance).with(1).argument
      end

      it 'deducts balance by a specified amount' do
        allow(oystercard).to receive(:top_up) { 10 }
        expect{ oystercard.deduct_from_balance(5) }.to change{ oystercard.balance }.by (-5)
      end
    end


    context '.touch_out' do
      it 'responds' do
        expect(oystercard).to respond_to(:touch_out)
      end

    end
  end

  context 'card is topped up,' do
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    before (:each) { oystercard.top_up(OysterCard::MAXIMUM_BALANCE) }

      it 'deducts minimum fare from balance' do
        min_fare = OysterCard::MINIMUM_FARE
        oystercard.touch_in(entry_station)
        expect { oystercard.touch_out(exit_station) }.to change{ oystercard.balance }.by -min_fare
      end

  end

  context 'card balance is below minimum,' do

    it 'raises an error on .touch_in' do
      min_fare = OysterCard::MINIMUM_FARE
      expect{ oystercard.touch_in(entry_station) }.to raise_error("Insufficient funds - minimum fare is £#{min_fare}, current balance is £#{subject.balance}")
    end

  end
end
