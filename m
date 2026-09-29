Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C193E397352
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666415; cv=none; b=XdcqLd/IuoKAzseUXvFG+bSKNZ9TbA/TtsFy6BHaF+wQqxIkb+ymkB5AR6Q4uzwxCJ2/qM767FkHfWi8wU7ozsDkSuBq3Z2DYbyOOZTK6guIxKmDfcCOu5vGZqVLVIMTQ3wHuRq/hXSsPiosnLD7GW9KQtodsCM5i5TpVMZg8e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666415; c=relaxed/simple;
	bh=LrHCQNRkYsQyUEfMAouMbj20Py/alqAV0dPlY0gG7rU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uIZjsOUFHlnDgMhXEd3ab+OV63/FBBLc41idpsaeIrjS1awWJJCQf9/CPqnwxDsQLh9RiK4vW/TUmkMifHmndbGTLllEfxPGF5bAL1PK378HgqzwNLQB8GFZz9MUdPudmubJCJ59/Id7Qfe/iD195C1Rf53L85IK364tV9Avi7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9Eztd4y; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9Eztd4y"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6f80c76e6so32268765ad.3
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666413; x=1791271213; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HbIc6++sPj09TlRBwYu0sM7sUIcTfhDOiHM+40cDviI=;
        b=K9Eztd4yS1/h413XSrcL1OUlCmpOUPSVMei933r1xoorjT6J3xSfIJIpb2F6ejDJzx
         8i0iIV/jGZF/42pOMKz3sNS0TXN7VCXpp9kuS8mF2wENo644GqkLmjqzQyG/TYrPddEZ
         I++ovv/LkVUlByD3ikGbF+be4sCnzUrgewlOy/hl8YDq8z3gopU352Mcm6tO0mgxRqOj
         z5IagYBmPFRv4bJSQOtunLc8mXK3QlEEwiCF9r77EBDi0SzELtBMkJrrQGHsbY6C1XaH
         P0Y80wwWOoABXLDjUSHR+iI/91PILY6lypKDe+ZwVg9XAGxb7AwEXQIQBcU1DLn3pqB/
         HuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666413; x=1791271213;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HbIc6++sPj09TlRBwYu0sM7sUIcTfhDOiHM+40cDviI=;
        b=QO2943DrRiCvPZ2q8aNay5Afb1+S/nOZnBmUOo4Tft0U1fjSwoTzosKxmH7MtW+BUd
         LcW+1bnzw5fpD2RZlAZbFhN1iO4CCEzqCfJbPsLyYmD/dyXE/m6mRBNNp8KcjUoQAl9u
         l+H5UG+wxRDN+zTDZ2oa3GDexcsyJzTE4P+QokvwfPNDLnX1d3i/qdMyOhhhuKDXbe1X
         8FLjH8b/ylXdtzqbec5ZJydEvSPhtJbsMjaRLdid8Mw8zpxvjxG9UvE4aPQk9TtgjoJk
         9k0aNb4SafupH/v71bXsxyAXObVVQH4gEfTFxHgjPGoxb5hKQqYdqSwtIeEhJ+16CtcA
         7T6A==
X-Gm-Message-State: AFq9FYKsKAkuGLNEV6Y5I+BRfTlmmilq/aidsL0bZ7TM/PEW8wMN8Zub
	8a6G6IHvc5OFaFlttWVjIfQsb/6rML0cO3o3HdsAm0ZKpJTJwBa9eEfIrglSfGwAI5ExmaknPKI
	+iKjAs+nya1NlYYCWMbqW9L6Bgqvoms34yywImVwfMQn2nE4a7LC4crr6tBXaor4mFyMb/IauXH
	QD0D3Fwuj79RjO+u6LxQstUX6W0nFApg==
X-Received: from pgte15.prod.google.com ([2002:a65:688f:0:b0:cc7:cb66:8ded])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:2df:8aea:7d99
 with SMTP id d9443c01a7336-2df8aea88aemr111556005ad.59.1790666412570; Tue, 29
 Sep 2026 00:20:12 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:49 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-9-praan@google.com>
Subject: [RFC PATCH v1 8/9] iommu/arm-smmu-v3: Inherit the ASID/VMID of
 restored domains
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

The IOMMU core restores a preserved domain by allocating a new paging
domain around the preserved page table and attaching it to the restored
device. The new domain gets a new ASID/VMID though, while the device is
still doing DMA through the preserved CD/STE.

Similar to the Intel driver reclaiming the preserved Domain ID, record
the ASID/VMID in the attachment_id and let a restored domain inherit the
live ASID/VMID on its first attach. Check the stage, the page table root
and the ID against the live CD/STE, failing the attach on a mismatch.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 115 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   6 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   8 ++
 3 files changed, 129 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index 68652123d0e1..c0772bcb8d3a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -273,6 +273,11 @@ int arm_smmu_preserve_device(struct device *dev,
 	/* Link this master to the preserved IOMMU domain in the ABI */
 	device_ser->domain_iommu_ser.domain_phys = virt_to_phys(domain_ser);
 
+	/* Record the ASID/VMID for the incoming kernel to cross-check */
+	device_ser->domain_iommu_ser.attachment_id =
+		smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ?
+			smmu_domain->cd.asid : smmu_domain->s2_cfg.vmid;
+
 	/* If it's not Stage-1, or the CD table isn't allocated, we're done */
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||
 	    !arm_smmu_cdtab_allocated(&master->cd_table))
