require "spec_helper"

describe "The talk was presented", :type => :request, :js => true do
  let!(:user) { create(:user, :paul) }

  let!(:event) { create(:event, :tasafoconf, :users => [ user ], :owner => user, start_date: Date.today, end_date: Date.today + 5.days, accepts_submissions: true) }

  let!(:talk) { create(:talk, :users => [ user ], :owner => user) }
  let!(:another_talk) { create(:another_talk, :users => [ user ], :owner => user) }

  let!(:activity_abertura) { create(:activity, :abertura) }
  let!(:activity_palestra) { create(:activity, :palestra) }
  let!(:activity_intervalo) { create(:activity, :intervalo) }

  let!(:schedule_palestra) { create(:schedule, :palestra, :event => event, :talk => talk) }
  let!(:schedule_palestra2) { create(:schedule, :palestra, :event => event, :talk => another_talk) }

  context "with valid data" do
    before do
      login_as(user)

      click_link "Eventos"
      click_link "Tá Safo Conf"
      click_link "was_presented_schedule_id_#{schedule_palestra.id}"
    end

    it "redirects to the event page" do
      expect(current_path).to match(%r[/events/\w+])
    end
  end
end