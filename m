Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20422157B
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766345112; cv=none; b=FXouboIS2hUTvnW+zPaPArMKkOQzZ4OG36Izpd/BtUY1xhU/lAF5P3TeSarEZDdNnt4vqgJZmsgXhXJYLHexzpVDzVk1vK1OJIXf/uQevHvqsS9Hu6E0ecKKo+SC1qEFv5KVnLwje0ZI7QZ/8A/OiArHrDY/1Jp6QTGFWKuBwPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766345112; c=relaxed/simple;
	bh=hDH34MAI4T/ktGpMSPvpqb15lu0FjZ0WMeL2y4GoI7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHUucXa32qflx+lvyoYrIRUg2zLJOVQ9VqOlIMMAypVCRXfe21qA0Aa5KuEgbE81KHVDOrmxC2VdJz8Z3uzfcgG9/g4oh/XzM5vxHBY4SGCUsYlfW6NPyrLrmfJwJq/MzN1OKx/cAj6LynTTZBNy/3K1cyNzsARBPNejQdJQfWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k04Sx6Di; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k04Sx6Di"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0bae9aca3so46615945ad.3
        for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 11:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766345110; x=1766949910; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thbvw4jAc9qFXbQZxlasdweVQvzQ0G21GFKpTP76SAQ=;
        b=k04Sx6DiYyeIN72g4f2/B+ejOIXJjlBRQROAm5Xc7tSfE0vLF3A3SwT0E1Veel4mQU
         1c1mVT5cf8kMhgOfQzlxdX2HB32lOKDYzAeTr5ssCxIA82jpiVjgVFKJtmyWpcxJckPa
         gC6MXwemL8mUVBq6cyVa8B3MgvoCFCFRGb3G6F/gs+0ZKBSniOoVfyRZl1pPX3gKPhGv
         NI2TxIzjsB/5Pqzd+pzzj9s6k4FcdBKhbfe6q0Ee9ItO9JKOv1IllyWG0GyTg1HCKpMd
         Ui4EW+XFWvAuwQnbUF+xZj5d1gcSXb03Z5jtbgMGl9qYqPEpe33uJvhzFECBiptwntGp
         4teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766345110; x=1766949910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thbvw4jAc9qFXbQZxlasdweVQvzQ0G21GFKpTP76SAQ=;
        b=cTKcgmUMSKh8tYpWpr1RA7KgDYzcoVH65S9TC6xChE1Fqn22MSW1tghfummUK3Vt4K
         oF0gR7TOHRbihTKmWEnQVxo+s0WN32i1qauwMkcmVdiW5s3zdG8/z449cEcjOTlsIxsu
         7Gi0jhfbAZ4lLDUbLIMNUNd0nDEK4G3B1eaT6e6Lh1/6eqNF68U1IchphZhrgEhUmDV5
         Of9SDMrkgBhgdiRz9M+xJdjx9L4RJVlTvEAAm/O1lA79pUZixr3FqhkrCcusltQg/4Ii
         ev7VKVzuhc1mle65CyGr416xzqqb1XMhxzgKgugNcJiBj4ROWHIhuvrTS7SxOoD1ZbJm
         eOTg==
X-Forwarded-Encrypted: i=1; AJvYcCURySpdld4XRQANtlJSsniG/rdxn4o17YPly+VoWPY3iCRhI8u6H9TXaPIFQ310fgBLTehXUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIzKRf8MDJvPZfhP6UBTrDgmTg86SBXGrMVr3UBuxdSPYyTpnc
	l8HYXKVdJDSqO0RlQ9LVzAfGvkzFYc2SbqkYUFdHQnfpAzEgxgtaoNUp
X-Gm-Gg: AY/fxX4UpaC7vZlVRbywcTO9h9Jysm01Zs30w7Vl6d4WpAxN/eGcy7+aHU3MNWch1+N
	hTtnCNRxdPerPFuZUwLfbsbqudAENEiSsS2rwGTk78aS9bPByhijGI9lLl91hit99bBxQ8vIhym
	v1m5QouER7GtiYzlSme0Eol2l667Pg3aZn+Ws5wnGSaniTBYBAkh5iY22sPyfBmhaVtxenyqmm/
	r1+P4aIta7ksMZRSSvRQ619jRenaqGahhHiUpH7Bz+Ppj4pOrCfXNBpQVJmJ0+5wRaTcehPDY8b
	6Hastz14v7zF6wJYNwTvGXJ5gaomt5qyPDyOSsTJ+4t7aZL1yCVu+HpAcbKYI+B8VMywLb5p7ZT
	kOl3emrkCSTARSgQ5jlacNjvIq+6yw00ybeg/qvP3xfLd9mUHKouR2Nnz/Nkciec8hYSK2uQIGF
	Hlz2YGqcCtLK/3+znQoGzzSN7k
