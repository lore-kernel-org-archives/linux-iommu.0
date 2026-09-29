Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347E395ACD
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666403; cv=none; b=X+lvY2uDrBnAwlNuSoXQvdZckRgd5FuYa3IFlnfmnz2c4BKFDxhzVSMdpOfeAP+kVIzM7BgtKuQC8C0TGgtu2HkhPDM8ejiWw5jvG+LmFBvYAFuvc/8hVDi6vqTcqwfArSszcwSKKfX1kxf36niAPb0lGuDlVtbLQqTgZSJg0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666403; c=relaxed/simple;
	bh=RIZ9UwuasHwWHQMi2OJdO1MT55FyVf2R4Ao1niepSXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zy6WYw2sSrCjGp6hp9gdSLuAqtaoy/zEurjfpqnsXPySQiC/KJkWX3j/jEqF2wQeWmBaKxLJIpVkQMIvlN0iKpxAFIlE4nrM6k1pCB7qGQBgn129t8iwB/KiqEdEc74dgBXHCoUATxvdgmJy9w0wtNDBLwoddt8jajzbC1Sx+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3VNYTE5; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3VNYTE5"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-880e099bba5so3965370b3a.1
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666401; x=1791271201; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wIkR6mQzFcjI9veWh5hOSNmg3hYrXJQMUzfvP9wEqgw=;
        b=n3VNYTE5NsjbWqyzFjR/u2JHYsKBq13sA4rFpKxzyIcTClbtKeRdxoPWdM9Gq1jaBU
         iRd82C7hvpkDeMjL0MVK8+2lyKhTrIFp2kD5YiXnObQ6PFx72XOkcJy3m/pvOQ8fojYv
         kGJtJbGLdx3yhVR8M4tiSrCeJaVl5UCT406XDSGpD63/ptwpp/AvATYcLsYisUOb66Dg
         9rdnIUKMeJqXDMSf0c4CR5R6bJQhsJjxuS2lrHteJvTe4iKSrONGFY3gxNb2b1QYuF07
         pBwqHwi4xD9F1wNj2h8gm65z/mYzXEKL7YSl8qZMkOb/EQNGt64ANnv7uP5jh+2kZSpa
         BcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666401; x=1791271201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wIkR6mQzFcjI9veWh5hOSNmg3hYrXJQMUzfvP9wEqgw=;
        b=uiXs4t40g0YTR1VsJ2MGBCpEUYFxxlsqntBSI8MOPqiimAh7jyr/2ODF8Hm1E8zbpa
         7EA40b+nvuUTnDvxKa2O393frzrST2juSSVrfrMxaL02UvPtF6hXK1uiN+UH2Al7K4Lk
         4yY1GrQOA9Am+G5XwiWC4QyjS7XRBcYIReaw8DBipikuFt3YC8+kqFzfKiRFVJdqE+6s
         db2iXuDw+t8/uIxrvgN4663oJleGDwHT5eOw9MQc89YEzUGQg2YP5k0B3I6eRB9hNFLv
         ENetIJIB5S5gHDiaISz2oeCCyE4huuVMrIZr9Cj5Aoqym2OW1Kzem5OBzi5Z1z/84xGB
         UrSQ==
X-Gm-Message-State: AFuF++lu8Gq3SJFhHEI495cQMM4g8p6ddLSaTHOcyxSm2xjhxlcL603u
	N9Q62LQtryYQG3l/IsB1fLCtaU38pMgZruwTkArVlV7GZsvRhz+zQISQXKs0ba/9RwjLOEyzVZd
	aZnjf7Rzn1Yj2MbXjyBEunM84wGwcUD9SzhUIyemomCxePdszdpgRxtesSXrw3JDDgE6DGGBdcJ
	0fLWiHTmrLGvzWkVKBZu7XNOU1V/AwSg==
X-Received: from pfjw16.prod.google.com ([2002:aa7:9a10:0:b0:87c:dd7e:8e68])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:910c:b0:3dd:85a9:55ab
 with SMTP id adf61e73a8af0-3de26db3402mr10807160637.36.1790666400760; Tue, 29
 Sep 2026 00:20:00 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:44 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-4-praan@google.com>
Subject: [RFC PATCH v1 3/9] iommu/arm-smmu-v3: Implement CD Table preservation
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

The core IOMMU Live Update framework preserves page tables pointed by the
respective TTBs but the CD tables are expected to be preserved by the
SMMUv3 driver.

