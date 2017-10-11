class Service
  def initialize(dependency)
    @dependency = dependency
  end

  def exec()
    {
      success: true,
      data: @dependency.call().merge!(c: 3)
    }
  end
end
