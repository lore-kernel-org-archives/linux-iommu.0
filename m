Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8076394470
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772316832; cv=none; b=J2h6KI2s/ii4teWVeymiPadU4lYGqd2lcRsRt0oM5r4euiYRqHsijSnY4pGpUVayoEheUJKfa7D7vZ49kLJf3vI3Pprw/6WjzItDWIhnH6pjuyz8+VaeWEM4CQGCBuCuYhJWrnIibVpRiBNM+HxLer+KOA7Y9hz2Z+UF68Ojrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772316832; c=relaxed/simple;
	bh=Jac4gfotNi0DAxmvnR0gHDUo2CGlLaT5iQGpBT7GjC4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ByEq3Pl2Qg6Yem7xNwPeGIVyV6uq8jJFdG9gZGzPoa3l3a8QB2tB4SFpC+XCvhNzDB6DVoXkv2BYdHPLkvUV6BYXUihjVmZ2vRuswum5ODtLvxc7VSWniB1t08BmQlPEXkPEk+9D1Z42r2beY+hzNZH5oHCZXUMN+qfrz9m375I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKU6xDT0; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKU6xDT0"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35928defcd0so1906463a91.0
        for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772316830; x=1772921630; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DOMW7lLqJkPCgTyPACAEGaBRlsYC7CH2Bm6ysbwwZRI=;
        b=GKU6xDT0yS48WUqxHM8raiGuaYud6+jNxcIjbXnOYYaCcJkMRKpF3TU0CX7Pn8jCLq
         EShaXSJfRn88EiugUmeaSGEFR5jdLriigIksnpbQ1V8i3rITwNBLDjbaFmd+q76pC2+v
         7OqdrymQI0LbLVUKNCUmxhl+yY3IcQNq/Ufkr6FFA5sINzNvkJLcIBNcILyGB6VQvb7/
         gNoC8LE61/AqYzpSDURT5c6m5Up5jo5lTZhKsME70qCj6hlzrjC77YTvwQeNnuRvWtaL
         JQREYvvPpaPN2Khpk4GirWWOvRQ5Zo7AgvIr/fivrTO4jF15aMsCWT0u9O/uDdaKcugJ
         i1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772316830; x=1772921630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOMW7lLqJkPCgTyPACAEGaBRlsYC7CH2Bm6ysbwwZRI=;
        b=UgjCDfGEy14zf0efEJTXDUYWWoN4yLGp7KXoMH95htZZXzR7hasQc8G/R8Y6QLqdwG
         APDpD/cgdaC15vLrZcrH5cM81Y8TTGijO6P0XXFtU+OsWoqCEkhwAsougwTjlRNAbThM
         qOYjURmw1i/REAk2qjDadIEvM2Z12c8A9QVwxdfCpZYKeget7pQNwdXzpKptBe35547C
         3Fve/0rYX4KuJPmXFS2YPHcJxXa9IKRs43SX15aQoFQCLGSj3Qvhipkrfp3CZz3hpWui
         j83FuNEktIurs3xZCGEMjafhOplMzcaOM2mRYmylxWeLIsCEcPp9zj4l3hJhRKXtu9Ea
         9WKg==
X-Forwarded-Encrypted: i=1; AJvYcCUvUVJ7i6i2eqN1CYOegTd5/wR1lxvsihX/KhJP3XThvshWeokoEO1fp/L2RdD8L0A6yCsHdg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxmybxVgq3tBpOmsI8JxI/p5ytda9OI22tTXHm2YYmLpIioQzk
	lA9MWNv5Zr/2jDySGP/C4G1484j5xM06n2LqfzHqMVZTKTQI+lJsiv9Z
X-Gm-Gg: ATEYQzzlOg25pb3cBBLxQICsADqHbM2kW71rooeu+JRRz+RrwOWhMwKVzvxofbQCtPp
	rmpA0HsqkG2augcKxKFViAN7gHO1k1FxHFzWWOxjSnUdYIgFZbIJzZdPAsSV2ItbvO1HiMiCntU
	HRvoYvOjmQGsSofEdUYyo03J4Zq40bJbcj8LgR8F2AF/b7rS2CRoB1rN127LOOeMnjjhJMYfeym
	RaEBMOgwRm4KGdr0UYJlEGHHauwUc/+UuwcAWpdi6+sKz92GRq2+MFMMpmIaaXxDP1zgM9sq05T
	KI2Nliu9T4HZSRqidP6fyzieJcj2QaUOrjwbrKI4d+4IRFpbkYGNu19gTfDmEgZQLjVhMHiaoXH
	zNSC/bswF9BFcEtzPbjhpcx5RYLu1Xr0abFwAsJhEIMykzyMso6APE+QdnVR5z+CYbyoT92pNvX
	ApGrT4D4B8D9Lhd0AGAvWVS2LdyABCtAXJgXp3PugDgjFyUTk=
