Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D381428F1
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661121; cv=none; b=sFr1ekf8m1e3Q+tC/QN02zvGHTFG04BuTcI9hVs5weQe6UqVJyIAFuSHBvHK1bmR2jS9FPbLwTZpiz9bEjosJBJOR8kisTzILMJBizxZ6RWsO7a5Qs6mlBMMTolDw6tbLum7M2lONjiLA51EAQ6Vp9Xl3+ODfCpWD7jAMl+0Z9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661121; c=relaxed/simple;
	bh=mtIzNlhGSjW2XWdx94955DEdlnQTz7eQkAIDlwrpybU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2lE2ljkehodSuc05rNhp8Fy/lRkqhNt1ejTwYkh4+z2ZqhcIcxOe13gIvl56RZp1RETkErIMVlG8W8g5Ud7hynlJnZzjomtTJ56NcGVuOoUWb3UyXN1xCgolpD6Qct0hyPlKMlr13d8NhHCvqbS1xbtdHC0o3mMumYZeZHD0rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SZUU/nfL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SZUU/nfL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j3V/VcNVaK7L8CG4WJkL+lwdtms7LUsMTA8cLz26qME=; b=SZUU/nfLXaFmklM4KD2UOn+z0i
	60sDquCHafOqhIZ6xC/6q0kRD3e/+a+2JZwqiCUYGrQDYO5IPHfDmu4LM1ducJanigWrehGtazDw+
	hXZWZTr9e4Q4qc6ZZ0i5LbLvGv2GbFTOJW9vrhz01J3uwWmIIvP3lyRW65U/iVGGO2pxbezYal+U7
	4vp3PisDCpV/wkcXSPiAcpO5d1z1XT4I6niMlnHHUoq6mDUgW3p26iwQBykRFtJsv58iXqhW7szvp
	lgSP5CycnqWw2s/0wa5kcm7l+peqHIqSFpWZ9HXsCZ77LfEPbDB53wNr5bohtjcP6tPfUXDssVPUZ
	ahoo0PvA==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Trw-0000000D2eC-477C;
	Wed, 23 Oct 2024 05:25:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/2] dma-debug: store a phys_addr_t in struct dma_debug_entry
Date: Wed, 23 Oct 2024 07:25:03 +0200
Message-ID: <20241023052511.309695-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023052511.309695-1-hch@lst.de>
References: <20241023052511.309695-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

