Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891B33556E
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 19:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406920; cv=none; b=QUxYHzMfDeXSA68ORJPVrqTmuDq61vHYR8y0nAqzq3BytxgbjLvxR2dkT9rgfHvO/OagbmjuOoC+s1BrxWxQ+MdVFr0C83iuARdhqEpWPjTmCQ1ePrjF7RnK8s5XP0llBE6Ta4wG4ihSs1D+5ws9tLJjQP1Ds6JE5rmdJdFGL3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406920; c=relaxed/simple;
	bh=JE+FpTuMFs74Daj5saM/f5vFVha96jln+0PajqCIjV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oeH8DYaahAEUYmrgQAySNkPtE7Wy2ft08irLxyLwcKZUryB234fCu2MJXJ93ONrqDlPY5eGiYioKGeN+aMQTqDzBkxEp8Oz91EZpoXUX77wpQ4Obgpu9aSDobZRFGfWPbsL9C7VxrfBa3beTRqJhtmT3uz22QGf4RZ9vPgfoisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BhMQnBUu; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BhMQnBUu"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297f8a2ba9eso124643965ad.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 11:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763406917; x=1764011717; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6rlXZZyuu/JRd1Lu4bCSgxEDDquRXCC5geovFT9dxiQ=;
        b=BhMQnBUu5TIsxUE3N4RgOClh0uNYLlETWEWU5XZLOTkrc+lDufoZDPog8k6BjyYCNv
         JRyD+gDMiDvJwNbWjfZ5iamvuu3UHnHmJancfrMkxIRAuY5vWNdaJgpyDRmbzgbogbBw
         BTNMXaMCz8h9HWAiJET30XcvgZNhDFGDn5beeubJeweqh5FcUksVgystl6EHX07XybSf
         hlXyg7ggTMtA6u+D/TxJn51PO7Z748lMObkhzeF2HW0hDTUc/+rLF79cGPu8XyzeIzbD
         nOfb/rBZ+nEkhEGUee9SgQtm+PcCI+1WKWmqrkcG8DjnUm9cCDW+DXUhe12N3rqSmi2c
         qP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763406917; x=1764011717;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rlXZZyuu/JRd1Lu4bCSgxEDDquRXCC5geovFT9dxiQ=;
        b=IXzAGUUIDrzgT6BJUfPgu/9XttFmEypEO5McDGYMYRfyo2o19CzhNffkIChh2SnXKv
         g4buyMpRjvieBop4z4yM00Y5kPz7rcHhOuH8TUnFW85Mh1FM4tiFro8W6tVVFDnJi9kx
         umbkzFbxGg77ja6IR1ckBXdONXP3T2avFBjVRDXqYI4cP26onJmAWPlfRtcPQW86ZXSo
         22RK3nSywwy1LLjn3e2YSRonvozBXXhv8lsMKZ/B64QgfBy61zAOP4DI7rjn5ypoEw3L
         cq74fG7MqPBqOYRlA8TxYNlC1DxgQK7jgSQWXShgd85JiWtnHqJJuKF8aCaRsCC+b1uf
         yGAg==
X-Gm-Message-State: AOJu0YzMeHmDwBUqBcnZFkPihF9OBZlarQCFFpWCQLZI8XT8DDD3bpOB
	pWkRSYvLaDSb3VXgnnBmMZQzI7r/QEfbjXUnScALomlm7G+TvF4iw+lKXIt2ujwR6In7l+H7QaH
	/C8MKxirmXBXXKE5CoCVCjPqkavzDklD9iiTnxiSUsSmdmeQrHqAzx9xN+VMoQudM4laXBVyzQC
	ZgDRQziiKIaZ5jLZdY5FIRrTU4jByA1Q==
X-Google-Smtp-Source: AGHT+IHLIwXhKvQ4Z4swMmxqmvnfhxZhf5PkZZcwVBjEUUPDVRlhYxcB4PnY7Hfnq5T+xoohNg1oFXZo+g==
X-Received: from pjbcv12.prod.google.com ([2002:a17:90a:fd0c:b0:33b:ca21:e3e7])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:234a:b0:295:9b3a:16b7
 with SMTP id d9443c01a7336-2986a6ae8b2mr146687805ad.4.1763406917407; Mon, 17
 Nov 2025 11:15:17 -0800 (PST)
