Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E24C11F6A
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 07:31:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD2E613F4
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 07:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD2E613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1364B405DD;
	Fri,  2 Jul 2021 07:31:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dy4gV18WfUGC; Fri,  2 Jul 2021 07:31:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B14E5405F1;
	Fri,  2 Jul 2021 07:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 419E6C0020;
	Fri,  2 Jul 2021 07:31:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30DC4C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 143A3400F4
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n1kppSjSN3OG for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 05:41:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 648B3400DD
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:48 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id m15so284378plx.7
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 22:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=D7zlF8y2JuYoUJhE1oS1iaGOUuZ9xQp++/xChxOT/IQ=;
 b=CAndttSGtAP+dzCgzlXnCQnfyHTh00G3Un/RT6vLy88Zq7jP1mUVl/TctvWNlbpUeO
 cWmUCCPHo3kGrZ0s/pAI5odjreiYA/OlzonX/6GB4NQ5I0euxSkytDq04sN2FmKJq0eK
 aTrNrWgopIDaT8JIzGsu8esAr4uWcnvo8yOFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=D7zlF8y2JuYoUJhE1oS1iaGOUuZ9xQp++/xChxOT/IQ=;
 b=PF60sJl/WZglcFjk32HfMnw4/bOA18Euo9KursiFkDtamk2VZE3cgr7JgPyjuetOIx
 EOnltQr44gQLvqK5Rak8LSuNHD4dho9rVc1kFzrz/lGN4Oaqz1GLUrehjFJdTIvbsZSh
 WIhgg3PEZ6khRSGWfZFQ7tcReAi8CKlu2KVRsNkFrO7omwLcpGofA7BOcGuBJFm8VfmQ
 1yIGWqb7kMVxffjvsUoKGxa46h1WIPO4OFlzGq28eQ5nZhIyxTXlnu/FnrjL8KbTHfTe
 A7WWcduguSmDWBtE0a0gpCkcw6Zos2qYdcXE1HzB0ZJTs+KR2l4y5cUPLOTgrSFewr8x
 mQMw==
X-Gm-Message-State: AOAM530x/h/zYchDjx0Hw/hYO/5/rSRYu26/y7LA24ks2QBrZBi1h5yK
 Wk0twQLi4KTXhgIRObvTraXRNw==
X-Google-Smtp-Source: ABdhPJxi/f+AQb94i0BZjuuD2GzHRRZEWoXuyNGP1UE+QuaGaQnRl0oSvWTnSbgt2900nHst8ZFcEA==
X-Received: by 2002:a17:902:ab8e:b029:125:e6a0:fea2 with SMTP id
 f14-20020a170902ab8eb0290125e6a0fea2mr3150377plr.41.1625204507886; 
 Thu, 01 Jul 2021 22:41:47 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:21b7:6cc1:2d7d:b4])
 by smtp.gmail.com with UTF8SMTPSA id d127sm1887619pfc.50.2021.07.01.22.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 22:41:47 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date: Fri,  2 Jul 2021 14:37:42 +0900
Message-Id: <20210702053742.842850-2-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210702053742.842850-1-stevensd@google.com>
References: <20210702053742.842850-1-stevensd@google.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 02 Jul 2021 07:31:46 +0000
Cc: iommu@lists.linux-foundation.org, David Stevens <stevensd@chromium.org>,
 linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>
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

Add check for CONFIG_SWIOTLB to dev_is_untrusted, so that swiotlb
related code can be removed more aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 24d1042cd052..614f0dd86b08 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -310,9 +310,10 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
-static bool dev_is_untrusted(struct device *dev)
+static bool dev_use_swiotlb(struct device *dev)
 {
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+	return IS_ENABLED(CONFIG_SWIOTLB) &&
+	       dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
 /**
@@ -368,7 +369,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	if (!cookie->fq_domain && (!dev || !dev_use_swiotlb(dev)) &&
 	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
@@ -553,8 +554,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | org_size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
 					      aligned_size, dir,
@@ -779,7 +779,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -794,7 +794,7 @@ static void __iommu_dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction dir, phys_addr_t phys)
 {
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	if (phys == 0)
@@ -821,10 +821,10 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -840,10 +840,10 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			__iommu_dma_sync_single_for_device(dev,
 							   sg_dma_address(sg),
@@ -1010,7 +1010,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
 							dir, attrs);
 		if (!early_mapped)
@@ -1092,7 +1092,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
