Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ED539E18C
	for <iommu@lists.linux.dev>; Fri,  1 May 2026 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634409; cv=none; b=YiIIsrpBLkuUlnWaQWeiWUnQH1Pw73/CdgxDgRysOn7ckSgOObdGlV/Y0+mrue5LBtxKd/tQsQLGuuwPrbUhRaEwHzdfmsvHEh5ckC2bE+/NUy46bISN1Zz1LqDx/VMbnU0JksXzI9PHJzuMR5vRb6db19s//7gASDoHJZ8YNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634409; c=relaxed/simple;
	bh=s+i9FkVsDdqiDhtbenKjDnOOXgFPIjoZdSeFxYf+bdE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jcy/8kP7pGR64w3pSyC7XSjnTdUykv4E4cSwo/pZVXiS+gTIORWNArBUgzpD6QnOJTM1tGPFRf02gCHdeH6kFKKnO4uGFksTkUkM8WgPHLCZbcgHZbrEO/02FCNJttLXAH0cce02EwrJGEWOCRw5Ce7veabOm/vXC9cGsThbono=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B0xBDAqS; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B0xBDAqS"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48a588ff84eso15059985e9.1
        for <iommu@lists.linux.dev>; Fri, 01 May 2026 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777634405; x=1778239205; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7C4551UfTUE9108SwsL7eQBuHqZOfGoFP6bfRW56kPQ=;
        b=B0xBDAqS2cIe8HMh3vQrEeatlestFyzRXNYMKYP5sfnlOkrFf93iCFZsPDdKGrAyJK
         4rEBUWQpi4qkwp2YCOFXbl/gZOWS88PRz6CgEj/gR/Gfb3ZJhHPk4rYNH/J9RZfkvKCa
         /CckT3a+CcXxLFQ/dBY7580TFkpdCX4QlgZ2+GbXTsozmO4G/PkYAY4fanH4nUd1QjNT
         TMqkWAM2UpQizm9WSnLCzI8K+U338SAlewIFzh5EsgRU1IKJSihLI9od/RpOqzLV/ltw
         KDjlstvdQbNJk+xpvOpPclElaXY/v+wgPxwjg4868sQFfxcchKw+B1O8txbF2EDY0qDS
         oiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777634405; x=1778239205;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7C4551UfTUE9108SwsL7eQBuHqZOfGoFP6bfRW56kPQ=;
        b=SGTZjobRgFIFy5E6mm8YBimHAPVcuF0whGo8g8QIu2ZDwt0cCllsCCI7KoZx7k57a5
         0W1aaZJa6KpDga90gVHy1q279WXG4owcZt16eBnsIR/1yIyVFH+aqH54XOjTkH3a2Vxw
         qXfy8ySnPP0uCgVS+HuBi02EZXMgmLRmuZf71TfApvlPxlZ0BJbFUY5xsjf5jVow2L7w
         He0ORA9I6kt12KyC1/rHxNkPvihLyY3KQkkHWPucI/GtjCO4hqVNg6AfeKvWYmiCCwH5
         Rm3POYSkLWS0JLboDNo52c8sQfNZO8mc2WbBHX1CPhaL4kBNTybxPPTt3fx5EsI8QnjT
         wong==
X-Forwarded-Encrypted: i=1; AFNElJ+spmZnIJK3G9Dj319d7mvKwqldz3Y5KbXgr/RsGUZsCr3AXk4YTmVK7FwDJCX3ETu6QkeZTg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy35f21hxPE/LjBGWOgcAadhuU/QX4zLgA9kRmNhYSBXK09p0aP
	a+prIqq6oabk9hkHDQ7bQtVF4jAGwPpZ2Vp7KWZWD4a7fzOWh0pj28lLGMMuGadyaSIsiXo/goM
	C0OAJA/Z2u4brgA==
X-Received: from wmro23.prod.google.com ([2002:a05:600c:3797:b0:485:2f8c:9478])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0ca:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48a83d1a406mr82848235e9.0.1777634405297;
 Fri, 01 May 2026 04:20:05 -0700 (PDT)
