Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10F13C5853
	for <iommu@lists.linux.dev>; Wed, 27 May 2026 22:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920078; cv=none; b=Xebtct1YJXqzSptJLgGexfLucfEMcGwxtztBsWEWiVD0OGA+H/aizH9PkrLv8Hx9cSoOoreIjFTbNkswIJiGSQwmdqD48UODwvqGJraCwQVDNsvaeTBHXg4lBFamb9Y17Ja4ppWa/BXj2oZFecbdLyZsF2iuEMGwFVOD/Xevx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920078; c=relaxed/simple;
	bh=aG3CQcVy1nYutfGwPleVun1yc5eIrFTp2+BbyC7Ul40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hi7OQaVQ8MzKu9v6Dl1mi+rms8hlHB8ZkymoXAhyIu3VVU56ixQsNrRp84evv7JUQG7IYm+LAFAHxjyL5QILZ1Uc2eNaHUcI5mK+1g1qLLPx0uu7BKj7exq05fsWtMvsLlrqjrSIaPY4PUNM5VGejRnIAVbA4xzcKTnTjcKSluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nlopoaqN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlopoaqN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2befd987fffso4589265ad.1
        for <iommu@lists.linux.dev>; Wed, 27 May 2026 15:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779920076; x=1780524876; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T07o4hh9zR51SydtMD40p8DCo5Ke4YN7hyk+lpGq+iI=;
        b=nlopoaqNHwij+t2miaTQZp/PCgsQUa1U86WdzodRBP8W4tfsR8sG+V3DbWrxW7AVhK
         WBk5ZTkNUR3E76Lbz+pGCcMxuSGm25KigSp1PDuPwMsIXgNsz6VsiEbBUibYpJ0D8dBs
         BYXTj/mkPQHMsDGy1xEBTPJpwKYgkNET8WZMHE/ZQlqLdGIyRm1GLQKe9HUxWQKwwZYi
         P4YO/BuEOJL6K9FIFOqnHrx+kWtvgxXUmUQudGMEDUGCUeopWiy9i8PwnUD7FyCMUE4C
         lrtGNkhYlK0cUgS4SpdP1YoCxb+OaQGbqpNG8g0SnPrPcbijbx8IOtFGtH46ck4xYqdw
         zYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920076; x=1780524876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T07o4hh9zR51SydtMD40p8DCo5Ke4YN7hyk+lpGq+iI=;
        b=Ws/Yyx2BZR+JR8itFLn68dd2Qtu8DU8Skz/vi6MrjxkcORWGd3Uv1LqoSyGpfSBd8T
         MOkArAUdUFkqfxyxzKaeSa9j9SuUWoHUSiykEfMszFj9+S7/8RjFQFX4IDAE2Af8re/3
         Kr4fNIVbJbOba/man0XJyOui2msgyzZ0lt2SX7eCsE6hHfiCaD0jbVzAkrwFxWZBw/Sw
         4o6mYUIA7ELNxvpflOtlnI1buocxDk+VkM2eIm1p+7N7wZk3pW0fKPXpetU5lQM5qfYR
         ZwgDx6mHXjEPxz20v9C+RueXtynHsxt7dxe8vI/oEIQDSyzYh1JugxPqOkaCiCHbxEF7
         3gjw==
X-Gm-Message-State: AOJu0Yy+JA2LlTvXJEK+v5nIMhz222dQQps1070/jQR91a8wSQiz7RSv
	8Ou9uf08jfEyzhLJbbpt+Gq6Uih64aWIpSv2wJbEHvGKkcasm432mrisbB5VSYieXTA15giN5L5
	VL9JHMOd/3CH4NCqVX1ro/zpgxaiIjWZIx7OfdpL/IU+3VkFvc5c/eZckUe28B5ZsMHSvZMCKoI
	f2OXL8fBEmix1TGjX6fQQlCXbw+RwUyQ==
