Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDEBC433FE
	for <iommu@archiver.kernel.org>; Tue, 23 Nov 2021 11:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8D6C60698;
	Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wTn34RMHo-NV; Tue, 23 Nov 2021 11:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9EB2260611;
	Tue, 23 Nov 2021 11:21:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DAA3C002E;
	Tue, 23 Nov 2021 11:21:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF9AC0012
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 19E1060698
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddLUUiH3jh69 for <iommu@lists.linux-foundation.org>;
 Tue, 23 Nov 2021 11:21:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7572560611
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 11:21:13 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id z6so19112079pfe.7
 for <iommu@lists.linux-foundation.org>; Tue, 23 Nov 2021 03:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cXx4tPUfUH9pafyzAeGR5gquV85Y2Z7tudxqqufT9GE=;
 b=Wyu1LS1cdtTMg0hBT2U10oleP2US7ydiLPsXo5v+x1MNLCd6m33da3VzYuAdmFxMDv
 /atTSJHqbJlfRgPOsJTgGAwa42sZEMLJfCeeybWG2f34PtVrGXjnb2T1yJRaaAh4pnH5
 yo0ASPO7kd0LehyYoqSA3V7IvNbzQ7efFI4NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cXx4tPUfUH9pafyzAeGR5gquV85Y2Z7tudxqqufT9GE=;
 b=RYAG32yE/UVZA0pRvrkP/0mi+vaPu2oV14u942B07nyXoiU1uVWQ1gdT2PJ2Sr1QcG
 lMVDSZLwwaaRuLM0gbzFtsinAyhyj8DNlT6PT1aJ2yetX++eEP2VnsTmCOX4LHjIW5bd
 yIsDuqY0AbzKY8mfNva9wXY8okKg0pRZZfr2bciSEr6z0mAWgExDC2nBoUT/aFsUt0Oj
 9hMZpKSJ/2yQoI6kQT6CkByVvA1fAW8g6W7LyB1VOQn0Iqfe7Cvczp04m+yDOMvTI4IR
 7GdGMGwaDJhJ7H/gVhLjDebB6Ch2SS+90QWz3qfb+3nXQ1V0859ZcsiSsWGAibUUlFWC
 DYWg==
X-Gm-Message-State: AOAM531xJ8yDwKHI+WeTXKBzyR/49JYLUzS+S0x87Om9/ywivF28tF5i
 +USY1s9KCXSqu0HsHzJd4p//Dg==
X-Google-Smtp-Source: ABdhPJxjIMzcvOjNvrJ8u+XuK5KrPYWq/y8+SH32D3Ysykp7V9Qvil0zhFT6XjR7GIbSKLcWQI8AkA==
X-Received: by 2002:a63:1813:: with SMTP id y19mr3266275pgl.93.1637666472835; 
 Tue, 23 Nov 2021 03:21:12 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com
 ([2401:fa00:1:10:d1ae:c331:ed2a:15e9])
 by smtp.gmail.com with ESMTPSA id 63sm11093914pfz.119.2021.11.23.03.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Nov 2021 03:21:12 -0800 (PST)
From: Hsin-Yi Wang <hsinyi@chromium.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/3] dma: swiotlb: Allow restricted-dma-pool to customize
 IO_TLB_SEGSIZE
Date: Tue, 23 Nov 2021 19:21:02 +0800
Message-Id: <20211123112104.3530135-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211123112104.3530135-1-hsinyi@chromium.org>
References: <20211123112104.3530135-1-hsinyi@chromium.org>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, - <devicetree-spec@vger.kernel.org>,
 linux-kernel@vger.kernel.org, senozhatsky@chromium.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Maxime Ripard <maxime@cerno.tech>,
 Matthias Brugger <matthias.bgg@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

Default IO_TLB_SEGSIZE is 128, but some use cases requires more slabs.
Otherwise swiotlb_find_slots() will fail.

This patch allows each mem pool to decide their own io-tlb-segsize
through dt property.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 include/linux/swiotlb.h |  1 +
 kernel/dma/swiotlb.c    | 34 ++++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 569272871375c4..73b3312f23e65b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -95,6 +95,7 @@ struct io_tlb_mem {
 	unsigned long nslabs;
 	unsigned long used;
 	unsigned int index;
+	unsigned int io_tlb_segsize;
 	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8e840fbbed7c7a..021eef1844ca4c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -145,9 +145,10 @@ void swiotlb_print_info(void)
 	       (mem->nslabs << IO_TLB_SHIFT) >> 20);
 }
 
-static inline unsigned long io_tlb_offset(unsigned long val)
+static inline unsigned long io_tlb_offset(unsigned long val,
+					  unsigned long io_tlb_segsize)
 {
-	return val & (IO_TLB_SEGSIZE - 1);
+	return val & (io_tlb_segsize - 1);
 }
 
 static inline unsigned long nr_slots(u64 val)
@@ -186,13 +187,16 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->end = mem->start + bytes;
 	mem->index = 0;
 	mem->late_alloc = late_alloc;
+	if (!mem->io_tlb_segsize)
+		mem->io_tlb_segsize = IO_TLB_SEGSIZE;
 
 	if (swiotlb_force == SWIOTLB_FORCE)
 		mem->force_bounce = true;
 
 	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		mem->slots[i].list = mem->io_tlb_segsize -
+				     io_tlb_offset(i, mem->io_tlb_segsize);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
@@ -523,7 +527,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
 	}
 	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
+	     io_tlb_offset(i, mem->io_tlb_segsize) != mem->io_tlb_segsize - 1 &&
 	     mem->slots[i].list; i--)
 		mem->slots[i].list = ++count;
 
@@ -603,7 +607,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * with slots below and above the pool being returned.
 	 */
 	spin_lock_irqsave(&mem->lock, flags);
-	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
+	if (index + nslots < ALIGN(index + 1, mem->io_tlb_segsize))
 		count = mem->slots[index + nslots].list;
 	else
 		count = 0;
@@ -623,8 +627,8 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	 * available (non zero)
 	 */
 	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
-	     i--)
+	     io_tlb_offset(i, mem->io_tlb_segsize) != mem->io_tlb_segsize - 1 &&
+	     mem->slots[i].list; i--)
 		mem->slots[i].list = ++count;
 	mem->used -= nslots;
 	spin_unlock_irqrestore(&mem->lock, flags);
@@ -701,7 +705,9 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 
 size_t swiotlb_max_mapping_size(struct device *dev)
 {
-	return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	return ((size_t)IO_TLB_SIZE) * mem->io_tlb_segsize;
 }
 
 bool is_swiotlb_active(struct device *dev)
@@ -788,6 +794,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 {
 	struct io_tlb_mem *mem = rmem->priv;
 	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
+	struct device_node *np;
 
 	/*
 	 * Since multiple devices can share the same pool, the private data,
@@ -808,6 +815,17 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
+
+		np = of_find_node_by_phandle(rmem->phandle);
+		if (np) {
+			if (!of_property_read_u32(np, "io-tlb-segsize",
+						  &mem->io_tlb_segsize)) {
+				if (hweight32(mem->io_tlb_segsize) != 1)
+					mem->io_tlb_segsize = IO_TLB_SEGSIZE;
+			}
+			of_node_put(np);
+		}
+
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
 		mem->force_bounce = true;
 		mem->for_alloc = true;
-- 
2.34.0.rc2.393.gf8c9666880-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
