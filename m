Return-Path: <SRS0=c+U5=L2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373C6C11F68
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 07:31:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA73C613F4
	for <iommu@archiver.kernel.org>; Fri,  2 Jul 2021 07:31:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA73C613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8175383C40;
	Fri,  2 Jul 2021 07:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nr1RMIm3x1mz; Fri,  2 Jul 2021 07:31:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 41FB783C41;
	Fri,  2 Jul 2021 07:31:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2058C0010;
	Fri,  2 Jul 2021 07:31:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D365C000E
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F0F4F400F4
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sgH_gmy_-VzP for <iommu@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 05:41:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28399400DD
 for <iommu@lists.linux-foundation.org>; Fri,  2 Jul 2021 05:41:45 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id j24so7988203pfi.12
 for <iommu@lists.linux-foundation.org>; Thu, 01 Jul 2021 22:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zAwD45KsI2uIcfr8Yqj6+SKk/uIGvPhpEyAUZslXh6M=;
 b=PlnDwwWqNVV8/2utfWGm8o1PTATjGBuFM9pG3Q6ARMsRIUFXv5uvavoHguUIgKibh5
 036Q5eUayl6uJm4l3UWTelUXVAWCuFBW4UbLutIROyzigIRjXXOY98igBKVRW2qozlg+
 DTnS5z+aio+fKtiW2ZoaazGQLDcxeQuAAf3I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zAwD45KsI2uIcfr8Yqj6+SKk/uIGvPhpEyAUZslXh6M=;
 b=cAHsyrxWMjK3/4LqJ2rTn9UDdTnAZ7pGwtjQR3Aaqg/0AFBgke2lJea93VSU2xicS4
 veEJ3V4d+V3MhlorlbvdxQIeh5zhEd6770kKuF52x8z5zthG5HNxNhV8+nP/Iqo7dJzr
 GWWW4F8gXNeJXFuDks0Y88Dw//HT1JALKffdPQXmvcvYGW1iSwK3KAQlF10Ng3N031JL
 Rrr9AWMJTp2giUe6Ps0RMyxD2oYi0ZfEs5tkOKYVSHaSAjV96NqV/NQPJobqBoA0dcnP
 nOF/cIM7KSgoE5JvTf5/z972haxOSr1jHDuozth5ODxdvDa9aPinTMimRQVWd7xhUxP3
 ck2A==
X-Gm-Message-State: AOAM533bxkW7LpT006ggbgji0W4tTAyKK6WFZIIuDCTyxo6IGlfJdsYs
 fJDzGldidZAxuj3GgoxbskOOOw==
X-Google-Smtp-Source: ABdhPJx4B9mCHjbOyCg2uapQgRRYladp7cHV/uj4+NV3dZmkMlotMTsoG/WZMZotQAs0TujbrhRwVQ==
X-Received: by 2002:aa7:9586:0:b029:30f:a816:a5ef with SMTP id
 z6-20020aa795860000b029030fa816a5efmr3743120pfj.27.1625204504496; 
 Thu, 01 Jul 2021 22:41:44 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:21b7:6cc1:2d7d:b4])
 by smtp.gmail.com with UTF8SMTPSA id h3sm1916647pfe.186.2021.07.01.22.41.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jul 2021 22:41:43 -0700 (PDT)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] dma-iommu: fix swiotlb SKIP_CPU_SYNC and arch sync
Date: Fri,  2 Jul 2021 14:37:41 +0900
Message-Id: <20210702053742.842850-1-stevensd@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
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

Make map_swiotlb and unmap_swiotlb only for mapping, and consistently
use sync_single_for and sync_sg_for functions for swiotlb sync and arch
sync. This ensures that the same code path is responsible for syncing
regardless of whether or not SKIP_CPU_SYNC is set. In the process, fix
various places where the original physical address and swiotlb tlb_addr
are mixed up:
  - Make sync_sg functions call sync_single functions for untrusted
    devices, so they use tlb_addr when checking is_swiotlb_buffer and
    when doing arch sync if necessary.
  - Use tlb_addr for arch sync in map_page if necessary.
  - In map_sg, map before syncing so that arch sync can target the
    bounce buffer if necessary.
  - Pass SKIP_CPU_SYNC to swiotlb map and unmap to avoid double syncing
    the swiotlb. This had previously only happened in the unmap_page
    case, but is now necessary for all swiotlb cases.

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Signed-off-by: David Stevens <stevensd@chromium.org>
---
 drivers/iommu/dma-iommu.c | 82 ++++++++++++++++++++++++---------------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7bcdd1205535..24d1042cd052 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 	__iommu_dma_unmap(dev, dma_addr, size);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -536,7 +537,8 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 		size_t org_size, dma_addr_t dma_mask, bool coherent,
