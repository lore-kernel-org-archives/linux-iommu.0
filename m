Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086434A78E;
	Mon, 27 Apr 2026 05:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777269357; cv=none; b=TQ+F/h4gQwSImlKVSLBljroqlvPhNiB6/ku4bAEl2qzb1BnD52QwqAe3hI07I8/ClWfuEt4pkrFyst+CnX5+QL6sd3t0D3yKtwYHU9BpsrCjHn1HJLZFotqCpW71ZwFcdh2kpn0oGjR/b4SYqA+ON8T2SyRnN1D57fyjqp8qYmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777269357; c=relaxed/simple;
	bh=AKZl3hyjk4W1rC0aLWScXZTr07h4gBnRtI18zLYuxp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IweMIfyNMGlkuZQsfDykaRo1TXSVgHqP2BcQL5H5otwfC7CZUy9xDRW1STovsPv/MxikEaAP+xwBZbaVciRMWSoR3RDSyb6Uy2V9VPl1WTheZ3rq0qRqh2U5+ZkL8YJzKAoUa1AaFvppJUPDYtlsTArQ5ccoNqnP6rC4mLo2kY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohS2YRWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohS2YRWY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3998C19425;
	Mon, 27 Apr 2026 05:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777269356;
	bh=AKZl3hyjk4W1rC0aLWScXZTr07h4gBnRtI18zLYuxp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohS2YRWYZOk+mbH14uaSWgTPUGXxh4Fjfd/qMnTWcNvHdBrHlyGaAClhxAXqBr3ho
	 kBT5YATwCKY3M9l8zfY0u4d17QGd3uRYkdGH+bYcDT27RiPO1jMn/RFYoG489rIX8G
	 DfVVm/K1zoUiJOsskdlWJhSd96YUVQRud+2PQNxAf4zcqEJ7RmzQIUzjq3/R3Q2sC6
	 k3GnTWuQdcjv+U69NslnSgtxi6lFBOQPZPQTDR85IhVYj8wKSDA5SyWI0BqlFrzzFm
	 4oGA30DIDFg5n1X+4bCNcom4K7MasXk8hIE8kbHWKVctuE7NYm2kblH7CznpwaOEGe
	 l4z3EESxvloww==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: [PATCH v3 6/9] dma-direct: pass attrs to dma_capable() for DMA_ATTR_CC_SHARED checks
Date: Mon, 27 Apr 2026 11:25:06 +0530
Message-ID: <20260427055509.898190-7-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427055509.898190-1-aneesh.kumar@kernel.org>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach dma_capable() about DMA_ATTR_CC_SHARED so the capability
check can reject encrypted DMA addresses for devices that require
unencrypted/shared DMA.

Also propagate DMA_ATTR_CC_SHARED in swiotlb_map() when the selected
SWIOTLB pool is decrypted so the capability check sees the correct DMA
address attribute.

Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/x86/kernel/amd_gart_64.c | 30 ++++++++++++++++--------------
 drivers/xen/swiotlb-xen.c     |  9 ++++++---
 include/linux/dma-direct.h    |  9 ++++++++-
 kernel/dma/direct.h           |  6 +++---
 kernel/dma/swiotlb.c          |  8 +++++---
 5 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/arch/x86/kernel/amd_gart_64.c b/arch/x86/kernel/amd_gart_64.c
index e8000a56732e..b5f1f031d45b 100644
--- a/arch/x86/kernel/amd_gart_64.c
+++ b/arch/x86/kernel/amd_gart_64.c
@@ -180,22 +180,23 @@ static void iommu_full(struct device *dev, size_t size, int dir)
 }
 
 static inline int
-need_iommu(struct device *dev, unsigned long addr, size_t size)
+need_iommu(struct device *dev, unsigned long addr, size_t size, unsigned long attrs)
 {
-	return force_iommu || !dma_capable(dev, addr, size, true);
+	return force_iommu || !dma_capable(dev, addr, size, true, attrs);
 }
 
 static inline int
-nonforced_iommu(struct device *dev, unsigned long addr, size_t size)
+nonforced_iommu(struct device *dev, unsigned long addr, size_t size,
+		unsigned long attrs)
 {
-	return !dma_capable(dev, addr, size, true);
+	return !dma_capable(dev, addr, size, true, attrs);
 }
 
 /* Map a single continuous physical area into the IOMMU.
  * Caller needs to check if the iommu is needed and flush.
  */
 static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
