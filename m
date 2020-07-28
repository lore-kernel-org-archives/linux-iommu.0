Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749C9C433FC
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476FA21744
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 05:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pa8mXmI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476FA21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1DE1E228E7;
	Tue, 28 Jul 2020 05:02:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ClBnSnZTNW+c; Tue, 28 Jul 2020 05:02:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01846227CD;
	Tue, 28 Jul 2020 05:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0002C004F;
	Tue, 28 Jul 2020 05:02:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B2A5C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 17AD387849
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z4OB1xyGZlOw for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 05:02:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2AB19877FA
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 05:02:02 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id d1so9270453plr.8
 for <iommu@lists.linux-foundation.org>; Mon, 27 Jul 2020 22:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P2a+a3NYSV0L8qJUUvIzx9RD01W8IuTiPxH9Jqk4EKc=;
 b=Pa8mXmI1SkrfjsU49mOAGXTNNn3tesDVg9s5BYIKkU5YZjBw3NPC/jJH4EvmhyPKxl
 Z57abN9nSzliVQLow4AfOWhK9h1h1oZ0BH8cexno+eeFulU/VtUhseihBKazL2UBASRY
 IKE8PrTEEKrnucdpPUF8wNMLx14mVyChtUMdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P2a+a3NYSV0L8qJUUvIzx9RD01W8IuTiPxH9Jqk4EKc=;
 b=Fjh99U9O041s+LpJ/RhQmT60ItnmUtt/aQKXT4lGfYMVRtqf9bMLRQv+oRcmhnNiFu
 bsTSM8N7kpTx+3yxmLpHHRuyk8iUhd83S76K220hdqGrYScmpZaIJYkbeepuCT7SK8hc
 fo229fz5E44iV06yx93WowwQNI7tKse67aMWJFgyZTqc1IdiUr87wJajhf30/I1BfCvI
 HTvRGRiGmZAchDNgMKANvTR2MNEdDcqzrn1iGP3mjZ4/TzpexURbCetcuOBxR8E4j8jM
 A0gZ0VSemlQ9ITYr1u2iu8qMXim7BcIOSYhrwAKUTHtIZsBEKUrSXGOaENlbqnXsNIDx
 kH3Q==
X-Gm-Message-State: AOAM532+6HMQnNM5BLnLpDcFX5OuceBVibVbhQANIOfVYiWEdDP7Y/mM
 tFli7XsmXgxEfqXv1YX3qC1b5w==
X-Google-Smtp-Source: ABdhPJzbXA9J0zYh/nfK50CWg1w3qmf++VrnO4uiuHKZizTmXCX+P+VRehqnozZhweRCj4IsNZYNIg==
X-Received: by 2002:a17:90a:71c1:: with SMTP id
 m1mr2661126pjs.22.1595912521692; 
 Mon, 27 Jul 2020 22:02:01 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:3e52:82ff:fe5e:cc9d])
 by smtp.gmail.com with ESMTPSA id y63sm16354334pgb.49.2020.07.27.22.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 22:02:01 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: robh+dt@kernel.org, frowand.list@gmail.com, hch@lst.de,
 m.szyprowski@samsung.com, robin.murphy@arm.com
Subject: [RFC v2 3/5] swiotlb: Use device swiotlb pool if available
Date: Tue, 28 Jul 2020 13:01:38 +0800
Message-Id: <20200728050140.996974-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200728050140.996974-1-tientzu@chromium.org>
References: <20200728050140.996974-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, heikki.krogerus@linux.intel.com,
 saravanak@google.com, suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, drinkcat@chromium.org, tientzu@chromium.org,
 dan.j.williams@intel.com, treding@nvidia.com
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

Regardless of swiotlb setting, the device swiotlb pool is preferred if
available.

The device swiotlb pools provide a basic level of protection against
the DMA overwriting buffer contents at unexpected times. However, to
protect against general data leakage and system memory corruption, the
system needs to provide a way to restrict the DMA to a predefined memory
region.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/iommu/intel/iommu.c |  6 +++---
 include/linux/dma-direct.h  |  8 ++++----
 include/linux/swiotlb.h     | 13 ++++++++-----
 kernel/dma/direct.c         |  8 ++++----
 kernel/dma/swiotlb.c        | 18 +++++++++++-------
 5 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 44c9230251eb..37d6583cf628 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3684,7 +3684,7 @@ bounce_sync_single(struct device *dev, dma_addr_t addr, size_t size,
 		return;
 
 	tlb_addr = intel_iommu_iova_to_phys(&domain->domain, addr);
-	if (is_swiotlb_buffer(tlb_addr))
+	if (is_swiotlb_buffer(dev, tlb_addr))
 		swiotlb_tbl_sync_single(dev, tlb_addr, size, dir, target);
 }
 
