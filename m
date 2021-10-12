Return-Path: <SRS0=nyYM=PA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A39AC433EF
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 05:54:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2591360EDF
	for <iommu@archiver.kernel.org>; Tue, 12 Oct 2021 05:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2591360EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=effective-light.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE77260759;
	Tue, 12 Oct 2021 05:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qD6LZeCJxA30; Tue, 12 Oct 2021 05:54:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7A5DD605E0;
	Tue, 12 Oct 2021 05:54:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F583C0011;
	Tue, 12 Oct 2021 05:54:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29746C000D
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 05:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A0054020E
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 05:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tt-I46yHpNAR for <iommu@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 05:54:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from h4.fbrelay.privateemail.com (h4.fbrelay.privateemail.com
 [131.153.2.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D64E9401B2
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 05:54:42 +0000 (UTC)
Received: from MTA-12-3.privateemail.com (mta-12-1.privateemail.com
 [198.54.122.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by h3.fbrelay.privateemail.com (Postfix) with ESMTPS id 4710180AA7
 for <iommu@lists.linux-foundation.org>; Tue, 12 Oct 2021 01:54:41 -0400 (EDT)
Received: from mta-12.privateemail.com (localhost [127.0.0.1])
 by mta-12.privateemail.com (Postfix) with ESMTP id 6585A18000A7;
 Tue, 12 Oct 2021 01:54:38 -0400 (EDT)
Received: from hal-station.. (unknown [10.20.151.235])
 by mta-12.privateemail.com (Postfix) with ESMTPA id 68C5B18000A0;
 Tue, 12 Oct 2021 01:54:37 -0400 (EDT)
From: Hamza Mahfooz <someguy@effective-light.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: teach add_dma_entry() about DMA_ATTR_SKIP_CPU_SYNC
Date: Tue, 12 Oct 2021 01:54:03 -0400
Message-Id: <20211012055404.88571-1-someguy@effective-light.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: Hamza Mahfooz <someguy@effective-light.com>,
 Karsten Graul <kgraul@linux.ibm.com>, iommu@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Mapping something twice should be possible as long as,
DMA_ATTR_SKIP_CPU_SYNC is passed to the strictly speaking second relevant
mapping operation (that attempts to map the same thing). So, don't issue a
warning if the specified condition is met in add_dma_entry().

Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
---
 kernel/dma/debug.c   | 24 ++++++++++++++----------
 kernel/dma/debug.h   | 24 ++++++++++++++++--------
 kernel/dma/mapping.c | 12 ++++++------
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 95445bd6eb72..c4128df3de41 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -552,7 +552,7 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
  * Wrapper function for adding an entry to the hash.
  * This function takes care of locking itself.
  */
-static void add_dma_entry(struct dma_debug_entry *entry)
+static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 {
 	struct hash_bucket *bucket;
 	unsigned long flags;
@@ -566,7 +566,7 @@ static void add_dma_entry(struct dma_debug_entry *entry)
 	if (rc == -ENOMEM) {
 		pr_err("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST) {
+	} else if ((rc == -EEXIST) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
@@ -1191,7 +1191,8 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 EXPORT_SYMBOL(debug_dma_map_single);
 
 void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
-			size_t size, int direction, dma_addr_t dma_addr)
+			size_t size, int direction, dma_addr_t dma_addr,
+			unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1222,7 +1223,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 		check_for_illegal_area(dev, addr, size);
 	}
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -1280,7 +1281,8 @@ void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 
 void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-		      int nents, int mapped_ents, int direction)
+		      int nents, int mapped_ents, int direction,
+		      unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 	struct scatterlist *s;
@@ -1312,7 +1314,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		check_sg_segment(dev, s);
 
-		add_dma_entry(entry);
+		add_dma_entry(entry, attrs);
 	}
 }
 
@@ -1368,7 +1370,8 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 }
 
 void debug_dma_alloc_coherent(struct device *dev, size_t size,
-			      dma_addr_t dma_addr, void *virt)
+			      dma_addr_t dma_addr, void *virt,
+			      unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1398,7 +1401,7 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 	else
 		entry->pfn = page_to_pfn(virt_to_page(virt));
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_free_coherent(struct device *dev, size_t size,
@@ -1429,7 +1432,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 }
 
 void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
-			    int direction, dma_addr_t dma_addr)
+			    int direction, dma_addr_t dma_addr,
+			    unsigned long attrs)
 {
 	struct dma_debug_entry *entry;
 
@@ -1449,7 +1453,7 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 	entry->direction	= direction;
 	entry->map_err_type	= MAP_ERR_NOT_CHECKED;
 
-	add_dma_entry(entry);
+	add_dma_entry(entry, attrs);
 }
 
 void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
