Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA72BF01B
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750105980; cv=none; b=Mf4k15fVz8cFho5YG35qEroIpZ5oQaeHY2q/MdML31TtFNGhaPasq8jqD8CcJNANRrdA2OuRqnheRpRN1iob46jVXs1HlK1ujCvkZkqrK/6kfHXm6GhT/cdhDtB/Kw0vGhAGoiMVniizktQ55Y8MEViS7frs/YBa7kLxWATika4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750105980; c=relaxed/simple;
	bh=ioBRVA5uuslDnSMQRxWUD3eU378i7yYkxi6Ybn1u9Jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HQtqr1e6So+zLEYDu4XuljaxDr0VnRwuytbZQVqZzTyB0BpNOI9AL+MHu+5j5sOCjg7dzBdt6XESjbwx2tcJtSSl7zFMleqrMLvDX9/GSrGw9++rCcZweDB/waK2pfA/YaISbns9Xttc6F/gtY9TJilyMVeiMFM1wQSV2sLi16Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hn7At2S7; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hn7At2S7"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23507382e64so44263585ad.2
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 13:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750105977; x=1750710777; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6+eSMzpPrV35AuVNVSKSO3KxQq2YAn9RgqoTP8GVlc=;
        b=hn7At2S7ltF/xiKvbtOs28GO7MEEzCun4HHP70+hV51KVsnsjvLRw7Ua4vMMIpgPH6
         Lc33u158iR5P7Z2Uwia316RC1nJiAZDJO0/0KoXk4CzLGoLPkDN7HcC5M1wrhdQXw+4a
         qMDWVqyK54Sr2OVg9LGh5sIJw3ZKzyY9od5Ug2SGdXA5/Mv97441mJoBi/nbS7v4h0ri
         i6uAsf/lD0zRbuGPNyLxE4+WHpTM+ffURBxt1KnYM+1u/cdT5ntebIe30z7OUHpE7bjD
         zRyNAHxbuW1A3aLtCCb5/uwpwhTBjE9LpvtJVLGdg+ewx0OJooKPCGdWpOxYwCyQ5ykS
         dKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750105977; x=1750710777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6+eSMzpPrV35AuVNVSKSO3KxQq2YAn9RgqoTP8GVlc=;
        b=KOPUOVSEjJoMYBeWb8j2SKI3xqQAeWmcI9ibMvd/w53+A2Ol87A9wLNfvHIGKaiSTb
         utgPAJ8qr3deskFTnrxfiHpMu8aVAPYghyoMDwkssvW5PD5XU6kT50griKPflhD8Xh4u
         3JrLfxuB60CS72H5AY6OGBEG3PmWKBNeFq1zAYOuI4e9PZaXl2jnDttuZWkZeoHcLqgc
         96HbvtbGn3VK3letootlE1/FNKhfsP1mIKVkrkxB7kBU2wAFQ8idW6GkCWPw+AwyOl+1
         rTnNGhvIG5kzY5NJ/sT+gwRWioLP9H/jOrWl0stFRyB5TS4cQHkjbCc9FKRWeW48PdH9
         H+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOhKxcyEQ8bUQ6bdsqx9RW9fff04Z5RjV4UwSmmD0V+r4W0GMzmYwXBYoZGLtq9rUhcpOWLw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxU343YyRt8FdNBU/Chdc7/aabsKOew3sYEmHcffisX8lXVL7l0
	cLSOXfNAbOiI/D8GYjh7jXxxNoDpX+sCP/LkS4E9CfvlJg6abRzoBOSOWIPnOu0Ki8aWltQITIm
	J7A==
X-Google-Smtp-Source: AGHT+IGddb1NebSTFJO2Pud8s3txIrPM9JVrZjdseclNkLDn6efCcFAPYAIPyUpjXAH7LnuxERdFsFRxJw==
X-Received: from plkl6.prod.google.com ([2002:a17:902:d346:b0:223:5693:a4e9])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c50:b0:21f:4649:fd49
 with SMTP id d9443c01a7336-2366b3e039fmr149292715ad.49.1750105977602; Mon, 16
 Jun 2025 13:32:57 -0700 (PDT)
