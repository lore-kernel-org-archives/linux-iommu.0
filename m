Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDE39447C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666410; cv=none; b=klzWePb7xdxHAgkXwYGp6pImeZeV9IAhYAa8rG/XiT7p9fnj9NK/KDl2/6GFMApW3ho3nNjPJndbQtCltChF3eTFsy0PUqPYjQTPQzN42XYaRzMPNR9Vy/775loPbeHd6mzLl/vqElomgxZtdPD9v590h2pOHIoFSP3ockKIvG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666410; c=relaxed/simple;
	bh=HKrCpLJ6bw7H3RJn+ezozzabfQVz0fvuKW0/baVIZxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=llK3+xbgcZaxICI18IBEOtI4SOeHSov5pmJo/eqcM9/rNC6+Lcu4TsXRERrXsZojLpgeA7kfacwHA2xQalc4eyOEz9EsLpqrJcUcsOaEqNq/vcONkDcSw4oqojb76RNuPEIAOqmbEfQCXzBKUwb/ir/hwQzftIIpZO4cqUW1A0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kHoSRZw7; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHoSRZw7"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1999218a12.3
        for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 00:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790666408; x=1791271208; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/uZDExLzYAB6EpzeDZNXRf2hABc3epv46tayxxhqFt0=;
        b=kHoSRZw7w/hgtsr862dgowbBCSZEUBY8Z/j9GQfo+XEs0TKdVW9Eg9Azu9zenoA7hn
         YzdgjKkWWP2ei9IU9/kbXjbLe+cDSAy4+09Y+S+uOanoobMUjynbB6ZmxQrOEtRnc7Pd
         OXaKi1jbfKTtYIQK/MbWxlrA5I27+o911mBltDYFEER+zj8X3XpMrYgy4XYEO69uD7bx
         mOnAEF+i/vYkaCD4xOFFWuE8WWIWdLgDeefCZLzWCzd91bGIXNau/rgLQUO0qE4YS8uZ
         l4mn/zDjgGyfewWhHfhZUtQ6fzvE9OKftglZJ+kMSG3LhszpCqAZH8jBuG+ecpo9WOAG
         xhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666408; x=1791271208;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uZDExLzYAB6EpzeDZNXRf2hABc3epv46tayxxhqFt0=;
        b=coLwSXal8vR3qITHpeArqRdtTpx3ECOcjiKClYSIeW3VjSK3uTzu5kLoIJvyXits2M
         HKtjYAOFU8iEKchSqz7/eC7O/kL4mCY+DySiBGGcVdx+eZrS2H5v0uUp7gJfpBMQFlYp
         avC/ZHyr5thzP5I/N2jhF9i3esZLgj23nFGTyEFMT6xkjtX1mgkWxL9VyR/Pn0P69hDd
         DLkhFBL67R7mBrjZAiXWNrtlVyz7otXpXRTZ3jcr7wA4P7Ma1k556lO5GvoH3HJhmZnc
         FXwZN252X42xhA5LTYpPiey4L53O7cFEp/trEUySYFmrndUTSBFI1XIfOChpL9dYc6ZO
         1v6A==
X-Gm-Message-State: AFuF++nBiQ4DaT48O/OniPB6zc0Ql/USceqxnXbUMjY5CVcks8gePR9b
	W/MpTXAFsm4h4rO91FNQ8a3fsC+0S2lu6GF6glB3QyI6TqCZPQfTt48T/yQ/WyazZFCOFNeZCYN
	+U+l1Pb7Gaq/7fYXguUpf6hAYuBSDITqR/cyLJbYpIiY8v6/qhVVwjlvEoWrQbMAL5qqA3s06wm
	Su7t2gNgZU0ufidVgxCfYR3O7WXTENsQ==
X-Received: from pgdj8.prod.google.com ([2002:a05:6a02:5208:b0:cc7:9685:757a])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:c709:b0:3da:34a7:6444
 with SMTP id adf61e73a8af0-3de0e73aba9mr14757995637.26.1790666407830; Tue, 29
 Sep 2026 00:20:07 -0700 (PDT)
Date: Tue, 29 Sep 2026 07:19:47 +0000
In-Reply-To: <20260929071950.2710070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929071950.2710070-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929071950.2710070-7-praan@google.com>
Subject: [RFC PATCH v1 6/9] iommu/arm-smmu-v3: Implement Live Update shutdown
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

