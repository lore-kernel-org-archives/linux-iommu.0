Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BC20C037
	for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 23:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745019334; cv=none; b=J1z29RVFAdNnz45B2iSDwHEFKcvbOb6mv7q1l1ax7Ht02WjviHXtBeC8dof+zL7gSMzLsRxAqRSOOElTYHGlLfgM7qJbAoOwZHqcOy4fLM5jUsgr4hYdnaN8QpO4vO2ILhtIPDUQhSv0DKS1O4uRGPYyX+zLxetqgdvI19IhSzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745019334; c=relaxed/simple;
	bh=Xwx26TPttT7+OdYE87Ps6TcoQi+siFpAHHbZ4e7BF4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OYg2difxMtbplfSNtrLAVSeTPv/b9hOYG/mIjTFlWP5LiMnbqixtxslE+arFusufR3jjT/fIluY8/YZbcqu3IoQDvUVWZDGYGhTm2NjtfswRuEfFFP/4BJBqm+88wX/oPJWBjur3QXgR1hJ1UKLVS+pAPGwjyRB6faNSEf3GfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ls3obb8j; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ls3obb8j"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso2878687b3a.1
        for <iommu@lists.linux.dev>; Fri, 18 Apr 2025 16:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745019331; x=1745624131; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bSAU/j7VKWXHdtAMnzpjIlzQEgD69DEeo/QytVxI8Rk=;
        b=ls3obb8jsKKFxXTNTpauQG+G5MBxIHg2Fl4/IL/qUcVwwGouMHSxZJqqranIPNp10Q
         rJ7dDtU4UW9SgWGvxM6JrTWfBDrAx+1PoGyWez29HECeDyWqKgXJ5HYpVB7ml9sg4ogT
         WdgNfOGWO+33pXnQ3z+bxtd0Ml0l5FaERxQulFPo+S/tTgVf6NINs72/MgTrKRSfY564
         OoNGWcnEoQW6WC3jQLKVomP+3otwdNRi2beA08jT/JFAH3AC/INRgD5aR85pcN0+/y9E
         nGwFSFHh1qu3EkrNahJkoZslKqvBIjbz4txRIFdl+Mg4HZnSZRdrI11h4kko0U0xi2WR
         VBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745019331; x=1745624131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSAU/j7VKWXHdtAMnzpjIlzQEgD69DEeo/QytVxI8Rk=;
        b=nDc2IwudYkM5FC/DDxvvqwk7Fg6HoCsNXlzJtu9/bDHarbxS/S0Fn3u8Vz5Dw00sii
         Yv2Rlde3E+bS37huHE5LwnyH/RnzPUkS5e0d4qWw24q4titahFhQAQFYwUYL+vxoH8O4
         J211rqXoR8Dl6i+bmRR2KtnrojCRaXmBsOK1s4zIOSrvG6ifpuQW/kEMY3/hemP7mqle
         MMNbVZymdGhdY50+4Q+WgxwJRx9IcdkqImn72CMidsrsEtQWVxERNRVTZTtALgQzx3Rv
         NnnNQMNmUTQf6NF7dPR4Art3uzP9onIxj1bDZJ7REwS2pcNjCRiMLDrhRxDL9+DBzl8V
         QcTA==
X-Forwarded-Encrypted: i=1; AJvYcCXknSrrjwCKzcyeLU83lyM3Hwv5le63+zZInELTt3Db6rzT7HvrFWG/cenYiycuvhCMKl9PeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlTg3DtYFyFNjPID0IparsehPaP+oPXIjlEsY6Y4Qbwh7+wTzE
	+qpbt2Wb9y3/WkL2BNpS5B8SHi0eYkE6LBw2VMrPxcu8s3AM0XLw/Q4r/N6ZA5yrSEx2SIBNNg=
	=
X-Google-Smtp-Source: AGHT+IHQDgV2BY2gYAmG8s1Uum6UOykt0eMDcYhuLyJcYYrouHH6R+K7vZtrcOCv2BWIjEOiYkNrp96yRQ==
X-Received: from pfvx5.prod.google.com ([2002:a05:6a00:2705:b0:73c:6d5:ce4c])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3990:b0:730:99cb:7c2f
 with SMTP id d2e1a72fcca58-73dc148fabcmr5401308b3a.6.1745019331548; Fri, 18
 Apr 2025 16:35:31 -0700 (PDT)
