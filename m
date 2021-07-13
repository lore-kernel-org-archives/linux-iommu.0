Return-Path: <SRS0=kZfo=MF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD2FC11F68
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62FE661178
	for <iommu@archiver.kernel.org>; Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FE661178
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40C6283B14;
	Tue, 13 Jul 2021 17:24:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HxqvdUcifd3F; Tue, 13 Jul 2021 17:24:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 31D8883B1A;
	Tue, 13 Jul 2021 17:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B97AC001A;
	Tue, 13 Jul 2021 17:24:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D083C001A
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 29F8B60AAB
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sguNITlVLdUP for <iommu@lists.linux-foundation.org>;
 Tue, 13 Jul 2021 17:24:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D9EE60AC9
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 17:24:52 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id p9so12538662pjl.3
 for <iommu@lists.linux-foundation.org>; Tue, 13 Jul 2021 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
 b=fp5UYghHE6KtNxD2b1E0TGw4ywdgqHo3DOU3XSqTy6BSP+SAI8jHkwFLuZ3ATi7uL7
 HjFY+YKKSKQxJnesW4N/MjEkeeaYVa2kZfvqQdMInA1LUAY8z9UzZoIZyNj0wwhanH6v
 3d+GTNcVYLKF7perJ0FNaJBkN3n1kPPP72ZTBnwddzBr6bJmzb+Ku+B7cKY3gSLLUyo5
 tSMYW9YA+TYgOZ/6cIergAnS2FhUUb1eYasucW6nue4Zriipvxl0wH6ukQ7MAfni27p4
 pxn2NKJeWfNWA8icoA7xTgm8dxFPhK+yt3T7OkHyih+olTmCWENmbEaRjt6gOQImN4qv
 QbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZOtpaC4Ypd4T1gRyw7mWdmcY15YhrZKpr6JIl6t/8bQ=;
 b=XlhU+k3xDSWQhTUg2up8WgtIBun+KnB/xrQU0EVFpHL397HuOu0IWhbZH0V4sefVXL
 wydIUQZZMAovNPcY9ESm6QYq1drANVku3c74Ap5aGGWhqbyiCYl6Yb263NkzS/6mCfU3
 /SB+squKuG35edalun4tVFYyDoGvlMU65RtErVlWetxkVHYko1L68neU0SdyWtbJaZbl
 kTEdbPzGcPirzP2y1Yysjt6XP4ySFb1pxQvUDP+F2NSPmCf5Z7QvF2iASiObXtVGTW8I
 KepJ2fW6ZI0vjhgGzRjxtZOb7fKgfoTsGZboSKGKZHUSbQyqcv0Cik/FNpJ88ssyZ2CZ
 nyGA==
X-Gm-Message-State: AOAM532onadKfi0RGVCz+qIMTKymdZopHBcQ2fViQ+E/fGW+agBw2c3y
 NpBkwUEcTTKjPERFInGEcZI=
X-Google-Smtp-Source: ABdhPJwDB3PHMILWk7WENii0WJjizUfXAPoiKBUBnI4U8E94UulJuRUPIXWr4LSf1rcBkQhpKrWnsA==
X-Received: by 2002:a17:90a:8407:: with SMTP id j7mr399030pjn.13.1626197092437; 
 Tue, 13 Jul 2021 10:24:52 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id lt14sm18239032pjb.47.2021.07.13.10.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jul 2021 10:24:51 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 3/7] iommu: Improve iommu_iotlb_gather helpers
Date: Tue, 13 Jul 2021 02:41:47 -0700
Message-Id: <20210713094151.652597-4-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713094151.652597-1-namit@vmware.com>
References: <20210713094151.652597-1-namit@vmware.com>
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
 drivers/iommu/mtk_iommu.c |  6 +-----
 include/linux/iommu.h     | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6f7c69688ce2..d9939e4af35c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -520,12 +520,8 @@ static size_t mtk_iommu_unmap(struct iommu_domain *domain,
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