Date: Fri,  1 May 2026 11:19:08 +0000
In-Reply-To: <20260501111928.259252-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260501111928.259252-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260501111928.259252-7-smostafa@google.com>
Subject: [PATCH v6 06/25] iommu/io-pgtable-arm: Rework to use the iommu-pages API
From: Mostafa Saleh <smostafa@google.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org, jgg@ziepe.ca, 
	mark.rutland@arm.com, qperret@google.com, tabba@google.com, 
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

To prepare for supporting io-pgtable-arm in the pKVM hypervisor,
we need to abstract away standard kernel allocations, frees, virt/phys
conversions, and DMA API mapping.

This patch introduces a set of generic wrappers in iommu-pages.h:
- iommu_alloc_data
- iommu_free_data
- iommu_virt_to_phys
- iommu_phys_to_virt
- iommu_pages_dma_map
- iommu_pages_dma_mapping_error
- iommu_pages_dma_unmap

The io-pgtable-arm.c code is updated to universally use these new
wrappers instead of standard kernel kmalloc_obj, kfree, virt_to_phys,
dma_map_single, etc. This abstraction makes it easy to replace them with
hypervisor-specific implementations in a later patch.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 37 ++++++++++++++++------------------
 drivers/iommu/iommu-pages.h    | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0208e5897c29..e765021308f9 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -15,7 +15,6 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/dma-mapping.h>
 
 #include <asm/barrier.h>
 
@@ -143,7 +142,7 @@
 #define ARM_MALI_LPAE_MEMATTR_WRITE_ALLOC 0x8DULL
 
 /* IOPTE accessors */
-#define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
+#define iopte_deref(pte, d) iommu_phys_to_virt(iopte_to_paddr(pte, d))
 
 #define iopte_type(pte)					\
 	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
@@ -245,7 +244,7 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
 
 static dma_addr_t __arm_lpae_dma_addr(void *pages)
 {
-	return (dma_addr_t)virt_to_phys(pages);
+	return (dma_addr_t)iommu_virt_to_phys(pages);
 }
 
 static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
@@ -272,15 +271,15 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 		return NULL;
 
 	if (!cfg->coherent_walk) {
-		dma = dma_map_single(dev, pages, size, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, dma))
+		dma = iommu_pages_dma_map(dev, pages, size);
+		if (iommu_pages_dma_mapping_error(dev, dma))
 			goto out_free;
 		/*
 		 * We depend on the IOMMU being able to work with any physical
 		 * address directly, so if the DMA layer suggests otherwise by
 		 * translating or truncating them, that bodes very badly...
 		 */
-		if (dma != virt_to_phys(pages))
+		if (dma != iommu_virt_to_phys(pages))
 			goto out_unmap;
 	}
 
@@ -288,7 +287,7 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 
 out_unmap:
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
-	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
+	iommu_pages_dma_unmap(dev, dma, size);
 
 out_free:
 	if (cfg->free)
@@ -304,8 +303,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 				  void *cookie)
 {
 	if (!cfg->coherent_walk)
-		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
-				 size, DMA_TO_DEVICE);
+		iommu_pages_dma_unmap(cfg->iommu_dev, __arm_lpae_dma_addr(pages), size);
 
 	if (cfg->free)
 		cfg->free(cookie, pages, size);
@@ -316,8 +314,7 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 static void __arm_lpae_sync_pte(arm_lpae_iopte *ptep, int num_entries,
 				struct io_pgtable_cfg *cfg)
 {
-	dma_sync_single_for_device(cfg->iommu_dev, __arm_lpae_dma_addr(ptep),
-				   sizeof(*ptep) * num_entries, DMA_TO_DEVICE);
+	iommu_pages_flush_incoherent(cfg->iommu_dev, ptep, 0, sizeof(*ptep) * num_entries);
 }
 
 static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct io_pgtable_cfg *cfg, int num_entries)
