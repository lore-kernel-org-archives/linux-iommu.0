Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CC038D40C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666409; cv=none; b=i7i9khUa6VVYk+pJZG9Jd0s7HEA16ETmMRdaPs4NVMy34BD/c2ltkhEMi4RhpE4idnmzYo0/ArNEIvP3BT6PjmlCHju8fzO+kIm0AnCcSFOk8IbU2Q10nvgulRosB7pyDexk4FbdCJhZ6eVAZF69bHyWmmVaBQmmSKruPwPtRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666409; c=relaxed/simple;
	bh=puDsKJYYeKqmtBFoywEhHyIb1i+AAMtA+OoPNOmxTyY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pHpBznduTbOx/fSjx8kJguEGz9inuhVbZiqqCfZab9LdIFYMs0e6nnzFYsOBFKfdqIIho2UUzVxV9kGq/c8v4BOeyGMSwiB/Hepphi13y/GCkBdbbSVVPkUzZX4Gg9yXgjOy5/nsLPeRqGDSuYaD18AfUhx2+MYkiova1HXbgGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqKuTQx/; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqKuTQx/"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc79892d934so2927364a12.0
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666406; x=1791271206; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UAHt9yPr8xErw2vTC+nZUeTF0cYtYEiZZIIkDpWP9/4=;
        b=NqKuTQx/JiP7iZXiFM/nHZ6RS9sJXbMwg7nqZYZACTiNbVlScBc7wvYjIvfNoXgqtf
         7tmIlAxoaS7TG55sodMLwbLXGbddNKjOIYjM4tybh0PO4WVFDak/ApbsmsnXcIDi5nWq
         pmRr4n37Gtz3e4luvILBpK3lP5+bvqHMsviRf35+a8lgWIEylgtFqTCKRdCkV5UrpJxI
         on2mCF7G52MmxqKPamUGIqNotUqqpRurXJId1EAGfrzTawyjEd5DKICF+npIyPlzU13B
         Ol0nChoBPVBwmhK9XKsJdJrORU2+VcFtqzU0Sx5vekGVESZQBxpLnOnbaF9SlUMEPRtd
         V1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666406; x=1791271206;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UAHt9yPr8xErw2vTC+nZUeTF0cYtYEiZZIIkDpWP9/4=;
        b=Umn0i73gyjsK1s+jk4a2M+Zbn79WJAGeuflJRlUn2AxtEbiOXPF1Vil3F18eDSrPqU
         GewGVQZM75aYA1nVhY7UG8fPKkD5/x9kdqbEBTn3Iwi+HUj7c80KONwyyUBTsSnLhksc
         e4C/WiFV5Z61q/Hsup+RJrikFeAXmjzdrkl7rrTE8IHh006QyZ8fEpvJdhVAubkM4FAJ
         JZaNktVhVrzlQBJh379EVWTViI/1CYo1FJhSljTIrs+haI2OoPGvo+f3/uQ4dqHhKN9S
         64FQIBTQ3dQJWXE9JpI3Y9n7SXpHDnNM67GNd4H93cpHBvJrznGMX4kA8URBrAZMfHbV
         FAug==
X-Gm-Message-State: AFuF++lEXHG/Ms/OXvtLUpYMMuzeLyB7tCJS5pmE/tsciU6AFrfW3Xkx
	sPxi9kYfuBrTw23gKW8tilzy71VmB2/dk3HlzEuKrN/UhCibGpfc8NBk7hqOfXQDIHvTGhgJjyp
	LWbqUnjs7KKQ5kKxZTPpr3TOtAwaWaOG6uHug4+HQrgCLNniQfwBZqexPqhXSqB2IRIHarhJidW
	5Ye5Wa9+Ztu39VBMD8AlRQdkwoSjiVXQ==
X-Received: from pfbmt5.prod.google.com ([2002:a05:6a00:6e65:b0:886:13f0:1b78])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914f:b0:3de:7701:d221
 with SMTP id adf61e73a8af0-3de7701d806mr3057497637.42.1790666405416; Tue, 29
 Sep 2026 00:20:05 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:46 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-6-praan@google.com>
Subject: [RFC PATCH v1 5/9] iommu/arm-smmu-v3: Implement Live Update CD Table restoration
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

