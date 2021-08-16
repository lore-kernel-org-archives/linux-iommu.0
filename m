Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B4C432BE
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9C461458
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 02:59:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A9C461458
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D97D40204;
	Mon, 16 Aug 2021 02:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nW_S0jOR2SN; Mon, 16 Aug 2021 02:59:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7D6BE40228;
	Mon, 16 Aug 2021 02:59:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C94C001A;
	Mon, 16 Aug 2021 02:59:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 188A1C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 082F3402C1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-M4SMmafh_I for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 02:59:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1DFA54017D
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 02:59:34 +0000 (UTC)
Received: by mail-pj1-x1030.google.com with SMTP id
 u13-20020a17090abb0db0290177e1d9b3f7so30184357pjr.1
 for <iommu@lists.linux-foundation.org>; Sun, 15 Aug 2021 19:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/W+vSgwB4JE0r8Dwuz6/SM/DZ1++krnjsG0UhcUWbEs=;
 b=Jl6EC+NAyTbfNS7jUTmbm7eH62FigekPVFVSy0bGiiXXpAixnUU1bA4pHE0C3xTOzc
 v4yBas0Shz3pahQ+rIlHfTn7P0EgCM29nVtV2Fvr6hMTY0xTxv5S1sVLiXqd6qbkLvfR
 tw6VxlHIuauqbpFLysiJ0mdqNm6lchod/ibtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/W+vSgwB4JE0r8Dwuz6/SM/DZ1++krnjsG0UhcUWbEs=;
 b=cHYYmIsmvh8WY7WGxXTlMbWiJVu7jvX4TPJZRzzdoQKL3UNJ8WzyJQbet2CwcUxve/
 xWiYb4mdJmwg2O1ePV8GnyVyX1SUh5ZL54C88b5u2CGl0jF5fV3oEkAqp/QANOMDvG02
 wiBkv5HgR0/hI6ViJh+CGJ/dJfyAFv27KV4+ksbu0jha8KE5Pk78Y57uXEyKCC09Bbgp
 k+Xuvt8Ea36EBMjjd1dhKHG8hshaiZ5J7AZOOIbOCsROvQmHcKIL/wr7Y53JORVVIHPx
 LXlcbq2dPERIjPZqscVtaXKo4LtF9eyXbyXpTvjpfA7YzyPoG1Wnt7SiQDJ0TFvJeoph
 OECw==
X-Gm-Message-State: AOAM532DcHkycEWlTEYH+cb2uSMpiMU4E+B8bZLIB5pqpbFABw+yfBf6
 qRrOqBBlgpTiKSKHI+Oaoe89jQ==
X-Google-Smtp-Source: ABdhPJwl22a/1iaLG7lwTFr+2DBMmhbUqgV4wTzEOn11jhBWA9F1fFWOiixp9UyfZqS8O97dLz6MJQ==
X-Received: by 2002:a65:4203:: with SMTP id c3mr4567183pgq.309.1629082773658; 
 Sun, 15 Aug 2021 19:59:33 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:17b8:f07a:2a52:317a])
 by smtp.gmail.com with UTF8SMTPSA id j128sm9534987pfd.38.2021.08.15.19.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 19:59:33 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 3/7] dma-iommu: skip extra sync during unmap w/swiotlb
Date: Mon, 16 Aug 2021 11:57:51 +0900
Message-Id: <20210816025755.2906695-4-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210816025755.2906695-1-stevensd@google.com>
References: <20210816025755.2906695-1-stevensd@google.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 Will Deacon <will@kernel.org>
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
---
 drivers/iommu/dma-iommu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8098ce593640..5dd2c517dbf5 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -504,6 +504,9 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	if (WARN_ON(!phys))
 		return;
 
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
@@ -853,8 +856,6 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
 	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
@@ -1062,14 +1063,14 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
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
2.33.0.rc1.237.g0d66db33f3-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
