Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F9426B742
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 02:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457421; cv=none; b=dTuessCC3OGNlZHk+bxcmWLo3yDk+a9P7r8p8dIE+JPLC4fnFxEPJDax05vWQuYkaxUcMnu2OsyYnfqbrcqm+ogchb3yw1NErzo66atYIDKPplRoU+vH0K1g+eU7Qge27mDmufvlgpbS9NbQDL6iFsY9ognmmZUK6iAJWfpFMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457421; c=relaxed/simple;
	bh=dVY+4ApU8RdOXwRzS5m97KruakbB5y2I/wh2b5ajRL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bR1ZBfiEvpWw2El/q/qSjEWYHEaeC8qtcfUxiOfKF9rd1Ehl8pcWV+7H9MXgvfjtMR7ekrA4nmEqw+kY9pHL3frngemeiy9WSfIjugNMzJ41ipdV2IjXuSMefSUw0X5dqC6J++0QE6uISPdbHVD8Znbu/zqeOUJKqtNbVcESlJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKeNf+yG; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKeNf+yG"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-803474aaa8bso940183b3a.0
        for <iommu@lists.linux.dev>; Mon, 22 Dec 2025 18:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766457419; x=1767062219; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2jom2nVm52M06JE+2UxZAwiHUkEaZ0dG9TF5/bVcM=;
        b=iKeNf+yG7l+7n7CWZbyMfeEZngrSG9AwZaODcZeTuk/98JbSsr4iIYdagelKkZrRHY
         bluzNbgWXBnzyjy7pkLPsNs77aRsFnmEXhK4OsKuJRxrvjy4ezS/p7ST/PqjP/vsq1Pt
         gFMPH8iVHa9JFl+JYJIuY8ASV2Mum4xIyUO59xiQqLRT5cmv3+J+7a+K9AeW7FwACJ5M
         TeWx2yNM7hoZI4vS0j+H8SW0Xl8qnp1WA5R3Hh2tZ+xtCoH2ovBsyxfaEkMxq6pire/y
         iqkDqS6Nth22Gm+KCXCEMiRgCgqvystlUshHbS2Nn1/UVPnw5WyGTkJlgQ7PBOUDy9fb
         GP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766457419; x=1767062219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EG2jom2nVm52M06JE+2UxZAwiHUkEaZ0dG9TF5/bVcM=;
        b=jQtFMczMhfx8K3G2DU1zBc2jgAjNxO2SvZjcyqPIWl55ZaDakMxPg5EdOr5K0srCMX
         A2sBCdFsYtXTzT7Ljkt7q+lBJp7KqtXGCl+3SZbwLoomTafP4yjHPxRfw+md3TzwpYmo
         8idrATuLmKszDHmUxRqo4KGhey9ubqpXgnedWETHnbvAMsIR6pyrqTv2TsEDDpO1+aNH
         Hwwv5hAglcnryhd+eGE48fOZ/70nfnB3DtrTNowPA2cSLnmXfu5aLkBUqdqNvQ6K17Ki
         ZbK2wh87kanklyA6tk0vLCqnX+7cHgkxFKubT2QWcYrgcAY7xbrahd/mGYEHgHWPlTZg
         w4yA==
X-Forwarded-Encrypted: i=1; AJvYcCXINVaX4RkDv4quK5F1b+G8meS/E3yZnlmeMF5aXnHiZYfiZ5J5ccylMRM9ixAGTeQmNgOhFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxP+C2gUHdC+eRnqIHVB7hNjjkCrLUrwyzHjXYwNVFw8tBSERXo
	nLrkY39b/tT3OGHgJ/dR3pkXVjWlGDTYpLMQeprO9C+E8nWRyOZ2Z7Ym
X-Gm-Gg: AY/fxX63el0czn8H1M3WGNkEb4IIIKN1Gln5aexc3tUZsNBcAVuqG/XyGnArdadlzDT
	G0Y6xyW3uMgNxmvCXCSvhpqH1m2TvJ9OA887mfCvUcMg6tbrgik+CV3GY6EAzo/x058+n1L1zwu
	pp8b4so56InJMOLd2SugfpxshSle/52O7iB+wRZYcHi7HkBpJa1HLa0MOB5R3tsV9Sya9yuRfpE
	EpbVgx8RFJXoZ6x/mG5IGJ9agU68L0pX+pGh3dUQm71TV7P6S/OFVWjDWYlr1IRimpigHsD+V4t
	Y3wqoB0NOVbjCaYHMnTOND4nnjIXUXHmprkVm0yzOTAM+jSnSGRfFUkXn91fdWe2hZU1S2VbYbW
	sR5aYgY5GMdoTPU6bISH0cHIaPHRQ/KewarzdGYWzSpfE2I8nlIZpaLcfhwaFSleWgzEUz8iU7k
	DhB1r6i8jXUyN32M6T9norsRIYHxzlYwogHQ==
X-Google-Smtp-Source: AGHT+IFpESelvsIvZ84qKN4f5qc9YV+VJzYgyjxTanTUZRfS+9fGdKninQTCQhz9sc2PNowSjWFdng==
X-Received: by 2002:aa7:9384:0:b0:7a9:acdf:e8f8 with SMTP id d2e1a72fcca58-7fe0b73a260mr10159988b3a.4.1766457419077;
        Mon, 22 Dec 2025 18:36:59 -0800 (PST)