Extend the arm-smmu-v3 driver to preserve CD tables across a KHO with
Live Update enabled. Currently, only support for preserving S1 CD tables
exists since nested CD tables are auto-preserved as they reside in the
guest memory. The current implementation doesn't support preservation at
a PASID granularity due to the similar limitation in IOMMU LU core.

Unpreserve the CD tables in .unpreserve_device.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 173 +++++++++++++++++-
 1 file changed, 164 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index 515a266ac22e..38b9d4e4ab4d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -11,6 +11,114 @@
 #include "arm-smmu-v3.h"
 
 #ifdef CONFIG_IOMMU_LIVEUPDATE
+static int arm_smmu_preserve_cd_table_linear(struct arm_smmu_master *master,
+					     struct iommu_device_ser *device_ser)
+{
+	struct device *dev = master->smmu->dev;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	u32 size = cd_table->linear.num_ents * sizeof(struct arm_smmu_cd);
+	u64 state;
+	int ret;
+
+	ret = dma_preserve_coherent_allocation(dev, cd_table->linear.table,
+					       size, cd_table->cdtab_dma, &state);
+	if (ret)
+		return ret;
+
+	device_ser->smmuv3.l1_cdtab_lu_state = state;
+	device_ser->smmuv3.num_l2_cdtables = 0;
+
+	return 0;
+}
+
+static int arm_smmu_preserve_cd_table_2lvl(struct arm_smmu_master *master,
+					   struct iommu_device_ser *device_ser)
+{
+	struct device *dev = master->smmu->dev;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	u32 l1size = cd_table->l2.num_l1_ents * sizeof(struct arm_smmu_cdtab_l1);
+	u32 num_l2 = 0;
+	u64 *l2_states;
+	u64 state;
+	int ret, i;
+
+	ret = dma_preserve_coherent_allocation(dev, cd_table->l2.l1tab,
+					       l1size, cd_table->cdtab_dma, &state);
+	if (ret)
+		return ret;
+
+	device_ser->smmuv3.l1_cdtab_lu_state = state;
+
+	for (i = 0; i < cd_table->l2.num_l1_ents; i++) {
+		if (cd_table->l2.l2ptrs[i])
+			num_l2++;
+	}
+
+	device_ser->smmuv3.num_l2_cdtables = num_l2;
+	if (!num_l2)
+		return 0;
+
+	l2_states = kho_alloc_preserve(sizeof(*l2_states) * num_l2);
+	if (IS_ERR(l2_states)) {
+		ret = PTR_ERR(l2_states);
+		goto err_unpreserve_cd_l1;
+	}
+
+	device_ser->smmuv3.l2_cdtab_lu_states_phys = virt_to_phys(l2_states);
+	num_l2 = 0;
+
+	for (i = 0; i < cd_table->l2.num_l1_ents; i++) {
+		dma_addr_t l2_dma;
+
+		if (!cd_table->l2.l2ptrs[i])
+			continue;
+
+		l2_dma = le64_to_cpu(cd_table->l2.l1tab[i].l2ptr) & CTXDESC_L1_DESC_L2PTR_MASK;
+		ret = dma_preserve_coherent_allocation(dev, cd_table->l2.l2ptrs[i],
+						       sizeof(struct arm_smmu_cdtab_l2),
+						       l2_dma, &state);
+		if (ret)
+			goto err_free_cd_l2_states;
+
+		l2_states[num_l2++] = state;
+	}
+
+	return 0;
+
+err_free_cd_l2_states:
+	for (i = i - 1; i >= 0; i--) {
+		if (cd_table->l2.l2ptrs[i]) {
+			num_l2--;
+			dma_unpreserve_coherent_allocation(dev, l2_states[num_l2]);
+		}
+	}
+	kho_unpreserve_free(l2_states);
+err_unpreserve_cd_l1:
+	dma_unpreserve_coherent_allocation(dev, device_ser->smmuv3.l1_cdtab_lu_state);
+	return ret;
+}
+
+static void arm_smmu_unpreserve_cd_table(struct arm_smmu_master *master,
+					 struct iommu_device_ser *device_ser)
+{
+	struct device *dev = master->smmu->dev;
+	u32 num_l2 = device_ser->smmuv3.num_l2_cdtables;
+	u64 *l2_states;
+	u32 i;
+
+	if (!device_ser->smmuv3.l1_cdtab_lu_state)
+		return;
+
+	if (num_l2) {
+		l2_states = phys_to_virt(device_ser->smmuv3.l2_cdtab_lu_states_phys);
+		for (i = 0; i < num_l2; i++)
+			dma_unpreserve_coherent_allocation(dev, l2_states[i]);
+		kho_unpreserve_free(l2_states);
+	}
+	dma_unpreserve_coherent_allocation(dev, device_ser->smmuv3.l1_cdtab_lu_state);
+	memset(&device_ser->smmuv3, 0, sizeof(device_ser->smmuv3));
+}
+
 static u64 *arm_smmu_l2_strtab_states(struct arm_smmu_device *smmu)
 {
 	struct iommu_hw_ser *iommu_ser = iommu_preserved_state(&smmu->iommu);
@@ -105,17 +213,53 @@ int arm_smmu_preserve_device(struct device *dev,
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 	struct iommu_domain_ser *domain_ser;
-	int ret;
+	int ret = 0;
+
+	memset(&device_ser->smmuv3, 0, sizeof(device_ser->smmuv3));
 
 	/*
 	 * We'd anyway configure abort STEs for non-preserved masters.
 	 * TODO: Re-visit for identity once IOMMUFD noIOMMU is merged
+	 * TODO: Re-visit for CXL + ATS + Identity CD Table thing
+	 *       Can use cd_table_allocated() helper here?
 	 */
 	if (domain->type == IOMMU_DOMAIN_IDENTITY ||
 	    domain->type == IOMMU_DOMAIN_BLOCKED)
 		return 0;
 
+	/*
+	 * For nested domains we only need to preserve STE.
+	 * The S2 parent domain's page tables are preserved via its own
+	 * iommu_preserve_domain() call during IOMMUFD's HWPT preservation.
+	 * Since the CD Table in this case lives in the guest memory, it is
+	 * naturally preserved by default across KHO when Live Update is enabled.
+	 * Thus, since CD isn't allocated via DMA allocator by the host driver
+	 * we must not attempt preserving CD here.
+	 */
+	if (domain->type == IOMMU_DOMAIN_NESTED)
+		goto skip_cd_preservation;
+
+	smmu_domain = to_smmu_domain(domain);
+
+	/* SVA domains cannot be preserved across KHO */
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_SVA) {
+		dev_err(dev, "SVA domains are NOT preserved across KHO\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * The IOMMU LU Core doesn't support preservation at a PASID
+	 * granularity yet, reject preservation to prevent leaving active
+	 * PASIDs pointing to unpreserved tables.
+	 */
+	if (arm_smmu_ssids_in_use(&master->cd_table)) {
+		dev_err(dev, "Preserving devices with active PASIDS is NOT supported w/ Live Update\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (domain->preserved_state) {
 		domain_ser = domain->preserved_state;
 	} else {
@@ -128,18 +272,28 @@ int arm_smmu_preserve_device(struct device *dev,
 	/* Link this master to the preserved IOMMU domain in the ABI */
 	device_ser->domain_iommu_ser.domain_phys = virt_to_phys(domain_ser);
 
-	ret = arm_smmu_preserve_l2_strtabs(master);
+	/* If it's not Stage-1, or the CD table isn't allocated, we're done */
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||
+	    !arm_smmu_cdtab_allocated(&master->cd_table))
+		goto skip_cd_preservation;
+
+	if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+		ret = arm_smmu_preserve_cd_table_linear(master, device_ser);
+	else if (cd_table->s1fmt == STRTAB_STE_0_S1FMT_64K_L2)
+		ret = arm_smmu_preserve_cd_table_2lvl(master, device_ser);
+
+skip_cd_preservation:
 	if (ret)
 		return ret;
 
-	/* Mark the master as preserved to track state across disable */
-	master->preserved = true;
-
-	/*
-	 * TODO: Preserve CD tables for Stage-1 domains here using
-	 * dmam_preserve_allocation_attrs() on master->cd_table.
-	 */
+	ret = arm_smmu_preserve_l2_strtabs(master);
+	if (ret) {
+		arm_smmu_unpreserve_cd_table(master, device_ser);
+		return ret;
+	}
 
+	/* Mark the master as preserved to track state during disable */
+	master->preserved = true;
 	return 0;
 }
 
@@ -153,6 +307,7 @@ void arm_smmu_unpreserve_device(struct device *dev,
 
 	master->preserved = false;
 	arm_smmu_unpreserve_l2_strtabs(master, master->num_streams);
+	arm_smmu_unpreserve_cd_table(master, device_ser);
 }
 
 static int arm_smmu_preserve_strtab_2lvl(struct arm_smmu_device *smmu,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

