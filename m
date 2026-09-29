Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E5138D40C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666401; cv=none; b=mnnzpGYc32NIPqV2W7Jm0P1g7uckRguikbpQbszC4qbeihzT66eXalbgltMCT8x8tsr9hFb4eY3HGd/kVbZjvwBm8s33eGySaA/anCnYZnvzjwybSgCm5QgLBoEkmEfDKI3nFnDxW0f/Xv2VGVMOzSNiEOw28MsxC5HneKnzyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666401; c=relaxed/simple;
	bh=npC1E4TvgSgQqDwNjyN0GqKXsjI4pYIME3rLeZqSk9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DtfNgYv/HXkuKfl1bPlwM0/EnhYqQ5Ed/Uzyc9XoXFbN7H6n5KIndoRe2xKWJFepNxy5l14kYfjSc70YaQOksOcqiXpf55qbsEPn9hPGMZzhDUkTshJAfheA5z/lMKUUsS6rbbGEuhtqEXWqR5cGd1os2uoD16Ov+HqdecfUlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izIXUQ2w; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izIXUQ2w"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e12723dc7aso21200705ad.1
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666399; x=1791271199; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zsEL1hqxDCqTINf2p1QIsw3bFDSMrLfqSmLGHg9MBAA=;
        b=izIXUQ2w7ooKFRZuS+O5L0SOlyk6pBRXLjiAcmfXFxjo25aN2LdgJyBt0IDRyzcNz3
         FPogroOvPfk7SZCygwCRDwnyRlU9iI5bCkvEouONvHTXYVA/46o96YYt+NTCR+Hgt8vn
         /Ii4fGCRn/KaK96PCavoM0ztI5HFb2D6ZaOWyD5by3/tu6I9N6LMLcTLoUsSKnuxsDed
         fJ5vbztlO5x9dda1KmpEUGZW1vqt4POiaSUA1/my0NjSHfqfRFEFIZlRPl3OiFUnav7l
         GTd23ojT0a2twAyz1JSo1LwYm2Zg7Zvxp/Fci7/xymi4yztWFRCGOxMFdYNYaijtK1AR
         KVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666399; x=1791271199;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsEL1hqxDCqTINf2p1QIsw3bFDSMrLfqSmLGHg9MBAA=;
        b=yYzeGy2L5jflkEUW4fMo5zAU3kLYBVdiRG15+3dZGq2nOhBwZgKL3GipnlKzcilx5u
         1GpqAScs3OM/tgW8xl8QPXAf0Csl+5eLZMLSQxF2QI2w+Z2vAxWr535dUGhh9z9DG8QK
         11p7mDXUlLpTigInDuQWL+mJA5E/CUu+PNoQ+NglwUp9B6eTVMpoRrM4PqksDO7DyWf6
         S5/Ar90rkMz2T8OZPTDfQ6r528GZB8e9//4lzyRNsT1Knj1DzsxCOVXQk3EXjvdA9P2T
         eXKHMZUwsT1dzjpPDKoAjB9+N9WHGOVU73rwJy6HoCm2bO1xbQSRMdTeWYuLTOM7zGEg
         vFyA==
X-Gm-Message-State: AFq9FYIw8u9KS9PxO3n8kyzkQ0DOvPNs8h4R5bg6j2Wk/4CnnHO/Sxs+
	T9Am0UetEDnDFuAcpWmeAquERls4f5rkulPIv0gqWtgzmT9Mk5lcv8RIuAPojYwWRidCurAZ6+6
	YB7TDcdC/yzSIZe34LD0sJ3ZazfUMfiD1KGGXzy5JbO9WSh2RKRUCBJMoT9XJe0+hCxlvFdIgCP
	DfKnW+5pnyZgGkcWFEu4BhevyUEcFm3A==
X-Received: from plem4.prod.google.com ([2002:a17:902:e404:b0:2df:ae84:5a1b])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3846:b0:2dd:c100:7cc0
 with SMTP id d9443c01a7336-2df7dd6c369mr122068695ad.60.1790666398420; Tue, 29
 Sep 2026 00:19:58 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:43 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-3-praan@google.com>
