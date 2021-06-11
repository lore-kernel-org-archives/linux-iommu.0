Return-Path: <SRS0=1MD/=LF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015DDC48BE8
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:27:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD6B61404
	for <iommu@archiver.kernel.org>; Fri, 11 Jun 2021 15:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD6B61404
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99EFA415D4;
	Fri, 11 Jun 2021 15:27:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jSQ6T-QTL5aa; Fri, 11 Jun 2021 15:27:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 21BE7415CA;
	Fri, 11 Jun 2021 15:27:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC191C000E;
	Fri, 11 Jun 2021 15:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 456D1C000B
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:27:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26361404E8
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KDrxC_4NuhxY for <iommu@lists.linux-foundation.org>;
 Fri, 11 Jun 2021 15:27:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 797DC4024F
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 15:27:40 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id e1so2998563pld.13
 for <iommu@lists.linux-foundation.org>; Fri, 11 Jun 2021 08:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N9TVmO9aGqoduxqk5pFie0IHXd8vLspLVt82aTdw2co=;
 b=fiJV4qFUiRXaxOp4vBkL4JToBkgYVY+AaQy2O2SrrY5MvO7od5oJ3tYXCIi5YBEuJh
 DGJzgMCIu0uMgBXkHJ7/7dTWoJ1FXDPZDsfDXnlYmJUO5c8ZukGBzjI7CYg/CWlag+/P
 qBP0ch5ltrmS/XxZKNv+okJuDN4vM3IFZNebE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N9TVmO9aGqoduxqk5pFie0IHXd8vLspLVt82aTdw2co=;
 b=e10YEhTmhYl6nEleEkfQ5GdFABZgwXmYWgKhVMt9z5bfxr9qwEm+Vw6YMxbm4si1Uj
 ObzuwaDjq3A1B9av7X16MzEPvmokghWi8C72zevfnHP/sP5ev24LZFV+Bx1FRL2k74xk
 zQgXLTw3sHhscoJJvqeovNQfxue38HJ8e4mGd+GE9EwhvGHv53GxY6bOb4aZ+0iTHSao
 UgoZ96V+1ITJcz3htJUCS/5qnK8wkV58UntI+ZV6TdqppqkE2JIB8Tgd2q9eDEnd0C8x
 qPaVXyYMn8tZDwKOD2TGSNQ8FAHmW4dg5QAc6Mn9OEsD7FeS9zDfT8Vg2v7VlIKNzSAl
 G92w==
X-Gm-Message-State: AOAM533l99y19xKAWJE6GcopCA4T37F7QexlZ8aGNy1VFu2m2er26HS8
 rrG/hSs1+yiNNMQqolBHRMBNxQ==
X-Google-Smtp-Source: ABdhPJx0OE49qJUIllsnRRF41WCicXTNT2KzJUs20xdPS7xiVUkY/qS3IozDVpjfuVo5+5ukcDBuNQ==
X-Received: by 2002:a17:90a:5309:: with SMTP id
 x9mr9513136pjh.111.1623425259905; 
 Fri, 11 Jun 2021 08:27:39 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:33c8:8e01:1161:6797])
 by smtp.gmail.com with UTF8SMTPSA id t143sm6505494pgb.93.2021.06.11.08.27.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jun 2021 08:27:39 -0700 (PDT)
From: Claire Chang <tientzu@chromium.org>
To: Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com,
 jgross@suse.com, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v9 03/14] swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool
 used
Date: Fri, 11 Jun 2021 23:26:48 +0800
Message-Id: <20210611152659.2142983-4-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210611152659.2142983-1-tientzu@chromium.org>
References: <20210611152659.2142983-1-tientzu@chromium.org>
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

Always have the pointer to the swiotlb pool used in struct device. This
could help simplify the code for other pools.

Signed-off-by: Claire Chang <tientzu@chromium.org>
---
 drivers/of/device.c     | 3 +++
 include/linux/device.h  | 4 ++++
 include/linux/swiotlb.h | 8 ++++++++
 kernel/dma/swiotlb.c    | 8 ++++----
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index c5a9473a5fb1..1defdf15ba95 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 
 	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
 
+	if (IS_ENABLED(CONFIG_SWIOTLB))
+		swiotlb_set_io_tlb_default_mem(dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_dma_configure_id);
diff --git a/include/linux/device.h b/include/linux/device.h
index 4443e12238a0..2e9a378c9100 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -432,6 +432,7 @@ struct dev_links_info {
  * @dma_pools:	Dma pools (if dma'ble device).
  * @dma_mem:	Internal for coherent mem override.
  * @cma_area:	Contiguous memory area for dma allocations
+ * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
  * @archdata:	For arch-specific additions.
  * @of_node:	Associated device tree node.
  * @fwnode:	Associated device node supplied by platform firmware.
@@ -540,6 +541,9 @@ struct device {
 #ifdef CONFIG_DMA_CMA
 	struct cma *cma_area;		/* contiguous memory area for dma
 					   allocations */
+#endif
+#ifdef CONFIG_SWIOTLB
+	struct io_tlb_mem *dma_io_tlb_mem;
 #endif
 	/* arch specific additions */
 	struct dev_archdata	archdata;
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 216854a5e513..008125ccd509 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -108,6 +108,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return mem && paddr >= mem->start && paddr < mem->end;
 }
 
+static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
+{
+	dev->dma_io_tlb_mem = io_tlb_default_mem;
+}
+
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -119,6 +124,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
 }
+static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
+{
+}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8a3e2b3b246d..29b950ab1351 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -344,7 +344,7 @@ void __init swiotlb_exit(void)
 static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
 			   enum dma_data_direction dir)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = mem->slots[index].orig_addr;
 	size_t alloc_size = mem->slots[index].alloc_size;
@@ -426,7 +426,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
 static int find_slots(struct device *dev, phys_addr_t orig_addr,
 		size_t alloc_size)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
@@ -503,7 +503,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned int i;
 	int index;
@@ -554,7 +554,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 			      size_t mapping_size, enum dma_data_direction dir,
 			      unsigned long attrs)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem;
 	unsigned long flags;
 	unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-- 
2.32.0.272.g935e593368-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
