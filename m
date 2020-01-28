Return-Path: <SRS0=+4f7=3R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5AFC33CB2
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:36 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F16322465B
	for <iommu@archiver.kernel.org>; Tue, 28 Jan 2020 22:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Pu9UEIjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16322465B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4C3220554;
	Tue, 28 Jan 2020 22:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRWM+WvGjTae; Tue, 28 Jan 2020 22:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6C41320774;
	Tue, 28 Jan 2020 22:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A177C0175;
	Tue, 28 Jan 2020 22:16:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD546C0171
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CC0CE86D81
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PSiHIwBk65Hy for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jan 2020 22:16:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail25.static.mailgun.info (mail25.static.mailgun.info
 [104.130.122.25])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4180C86BB9
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jan 2020 22:16:29 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1580249789; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=KdcQ65gqI50OxnhTRGaxYktgrCkhdMIxF4WU3OuTTNg=;
 b=Pu9UEIjnW5i0IwCvy+Q63YN6aR4Th/FzXOMBRhK27LOrBS1j92etqbVy2Mn6zdk1znJCPXz3
 4MXQNIwRTx/72Fk3j2yMWgtVxto9E1WysIqmMMwZdY/Y+uTmV40eC9z7tKzt4E3BMbAe9uPm
 xKYa9lGO4LiBBUJwIqtHC3+k2gE=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e30b2b4.7f767cdf9998-smtp-out-n02;
 Tue, 28 Jan 2020 22:16:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8D326C447A1; Tue, 28 Jan 2020 22:16:20 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 28EFDC43383;
 Tue, 28 Jan 2020 22:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28EFDC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
From: Jordan Crouse <jcrouse@codeaurora.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v1 2/6] arm/smmu: Add auxiliary domain support for arm-smmuv2
Date: Tue, 28 Jan 2020 15:16:06 -0700
Message-Id: <1580249770-1088-3-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
References: <1580249770-1088-1-git-send-email-jcrouse@codeaurora.org>
Cc: robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Support auxiliary domains for arm-smmu-v2 to initialize and support
multiple pagetables for a single SMMU context bank. Since the smmu-v2
hardware doesn't have any built in support for switching the pagetable
base it is left as an exercise to the caller to actually use the pagetable.

Aux domains are supported if split pagetable (TTBR1) support has been
enabled on the master domain.  Each auxiliary domain will reuse the
configuration of the master domain. By default the a domain with TTBR1
support will have the TTBR0 region disabled so the first attached aux
domain will enable the TTBR0 region in the hardware and conversely the
last domain to be detached will disable TTBR0 translations.  All subsequent
auxiliary domains create a pagetable but not touch the hardware.

The leaf driver will be able to query the physical address of the
pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
address with whatever means it has to switch the pagetable base.

Following is a pseudo code example of how a domain can be created

 /* Check to see if aux domains are supported */
 if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
	 iommu = iommu_domain_alloc(...);

	 if (iommu_aux_attach_device(domain, dev))
		 return FAIL;

	/* Save the base address of the pagetable for use by the driver
	iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
 }

Then 'domain' can be used like any other iommu domain to map and
unmap iova addresses in the pagetable.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
---

 drivers/iommu/arm-smmu.c | 230 +++++++++++++++++++++++++++++++++++++++++++----
 drivers/iommu/arm-smmu.h |   3 +
 2 files changed, 217 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 23b22fa..85a6773 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -91,6 +91,8 @@ struct arm_smmu_cb {
 	u32				tcr[2];
 	u32				mair[2];
 	struct arm_smmu_cfg		*cfg;
+	atomic_t			aux;
+	atomic_t			refcount;
 };
 
 struct arm_smmu_master_cfg {
@@ -533,6 +535,7 @@ static void arm_smmu_init_context_bank(struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_cb *cb = &smmu_domain->smmu->cbs[cfg->cbndx];
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 
+	atomic_inc(&cb->refcount);
 	cb->cfg = cfg;
 
 	/* TCR */
@@ -671,6 +674,91 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
 }
 
