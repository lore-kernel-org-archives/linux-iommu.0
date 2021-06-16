Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0894C48BE8
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD4261356
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 17:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD4261356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 469B8404CA;
	Wed, 16 Jun 2021 17:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocf7tDsG7vRc; Wed, 16 Jun 2021 17:34:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4A84404BF;
	Wed, 16 Jun 2021 17:34:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF687C000D;
	Wed, 16 Jun 2021 17:34:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8778C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA73083227
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g7QeRrMxSpaP for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 17:34:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3F941831C1
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 17:34:28 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id t17so2578177pga.5
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 10:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dRmBSLhAuXxBVTuhCH5oFREPk0hy4CPzH2ZUQRDqv1I=;
 b=BQujgSI/SQuHMrtiNYyK9oa6Xkfiw5O6r5xaRKxR6ggIFV/lLfFN2U4CWDUguYX9UY
 9jpQBY6lck0rgEk9mvySpQp9laDFb9yNlYdGvZOlr3F4VijrCK63JKcT+e63tY4lPKc4
 urCyYX9XgencbyvDKb5mWWeUJpbjqbPrtdAMUkXSUL7YfIQyK2n68UakUcbe1Xnl+FX5
 eCuhPaLG2UK8XLqeUEs9M1G4jHPgnO/zdSFIi5NuznYdnN5a60txyM4Xixl4Qm409Uqf
 u/OPa6yktVFgohfdFrZ9OEVNWZuURcq3GgHDqrzDDozq7G9PSbAjaQ09Al6o5eoYKQ8h
 LaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dRmBSLhAuXxBVTuhCH5oFREPk0hy4CPzH2ZUQRDqv1I=;
 b=ixHhwC9/x5a4QvJylgDAIazC3aRVTMyLbsp5C94fM4QTeDtvdA1Jnv/XQSfQI59MVu
 612zHJpg8NacTIsC/INie2Wqbd4tPRTJrlKIk4JEGjP/rS12kyiicESvMy0qup10cLT4
 uv5uT06X+yvDzHc7SIZbnynOUydQbNvTiRfkyx0azy+j7SgROKXelzzAmUVBO7Z7Z/VU
 O5+7PV0FUnxi2mgzoHr2fsMmsGbrUueFhW9hu7tX2Sng/NeP9S8Qc6/zrvrgGPgG/jWp
 gOI05FP0MTbWO2OMKpZEyiZU89JCV1XZoRCKv4HvgZHFrHjymXfz8E1bpUNF1BzqfT6J
 CsaQ==
X-Gm-Message-State: AOAM532jZF7NDBIrtXDwzAE4NAlH45fEYVetPtrYRk8ZDYLj0ocxseaf
 Pq3mu0+WWQpGb6rahE/hGXQ=
X-Google-Smtp-Source: ABdhPJwB7O62mp8ypvQ1bWIM4zK7x+69bkrCnrTVjMC2IdH7tq14Fu/IrkgxzCLmHN30YuRsXaF7OQ==
X-Received: by 2002:a05:6a00:c2:b029:2ee:9cfc:af85 with SMTP id
 e2-20020a056a0000c2b02902ee9cfcaf85mr983338pfj.78.1623864867588; 
 Wed, 16 Jun 2021 10:34:27 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id m3sm2933901pfh.174.2021.06.16.10.34.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 10:34:27 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 3/7] iommu: Improve iommu_iotlb_gather helpers
Date: Wed, 16 Jun 2021 03:04:56 -0700
Message-Id: <20210616100500.174507-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616100500.174507-1-namit@vmware.com>
References: <20210616100500.174507-1-namit@vmware.com>
MIME-Version: 1.0
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Nadav Amit <namit@vmware.com>,
 Jiajun Cao <caojiajun@vmware.com>, Will Deacon <will@kernel.org>
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

From: Robin Murphy <robin.murphy@arm.com>

The Mediatek driver is not the only one which might want a basic
address-based gathering behaviour, so although it's arguably simple
enough to open-code, let's factor it out for the sake of cleanliness.
Let's also take this opportunity to document the intent of these
helpers for clarity.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nadav Amit <namit@vmware.com>

---

Changes from Robin's version:
* Added iommu_iotlb_gather_add_range() stub !CONFIG_IOMMU_API
* Use iommu_iotlb_gather_add_range() in iommu_iotlb_gather_add_page()
---
 drivers/iommu/mtk_iommu.c |  6 +-----
 include/linux/iommu.h     | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e06b8a0e2b56..cd457487ce81 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -521,12 +521,8 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
 			      struct iommu_iotlb_gather *gather)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
-	unsigned long end = iova + size - 1;
 
-	if (gather->start > iova)
-		gather->start = iova;
-	if (gather->end < end)
-		gather->end = end;
+	iommu_iotlb_gather_add_range(gather, iova, size);
 	return dom->iop->unmap(dom->iop, iova, size, gather);
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 32d448050bf7..e554871db46f 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -497,6 +497,38 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_iotlb_gather_init(iotlb_gather);
 }
 
+/**
+ * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build arbitrarily-sized invalidation commands
+ * where only the address range matters, and simply minimising intermediate
+ * syncs is preferred.
+ */
+static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
+						unsigned long iova, size_t size)
+{
+	unsigned long end = iova + size - 1;
+
+	if (gather->start > iova)
+		gather->start = iova;
+	if (gather->end < end)
+		gather->end = end;
+}
+
+/**
+ * iommu_iotlb_gather_add_page - Gather for page-based TLB invalidation
+ * @domain: IOMMU domain to be invalidated
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to build invalidation commands based on individual
+ * pages, or with page size/table level hints which cannot be gathered if they
+ * differ.
+ */
 static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
@@ -515,11 +547,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 		gather->pgsize = size;
 	}
 
-	if (gather->end < end)
-		gather->end = end;
-
-	if (gather->start > start)
-		gather->start = start;
+	iommu_iotlb_gather_add_range(gather, iova, size);
 }
 
 /* PCI device grouping function */
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