Subject: [RFC PATCH v1 2/9] iommu/arm-smmu-v3: Implement KHO preservation for STEs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, 
	Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the foundation for SMMUv3 Live Update (LU) using the Kexec
Handover (KHO) framework. Implement the preserve and preserve_device
hooks to serialize SMMU & preserved masters' state for KHO, along with
the respective unpreserve hooks.

Since .preserve only runs for the first preserved device, preserve the
L2 Stream Tables in .preserve_device, recording their tokens by L1 index.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/Makefile        |   1 +
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 277 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   7 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 +
 4 files changed, 299 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c

diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 2bc52473d960..57db7621972c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-y := arm-smmu-v3.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
+arm_smmu_v3-$(CONFIG_IOMMU_LIVEUPDATE) += arm-smmu-v3-liveupdate.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_KEXEC) += arm-smmu-v3-kexec.o
 arm_smmu_v3-$(CONFIG_CRASH_DUMP) += arm-smmu-v3-kdump.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
new file mode 100644
index 000000000000..515a266ac22e
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -0,0 +1,277 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Google LLC
+ * Author: Pranjal Shrivastava <praan@google.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
+#include <linux/kexec_handover.h>
+#include "arm-smmu-v3.h"
+
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+static u64 *arm_smmu_l2_strtab_states(struct arm_smmu_device *smmu)
+{
+	struct iommu_hw_ser *iommu_ser = iommu_preserved_state(&smmu->iommu);
+
+	return phys_to_virt(iommu_ser->smmuv3.l2_strtab_lu_states_phys);
+}
+
+static bool arm_smmu_l2_strtab_in_use(struct arm_smmu_device *smmu, u32 idx)
+{
+	struct rb_node *node;
+
+	lockdep_assert_held(&smmu->streams_mutex);
+
+	for (node = rb_first(&smmu->streams); node; node = rb_next(node)) {
+		struct arm_smmu_stream *stream =
+			rb_entry(node, struct arm_smmu_stream, node);
+
+		if (stream->master->preserved &&
+		    arm_smmu_strtab_l1_idx(stream->id) == idx)
+			return true;
+	}
+	return false;
+}
+
+/* Unpreserve the L2 tables of the first @num_streams, unless still in use */
+static void arm_smmu_unpreserve_l2_strtabs(struct arm_smmu_master *master,
+					   unsigned int num_streams)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u64 *l2_states;
+	unsigned int i;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB))
+		return;
+
+	l2_states = arm_smmu_l2_strtab_states(smmu);
+
+	mutex_lock(&smmu->streams_mutex);
+	for (i = 0; i < num_streams; i++) {
+		u32 idx = arm_smmu_strtab_l1_idx(master->streams[i].id);
+		dma_addr_t l2_dma;
+
+		if (!l2_states[idx] || arm_smmu_l2_strtab_in_use(smmu, idx))
+			continue;
+
+		l2_dma = le64_to_cpu(cfg->l2.l1tab[idx].l2ptr) & STRTAB_L1_DESC_L2PTR_MASK;
+		dmam_unpreserve_coherent_allocation(smmu->dev, cfg->l2.l2ptrs[idx],
+						    sizeof(struct arm_smmu_strtab_l2),
+						    l2_dma, l2_states[idx]);
+		l2_states[idx] = 0;
+	}
+	mutex_unlock(&smmu->streams_mutex);
+}
+
+/* Preserve the L2 tables holding the STEs of @master */
+static int arm_smmu_preserve_l2_strtabs(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u64 *l2_states;
+	unsigned int i;
+	int ret;
+
+	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB))
+		return 0;
+
+	l2_states = arm_smmu_l2_strtab_states(smmu);
+
+	for (i = 0; i < master->num_streams; i++) {
+		u32 idx = arm_smmu_strtab_l1_idx(master->streams[i].id);
+		dma_addr_t l2_dma;
+
+		if (l2_states[idx])
+			continue;
+
+		l2_dma = le64_to_cpu(cfg->l2.l1tab[idx].l2ptr) & STRTAB_L1_DESC_L2PTR_MASK;
+		ret = dmam_preserve_coherent_allocation(smmu->dev,
+						cfg->l2.l2ptrs[idx],
+						sizeof(struct arm_smmu_strtab_l2),
+						l2_dma, &l2_states[idx]);
+		if (ret) {
+			arm_smmu_unpreserve_l2_strtabs(master, i);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+int arm_smmu_preserve_device(struct device *dev,
+				    struct iommu_device_ser *device_ser)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain_ser *domain_ser;
+	int ret;
+
+	/*
+	 * We'd anyway configure abort STEs for non-preserved masters.
+	 * TODO: Re-visit for identity once IOMMUFD noIOMMU is merged
+	 */
+	if (domain->type == IOMMU_DOMAIN_IDENTITY ||
+	    domain->type == IOMMU_DOMAIN_BLOCKED)
+		return 0;
+
+	if (domain->preserved_state) {
+		domain_ser = domain->preserved_state;
+	} else {
+		/* Fallback for kernel-managed domains */
+		ret = iommu_preserve_domain(domain, &domain_ser);
+		if (ret)
+			return ret;
+	}
+
+	/* Link this master to the preserved IOMMU domain in the ABI */
+	device_ser->domain_iommu_ser.domain_phys = virt_to_phys(domain_ser);
+
+	ret = arm_smmu_preserve_l2_strtabs(master);
+	if (ret)
+		return ret;
+
+	/* Mark the master as preserved to track state across disable */
+	master->preserved = true;
+
+	/*
+	 * TODO: Preserve CD tables for Stage-1 domains here using
+	 * dmam_preserve_allocation_attrs() on master->cd_table.
+	 */
+
+	return 0;
+}
+
+void arm_smmu_unpreserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master->preserved)
+		return;
+
+	master->preserved = false;
+	arm_smmu_unpreserve_l2_strtabs(master, master->num_streams);
+}
+
+static int arm_smmu_preserve_strtab_2lvl(struct arm_smmu_device *smmu,
+					 struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 l1size = cfg->l2.num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	u64 *l2_states;
+	u64 state;
+	int ret;
+
+	/* Preserve the L1 Stream table */
+	ret = dmam_preserve_coherent_allocation(smmu->dev, cfg->l2.l1tab,
+						l1size, cfg->l2.l1_dma, &state);
+	if (ret) {
+		dev_err(smmu->dev, "L1 table preservation failed\n");
+		return ret;
+	}
+	iommu_ser->smmuv3.l1_strtab_lu_state = state;
+
+	/* The L2 tables are preserved along with the masters using them */
+	l2_states = kho_alloc_preserve(sizeof(*l2_states) * cfg->l2.num_l1_ents);
+	if (IS_ERR(l2_states)) {
+		dmam_unpreserve_coherent_allocation(smmu->dev, cfg->l2.l1tab,
+						    l1size, cfg->l2.l1_dma, state);
+		return PTR_ERR(l2_states);
+	}
+
+	iommu_ser->smmuv3.l2_strtab_lu_states_phys = virt_to_phys(l2_states);
+	return 0;
+}
+
+static void arm_smmu_unpreserve_strtab_2lvl(struct arm_smmu_device *smmu,
+					    struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 l1size = cfg->l2.num_l1_ents * sizeof(struct arm_smmu_strtab_l1);
+	u64 *l2_states = phys_to_virt(iommu_ser->smmuv3.l2_strtab_lu_states_phys);
+	u32 i;
+
+	for (i = 0; i < cfg->l2.num_l1_ents; i++) {
+		dma_addr_t l2_dma;
+
+		if (!l2_states[i])
+			continue;
+
+		l2_dma = le64_to_cpu(cfg->l2.l1tab[i].l2ptr) & STRTAB_L1_DESC_L2PTR_MASK;
+		dmam_unpreserve_coherent_allocation(smmu->dev, cfg->l2.l2ptrs[i],
+						    sizeof(struct arm_smmu_strtab_l2),
+						    l2_dma, l2_states[i]);
+	}
+	kho_unpreserve_free(l2_states);
+
+	dmam_unpreserve_coherent_allocation(smmu->dev, cfg->l2.l1tab, l1size,
+					    cfg->l2.l1_dma,
+					    iommu_ser->smmuv3.l1_strtab_lu_state);
+}
+
+static int arm_smmu_preserve_strtab_linear(struct arm_smmu_device *smmu,
+					   struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
+	u64 state;
+	int ret;
+
+	/* STRTAB BASE can't be changed hitlessly, preserve the whole table */
+	ret = dmam_preserve_coherent_allocation(smmu->dev, cfg->linear.table,
+						size, cfg->linear.ste_dma,
+						&state);
+	if (ret)
+		return ret;
+
+	iommu_ser->smmuv3.l1_strtab_lu_state = state;
+	iommu_ser->smmuv3.l2_strtab_lu_states_phys = 0;
+	return 0;
+}
+
+static void arm_smmu_unpreserve_strtab_linear(struct arm_smmu_device *smmu,
+					      struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	u32 size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
+
+	dmam_unpreserve_coherent_allocation(smmu->dev, cfg->linear.table, size,
+					    cfg->linear.ste_dma,
+					    iommu_ser->smmuv3.l1_strtab_lu_state);
+}
+
+int arm_smmu_preserve(struct iommu_device *iommu,
+		      struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_device *smmu =
+		container_of(iommu, struct arm_smmu_device, iommu);
+
+	/* Basic info */
+	iommu_ser->smmuv3.phys_addr = smmu->base_phys;
+	iommu_ser->token = smmu->base_phys;
+	iommu_ser->type = IOMMU_ARM_SMMUV3;
+	iommu_ser->smmuv3.strtab_base_cfg =
+		readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
+
+	/* We always implements 2-level when supported by HW */
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		return arm_smmu_preserve_strtab_2lvl(smmu, iommu_ser);
+	else
+		return arm_smmu_preserve_strtab_linear(smmu, iommu_ser);
+}
+
+void arm_smmu_unpreserve(struct iommu_device *iommu,
+			 struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_device *smmu =
+		container_of(iommu, struct arm_smmu_device, iommu);
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
+		arm_smmu_unpreserve_strtab_2lvl(smmu, iommu_ser);
+	else
+		arm_smmu_unpreserve_strtab_linear(smmu, iommu_ser);
+}
+
+#endif
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 670487613459..ae4a1c98228c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4548,6 +4548,12 @@ static const struct iommu_ops arm_smmu_ops = {
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.get_viommu_size	= arm_smmu_get_viommu_size,
 	.viommu_init		= arm_vsmmu_init,
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+	.preserve		= arm_smmu_preserve,
+	.unpreserve		= arm_smmu_unpreserve,
+	.preserve_device	= arm_smmu_preserve_device,
+	.unpreserve_device	= arm_smmu_unpreserve_device,
+#endif
 	.user_pasid_table	= 1,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
@@ -5807,6 +5813,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 	ioaddr = res->start;
+	smmu->base_phys = ioaddr;
 
 	/*
 	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 69455eced889..7bce5bbe75e5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -952,6 +952,7 @@ struct arm_smmu_device {
 
 	void __iomem			*base;
 	void __iomem			*page1;
+	phys_addr_t			base_phys;
 
 #define ARM_SMMU_FEAT_2_LVL_STRTAB	(1 << 0)
 #define ARM_SMMU_FEAT_2_LVL_CDTAB	(1 << 1)
@@ -1078,6 +1079,8 @@ struct arm_smmu_master {
 	bool				ste_ats_enabled : 1;
 	bool				stall_enabled;
 	bool				ats_always_on;
+	/* Preserved for a KHO Live Update */
+	bool				preserved;
 	unsigned int			ssid_bits;
 	unsigned int			iopf_refcount;
 };
@@ -1196,6 +1199,17 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+int arm_smmu_preserve_device(struct device *dev,
+			     struct iommu_device_ser *device_ser);
+int arm_smmu_preserve(struct iommu_device *iommu,
+		      struct iommu_hw_ser *iommu_ser);
+void arm_smmu_unpreserve_device(struct device *dev,
+				struct iommu_device_ser *device_ser);
+void arm_smmu_unpreserve(struct iommu_device *iommu,
+			 struct iommu_hw_ser *iommu_ser);
+#endif
+
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
 {
 	/* No concurrency with invalidation is possible at this point */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

