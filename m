Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801421CC68
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789631; cv=none; b=eYtVXemPbZzRQ5XnnDFQpBPrMK6ar4Naf+9o3gsG5f8BZwudyN3vnrDY3pRDmr49uBd7aEvq/MvGr0wDng96HRvSnyadLd0Kl9LjjDmtdaLd6MLGAO8LFi4IGBPYewwDDJ/DaNRiG4y74w/k6CGc6P8N+DiOB0nbiIqAi0iFaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789631; c=relaxed/simple;
	bh=H+JcZ3ALFKjMEK+ridC5ARPUqoSBVPZTR86r1nheB4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjVJmTSYPZMxNXiI/FCLuc8sahsh3xfTUz0AD2tE79t7F+pHirtajK3ypJyPMknVd7zbF3NkqBQMEHOaMHNyTB1HJahDcYqyMugTCKFH7WP577hWhP/GZqV16T9suOR4B6CJx+TNfqC3FHR7IS4tN0fELcRTpAK+UMeE7j45Z58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2fgT9TH; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2fgT9TH"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c718c5481so7362445a91.3
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789629; x=1767394429; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CBlUJRZIbYM1prFWy/0G8KDccWD/YxTB/AJqWrZ/Ys=;
        b=E2fgT9THUqqpbbKw32lB8PLg96IN30A/I2EV1Ilfwg0bYtS55oQ3Hsw5yIiS5ZQ7vf
         HYi9ix6sTx+pAke+Nge4kkPkhEBQ/1k4WCdJlbkryO/85fl0qU0iZfYVDk/hgqWgJD4B
         jXWDzd5eoQQsEZvlj7t91AtnCf+GLEdejQ/RiUkeR2Oa1khwm4oaS70IpBveUMwhh99x
         NuheH4WvtQUz/1rkQWTEBuj/cgSA2qG1M1VLIjc1/8a96UwziWWbwgDNAFQScZnzfoHz
         BcMvmfxOpRRcfpBB4wikx8yTMEZ8PrTM5oxCdTK7BDnlU1BT/HN3SHqqfW3F/6mYNVws
         jY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789629; x=1767394429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9CBlUJRZIbYM1prFWy/0G8KDccWD/YxTB/AJqWrZ/Ys=;
        b=rP9vnujKta7hIJU6+BGvKfLKJWvVuMhenQ8i0EIY1W4cMm15jO0ufAJWUhyOgdxNSA
         piZkwbZiT6XgeTLX+Mys8DSku1iArd6Y3i1dZbRfrSoEKy2Hl/dj2X+2KK8gw6BBvhVO
         A2Y3JTS0qslJ0vHRlvy6I/zDu/ddODwUJriyJJyELenGNIrMHkEF0AIgtDGPfNPXN/0f
         OFascG2hb5NDAlpRnB509x/cI88D4a2oipZqXTfAWhUsChEFbCmpXwwmZBZoi3JHogjw
         A/b1uPO513LuShEYGl+9IpEL8qwXp8X9cEfdy+g+T2WeM5lZ/VHRwnFJRiP9D0u0VXdw
         0Flw==
X-Forwarded-Encrypted: i=1; AJvYcCVgmY0PyC1uRZiGVBqJzuzzqWxCaV/TYMFykD78NSxDMoALR2F26DC8rYPNpVA1jFwUq43G2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzKEzvJEIMY2n2Y4xjRRJSwS5ZE1HXXAU59OuCV1AFYWfB9fpKj
	2iFrT02Eq/YGcPT8I5j/K5Qv++576LYgysqts6jZ0gfh7AnSs8EtbnXB
X-Gm-Gg: AY/fxX4KQzsHeVIjf9QiX8DmJKigfbmGLqQk0Yclq1DSocqFswf0sp5o8CJVtqeUkFE
	GvjI0ln+ojVUqzVHMq6wgFJYNPhum/KamyYa6Z+1RcKE4QDAfJXzq+JxdKutM7OoLLL0JyXHdH2
	VoW8PA8gvLwKsN9nTJ+ta/SWsuxcFmvW8oRCpAVPssXCIdKKuiXlsm/XwxLakKMmBOAI589wsU3
	RKO/XLUq3DVOaKtjoloa1o/3ACCjWrRYRlkgJXGvqSr8wT/+DIWFAMgqjhoW0KM/TTkzwjEuZc+
	lSAXp7nQYyR/KlfWXPfCY8D0P8gUPwigV/AR0FbRv+eXmPZfPhmvoA3r3v1SUYANrJQKtkxtch9
	51yh4VZYn8s6HVyr9s212sdzh5Sb0u8akUAzMdoN5AH6cn2rEsvC5+L2mVw4YZ2VdfmPDtN6HXW
	DKDyjM6JLRu8S+
X-Google-Smtp-Source: AGHT+IF6GTCerKOqMOKSYSeLfAiimvUN3+7D1SxAsR14bBFsurGjwmGev9rAORcjp7S0YIZTn6CThQ==
X-Received: by 2002:a17:90b:560c:b0:32d:e780:e9d5 with SMTP id 98e67ed59e1d1-34e921c3003mr16987619a91.22.1766789629137;
        Fri, 26 Dec 2025 14:53:49 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:53:48 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Joerg Roedel <joro@8bytes.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH v2 4/8] dma-mapping: Separate DMA sync issuing and completion waiting
