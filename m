Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036652AD3D
	for <iommu@lists.linux.dev>; Sun, 21 Dec 2025 05:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766294137; cv=none; b=qbYB4LRzDPQ5QiSiUs+UEZcSf6j+gZfP5Apg0YV2j8BVanEI0+DS6k4WSpc85/S0HZDnfpPMRym1+1L1FWuIhV3fCY5SDp84N7TWLB8fAl4EZMapZr0VJeW3+Ujvwza8hAr8QmeI4+S6iTU4LQ3zx9JuC46VR8u1sJW6vYhHIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766294137; c=relaxed/simple;
	bh=lqw/hboHx3ROopTDDyy9VMaHC5uPA3PcmRQKg2v2bbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFYLui9tH6dpzjZDKSQ9PwysJDSRPq0tj0ulzR9hv/ffhgiI8EI6CnTJBVaG6HEZPDpZ+0pMrf7UNpy6YeLbUUDcoSMb2UnxTfBzVNMDYRMSMs1YDz064I+v/ayyV1iW5AUxbuEYkZZ8sMYU+/99VCr6210g2mxxT3z7FRp9Yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYTllWGt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYTllWGt"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34abc7da414so2522137a91.0
        for <iommu@lists.linux.dev>; Sat, 20 Dec 2025 21:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766294135; x=1766898935; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zrm+sCPHTPnZ3R2lUhrTFOXrDyXAJEp9c+N8RivifRI=;
        b=WYTllWGtB733rp93V9eYSRk6VZG6onxyFHGxOocN7WAV8+FDhMqkFPloE2p9XSFs14
         Tn9RZjyelLmRumqNlW+2YJGg3ity6LKM9LFNJX4U6aBK+v5ah/4n2ATaQAsBLF62pWkb
         BycYSl31HTAj85N9Mg44RjnrT60xSccQ7MhCE5qsPgyhKMHHiM0oYCEDSM3Bq9Rx5MBk
         BS4Abmqt+gCU62260wl+sd/NkKLEfHABoEtiGrv4pimqnwrHVXAsX8kFWV09zFk20q1O
         0C4GkD6eaEBKMJYHoB5QT7Js8N+Y4marKi2U/bJo41ncy4hkxDZgGlz29M0pJ2pz54Yd
         l6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766294135; x=1766898935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zrm+sCPHTPnZ3R2lUhrTFOXrDyXAJEp9c+N8RivifRI=;
        b=KmrDGmxeudEmdzsCF+7RAq+7NVWU+6BcCVzQonqK7TsBWVxEgY63mbdlL/PVKkoId0
         4kyux0DPnL9LDKaEEEDxwc3ePMsV8rJKaiwQo96wMjOTZtDT9laU36OhFFWBakB1HWLY
         VsB5HsepLi5G+AZsZZvTk2O8Rz8RP8WcMBrHOIuwnLEUCzlyq68OVwAThkF9l7Wyx8QR
         5lyWcLdC3eFhWfqMssSM9kkPQ4YxhfLBPyNAOaBDYO8ZtW6XbBajAHWEQxL2U+RohRPw
         CWf7st2vH7kCZoD0Nx0Jm8fbT707c6VAyMNmYk41QCjfrNrToHJ8oxlRjURsRUxAIUWG
         Oq9w==
X-Forwarded-Encrypted: i=1; AJvYcCUN2xGLjjK1TuA3NvJIQ09VCqQslba5ZJJDwcVIv0cOJEfcET6MWyiphqiNl92lO+HLz2ByWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6NU4oVLv2416pkcfRxfsaUuHoR3hxYBHTE4PjGszA8CmHicdx
	eBRaQP3L3WWGopOE21JiJgDY8pza6rbR5REevvEaYn5w8BS47J/YbOSf
X-Gm-Gg: AY/fxX458nlAuxvEbeYdrtvlb6GSgr8pu7SQj9Aix6Yx9WhJ+Rcm5c9uaANx96uE/fR
	sl18zxm0LROkoSXBXsCzswMzKNNIXxiF/4dlvNGRK4PEPfP+scPyCbLnU407uqDFZTzi0ydJ1k3
	AdkywEPVJFRBdyGxb9Rg3+jAeCMXzH+eRbhJlqZ49lyNJW3dR1PaxxcC3sM5/l5OiXhjeBIJXIf
	e37Egn6EiXvFxrS5afnV/8TfueY9rUr492GH6Z7MQLQ8jvVNFTfqq5Qu+/byko68fvKGSGAnXh4
	P4D9OkuACxMqcn/q6Y+tfHZcowxzVRJyunavUyp9gXbUT1jPGtoWSRkzryPYUQ5T36mOzoktP22
	AxfFYwlXfe08NarJPx9MTB3iNtBKsICfs7esjvGtM2NCLzGBy5ziGfEsLJK4qS0JxY62/KebHaI
	V8QDn1/EElSPq94MKiF+HnaHRF
