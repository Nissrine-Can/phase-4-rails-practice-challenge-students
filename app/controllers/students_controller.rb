class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index 
       students = Student.all 
        render json: students
    end 

    def show 
        student = Student.find(params[:id])
        render json: student, serializer: StudentWithTeacherSerializer
    end

    def create 
        student = Student.create!(student_params)
        render json: student, status: :created
    end 

    private 

    def student_params 
        params.permit(:name, :major, :age)
    end
    def render_not_found_response
        render json: { error: "Student not found" }, status: :not_found
      end
    
      def render_unprocessable_entity_response(exception)
        render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
      end

end
