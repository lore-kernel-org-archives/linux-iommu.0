Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65628641F
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766122663; cv=none; b=eWTT3o2dwyrDQMFgfyomA2YbIAa1K6dxDJ7o4SSxLen+tWQk1P8RN3rnCgRnNkCAXlNB6csn2RhTKOQdZGJ/T8zwto1bHp2G7VxzvkntTpz6YXzgGsKraF3aAWkqZF7tQy0qRRirl25gn/puhyLBu6KL8IjDZYgIYUnSCvJFy0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766122663; c=relaxed/simple;
	bh=6qIKRywSnWWq7hy1HRk8ynBQ/UoE1yw8azJnlduW0L0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKmet+Ba+ADrFaMToUOV4bOgfZWKDCWTJ+lEsyLlqhoJzWubKiysnIe7dYExHYB2ieCBYSCyNLXJ5PmmL3B0RpkjA+YiuK4V8KNFDhaE+jhSX2ChWKXV8nPPbsERfkGOOUyq2E0ulJ1hvSo79Wv4XwCInInl7qTghZ33yUcQcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3qXQaHH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3qXQaHH"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0a33d0585so13258845ad.1
        for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 21:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766122661; x=1766727461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eenPutgBr0kvR5xknWuBlG56Mzp4JXW/11o/+DFN/Mk=;
        b=e3qXQaHHOomoNrNCt70Ug2MIj2vLZTck6D6oUqF3Zny0fuXjhrQymvIFvlFO+Z0HuV
         Qm7KJASFl/k+Cdx/JDH+NWX3HKtBRFmZs60aHxR7C9FFu39vto7M3MPx/flBo+HXhXVF
         E3pkePrZGtWlxDDmlqHuOuYru/KUsvMeeqkd9RKziEEpbN4GZX24DFnvuBcJULb+TARk
         2BGB7kkj7+mt+BmLCMe3ozvey6Ass9ZY82zld5HmbYm07RxhSC3JuKp8uDoROL6Y5wsq
         hMis6iN8SbweKUimNra2RnDqbPTHe3bgCD+ZgJPA/S5u5dfju7QEOPvGpFWonJWksVud
         6HkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766122661; x=1766727461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eenPutgBr0kvR5xknWuBlG56Mzp4JXW/11o/+DFN/Mk=;
        b=lHununCtgbY0q+mhvod1taTCwanKNd3o2mybo+1/uu0tqS7ryt9z50cNryLG5UTDGD
         mWqaF706HduKB5IipqkP6yF+bjLjG7jAX/YMzngHwuzqZpZIwQlVTD7i3LR+jfBh3FPn
         qx4fBF+V8rEVnMWhZd1mJAY9Z9EgV5v7ygIStynaKBY3vjH4nCmVE7D2Qi811+wHEZNx
         SBzEyfz7EUT2K7irgOM0LnqRFiagoIhCT15Dkgzj5T1qkaRQh+LhZENvivZ0Ss880f/9
         Bj7WnDNdKYqC+aNp91gEgS0akNqSBCViJVwTcp8e7gxHzA7tay61fWZU3L7t6C36dyYe
         kKDg==
X-Forwarded-Encrypted: i=1; AJvYcCVOSYohV4ugjGWJiuW8LiZd1eWhjsRr5vTnj/U0sGQDODKrZG6AOUIUnALtQzQFAkp7q5okVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy67mKDQiy1DofjKZP3QZkPwSkcQxgSqr9cMBvuPDlprzyftBDs
	py5r+3oFQC65TzwhUaDopLL59IMsXeT3/C6vOhJY8DoyRD5Z7qEzdaes
X-Gm-Gg: AY/fxX61M8K0rKxQ/0LqsGzoJjV9FWm4q2u4zKdr8dOYgFtbP23UM55qfxAMO5Wwqfu
	/g47hmWMqB5Zal7yriEudNYTGWXZ8yrLuXENYRizaGz0q4HvbFbAqPJ4aQuNs/NN2EScUlL7b5b
	hueTeOnMNM9Q6Sfmic1gDm464v8geXaM95mXhvX7Nk/S21r9X+iMt0qDZJKHADpHylCgrmWn8AD
	uytfQV3tltSXhzV+ME+itQE5XywT+2iSixpPS+bP2EUw0uBR4PRHUNlfM8G4I9gR4q8XtJK3VQt
	+/FjbSZXLL2B348TObGF6GWFQl6wHf8ZUbWZhWpB0CHUWChU5Pw3FwqTN8CtyXRQFVuJazPHAhj
	UG3cmezwZwrkbMU8BBYGxgkymmMiiDiqvtK1tQjD1HR7wNHp7+yfTSfvEGbSuBaF5E8psncPlCm
	SDzd/WLWRE1my3FogiG1A=