index 83643b3010b2..f525197d3cae 100644
--- a/kernel/dma/debug.h
+++ b/kernel/dma/debug.h
@@ -11,26 +11,30 @@
 #ifdef CONFIG_DMA_API_DEBUG
 extern void debug_dma_map_page(struct device *dev, struct page *page,
 			       size_t offset, size_t size,
-			       int direction, dma_addr_t dma_addr);
+			       int direction, dma_addr_t dma_addr,
+			       unsigned long attrs);
 
 extern void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 				 size_t size, int direction);
 
 extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-			     int nents, int mapped_ents, int direction);
+			     int nents, int mapped_ents, int direction,
+			     unsigned long attrs);
 
 extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 			       int nelems, int dir);
 
 extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
-				     dma_addr_t dma_addr, void *virt);
+				     dma_addr_t dma_addr, void *virt,
+				     unsigned long attrs);
 
 extern void debug_dma_free_coherent(struct device *dev, size_t size,
 				    void *virt, dma_addr_t addr);
 
 extern void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
 				   size_t size, int direction,
-				   dma_addr_t dma_addr);
+				   dma_addr_t dma_addr,
+				   unsigned long attrs);
 
 extern void debug_dma_unmap_resource(struct device *dev, dma_addr_t dma_addr,
 				     size_t size, int direction);
@@ -53,7 +57,8 @@ extern void debug_dma_sync_sg_for_device(struct device *dev,
 #else /* CONFIG_DMA_API_DEBUG */
 static inline void debug_dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
-				      int direction, dma_addr_t dma_addr)
+				      int direction, dma_addr_t dma_addr,
+				      unsigned long attrs)
 {
 }
 
@@ -63,7 +68,8 @@ static inline void debug_dma_unmap_page(struct device *dev, dma_addr_t addr,
 }
 
 static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
-				    int nents, int mapped_ents, int direction)
+				    int nents, int mapped_ents, int direction,
+				    unsigned long attrs)
 {
 }
 
@@ -74,7 +80,8 @@ static inline void debug_dma_unmap_sg(struct device *dev,
 }
 
 static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
-					    dma_addr_t dma_addr, void *virt)
+					    dma_addr_t dma_addr, void *virt,
+					    unsigned long attrs)
 {
 }
 
@@ -85,7 +92,8 @@ static inline void debug_dma_free_coherent(struct device *dev, size_t size,
 
 static inline void debug_dma_map_resource(struct device *dev, phys_addr_t addr,
 					  size_t size, int direction,
-					  dma_addr_t dma_addr)
+					  dma_addr_t dma_addr,
+					  unsigned long attrs)
 {
 }
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 06fec5547e7c..17c6d217f8fb 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -156,7 +156,7 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr);
+	debug_dma_map_page(dev, page, offset, size, dir, addr, attrs);
 
 	return addr;
 }
@@ -195,7 +195,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 
 	if (ents > 0)
-		debug_dma_map_sg(dev, sg, nents, ents, dir);
+		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
 			      ents != -EIO))
 		return -EIO;
@@ -305,7 +305,7 @@ dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 	else if (ops->map_resource)
 		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
 
-	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
+	debug_dma_map_resource(dev, phys_addr, size, dir, addr, attrs);
 	return addr;
 }
 EXPORT_SYMBOL(dma_map_resource);
@@ -510,7 +510,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	else
 		return NULL;
 
-	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr, attrs);
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_alloc_attrs);
@@ -566,7 +566,7 @@ struct page *dma_alloc_pages(struct device *dev, size_t size,
 	struct page *page = __dma_alloc_pages(dev, size, dma_handle, dir, gfp);
 
 	if (page)
-		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle);
+		debug_dma_map_page(dev, page, 0, size, dir, *dma_handle, 0);
 	return page;
 }
 EXPORT_SYMBOL_GPL(dma_alloc_pages);
@@ -644,7 +644,7 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (sgt) {
 		sgt->nents = 1;
-		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir);
+		debug_dma_map_sg(dev, sgt->sgl, sgt->orig_nents, 1, dir, attrs);
 	}
 	return sgt;
 }
-- 
2.33.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
