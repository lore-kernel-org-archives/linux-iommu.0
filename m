Return-Path: <SRS0=69++=LC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12CBC47094
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C94F60FEE
	for <iommu@archiver.kernel.org>; Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C94F60FEE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54E90403F9;
	Tue,  8 Jun 2021 01:55:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1kn6SZrEnvRu; Tue,  8 Jun 2021 01:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8E35403DF;
	Tue,  8 Jun 2021 01:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8357C000E;
	Tue,  8 Jun 2021 01:55:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC47C0001
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 183C5403DF
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id akLoNnVKo7zK for <iommu@lists.linux-foundation.org>;
 Tue,  8 Jun 2021 01:55:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BB151403EA
 for <iommu@lists.linux-foundation.org>; Tue,  8 Jun 2021 01:55:26 +0000 (UTC)
Received: by mail-pf1-x42d.google.com with SMTP id q25so14504085pfh.7
 for <iommu@lists.linux-foundation.org>; Mon, 07 Jun 2021 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a5Q03kPB9N31Dxz5JpgFwNRhEHR7Ck7FkWGxbrLez1o=;
 b=MmLsD0VYye5jr8qllapIW+sULNF1AqgI9y2nx0BegR+bTMbQ2Hfsv+TVMqg8Eqfnbl
 mfq0nXiK0HKYzuDVdn0d6/aC4iMXJF8oZ/YQhRuhW/KJS7zvmnNKKP9Z1Xpp7NsdRmBY
 lFxqMbHPN55xVsBkDq/mWF0RQxk73S43HBdlnln22aD8EJQbR0eEzqhV2atNiUNlSWMW
 H0gyaW/LvxoWJM1RK8db7LbeOpjHrQAXDbqQKdqYfX5AbNexcyKTrsupYfM9OAUtO1C9
 VzxRKtyZvoXDM/aaoHk3lbldaavnmLEQXO2Td98VDXOni+4LmNP/zZgCpTYIV7hwm/mT
 iJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a5Q03kPB9N31Dxz5JpgFwNRhEHR7Ck7FkWGxbrLez1o=;
 b=KkMfDCczfT8EwkG+ZL0Phz6voNRu/1KSBvB857mVLVoP87XSj1uZpihnMLK+tDZjat
 +PuGxw8fIt1tim7wu3uacNwqtujRAjH20No6tsgmOcj0HSko6re61DxqzEK4lVANxeSh
 4RUsxAyzVWpf2k5piKLvwtdCDIYb9Gp2LUKku1ULrUqNWj/dG8gpzFiuAIoWlQeRvZ3y
 jHFjA17uTvUjYK/EByG8Dj+VpX2vuBEmLR8oGZ9Ubs+EclXCkQHC5IuHI8f3wTV2uITQ
 /jjyq+hmHK58NMLw7N+ddJw6W1n3f6Hx1t5JyiVilr33zBn5IxwmRx+hD55e3wut3qNq
 MZWw==
X-Gm-Message-State: AOAM532lZ4fi2LIjmhtoCn2dXjMgg9t8fr6hEjunzbb45QLbJNIiLjjR
 HZpVlakmy7nv0O3MKkPSjyo=
X-Google-Smtp-Source: ABdhPJySj6bY3RLL5G2GGlLOcMIbtH6J1GqfmqQkYZySvs5JdXKnRZ6oPYN23g6N0eNUQOOcCrT6bA==
X-Received: by 2002:aa7:8114:0:b029:2e9:c437:1121 with SMTP id
 b20-20020aa781140000b02902e9c4371121mr19464441pfi.7.1623117326092; 
 Mon, 07 Jun 2021 18:55:26 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
 by smtp.gmail.com with ESMTPSA id s24sm9284767pfh.104.2021.06.07.18.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jun 2021 18:55:25 -0700 (PDT)
From: Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 4/6] iommu: Factor iommu_iotlb_gather_is_disjoint() out
Date: Mon,  7 Jun 2021 11:25:39 -0700
Message-Id: <20210607182541.119756-5-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607182541.119756-1-namit@vmware.com>
References: <20210607182541.119756-1-namit@vmware.com>
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

From: Nadav Amit <namit@vmware.com>

Refactor iommu_iotlb_gather_add_page() and factor out the logic that
detects whether IOTLB gather range and a new range are disjoint. To be
used by the next patch that implements different gathering logic for
AMD.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Jiajun Cao <caojiajun@vmware.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/iommu.h | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f254c62f3720..b5a2bfc68fb0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -497,6 +497,28 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 	iommu_iotlb_gather_init(iotlb_gather);
 }
 
+/**
+ * iommu_iotlb_gather_is_disjoint - Checks whether a new range is disjoint
+ *
+ * @gather: TLB gather data
+ * @iova: start of page to invalidate
+ * @size: size of page to invalidate
+ *
+ * Helper for IOMMU drivers to check whether a new range is and the gathered
+ * range are disjoint. For many IOMMUs, flushing the IOMMU in this case is
+ * better than merging the two, which might lead to unnecessary invalidations.
+ */
+static inline
+bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t size)
+{
+	unsigned long start = iova, end = start + size - 1;
+
+	return gather->end != 0 &&
+		(end + 1 < gather->start || start > gather->end + 1);
+}
+
+
 /**
  * iommu_iotlb_gather_add_range - Gather for address-based TLB invalidation
  * @gather: TLB gather data
@@ -533,20 +555,16 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
-	unsigned long start = iova, end = start + size - 1;
-
 	/*
 	 * If the new page is disjoint from the current range or is mapped at
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
-	    end + 1 < gather->start || start > gather->end + 1) {
-		if (gather->pgsize)
-			iommu_iotlb_sync(domain, gather);
-		gather->pgsize = size;
-	}
+	if ((gather->pgsize && gather->pgsize != size) ||
+	    iommu_iotlb_gather_is_disjoint(gather, iova, size))
+		iommu_iotlb_sync(domain, gather);
 
+	gather->pgsize = size;
 	iommu_iotlb_gather_add_range(gather, iova, size);
 }
 
@@ -730,6 +748,13 @@ static inline void iommu_iotlb_sync(struct iommu_domain *domain,
 {
 }
 
+static inline
+bool iommu_iotlb_gather_is_disjoint(struct iommu_iotlb_gather *gather,
+				    unsigned long iova, size_t size)
+{
+	return false;
+}
+
 static inline void iommu_iotlb_gather_add_range(struct iommu_iotlb_gather *gather,
 						unsigned long iova, size_t size)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
