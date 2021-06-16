Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DB2C48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 03:54:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD90F613B6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 03:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD90F613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 901214023F;
	Wed, 16 Jun 2021 03:54:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKl7waxHsFoX; Wed, 16 Jun 2021 03:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB0E24021F;
	Wed, 16 Jun 2021 03:54:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3D19C000E;
	Wed, 16 Jun 2021 03:54:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B1C8C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 03:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37DEE401AE
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 03:54:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZSKs4l89Eh7B for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 03:54:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1377A401CA
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 03:54:10 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id t13so838790pgu.11
 for <iommu@lists.linux-foundation.org>; Tue, 15 Jun 2021 20:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZXmU6yzP+hOGy6a5w7xUx+op0fIxrN6dQVFWjI9Fg98=;
 b=H3J253tStSd+Sippm5y1kLb/sxBHtsc81GVn7xqCMuznl+uIejEja5CpvAgNOkDgUV
 rW2jSd2SeApcedRqrCHthelTfcKnVhlQe6ePU9+UnSNNyaqurkjBrgXlhQZ38oVzAhmS
 uYETYDjjS42EMVE+V8ROo6uxeafX55HJgDW3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZXmU6yzP+hOGy6a5w7xUx+op0fIxrN6dQVFWjI9Fg98=;
 b=UeaeJTRQF+AqQXwNhXCbIwB2LeGbF1v4nBmy1H2++VnmMwjfa67cPOZiH0YvoBtxPq
 NGUMW1Jsyl5eQQsbC2am4P/UZzABaTLtMud/FigccwH3lT0x4iuXskXWXYoT6EH7O7Ru
 2EVXX9p6fV7eYCmDWYymD716f5AmNmhJ05+X4s6kdsuXgkV2UGJ9duCO/2R0ZqnTdsIe
 PJINVL0DW47dYwY5n2aoeRbOXO9GtGci96WMerM0HwS5xs3JXVqVpW/5YEk/XAAVujSd
 C6EXxwJsUbj0fV9uPZ8GCLp4/q8b8ch7der4oEYvnvxKCDtvydU669ZcD/dVv+xOcwL+
 N5vg==
X-Gm-Message-State: AOAM531mxJVm2xSXJkOtv+QercLQFpkKOFA478S2HCtHd5M6wlKqq6uy
 pLoPSPrUvvJ7pr+Uhw3t4T2byQ==
X-Google-Smtp-Source: ABdhPJweQmr2eF6Xr1UvMmJWyzNtto6ofAzJzKlojyKwdI6zZ2VnCta/4IZcR5xAxNSgDQaSW5LnWQ==
X-Received: by 2002:a62:b50b:0:b029:2fc:db53:a56a with SMTP id
 y11-20020a62b50b0000b02902fcdb53a56amr2501590pfe.30.1623815650449; 
 Tue, 15 Jun 2021 20:54:10 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:3d52:f252:7393:1992])
 by smtp.gmail.com with UTF8SMTPSA id b80sm527132pfb.151.2021.06.15.20.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jun 2021 20:54:10 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v11 09/12] swiotlb: Add restricted DMA alloc/free support
Date: Wed, 16 Jun 2021 11:52:37 +0800
Message-Id: <20210616035240.840463-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616035240.840463-1-tientzu@chromium.org>
References: <20210616035240.840463-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
 Nicolas Boichat <drinkcat@chromium.org>, rodrigo.vivi@intel.com,
 bhelgaas@google.com, tientzu@chromium.org,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>,
 bauerman@linux.ibm.com
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

Add the functions, swiotlb_{alloc,free} to support the memory allocation
from restricted DMA pool.

The restricted DMA pool is preferred if available.

Note that since coherent allocation needs remapping, one must set up
another device coherent pool by shared-dma-pool and use
dma_alloc_from_dev_coherent instead for atomic coherent allocation.

Signed-off-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 15 +++++++++++++
 kernel/dma/direct.c     | 50 ++++++++++++++++++++++++++++++-----------
 kernel/dma/swiotlb.c    | 45 +++++++++++++++++++++++++++++++++++--
 3 files changed, 95 insertions(+), 15 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index efcd56e3a16c..2d5ec670e064 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -156,4 +156,19 @@ static inline void swiotlb_adjust_size(unsigned long size)
 extern void swiotlb_print_info(void);
 extern void swiotlb_set_max_segment(unsigned int);
 
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size);
+bool swiotlb_free(struct device *dev, struct page *page, size_t size);
+#else
+static inline struct page *swiotlb_alloc(struct device *dev, size_t size)
+{
+	return NULL;
+}
+static inline bool swiotlb_free(struct device *dev, struct page *page,
+				size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
+
 #endif /* __LINUX_SWIOTLB_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3713461d6fe0..da0e09621230 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -75,6 +75,15 @@ static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 		min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
 }
 