Date: Sat, 27 Dec 2025 11:52:44 +1300
Message-ID: <20251226225254.46197-5-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251226225254.46197-1-21cnbao@gmail.com>
References: <20251226225254.46197-1-21cnbao@gmail.com>
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

To address this, arch_sync_dma_for_* now issues DMA operations in
batch, followed by a flush. On ARM64, the flush is implemented
using a dsb instruction within arch_sync_dma_flush().

For now, add arch_sync_dma_flush() after each
arch_sync_dma_for_*() call. arch_sync_dma_flush() is defined as a
no-op on all architectures except arm64, so this patch does not
change existing behavior. Subsequent patches will introduce true
batching for SG DMA buffers.

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
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 arch/arm64/include/asm/cache.h |  6 ++++++
 arch/arm64/mm/dma-mapping.c    |  4 ++--
 drivers/iommu/dma-iommu.c      | 37 +++++++++++++++++++++++++---------
 drivers/xen/swiotlb-xen.c      | 24 ++++++++++++++--------
 include/linux/dma-map-ops.h    |  6 ++++++
 kernel/dma/direct.c            |  8 ++++++--
 kernel/dma/direct.h            |  9 +++++++--
 kernel/dma/swiotlb.c           |  4 +++-
 8 files changed, 73 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index dd2c8586a725..487fb7c355ed 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -87,6 +87,12 @@ int cache_line_size(void);
 
 #define dma_get_cache_alignment	cache_line_size
 
+static inline void arch_sync_dma_flush(void)
+{
+	dsb(sy);
+}
+#define arch_sync_dma_flush arch_sync_dma_flush
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
index c92088855450..6827763a3877 100644
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
@@ -1122,13 +1126,16 @@ void iommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
 	struct scatterlist *sg;
 	int i;
 
-	if (sg_dma_is_swiotlb(sgl))
+	if (sg_dma_is_swiotlb(sgl)) {
 		for_each_sg(sgl, sg, nelems, i)
 			iommu_dma_sync_single_for_cpu(dev, sg_dma_address(sg),
 						      sg->length, dir);
-	else if (!dev_is_dma_coherent(dev))
-		for_each_sg(sgl, sg, nelems, i)
+	} else if (!dev_is_dma_coherent(dev)) {
+		for_each_sg(sgl, sg, nelems, i) {
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+			arch_sync_dma_flush();
+		}
+	}
 }
 
 void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
@@ -1143,8 +1150,10 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 							 sg_dma_address(sg),
 							 sg->length, dir);
 	else if (!dev_is_dma_coherent(dev))
-		for_each_sg(sgl, sg, nelems, i)
+		for_each_sg(sgl, sg, nelems, i) {
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+			arch_sync_dma_flush();
+		}
 }
 
 static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
@@ -1219,8 +1228,10 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 			return DMA_MAPPING_ERROR;
 	}
 
-	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
 	if (iova == DMA_MAPPING_ERROR && !(attrs & DMA_ATTR_MMIO))
@@ -1242,8 +1253,10 @@ void iommu_dma_unmap_phys(struct device *dev, dma_addr_t dma_handle,
 	if (WARN_ON(!phys))
 		return;
 
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev))
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) && !dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	__iommu_dma_unmap(dev, dma_handle, size);
 
@@ -1836,8 +1849,10 @@ static int __dma_iova_link(struct device *dev, dma_addr_t addr,
 	bool coherent = dev_is_dma_coherent(dev);
 	int prot = dma_info_to_prot(dir, coherent, attrs);
 
-	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+	if (!coherent && !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_flush();
+	}
 
 	return iommu_map_nosync(iommu_get_dma_domain(dev), addr, phys, size,
 			prot, GFP_ATOMIC);
@@ -2008,8 +2023,10 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 			end - addr, iovad->granule - iova_start_pad);
 
 		if (!dev_is_dma_coherent(dev) &&
-		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 			arch_sync_dma_for_cpu(phys, len, dir);
+			arch_sync_dma_flush();
+		}
 
 		swiotlb_tbl_unmap_single(dev, phys, len, dir, attrs);
 
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
index 4809204c674c..e7dd8a63b40e 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -361,6 +361,12 @@ static inline void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
 }
 #endif /* ARCH_HAS_SYNC_DMA_FOR_CPU */
 
+#ifndef arch_sync_dma_flush
+static inline void arch_sync_dma_flush(void)
+{
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL
 void arch_sync_dma_for_cpu_all(void);
 #else
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50c3fe2a1d55..a219911c7b90 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -402,9 +402,11 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
-		if (!dev_is_dma_coherent(dev))
+		if (!dev_is_dma_coherent(dev)) {
 			arch_sync_dma_for_device(paddr, sg->length,
 					dir);
+			arch_sync_dma_flush();
+		}
 	}
 }
 #endif
@@ -421,8 +423,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	for_each_sg(sgl, sg, nents, i) {
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
-		if (!dev_is_dma_coherent(dev))
+		if (!dev_is_dma_coherent(dev)) {
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+			arch_sync_dma_flush();
+		}
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index da2fadf45bcd..a69326eed266 100644
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
 
@@ -109,8 +112,10 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
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
index a547c7693135..7cdbfcdfef86 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1595,8 +1595,10 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
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
2.43.0

