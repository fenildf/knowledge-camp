module Mockup::ManagerNotGetMethods
  include Mockup::SampleData
  
  def manager_do_post
    case params[:req]
      when 'common'
        render json: {is_mockup: true}
      when 'create_course'
        post_create_course
      when 'create_chapter'
        post_create_chapter
      when 'create_ware'
        post_create_ware
      when 'create_subject'
        post_create_subject
      end
  end

  def post_create_course
    if params[:course][:name] == 'true'
      render json: {
        jump_url: mockup_manager_url(page: 'course_contents')
      }
    else
      render status: 422, json: {
        name: ['测试校验错误'],
        desc: ['测试校验错误']
      }
    end
  end

  def post_create_chapter
    render json: SAMPLE_CHAPTER_DATA.merge(
      id: randstr,
      create_ware_url:  mockup_manager_post_url(req: 'create_ware'),
      update_url:       mockup_manager_put_url(req: 'common'),
      move_up_url:      mockup_manager_put_url(req: 'common'),
      move_down_url:    mockup_manager_put_url(req: 'common'),
      delete_url:       mockup_manager_delete_url(req: 'common')
    )
  end

  def post_create_ware
    render json: SAMPLE_WARES_DATA[0].merge(
      id: randstr,
      update_url:     mockup_manager_put_url(req: 'common'),
      move_up_url:    mockup_manager_put_url(req: 'common'),
      move_down_url:  mockup_manager_put_url(req: 'common'),
      delete_url:     mockup_manager_delete_url(req: 'common')
    )
  end

  def post_create_subject
    render json: SAMPLE_CSUBJECTS_DATA[:items][0].merge(
      id: randstr,
      name: params[:subject][:name],
      slug: randstr,
      parent_id: params[:subject][:parent_id], 

      delete_url: mockup_manager_delete_url(req: 'common'),
      update_url: mockup_manager_post_url(req: 'common')
    )
  end

  # -------------------

  def manager_do_put
    case params[:req]
      when 'common'
        render json: {is_mockup: true}
      end
  end

  def manager_do_delete
    render json: {is_mockup: true}
  end
end