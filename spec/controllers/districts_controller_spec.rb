require 'rails_helper'

RSpec.describe DistrictsController, type: :controller do

  describe 'GET index' do
    before { get :index }

    it 'returns a 200 OK status' do
      get :index
      expect(response).to be_success
    end

    it 'renders #index' do
      expect(response).to render_template(:index)
    end

    it 'assigns @districts' do
      expect(assigns(:districts)).to be_truthy 
    end

    describe 'assigns @meetings' do      
      it 'is present' do
        expect(assigns(:meetings)).to be_truthy
      end

      context 'with meetings' do
        let!(:meeting) { create(:meeting) }
        let(:past) { build(:meeting, starts_at_date: Date.yesterday) }

        before do
          past.save(validate: false)
          get :index
        end

        it 'contains upcoming/unset meetings' do
          expect(assigns(:meetings)).to include(meeting)
        end

        it 'excludes past meetings' do
          expect(assigns(:meetings)).not_to include(past)
        end
      end
    end
  end

  describe 'GET show' do
    let(:district) { create(:district,
      area: 'POLYGON ((0.0 0.0, 0.0 10.0, 10.0 10.0, 10.0 0.0, 0.0 0.0))') }
    let!(:graetzl) { create(:graetzl,
      area: 'POLYGON ((0.0 0.0, 0.0 6.0, 6.0 5.0, 5.0 0.0, 0.0 0.0))') }
    let!(:wrong_graetzl) { create(:graetzl,
      area: 'POLYGON ((20.0 20.0, 20.0 40.0, 40.0 40.0, 40.0 2.0, 20.0 20.0))') }

    before { get :show, id: district }

    it 'returns a 200 OK status' do
      expect(response).to be_success
    end

    it 'renders #show' do
      expect(response).to render_template(:show)
    end

    it 'assigns @district' do
      expect(assigns(:district)).to eq district
    end

    describe 'assings @meetings' do
      it 'is present' do
        expect(assigns(:meetings)).to be_truthy
      end

      context 'with meetings' do
        let!(:meeting_in_graetzl) { create(:meeting, graetzl: graetzl) }
        let!(:meeting_outside_graetzl) { create(:meeting, graetzl: wrong_graetzl) }


        it 'contains meetings from area' do
          expect(assigns(:meetings)).to include(meeting_in_graetzl)
        end

        it 'excludes meetings from outside area' do
          expect(assigns(:meetings)).not_to include(meeting_outside_graetzl)
        end
      end
    end
  end

  describe 'GET graetzls' do
    let(:district) { create(:district,
      area: 'POLYGON ((0.0 0.0, 0.0 10.0, 10.0 10.0, 10.0 0.0, 0.0 0.0))')}
    let!(:graetzl_1) { create(:graetzl,
      area: 'POLYGON ((1.0 1.0, 1.0 5.0, 5.0 5.0, 5.0 1.0, 1.0 1.0))') }
    let!(:graetzl_2) { create(:graetzl,
      area: 'POLYGON ((5.0 5.0, 5.0 6.0, 6.0 6.0, 6.0 5.0, 5.0 5.0))') }

    before do
      get :graetzls, id: district.id, format: :json
    end

    it 'responds with json' do
      expect(response.content_type).to eq('application/json')
    end

    it 'responds with 2 graetzls' do
      graetzls = JSON.parse(response.body)
      expect(graetzls.count).to eq 2
    end

    it 'responds with id and name of graetzl' do
      graetzls = JSON.parse(response.body)
      expect(graetzls.first.size).to eq 2
      expect(graetzls.last.size).to eq 2
      expect(graetzls.first['id']).to eq graetzl_1.id
      expect(graetzls.last['id']).to eq graetzl_2.id
      expect(graetzls.first['name']).to eq graetzl_1.name
      expect(graetzls.last['name']).to eq graetzl_2.name
    end
  end
end