@@ -395,7 +392,7 @@ static arm_lpae_iopte arm_lpae_install_table(arm_lpae_iopte *table,
 	arm_lpae_iopte old, new;
 	struct io_pgtable_cfg *cfg = &data->iop.cfg;
 
-	new = paddr_to_iopte(__pa(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
+	new = paddr_to_iopte(iommu_virt_to_phys(table), data) | ARM_LPAE_PTE_TYPE_TABLE;
 	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_NS)
 		new |= ARM_LPAE_PTE_NSTABLE;
 
@@ -616,7 +613,7 @@ static void arm_lpae_free_pgtable(struct io_pgtable *iop)
 	struct arm_lpae_io_pgtable *data = io_pgtable_to_data(iop);
 
 	__arm_lpae_free_pgtable(data, data->start_level, data->pgd);
-	kfree(data);
+	iommu_free_data(data);
 }
 
 static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
@@ -930,7 +927,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
 	if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
 		return NULL;
 
-	data = kmalloc_obj(*data);
+	data = iommu_alloc_data(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return NULL;
 
@@ -1053,11 +1050,11 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
 	wmb();
 
 	/* TTBR */
-	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
+	cfg->arm_lpae_s1_cfg.ttbr = iommu_virt_to_phys(data->pgd);
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	iommu_free_data(data);
 	return NULL;
 }
 
@@ -1149,11 +1146,11 @@ arm_64_lpae_alloc_pgtable_s2(struct io_pgtable_cfg *cfg, void *cookie)
 	wmb();
 
 	/* VTTBR */
-	cfg->arm_lpae_s2_cfg.vttbr = virt_to_phys(data->pgd);
+	cfg->arm_lpae_s2_cfg.vttbr = iommu_virt_to_phys(data->pgd);
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	iommu_free_data(data);
 	return NULL;
 }
 
@@ -1223,7 +1220,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	/* Ensure the empty pgd is visible before TRANSTAB can be written */
 	wmb();
 
-	cfg->arm_mali_lpae_cfg.transtab = virt_to_phys(data->pgd) |
+	cfg->arm_mali_lpae_cfg.transtab = iommu_virt_to_phys(data->pgd) |
 					  ARM_MALI_LPAE_TTBR_READ_INNER |
 					  ARM_MALI_LPAE_TTBR_ADRMODE_TABLE;
 	if (cfg->coherent_walk)
@@ -1232,7 +1229,7 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
 	return &data->iop;
 
 out_free_data:
-	kfree(data);
+	iommu_free_data(data);
 	return NULL;
 }
 
diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
index ae9da4f571f6..e1945193ad7f 100644
--- a/drivers/iommu/iommu-pages.h
+++ b/drivers/iommu/iommu-pages.h
@@ -7,6 +7,7 @@
 #ifndef __IOMMU_PAGES_H
 #define __IOMMU_PAGES_H
 
+#include <linux/dma-mapping.h>
 #include <linux/iommu.h>
 
 /**
@@ -145,4 +146,39 @@ void iommu_pages_stop_incoherent_list(struct iommu_pages_list *list,
 void iommu_pages_free_incoherent(void *virt, struct device *dma_dev);
 #endif
 
+static inline void *iommu_alloc_data(size_t size, gfp_t gfp)
+{
+	return kmalloc(size, gfp);
+}
+
+static inline void iommu_free_data(void *p)
+{
+	kfree(p);
+}
+
+static inline phys_addr_t iommu_virt_to_phys(void *virt)
+{
+	return virt_to_phys(virt);
+}
+
+static inline void *iommu_phys_to_virt(phys_addr_t phys)
+{
+	return phys_to_virt(phys);
+}
+
+static inline dma_addr_t iommu_pages_dma_map(struct device *dev, void *virt, size_t size)
+{
+	return dma_map_single(dev, virt, size, DMA_TO_DEVICE);
+}
+
+static inline int iommu_pages_dma_mapping_error(struct device *dev, dma_addr_t dma)
+{
+	return dma_mapping_error(dev, dma);
+}
+
+static inline void iommu_pages_dma_unmap(struct device *dev, dma_addr_t dma, size_t size)
+{
+	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
+}
+
 #endif /* __IOMMU_PAGES_H */
-- 
2.54.0.545.g6539524ca2-goog

