Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D133101C0
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776196056; cv=none; b=cOqmmcwe6+f8+rg7sTZhRmUuyACkzEKlVZCFyetElHOtB0L9NWxEwC4oXIMNyERpSj7oQ1bh2V1xJbJi9Lnw0wyRs3CEgKvqPucWrKH5ovs1SlD59cD62Prmxr2MDmHAYiRP3ESaGc9WI9ZLn14ouYAR/6XLofodtGhxmC/hOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776196056; c=relaxed/simple;
	bh=R1OMFAJ2gBFTsrR5B5onz5lhkBpdok6/VZ/NhP398tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qn38GrIMLIVBdu5VkZJ96zSXY8S3Hh5ockB1agzIXdGSI0WhisQX+BINkEibEwjkujf9u7NGbnzZP81fd2R3KNEn+mBYc9tSxL524H3w79E4/MxIdTByso0W7v2wSLy1lvf6yXNviQ+7uokHPC0W/8+8gampEIdBLK/pR18oqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BDk6s0uA; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BDk6s0uA"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so5468594b3a.0
        for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 12:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776196054; x=1776800854; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=He2qEgHR7B2IC2Wa1UcL9y1NM99O0Pz6imA1qwpHhj8=;
        b=BDk6s0uAh2AJC7VtzT5nh+vSdyHCwVHlxwBosn6pl6XnoPHkDiTfQbZwxSzfgww7Qn
         BKwHYzxU4YpqoyM0MM9jn1L0xqYWunT4roAXDEeJjpuNQQpgghQ4fAcgHuyyxsbxoVBQ
         C91H7Mkuy4z/nPIaI0Io8RIB1e4gSlB6wBtO+VhL3jAbs37OrptKsk1NTtVbo3zNwBmZ
         tamfpMPURsqH+RKUaS2qwXCDdP+YXptX8Tt+BgsFADyqZ2ETvI2EwlLzuJOKQaoVXNmk
         9jlhSWoMB0x0JAQDPZoHaSdqkgwPvPkZQDJqnmHPaGtzitRRxnp0Wpgtum2EBQQdGe1p
         YVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196054; x=1776800854;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=He2qEgHR7B2IC2Wa1UcL9y1NM99O0Pz6imA1qwpHhj8=;
        b=ga2Dok2uLKL2gF9UUy05gMH86UzQYR2JBqTyJ6aZFWKdLR5906XlTyNeElToEJAo7Q
         rq4tx0NYPzg3d5bC1m37syMbHxFpub/uZz/Ap3N2sfZ+l2T4j+3qmcU7SeB9peMeMncp
         1fv7ZdFRKxzpJZ+KfojHVckJIcLj54xcrLxM+1zOuutOoK/3lEFpfzP5cG7LDtzfSYvz
         Ck+5GCMK6oZE89i8TC+FgeRkiLHOcFr0U2ZFwTTR+8XCedS4ETdevN4rbXJ92FgZgG7a
         ezaoiXghSiDSYPCr/INKRvv6orYfxY+ogpLrh48XyCFKEM1UXxB/e1HU1Q5gc12/uf5M
         JbKg==
X-Gm-Message-State: AOJu0YwPMMKZJnEqeH3l64AxigEBSx1bm7bSogPD2NrsRpAGuEEdBMWU
	yEoQNHmmkwag3Vzlxps6ANelKfVzd12ARj6jOGZxf+wqTeMI2KRSWBRGBloBpj7/hgMN1sGjvXK
	MMCb2Z8wuCrMuTvLRqvGHsGMtmVWmUmbU2fLUXmY15q7h8mOZCwIIEPNaNjQLNYLfM02JuPv7u6
	9PVEZBdPV9Vhsv/KKUBL00w+5/VwQD/Q==
X-Received: from pfbdi7.prod.google.com ([2002:a05:6a00:4807:b0:82a:ff5:27d5])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1305:b0:82f:b5:8044
 with SMTP id d2e1a72fcca58-82f0c1e261amr19788807b3a.6.1776196053630; Tue, 14
 Apr 2026 12:47:33 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:47:02 +0000
In-Reply-To: <20260414194702.1229094-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260414194702.1229094-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414194702.1229094-11-praan@google.com>
Subject: [PATCH v6 10/10] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are
used by exposed ops or interrupt handlers. Elide all TLB and CFG
invalidations if the smmu is suspended but not  ATC invalidations.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  18 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 108 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   4 +
 3 files changed, 118 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index ddae0b07c76b..b92e891035bb 100644
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
 
 	info = kzalloc_obj(*info);
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
 
