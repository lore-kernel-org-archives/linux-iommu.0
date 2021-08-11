Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68CC4320A
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B64F260EC0
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 02:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B64F260EC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CB9981CE7;
	Wed, 11 Aug 2021 02:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsxLWl2zqhj2; Wed, 11 Aug 2021 02:44:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 32CC681D2D;
	Wed, 11 Aug 2021 02:44:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 103D0C0010;
	Wed, 11 Aug 2021 02:44:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C055C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ECB3A81959
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tvNY6E3OFkeF for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 02:44:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB395836C5
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 02:44:14 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 mq2-20020a17090b3802b0290178911d298bso2316338pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=32CCkzzdwlBxBR5R3R3lQIa/BUxHULX8DF1l6bUu8Gg=;
 b=MrvkA+8UoYyZJMGfbINoSZj40Z+N4JQ9I+NievWkQ2fR4dqQzEEvM7whbnBjgjGSmv
 l0nrF9dUjZOZJuu1L8+giXIxKKnkMMqME0MQSJQCkXZaC5uCZvyEgAU+e6jaPTaIs+Jt
 nWKhDYvv2sA5nS684Pwkv8J+1ViFVgH/xaDZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=32CCkzzdwlBxBR5R3R3lQIa/BUxHULX8DF1l6bUu8Gg=;
 b=fekyWZDAN6R34y0YbCVswVuPc8XsR74YD4DiyuAIvW9J9bOrxVu0kF8NCPyY8vEQh5
 34zZjOob3nqlq/q1AuEIN51t1cbBAUKf5vPzcNhI3Xwd5m938DIs2j+WUn0Okp0duEyI
 HJbz77TybUYM7n9S8mPGe/uYBGU6o5hQTaSiy5JID8TdSMRj8SHRA9dmOTwCqSc10App
 ww2eoEYrHn8bmYT0g1hfECjRyM0kD81pFTRpXqcwOk/NudHohnDZ1h+syTZQ8b6GAsfF
 IPlDhIEPRO5JxSEhUEpFSa5cD0o/KxRZRGgRoeqoOPJ2Dh0qP/JQRRD1JPBhRoMfbgK4
 8Xng==
X-Gm-Message-State: AOAM532M4Jr4ZzIMuuJxpfn8zt6Va01yD6cZttk5G/tVJPqNf49/88oU
 8iUqxqn1NisfGt14XAy8dDb7sQ==
X-Google-Smtp-Source: ABdhPJy2axgHyiRzRqB0mBc5KbCk2yWjNcqP8qah7TL56kK7YEtNcGf0hUpmuLezpBSWmj7A8FmJjw==
X-Received: by 2002:a65:6099:: with SMTP id t25mr239595pgu.85.1628649854506;
 Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:1e5c:70cb:3289:1b5b])
 by smtp.gmail.com with UTF8SMTPSA id 128sm890278pfe.55.2021.08.10.19.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Aug 2021 19:44:14 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
Date: Wed, 11 Aug 2021 11:42:44 +0900
Message-Id: <20210811024247.1144246-3-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210811024247.1144246-1-stevensd@google.com>
References: <20210811024247.1144246-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>
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

When calling arch_sync_dma, we need to pass it the memory that's
actually being used for dma. When using swiotlb bounce buffers, this is
the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
helper, so it can use the bounce buffer address if necessary. This also
means it is no longer necessary to call iommu_dma_sync_sg_for_device in
iommu_dma_map_sg for untrusted devices.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 54e103b989d9..4f0cc4a0a61f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		memset(padding_start, 0, padding_size);
 	}
 
+	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(phys, org_size, dir);
+
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
 		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
@@ -848,14 +851,9 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
+	return __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
 			coherent, dir, attrs);
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    dma_handle != DMA_MAPPING_ERROR)
-		arch_sync_dma_for_device(phys, size, dir);
-	return dma_handle;
 }
 
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
@@ -998,12 +996,12 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
-
 	if (dev_is_untrusted(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
-- 
2.32.0.605.g8dce9f2422-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
