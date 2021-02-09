Return-Path: <SRS0=nJTY=HL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E97C433DB
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B6564E54
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B6564E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 161AC6F647
	for <iommu@archiver.kernel.org>; Tue,  9 Feb 2021 06:22:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n3-YvgSF3kQG for <iommu@archiver.kernel.org>;
	Tue,  9 Feb 2021 06:22:56 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 2F6DF6F675; Tue,  9 Feb 2021 06:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 781776F61E;
	Tue,  9 Feb 2021 06:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 530A5C0174;
	Tue,  9 Feb 2021 06:22:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70A0AC013A
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5EFB685FE4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m2qeCtsWbM-M for <iommu@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:22:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A8E7785FD4
 for <iommu@lists.linux-foundation.org>; Tue,  9 Feb 2021 06:22:48 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id o38so300821pgm.9
 for <iommu@lists.linux-foundation.org>; Mon, 08 Feb 2021 22:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4zqci56JWIAAF0wW2XoOW1nlucKE1HdU8HbBcVGEoj4=;
 b=iQ8wBJSEVZzeAe0ffh2h2GM8F5kehjcPxtVFeT4gPFJg8QooaH8d0bbR3DBFmEjh7/
 +t81Z22ZQ3jfYQJEtw6EEDXPAwtTfgWAGJvdqJ64cWu+Z/90HeG76Xdlz9LMQYcjebg6
 t1DpKPM5Kv3tzEnaDX3egDRfxshz/CzrFwO+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4zqci56JWIAAF0wW2XoOW1nlucKE1HdU8HbBcVGEoj4=;
 b=PF1b+UiZwqdLwkXpAW0CNo9ApzBCkLPWRD2lIdLlGr/qrZacOdjosT3AeGouBAW029
 zX4Ar/mZqyeDoRkJAqZGsdWbZgaRJmoWjRJtsApID/QoUkq5Knn1xtdljmzjaPfuc1p0
 cVCEBQhCDYsJM2yWUQvVGFFQBugCjfCQtBurw2+BivUbpJKeN2eFLdIx7bTCH7oM7SpO
 HwmUtLA6HXA3AZTOCwv2dN2hnyvMaBA79wY7m7R1zK0ys0x9Xx/VYERmuI4K0C3wVfGE
 8OqagSSGg+0OT/qNu+scmyeObwDh65WQEQ2aOtulP/iNvlIXJ8divc/KrCoErRl9UjD1
 aCoA==
X-Gm-Message-State: AOAM530H0SwyATz2ewQz5bWuZBo0B9gP8E25kIGxyhZqZOECJ7JbqKpu
 6vVtpSKZ2epfclsao28LTWCSag==
X-Google-Smtp-Source: ABdhPJy1CzOC+GQys63fdcsVT9unv4NpcqE4/TesqmaSSFAML/xnfw6XY2m3UHOllfAZ0J4Itqp2AA==
X-Received: by 2002:aa7:80cc:0:b029:1da:689d:2762 with SMTP id
 a12-20020aa780cc0000b02901da689d2762mr14012849pfn.3.1612851768274; 
 Mon, 08 Feb 2021 22:22:48 -0800 (PST)
Received: from localhost ([2401:fa00:1:10:a106:46e1:a999:81df])
 by smtp.gmail.com with UTF8SMTPSA id n1sm6296866pgn.94.2021.02.08.22.22.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 22:22:47 -0800 (PST)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 09/14] swiotlb: Refactor swiotlb_tbl_{map,unmap}_single
Date: Tue,  9 Feb 2021 14:21:26 +0800
Message-Id: <20210209062131.2300005-10-tientzu@chromium.org>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210209062131.2300005-1-tientzu@chromium.org>
References: <20210209062131.2300005-1-tientzu@chromium.org>
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, peterz@infradead.org,
 benh@kernel.crashing.org, grant.likely@arm.com, paulus@samba.org,
 mingo@kernel.org, sstabellini@kernel.org,
 Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 xen-devel@lists.xenproject.org, Thierry Reding <treding@nvidia.com>,
 linux-devicetree <devicetree@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nicolas Boichat <drinkcat@chromium.org>, Claire Chang <tientzu@chromium.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg KH <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, Robin Murphy <robin.murphy@arm.com>
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

