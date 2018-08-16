/*
这是一个基础的函数合集
它包括一系列能够增加工作效率的函数
只需要运行这个脚本即可自动添加这些函数
****该文件适用于SQL Server****
*/
--这里面的函数可能会随着使用会不定期增加和优化
--记得随时跟进运行此SQL脚本
------------------------------------
--目录
------------------------------------
/*─│├└********善用ctrl+F搜索********
├─字符串操作
  ├─1.切割字符串
  │ └select dbo.cutStrByPar(<字符串>,<分割标志>,<分组序号>) FROM <TABLE>

*/
------------------------------------
--初始化
------------------------------------
--删除已有函数，并重新创建他们，以免出现冲突（适用于算法优化）
    DROP FUNCTION dbo.cutStrByPar --1.1

------------------------------------
--函数集
------------------------------------
--1.1 切割字符串
    --返回字符串中特定的部分
    --三个参数（<字符串><分隔符><部位编号>）
    --用法select dbo.cutStrByPar([UID],',',2) FROM JE，意为：返回uid列字符串中以逗号分隔的第二组字符串
        CREATE FUNCTION dbo.cutStrByPar(@target nvarchar(MAX)='0',@par nvarchar(255)=',',@order int)
        RETURNS nvarchar(MAX) 
        AS
        begin
            DECLARE @targetString nvarchar(MAX)
            DECLARE @d int
            DECLARE @c int
            select @d=0
            select @c=CHARINDEX(@par,@target)
            while @order>1
            begin
                if @order=2
                begin
                    select @d=CHARINDEX(@par,@target,@c)
                end
                select @c=CHARINDEX(@par,@target,@c+1)
                select @order=@order-1
            end
            if @c=0
            begin
                SELECT @targetString = right(@target,len(@target)-@d)
            end
            else
            begin
                SELECT @targetString = substring(@target,@d+1,@c-@d-1)
            end
            return @targetString
        end