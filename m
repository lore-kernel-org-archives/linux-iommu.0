Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237C28641D
	for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 17:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725238; cv=none; b=Ix8za/nuT8UzJjb2BxEzs0Wp78GC4uI3XyBcDH358zEC4YkW+EVKvu2PeHAP/Lz6babvhCBiQ/4tuZ1KobOJGJxNIGxzxW6tdJLtoEgLiXR2fSsKgothNZmPdqsJqURUDE2ApCADo7EyFWWQ6rrBhg1m8TPwko7zGgd26TZ1tDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725238; c=relaxed/simple;
	bh=5CXwO+3dMDU4kX1Nb2jGlQpvWqjZDmaGhbdPDt03cYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LwW7AWejG68z+mzPG28OYJZxcmsWBxO1YKNHZvMmLOdsJvpWAotm2gFhTo3+2wBOWwXA5fiBkvocFH+4/lhTSyfjAd2bQb5FxGRN2qif83+Q+B+J5NBOZXkOLpm8XyeLHxonL05KfaBWUfwF9BV4r2zcBTwPSvNUYKdiJNG8DCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z8hx4Njv; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z8hx4Njv"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b7891afb31so979075f8f.2
        for <iommu@lists.linux.dev>; Mon, 28 Jul 2025 10:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753725233; x=1754330033; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVGSgwZoE434l08ahOgSiVZME26vq9k77nmMG1Lfyxw=;
        b=Z8hx4Njvg4Q230TXt6LO5GXZt8UOl2aE1Juy+MWs9IVNBMzNsVo72xon6LlGzOeYMK
         LvSqJc5GBBfQbfhJT0Z8/1AT+dabwzwHMEnsy4C+2o/xbMz8iEG2OwgLLfO/MnHb0NQE
         nrrFpx8vtsbGVbBNC+eH6dsvyEmeESOqBlDMzBYPq7FdbuYYJM0UXWMcK2JqXfiGtjsF
         PmuFrtOqHEwzztnRWNRC8pE/EeBk95m+um5EsnMGFr1nJr32gnJEQxC66fLuNHLVrH0x
         GqVE9OPtwrJ4gFjXZnuVZlzRJ7jeZHH+FnMob5zQfyVdkfjYKGG1etVbrfWlwIrk2Zxx
         dlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753725233; x=1754330033;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVGSgwZoE434l08ahOgSiVZME26vq9k77nmMG1Lfyxw=;
        b=bRdMRfDe/clXmp0947gCpZ1qLcBbUDcNcfJ66C3LaQwt3R4aNWxGhFrDOmBLHD9IoN
         xTdOnxmcmlH0tbfq6RmICNQ9KuZzEMgsJMVwIRBgpcyfaZ99gRSGpkNsYaHDOK3mXgyu
         uVpVWfGGEXwtd0NRBGAxIIvbzo0Rnad0PuTWmPK/8EyTvu9PofC/P60r9lUDttCmgcXA
         qsj3lL/VRuo9NgMvQ/hHnzH2T9pCB5ydgkQyItvXV42cGCF0VscZRyubPcnab+uFVUlM
         xaL8J255li1C0/w/MqdJ7kEPoBQGGFeiMl8GobD95ZqZlX+5y/k1KPxGtKp3NP2pbHpI
         W8mw==
X-Forwarded-Encrypted: i=1; AJvYcCXtNXDziT8DeWzaTfdcUCy8ArJam5d6A/5N0M32o3YMdFScReluPi0qRf2iWi0X0+3+3UbiTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YypYPs60zc8Jtu412chMiqP4uE8Q1SDWmURQQRX13FTqFm43Rw+
	XNHKMIgeBiOnhkdhU/LXRFYJZrOUSCNFOHUikUboKZkroX8SkpJd6r2yjyj0q0xm+M9LelHMvmP
	EBkQa4K1U692m6A==
X-Google-Smtp-Source: AGHT+IE3DbSna5yWRpg9pDI/w3zNw6uczlG2QD/pr3gxP2WEiggoF+1EAE0R+toZgh10YxWOKOvftEYKiqbgHA==
X-Received: from wrup1.prod.google.com ([2002:a5d:6381:0:b0:3a4:ddbd:cc32])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:40db:b0:3b7:7a4a:dbbf with SMTP id ffacd0b85a97d-3b77a4adc81mr6890156f8f.45.1753725232898;
 Mon, 28 Jul 2025 10:53:52 -0700 (PDT)