@@ -781,4 +786,114 @@ int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master)
 	return ret;
 }
 
+/* Hand over the reserved ASID/VMID, releasing the never programmed one */
+static int arm_smmu_liveupdate_inherit_id(struct arm_smmu_domain *smmu_domain,
+					  u32 id)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	int ret;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (smmu_domain->cd.asid == id)
+			return 0;
+
+		/* Only a reserved entry, which loads as NULL, can be taken */
+		if (xa_load(&smmu->asid_map, id))
+			return -EBUSY;
+		ret = xa_err(xa_store(&smmu->asid_map, id, smmu_domain,
+				      GFP_KERNEL));
+		if (ret)
+			return ret;
+		xa_erase(&smmu->asid_map, smmu_domain->cd.asid);
+		smmu_domain->cd.asid = id;
+		return 0;
+	}
+
+	if (smmu_domain->s2_cfg.vmid == id)
+		return 0;
+
+	/* The vmid_map already holds @id, simply transfer its ownership */
+	ida_free(&smmu->vmid_map, smmu_domain->s2_cfg.vmid);
+	smmu_domain->s2_cfg.vmid = id;
+	return 0;
+}
+
+/*
+ * Inherit the live ASID/VMID of a restored master, after checking that
+ * @smmu_domain matches its live translation. Called before
+ * arm_smmu_attach_prepare() builds the invalidation array.
+ */
+int arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
+					struct arm_smmu_domain *smmu_domain)
+{
+	struct iommu_device_ser *dev_ser = dev_iommu_restored_state(master->dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	struct pt_iommu_armv8_hw_info info;
+	struct arm_smmu_ste *ste;
+	u64 ste0, ttb, live_ttb;
+	u32 id;
+
+	lockdep_assert_held(&arm_smmu_asid_lock);
+
+	if (!dev_ser || !iommu_domain_restored_state(&smmu_domain->domain))
+		return 0;
+
+	ste = arm_smmu_get_step_for_sid(smmu, master->streams[0].id);
+	ste0 = le64_to_cpu(ste->data[0]);
+	if (!(ste0 & STRTAB_STE_0_V))
+		return 0;
+
+	pt_iommu_armv8_hw_info(&smmu_domain->armv8pt, &info);
+
+	switch (FIELD_GET(STRTAB_STE_0_CFG, ste0)) {
+	case STRTAB_STE_0_CFG_S1_TRANS: {
+		struct arm_smmu_cd *cdptr;
+		u64 cd0;
+
+		if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+			goto err_mismatch;
+
+		cdptr = arm_smmu_get_cd_ptr(master, IOMMU_NO_PASID);
+		if (!cdptr)
+			goto err_mismatch;
+
+		cd0 = le64_to_cpu(cdptr->data[0]);
+		if (!(cd0 & CTXDESC_CD_0_V))
+			goto err_mismatch;
+
+		id = FIELD_GET(CTXDESC_CD_0_ASID, cd0);
+		live_ttb = le64_to_cpu(cdptr->data[1]) & CTXDESC_CD_1_TTB0_MASK;
+		ttb = info.ttb & CTXDESC_CD_1_TTB0_MASK;
+		break;
+	}
+	case STRTAB_STE_0_CFG_S2_TRANS:
+		if (smmu_domain->stage != ARM_SMMU_DOMAIN_S2)
+			goto err_mismatch;
+
+		id = FIELD_GET(STRTAB_STE_2_S2VMID, le64_to_cpu(ste->data[2]));
+		live_ttb = le64_to_cpu(ste->data[3]) & STRTAB_STE_3_S2TTB_MASK;
+		ttb = info.ttb & STRTAB_STE_3_S2TTB_MASK;
+		break;
+	default:
+		/* Nothing to inherit, nested STEs aren't restored (yet) */
+		return 0;
+	}
+
+	if (live_ttb != ttb || id != dev_ser->domain_iommu_ser.attachment_id)
+		goto err_mismatch;
+
+	/* A shared restored domain inherits its ID on the first attach */
+	if (!list_empty(&smmu_domain->devices) &&
+	    id != (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 ?
+		   smmu_domain->cd.asid : smmu_domain->s2_cfg.vmid))
+		goto err_mismatch;
+
+	return arm_smmu_liveupdate_inherit_id(smmu_domain, id);
+
+err_mismatch:
+	dev_err(master->dev,
+		"restored domain doesn't match the live translation\n");
+	return -EINVAL;
+}
+
 #endif
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 54c97ebc15b2..b371ea6b6009 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3838,6 +3838,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	 */
 	mutex_lock(&arm_smmu_asid_lock);
 
+	ret = arm_smmu_liveupdate_attach_restored(master, smmu_domain);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		return ret;
+	}
+
 	ret = arm_smmu_attach_prepare(&state, domain);
 	if (ret) {
 		mutex_unlock(&arm_smmu_asid_lock);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 0a88c0ec66ca..1b33f713f3b7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1214,6 +1214,8 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master);
+int arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
+					struct arm_smmu_domain *smmu_domain);
 #else
 static inline int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu)
 {
@@ -1227,6 +1229,12 @@ static inline int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *
 {
 	return 0;
 }
+static inline int
+arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
+				    struct arm_smmu_domain *smmu_domain)
+{
+	return 0;
+}
 #endif
 
 static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

