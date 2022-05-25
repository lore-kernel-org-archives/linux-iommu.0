Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15084C433F5
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 15:41:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B2558128A;
	Wed, 25 May 2022 15:41:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7TDSpOVj8htk; Wed, 25 May 2022 15:41:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8FBA581250;
	Wed, 25 May 2022 15:41:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72B43C0032;
	Wed, 25 May 2022 15:41:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA52EC002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 14:56:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E78F2842D6
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 14:56:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ihOejrxGRu91 for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 14:56:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E9AD842AD
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 14:56:22 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id j25so6056650wrb.6
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GRmrkmCITQkax/Dx9/Fy9p50J8k27ds4oFcgLc3FeZQ=;
 b=kvCQ65GYzcvSQpaiM0pwVax/xwd/9jvuxahiPnCLkSIX4BdbI1za5P7bpU9VlQK6ea
 BA61JlkSTP64rbEh2gh6mQSRNVUuHrRLTGz2EaNf9eCTprzJPKjfk4o2EsOhfyWD3wyW
 qFiFKPSQeqRTBUcI2uZ2EISBz0swMaw4t5qSQWe8jRRV+/EFhQWglN8/iqhPIZ9kvCbG
 CMiDsuK8/WE5ZlvxLcVOzJCPeSd0PESvhRpCRawDYukzTVVyIFbTR0/1YVsoeS2v55cT
 E66jCsl5nrzuTTzJUl2/2Z2JWWTxOgRayefQWFGxIoQgLoZopzRzn/1xE6QNoBPY+ll+
 RZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GRmrkmCITQkax/Dx9/Fy9p50J8k27ds4oFcgLc3FeZQ=;
 b=hNgoXLnl9JC09HUli4kLSxb1JLkX16kt4j+P+aQv/hivfd5Hl5viUhtlLhV+L3+zW+
 sK9fk73+LGAZimXNSE2gl2pA+jN2mZFZoZ1mRrzd30FSB+J1/XU3r6IWI8hAC+6qjkgf
 V/QAQbU3VL3xBArdi3xGhTFrQD9GiGrQUYwvQeVq1wugRYVAeJdY4MfsJug5FElxDmY3
 CzodrcKo4G52RBSsRgUypQglXxwMDn3zAbRGMvkrGPbGnqGQQoQcXIYuaA+vPRC3HXnH
 r4yeNFhN7AsMb7DFM1NqFrdBnycxEYP3TjYQA3HlpGXzLXNxXqt40/3VQCzl7leuf3NA
 rsiA==
X-Gm-Message-State: AOAM533MaH0GyLcMuDmAJG/7E9KWJ7Zc18QruPP5eCj7EsPqhmSh/Maa
 i9bUDgqAR34FerYYN3/p5q9our53mvI=
X-Google-Smtp-Source: ABdhPJzN/+hdpLVh3Tf15FuI+QNff0WX1WTfvz9VDPa84g7vY4sBJBxH+JDHaGZnaFnCPPm7JH02NQ==
X-Received: by 2002:a5d:5310:0:b0:20f:d075:a386 with SMTP id
 e16-20020a5d5310000000b0020fd075a386mr15953145wrv.619.1653490580047; 
 Wed, 25 May 2022 07:56:20 -0700 (PDT)
Received: from localhost.localdomain (93-103-18-160.static.t-2.net.
 [93.103.18.160]) by smtp.gmail.com with ESMTPSA id
 a19-20020a05600c349300b00397071b10dfsm2168896wmq.10.2022.05.25.07.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 May 2022 07:56:19 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Use try_cmpxchg64 in alloc_pte and free_clear_pte
Date: Wed, 25 May 2022 16:54:16 +0200
Message-Id: <20220525145416.10816-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 25 May 2022 15:41:28 +0000
Cc: Will Deacon <will@kernel.org>, Uros Bizjak <ubizjak@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Use try_cmpxchg64 instead of cmpxchg64 (*ptr, old, new) != old in
alloc_pte and free_clear_pte.  cmpxchg returns success in ZF flag, so this
change saves a compare after cmpxchg (and related move instruction
in front of cmpxchg). Also, remove racy explicit assignment to pteval
when cmpxchg fails, this is what try_cmpxchg does implicitly from
*pte in an atomic way.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Will Deacon <will@kernel.org>
---
 drivers/iommu/amd/io_pgtable.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 6608d1717574..7d4b61e5db47 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -258,7 +258,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
 
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte)
+			if (!try_cmpxchg64(pte, &__pte, __npte))
 				free_page((unsigned long)page);
 			else if (IOMMU_PTE_PRESENT(__pte))
 				*updated = true;
@@ -341,10 +341,8 @@ static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *freelist)
 	u64 *pt;
 	int mode;
 
-	while (cmpxchg64(pte, pteval, 0) != pteval) {
+	while (!try_cmpxchg64(pte, &pteval, 0))
 		pr_warn("AMD-Vi: IOMMU pte changed since we read it\n");
-		pteval = *pte;
-	}
 
 	if (!IOMMU_PTE_PRESENT(pteval))
 		return;
-- 
2.35.3

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
