Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86D6C433EF
	for <iommu@archiver.kernel.org>; Thu, 23 Jun 2022 09:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3091C84719;
	Thu, 23 Jun 2022 09:36:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3091C84719
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=I5KTYmG2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3WYUHZB2YKc4; Thu, 23 Jun 2022 09:36:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1475084714;
	Thu, 23 Jun 2022 09:36:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1475084714
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA7E5C0039;
	Thu, 23 Jun 2022 09:36:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB08AC002D
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5DAE405A9
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:36:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E5DAE405A9
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com
 header.a=rsa-sha256 header.s=mail20170921 header.b=I5KTYmG2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FOJ--1eELAnG for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jun 2022 09:36:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7BF32410D1
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7BF32410D1
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:36:45 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220623093642euoutp02d70dd6fa2a7ad8dc457a57ae6e9b3fc9~7Nk9hYy0q2398023980euoutp02c
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jun 2022 09:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220623093642euoutp02d70dd6fa2a7ad8dc457a57ae6e9b3fc9~7Nk9hYy0q2398023980euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1655977002;
 bh=9SQtRTmptlpX2eGqJJoi05MYv1nLRS8ShWrPfcmNEaw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=I5KTYmG2tTce9CcgLVSxT7XlipMQ/xd4waCzqg+6vYLjSR5g5vSLjiVW2PtqFUoBz
 /n6swMWDAOok5dJOaUTMfFTvJR5gEdx0PVUr9ygTzq7mc2rfpwcRzQOCnypC/1bDsa
 01DggtrJh/veLpDb/EsWMFBmjP9xFDJqTItYLZt8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220623093642eucas1p240329f627c8647972b312064db90f603~7Nk9OxwLv3038830388eucas1p2-;
 Thu, 23 Jun 2022 09:36:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 49.11.09664.A2434B26; Thu, 23
 Jun 2022 10:36:42 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81~7Nk81hrsl1208412084eucas1p16;
 Thu, 23 Jun 2022 09:36:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220623093641eusmtrp22ad7045aa6572c61bfa82bbf1e156f44~7Nk80tqCu0744107441eusmtrp2K;
 Thu, 23 Jun 2022 09:36:41 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-cb-62b4342a0565
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id F6.9E.09038.92434B26; Thu, 23
 Jun 2022 10:36:41 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20220623093641eusmtip2781fa68136cb39eb46e90a6c20c72eeb~7Nk8hdbQb1899918999eusmtip2F;
 Thu, 23 Jun 2022 09:36:41 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] iommu/exynos: Make driver independent of the system page size