During a Kexec Handover (KHO) with Live Update enabled, the SMMUv3
must not be disabled (via CR0.SMMUEN=0) during device shutdown since
doing so would instantly stop active DMA traffic preserved for masters.

Modify the .shutdown hook to install abort STEs for unpreserved masters,
invalidate the L1STDs of unpreserved L2 tables and flush the config and
TLB caches. Mask the interrupts, wait for the EVTQ handler and disable
the queues, leaving SMMUEN set. Fall back to a full disable on failure.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c  | 120 ++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  25 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  12 ++
 3 files changed, 152 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
index 981b091a47a1..68652123d0e1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-liveupdate.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/iommu-liveupdate.h>
 #include <linux/kexec_handover.h>
@@ -429,6 +430,125 @@ void arm_smmu_unpreserve(struct iommu_device *iommu,
 		arm_smmu_unpreserve_strtab_linear(smmu, iommu_ser);
 }
 
+static void arm_smmu_liveupdate_clear_l1_std(struct arm_smmu_device *smmu,
+					     unsigned long *l2_active)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	int i;
+
+	for (i = 0; i < cfg->l2.num_l1_ents; i++) {
+		if (!cfg->l2.l2ptrs[i] || test_bit(i, l2_active))
+			continue;
+
+		/* Clear L1 STD for unpreserved streams */
+		WRITE_ONCE(cfg->l2.l1tab[i].l2ptr, 0);
+	}
+}
+
+int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_stream *stream;
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+	struct rb_node *node;
+	struct arm_smmu_ste abort_ste;
+	struct arm_smmu_cmd cmd_cfgi, cmd_el2, cmd_nsnh;
+	unsigned long *l2_active = NULL;
+	bool is_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
+	u32 cr0;
+	int ret;
+
+	/* Only the incoming kernel unmasks the SMMU interrupts again */
+	if (arm_smmu_disable_irqs(smmu))
+		dev_warn(smmu->dev, "failed to disable irqs\n");
+
+	/* Wait for a running EVTQ handler */
+	if (smmu->combined_irq || smmu->evtq.q.irq)
+		synchronize_irq(smmu->combined_irq ?: smmu->evtq.q.irq);
+
+	if (is_2lvl) {
+		l2_active = bitmap_zalloc(cfg->l2.num_l1_ents, GFP_KERNEL);
+		if (!l2_active) {
+			dev_err(smmu->dev, "OOM: Falling back to hard disable\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Prepare an abort STE for unpreserved masters */
+	arm_smmu_make_abort_ste(&abort_ste);
+
+	/*
+	 * We do not scrub unpreserved Context Descriptors (CDs) here since:
+	 *
+	 * 1. Each master has its own independently allocated CD table page,
+	 *    i.e. multiple masters never share a CD table.
+	 *
+	 * 2. We explicitly reject preserving any device with active PASIDs in
+	 *    the .preserve_device op. Thus, any preserved master is guaranteed
+	 *    to only be using CD[0].
+	 *
+	 * Therefore, partial preservation within a CD table is not possible,
+	 * and we only need to isolate unpreserved streams within shared
+	 * Stream Tables.
+	 */
+	mutex_lock(&smmu->streams_mutex);
+
+	/* Install the abort STEs for unpreserved masters */
+	for (node = rb_first(&smmu->streams); node; node = rb_next(node)) {
+		stream = rb_entry(node, struct arm_smmu_stream, node);
+		master = stream->master;
+
+		if (master->preserved) {
+			if (is_2lvl)
+				set_bit(arm_smmu_strtab_l1_idx(stream->id), l2_active);
+		} else {
+			arm_smmu_write_ste(master, stream->id,
+				  arm_smmu_get_step_for_sid(smmu, stream->id),
+				  &abort_ste);
+		}
+	}
+
+	/* Invalidate completely unpreserved streams */
+	if (is_2lvl) {
+		arm_smmu_liveupdate_clear_l1_std(smmu, l2_active);
+		bitmap_free(l2_active);
+	}
+
+	mutex_unlock(&smmu->streams_mutex);
+
+	/* Sync hardware caches to observe updated structures */
+	cmd_cfgi = arm_smmu_make_cmd_cfgi_all();
+	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmd_cfgi, 1, true);
+
+	/*
+	 * Aggressively flush all TLBs to ensure no stale entries exist for
+	 * unpreserved streams. The preserved streams will take a minor hit
+	 * re-walking their page tables, but this guarantees safety.
+	 */
+	if (smmu->features & ARM_SMMU_FEAT_HYP) {
+		cmd_el2 = arm_smmu_make_cmd_op(CMDQ_OP_TLBI_EL2_ALL);
+		arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmd_el2, 1, true);
+	}
+
+	cmd_nsnh = arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL);
+	arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &cmd_nsnh, 1, true);
+
+	/*
+	 * No need to drain the CMDQ: the invalidations above are synced, no
+	 * other submitters are left at shutdown and the incoming kernel
+	 * invalidates everything again.
+	 * TODO: Quiesce the CMDQV VCMDQs assigned to guests.
+	 */
+
+	/* Disable the queues, leaving SMMUEN set for the preserved masters */
+	cr0 = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+	cr0 &= ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+	ret = arm_smmu_write_reg_sync(smmu, cr0, ARM_SMMU_CR0, ARM_SMMU_CR0ACK);
+	if (ret)
+		dev_err(smmu->dev, "failed to disable queues\n");
+	return ret;
+}
+
 static int arm_smmu_liveupdate_restore_strtab_2lvl(struct arm_smmu_device *smmu,
 						   struct iommu_hw_ser *iommu_ser,
 						   u32 cfg_reg, phys_addr_t base)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b13ed06a368f..3cf97f451b64 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1853,9 +1853,9 @@ static const struct arm_smmu_entry_writer_ops arm_smmu_ste_writer_ops = {
 	.get_update_safe = arm_smmu_get_ste_update_safe,
 };
 
