Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C8391855
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666420; cv=none; b=g0dvpI54lENqh+u1EFGJ0MgFHsFwhiv7BAlj0zJhx6BYIZD5MYz9QYEIWPsvPNyjruKDBi0R2yn8kmvkZ7HoK6xdDx1+EjSnbkjENw6zC/KM9wRLqa5kOdPNnckNY7Kh+x+M72IRKsv7SPR0HpZurIU6EpP4IccolSssGJ+ZPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666420; c=relaxed/simple;
	bh=u8O2177+KqQdQw8TfYAzTNICrO5G0fO2/HiKOb7evz4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ikcwpXAwofWrPQQAMmipfa5Jgz5rIswOvETzAkrxbbF9q0McUl+GRwNsklUcCyj017zQe6HEiaVekjU38w1dIDilF4v1PnB7gon2bP9dIvNFegrHuXVxaph26aP7clyIIRD4gduDbsxBRgf/WBwu6JkQLGHLhK/8MTHH/MPpD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0qzid6k; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0qzid6k"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d94a158dc8so55646945ad.2
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666415; x=1791271215; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlVYV/o4fm3RCndKRXTcczL0qjVzCkXzkjMu/hurkAc=;
        b=i0qzid6kINEwI7D04KBbbamBhzy86v78uf9HQo7Q6DFiKoDXbRn+R/sjxnCSdX+Y4k
         zWaoKc41AciKbHx8ZO5jKPvL6tnQFvnoP2XAIjI0a7w9LPi57vy+zVcvX2dcq/BMnLcw
         JO/B61MMLXwLcQwdCU0atv+5rX/pTelZ7TWYp+E5Y5KJnHhTo2ZbloGM8EDANOdqyCdx
         jamgBUNQY4QQ9QisI8Xtps2iS7zxxoByw02r3jup6WWxUzN/aHUgYD7BgZ/P61OHzFZx
         lJ9paIxvJv/XqQqZai7U1PFYsir8zqNIF/NBjREJiZo9/SqXPYMt7RtkfWUnRZ817jRn
         BfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666415; x=1791271215;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OlVYV/o4fm3RCndKRXTcczL0qjVzCkXzkjMu/hurkAc=;
        b=xJsZizQNaClGiX2pXU2G/M3rqXeBDmMXmxgAVXBHI+OmamjWNFtzt7ZRYu0izASJKv
         dV5gpSMe3VwsbjUhI9rkEiHXfInv4+fRwCTM9httIWZgerjz3j90luk2I9rxoi5QgRO1
         /OgjioS25kAwPEFnjysvdUtUabGwxums4gzMK0+Of39DHacHKHYdUgxE1A7FTM2OkwTO
         osDFPIBfjuQaXD6IIqTjkwo+OYhmZFz3L5t4m1W7m8HYACgdcyJG8NLLUbEVjLBvj2Dc
         iDjovnqR3tQ3sTyibyGCUQaILKjd3SXcrMjj7aVw1JpAOApK/FTk0AERdq+xMvn9pgrD
         4cEg==
X-Gm-Message-State: AFq9FYI4eQxZawj2cVWc8fhH7LztP+wdH6EEKgSBHNSL61Zgp9inpvUG
	AGLsBTaJ1E/DoajOh/usEGOuphfq/+PM/5k2ZyLECuOK4VcoPfWdRolTKUtp0xqGBuZpKOGxCH3
	H/omYpcZZ2seYYkhfsKDNXxY7bDMckR58isf0Ndxrt44BzfAe5eFDnFDVDh/XJgSqrJapXHVwOp
	Q0+4XzsSMJt4HvDeOzwGmzoiSueb13ww==
X-Received: from plmk4.prod.google.com ([2002:a17:903:1804:b0:2df:af7a:7386])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d4c1:b0:2dd:c100:9438
 with SMTP id d9443c01a7336-2df94c22bdfmr92863685ad.54.1790666415041; Tue, 29
 Sep 2026 00:20:15 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:50 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-10-praan@google.com>
Subject: [RFC PATCH v1 9/9] iommu/arm-smmu-v3: Adopt the Event queue across a
 Live Update
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

The SMMU may record events of the preserved devices across the kexec,
which the incoming kernel loses by resetting the EVTQ.

Preserve the EVTQ memory and leave the EVTQ enabled on shutdown. Only
store its preservation token in the ABI, as the incoming kernel reads the
base, size, PROD and CONS back from the EVTQ registers. Retain EVTQEN
across the reset and wake up the EVTQ thread to handle pending events.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 108 +++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  39 +++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  10 ++
 include/linux/kho/abi/iommu.h                 |   2 +
 4 files changed, 143 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index c0772bcb8d3a..b7cacf48cf8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -403,11 +403,48 @@ static void arm_smmu_unpreserve_strtab_linear(struct arm_smmu_device *smmu,
 					    iommu_ser->smmuv3.l1_strtab_lu_state);
 }
 