X-Received: by 2002:a17:90b:1ccc:b0:340:b912:536 with SMTP id 98e67ed59e1d1-35965cec355mr6169958a91.31.1772316829957;
        Sat, 28 Feb 2026 14:13:49 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f87d0csm8275940a91.1.2026.02.28.14.13.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:13:49 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Leon Romanovsky <leon@kernel.org>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: [PATCH v3 5/5] dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg
Date: Sun,  1 Mar 2026 06:13:37 +0800
Message-Id: <20260228221337.59951-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <baohua@kernel.org>

Extending these APIs with a flush argument:
dma_direct_unmap_phys(), dma_direct_map_phys(), and
dma_direct_sync_single_for_cpu(). For single-buffer cases, flush=true
would be used, while for SG cases flush=false would be used, followed
by a single flush after all cache operations are issued in
dma_direct_{map,unmap}_sg().

This ultimately benefits dma_map_sg() and dma_unmap_sg().

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
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 kernel/dma/direct.c  | 17 +++++++++++++----
 kernel/dma/direct.h  | 16 ++++++++++------
 kernel/dma/mapping.c |  6 +++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c7666e5d5e7c..ec887f443741 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -444,14 +444,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 {
 	struct scatterlist *sg;
 	int i;
+	bool need_sync = false;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
+		if (sg_dma_is_bus_address(sg)) {
 			sg_dma_unmark_bus_address(sg);
-		else
+		} else {
+			need_sync = true;
 			dma_direct_unmap_phys(dev, sg->dma_address,
-					      sg_dma_len(sg), dir, attrs);
+					      sg_dma_len(sg), dir, attrs, false);
+		}
 	}
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 }
 #endif
 
@@ -461,6 +466,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
+	bool need_sync = false;
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -472,8 +478,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 */
 			break;
 		case PCI_P2PDMA_MAP_NONE:
+			need_sync = true;
 			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
-					sg->length, dir, attrs);
+					sg->length, dir, attrs, false);
 			if (sg->dma_address == DMA_MAPPING_ERROR) {
 				ret = -EIO;
 				goto out_unmap;
@@ -492,6 +499,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 	return nents;
 
 out_unmap:
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index cbdbf9ddc8cc..ac8ff3feff51 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -67,13 +67,15 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 }
 
 static inline void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+		dma_addr_t addr, size_t size, enum dma_data_direction dir,
+		bool flush)
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
 	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu(paddr, size, dir);
-		arch_sync_dma_flush();
+		if (flush)
+			arch_sync_dma_flush();
 		arch_sync_dma_for_cpu_all();
 	}
 
@@ -82,7 +84,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 
 static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+		unsigned long attrs, bool flush)
 {
 	dma_addr_t dma_addr;
 
@@ -111,7 +113,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	if (!dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
-		arch_sync_dma_flush();
+		if (flush)
+			arch_sync_dma_flush();
 	}
 	return dma_addr;
 
@@ -124,7 +127,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 }
 
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs,
+		bool flush)
 {
 	phys_addr_t phys;
 
@@ -134,7 +138,7 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir, flush);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3928a509c44c..78d8b4039c3e 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -166,7 +166,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 
 	if (dma_map_direct(dev, ops) ||
 	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
-		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
+		addr = dma_direct_map_phys(dev, phys, size, dir, attrs, true);
 	else if (use_dma_iommu(dev))
 		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
 	else if (ops->map_phys)
@@ -207,7 +207,7 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops) ||
 	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
-		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
+		dma_direct_unmap_phys(dev, addr, size, dir, attrs, true);
 	else if (use_dma_iommu(dev))
 		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
 	else if (ops->unmap_phys)
@@ -373,7 +373,7 @@ void __dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
 
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir, true);
 	else if (use_dma_iommu(dev))
 		iommu_dma_sync_single_for_cpu(dev, addr, size, dir);
 	else if (ops->sync_single_for_cpu)
-- 
2.39.3 (Apple Git-146)