Date: Fri, 18 Apr 2025 23:34:09 +0000
In-Reply-To: <20250418233409.3926715-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250418233409.3926715-1-praan@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418233409.3926715-11-praan@google.com>
Subject: [RFC PATCH v2 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are
used by exposed ops or interrupt handlers. Elide all TLB and CFG
invalidations if the smmu is suspended but not  ATC invalidations.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  11 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 135 +++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index e4fd8d522af8..817d384ae8e4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -13,10 +13,17 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
+	int ret;
+
+	ret = arm_smmu_rpm_get(master->smmu);
+	if (ret < 0)
+		return ERR_PTR(-EIO);
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
+	if (!info) {
+		arm_smmu_rpm_put(master->smmu);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	base_idr = master->smmu->base + ARM_SMMU_IDR0;
 	for (i = 0; i <= 5; i++)
@@ -27,6 +34,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
+	arm_smmu_rpm_put(master->smmu);
 	return info;
 }
 
@@ -139,6 +147,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
 		.old_domain = iommu_get_domain_for_dev(dev),
 		.ssid = IOMMU_NO_PASID,
 	};
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ste ste;
 	int ret;
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d78c6ab24eb2..9319df173cba 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -110,7 +110,7 @@ static const char * const event_class_str[] = {
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -130,10 +130,10 @@ static int arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
 	if (pm_runtime_enabled(smmu->dev))
 		return pm_runtime_get_if_in_use(smmu->dev);
 
-	return 0;
+	return 1;
 }
 
-static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -1072,7 +1072,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	int sid = master->streams[0].id;
+	int ret;
 
 	if (WARN_ON(!master->stall_enabled))
 		return;
@@ -1092,6 +1094,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
@@ -1099,11 +1105,16 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
+	/* No need to invalidate TLBs if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		return;
+
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
 			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
@@ -1111,6 +1122,7 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	};
 
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	arm_smmu_rpm_put(smmu);
 }
 
 /*
@@ -1317,6 +1329,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	/* No need to invalidate if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		return;
+
 	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1324,6 +1340,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	}
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_rpm_put(smmu);
 }
 
 static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
@@ -1613,6 +1630,10 @@ struct arm_smmu_ste_writer {
 
 static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
+	/* No need to invalidate if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_active(writer->master->smmu))
+		return;
+
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
 	struct arm_smmu_cmdq_ent cmd = {
@@ -1624,6 +1645,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 	};
 
 	arm_smmu_cmdq_issue_cmd_with_sync(writer->master->smmu, &cmd);
+	arm_smmu_rpm_put(writer->master->smmu);
 }
 
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
@@ -1648,6 +1670,10 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
 
 	/* It's likely that we'll want to use the new STE soon */
 	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
+		/* No need to prefech if smmu is suspended */
+		if (!arm_smmu_rpm_get_if_active(smmu))
+			return;
+
 		struct arm_smmu_cmdq_ent
 			prefetch_cmd = { .opcode = CMDQ_OP_PREFETCH_CFG,
 					 .prefetch = {
@@ -1655,6 +1681,7 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
 					 } };
 
 		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+		arm_smmu_rpm_put(smmu);
 	}
 }
 
@@ -2027,6 +2054,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
+	int ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -2035,6 +2063,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2055,6 +2087,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2102,6 +2135,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 	struct arm_smmu_queue *q = &smmu->priq.q;
 	struct arm_smmu_ll_queue *llq = &q->llq;
 	u64 evt[PRIQ_ENT_DWORDS];
