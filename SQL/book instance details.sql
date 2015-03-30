
--return bookInstance details, including status and dateDue
SELECT [b].[BookId], [Isbn], [Title], [Edition], [Summary], [bi].[BookInstanceId], [CallNumber],
CASE WHEN (SELECT ReturnDate FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND [l].[LoanId] IN 
(SELECT MAX(LoanId) FROM  Loans AS [l2] WHERE [l2].[BookInstanceId] = [bi].[BookInstanceId] ) ) 
IS NULL AND 
EXISTS (SELECT [l].[Date] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId])
THEN 'CHECKED-OUT' ELSE 'Available' END AS [Status],
CASE WHEN (SELECT [l].[DateDue] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND ReturnDate IS NULL) IS NOT null
THEN (SELECT [l].[DateDue] FROM Loans AS [l] WHERE [l].[BookInstanceId]=[bi].[BookInstanceId] AND ReturnDate IS NULL) ELSE null END AS [DateDue]
FROM Books AS b 
INNER JOIN 
BooksInstances AS bi
ON [b].[BookId]=[bi].[BookId]
WHERE [b].[BookId] = @pARAMETER
ORDER BY [b].[Title]