+static size_t arm_smmu_evtq_size(struct arm_smmu_device *smmu)
+{
+	return ((1 << smmu->evtq.q.llq.max_n_shift) * EVTQ_ENT_DWORDS) << 3;
+}
+
+/* The EVTQ stays enabled across the kexec */
+static int arm_smmu_preserve_evtq(struct arm_smmu_device *smmu,
+				  struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+
+	iommu_ser->smmuv3.evtq_lu_state = 0;
+	if (!(smmu->features & ARM_SMMU_FEAT_EVTQ))
+		return 0;
+
+	return dmam_preserve_coherent_allocation(smmu->dev, q->base,
+						 arm_smmu_evtq_size(smmu),
+						 q->base_dma,
+						 &iommu_ser->smmuv3.evtq_lu_state);
+}
+
+static void arm_smmu_unpreserve_evtq(struct arm_smmu_device *smmu,
+				     struct iommu_hw_ser *iommu_ser)
+{
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+
+	if (!iommu_ser->smmuv3.evtq_lu_state)
+		return;
+
+	dmam_unpreserve_coherent_allocation(smmu->dev, q->base,
+					    arm_smmu_evtq_size(smmu),
+					    q->base_dma,
+					    iommu_ser->smmuv3.evtq_lu_state);
+	iommu_ser->smmuv3.evtq_lu_state = 0;
+}
+
 int arm_smmu_preserve(struct iommu_device *iommu,
 		      struct iommu_hw_ser *iommu_ser)
 {
 	struct arm_smmu_device *smmu =
 		container_of(iommu, struct arm_smmu_device, iommu);
+	int ret;
 
 	/* Basic info */
 	iommu_ser->smmuv3.phys_addr = smmu->base_phys;
@@ -416,11 +453,20 @@ int arm_smmu_preserve(struct iommu_device *iommu,
 	iommu_ser->smmuv3.strtab_base_cfg =
 		readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
 
+	ret = arm_smmu_preserve_evtq(smmu, iommu_ser);
+	if (ret) {
+		dev_err(smmu->dev, "EVTQ preservation failed\n");
+		return ret;
+	}
+
 	/* We always implements 2-level when supported by HW */
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
-		return arm_smmu_preserve_strtab_2lvl(smmu, iommu_ser);
+		ret = arm_smmu_preserve_strtab_2lvl(smmu, iommu_ser);
 	else
-		return arm_smmu_preserve_strtab_linear(smmu, iommu_ser);
+		ret = arm_smmu_preserve_strtab_linear(smmu, iommu_ser);
+	if (ret)
+		arm_smmu_unpreserve_evtq(smmu, iommu_ser);
+	return ret;
 }
 
 void arm_smmu_unpreserve(struct iommu_device *iommu,
@@ -433,6 +479,7 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 		arm_smmu_unpreserve_strtab_2lvl(smmu, iommu_ser);
 	else
 		arm_smmu_unpreserve_strtab_linear(smmu, iommu_ser);
+	arm_smmu_unpreserve_evtq(smmu, iommu_ser);
 }
 
 static void arm_smmu_liveupdate_clear_l1_std(struct arm_smmu_device *smmu,
@@ -545,12 +592,12 @@ int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu)
 	 * TODO: Quiesce the CMDQV VCMDQs assigned to guests.
 	 */
 
-	/* Disable the queues, leaving SMMUEN set for the preserved masters */
+	/* The incoming kernel resets the CMDQ and PRIQ and adopts the EVTQ */
 	cr0 = readl_relaxed(smmu->base + ARM_SMMU_CR0);
-	cr0 &= ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+	cr0 &= ~(CR0_CMDQEN | CR0_PRIQEN);
 	ret = arm_smmu_write_reg_sync(smmu, cr0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
 	if (ret)
-		dev_err(smmu->dev, "failed to disable queues\n");
+		dev_err(smmu->dev, "failed to disable CMDQ/PRIQ\n");
 	return ret;
 }
 
@@ -696,6 +743,57 @@ int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+/* Adopt the live EVTQ. Returns -ENOENT if it wasn't preserved */
+int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu)
+{
+	u64 base = readq_relaxed(smmu->base + ARM_SMMU_EVTQ_BASE);
+	u32 log2size = FIELD_GET(Q_BASE_LOG2SIZE, base);
+	struct arm_smmu_queue *q = &smmu->evtq.q;
+	struct iommu_hw_ser *iommu_ser;
+
+	iommu_ser = iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+	if (!iommu_ser || !iommu_ser->smmuv3.evtq_lu_state)
+		return -ENOENT;
+
+	if (log2size > q->llq.max_n_shift) {
+		dev_err(smmu->dev, "preserved EVTQ is larger than supported\n");
+		return -EINVAL;
+	}
+	q->llq.max_n_shift = log2size;
+
+	q->base = dmam_restore_coherent_allocation(smmu->dev,
+			arm_smmu_evtq_size(smmu), &q->base_dma, GFP_KERNEL,
+			iommu_ser->smmuv3.evtq_lu_state);
+	if (!q->base)
+		return -ENOMEM;
+
+	if (q->base_dma != (base & Q_BASE_ADDR_MASK)) {
+		dev_err(smmu->dev, "EVTQ_BASE doesn't match the preserved EVTQ\n");
+		return -EINVAL;
+	}
+
+	q->prod_reg = smmu->page1 + ARM_SMMU_EVTQ_PROD;
+	q->cons_reg = smmu->page1 + ARM_SMMU_EVTQ_CONS;
+	q->ent_dwords = EVTQ_ENT_DWORDS;
+	q->q_base = base;
+
+	q->llq.prod = readl_relaxed(q->prod_reg);
+	q->llq.cons = readl_relaxed(q->cons_reg);
+
+	dev_info(smmu->dev, "restored preserved evtq (%u entries)\n",
+		 1 << q->llq.max_n_shift);
+	return 0;
+}
+
+/* A failed EVTQ restore fails the probe, so a preserved EVTQ implies live */
+bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu)
+{
+	struct iommu_hw_ser *iommu_ser;
+
+	iommu_ser = iommu_get_preserved_data(smmu->base_phys, IOMMU_ARM_SMMUV3);
+	return iommu_ser && iommu_ser->smmuv3.evtq_lu_state;
+}
+
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master)
 {
 	struct arm_smmu_device *smmu = master->smmu;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b371ea6b6009..5f9f8bfac668 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4683,10 +4683,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 
 	/* evtq */
 	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
-		ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
-					      ARM_SMMU_EVTQ_PROD,
-					      ARM_SMMU_EVTQ_CONS,
-					      EVTQ_ENT_DWORDS, "evtq");
+		ret = arm_smmu_liveupdate_restore_evtq(smmu);
+		if (ret == -ENOENT)
+			ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q,
+						      smmu->page1,
+						      ARM_SMMU_EVTQ_PROD,
+						      ARM_SMMU_EVTQ_CONS,
+						      EVTQ_ENT_DWORDS, "evtq");
 		if (ret)
 			return ret;
 	}