During the boot phase of a Kexec Handover (KHO), the incoming kernel
must restore Context Descriptor (CD) tables for preserved devices to
maintain Stage-1 translation contexts. Add a check within
arm_smmu_alloc_cd_tables() to implement the CD table restoration.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 44 ++++++---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 90 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  9 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 4 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 8c53cd757007..7dc499a7bef4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -222,6 +222,33 @@ int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 	return 0;
 }
 
+/**
+ * arm_smmu_kexec_check_cdtab_l1_desc() - Check one CD table L1 descriptor
+ * @l1_desc: L1 descriptor value from the previous kernel's CD table
+ * @l2_base: pointer to return the L2 CD table's physical address
+ *
+ * Return: 1 if the descriptor is unused, 0 if it is valid with @l2_base set, or
+ * -EINVAL if it is malformed
+ */
+int arm_smmu_kexec_check_cdtab_l1_desc(u64 l1_desc, phys_addr_t *l2_base)
+{
+	phys_addr_t base = l1_desc & CTXDESC_L1_DESC_L2PTR_MASK;
+
+	if (!(l1_desc & CTXDESC_L1_DESC_V))
+		return 1;
+
+	/*
+	 * A valid descriptor never carries a null pointer. Also, an L2 table is
+	 * always 64KB-aligned, so an unaligned pointer would make this kernel
+	 * read a different table.
+	 */
+	if (!base || !IS_ALIGNED(base, sizeof(struct arm_smmu_cdtab_l2)))
+		return -EINVAL;
+
+	*l2_base = base;
+	return 0;
+}
+
 static int arm_smmu_kexec_resv_asid(struct arm_smmu_device *smmu, u32 asid)
 {
 	/* A valid CD never has ASID 0; both kernels share the same HW limit */
@@ -310,21 +337,16 @@ static int arm_smmu_kexec_resv_s1_asids(struct arm_smmu_device *smmu, u64 ste0)
 	/* Aliased L2 tables cannot extend the walk; they only repeat a scan */
 	for (i = 0; i < num_l1_ents; i++) {
 		u64 l1_desc = le64_to_cpu(l1tab[i].l2ptr);
-		phys_addr_t l2_base = l1_desc & CTXDESC_L1_DESC_L2PTR_MASK;
 		struct arm_smmu_cdtab_l2 *l2;
+		phys_addr_t l2_base;
 
-		if (!(l1_desc & CTXDESC_L1_DESC_V))
+		ret = arm_smmu_kexec_check_cdtab_l1_desc(l1_desc, &l2_base);
+		if (ret == 1) {
+			ret = 0;
 			continue;
-
-		/*
-		 * A valid descriptor never carries a null pointer. Also, an L2
-		 * table is always 64KB-aligned, so an unaligned pointer would
-		 * make this kernel read a different table.
-		 */
-		if (!l2_base || !IS_ALIGNED(l2_base, sizeof(*l2))) {
-			ret = -EINVAL;
-			break;
 		}
+		if (ret)
+			break;
 
 		l2 = memremap(l2_base, num_cds * sizeof(*l2->cds), MEMREMAP_WB);
 		if (!l2) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index 4998234e1e7a..981b091a47a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -571,4 +571,94 @@ int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
+	struct iommu_device_ser *dev_ser = dev_iommu_restored_state(master->dev);
+	u32 max_contexts, s1fmt, num_l2, restored = 0, i;
+	struct arm_smmu_ste *ste;
+	u64 *l2_states = NULL;
+	phys_addr_t cdtab;
+	u64 ste0;
+	int ret;
+
+	if (!dev_ser)
+		return 0;
+
+	/* Only an S1 STE has a CD table behind it */
+	ste = arm_smmu_get_step_for_sid(smmu, master->streams[0].id);
+	ste0 = le64_to_cpu(ste->data[0]);
+	if (!(ste0 & STRTAB_STE_0_V) ||
+	    FIELD_GET(STRTAB_STE_0_CFG, ste0) != STRTAB_STE_0_CFG_S1_TRANS)
+		return 0;
+
+	ret = arm_smmu_kexec_check_ste_cdtab(smmu, ste0, &cdtab, &s1fmt,
+					     &max_contexts);
+	if (ret)
+		return ret;
+
+	cd_table->s1cdmax = ilog2(max_contexts);
+	cd_table->s1fmt = s1fmt;
+
+	if (s1fmt == STRTAB_STE_0_S1FMT_LINEAR) {
+		cd_table->linear.num_ents = max_contexts;
+		cd_table->linear.table = dma_restore_coherent_allocation(smmu->dev,
+				max_contexts * sizeof(*cd_table->linear.table),
+				&cd_table->cdtab_dma, GFP_KERNEL,
+				dev_ser->smmuv3.l1_cdtab_lu_state);
+		return cd_table->linear.table ? 0 : -ENOMEM;
+	}
+
+	cd_table->l2.num_l1_ents = DIV_ROUND_UP(max_contexts,
+						CTXDESC_L2_ENTRIES);
+	cd_table->l2.l1tab = dma_restore_coherent_allocation(smmu->dev,
+			cd_table->l2.num_l1_ents * sizeof(*cd_table->l2.l1tab),
+			&cd_table->cdtab_dma, GFP_KERNEL,
+			dev_ser->smmuv3.l1_cdtab_lu_state);
+	if (!cd_table->l2.l1tab)
+		return -ENOMEM;
+
+	cd_table->l2.l2ptrs = kcalloc(cd_table->l2.num_l1_ents,
+				      sizeof(*cd_table->l2.l2ptrs), GFP_KERNEL);
+	if (!cd_table->l2.l2ptrs)
+		return -ENOMEM;
+
+	num_l2 = dev_ser->smmuv3.num_l2_cdtables;
+	if (num_l2)
+		l2_states = phys_to_virt(dev_ser->smmuv3.l2_cdtab_lu_states_phys);
+
+	for (i = 0; i < cd_table->l2.num_l1_ents; i++) {
+		u64 l1_desc = le64_to_cpu(cd_table->l2.l1tab[i].l2ptr);
+		phys_addr_t l2_base;
+		dma_addr_t l2_dma;
+
+		ret = arm_smmu_kexec_check_cdtab_l1_desc(l1_desc, &l2_base);
+		if (ret == 1)
+			continue;
+		if (ret)
+			goto out_free_states;
+
+		if (restored >= num_l2) {
+			ret = -EINVAL;
+			goto out_free_states;
+		}
+
+		l2_dma = l2_base;
+		cd_table->l2.l2ptrs[i] = dma_restore_coherent_allocation(smmu->dev,
+				sizeof(*cd_table->l2.l2ptrs[i]), &l2_dma,
+				GFP_KERNEL, l2_states[restored++]);
+		if (!cd_table->l2.l2ptrs[i]) {
+			ret = -ENOMEM;
+			goto out_free_states;
+		}
+	}
+	ret = 0;
+
+out_free_states:
+	if (l2_states)
+		kho_restore_free(l2_states);
+	return ret;
+}
+
 #endif
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c8bcf901f1c8..b13ed06a368f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/generic_pt/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/iopoll.h>
 #include <linux/jump_label.h>
 
@@ -1723,6 +1724,14 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
+	if (dev_iommu_restored_state(master->dev)) {
+		ret = arm_smmu_liveupdate_restore_cd_tables(master);
+		if (ret)
+			return ret;
+		if (arm_smmu_cdtab_allocated(cd_table))
+			return 0;
+	}
+
 	cd_table->s1cdmax = master->ssid_bits;
 
 	/*
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6b75f48671f8..453ad34ab0fa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1209,11 +1209,16 @@ void arm_smmu_unpreserve_device(struct device *dev,
 void arm_smmu_unpreserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
 int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu);
+int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master);
 #else
 static inline int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu)
 {
 	return -ENOENT;
 }
+static inline int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master)
+{
+	return 0;
+}
 #endif
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
@@ -1369,6 +1374,7 @@ int arm_smmu_kexec_check_strtab_l1_desc(struct arm_smmu_device *smmu,
 int arm_smmu_kexec_check_ste_cdtab(struct arm_smmu_device *smmu, u64 ste0,
 				   phys_addr_t *cdtab, u32 *s1fmt,
 				   u32 *max_contexts);
+int arm_smmu_kexec_check_cdtab_l1_desc(u64 l1_desc, phys_addr_t *l2_base);
 int arm_smmu_kexec_scan_and_resv_ids(struct arm_smmu_device *smmu);
 void arm_smmu_kexec_unresv_ids(struct arm_smmu_device *smmu);
 #endif /* CONFIG_ARM_SMMU_V3_KEXEC */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

