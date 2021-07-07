Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B779C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA0861CB3
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 07:55:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA0861CB3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E273C83300;
	Wed,  7 Jul 2021 07:55:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGMehaPH6vQV; Wed,  7 Jul 2021 07:55:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C310983252;
	Wed,  7 Jul 2021 07:55:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FA7BC0010;
	Wed,  7 Jul 2021 07:55:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09B26C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFBB2400F4
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 90Cvmyo7nv1Y for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 07:55:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AF6A4000B
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 07:55:30 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 p14-20020a17090ad30eb02901731c776526so876370pju.4
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uGEeUgmKAJ+AMwE86QaIOFXRPTohU9n1eBXMqjimMhw=;
 b=C6uhEJCNPMqgdWKMTIwMcE72fXDVHxSVB5iPOxhZ1LxLff61nIukpV1idzH1n4hbim
 Uk+6DRwVgIZTfXIMMb+IEhmyuhgU1X+kHc18IhP1IL0TdWiPa6z8dCEL5CfTK5ECjB0i
 fz1rGSHN0UPfsOGJmIIVTkLtfvL7K3NVAFgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uGEeUgmKAJ+AMwE86QaIOFXRPTohU9n1eBXMqjimMhw=;
 b=GiHqMQrnx6+MVJ1ZDz7HQxo/1a0oDHH6aQNDMRS/BXs10Kw5UKDwfIEjyR4tQwKRcq
 TwEF39hMSaGa2tvjWsigPOJ3In2CrgJINpP+Rf65Tm9Vqb4FvXLjeSs91Wt66eRQL8Tk
 2ZV2VRJ0RqQio/KPGb6O8hO1DrNFH2miBjG+nKh0ZIkUGK52zpL0BK26a29EE5s5XHz/
 BI+o7E/XpL4IjGUkQW2heSZQKqhwzAuKmC40tAMU1txDMI4TMGstluoqaA5keQAl0bHX
 wkM6oL/yLHIil2m9QE8aQ3rhyvsTwEWIUhAOE6T4NcxyAyF8AqAnHh4dAyApx/QflK0q
 Oisw==
X-Gm-Message-State: AOAM5304ly3MqkAyh50+ILU+B6By0kS/SDgUQeWbYnEaBSWBLtmFHVwP
 qhTpFXAq3d8NZ0iL403vp6dnyQ==
X-Google-Smtp-Source: ABdhPJz8OC0dxdmIRWsGcK94nsbwAUwXodh/VqsMrx7+HVDTL6k6AHKA2UIOnTwNTGrCHmXcwXgdSw==
X-Received: by 2002:a17:90a:6942:: with SMTP id
 j2mr18736528pjm.9.1625644529837; 
 Wed, 07 Jul 2021 00:55:29 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:355a:c470:1237:e5f4])
 by smtp.gmail.com with UTF8SMTPSA id c24sm22522018pgj.11.2021.07.07.00.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 00:55:29 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/4] dma-iommu: add kalloc gfp flag to alloc helper
Date: Wed,  7 Jul 2021 16:55:02 +0900
Message-Id: <20210707075505.2896824-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210707075505.2896824-1-stevensd@google.com>
References: <20210707075505.2896824-1-stevensd@google.com>
MIME-Version: 1.0
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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

From: David Stevens <stevensd@chromium.org>

Add gfp flag for kalloc calls within __iommu_dma_alloc_pages, so the
function can be called from atomic contexts.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 614f0dd86b08..00993b56c977 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -593,7 +593,8 @@ static void __iommu_dma_free_pages(struct page **pages, int count)
 }
 
 static struct page **__iommu_dma_alloc_pages(struct device *dev,
-		unsigned int count, unsigned long order_mask, gfp_t gfp)
+		unsigned int count, unsigned long order_mask,
+		gfp_t page_gfp, gfp_t kalloc_gfp)
 {
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
@@ -602,15 +603,15 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	if (!order_mask)
 		return NULL;
 
-	pages = kvzalloc(count * sizeof(*pages), GFP_KERNEL);
+	pages = kvzalloc(count * sizeof(*pages), kalloc_gfp);
 	if (!pages)
 		return NULL;
 
 	/* IOMMU can map any pages, so himem can also be used here */
-	gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
+	page_gfp |= __GFP_NOWARN | __GFP_HIGHMEM;
 
 	/* It makes no sense to muck about with huge pages */
-	gfp &= ~__GFP_COMP;
+	page_gfp &= ~__GFP_COMP;
 
 	while (count) {
 		struct page *page = NULL;
@@ -624,7 +625,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 		for (order_mask &= (2U << __fls(count)) - 1;
 		     order_mask; order_mask &= ~order_size) {
 			unsigned int order = __fls(order_mask);
-			gfp_t alloc_flags = gfp;
+			gfp_t alloc_flags = page_gfp;
 
 			order_size = 1U << order;
 			if (order_mask > order_size)
@@ -680,7 +681,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 
 	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
 	pages = __iommu_dma_alloc_pages(dev, count, alloc_sizes >> PAGE_SHIFT,
-					gfp);
+					gfp, GFP_KERNEL);
 	if (!pages)
 		return NULL;
 
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