-		enum dma_data_direction dir, unsigned long attrs)
+		enum dma_data_direction dir, unsigned long attrs,
+		phys_addr_t *adj_phys)
 {
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
@@ -555,7 +557,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 	    iova_offset(iovad, phys | org_size)) {
 		aligned_size = iova_align(iovad, org_size);
 		phys = swiotlb_tbl_map_single(dev, phys, org_size,
-					      aligned_size, dir, attrs);
+					      aligned_size, dir,
+					      attrs | DMA_ATTR_SKIP_CPU_SYNC);
 
 		if (phys == DMA_MAPPING_ERROR)
 			return DMA_MAPPING_ERROR;
@@ -573,6 +576,8 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
 
 		memset(padding_start, 0, padding_size);
 	}
+	if (adj_phys)
+		*adj_phys = phys;
 
 	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
@@ -785,15 +790,17 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
 
-static void iommu_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+static void __iommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction dir, phys_addr_t phys)
 {
-	phys_addr_t phys;
-
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
+	if (phys == 0)
+		phys = iommu_iova_to_phys(iommu_get_dma_domain(dev),
+					  dma_handle);
+
 	if (is_swiotlb_buffer(phys))
 		swiotlb_sync_single_for_device(dev, phys, size, dir);
 
@@ -801,6 +808,12 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 		arch_sync_dma_for_device(phys, size, dir);
 }
 
+static void iommu_dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
+{
+	__iommu_dma_sync_single_for_device(dev, dma_handle, size, dir, 0);
+}
+
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nelems,
 		enum dma_data_direction dir)
@@ -811,14 +824,13 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
+						      sg->length, dir);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
-
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
-						    sg->length, dir);
-	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -831,29 +843,30 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i) {
-		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_sync_single_for_device(dev, sg_phys(sg),
-						       sg->length, dir);
-
-		if (!dev_is_dma_coherent(dev))
+	if (dev_is_untrusted(dev))
+		for_each_sg(sgl, sg, nelems, i)
+			__iommu_dma_sync_single_for_device(dev,
+							   sg_dma_address(sg),
+							   sg->length, dir, 0);
+	else
+		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
-	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
-	phys_addr_t phys = page_to_phys(page) + offset;
+	phys_addr_t phys = page_to_phys(page) + offset, adj_phys;
 	bool coherent = dev_is_dma_coherent(dev);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
-			coherent, dir, attrs);
-	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size,
+			dma_get_mask(dev), coherent, dir, attrs, &adj_phys);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
-		arch_sync_dma_for_device(phys, size, dir);
+		__iommu_dma_sync_single_for_device(dev, dma_handle, size,
+						   dir, adj_phys);
 	return dma_handle;
 }
 
@@ -960,7 +973,7 @@ static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nents, i) {
 		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
 				s->length, dma_get_mask(dev),
-				dev_is_dma_coherent(dev), dir, attrs);
+				dev_is_dma_coherent(dev), dir, attrs, NULL);
 		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
 			goto out_unmap;
 		sg_dma_len(s) = s->length;
@@ -991,17 +1004,24 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	dma_addr_t iova;
 	size_t iova_len = 0;
 	unsigned long mask = dma_get_seg_boundary(dev);
-	int i;
+	int i, early_mapped = 0;
 
 	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
 	    iommu_deferred_attach(dev, domain))
 		return 0;
 
+	if (dev_is_untrusted(dev)) {
+		early_mapped = iommu_dma_map_sg_swiotlb(dev, sg, nents,
+							dir, attrs);
+		if (!early_mapped)
+			return 0;
+	}
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
-	if (dev_is_untrusted(dev))
-		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
+	if (early_mapped)
+		return early_mapped;
 
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
-- 
2.32.0.93.g670b81a890-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