+static void __dma_direct_free_pages(struct device *dev, struct page *page,
+				    size_t size)
+{
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL) &&
+	    swiotlb_free(dev, page, size))
+		return;
+	dma_free_contiguous(dev, page, size);
+}
+
 static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		gfp_t gfp)
 {
@@ -86,7 +95,16 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 
 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
 					   &phys_limit);
-	page = dma_alloc_contiguous(dev, size, gfp);
+	if (IS_ENABLED(CONFIG_DMA_RESTRICTED_POOL)) {
+		page = swiotlb_alloc(dev, size);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			__dma_direct_free_pages(dev, page, size);
+			return NULL;
+		}
+	}
+
+	if (!page)
+		page = dma_alloc_contiguous(dev, size, gfp);
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		dma_free_contiguous(dev, page, size);
 		page = NULL;
@@ -142,7 +160,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO);
 		if (!page)
 			return NULL;
@@ -155,18 +173,23 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !dev_is_dma_coherent(dev))
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
+	    !is_dev_swiotlb_force(dev))
 		return arch_dma_alloc(dev, size, dma_handle, gfp, attrs);
 
 	/*
 	 * Remapping or decrypting memory may block. If either is required and
 	 * we can't block, allocate the memory from the atomic pools.
+	 * If restricted DMA (i.e., is_dev_swiotlb_force) is required, one must
+	 * set up another device coherent pool by shared-dma-pool and use
+	 * dma_alloc_from_dev_coherent instead.
 	 */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
 	    !gfpflags_allow_blocking(gfp) &&
 	    (force_dma_unencrypted(dev) ||
-	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev))))
+	     (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
+	      !dev_is_dma_coherent(dev))) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
@@ -237,7 +260,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			return NULL;
 	}
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -247,15 +270,15 @@ void dma_direct_free(struct device *dev, size_t size,
 	unsigned int page_order = get_order(size);
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev)) {
+	    !force_dma_unencrypted(dev) && !is_dev_swiotlb_force(dev)) {
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
 	}
 
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !dev_is_dma_coherent(dev)) {
+	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) && !dev_is_dma_coherent(dev) &&
+	    !is_dev_swiotlb_force(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
 		return;
 	}
@@ -273,7 +296,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	else if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 		arch_dma_clear_uncached(cpu_addr, size);
 
-	dma_free_contiguous(dev, dma_direct_to_page(dev, dma_addr), size);
+	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -283,7 +306,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	void *ret;
 
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
-	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp))
+	    force_dma_unencrypted(dev) && !gfpflags_allow_blocking(gfp) &&
+	    !is_dev_swiotlb_force(dev))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	page = __dma_direct_alloc_pages(dev, size, gfp);
@@ -310,7 +334,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
 	return page;
 out_free_pages:
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 }
 
@@ -329,7 +353,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	if (force_dma_unencrypted(dev))
 		set_memory_encrypted((unsigned long)vaddr, 1 << page_order);
 
-	dma_free_contiguous(dev, page, size);
+	__dma_direct_free_pages(dev, page, size);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index fec4934b9926..6ad85b48f101 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -462,8 +462,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
 	do {
-		if ((slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
-		    (orig_addr & iotlb_align_mask)) {
+		if (orig_addr &&
+		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
+			    (orig_addr & iotlb_align_mask)) {
 			index = wrap_index(mem, index + 1);
 			continue;
 		}
@@ -702,3 +703,43 @@ static int __init swiotlb_create_default_debugfs(void)
 late_initcall(swiotlb_create_default_debugfs);
 
 #endif
+
+#ifdef CONFIG_DMA_RESTRICTED_POOL
+struct page *swiotlb_alloc(struct device *dev, size_t size)
+{
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	phys_addr_t tlb_addr;
+	int index;
+
+	/*
+	 * Skip io_tlb_default_mem since swiotlb_alloc doesn't support atomic
+	 * coherent allocation. Otherwise might break existing devices.
+	 * One must set up another device coherent pool by shared-dma-pool and
+	 * use dma_alloc_from_dev_coherent instead for atomic coherent
+	 * allocation to avoid memory remapping.
+	 */
+	if (!mem || mem == io_tlb_default_mem)
+		return NULL;
+
+	index = swiotlb_find_slots(dev, 0, size);
+	if (index == -1)
+		return NULL;
+
+	tlb_addr = slot_addr(mem->start, index);
+
+	return pfn_to_page(PFN_DOWN(tlb_addr));
+}
+
+bool swiotlb_free(struct device *dev, struct page *page, size_t size)
+{
+	phys_addr_t tlb_addr = page_to_phys(page);
+
+	if (!is_swiotlb_buffer(dev, tlb_addr))
+		return false;
+
+	swiotlb_release_slots(dev, tlb_addr);
+
+	return true;
+}
+
+#endif /* CONFIG_DMA_RESTRICTED_POOL */
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