-static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
-			       struct arm_smmu_ste *ste,
-			       const struct arm_smmu_ste *target)
+void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
+			struct arm_smmu_ste *ste,
+			const struct arm_smmu_ste *target)
 {
 	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ste_writer ste_writer = {
@@ -4813,8 +4813,8 @@ static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-static int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
-				   unsigned int reg_off, unsigned int ack_off)
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off)
 {
 	u32 reg;
 
@@ -4998,6 +4998,12 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+int arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
+{
+	return arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
+				       ARM_SMMU_IRQ_CTRLACK);
+}
+
 static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
 {
 	int ret;
@@ -5919,6 +5925,15 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	if (iommu_preserved_state(&smmu->iommu)) {
+		if (!arm_smmu_liveupdate_shutdown(smmu))
+			return;
+	}
+
+	/*
+	 * Disable the SMMU on standard shutdown/reboot.
+	 * Fallback to this path if the Live Update shutdown failed.
+	 */
 	arm_smmu_device_disable(smmu);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 453ad34ab0fa..0a88c0ec66ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1198,6 +1198,9 @@ to_smmu_nested_domain(struct iommu_domain *dom)
 extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
+int arm_smmu_write_reg_sync(struct arm_smmu_device *smmu, u32 val,
+			    unsigned int reg_off, unsigned int ack_off);
+int arm_smmu_disable_irqs(struct arm_smmu_device *smmu);
 
 #ifdef CONFIG_IOMMU_LIVEUPDATE
 int arm_smmu_preserve_device(struct device *dev,
@@ -1208,9 +1211,14 @@ void arm_smmu_unpreserve_device(struct device *dev,
 				struct iommu_device_ser *device_ser);
 void arm_smmu_unpreserve(struct iommu_device *iommu,
 			 struct iommu_hw_ser *iommu_ser);
+int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_liveupdate_restore_cd_tables(struct arm_smmu_master *master);
 #else
+static inline int arm_smmu_liveupdate_shutdown(struct arm_smmu_device *smmu)
+{
+	return -EOPNOTSUPP;
+}
 static inline int arm_smmu_liveupdate_restore_strtab(struct arm_smmu_device *smmu)
 {
 	return -ENOENT;
@@ -1242,6 +1250,10 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
 		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
+void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
+			struct arm_smmu_ste *ste,
+			const struct arm_smmu_ste *target);
+
 void arm_smmu_domain_tlbi(struct arm_smmu_tlbi *tlbi,
 			  struct arm_smmu_domain *smmu_domain);
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