Received: from barry-desktop.hub ([47.72.129.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7b4234e2sm11791930b3a.27.2025.12.22.18.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 18:36:58 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: 21cnbao@gmail.com,
	leon@kernel.org
Cc: ada.coupriediaz@arm.com,
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
Date: Tue, 23 Dec 2025 15:36:46 +1300
Message-ID: <20251223023648.31614-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CAGsJ_4yuvHNqHDi8eN-8UoY2McoXUeCMmbjFAr=jSdv8GpGKeg@mail.gmail.com>
References: <CAGsJ_4yuvHNqHDi8eN-8UoY2McoXUeCMmbjFAr=jSdv8GpGKeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

>
> >
> > I would also rename arch_sync_dma_batch_flush() to arch_sync_dma_flush().
>
> Sure.
>
> >
> > You can also minimize changes in dma_direct_map_phys() too, by extending
> > it's signature to provide if flush is needed or not.
>
> Yes. I have
>
> static inline dma_addr_t __dma_direct_map_phys(struct device *dev,
>                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
>                 unsigned long attrs, bool flush)
>
> and two wrappers:
> static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
>                 unsigned long attrs)
> {
>         return __dma_direct_map_phys(dev, phys, size, dir, attrs, true);
> }
>
> static inline dma_addr_t dma_direct_map_phys_batch_add(struct device *dev,
>                 phys_addr_t phys, size_t size, enum dma_data_direction dir,
>                 unsigned long attrs)
> {
>         return __dma_direct_map_phys(dev, phys, size, dir, attrs, false);
> }
>
> If you prefer exposing "flush" directly in dma_direct_map_phys()
> and updating its callers with flush=true, I think that’s fine.
>
> It could be also true for dma_direct_sync_single_for_device().

sorry for typo. I meant dma_direct_sync_single_for_cpu().
With flush passed as an argument, the patch becomes the following.
Please feel free to comment before I send v2.


diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 50c3fe2a1d55..5c65d213eb37 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -403,9 +403,11 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		swiotlb_sync_single_for_device(dev, paddr, sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_device(paddr, sg->length,
+			arch_sync_dma_for_device_batch_add(paddr, sg->length,
 					dir);
 	}
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 }
 #endif
 
@@ -422,7 +424,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (!dev_is_dma_coherent(dev))
-			arch_sync_dma_for_cpu(paddr, sg->length, dir);
+			arch_sync_dma_for_cpu_batch_add(paddr, sg->length, dir);
 
 		swiotlb_sync_single_for_cpu(dev, paddr, sg->length, dir);
 
@@ -430,8 +432,10 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 			arch_dma_mark_clean(paddr, sg->length);
 	}
 
-	if (!dev_is_dma_coherent(dev))
+	if (!dev_is_dma_coherent(dev)) {
 		arch_sync_dma_for_cpu_all();
+		arch_sync_dma_flush();
+	}
 }
 
 /*
@@ -443,14 +447,19 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
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
 
@@ -460,6 +469,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	struct pci_p2pdma_map_state p2pdma_state = {};
 	struct scatterlist *sg;
 	int i, ret;
+	bool need_sync = false;
 
 	for_each_sg(sgl, sg, nents, i) {
 		switch (pci_p2pdma_state(&p2pdma_state, dev, sg_page(sg))) {
@@ -471,8 +481,9 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
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
@@ -491,6 +502,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		sg_dma_len(sg) = sg->length;
 	}
 
+	if (need_sync && !dev_is_dma_coherent(dev))
+		arch_sync_dma_flush();
 	return nents;
 
 out_unmap:
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index da2fadf45bcd..b13eb5bfd051 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -65,12 +65,15 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 }
 
 static inline void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+		dma_addr_t addr, size_t size, enum dma_data_direction dir,
+		bool flush)
 {
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
 	if (!dev_is_dma_coherent(dev)) {
-		arch_sync_dma_for_cpu(paddr, size, dir);
+		arch_sync_dma_for_cpu_batch_add(paddr, size, dir);
+		if (flush)
+			arch_sync_dma_flush();
 		arch_sync_dma_for_cpu_all();
 	}
 
@@ -82,7 +85,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 
 static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
+		unsigned long attrs, bool flush)
 {
 	dma_addr_t dma_addr;
 
@@ -109,8 +112,11 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 	}
 
 	if (!dev_is_dma_coherent(dev) &&
-	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
-		arch_sync_dma_for_device(phys, size, dir);
+	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
+		arch_sync_dma_for_device_batch_add(phys, size, dir);
+		if (flush)
+			arch_sync_dma_flush();
+	}
 	return dma_addr;
 
 err_overflow:
@@ -122,7 +128,8 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 }
 
 static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+		size_t size, enum dma_data_direction dir, unsigned long attrs,
+		bool flush)
 {
 	phys_addr_t phys;
 
@@ -132,9 +139,10 @@ static inline void dma_direct_unmap_phys(struct device *dev, dma_addr_t addr,
 
 	phys = dma_to_phys(dev, addr);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir, flush);
 
 	swiotlb_tbl_unmap_single(dev, phys, size, dir,
 					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
 }
+
 #endif /* _KERNEL_DMA_DIRECT_H */
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
