Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05F1A9FBF
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 02:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761705161; cv=none; b=h8payQRZB1mEpRKXHlg9IV9c/vLKsReW7ltxtH7X5eZC0IqdsP7NXruAq2DQackp6uWQceAfUiJdVrxx8ewSPaQSKsr8UvOT8yhqLwYTNrwVpH+peN7HSTUv+fXFkNihwhin/591ZHG4fkPeOofG5L64wcPBITdz9fsoVng/7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761705161; c=relaxed/simple;
	bh=FhMdW1amZrDZOTYi1F2Y9ii4zVzoBonKSxbmPFkN9mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qmBSNQfuX1d7fKBiZjA2ImCpnnMZ/3IDMjrbTXYrshWb9cb1GPXMR/5OGAsVZ1DKL6Jzc3vwkjEKx84FMYmqsSMYHn4JYAC8lIYNxGr4lKNQuBep8iJ/KTZExfszFHpz6Gr/2HT9YIrvC6amQWdvOtoK3HWEmVgZYY5uknoExhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJEEgQAI; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJEEgQAI"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3401314d845so3324921a91.1
        for <iommu@lists.linux.dev>; Tue, 28 Oct 2025 19:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761705159; x=1762309959; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXLeKP/DtOqQuL8m7vYar3R6RP6+fCAYk9I78/ihr2U=;
        b=aJEEgQAI0CEHjQfnCpuXpY0fRTnnBplmjxd7oou+5mVJmFjsvkq8w25WuqgF1m3f0T
         3fp5zqz5+7KzeetaInX4KGX+4l28Rm4srsnzVjeah5rD6mL2M43kvFQo+dKs4WtlHUaR
         HFk1oDe/vJR61hn+13RU0I/sEHJWBAQ31BlHhx46df8wZWZt0OfkdD12NIcdzilKjPHh
         KkJ9NQasoYppOWSzhyTdoeTleBekdKaNS9jGTyRNplL7OhrI3FtiQS0/dNVfQWucwaXZ
         Eayw0haqsu5n4KMw2iUbXLqLatM+bK68HD2R0aAI06xKLZcHz75Dn9SpPU340JWoM5BL
         iNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761705159; x=1762309959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXLeKP/DtOqQuL8m7vYar3R6RP6+fCAYk9I78/ihr2U=;
        b=KalIt5ilbDjYy9Qg7j2nY19+IEf1p9Q6646f9BfUcsh+kriepVDWH1/y6mlt0Nqud9
         qqMAamgXwIIw+42H49yO/N/MimBhl+9KAv8tRSVxqYD5q973S5nkLN1i2I7yggbDf/Du
         lXVgHHnyb77VTekoHFljeEITFujBodNW92D/7alLSvph+EpdnybFZURqejKRPl9L4wuL
         43Rkz7HmnMi/zv+mqZSJvExb4Bea2eKV+jIb9BCoGZr+ka5dxieKmIamvwv5XIuVon8k
         WxiBUiIACHlj+jBQeoCimQdCfkyifaCOLymdi6PC29MXgp9KbbIK07CV/k29oWyFX2RK
         cVUA==
X-Forwarded-Encrypted: i=1; AJvYcCULYFtQ8YodfjnWpsHgHkzLUZhqEgRqCSJYKGj0MgKP8IHTmLEbVNMSqsZS3zgi1ACedxmV+A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yygis6EZBKGGnic6NFjtJatBYONXgGDKDCKJcn8MvETqhrOEyrw
	cpOpBtYp1/agb8eFY7LEjgz1FqCvBVgfBcH384EeWUBs5WvKmIqiYOUg