@@ -386,8 +394,12 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
-						  cur - last, true);
+		if (arm_smmu_rpm_get_if_active(smmu)) {
+			ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, last->cmd,
+							  cur - last, true);
+			arm_smmu_rpm_put(smmu);
+		}
+
 		if (ret) {
 			cur--;
 			goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index be091739af49..983042fd7a5b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -111,7 +111,7 @@ static const char * const event_class_str[] = {
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -126,7 +126,7 @@ __maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -141,7 +141,7 @@ __maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
  * This should always return true if devlinks are setup correctly
  * and the client using the SMMU is active.
  */
-__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
+bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
 {
 	if (!arm_smmu_is_active(smmu))
 		return false;
@@ -1100,7 +1100,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 {
 	struct arm_smmu_cmdq_ent cmd = {0};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	int sid = master->streams[0].id;
+	int ret;
 
 	if (WARN_ON(!master->stall_enabled))
 		return;
@@ -1120,6 +1122,25 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 		break;
 	}
 
+	/*
+	 * The SMMU is guaranteed to be active via device_link if any master is
+	 * active. Furthermore, on suspend we set GBPA to abort, flushing any
+	 * pending stalled transactions.
+	 *
+	 * Receiving a page fault while suspended implies a bug in the power
+	 * dependency chain or a stale event. Since the SMMU is powered down
+	 * and the command queue is inaccessible, we cannot issue the
+	 * RESUME command and must drop it.
+	 */
+	if (!arm_smmu_is_active(smmu)) {
+		dev_err(smmu->dev, "Ignoring page fault while suspended\n");
+		return;
+	}
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
 	/*
 	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
@@ -1127,6 +1148,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Invalidation array manipulation functions */
@@ -1652,6 +1674,9 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		return;
+
 	arm_smmu_cmdq_batch_init(smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
@@ -1659,6 +1684,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	}
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
+	arm_smmu_rpm_put(smmu);
 }
 
 static void arm_smmu_write_cd_l1_desc(struct arm_smmu_cdtab_l1 *dst,
@@ -1949,6 +1975,7 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
+	struct arm_smmu_device *smmu = writer->master->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_STE,
 		.cfgi	= {
@@ -1957,7 +1984,11 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 		},
 	};
 
-	arm_smmu_cmdq_issue_cmd_with_sync(writer->master->smmu, &cmd);
+	if (!arm_smmu_rpm_get_if_active(smmu))
+		return;
+
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+	arm_smmu_rpm_put(smmu);
 }
 
 static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
@@ -2362,6 +2393,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
+	int ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -2370,6 +2402,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2390,6 +2426,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2437,6 +2474,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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
@@ -2448,6 +2490,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2502,8 +2545,19 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret;
+
+	/* If we are suspended, this is a spurious interrupt */
+	if (arm_smmu_rpm_get_if_active(smmu) <= 0) {
+		dev_err(smmu->dev,
+			"Ignoring gerror interrupt because the SMMU is suspended\n");
+		return IRQ_NONE;
+	}
+
+	ret = arm_smmu_handle_gerror(smmu);
+	arm_smmu_rpm_put(smmu);
 
-	return arm_smmu_handle_gerror(smmu);
+	return ret;
 }
 
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
@@ -2593,19 +2647,25 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 				   ioasid_t ssid)
 {
-	int i;
+	int i, ret = 0;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
+	/* Shouldn't be elided if there's no devlink inconsistency */
+	if (WARN_ON_ONCE(!arm_smmu_rpm_get_if_active(master->smmu)))
+		return 0;
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
 
 /* IO_PGTABLE API */
@@ -2823,7 +2883,16 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
-			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+			bool active = arm_smmu_rpm_get_if_active(smmu);
+
+			if (arm_smmu_inv_is_ats(cur))
+				WARN_ON_ONCE(!active);
+
+			if (active) {
+				arm_smmu_cmdq_batch_submit(smmu, &cmds);
+				arm_smmu_rpm_put(smmu);
+			}
+			/* Drop this batch to ensure the next one's fresh */
 			cmds.num = 0;
 		}
 		cur = next;
@@ -3540,6 +3609,9 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
 {
 	struct arm_smmu_cmdq_ent cmd = {};
 
+	if (!arm_smmu_rpm_get_if_active(inv->smmu))
+		return;
+
 	switch (inv->type) {
 	case INV_TYPE_S1_ASID:
 		cmd.tlbi.asid = inv->id;
@@ -3549,11 +3621,14 @@ static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
 		cmd.tlbi.vmid = inv->id;
 		break;
 	default:
-		return;
+		goto out_rpm_put;
 	}
 
 	cmd.opcode = inv->nsize_opcode;
 	arm_smmu_cmdq_issue_cmd_with_sync(inv->smmu, &cmd);
+
+out_rpm_put:
+	arm_smmu_rpm_put(inv->smmu);
 }
 
 /* Should be installed after arm_smmu_install_ste_for_dev() */
@@ -5747,10 +5822,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5758,8 +5842,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
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
index 3a20a553105e..a697fa3c457b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1152,11 +1152,15 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
 static inline bool arm_smmu_is_active(struct arm_smmu_device *smmu)
 {
 	return !Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
 }
 
+bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.54.0.rc0.605.g598a273b03-goog