Refactor swiotlb_tbl_{map,unmap}_single to make the code reusable for
dev_swiotlb_{alloc,free}.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 kernel/dma/swiotlb.c | 116 ++++++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 6fdebde8fb1f..f64cbe6e84cc 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -509,14 +509,12 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 	}
 }
 
-phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
-		size_t mapping_size, size_t alloc_size,
-		enum dma_data_direction dir, unsigned long attrs)
+static int swiotlb_tbl_find_free_region(struct device *hwdev,
+					dma_addr_t tbl_dma_addr,
+					size_t alloc_size, unsigned long attrs)
 {
 	struct swiotlb *swiotlb = get_swiotlb(hwdev);
-	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, swiotlb->start);
 	unsigned long flags;
-	phys_addr_t tlb_addr;
 	unsigned int nslots, stride, index, wrap;
 	int i;
 	unsigned long mask;
@@ -531,15 +529,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 #endif
 		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
 
-	if (mem_encrypt_active())
-		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
-
-	if (mapping_size > alloc_size) {
-		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
-
 	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
@@ -601,7 +590,6 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 				swiotlb->list[i] = 0;
 			for (i = index - 1; (OFFSET(i, IO_TLB_SEGSIZE) != IO_TLB_SEGSIZE - 1) && swiotlb->list[i]; i--)
 				swiotlb->list[i] = ++count;
-			tlb_addr = swiotlb->start + (index << IO_TLB_SHIFT);
 
 			/*
 			 * Update the indices to avoid searching in the next
@@ -624,45 +612,20 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
 			 alloc_size, swiotlb->nslabs, tmp_io_tlb_used);
-	return (phys_addr_t)DMA_MAPPING_ERROR;
+	return -ENOMEM;
+
 found:
 	swiotlb->used += nslots;
 	spin_unlock_irqrestore(&swiotlb->lock, flags);
 
-	/*
-	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
-	 */
-	for (i = 0; i < nslots; i++)
-		swiotlb->orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
-
-	return tlb_addr;
+	return index;
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t mapping_size, size_t alloc_size,
-			      enum dma_data_direction dir, unsigned long attrs)
+static void swiotlb_tbl_release_region(struct device *hwdev, int index, size_t size)
 {
 	struct swiotlb *swiotlb = get_swiotlb(hwdev);
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = swiotlb->orig_addr[index];
-
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (orig_addr != INVALID_PHYS_ADDR &&
-	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -694,6 +657,69 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	spin_unlock_irqrestore(&swiotlb->lock, flags);
 }
 
+phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t orig_addr,
+				   size_t mapping_size, size_t alloc_size,
+				   enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
+	dma_addr_t tbl_dma_addr = phys_to_dma_unencrypted(hwdev, swiotlb->start);
+	phys_addr_t tlb_addr;
+	unsigned int nslots, index;
+	int i;
+
+	if (mem_encrypt_active())
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	index = swiotlb_tbl_find_free_region(hwdev, tbl_dma_addr, alloc_size, attrs);
+	if (index < 0)
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+
+	tlb_addr = swiotlb->start + (index << IO_TLB_SHIFT);
+
+	/*
+	 * Save away the mapping from the original address to the DMA address.
+	 * This is needed when we sync the memory.  Then we sync the buffer if
+	 * needed.
+	 */
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	for (i = 0; i < nslots; i++)
+		swiotlb->orig_addr[index + i] = orig_addr + (i << IO_TLB_SHIFT);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
+
+	return tlb_addr;
+}
+
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
+			      size_t mapping_size, size_t alloc_size,
+			      enum dma_data_direction dir, unsigned long attrs)
+{
+	struct swiotlb *swiotlb = get_swiotlb(hwdev);
+	int index = (tlb_addr - swiotlb->start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = swiotlb->orig_addr[index];
+
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (orig_addr != INVALID_PHYS_ADDR &&
+	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
+
+	swiotlb_tbl_release_region(hwdev, index, alloc_size);
+}
+
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 			     size_t size, enum dma_data_direction dir,
 			     enum dma_sync_target target)
-- 
2.30.0.478.g8a0d178c01-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
