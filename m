Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DF2C433FE
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717EE6124A
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 717EE6124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35F1160BD4;
	Wed, 29 Sep 2021 02:33:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFUlESkYsMSn; Wed, 29 Sep 2021 02:33:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DE7B76077A;
	Wed, 29 Sep 2021 02:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAE66C0011;
	Wed, 29 Sep 2021 02:33:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96638C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 74F7B82C7D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EOqsmGjUbTgS for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:33:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C06C582C8E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:33:30 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id j14so487141plx.4
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Avq5RbT/lx2fFWwn1+oBZcpxY4DeWLbxCwAyQKZBr6Q=;
 b=RsreUQtZHkHMdFYzbWrJEWkO7v8DByvMn1Cm55K01vrJ1BdE5FqMiOk5XvGjmjn13/
 wSIaJmMt0JynoNYnAzFDSVZrdZYO3yC+c5NuctFmkYv98pT7ka6WOlQwreGFcPNdDx0z
 s0hS+MgpU3CYbpJ+OckbEQsOtASV0wdfMOErM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Avq5RbT/lx2fFWwn1+oBZcpxY4DeWLbxCwAyQKZBr6Q=;
 b=bURZ2vQ7BKuJbZM9MMvnAAgUZNa5odizZWp/KJUM1Pg5AJengCG4jcitWIZeFcPNlZ
 m+ZGLk2B5hu1qu93YLB0bzyEr9th0tA0miZ7alPQWNuXEvnUTYqRMyspPgrAlBMlWA9c
 E598EH4I2wE/P9LFKF2VixPT4BPQwoGy0cmjoz8kgZqchhjGx5KMg+gCq0tKI8xHdIdc
 gSHeLViMkkOrJn4TM3jcL/wvBApoBO+LvbybJEieLFgCLV473EC5D1R2WsiQHiiU5o8L
 i/c5YIzS0ZCvO/pxdwrSGdkM1ci3yeNtXd8aPPDMaq/8dDL5ngX1t6MnyrL4khSaKA/j
 gh3Q==
X-Gm-Message-State: AOAM5325vYrqgPPulHvPth+ax6DHXgogvAYIdOFJfdgQJL53d//2NgnA
 D39WH91vRfSllTfKTiwtmhdUww==
X-Google-Smtp-Source: ABdhPJyoSPNVeVmBl31+olu0YXEa5foZN5sfKsQOK+2mvMYcLDsnB8Wy+WaCIoBB0kmqTaWZjrbMdw==
X-Received: by 2002:a17:90a:49:: with SMTP id 9mr3654873pjb.80.1632882810263; 
 Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:f818:368:93ef:fa36])
 by smtp.gmail.com with UTF8SMTPSA id k3sm27354pjg.43.2021.09.28.19.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Sep 2021 19:33:30 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 5/7] dma-iommu: Check CONFIG_SWIOTLB more broadly
Date: Wed, 29 Sep 2021 11:32:58 +0900
Message-Id: <20210929023300.335969-6-stevensd@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210929023300.335969-1-stevensd@google.com>
References: <20210929023300.335969-1-stevensd@google.com>
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

Introduce a new dev_use_swiotlb function to guard swiotlb code, instead
of overloading dev_is_untrusted. This allows CONFIG_SWIOTLB to be
checked more broadly, so the swiotlb related code can be removed more
aggressively.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4f77c44eaf14..85a005b268f6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -317,6 +317,11 @@ static bool dev_is_untrusted(struct device *dev)
 	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
 }
 
+static bool dev_use_swiotlb(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
+}
+
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
@@ -731,7 +736,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -747,7 +752,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
+	if (dev_is_dma_coherent(dev) && !dev_use_swiotlb(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
@@ -765,7 +770,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
@@ -781,7 +786,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
@@ -808,8 +813,7 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 	 * If both the physical buffer start address and size are
 	 * page aligned, we don't need to use a bounce page.
 	 */
-	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
-	    iova_offset(iovad, phys | size)) {
+	if (dev_use_swiotlb(dev) && iova_offset(iovad, phys | size)) {
 		void *padding_start;
 		size_t padding_size;
 
@@ -994,7 +998,7 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		goto out;
 	}
 
-	if (dev_is_untrusted(dev))
+	if (dev_use_swiotlb(dev))
 		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
 
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
@@ -1072,7 +1076,7 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	struct scatterlist *tmp;
 	int i;
 
-	if (dev_is_untrusted(dev)) {
+	if (dev_use_swiotlb(dev)) {
 		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
 		return;
 	}
-- 
2.33.0.685.g46640cef36-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