-				size_t size, int dir, unsigned long align_mask)
+		size_t size, int dir, unsigned long align_mask, unsigned long attrs)
 {
 	unsigned long npages = iommu_num_pages(phys_mem, size, PAGE_SIZE);
 	unsigned long iommu_page;
@@ -206,7 +207,7 @@ static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
 
 	iommu_page = alloc_iommu(dev, npages, align_mask);
 	if (iommu_page == -1) {
-		if (!nonforced_iommu(dev, phys_mem, size))
+		if (!nonforced_iommu(dev, phys_mem, size, attrs))
 			return phys_mem;
 		if (panic_on_overflow)
 			panic("dma_map_area overflow %lu bytes\n", size);
@@ -231,10 +232,10 @@ static dma_addr_t gart_map_phys(struct device *dev, phys_addr_t paddr,
 	if (unlikely(attrs & DMA_ATTR_MMIO))
 		return DMA_MAPPING_ERROR;
 
-	if (!need_iommu(dev, paddr, size))
+	if (!need_iommu(dev, paddr, size, attrs))
 		return paddr;
 
-	bus = dma_map_area(dev, paddr, size, dir, 0);
+	bus = dma_map_area(dev, paddr, size, dir, 0, attrs);
 	flush_gart();
 
 	return bus;
@@ -289,7 +290,7 @@ static void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 /* Fallback for dma_map_sg in case of overflow */
 static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
-			       int nents, int dir)
+		int nents, int dir, unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -301,8 +302,8 @@ static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nents, i) {
 		unsigned long addr = sg_phys(s);
 
-		if (nonforced_iommu(dev, addr, s->length)) {
-			addr = dma_map_area(dev, addr, s->length, dir, 0);
+		if (nonforced_iommu(dev, addr, s->length, attrs)) {
+			addr = dma_map_area(dev, addr, s->length, dir, 0, attrs);
 			if (addr == DMA_MAPPING_ERROR) {
 				if (i > 0)
 					gart_unmap_sg(dev, sg, i, dir, 0);
@@ -401,7 +402,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		s->dma_address = addr;
 		BUG_ON(s->length == 0);
 
-		nextneed = need_iommu(dev, addr, s->length);
+		nextneed = need_iommu(dev, addr, s->length, attrs);
 
 		/* Handle the previous not yet processed entries */
 		if (i > start) {
@@ -449,7 +450,7 @@ static int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 	/* When it was forced or merged try again in a dumb way */
 	if (force_iommu || iommu_merge) {
-		out = dma_map_sg_nonforce(dev, sg, nents, dir);
+		out = dma_map_sg_nonforce(dev, sg, nents, dir, attrs);
 		if (out > 0)
 			return out;
 	}
@@ -473,7 +474,8 @@ gart_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_addr,
 		return vaddr;
 
 	*dma_addr = dma_map_area(dev, virt_to_phys(vaddr), size,
-			DMA_BIDIRECTIONAL, (1UL << get_order(size)) - 1);
+				 DMA_BIDIRECTIONAL,
+				 (1UL << get_order(size)) - 1, attrs);
 	flush_gart();
 	if (unlikely(*dma_addr == DMA_MAPPING_ERROR))
 		goto out_free;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2cbf2b588f5b..7584c6f42141 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -212,7 +212,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	BUG_ON(dir == DMA_NONE);
 
 	if (attrs & DMA_ATTR_MMIO) {
-		if (unlikely(!dma_capable(dev, phys, size, false))) {
+		if (unlikely(!dma_capable(dev, phys, size, false, attrs))) {
 			dev_err_once(
 				dev,
 				"DMA addr %pa+%zu overflow (mask %llx, bus limit %llx).\n",
@@ -231,7 +231,7 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	 * we can safely return the device addr and not worry about bounce
 	 * buffering it.
 	 */
-	if (dma_capable(dev, dev_addr, size, true) &&
+	if (dma_capable(dev, dev_addr, size, true, attrs) &&
 	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
 	    !range_straddles_page_boundary(phys, size) &&
 		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
@@ -250,10 +250,13 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 	phys = map;
 	dev_addr = xen_phys_to_dma(dev, map);
 
+	if (dev->dma_io_tlb_mem->decrypted)
+		attrs |= DMA_ATTR_CC_SHARED;
+
 	/*
 	 * Ensure that the address returned is DMA'ble
 	 */
-	if (unlikely(!dma_capable(dev, dev_addr, size, true))) {
+	if (unlikely(!dma_capable(dev, dev_addr, size, true, attrs))) {
 		__swiotlb_tbl_unmap_single(dev, map, size, dir,
 				attrs | DMA_ATTR_SKIP_CPU_SYNC,
 				swiotlb_find_pool(dev, map));
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 94fad4e7c11e..1281d91050a4 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -135,12 +135,19 @@ static inline bool force_dma_unencrypted(struct device *dev)
 #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
-		bool is_ram)
+		bool is_ram, unsigned long attrs)
 {
 	dma_addr_t end = addr + size - 1;
 
 	if (addr == DMA_MAPPING_ERROR)
 		return false;
+	/*
+	 * if phys addr attribute is encrypted but the
+	 * device is forcing an encrypted dma addr
+	 */
+	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
+		return false;
+
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
 	    min(addr, end) < phys_to_dma(dev, PFN_PHYS(min_low_pfn)))
 		return false;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 7140c208c123..e05dc7649366 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -101,15 +101,15 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 
 	if (attrs & DMA_ATTR_MMIO) {
 		dma_addr = phys;
-		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
 			goto err_overflow;
 	} else if (attrs & DMA_ATTR_CC_SHARED) {
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
+		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
 			goto err_overflow;
 	} else {
 		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
+		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
 		    dma_kmalloc_needs_bounce(dev, size, dir)) {
 			if (is_swiotlb_active(dev) &&
 			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dad351988daf..0d3ae9a0130a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1640,12 +1640,14 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 	/*
 	 * Use the allocated io_tlb_mem encryption type to determine dma addr.
 	 */
-	if (dev->dma_io_tlb_mem->decrypted)
+	if (dev->dma_io_tlb_mem->decrypted) {
 		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
-	else
+		attrs |= DMA_ATTR_CC_SHARED;
+	} else {
 		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
+	}
 
-	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs))) {
 		__swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC,
 			swiotlb_find_pool(dev, swiotlb_addr));
-- 
2.43.0

