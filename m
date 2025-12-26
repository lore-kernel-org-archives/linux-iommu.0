Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D09298CB2
	for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766789650; cv=none; b=mY/tcED5QEyMIyU8QECEVD8LRlSZYpxHsq5By3xnllfUyHqRkkXQ+uInyM8yt8uyK12FjscoIMdUiEP04JZaw23mi5qhZG+soG6+W+7fNLXdFRkkPs79eGLItwDGF4jjpqZ2yfsQ3AXApix1JW97eFwMzp9tQKkidZdPNWBDnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766789650; c=relaxed/simple;
	bh=y0GAlTukBhrwG28eorWp2ff1UapqeGDpOXnThHTS++U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzkL3xv+P8SjNy8Y/7LnAVoYYRUfpIpfZBYGAKvgHjqi2bZQXU/S828pxoWsODlHObFmweiZuUX7MMmg4QSnLjc4fYSgo8IWNHLQneqUyRbwtfr/31HGo2u5YxVx+S/m7N7gN5ae+8+3wrpS6sHZn2dDUbzPO1Y8MOTihaaGasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzatDPO3; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzatDPO3"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so5727365a91.0
        for <iommu@lists.linux.dev>; Fri, 26 Dec 2025 14:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766789645; x=1767394445; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcGdIc/9DJZ3V/5WVf7vUUbl5wTlCyMzFQWvUiTQ7kw=;
        b=BzatDPO3wJOR4UQ0fYW3PLUE6piq6PShA3y5B88PzvjhSL3EBz3vqqfpX5R0fYG7mL
         Pk9zXgIZZU9SNsVtD6MZpopYxvgrzRliBsvjxvoXx2UCRzAdeOOa63Cp88gj8sp5ABCh
         lvv5Z68M2pytXFwNfuPHmW4pnU+zbKWRvJuYWR6NH7wA/q2j/Todi/CYzW/KufqruuWD
         mXq6eTO7TZ9E1aBUEnfQrg1WWOQKLiQHnXW+/C78jdSQPCraBDeQ2qM9eR+Ih2tP40j/
         Lrf4s16IkW7Y1qIWJF2gJfNymhgIxk+Entd7p5iBNU7uOgewrldZ1WxZ4BO0VvhG4rn/
         91hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766789645; x=1767394445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcGdIc/9DJZ3V/5WVf7vUUbl5wTlCyMzFQWvUiTQ7kw=;
        b=u7MPIc5+TCSEkUCFTRyVhAh8oQVBKXbUPG/L9dMZdUER1RdnpRJaXNJ1wXzB2B7huX
         +4mgDEd+GTO54cf2f/c9yulYr0pMxew9eXm3wrQGV3VkNs1IzzMLozs/lRl7dQRNT/cI
         h49Ax4w2pKg7YCZLAnJV3fAlLATCt0uaKR3mzxJcdmVwhimRDPLgknWZmilCFKCReDvk
         X0rE9/iTpUqJQX9tAK0/PMV5/l1sijjAXBQ+SOBcbceOn/rblSou7F+Gv/r7S0EEDuRg
         GEnTerXVWftdoL4JGxFoym5/4BmODo7w9JMvEcet7QiMHp6bQ2TA6qhHxL30yxZFEKNg
         XCwg==
X-Forwarded-Encrypted: i=1; AJvYcCWXR0EC9wL5rJH63WQB57B556lURQBh40aD6yx3WYF9vhv9ew4yYiiUQPt6Dk0phgfpcu9eiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPxx7ufyqIq4PtONS1EFpS828VHwfQB+QMq8LBsxCUijWULW01
	0uWyMMvVTeLAVncDztMg+zdsTDk5PmNPvTxHj/fe++Qo8///+zP6MyMC
X-Gm-Gg: AY/fxX7K7BjuP4rqx6mMj3SExg9rqwPPdaB2QIwySvkuBWuEIv+MqIEvZ6xBSl4DCGw
	NP1fPARt1eZBLBrKhIHdPoVB0b566+vif2cCfwR9jx83ON5mVbaMUpWPvr/n7IWn7b6iLe1+VfU
	8z+AhSSlWciZdzuUFOhHIfeRpjslKRPG/DQqvxKETGbCkHit/n35FTSa4phokwjkC/AaZrtxfy/
	aHiQfMysBZuCc8TgaYv+NeiaNTNDA93VyolREG5SvlGQDb+c48YR4LZ06c8gSTU49cPzj2GnqzJ
	P9a8k/LX9PlBdIYBvDxfzpBego2bBnBxz37hADzsFPlTqNP/FboH+9pIUyfDHJivkgk3/21N/FJ
	3A0FHVsjTqL5cf01bVn5n9Ubt7QIT9myQILgoenLYQ/Cjn+LCjlJU4lT1me/d2MG4M94zbpmbGZ
	TgdRKAiZb1Oxhc
X-Google-Smtp-Source: AGHT+IE+oJ1Ft1XOQ1XU6OeA4rerw4thrh1Pz4yYg+rxMS7HW6pD48/QipbV6W5OVknyxXIG+nvg1w==
X-Received: by 2002:a17:90b:5804:b0:34a:b459:bd10 with SMTP id 98e67ed59e1d1-34e921bf172mr21139744a91.24.1766789644533;
        Fri, 26 Dec 2025 14:54:04 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e772ac1acsm9981428a91.9.2025.12.26.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Dec 2025 14:54:03 -0800 (PST)
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
	Tangquan Zheng <zhengtangquan@oppo.com>
Subject: [PATCH v2 6/8] dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg
Date: Sat, 27 Dec 2025 11:52:46 +1300
Message-ID: <20251226225254.46197-7-21cnbao@gmail.com>
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

Leon suggested extending a flush argument to
dma_direct_unmap_phys(), dma_direct_map_phys(), and
dma_direct_sync_single_for_cpu(). For single-buffer cases, this
would use flush=true, while for SG cases flush=false would be
used, followed by a single flush after all cache operations are
issued in dma_direct_{map,unmap}_sg().

This ultimately benefits dma_map_sg() and dma_unmap_sg().

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
Cc: Tangquan Zheng <zhengtangquan@oppo.com>
Signed-off-by: Barry Song <baohua@kernel.org>
---
 kernel/dma/direct.c  | 17 +++++++++++++----
 kernel/dma/direct.h  | 16 ++++++++++------
 kernel/dma/mapping.c |  6 +++---
 3 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 98bacf562ca1..550a1a13148d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -447,14 +447,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
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
 
@@ -464,6 +469,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
+	bool need_sync = false;
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -475,8 +481,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
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
@@ -495,6 +502,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 	return nents;
 
 out_unmap:
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index a69326eed266..d4ad79828090 100644
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
 
@@ -85,7 +87,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 
 static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+		unsigned long attrs, bool flush)
 {
 	dma_addr_t dma_addr;
 
@@ -114,7 +116,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	if (!dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
-		arch_sync_dma_flush();
+		if (flush)
+			arch_sync_dma_flush();
 	}
 	return dma_addr;
 
@@ -127,7 +130,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 }
 
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs,
+		bool flush)
 {
 	phys_addr_t phys;
 
@@ -137,7 +141,7 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir, flush);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 37163eb49f9f..d8cfa56a3cbb 100644
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
2.43.0