X-Google-Smtp-Source: AGHT+IG8fgdP5DyvYQfIsi79vPvO3rvDS48h/0TZoR1EsxLyaeNxkQLWaGjIbOP2x9FZnMrWOAqXpQ==
X-Received: by 2002:a17:90b:33c9:b0:32e:6fae:ba52 with SMTP id 98e67ed59e1d1-34e9211d59dmr6149016a91.6.1766294135006;
        Sat, 20 Dec 2025 21:15:35 -0800 (PST)
Received: from Barrys-MBP.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e9223adf5sm6402226a91.14.2025.12.20.21.15.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 20 Dec 2025 21:15:34 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: lkp@intel.com
Cc: 21cnbao@gmail.com,
	ada.coupriediaz@arm.com,
	anshuman.khandual@arm.com,
	ardb@kernel.org,
	catalin.marinas@arm.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	m.szyprowski@samsung.com,
	maz@kernel.org,
	oe-kbuild-all@lists.linux.dev,
	robin.murphy@arm.com,
	ryan.roberts@arm.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	will@kernel.org,
	zhengtangquan@oppo.com
Subject: Re: [PATCH 5/6] dma-mapping: Allow batched DMA sync operations if supported by the arch
Date: Sun, 21 Dec 2025 13:15:23 +0800
Message-Id: <20251221051523.18557-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <202512201836.f6KX6WMH-lkp@intel.com>
References: <202512201836.f6KX6WMH-lkp@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>
> All errors (new ones prefixed by >>):
>
> >> kernel/dma/direct.c:456:4: error: call to undeclared function 'dma_direct_unmap_phys_batch_add'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      456 |                         dma_direct_unmap_phys_batch_add(dev, sg->dma_address,
>          |                         ^
>    kernel/dma/direct.c:456:4: note: did you mean 'dma_direct_unmap_phys'?
>    kernel/dma/direct.h:188:20: note: 'dma_direct_unmap_phys' declared here
>      188 | static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
>          |                    ^
> >> kernel/dma/direct.c:484:22: error: call to undeclared function 'dma_direct_map_phys_batch_add'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      484 |                         sg->dma_address = dma_direct_map_phys_batch_add(dev, sg_phys(sg),
>          |                                           ^
>    2 errors generated.
>
>

Thanks very much for the report.
Can you please check if the below diff fix the build issue?

From 5541aa1efa19777e435c9f3cca7cd2c6a490d9f1 Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Sun, 21 Dec 2025 13:09:36 +0800
Subject: [PATCH] kernel/dma: Fix build errors for dma_direct_map_phys

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512201836.f6KX6WMH-lkp@intel.com/
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 kernel/dma/direct.h | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index a211bab26478..bcc398b5aa6b 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -138,8 +138,7 @@ static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
 	return DMA_MAPPING_ERROR;
 }
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
-static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
+static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
@@ -147,13 +146,13 @@ static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
 
 	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device_batch_add(phys, size, dir);
+		arch_sync_dma_for_device(phys, size, dir);
 
 	return dma_addr;
 }
-#endif
 
-static inline dma_addr_t dma_direct_map_phys(struct device *dev,
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
 {
@@ -161,13 +160,20 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 
 	if (dma_addr != DMA_MAPPING_ERROR && !dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
 
 	return dma_addr;
 }
+#else
+static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
+		phys_addr_t phys, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	return dma_direct_map_phys(dev, phys, size, dir, attrs);
+}
+#endif
 
-#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
-static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_t addr,
+static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t phys;
@@ -178,14 +184,14 @@ static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu_batch_add(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
-#endif
 
-static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
+#ifdef CONFIG_ARCH_WANT_BATCHED_DMA_SYNC
+static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
 	phys_addr_t phys;
@@ -196,9 +202,17 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu_batch_add(dev, addr, size, dir);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
+#else
+static inline void dma_direct_unmap_phys_batch_add(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	dma_direct_unmap_phys(dev, addr, size, dir, attrs);
+}
+#endif
+
 #endif /* _KERNEL_DMA_DIRECT_H */
-- 
2.39.3 (Apple Git-146)

Thanks
Barry

