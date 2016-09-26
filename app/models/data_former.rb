class DataFormer
  include DataFormerConfig

  include ArticleFormer
  include CourseFormer
  include ChapterFormer
  include WareFormer
  include CourseSubjectFormer
  include UserFormer

  include PublishedCourseFormer
  include BusinessCategoryFormer
  include EnterprisePostFormer
  include EnterpriseLevelFormer

  include Finance::TellerWareFormer
  include Finance::TellerWareScreenFormer
  include Finance::TellerWareTradeFormer

  include QuestionFormer
  include NoteFormer

  include FileEntityFormer

  include CommentFormer

  def self.paginate_data(models)
    begin
      {
        total_pages: models.total_pages,
        current_page: models.current_page,
        per_page: models.limit_value
      }
    rescue
      {}
    end
  end
end