dma-debug goes to great length to split incoming physical addresses into
a PFN and offset to store them in struct dma_debug_entry, just to
recombine those for all meaningful uses.  Just store a phys_addr_t
instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 79 ++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 51 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index d570535342cb..e1da50a36bdc 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -59,8 +59,7 @@ enum map_err_types {
  * @direction: enum dma_data_direction
  * @sg_call_ents: 'nents' from dma_map_sg
  * @sg_mapped_ents: 'mapped_ents' from dma_map_sg
- * @pfn: page frame of the start address
- * @offset: offset of mapping relative to pfn
+ * @paddr: physical start address of the mapping
  * @map_err_type: track whether dma_mapping_error() was checked
  * @stack_len: number of backtrace entries in @stack_entries
  * @stack_entries: stack of backtrace history
@@ -74,8 +73,7 @@ struct dma_debug_entry {
 	int              direction;
 	int		 sg_call_ents;
 	int		 sg_mapped_ents;
-	unsigned long	 pfn;
-	size_t		 offset;
+	phys_addr_t	 paddr;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
 	unsigned int	stack_len;
@@ -389,14 +387,6 @@ static void hash_bucket_del(struct dma_debug_entry *entry)
 	list_del(&entry->list);
 }
 
-static unsigned long long phys_addr(struct dma_debug_entry *entry)
-{
-	if (entry->type == dma_debug_resource)
-		return __pfn_to_phys(entry->pfn) + entry->offset;
-
-	return page_to_phys(pfn_to_page(entry->pfn)) + entry->offset;
-}
-
 /*
  * For each mapping (initial cacheline in the case of
  * dma_alloc_coherent/dma_map_page, initial cacheline in each page of a
@@ -428,8 +418,8 @@ static DEFINE_SPINLOCK(radix_lock);
 
 static phys_addr_t to_cacheline_number(struct dma_debug_entry *entry)
 {
-	return (entry->pfn << CACHELINE_PER_PAGE_SHIFT) +
-		(entry->offset >> L1_CACHE_SHIFT);
+	return ((entry->paddr >> PAGE_SHIFT) << CACHELINE_PER_PAGE_SHIFT) +
+		(offset_in_page(entry->paddr) >> L1_CACHE_SHIFT);
 }
 
 static int active_cacheline_read_overlap(phys_addr_t cln)
@@ -538,11 +528,11 @@ void debug_dma_dump_mappings(struct device *dev)
 			if (!dev || dev == entry->dev) {
 				cln = to_cacheline_number(entry);
 				dev_info(entry->dev,
-					 "%s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+					 "%s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 					 type2name[entry->type], idx,
-					 phys_addr(entry), entry->pfn,
-					 entry->dev_addr, entry->size,
-					 &cln, dir2name[entry->direction],
+					 &entry->paddr, entry->dev_addr,
+					 entry->size, &cln,
+					 dir2name[entry->direction],
 					 maperr2str[entry->map_err_type]);
 			}
 		}
@@ -569,13 +559,13 @@ static int dump_show(struct seq_file *seq, void *v)
 		list_for_each_entry(entry, &bucket->list, list) {
 			cln = to_cacheline_number(entry);
 			seq_printf(seq,
-				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx cln=%pa %s %s\n",
+				   "%s %s %s idx %d P=%pa D=%llx L=%llx cln=%pa %s %s\n",
 				   dev_driver_string(entry->dev),
 				   dev_name(entry->dev),
 				   type2name[entry->type], idx,
-				   phys_addr(entry), entry->pfn,
-				   entry->dev_addr, entry->size,
-				   &cln, dir2name[entry->direction],
+				   &entry->paddr, entry->dev_addr,
+				   entry->size, &cln,
+				   dir2name[entry->direction],
 				   maperr2str[entry->map_err_type]);
 		}
 		spin_unlock_irqrestore(&bucket->lock, flags);
@@ -1003,16 +993,16 @@ static void check_unmap(struct dma_debug_entry *ref)
 			   "[mapped as %s] [unmapped as %s]\n",
 			   ref->dev_addr, ref->size,
 			   type2name[entry->type], type2name[ref->type]);
-	} else if ((entry->type == dma_debug_coherent) &&
-		   (phys_addr(ref) != phys_addr(entry))) {
+	} else if (entry->type == dma_debug_coherent &&
+		   ref->paddr != entry->paddr) {
 		err_printk(ref->dev, entry, "device driver frees "
 			   "DMA memory with different CPU address "
 			   "[device address=0x%016llx] [size=%llu bytes] "
-			   "[cpu alloc address=0x%016llx] "
-			   "[cpu free address=0x%016llx]",
+			   "[cpu alloc address=0x%pa] "
+			   "[cpu free address=0x%pa]",
 			   ref->dev_addr, ref->size,
-			   phys_addr(entry),
-			   phys_addr(ref));
+			   &entry->paddr,
+			   &ref->paddr);
 	}
 
 	if (ref->sg_call_ents && ref->type == dma_debug_sg &&
@@ -1227,8 +1217,7 @@ void debug_dma_map_page(struct device *dev, struct page *page, size_t offset,
 
 	entry->dev       = dev;
 	entry->type      = dma_debug_single;
-	entry->pfn	 = page_to_pfn(page);
-	entry->offset	 = offset;
+	entry->paddr	 = page_to_phys(page);
 	entry->dev_addr  = dma_addr;
 	entry->size      = size;
 	entry->direction = direction;
@@ -1323,8 +1312,7 @@ void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
 
 		entry->type           = dma_debug_sg;
 		entry->dev            = dev;
-		entry->pfn	      = page_to_pfn(sg_page(s));
-		entry->offset	      = s->offset;
+		entry->paddr	      = sg_phys(s);
 		entry->size           = sg_dma_len(s);
 		entry->dev_addr       = sg_dma_address(s);
 		entry->direction      = direction;
@@ -1370,8 +1358,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = dir,
@@ -1410,16 +1397,12 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
 
 	entry->type      = dma_debug_coherent;
 	entry->dev       = dev;
-	entry->offset	 = offset_in_page(virt);
+	entry->paddr	 = page_to_phys((is_vmalloc_addr(virt) ?
+				vmalloc_to_page(virt) : virt_to_page(virt)));
 	entry->size      = size;
 	entry->dev_addr  = dma_addr;
 	entry->direction = DMA_BIDIRECTIONAL;
 
-	if (is_vmalloc_addr(virt))
-		entry->pfn = vmalloc_to_pfn(virt);
-	else
-		entry->pfn = page_to_pfn(virt_to_page(virt));
-
 	add_dma_entry(entry, attrs);
 }
 
@@ -1429,7 +1412,6 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	struct dma_debug_entry ref = {
 		.type           = dma_debug_coherent,
 		.dev            = dev,
-		.offset		= offset_in_page(virt),
 		.dev_addr       = dma_addr,
 		.size           = size,
 		.direction      = DMA_BIDIRECTIONAL,
@@ -1439,10 +1421,8 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
 	if (!is_vmalloc_addr(virt) && !virt_addr_valid(virt))
 		return;
 
-	if (is_vmalloc_addr(virt))
-		ref.pfn = vmalloc_to_pfn(virt);
-	else
-		ref.pfn = page_to_pfn(virt_to_page(virt));
+	ref.paddr = page_to_phys((is_vmalloc_addr(virt) ?
+			vmalloc_to_page(virt) : virt_to_page(virt)));
 
 	if (unlikely(dma_debug_disabled()))
 		return;
@@ -1465,8 +1445,7 @@ void debug_dma_map_resource(struct device *dev, phys_addr_t addr, size_t size,
 
 	entry->type		= dma_debug_resource;
 	entry->dev		= dev;
-	entry->pfn		= PHYS_PFN(addr);
-	entry->offset		= offset_in_page(addr);
+	entry->paddr		= addr;
 	entry->size		= size;
 	entry->dev_addr		= dma_addr;
 	entry->direction	= direction;
@@ -1543,8 +1522,7 @@ void debug_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(s),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
@@ -1575,8 +1553,7 @@ void debug_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 		struct dma_debug_entry ref = {
 			.type           = dma_debug_sg,
 			.dev            = dev,
-			.pfn		= page_to_pfn(sg_page(s)),
-			.offset		= s->offset,
+			.paddr		= sg_phys(sg),
 			.dev_addr       = sg_dma_address(s),
 			.size           = sg_dma_len(s),
 			.direction      = direction,
-- 
2.45.2

