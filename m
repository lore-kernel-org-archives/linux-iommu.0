Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E12373BEF
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316812; cv=none; b=oHWRdjkyP17NsCRmIyBMAgrCSqmTvt6JyyFs7eoY/8c0bMHnAEXy3OmYL3f6PD0WqsHN/di1P/oMn6/u5KX0CBg62LdlFNapzHXAekqo30U9LnDvkDWp6HcycTRnCLktLlpJzsCw3MEDbCrtec6PwP2GkJUvK9cBo22kxC1R/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316812; c=relaxed/simple;
	bh=z68hJwId7nj535F94mUhkq1/7jrcgkR9k2aCup2MG0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DRv5aIbsiIlfidTnhGLnyYd0/AYV56F39CV9hxYNlfX+WYAZrt4lk3708TOHzrOeOm1PKW7oQRtOxA0xyACmfziD7/Ygy3Fs8prVKquP9BHFQ6P5rMjdnbyw/jiT6M2GPmjZeLiTwsMJiNQSyyRMtddOa6nWRm1FJBAaCimPdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caQAah2t; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caQAah2t"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-827270d50d4so3359689b3a.3
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316810; x=1772921610; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6awcUYGAdW+BeRy1ycVcTLa+2uO0HwbfVjDnX1T7upc=;
        b=caQAah2tn0KSiwbJvPWyX9A0XMjRQSQsyO37mhmovVExHV7XqoDp1cDo/XxfN5QEdj
         F+NbeIxV9XhzGlY+VGR0MBG+KcS78zdo+Y5laWTqjcyqo76nS5nhi6cp3y9PwTCEHQ6R
         7dIpk8e9Wi2ar+AA3iCN6xa19nv8trsILimbqiQJUjqkjDfHxiTeAZTRthFWFAnJ1e95
         xy1SiEedrMkwqKgz5x/JBynPbaxzqlqSw2+XRjd63VaboNppQAuINrPhh52MvWz9vJJP
         7aUdlHb19OaBqhE1QKG150W50x8AS11eaN7Gp86nqN4NngRTcXNJnUc6qhjAogcoTZkj
         hLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316810; x=1772921610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6awcUYGAdW+BeRy1ycVcTLa+2uO0HwbfVjDnX1T7upc=;
        b=Xbl0Lq6pTRgzjLFs8lnU0jkjqyYNzmzPW/7qKFgk6vE9TyUpSXpaDamZyktpBdZWWS
         OkbWiChWw+b+U/c1u7IOd32OlObkf1/w75J0OyXVmtKza3qephk4wBvvxj8E32yFHQim
         20Q730yhMfFptexnQVy+icAq/lV98PhykSPjxN1BJqqy3L3rf7Gr0yf9z0yRr9S3qQeG
         ivTjbap5KsTz1x1NSeUvMoYC+FChNb51jGPimi+4latc8UwSk9DF9UheHYNRTcifOryZ
         gzixHsFTyu2cf1FkHu3bWmA7fq/SthJ9aCkQWEyMmTFt8k/xf7jJPrJANHumAsFDaNnF
         2Edg==
X-Forwarded-Encrypted: i=1; AJvYcCWtA0TAKTHk4aWiKBvr/6yWKPMOupyrXi4m7RWQkfD7EHLiPZOM33iQ4ByZXkz5Hew42aFdxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYKLfA6ZM7SUggvif1rju4ngZiawQs06zJPIQCoAN2hGPRQiWN
	quYInT5B9R6ozGY3RbUwTYylgd+pp+DGx5dMDduzb9mxgvsWQ/mrl9Q9
X-Gm-Gg: ATEYQzyYwc8sAmZUoRoTmHePUyV+FdL60yka9+QmL1KkqQDE32U9eh4SuegMxRyUzXW
	O79zMRRCvls5BDh0pyN5Eq2gkSR/fAfsSRfs5WJ/Cba0ZHfe26273G6zG9qPsiA9bHj5un1h0dx
	ttW5LAVcYh8mMve36IbjYALfO6KNUdYAtX33yuMb03iA7DBPgl/5DO0wSPy0b2FSS21sUIq6JrM
	BjXfOkX+CFWwXCbRIipdiiylnZlEYhylM2TnDHLTxDUi4iDsFkvkM6PbhE4tr4GP50gPK5OEjwD
	xImuhfGl3yLNhTdxdeKdhKyCP6dk9V+Kekn4Sy9Cx8H7N12b1xBPN9/TNemusllGEpPLbCIxLWA
	RnxvBkfyDHDaWL1BxSGsnmc07cWC5w4+fk/kVn2ozRMfC93e6miBLlapUzXo+Dk0KET2NweYa9U
	isCOiqp9fe47wH0VJdviHkih2411z9UIY73x6X