+	int ret;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
 
 	do {
 		while (!queue_remove_raw(q, evt))
@@ -2113,6 +2151,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2122,13 +2161,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	u32 gerror, gerrorn, active;
 	struct arm_smmu_device *smmu = dev;
+	int ret;
+
+	if (pm_runtime_enabled(smmu->dev)) {
+		ret = pm_runtime_get_if_active(smmu->dev);
+		if (ret == 0) {
+			dev_err(smmu->dev, "Ignoring gerror interrupt because device isn't rpm active\n");
+			return IRQ_NONE;
+		}
+	}
 
 	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
 	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
 
 	active = gerror ^ gerrorn;
-	if (!(active & GERROR_ERR_MASK))
+	if (!(active & GERROR_ERR_MASK)) {
+		arm_smmu_rpm_put(smmu);
 		return IRQ_NONE; /* No errors pending */
+	}
 
 	dev_warn(smmu->dev,
 		 "unexpected global error reported (0x%08x), this could be serious\n",
@@ -2161,6 +2211,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2251,26 +2302,33 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 				   ioasid_t ssid)
 {
-	int i;
+	int i, ret;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
+	/* ATC invalidations shouldn't be elided */
+	ret = arm_smmu_rpm_get(master->smmu);
+	if (ret < 0)
+		return ret;
+
 	arm_smmu_cmdq_batch_init(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
 	}
 
-	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
+	arm_smmu_rpm_put(master->smmu);
+	return ret;
 }
 
 int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 			    unsigned long iova, size_t size)
 {
 	struct arm_smmu_master_domain *master_domain;
-	int i;
+	int i, ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode = CMDQ_OP_ATC_INV,
@@ -2297,6 +2355,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
+	/* ATC invalidations shouldn't be elided */
+	ret = arm_smmu_rpm_get(smmu_domain->smmu);
+	if (ret < 0)
+		return ret;
+
 	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2325,7 +2388,9 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	arm_smmu_rpm_put(smmu_domain->smmu);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2347,8 +2412,15 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+
+		/* No need to invalidate TLBs if smmu is suspended */
+		if (!arm_smmu_rpm_get_if_active(smmu))
+			goto atc_inv;
+
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		arm_smmu_rpm_put(smmu);
 	}
+atc_inv:
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
@@ -2365,6 +2437,10 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	if (!size)
 		return;
 
+	/* No need to invalidate TLBs if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		return;
+
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
@@ -2421,18 +2497,24 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 		iova += inv_range;
 	}
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_rpm_put(smmu);
 }
 
 static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 					  size_t granule, bool leaf,
 					  struct arm_smmu_domain *smmu_domain)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.tlbi = {
 			.leaf	= leaf,
 		},
 	};
 
+	/* No need to invalidate TLBs if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		goto atc_inv;
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
@@ -2441,6 +2523,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
+
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	if (smmu_domain->nest_parent) {
@@ -2452,6 +2535,8 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
 	}
 
+	arm_smmu_rpm_put(smmu);
+atc_inv:
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
@@ -3278,13 +3363,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
 		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
 			sid_domain->ops->attach_dev(sid_domain, dev);
 	}
+
 	return 0;
 }
 
-static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
-				    struct device *dev,
-				    struct arm_smmu_ste *ste,
-				    unsigned int s1dss)
+static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
+				   struct device *dev,
+				   struct arm_smmu_ste *ste,
+				   unsigned int s1dss)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct arm_smmu_attach_state state = {
@@ -3327,6 +3413,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
+	return 0;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -3337,8 +3424,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_BYPASS);
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -3358,9 +3445,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_TERMINATE);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_TERMINATE);
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
@@ -5037,10 +5123,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	int ret;
 
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret <  0)
+		goto free_iopf;
+
 	arm_smmu_device_disable(smmu);
+	arm_smmu_rpm_put(smmu);
+
+free_iopf:
 	iopf_queue_free(smmu->evtq.iopf);
 	ida_destroy(&smmu->vmid_map);
 }
@@ -5048,8 +5143,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
 
 	arm_smmu_device_disable(smmu);
+	arm_smmu_rpm_put(smmu);
 }
 
 static bool arm_smmu_suspend_is_safe(struct arm_smmu_device *smmu)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 28fddc07ab49..7be08347b012 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1009,6 +1009,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.49.0.805.g082f7c87e0-goog

