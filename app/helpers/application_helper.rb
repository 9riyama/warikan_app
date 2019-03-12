module ApplicationHelper
  
  def ymconv(yyyymm)
    yyyy = yyyymm[0,4]
    mm = yyyymm[4,2]
    return yyyy + "年" + mm + "月の生活費"
  end
end