Date: Thu, 23 Jun 2022 11:36:29 +0200
Message-Id: <20220623093629.32178-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7djPc7paJluSDF5s47FYsN/aonP2BnaL
 Gef3MVmsPXKX3eLghyesDqweTw7OY/JYM28No8fkG8sZPfq2rGL0+LxJLoA1issmJTUnsyy1
 SN8ugSvjzqkGpoKp3BVbzu1kaWBcwNnFyMkhIWAi8XHCb7YuRi4OIYEVjBLbH+xih3C+MEpM
 fdDMBOF8ZpTobTvJDtNy9ucaZojEckaJxhfLWOFa1hz4zAJSxSZgKNH1tosNxBYRcJe4/uc5
 WJxZoEzi/P1HYLawQIDEhBnrwWwWAVWJh1sug9m8ArYS96evZYTYJi+xesMBsG0SAm/ZJV40
 9DNDJFwknm6YygJhC0u8Or4F6jwZif875wPdzQFk50v8nWEMEa6QuPZ6DVSrtcSdc7/YQEqY
 BTQl1u/Shwg7Snz/fpUVopNP4sZbQYiL+SQmbZvODBHmlehoE4KoVpOYdXwd3M6DFy5BlXhI
 bJwUABIWEoiVaLy6mH0Co9wshFULGBlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBEb8
 6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8L/5vThLiTUmsrEotyo8vKs1JLT7EKM3BoiTOm5y5
 IVFIID2xJDU7NbUgtQgmy8TBKdXAlJY3d0ue5LoJjI3O007ff3f7558DSptYt25xuPQ0wHvS
 A6Hnu9e8mTXd/PTmmilWQRuOm6cY+t+WXtAcZJ/QXsrcxbtox+v4Ty/NhN9MXBfjHrPP2kuD
 c8JHrhUbrBtmSh97pdyQ6jNfpWK+rfbpjwd2Swu2/t8p+f/45DQWkwKjHPYVfs9ffrmQKHO+
 aa/2IR8zy8z8rU+F739ck6P86Oy2Mnu/la6ntn4Rs1TZYeZ9zvvcfQP/i4ZSrcdSTf9NWbCo
 UNZuZoJw7fbPgr8YA0L+Jfy13Su5y6vFfaZnxPvJdx/IFKz7dHjz+fsfPxbzqa0pbNSb+Nfu
 pajTZ5Vdzdo9irvFGr9Mk1k5raAms1GJpTgj0VCLuag4EQB7ZCzpZwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFLMWRmVeSWpSXmKPExsVy+t/xe7qaJluSDNbf1LNYsN/aonP2BnaL
 Gef3MVmsPXKX3eLghyesDqweTw7OY/JYM28No8fkG8sZPfq2rGL0+LxJLoA1Ss+mKL+0JFUh
 I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/jzqkGpoKp3BVbzu1k
 aWBcwNnFyMkhIWAicfbnGmYQW0hgKaPEipXKEHEZiZPTGlghbGGJP9e62LoYuYBqPjFKdOx5
 AtbAJmAo0fUWJMHJISLgKTHzbQtQAwcHs0CFRPsFfhBTWMBP4vpfJpAKFgFViYdbLrOA2LwC
 thL3p69lhBgvL7F6wwHmCYw8CxgZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgQG2rZjP7fs
 YFz56qPeIUYmDsZDjBIczEoivC/+b04S4k1JrKxKLcqPLyrNSS0+xGgKtG8is5Rocj4w1PNK
 4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpiWBLGZW35L3cDCZi/L
 L/U9Yqn9X/l7kqf2q6eU3/M6UPDFk3ulRt1cwz1Js+3rd3q73i+UOvudf4nA2r47QbWKagHX
 9Z40z3HZc6fclm86c1NHd/7P3p8lzSd2ccm59HaWljdzJt3U2JAwZX0sW5150vw4Z5uztTPO
 ZEyuv1k70/Tv3kuKLiefftHsl/+9JvObrtDCVfskNSp+hu9VYbeo8fEJ9GveyTd7y1SGAs2/
 W6unC+3p+q50i2e99RKFzjidYo69Njy8bzxlVZ7dENmZYfhXYOIlcZc5e9n5S07ERV1uOKFx
 z++fkcxaM+MVn1y00iMPXmn7ztS7eXZR9RxFJjkbD1vJmKTfU3otlFiKMxINtZiLihMBxmWq
 q70CAAA=
X-CMS-MailID: 20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81
X-Msg-Generator: CA
X-RootMTR: 20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81
References: <CGME20220623093641eucas1p11732bf2c875960f7a2bb1d6fe053bc81@eucas1p1.samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PAGE_{SIZE,SHIFT} macros depend on the configured kernel's page size, but
the driver expects values calculated as for 4KB pages. Fix this.

Reported-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Untested, because Exynos based boards I have doesn't boot with non-4KB
page size for other reasons.
---
 drivers/iommu/exynos-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 71f2018e23fe..9c060505a46e 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -340,8 +340,7 @@ static void __sysmmu_set_ptbase(struct sysmmu_drvdata *data, phys_addr_t pgd)
 	if (MMU_MAJ_VER(data->version) < 5)
 		writel(pgd, data->sfrbase + REG_PT_BASE_ADDR);
 	else
-		writel(pgd >> PAGE_SHIFT,
-			     data->sfrbase + REG_V5_PT_BASE_PFN);
+		writel(pgd / SZ_4K, data->sfrbase + REG_V5_PT_BASE_PFN);
 
 	__sysmmu_tlb_invalidate(data);
 }
@@ -551,7 +550,7 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 		 * 64KB page can be one of 16 consecutive sets.
 		 */
 		if (MMU_MAJ_VER(data->version) == 2)
-			num_inv = min_t(unsigned int, size / PAGE_SIZE, 64);
+			num_inv = min_t(unsigned int, size / SZ_4K, 64);
 
 		if (sysmmu_block(data)) {
 			__sysmmu_tlb_invalidate_entry(data, iova, num_inv);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
