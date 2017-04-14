require "test_helper"

describe ClassroomsController do
  describe "index" do
    it "is successful when there are many classrooms" do
      Classroom.count.must_be :>, 0
      get classrooms_path
      must_respond_with :success
    end

    it "is successful when there are zero classrooms" do
      Classroom.destroy_all
      get classrooms_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "runs successfully" do
      get new_classroom_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new classroom" do
      start_count = Classroom.count

      classroom_data = {
        classroom: {
          designation: "test classroom"
        }
      }
      post classrooms_path, params: classroom_data
      must_redirect_to classrooms_path

      end_count = Classroom.count
      end_count.must_equal start_count + 1

      classroom = Classroom.last
      classroom.designation.must_equal classroom_data[:classroom][:designation]
    end

    it "responds with bad_request for bogus data" do
      start_count = Classroom.count

      classroom_data = {
        classroom: {
          foo: "bar"
        }
      }
      post classrooms_path, params: classroom_data
      must_respond_with :bad_request

      end_count = Classroom.count
      end_count.must_equal start_count
    end
  end

  describe "show" do
    it "finds a classroom that exists" do
      classroom_id = Classroom.first.id
      get classroom_path(classroom_id)
      must_respond_with :success
    end

    it "returns 404 for a classroom that DNE" do
      classroom_id = Classroom.last.id + 1
      get classroom_path(classroom_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "finds a classroom that exists" do
      classroom_id = Classroom.first.id
      get edit_classroom_path(classroom_id)
      must_respond_with :success
    end

    it "returns 404 for a classroom that DNE" do
      classroom_id = Classroom.last.id + 1
      get edit_classroom_path(classroom_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "updates the work" do
      classroom = Classroom.first
      classroom_data = {
        classroom: {
          designation: classroom.designation + " extra stuff"
        }
      }

      patch classroom_path(classroom), params: classroom_data
      must_redirect_to classroom_path(classroom)

      Classroom.first.designation.must_equal classroom_data[:classroom][:designation]
    end

    it "responds with bad_request for bogus data" do
      classroom = Classroom.first
      classroom_data = {
        classroom: {
          designation: ""
        }
      }

      patch classroom_path(classroom), params: classroom_data
      must_respond_with :bad_request

      # Make sure that what's in the database still matches
      # what we had before
      Classroom.first.designation.must_equal classroom.designation
    end

    it "returns 404 for a classroom that DNE" do
      classroom_data = {
        classroom: {
          designation: "test designation"
        }
      }
      classroom_id = Classroom.last.id + 1
      patch classroom_path(classroom_id), params: classroom_data
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "destroys a classroom that exists" do
      start_count = Classroom.count

      classroom_id = Classroom.first.id
      delete classroom_path(classroom_id)
      must_redirect_to classrooms_path

      end_count = Classroom.count
      end_count.must_equal start_count - 1
    end

    it "returns 404 for a classroom that DNE" do
      start_count = Classroom.count

      classroom_id = Classroom.last.id + 1
      delete classroom_path(classroom_id)
      must_respond_with :not_found

      end_count = Classroom.count
      end_count.must_equal start_count
    end
  end
end