X-Google-Smtp-Source: AGHT+IHOj/tomowDEiB20GWpwm1Eafm2xs2aEyUzFu0xX3zTdDmt2EBoWVTLaYigoPnj18tyH/xwXQ==
X-Received: by 2002:a17:902:d548:b0:2a1:325d:821a with SMTP id d9443c01a7336-2a2f2a4f0c5mr13846805ad.60.1766122660716;
        Thu, 18 Dec 2025 21:37:40 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d895sm9930215ad.54.2025.12.18.21.37.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 18 Dec 2025 21:37:40 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: catalin.marinas@arm.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	will@kernel.org
Cc: ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maz@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	zhengtangquan@oppo.com
Subject: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Fri, 19 Dec 2025 13:36:57 +0800
Message-Id: <20251219053658.84978-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251219053658.84978-1-21cnbao@gmail.com>
References: <20251219053658.84978-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This enables dma_direct_sync_sg_for_device, dma_direct_sync_sg_for_cpu,
dma_direct_map_sg, and dma_direct_unmap_sg to use batched DMA sync
operations when possible. This significantly improves performance on
devices without hardware cache coherence.

Tangquan's initial results show that batched synchronization can reduce
dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
phone platform (MediaTek Dimensity 9500). The tests were performed by
pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
sg entries per buffer) for 200 iterations and then averaging the
results.

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
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 kernel/dma/direct.c | 28 ++++++++++-----
 kernel/dma/direct.h | 86 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 95 insertions(+), 19 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50c3fe2a1d55..ed2339b0c5e7 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -403,9 +403,10 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(paddr, sg->length,
-					dir);
+			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
 	}
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
 }
 #endif
 
@@ -422,7 +423,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
@@ -430,8 +431,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 			arch_dma_mark_clean(paddr, sg->length);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu_all();
+		arch_sync_dma_batch_flush();
+	}
 }
 
 /*
@@ -443,14 +446,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 {
 	struct scatterlist *sg;
 	int i;
+	bool need_sync = false;
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
+		if (sg_dma_is_bus_address(sg)) {
 			sg_dma_unmark_bus_address(sg);
-		else
-			dma_direct_unmap_phys(dev, sg->dma_address,
+		} else {
+			need_sync = true;
+			dma_direct_unmap_phys_batch_add(dev, sg->dma_address,
 					      sg_dma_len(sg), dir, attrs);
+		}
 	}
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
 }
 #endif
 
@@ -460,6 +468,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
+	bool need_sync = false;
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -471,7 +480,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 */
 			break;
 		case PCI_P2PDMA_MAP_NONE:
-			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
+			need_sync = true;
+			sg->dma_address = dma_direct_map_phys_batch_add(dev, sg_phys(sg),
 					sg->length, dir, attrs);
 			if (sg->dma_address == DMA_MAPPING_ERROR) {
 				ret = -EIO;
@@ -491,6 +501,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
 	return nents;
 
 out_unmap:
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index da2fadf45bcd..a211bab26478 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -64,15 +64,11 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 		arch_sync_dma_for_device(paddr, size, dir);
 }
 
-static inline void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+static inline void __dma_direct_sync_single_for_cpu(struct device *dev,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr = dma_to_phys(dev, addr);
-
-	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(paddr, size, dir);
+	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu_all();
-	}
 
 	swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 
@@ -80,7 +76,31 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_dma_mark_clean(paddr, size);
 }
 
-static inline dma_addr_t dma_direct_map_phys(struct device *dev,
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+static inline void dma_direct_sync_single_for_cpu_batch_add(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu_batch_add(paddr, size, dir);
+
+	__dma_direct_sync_single_for_cpu(dev, paddr, size, dir);
+}
+#endif
+
+static inline void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	phys_addr_t paddr = dma_to_phys(dev, addr);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(paddr, size, dir);
+
+	__dma_direct_sync_single_for_cpu(dev, paddr, size, dir);
+}
+
+static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
@@ -108,9 +128,6 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		}
 	}
 
-	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
 	return dma_addr;
 
 err_overflow:
@@ -121,6 +138,53 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	return DMA_MAPPING_ERROR;
 }
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	dma_addr_t dma_addr = __dma_direct_map_phys(dev, phys, size, dir, attrs);
+
+	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
+
+	return dma_addr;
+}
+#endif
+
+static inline dma_addr_t dma_direct_map_phys(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	dma_addr_t dma_addr = __dma_direct_map_phys(dev, phys, size, dir, attrs);
+
+	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
+		arch_sync_dma_for_device(phys, size, dir);
+
+	return dma_addr;
+}
+
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	phys_addr_t phys;
+
+	if (attrs & DMA_ATTR_MMIO)
+		/* nothing to do: uncached and no swiotlb */
+		return;
+
+	phys = dma_to_phys(dev, addr);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_direct_sync_single_for_cpu_batch_add(dev, addr, size, dir);
+
+	swiotlb_tbl_unmap_single(dev, phys, size, dir,
+					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
+}
+#endif
+
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-- 
2.39.3 (Apple Git-146)