+/*
+ * Update the context context bank to enable TTBR0. Assumes AARCH64 S1
+ * configuration.
+ */
+static void arm_smmu_context_set_ttbr0(struct arm_smmu_cb *cb,
+		struct io_pgtable_cfg *pgtbl_cfg)
+{
+	u32 tcr = cb->tcr[0];
+
+	/* Add the TCR configuration from the new pagetable config */
+	tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
+
+	/* Make sure that both TTBR0 and TTBR1 are enabled */
+	tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
+
+	/* Udate the TCR register */
+	cb->tcr[0] = tcr;
+
+	/* Program the new TTBR0 */
+	cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
+	cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
+}
+
+/*
+ * Thus function assumes that the current model only allows aux domains for
+ * AARCH64 S1 configurations
+ */
+static int arm_smmu_aux_init_domain_context(struct iommu_domain *domain,
+		struct arm_smmu_device *smmu, struct arm_smmu_cfg *master)
+{
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct io_pgtable_ops *pgtbl_ops;
+	struct io_pgtable_cfg pgtbl_cfg;
+
+	mutex_lock(&smmu_domain->init_mutex);
+
+	/* Copy the configuration from the master */
+	memcpy(&smmu_domain->cfg, master, sizeof(smmu_domain->cfg));
+
+	smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
+	smmu_domain->smmu = smmu;
+
+	pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap = smmu->pgsize_bitmap,
+		.ias = smmu->va_size,
+		.oas = smmu->ipa_size,
+		.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK,
+		.tlb = smmu_domain->flush_ops,
+		.iommu_dev = smmu->dev,
+		.quirks = 0,
+	};
+
+	if (smmu_domain->non_strict)
+		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
+
+	pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &pgtbl_cfg,
+		smmu_domain);
+	if (!pgtbl_ops) {
+		mutex_unlock(&smmu_domain->init_mutex);
+		return -ENOMEM;
+	}
+
+	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
+
+	domain->geometry.aperture_end = (1UL << smmu->va_size) - 1;
+	domain->geometry.force_aperture = true;
+
+	/*
+	 * Add a reference to the context bank to make sure it stays programmed
+	 * wile we are attached
+	 */
+	atomic_inc(&smmu->cbs[master->cbndx].refcount);
+
+	/* enable TTBR0 when the the first aux domain is attached */
+	if (atomic_inc_return(&smmu->cbs[master->cbndx].aux) == 1) {
+		arm_smmu_context_set_ttbr0(&smmu->cbs[master->cbndx],
+			&pgtbl_cfg);
+		arm_smmu_write_context_bank(smmu, master->cbndx);
+	}
+
+	smmu_domain->ptbase = pgtbl_cfg.arm_lpae_s1_cfg.ttbr;
+	smmu_domain->pgtbl_ops = pgtbl_ops;
+	return 0;
+}
+
 static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 					struct arm_smmu_device *smmu)
 {
@@ -882,36 +970,70 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	return ret;
 }
 
+static void
+arm_smmu_destroy_aux_domain_context(struct arm_smmu_domain *smmu_domain)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
+	int ret;
+
+	/*
+	 * If this is the last aux domain to be freed, disable TTBR0 by turning
+	 * off translations and clearing TTBR0
+	 */
+	if (atomic_dec_return(&smmu->cbs[cfg->cbndx].aux) == 0) {
+		/* Clear out the T0 region */
+		smmu->cbs[cfg->cbndx].tcr[0] &= ~GENMASK(15, 0);
+		/* Disable TTBR0 translations */
+		smmu->cbs[cfg->cbndx].tcr[0] |= ARM_SMMU_TCR_EPD0;
+		/* Clear the TTBR0 pagetable address */
+		smmu->cbs[cfg->cbndx].ttbr[0] =
+			FIELD_PREP(ARM_SMMU_TTBRn_ASID, cfg->asid);
+
+		ret = arm_smmu_rpm_get(smmu);
+		if (!ret) {
+			arm_smmu_write_context_bank(smmu, cfg->cbndx);
+			arm_smmu_rpm_put(smmu);
+		}
+	}
+
+}
+
 static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
 {
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
-	int ret, irq;
 
 	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
 		return;
 
-	ret = arm_smmu_rpm_get(smmu);
-	if (ret < 0)
-		return;
+	if (smmu_domain->aux)
+		arm_smmu_destroy_aux_domain_context(smmu_domain);
 
-	/*
-	 * Disable the context bank and free the page tables before freeing
-	 * it.
-	 */
-	smmu->cbs[cfg->cbndx].cfg = NULL;
-	arm_smmu_write_context_bank(smmu, cfg->cbndx);
+	/* Check if the last user is done with the context bank */
+	if (atomic_dec_return(&smmu->cbs[cfg->cbndx].refcount) == 0) {
+		int ret = arm_smmu_rpm_get(smmu);
+		int irq;
 
-	if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
-		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-		devm_free_irq(smmu->dev, irq, domain);
+		if (ret < 0)
+			return;
+
+		/* Disable the context bank */
+		smmu->cbs[cfg->cbndx].cfg = NULL;
+		arm_smmu_write_context_bank(smmu, cfg->cbndx);
+
+		if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
+			irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
+			devm_free_irq(smmu->dev, irq, domain);
+		}
+
+		__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
+		arm_smmu_rpm_put(smmu);
 	}
 