Date: Mon, 16 Jun 2025 20:31:49 +0000
In-Reply-To: <20250616203149.2649118-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250616203149.2649118-1-praan@google.com>
X-Mailer: git-send-email 2.50.0.rc2.692.g299adb8693-goog
Message-ID: <20250616203149.2649118-9-praan@google.com>
Subject: [RFC PATCH v3 8/8] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 133 +++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 130 insertions(+), 17 deletions(-)

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
index 80928e5a2d60..87ee2e22aa33 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -110,7 +110,7 @@ static const char * const event_class_str[] = {
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -133,7 +133,7 @@ static int arm_smmu_rpm_get_if_not_suspended(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -1066,7 +1066,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	int sid = master->streams[0].id;
+	int ret;
 
 	if (WARN_ON(!master->stall_enabled))
 		return;
@@ -1086,6 +1088,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
@@ -1093,11 +1099,16 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Context descriptor manipulation functions */
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 {
+	/* No need to invalidate TLBs if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+		return;
+
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
 			CMDQ_OP_TLBI_EL2_ASID : CMDQ_OP_TLBI_NH_ASID,
@@ -1105,6 +1116,7 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	};
 
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	arm_smmu_rpm_put(smmu);
 }
 
 /*
@@ -1311,6 +1323,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	/* No need to invalidate if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+		return;
+
 	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1318,6 +1334,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	}
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_rpm_put(smmu);
 }
 
 static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
@@ -1607,6 +1624,10 @@ struct arm_smmu_ste_writer {
 
 static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
+	/* No need to invalidate if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_not_suspended(writer->master->smmu))
+		return;
+
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
 	struct arm_smmu_cmdq_ent cmd = {
@@ -1618,6 +1639,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 	};
 
 	arm_smmu_cmdq_issue_cmd_with_sync(writer->master->smmu, &cmd);
+	arm_smmu_rpm_put(writer->master->smmu);
 }
 
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
@@ -1642,6 +1664,10 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
 
 	/* It's likely that we'll want to use the new STE soon */
 	if (!(smmu->options & ARM_SMMU_OPT_SKIP_PREFETCH)) {
+		/* No need to prefech if smmu is suspended */
+		if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+			return;
+
 		struct arm_smmu_cmdq_ent
 			prefetch_cmd = { .opcode = CMDQ_OP_PREFETCH_CFG,
 					 .prefetch = {
@@ -1649,6 +1675,7 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
 					 } };
 
 		arm_smmu_cmdq_issue_cmd(smmu, &prefetch_cmd);
+		arm_smmu_rpm_put(smmu);
 	}
 }
 
@@ -2021,6 +2048,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
+	int ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -2029,6 +2057,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2049,6 +2081,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2096,6 +2129,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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
@@ -2107,6 +2145,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2116,13 +2155,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
@@ -2155,6 +2205,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2245,26 +2296,33 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2291,6 +2349,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
+	/* ATC invalidations shouldn't be elided */
+	ret = arm_smmu_rpm_get(smmu_domain->smmu);
+	if (ret < 0)
+		return ret;
+
 	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2319,7 +2382,9 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	arm_smmu_rpm_put(smmu_domain->smmu);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2341,8 +2406,15 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+
+		/* No need to invalidate TLBs if smmu is suspended */
+		if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+			goto atc_inv;
+
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+		arm_smmu_rpm_put(smmu);
 	}
+atc_inv:
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
@@ -2359,6 +2431,10 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 	if (!size)
 		return;
 
+	/* No need to invalidate TLBs if smmu is suspended */
+	if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+		return;
+
 	if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
 		/* Get the leaf page size */
 		tg = __ffs(smmu_domain->domain.pgsize_bitmap);
@@ -2415,18 +2491,24 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
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
+	if (!arm_smmu_rpm_get_if_not_suspended(smmu))
+		goto atc_inv;
+
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
 				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
@@ -2435,6 +2517,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
+
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	if (smmu_domain->nest_parent) {
@@ -2446,6 +2529,8 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
 	}
 
+	arm_smmu_rpm_put(smmu);
+atc_inv:
 	/*
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
@@ -3206,13 +3291,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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
@@ -3255,6 +3341,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
+	return 0;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -3265,8 +3352,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_BYPASS);
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -3286,9 +3373,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_TERMINATE);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_TERMINATE);
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
@@ -4965,10 +5051,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -4976,8 +5071,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
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
 
 static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d4ac6adc6a30..283e72924054 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -999,6 +999,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
-- 
2.50.0.rc2.692.g299adb8693-goog