X-Gm-Gg: ASbGncv+f9rFLQ6FHCptqbLEMcBVszGlijqRYsDMYjZUVa3uaumzA4WCrGQce/7edgt
	QytYNgFJniRlmTs7pV3MCOJFrI7tXybEbFcmpGSGMWCqCUPzM6ukPvtlD2Bcs8Bh04RUMg4L52N
	WNeXbhnr1/cs6YeOiValGKIajVxqIhs+rLqxhsf/ePaUP7wkNo17p29ycI1mWqdOeMqV9MMk0Sm
	ngnNe+nM4Sdg7cHUpM/FP7+s/oSKfN62hrOcaa+I5Hv5066mcl69sb15dYbsLWWpGSF3RwYFUny
	q0ffCUkH27d/Yio/hUAwRGMHoMDrXZa5hPSl1x4H1myp4sNOuNoeWhOfE+KOxl2Ao0819JL6rsG
	WFRKJIfepUPM+ZSOcBJK0C0t1dRPz8nMHsWDIVoJLC5RypUVHvwYKOBfy0vY4QKJsa2rjxmaZpJ
	SzzsvPufuXFwy9c3HYt3GzT7PpcNL24J9JE9JFlddqvepXJECUZZzdlwSUyg==
X-Google-Smtp-Source: AGHT+IFhBNLyIOct1mE9x8NjCrvkWR0gN9M9H3c4aZoq5oEbAmNrnFsNADSTOspd44npw8jvwAKgSg==
X-Received: by 2002:a17:90b:2549:b0:33f:ee05:56e1 with SMTP id 98e67ed59e1d1-3403a143527mr1244236a91.2.1761705159331;
        Tue, 28 Oct 2025 19:32:39 -0700 (PDT)
Received: from localhost.localdomain ([47.72.128.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed81a4afsm13649518a91.19.2025.10.28.19.32.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Oct 2025 19:32:38 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Barry Song <v-songbaohua@oppo.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: [RFC PATCH 5/5] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Wed, 29 Oct 2025 10:31:15 +0800
Message-Id: <20251029023115.22809-6-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251029023115.22809-1-21cnbao@gmail.com>
References: <20251029023115.22809-1-21cnbao@gmail.com>
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
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux.dev
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 kernel/dma/direct.c | 53 +++++++++++++++++++++++++---
 kernel/dma/direct.h | 86 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 123 insertions(+), 16 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1f9ee9759426..a0b45f84a91f 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -403,9 +403,16 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(paddr, sg->length,
-					dir);
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+			arch_sync_dma_for_device_batch_add(paddr, sg->length, dir);
+#else
+			arch_sync_dma_for_device(paddr, sg->length, dir);
+#endif
 	}
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
+#endif
 }
 #endif
 
@@ -422,7 +429,11 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
+#else
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+#endif
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
@@ -430,8 +441,12 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 			arch_dma_mark_clean(paddr, sg->length);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu_all();
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+		arch_sync_dma_batch_flush();
+#endif
+	}
 }
 
 /*
@@ -443,14 +458,29 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 {
 	struct scatterlist *sg;
 	int i;
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+	bool need_sync = false;
+#endif
 
 	for_each_sg(sgl,  sg, nents, i) {
-		if (sg_dma_is_bus_address(sg))
+		if (sg_dma_is_bus_address(sg)) {
 			sg_dma_unmark_bus_address(sg);
-		else
+		} else {
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+			need_sync = true;
+			dma_direct_unmap_phys_batch_add(dev, sg->dma_address,
+					      sg_dma_len(sg), dir, attrs);
+
+#else
 			dma_direct_unmap_phys(dev, sg->dma_address,
 					      sg_dma_len(sg), dir, attrs);
+#endif
+		}
 	}
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
+#endif
 }
 #endif
 
@@ -460,6 +490,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+	bool need_sync = false;
+#endif
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -471,8 +504,14 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 			 */
 			break;
 		case PCI_P2PDMA_MAP_NONE:
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+			need_sync = true;
+			sg->dma_address = dma_direct_map_phys_batch_add(dev, sg_phys(sg),
+					sg->length, dir, attrs);
+#else
 			sg->dma_address = dma_direct_map_phys(dev, sg_phys(sg),
 					sg->length, dir, attrs);
+#endif
 			if (sg->dma_address == DMA_MAPPING_ERROR) {
 				ret = -EIO;
 				goto out_unmap;
@@ -490,6 +529,10 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_batch_flush();
+#endif
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