@@ -5080,9 +5083,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	 * Same for a Live Update restore.
 	 */
 	if (arm_smmu_strtab_is_live(smmu)) {
+		u32 qens = CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN;
+
 		dev_info(smmu->dev, "%s: retaining SMMUEN for in-flight DMA\n",
 			 is_kdump_kernel() ? "kdump" : "live update");
-		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+
+		/* An adopted EVTQ keeps running */
+		if (arm_smmu_liveupdate_evtq_is_live(smmu))
+			qens &= ~CR0_EVTQEN;
+		enables = reg & ~qens;
 		goto reset_queues;
 	}
 
@@ -5173,12 +5182,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 
 	/* Event queue */
 	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
-		writeq_relaxed(smmu->evtq.q.q_base,
-			       smmu->base + ARM_SMMU_EVTQ_BASE);
-		writel_relaxed(smmu->evtq.q.llq.prod,
-			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
-		writel_relaxed(smmu->evtq.q.llq.cons,
-			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+		/* An adopted EVTQ resumes from its live BASE/PROD/CONS */
+		if (!arm_smmu_liveupdate_evtq_is_live(smmu)) {
+			writeq_relaxed(smmu->evtq.q.q_base,
+				       smmu->base + ARM_SMMU_EVTQ_BASE);
+			writel_relaxed(smmu->evtq.q.llq.prod,
+				       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+			writel_relaxed(smmu->evtq.q.llq.cons,
+				       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+		}
 
 		enables |= CR0_EVTQEN;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5228,6 +5240,11 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
+	/* Handle the events recorded across the Live Update */
+	if (arm_smmu_liveupdate_evtq_is_live(smmu) &&
+	    (smmu->combined_irq || smmu->evtq.q.irq))
+		irq_wake_thread(smmu->combined_irq ?: smmu->evtq.q.irq, smmu);
+
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1b33f713f3b7..3a67ba685ef5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1214,6 +1214,8 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master);
+int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu);
+bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
 					struct arm_smmu_domain *smmu_domain);
 #else
@@ -1229,6 +1231,14 @@ static inline int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *
 {
 	return 0;
 }
+static inline int arm_smmu_liveupdate_restore_evtq(struct arm_smmu_device *smmu)
+{
+	return -ENOENT;
+}
+static inline bool arm_smmu_liveupdate_evtq_is_live(struct arm_smmu_device *smmu)
+{
+	return false;
+}
 static inline int
 arm_smmu_liveupdate_attach_restored(struct arm_smmu_master *master,
 				    struct arm_smmu_domain *smmu_domain)
diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 397fdb0449a6..4e8cc32c3136 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -208,12 +208,14 @@ struct iommu_intel_ser {
  * @l2_strtab_lu_states_phys: Physical pointer to an array of u64 LU state tokens
  *                            indexed by L1 index, 0 for L2 tables that aren't
  *                            preserved (0 if linear)
+ * @evtq_lu_state: Live update state token for the Event queue (0 if not preserved)
  */
 struct iommu_smmuv3_hw_ser {
 	u64 phys_addr;
 	u64 strtab_base_cfg;
 	u64 l1_strtab_lu_state;
 	u64 l2_strtab_lu_states_phys;
+	u64 evtq_lu_state;
 } __packed;
 
 /**
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