+	/* Destroy the pagetable */
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
-	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
-
-	arm_smmu_rpm_put(smmu);
 }
 
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
@@ -1181,6 +1303,73 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static bool arm_smmu_dev_has_feat(struct device *dev,
+		enum iommu_dev_features feat)
+{
+	if (feat != IOMMU_DEV_FEAT_AUX)
+		return false;
+
+	return true;
+}
+
+static int arm_smmu_dev_enable_feat(struct device *dev,
+		enum iommu_dev_features feat)
+{
+	/* aux domain support is always available */
+	if (feat == IOMMU_DEV_FEAT_AUX)
+		return 0;
+
+	return -ENODEV;
+}
+
+static int arm_smmu_dev_disable_feat(struct device *dev,
+		enum iommu_dev_features feat)
+{
+	return -EBUSY;
+}
+
+static int arm_smmu_aux_attach_dev(struct iommu_domain *domain,
+		struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu = fwspec_smmu(fwspec);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_cb *cb;
+	int idx, i, ret, cbndx = -1;
+
+	/* Try to find the context bank configured for this device */
+	for_each_cfg_sme(fwspec, i, idx) {
+		if (idx != INVALID_SMENDX) {
+			cbndx = smmu->s2crs[idx].cbndx;
+			break;
+		}
+	}
+
+	if (cbndx == -1)
+		return -ENODEV;
+
+	cb = &smmu->cbs[cbndx];
+
+	/* Aux domains are only supported for AARCH64 configurations */
+	if (cb->cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64)
+		return -EINVAL;
+
+	/* Make sure that TTBR1 is enabled in the hardware */
+	if ((cb->tcr[0] & ARM_SMMU_TCR_EPD1))
+		return -EINVAL;
+
+	smmu_domain->aux = true;
+
+	ret = arm_smmu_rpm_get(smmu);
+	if (ret < 0)
+		return ret;
+
+	ret = arm_smmu_aux_init_domain_context(domain, smmu, cb->cfg);
+
+	arm_smmu_rpm_put(smmu);
+	return ret;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret;
@@ -1549,6 +1738,11 @@ static int arm_smmu_domain_get_attr(struct iommu_domain *domain,
 		case DOMAIN_ATTR_SPLIT_TABLES:
 			*(int *)data = smmu_domain->split_pagetables;
 			return 0;
+		case DOMAIN_ATTR_PTBASE:
+			if (!smmu_domain->aux)
+				return -EINVAL;
+			*(u64 *)data = smmu_domain->ptbase;
+			return 0;
 		default:
 			return -ENODEV;
 		}
@@ -1667,6 +1861,10 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.dev_has_feat		= arm_smmu_dev_has_feat,
+	.dev_enable_feat	= arm_smmu_dev_enable_feat,
+	.dev_disable_feat	= arm_smmu_dev_disable_feat,
+	.aux_attach_dev		= arm_smmu_aux_attach_dev,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 53053fd..8266b29 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -345,6 +345,9 @@ struct arm_smmu_domain {
 	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
 	struct iommu_domain		domain;
 	bool				split_pagetables;
+	bool				aux;
+	/* Shadow of the pagetable base for aux domains */
+	u64				ptbase;
 };
 
 static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
-- 
2.7.4
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