Date: Mon, 17 Nov 2025 19:14:33 +0000
In-Reply-To: <20251117191433.3360130-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251117191433.3360130-1-praan@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251117191433.3360130-9-praan@google.com>
Subject: [PATCH v4 8/8] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are
used by exposed ops or interrupt handlers. Elide all TLB and CFG
invalidations if the smmu is suspended but not  ATC invalidations.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 10 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 95 +++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +
 3 files changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 8cd8929bbfdf..d2c4c67600cf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -15,6 +15,11 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	struct iommu_hw_info_arm_smmuv3 *info;
 	u32 __iomem *base_idr;
 	unsigned int i;
+	int ret;
+
+	ret = arm_smmu_rpm_get(master->smmu);
+	if (ret < 0)
+		return ERR_PTR(-EIO);
 
 	if (*type != IOMMU_HW_INFO_TYPE_DEFAULT &&
 	    *type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
@@ -24,8 +29,10 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	}
 
 	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info)
+	if (!info) {
+		arm_smmu_rpm_put(master->smmu);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	base_idr = master->smmu->base + ARM_SMMU_IDR0;
 	for (i = 0; i <= 5; i++)
@@ -36,6 +43,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length,
 	*length = sizeof(*info);
 	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
 
+	arm_smmu_rpm_put(master->smmu);
 	return info;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 49a3a46994b1..ec84e6381416 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -110,7 +110,7 @@ static const char * const event_class_str[] = {
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -125,7 +125,7 @@ __maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -1102,7 +1102,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	int sid = master->streams[0].id;
+	int ret;
 
 	if (WARN_ON(!master->stall_enabled))
 		return;
@@ -1122,6 +1124,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
@@ -1129,6 +1135,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Context descriptor manipulation functions */
@@ -2057,6 +2064,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
+	int ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -2065,6 +2073,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2085,6 +2097,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2132,6 +2145,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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
@@ -2143,6 +2161,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2152,13 +2171,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
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
@@ -2191,6 +2221,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 		arm_smmu_cmdq_skip_err(smmu);
 
 	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2281,26 +2312,33 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
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
@@ -2327,6 +2365,11 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
+	/* ATC invalidations shouldn't be elided */
+	ret = arm_smmu_rpm_get(smmu_domain->smmu);
+	if (ret < 0)
+		return ret;
+
 	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, &cmd);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2355,7 +2398,9 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	}
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	ret = arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	arm_smmu_rpm_put(smmu_domain->smmu);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2377,6 +2422,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	} else {
 		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
+
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
@@ -2471,6 +2517,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 	}
+
 	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
 
 	if (smmu_domain->nest_parent) {
@@ -3312,13 +3359,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
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
@@ -3361,6 +3409,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
 	 * descriptor from arm_smmu_share_asid().
 	 */
 	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
+	return 0;
 }
 
 static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
@@ -3371,8 +3420,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_bypass_ste(master->smmu, &ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_BYPASS);
 }
 
 static const struct iommu_domain_ops arm_smmu_identity_ops = {
@@ -3392,9 +3441,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
 
 	arm_smmu_master_clear_vmaster(master);
 	arm_smmu_make_abort_ste(&ste);
-	arm_smmu_attach_dev_ste(domain, dev, &ste,
-				STRTAB_STE_1_S1DSS_TERMINATE);
-	return 0;
+	return arm_smmu_attach_dev_ste(domain, dev, &ste,
+				       STRTAB_STE_1_S1DSS_TERMINATE);
 }
 
 static const struct iommu_domain_ops arm_smmu_blocked_ops = {
@@ -5030,10 +5078,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5041,8 +5098,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
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
index eefa5853033c..8486a2e95b03 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1021,6 +1021,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.52.0.rc1.455.g30608eb744-goog