X-Received: by 2002:a05:6a00:9506:b0:824:b024:93dc with SMTP id d2e1a72fcca58-8274d9f446dmr8368764b3a.35.1772316809892;
        Sat, 28 Feb 2026 14:13:29 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa806295sm7926589a12.16.2026.02.28.14.13.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:13:28 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Juergen Gross <jgross@suse.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v3 4/5] dma-mapping: Separate DMA sync issuing and completion waiting
Date: Sun,  1 Mar 2026 06:13:16 +0800
Message-Id: <20260228221316.59934-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Currently, arch_sync_dma_for_cpu and arch_sync_dma_for_device
always wait for the completion of each DMA buffer. That is,
issuing the DMA sync and waiting for completion is done in a
single API call.

For scatter-gather lists with multiple entries, this means
issuing and waiting is repeated for each entry, which can hurt
performance. Architectures like ARM64 may be able to issue all
DMA sync operations for all entries first and then wait for
completion together.

To address this, arch_sync_dma_for_* now batches DMA operations
and performs a flush afterward. On ARM64, the flush is implemented
with a dsb instruction in arch_sync_dma_flush(). On other
architectures, arch_sync_dma_flush() is currently a nop.

Cc: Leon Romanovsky <leon@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Reviewed-by: Juergen Gross <jgross@suse.com> # drivers/xen/swiotlb-xen.c
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/include/asm/cache.h |  5 +++++
 arch/arm64/mm/dma-mapping.c    |  4 ++--
 drivers/iommu/dma-iommu.c      | 35 ++++++++++++++++++++++++++--------
 drivers/xen/swiotlb-xen.c      | 24 +++++++++++++++--------
 include/linux/dma-map-ops.h    |  6 ++++++
 kernel/dma/Kconfig             |  3 +++
 kernel/dma/direct.c            |  6 +++++-
 kernel/dma/direct.h            |  9 +++++++--
 kernel/dma/swiotlb.c           |  7 ++++++-
 10 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38dba5f7e4d2..ceafaac6532c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -55,6 +55,7 @@ config ARM64
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
+	select ARCH_HAS_BATCHED_DMA_SYNC
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index dd2c8586a725..10a7ffadee3d 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -87,6 +87,11 @@ int cache_line_size(void);
 
 #define dma_get_cache_alignment	cache_line_size
 
+static inline void arch_sync_dma_flush(void)
+{
+	dsb(sy);
+}
+
 /* Compress a u64 MPIDR value into 32 bits. */
 static inline u64 arch_compact_of_hwid(u64 id)
 {
diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index b2b5792b2caa..ae1ae0280eef 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -17,7 +17,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
 {
 	unsigned long start = (unsigned long)phys_to_virt(paddr);
 
-	dcache_clean_poc(start, start + size);
+	dcache_clean_poc_nosync(start, start + size);
 }
 
 void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
@@ -28,7 +28,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 	if (dir == DMA_TO_DEVICE)
 		return;
 
-	dcache_inval_poc(start, start + size);
+	dcache_inval_poc_nosync(start, start + size);
 }
 
 void arch_dma_prep_coherent(struct page *page, size_t size)
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5dac64be61bb..66fc25bae85b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1095,8 +1095,10 @@ void iommu_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
@@ -1112,8 +1114,10 @@ void iommu_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
 	swiotlb_sync_single_for_device(dev, phys, size, dir);
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 }
 
 void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
@@ -1122,13 +1126,15 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	if (sg_dma_is_swiotlb(sgl))
+	if (sg_dma_is_swiotlb(sgl)) {
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
-	else if (!dev_is_dma_coherent(dev))
+	} else if (!dev_is_dma_coherent(dev)) {
 		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+		arch_sync_dma_flush();
+	}
 }
 
 void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
@@ -1137,14 +1143,16 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	if (sg_dma_is_swiotlb(sgl))
+	if (sg_dma_is_swiotlb(sgl)) {
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_device(dev,
 							 sg_dma_address(sg),
 							 sg->length, dir);
-	else if (!dev_is_dma_coherent(dev))
+	} else if (!dev_is_dma_coherent(dev)) {
 		for_each_sg(sgl, sg, nelems, i)
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+		arch_sync_dma_flush();
+	}
 }
 
 static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
@@ -1219,8 +1227,10 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 			return DMA_MAPPING_ERROR;
 	}
 
-	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && !(attrs & DMA_ATTR_MMIO))
@@ -1242,8 +1252,10 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 	if (WARN_ON(!phys))
 		return;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	__iommu_dma_unmap(dev, dma_handle, size);
 
@@ -1980,6 +1992,8 @@ int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
 	dma_addr_t addr = state->addr + offset;
 	size_t iova_start_pad = iova_offset(iovad, addr);
 
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 	return iommu_sync_map(domain, addr - iova_start_pad,
 		      iova_align(iovad, size + iova_start_pad));
 }