@@ -3768,7 +3768,7 @@ bounce_map_single(struct device *dev, phys_addr_t paddr, size_t size,
 	return (phys_addr_t)iova_pfn << PAGE_SHIFT;
 
 mapping_error:
-	if (is_swiotlb_buffer(tlb_addr))
+	if (is_swiotlb_buffer(dev, tlb_addr))
 		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
 					 aligned_size, dir, attrs);
 swiotlb_error:
@@ -3796,7 +3796,7 @@ bounce_unmap_single(struct device *dev, dma_addr_t dev_addr, size_t size,
 		return;
 
 	intel_unmap(dev, dev_addr, size);
-	if (is_swiotlb_buffer(tlb_addr))
+	if (is_swiotlb_buffer(dev, tlb_addr))
 		swiotlb_tbl_unmap_single(dev, tlb_addr, size,
 					 aligned_size, dir, attrs);
 
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 5a3ce2a24794..1cf920ddb2f6 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -134,7 +134,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(dev, paddr)))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
 
 	if (!dev_is_dma_coherent(dev))
@@ -151,7 +151,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu_all();
 	}
 
-	if (unlikely(is_swiotlb_buffer(paddr)))
+	if (unlikely(is_swiotlb_buffer(dev, paddr)))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
 
@@ -162,7 +162,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE || dev->dma_io_tlb_mem))
 		return swiotlb_map(dev, phys, size, dir, attrs);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
@@ -188,7 +188,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
-	if (unlikely(is_swiotlb_buffer(phys)))
+	if (unlikely(is_swiotlb_buffer(dev, phys)))
 		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
 }
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index ab0d571d0826..8a50b3af7c3f 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -105,18 +105,21 @@ struct io_tlb_mem {
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
-	return paddr >= io_tlb_mem.start && paddr < io_tlb_mem.end;
+	struct io_tlb_mem *mem =
+		dev->dma_io_tlb_mem ? dev->dma_io_tlb_mem : &io_tlb_default_mem;
+
+	return paddr >= mem->start && paddr < mem->end;
 }
 
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
-bool is_swiotlb_active(void);
+bool is_swiotlb_active(struct device *dev);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
-static inline bool is_swiotlb_buffer(phys_addr_t paddr)
+static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
 	return false;
 }
@@ -132,7 +135,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
 	return SIZE_MAX;
 }
 
-static inline bool is_swiotlb_active(void)
+static inline bool is_swiotlb_active(struct device *dev)
 {
 	return false;
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index bb0041e99659..b31312d68196 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -311,7 +311,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length,
 					dir, SYNC_FOR_DEVICE);
 
@@ -337,7 +337,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
-		if (unlikely(is_swiotlb_buffer(paddr)))
+		if (unlikely(is_swiotlb_buffer(dev, paddr)))
 			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
 					SYNC_FOR_CPU);
 	}
@@ -460,7 +460,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
 size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
-	if (is_swiotlb_active() &&
+	if (is_swiotlb_active(dev) &&
 	    (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
 		return swiotlb_max_mapping_size(dev);
 	return SIZE_MAX;
@@ -469,5 +469,5 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
 {
 	return !dev_is_dma_coherent(dev) ||
-		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
+		is_swiotlb_buffer(dev, dma_to_phys(dev, dma_addr));
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index eaa101b3e75b..fbc9367bccb4 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -449,7 +449,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem ? hwdev->dma_io_tlb_mem :
+							       &io_tlb_default_mem;
 	unsigned long flags;
 	phys_addr_t tlb_addr;
 	unsigned int nslots, stride, index, wrap;
@@ -459,7 +460,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	unsigned long max_slots;
 	unsigned long tmp_io_tlb_used;
 
-	if (no_iotlb_memory)
+	if (!hwdev->dma_io_tlb_mem && no_iotlb_memory)
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
 	if (mem_encrypt_active())
@@ -581,7 +582,8 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, size_t alloc_size,
 			      enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem ? hwdev->dma_io_tlb_mem :
+							       &io_tlb_default_mem;
 	unsigned long flags;
 	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
@@ -629,7 +631,8 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem ? hwdev->dma_io_tlb_mem :
+							       &io_tlb_default_mem;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->orig_addr[index];
 
@@ -664,7 +667,8 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = &io_tlb_default_mem;
+	struct io_tlb_mem *mem =
+		dev->dma_io_tlb_mem ? dev->dma_io_tlb_mem : &io_tlb_default_mem;
 	phys_addr_t swiotlb_addr;
 	dma_addr_t dma_addr;
 
@@ -698,13 +702,13 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 	return ((size_t)1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
 }
 
-bool is_swiotlb_active(void)
+bool is_swiotlb_active(struct device *dev)
 {
 	/*
 	 * When SWIOTLB is initialized, even if io_tlb_default_mem.start points
 	 * to physical address zero, io_tlb_default_mem.end surely doesn't.
 	 */
-	return io_tlb_default_mem.end != 0;
+	return dev->dma_io_tlb_mem || io_tlb_default_mem.end != 0;
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.28.0.rc0.142.g3c755180ce-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
