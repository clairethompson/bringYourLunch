require 'rails_helper'

regex = /(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d\d - (Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec) \d\d , 20\d\d/

describe 'the response' do
  let(:event_list_url) {'http://conventioncalendar.com/view/event-list/85?startDate=2014-08-18' }
  let(:event_list_html) { File.read('spec/fixtures/eventList.html') }

  before :each do
    test_time = Time.parse('Aug 18 2014')
    Time.stub(:now).and_return(test_time)


    stub_request(:get, event_list_url).to_return(status: 200, body: event_list_html)

    get '/events'
    @response = JSON.parse response.body
  end

  it 'contains the date' do
    expect(@response [0]['date']).to match regex
  end

  it 'contains the number of attendees' do
    expect(@response[0]['attendance']).to match /^[0-9]+$/
  end
end

