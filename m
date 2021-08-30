Return-Path: <SRS0=sxdJ=NV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241D8C432BE
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D994560F92
	for <iommu@archiver.kernel.org>; Mon, 30 Aug 2021 05:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D994560F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABAE94042D;
	Mon, 30 Aug 2021 05:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OrYEEQd_3zd6; Mon, 30 Aug 2021 05:00:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C95F403DE;
	Mon, 30 Aug 2021 05:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BB9BC0010;
	Mon, 30 Aug 2021 05:00:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4B39C000E
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 987B560757
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yeKD8TcT_Xvn for <iommu@lists.linux-foundation.org>;
 Mon, 30 Aug 2021 05:00:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF88E60753
 for <iommu@lists.linux-foundation.org>; Mon, 30 Aug 2021 05:00:23 +0000 (UTC)
Received: by mail-pg1-x535.google.com with SMTP id 17so12282812pgp.4
 for <iommu@lists.linux-foundation.org>; Sun, 29 Aug 2021 22:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p0M0LPeLb2bO15/S2RN1fSV7prFIeL6kElwekRN6sTw=;
 b=S3yczAZAkq/yaayh+fEIYgG+OGimGvZhH5pW0o5+iovC3ow6Pk74+0Zxt6ggbkLOWo
 jgqbWPwxirW+0jI7jK/G+8PoBahK0AljG8xIU1D9eBSChiDAi+8LgtjP5FTYzbLou8HO
 8eaM4Z7+N/BJtFEUFc/6fL1rKFHNVJoC+DVk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p0M0LPeLb2bO15/S2RN1fSV7prFIeL6kElwekRN6sTw=;
 b=D/7uJ8uiQZOB8FGohK1RAQZIFHB+2x/uc38FcGMPwuYiaTr2YujppgoUDtN6DkJ3vC
 k4gdFpHK4YuPV8K56sPCtHGWDXLi+5S8Q9Id/j101HoTj2k360hKHHH9sDhjf1/6u4ot
 nj5zJMTVnnpiGAno+jNLmdGdiRH2DNfZAz60GplWi/FSxcWFuElZwD6ObAtaPc2w1eD/
 2xHpq113FBFZCXIvLK5Qwy5YSbz+HlCWWbkARKrWr3amAHhBgK3xpxu7VmcdhFh+fwAG
 18msCMAEBxwr4q55yi/VkgJcX7+brZDuq3CiaQ9rvXgKWNSL1gGOy1YOw74HaeRYjL1G
 fsug==
X-Gm-Message-State: AOAM532bdCUXIUkRh7RiouamagqGWDXOgX258GB+1X6VGcXPwRdfZviB
 GeNYrWfTqLAib9mxeN5mevpTQA==
X-Google-Smtp-Source: ABdhPJwReaCNJJnrv/elBCRGZOUsyg/AsxzC4aoA//Ej0ZUib5Qnw5rAjliODJvign4dDnuvDxNHtg==
X-Received: by 2002:a05:6a00:228a:b0:3e1:a0b2:535b with SMTP id
 f10-20020a056a00228a00b003e1a0b2535bmr21407462pfe.5.1630299623159; 
 Sun, 29 Aug 2021 22:00:23 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:28a5:1b9f:af1d:5542])
 by smtp.gmail.com with UTF8SMTPSA id q21sm15506738pgk.71.2021.08.29.22.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Aug 2021 22:00:22 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date: Mon, 30 Aug 2021 13:59:21 +0900
Message-Id: <20210830045925.4163412-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
In-Reply-To: <20210830045925.4163412-1-stevensd@google.com>
References: <20210830045925.4163412-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Rajat Jain <rajatja@google.com>, Will Deacon <will@kernel.org>
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

Calling the iommu_dma_sync_*_for_cpu functions during unmap can cause
two copies out of the swiotlb buffer. Do the arch sync directly in
__iommu_dma_unmap_swiotlb instead to avoid this. This makes the call to
iommu_dma_sync_sg_for_cpu for untrusted devices in iommu_dma_unmap_sg no
longer necessary, so move that invocation later in the function.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/dma-iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 12197fdc3b1c..abc528ed653c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -521,6 +521,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	if (WARN_ON(!phys))
 		return;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
@@ -870,8 +873,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1079,14 +1080,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
-
 	if (dev_is_untrusted(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.33.0.259.gc128427fd7-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