X-Received: from plbky11.prod.google.com ([2002:a17:902:f98b:b0:2b2:a6ef:8235])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1a07:b0:2b0:52b7:e82
 with SMTP id d9443c01a7336-2beb0699574mr288251695ad.16.1779920075729; Wed, 27
 May 2026 15:14:35 -0700 (PDT)
Date: Wed, 27 May 2026 22:14:06 +0000
In-Reply-To: <20260527221407.1756491-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260527221407.1756491-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260527221407.1756491-11-praan@google.com>
Subject: [PATCH v7 10/11] iommu/arm-smmu-v3: Invoke pm_runtime before hw access
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

Invoke the pm_runtime helpers at all places before accessing the hw.
The idea is to invoke runtime_pm helpers at common points which are used
by exposed ops or interrupt handlers. TLB and CFG invalidations are
elided if the SMMU is suspended by observing the CMDQ_PROD_STOP_FLAG via
the arm_smmu_can_elide() helper.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  15 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 115 ++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
 3 files changed, 123 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..c10de7aaf399 100644
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
 
@@ -386,8 +394,9 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						  cur - last, true);
+		if (!arm_smmu_can_elide(smmu))
+			ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
+							  cur - last, true);
 		if (ret) {
 			cur--;
 			goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 34e249656ab4..d42f78777571 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -112,7 +112,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
 static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 /* Runtime PM helpers */
-__maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -127,7 +127,7 @@ __maybe_unused static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-__maybe_unused static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
 {
 	int ret;
 
@@ -981,7 +981,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 				   struct iommu_page_response *resp)
 {
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
 	u8 resume_resp;
+	int ret;
 
 	if (WARN_ON(!master->stall_enabled))
 		return;
@@ -999,6 +1001,25 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
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
+	if (arm_smmu_can_elide(smmu)) {
+		dev_err(smmu->dev, "Ignoring page fault while suspended\n");
+		return;
+	}
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return;
+
 	arm_smmu_cmdq_issue_cmd(master->smmu,
 				arm_smmu_make_cmd_resume(master->streams[0].id,
 							 resp->grpid,
@@ -1009,6 +1030,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
 	 * terminated... at some point in the future. PRI_RESP is fire and
 	 * forget.
 	 */
+	arm_smmu_rpm_put(smmu);
 }
 
 /* Invalidation array manipulation functions */
@@ -1528,13 +1550,15 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmd cmd = arm_smmu_make_cmd_cfgi_cd(0, ssid, leaf);
 
+	if (arm_smmu_can_elide(smmu))
+		return;
+
 	arm_smmu_cmdq_batch_init_cmd(smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++)
 		arm_smmu_cmdq_batch_add_cmd(
 			smmu, &cmds,
 			arm_smmu_make_cmd_cfgi_cd(master->streams[i].id, ssid,
 						  leaf));
-
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
 
@@ -1826,9 +1850,12 @@ static void arm_smmu_ste_writer_sync_entry(struct arm_smmu_entry_writer *writer)
 {
 	struct arm_smmu_ste_writer *ste_writer =
 		container_of(writer, struct arm_smmu_ste_writer, writer);
+	struct arm_smmu_device *smmu = writer->master->smmu;
 
-	arm_smmu_cmdq_issue_cmd_with_sync(
-		writer->master->smmu,
+	if (arm_smmu_can_elide(smmu))
+		return;
+
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu,
 		arm_smmu_make_cmd_cfgi_ste(ste_writer->sid, true));
 }
 
@@ -2228,6 +2255,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
 
 static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 {
+	int ret;
 	u64 evt[EVTQ_ENT_DWORDS];
 	struct arm_smmu_event event = {0};
 	struct arm_smmu_device *smmu = dev;
@@ -2236,6 +2264,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
 
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return IRQ_NONE;
+
 	do {
 		while (!queue_remove_raw(q, evt)) {
 			arm_smmu_decode_event(smmu, evt, &event);
@@ -2256,6 +2288,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2293,6 +2326,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
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
@@ -2304,6 +2342,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
 
 	/* Sync our overflow flag, as we believe we're up to speed */
 	queue_sync_cons_ovf(q);
+	arm_smmu_rpm_put(smmu);
 	return IRQ_HANDLED;
 }
 
@@ -2358,8 +2397,33 @@ static irqreturn_t arm_smmu_handle_gerror(struct arm_smmu_device *smmu)
 static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret;
+
+	/*
+	 * Global Errors are only processed if the SMMU is active.
+	 *
+	 * If the STOP_FLAG is set (can_elide == true), the hardware is
+	 * either already disabled or in the process of being disabled.
+	 * Any errors captured during the quiesce/drain phase will be
+	 * handled by the explicit arm_smmu_handle_gerror() call at the
+	 * end of arm_smmu_runtime_suspend() callback. On resume, the
+	 * STOP_FLAG is cleared before interrupts are re-enabled, ensuring
+	 * no valid errors are missed.
+	 *
+	 * A lockless check is favoured here over a dynamic PM core check
+	 * since the runtime_pm_get_if_active would return false during
+	 * transient states like RPM_RESUMING & ignore level-triggered
+	 * interrupts.
+	 */
+	if (arm_smmu_can_elide(smmu)) {
+		dev_err(smmu->dev,
+			"Ignoring gerror interrupt because the SMMU is suspended\n");
+		return IRQ_NONE;
+	}
+
+	ret = arm_smmu_handle_gerror(smmu);
 
-	return arm_smmu_handle_gerror(smmu);
+	return ret;
 }
 
 static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
@@ -2442,6 +2506,10 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 	struct arm_smmu_cmd cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
+	/* Shouldn't be elided if there's no devlink inconsistency */
+	if (WARN_ON_ONCE(arm_smmu_can_elide(master->smmu)))
+		return 0;
+
 	cmd = arm_smmu_make_cmd_atc_inv_all(0, IOMMU_NO_PASID);
 	arm_smmu_cmdq_batch_init_cmd(master->smmu, &cmds, &cmd);
 	for (i = 0; i < master->num_streams; i++)
@@ -2687,7 +2755,22 @@ static void __arm_smmu_domain_inv_range(struct arm_smmu_invs *invs,
 
 		if (cmds.num &&
 		    (next == end || arm_smmu_invs_end_batch(cur, next))) {
-			arm_smmu_cmdq_batch_submit(smmu, &cmds);
+
+			/*
+			 * Concurrent suspend races are benign: the cmdq allocation cmpxchg
+			 * loop acts as the serialization point to safely drop the batch
+			 * without MMIO accesses. Concurrent resume is caught by the HW
+			 * reset cache invalidation, ensuring state consistency.
+			 */
+			bool elide = arm_smmu_can_elide(smmu);
+
+			if (arm_smmu_inv_is_ats(cur))
+				WARN_ON_ONCE(elide);
+
+			if (!elide)
+				arm_smmu_cmdq_batch_submit(smmu, &cmds);
+
+			/* Drop this batch to ensure the next one's fresh */
 			cmds.num = 0;
 		}
 		cur = next;
@@ -3404,6 +3487,9 @@ arm_smmu_install_new_domain_invs(struct arm_smmu_attach_state *state)
 
 static void arm_smmu_inv_flush_iotlb_tag(struct arm_smmu_inv *inv)
 {
+	if (arm_smmu_can_elide(inv->smmu))
+		return;
+
 	switch (inv->type) {
 	case INV_TYPE_S1_ASID:
 		arm_smmu_cmdq_issue_cmd_with_sync(
@@ -5630,10 +5716,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
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
@@ -5641,8 +5736,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
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
index 97ec9d9caffe..39fb26552e57 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1235,6 +1235,9 @@ static inline bool arm_smmu_can_elide(struct arm_smmu_device *smmu)
 	return !!Q_STOP(READ_ONCE(smmu->cmdq.q.llq.prod));
 }
 
+int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
+void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.54.0.794.g4f17f83d09-goog