X-Google-Smtp-Source: AGHT+IGh+u8/09esmdKFv5uzl2lfPsJMPaLvSL5Po3+aPCp1tGS+/be/qQac7D60igIrYPvPxPgfqA==
X-Received: by 2002:a17:903:2285:b0:29b:e512:752e with SMTP id d9443c01a7336-2a2f293b6c1mr88369015ad.47.1766345110324;
        Sun, 21 Dec 2025 11:25:10 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c82aa8sm76559155ad.31.2025.12.21.11.25.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 21 Dec 2025 11:25:09 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: leon@kernel.org
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	m.szyprowski@samsung.com,
	maz@kernel.org,
	robin.murphy@arm.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Mon, 22 Dec 2025 03:24:58 +0800
Message-Id: <20251221192458.1320-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251221115523.GI13030@unreal>
References: <20251221115523.GI13030@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Dec 21, 2025 at 7:55 PM Leon Romanovsky <leon@kernel.org> wrote:
[...]
> > +
>
> I'm wondering why you don't implement this batch‑sync support inside the
> arch_sync_dma_*() functions. Doing so would minimize changes to the generic
> kernel/dma/* code and reduce the amount of #ifdef‑based spaghetti.
>

There are two cases: mapping an sg list and mapping a single
buffer. The former can be batched with
arch_sync_dma_*_batch_add() and flushed via
arch_sync_dma_batch_flush(), while the latter requires all work to
be done inside arch_sync_dma_*(). Therefore,
arch_sync_dma_*() cannot always batch and flush.

But yes, I can drop the ifdef in this patch. I have rewritten the entire
patch as shown below, and it will be tested today prior to
resending v2. Before I send v2, you are very welcome to comment.


From c03aae12c608b25fc1a84931ce78dbe3ef0f1ebe Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Wed, 29 Oct 2025 10:31:15 +0800
Subject: [PATCH v2 FOR DISCUSION 5/6] dma-mapping: Allow batched DMA sync operations

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

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 kernel/dma/direct.c | 28 +++++++++++++++------
 kernel/dma/direct.h | 59 +++++++++++++++++++++++++++++++++++++--------
 2 files changed, 69 insertions(+), 18 deletions(-)

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
index da2fadf45bcd..2e25af887204 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -64,13 +64,16 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 		arch_sync_dma_for_device(paddr, size, dir);
 }
 
-static inline void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+static inline void __dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir,
+		bool flush)
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
 	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_for_cpu_batch_add(paddr, size, dir);
+		if (flush)
+			arch_sync_dma_batch_flush();
 		arch_sync_dma_for_cpu_all();
 	}
 
@@ -80,9 +83,15 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 		arch_dma_mark_clean(paddr, size);
 }
 
-static inline dma_addr_t dma_direct_map_phys(struct device *dev,
+static inline void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+	__dma_direct_sync_single_for_cpu(dev, addr, size, dir, true);
+}
+
+static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+		unsigned long attrs, bool flush)
 {
 	dma_addr_t dma_addr;
 
@@ -109,8 +118,11 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	}
 
 	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
+		if (flush)
+			arch_sync_dma_batch_flush();
+	}
 	return dma_addr;
 
 err_overflow:
@@ -121,8 +133,23 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	return DMA_MAPPING_ERROR;
 }
 
-static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+static inline dma_addr_t dma_direct_map_phys(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return __dma_direct_map_phys(dev, phys, size, dir, attrs, true);
+}
+
+static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return __dma_direct_map_phys(dev, phys, size, dir, attrs, false);
+}
+
+static inline void __dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs,
+		bool flush)
 {
 	phys_addr_t phys;
 
@@ -132,9 +159,21 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		__dma_direct_sync_single_for_cpu(dev, addr, size, dir, flush);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
+
+static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	__dma_direct_unmap_phys(dev, addr, size, dir, attrs, true);
+}
+
+static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	__dma_direct_unmap_phys(dev, addr, size, dir, attrs, false);
+}
 #endif /* _KERNEL_DMA_DIRECT_H */
-- 
2.39.3 (Apple Git-146)