@@ -1993,6 +2007,8 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
 	size_t iova_start_pad = iova_offset(iovad, addr);
+	bool need_sync_dma = !dev_is_dma_coherent(dev) &&
+			!(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO));
 	dma_addr_t end = addr + size;
 
 	do {
@@ -2016,6 +2032,9 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		addr += len;
 		iova_start_pad = 0;
 	} while (addr < end);
+
+	if (need_sync_dma)
+		arch_sync_dma_flush();
 }
 
 static void __iommu_dma_iova_unlink(struct device *dev,
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ccf25027bec1..b79917e785a5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -262,10 +262,12 @@ static dma_addr_t xen_swiotlb_map_phys(struct device *dev, phys_addr_t phys,
 
 done:
 	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr))))
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dev_addr)))) {
 			arch_sync_dma_for_device(phys, size, dir);
-		else
+			arch_sync_dma_flush();
+		} else {
 			xen_dma_sync_for_device(dev, dev_addr, size, dir);
+		}
 	}
 	return dev_addr;
 }
@@ -287,10 +289,12 @@ static void xen_swiotlb_unmap_phys(struct device *hwdev, dma_addr_t dev_addr,
 	BUG_ON(dir == DMA_NONE);
 
 	if (!dev_is_dma_coherent(hwdev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr))))
+		if (pfn_valid(PFN_DOWN(dma_to_phys(hwdev, dev_addr)))) {
 			arch_sync_dma_for_cpu(paddr, size, dir);
-		else
+			arch_sync_dma_flush();
+		} else {
 			xen_dma_sync_for_cpu(hwdev, dev_addr, size, dir);
+		}
 	}
 
 	/* NOTE: We use dev_addr here, not paddr! */
@@ -308,10 +312,12 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 	struct io_tlb_pool *pool;
 
 	if (!dev_is_dma_coherent(dev)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr)))) {
 			arch_sync_dma_for_cpu(paddr, size, dir);
-		else
+			arch_sync_dma_flush();
+		} else {
 			xen_dma_sync_for_cpu(dev, dma_addr, size, dir);
+		}
 	}
 
 	pool = xen_swiotlb_find_pool(dev, dma_addr);
@@ -331,10 +337,12 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 		__swiotlb_sync_single_for_device(dev, paddr, size, dir, pool);
 
 	if (!dev_is_dma_coherent(dev)) {
-		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
+		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr)))) {
 			arch_sync_dma_for_device(paddr, size, dir);
-		else
+			arch_sync_dma_flush();
+		} else {
 			xen_dma_sync_for_device(dev, dma_addr, size, dir);
+		}
 	}
 }
 
diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 60b63756df82..8a07df5a9ef6 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -361,6 +361,12 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifndef CONFIG_ARCH_HAS_BATCHED_DMA_SYNC
+static inline void arch_sync_dma_flush(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 void arch_sync_dma_for_cpu_all(void);
 #else
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 159900736f25..bfef21b4a9ae 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -72,6 +72,9 @@ config ARCH_HAS_DMA_PREP_COHERENT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_BATCHED_DMA_SYNC
+	bool
+
 #
 # Select this option if the architecture assumes DMA devices are coherent
 # by default.
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 8f43a930716d..c7666e5d5e7c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -406,6 +406,8 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 			arch_sync_dma_for_device(paddr, sg->length,
 					dir);
 	}
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 }
 #endif
 
@@ -427,8 +429,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
+		arch_sync_dma_flush();
 		arch_sync_dma_for_cpu_all();
+	}
 }
 
 /*
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e89f175e9c2d..cbdbf9ddc8cc 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -60,8 +60,10 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 
 	swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_device(paddr, size, dir);
+		arch_sync_dma_flush();
+	}
 }
 
 static inline void dma_direct_sync_single_for_cpu(struct device *dev,
@@ -71,6 +73,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 
 	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_flush();
 		arch_sync_dma_for_cpu_all();
 	}
 
@@ -106,8 +109,10 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	}
 
 	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 	return dma_addr;
 
 err_overflow:
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d8e6f1d889d5..1105db1689d5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -867,6 +867,9 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 	if (orig_addr == INVALID_PHYS_ADDR)
 		return;
 
+	if (dir == DMA_FROM_DEVICE && !dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
+
 	/*
 	 * It's valid for tlb_offset to be negative. This can happen when the
 	 * "offset" returned by swiotlb_align_offset() is non-zero, and the
@@ -1595,8 +1598,10 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
 		return DMA_MAPPING_ERROR;
 	}
 
-	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
 		arch_sync_dma_for_device(swiotlb_addr, size, dir);
+		arch_sync_dma_flush();
+	}
 	return dma_addr;
 }
 
-- 
2.39.3 (Apple Git-146)