Date: Mon, 28 Jul 2025 17:53:11 +0000
In-Reply-To: <20250728175316.3706196-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250728175316.3706196-1-smostafa@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728175316.3706196-25-smostafa@google.com>
Subject: [PATCH v3 24/29] iommu/arm-smmu-v3-kvm: Shadow the CPU stage-2 page table
From: Mostafa Saleh <smostafa@google.com>
To: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, robin.murphy@arm.com, jean-philippe@linaro.org, 
	qperret@google.com, tabba@google.com, jgg@ziepe.ca, mark.rutland@arm.com, 
	praan@google.com, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Based on the callbacks from the hypervisor, update the SMMUv3
Identity mapped page table.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 .../iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c  | 161 +++++++++++++++++-
 .../iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h  |   6 +
 2 files changed, 166 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
index 5e988ffede92..38d81cd6d24a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
@@ -10,6 +10,7 @@
 #include <nvhe/mem_protect.h>
 
 #include "arm_smmu_v3.h"
+#include "../../../io-pgtable-arm.h"
 
 #define ARM_SMMU_POLL_TIMEOUT_US	100000 /* 100ms arbitrary timeout */
 
@@ -48,6 +49,8 @@ struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
 	smmu_wait(_cond);					\
 })
 
+static struct io_pgtable *idmap_pgtable;
+
 static int smmu_write_cr0(struct hyp_arm_smmu_v3_device *smmu, u32 val)
 {
 	writel_relaxed(val, smmu->base + ARM_SMMU_CR0);
@@ -130,6 +133,56 @@ static int smmu_send_cmd(struct hyp_arm_smmu_v3_device *smmu,
 	return smmu_sync_cmd(smmu);
 }
 
+static void __smmu_add_cmd(struct hyp_arm_smmu_v3_device *smmu, void *unused,
+			   struct arm_smmu_cmdq_ent *cmd)
+{
+	WARN_ON(smmu_add_cmd(smmu, cmd));
+}
+
+static int smmu_tlb_inv_range_smmu(struct hyp_arm_smmu_v3_device *smmu,
+				   struct arm_smmu_cmdq_ent *cmd,
+				   unsigned long iova, size_t size, size_t granule)
+{
+	arm_smmu_tlb_inv_build(cmd, iova, size, granule,
+			       idmap_pgtable->cfg.pgsize_bitmap, smmu,
+			       __smmu_add_cmd, NULL);
+	return smmu_sync_cmd(smmu);
+}
+
+static void smmu_tlb_inv_range(unsigned long iova, size_t size, size_t granule,
+			       bool leaf)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_S2_IPA,
+		.tlbi = {
+			.leaf = leaf,
+			.vmid = 0,
+		},
+	};
+	struct hyp_arm_smmu_v3_device *smmu;
+
+	for_each_smmu(smmu)
+		WARN_ON(smmu_tlb_inv_range_smmu(smmu, &cmd, iova, size, granule));
+}
+
+static void smmu_tlb_flush_walk(unsigned long iova, size_t size,
+				size_t granule, void *cookie)
+{
+	smmu_tlb_inv_range(iova, size, granule, false);
+}
+
+static void smmu_tlb_add_page(struct iommu_iotlb_gather *gather,
+			      unsigned long iova, size_t granule,
+			      void *cookie)
+{
+	smmu_tlb_inv_range(iova, granule, granule, true);
+}
+
+static const struct iommu_flush_ops smmu_tlb_ops = {
+	.tlb_flush_walk = smmu_tlb_flush_walk,
+	.tlb_add_page	= smmu_tlb_add_page,
+};
+
 __maybe_unused
 static int smmu_sync_ste(struct hyp_arm_smmu_v3_device *smmu, u32 sid, unsigned long ste)
 {
@@ -377,6 +430,34 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
 	return ret;
 }
 
+static int smmu_init_pgt(void)
+{
+	/* Default values overridden based on SMMUs common features. */
+	struct io_pgtable_cfg cfg = (struct io_pgtable_cfg) {
+		.tlb = &smmu_tlb_ops,
+		.pgsize_bitmap = -1,
+		.ias = 48,
+		.oas = 48,
+		.coherent_walk = true,
+	};
+	int ret = 0;
+	struct hyp_arm_smmu_v3_device *smmu;
+
+	for_each_smmu(smmu) {
+		cfg.ias = min(cfg.ias, smmu->ias);
+		cfg.oas = min(cfg.oas, smmu->oas);
+		cfg.pgsize_bitmap &= smmu->pgsize_bitmap;
+		cfg.coherent_walk &= !!(smmu->features & ARM_SMMU_FEAT_COHERENCY);
+	}
+
+	/* At least PAGE_SIZE must be supported by all SMMUs*/
+	if ((cfg.pgsize_bitmap & PAGE_SIZE) == 0)
+		return -EINVAL;
+
+	idmap_pgtable = kvm_arm_io_pgtable_alloc(&cfg, NULL, ARM_64_LPAE_S2, &ret);
+	return ret;
+}
+
 static int smmu_init(void)
 {
 	int ret;
@@ -398,7 +479,7 @@ static int smmu_init(void)
 			goto out_reclaim_smmu;
 	}
 
-	return 0;
+	return smmu_init_pgt();
 out_reclaim_smmu:
 	while (smmu != kvm_hyp_arm_smmu_v3_smmus)
 		smmu_deinit_device(--smmu);
@@ -406,7 +487,85 @@ static int smmu_init(void)
 	return ret;
 }
 
+static size_t smmu_pgsize_idmap(size_t size, u64 paddr, size_t pgsize_bitmap)
+{
+	size_t pgsizes;
+
+	/* Remove page sizes that are larger than the current size */
+	pgsizes = pgsize_bitmap & GENMASK_ULL(__fls(size), 0);
+
+	/* Remove page sizes that the address is not aligned to. */
+	if (likely(paddr))
+		pgsizes &= GENMASK_ULL(__ffs(paddr), 0);
+
+	WARN_ON(!pgsizes);
+
+	/* Return the larget page size that fits. */
+	return BIT(__fls(pgsizes));
+}
+
+static void smmu_host_stage2_idmap(phys_addr_t start, phys_addr_t end, int prot)
+{
+	size_t size = end - start;
+	size_t pgsize = PAGE_SIZE, pgcount;
+	size_t mapped, unmapped;
+	int ret;
+	struct io_pgtable *pgtable = idmap_pgtable;
+
+	end = min(end, BIT(pgtable->cfg.oas));
+	if (start >= end)
+		return;
+
+	if (prot) {
+		if (!(prot & IOMMU_MMIO))
+			prot |= IOMMU_CACHE;
+
+		while (size) {
+			mapped = 0;
+			/*
+			 * We handle pages size for memory and MMIO differently:
+			 * - memory: Map everything with PAGE_SIZE, that is guaranteed to
+			 *   find memory as we allocated enough pages to cover the entire
+			 *   memory, we do that as io-pgtable-arm doesn't support
+			 *   split_blk_unmap logic any more, so we can't break blocks once
+			 *   mapped to tables.
+			 * - MMIO: Unlike memory, pKVM allocate 1G to for all MMIO, while
+			 *   the MMIO space can be large, as it is assumed to cover the
+			 *   whole IAS that is not memory, we have to use block mappings,
+			 *   that is fine for MMIO as it is never donated at the moment,
+			 *   so we never need to unmap MMIO at the run time triggereing
+			 *   split block logic.
+			 */
+			if (prot & IOMMU_MMIO)
+				pgsize = smmu_pgsize_idmap(size, start, pgtable->cfg.pgsize_bitmap);
+
+			pgcount = size / pgsize;
+			ret = pgtable->ops.map_pages(&pgtable->ops, start, start,
+						     pgsize, pgcount, prot, 0, &mapped);
+			size -= mapped;
+			start += mapped;
+			if (!mapped || ret)
+				return;
+		}
+	} else {
+		/* Shouldn't happen. */
+		WARN_ON(prot & IOMMU_MMIO);
+		while (size) {
+			pgcount = size / pgsize;
+			unmapped = pgtable->ops.unmap_pages(&pgtable->ops, start,
+							    pgsize, pgcount, NULL);
+			size -= unmapped;
+			start += unmapped;
+			if (!unmapped)
+				return;
+		}
+		/* Some memory were not unmapped. */
+		WARN_ON(size);
+	}
+}
+
 /* Shared with the kernel driver in EL1 */
 struct kvm_iommu_ops smmu_ops = {
 	.init				= smmu_init,
+	.host_stage2_idmap		= smmu_host_stage2_idmap,
 };
diff --git a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
index d188537545b1..5c2f121837ad 100644
--- a/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm_smmu_v3.h
@@ -14,6 +14,9 @@
  * @features		SMMUv3 features as defined in arm-smmu-v3-common.h
  * @cmdq		CMDQ queue struct
  * @strtab_cfg		stream table config, strtab_cfg.l2.l2ptrs is not used
+ * @ias			IAS of the SMMUv3
+ * @oas			OAS of the SMMUv3
+ * @pgsize_bitmap	Pages sizes supported by the SMMUv3
  * Other members are filled and used at runtime by the SMMU driver.
  */
 struct hyp_arm_smmu_v3_device {
@@ -23,6 +26,9 @@ struct hyp_arm_smmu_v3_device {
 	unsigned long		features;
 	struct arm_smmu_queue	cmdq;
 	struct arm_smmu_strtab_cfg strtab_cfg;
+	unsigned int            ias;
+	unsigned int            oas;
+	size_t                  pgsize_bitmap;
 };
 
 extern size_t kvm_nvhe_sym(kvm_hyp_arm_smmu_v3_count);
-- 
2.50.1.552.g942d659e1b-goog

