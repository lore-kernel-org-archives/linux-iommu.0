Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EBC3A589
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:37:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A642083B
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 18:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A642083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D75D21094;
	Thu, 15 Aug 2019 18:37:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id B105F2C
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CDB55CF
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 18:37:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D064344;
	Thu, 15 Aug 2019 11:37:42 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EC3403F694; 
	Thu, 15 Aug 2019 11:37:40 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH v2 00/17] Arm SMMU refactoring
Date: Thu, 15 Aug 2019 19:37:20 +0100
Message-Id: <cover.1565892337.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
MIME-Version: 1.0
Cc: bjorn.andersson@linaro.org, iommu@lists.linux-foundation.org,
	gregory.clement@bootlin.com, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi all,

v1 for context: https://patchwork.kernel.org/cover/11087347/

Here's a quick v2 attempting to address all the minor comments; I've
tweaked a whole bunch of names, added some verbosity in macros and
comments for clarity, and rejigged arm_smmu_impl_init() for a bit more
structure. The (new) patches #1 and #2 are up front as conceptual fixes,
although they're not actually critical - it turns out to be more of an
embarrassment than a real problem in practice.

For ease of reference, the overall diff against v1 is attached below.

Robin.


Robin Murphy (17):
  iommu/arm-smmu: Mask TLBI address correctly
  iommu/qcom: Mask TLBI addresses correctly
  iommu/arm-smmu: Convert GR0 registers to bitfields
  iommu/arm-smmu: Convert GR1 registers to bitfields
  iommu/arm-smmu: Convert context bank registers to bitfields
  iommu/arm-smmu: Rework cb_base handling
  iommu/arm-smmu: Split arm_smmu_tlb_inv_range_nosync()
  iommu/arm-smmu: Get rid of weird "atomic" write
  iommu/arm-smmu: Abstract GR1 accesses
  iommu/arm-smmu: Abstract context bank accesses
  iommu/arm-smmu: Abstract GR0 accesses
  iommu/arm-smmu: Rename arm-smmu-regs.h
  iommu/arm-smmu: Add implementation infrastructure
  iommu/arm-smmu: Move Secure access quirk to implementation
  iommu/arm-smmu: Add configuration implementation hook
  iommu/arm-smmu: Add reset implementation hook
  iommu/arm-smmu: Add context init implementation hook

 MAINTAINERS                   |   3 +-
 drivers/iommu/Makefile        |   2 +-
 drivers/iommu/arm-smmu-impl.c | 174 +++++++++++
 drivers/iommu/arm-smmu-regs.h | 210 -------------
 drivers/iommu/arm-smmu.c      | 573 +++++++++++-----------------------
 drivers/iommu/arm-smmu.h      | 394 +++++++++++++++++++++++
 drivers/iommu/qcom_iommu.c    |  17 +-
 7 files changed, 764 insertions(+), 609 deletions(-)
 create mode 100644 drivers/iommu/arm-smmu-impl.c
 delete mode 100644 drivers/iommu/arm-smmu-regs.h
 create mode 100644 drivers/iommu/arm-smmu.h

----->8-----
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 3c731e087854..e22e9004f449 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -28,7 +28,7 @@ static int arm_smmu_gr0_ns(int offset)
 static u32 arm_smmu_read_ns(struct arm_smmu_device *smmu, int page,
 			    int offset)
 {
-	if (page == 0)
+	if (page == ARM_SMMU_GR0)
 		offset = arm_smmu_gr0_ns(offset);
 	return readl_relaxed(arm_smmu_page(smmu, page) + offset);
 }
@@ -36,7 +36,7 @@ static u32 arm_smmu_read_ns(struct arm_smmu_device *smmu, int page,
 static void arm_smmu_write_ns(struct arm_smmu_device *smmu, int page,
 			      int offset, u32 val)
 {
-	if (page == 0)
+	if (page == ARM_SMMU_GR0)
 		offset = arm_smmu_gr0_ns(offset);
 	writel_relaxed(val, arm_smmu_page(smmu, page) + offset);
 }
@@ -52,18 +52,17 @@ struct cavium_smmu {
 	struct arm_smmu_device smmu;
 	u32 id_base;
 };
-#define to_csmmu(s)	container_of(s, struct cavium_smmu, smmu)
 
 static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 {
 	static atomic_t context_count = ATOMIC_INIT(0);
+	struct cavium_smmu *cs = container_of(smmu, struct cavium_smmu, smmu);
 	/*
 	 * Cavium CN88xx erratum #27704.
 	 * Ensure ASID and VMID allocation is unique across all SMMUs in
 	 * the system.
 	 */
-	to_csmmu(smmu)->id_base = atomic_fetch_add(smmu->num_context_banks,
-						   &context_count);
+	cs->id_base = atomic_fetch_add(smmu->num_context_banks, &context_count);
 	dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
 
 	return 0;
@@ -71,12 +70,13 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 
 int cavium_init_context(struct arm_smmu_domain *smmu_domain)
 {
-	u32 id_base = to_csmmu(smmu_domain->smmu)->id_base;
+	struct cavium_smmu *cs = container_of(smmu_domain->smmu,
+					      struct cavium_smmu, smmu);
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
-		smmu_domain->cfg.vmid += id_base;
+		smmu_domain->cfg.vmid += cs->id_base;
 	else
-		smmu_domain->cfg.asid += id_base;
+		smmu_domain->cfg.asid += cs->id_base;
 
 	return 0;
 }
@@ -88,18 +88,18 @@ const struct arm_smmu_impl cavium_impl = {
 
 struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smmu)
 {
-	struct cavium_smmu *csmmu;
+	struct cavium_smmu *cs;
 
-	csmmu = devm_kzalloc(smmu->dev, sizeof(*csmmu), GFP_KERNEL);
-	if (!csmmu)
+	cs = devm_kzalloc(smmu->dev, sizeof(*cs), GFP_KERNEL);
+	if (!cs)
 		return ERR_PTR(-ENOMEM);
 
-	csmmu->smmu = *smmu;
-	csmmu->smmu.impl = &cavium_impl;
+	cs->smmu = *smmu;
+	cs->smmu.impl = &cavium_impl;
 
 	devm_kfree(smmu->dev, smmu);
 
-	return &csmmu->smmu;
+	return &cs->smmu;
 }
 
 
@@ -150,16 +150,25 @@ const struct arm_smmu_impl arm_mmu500_impl = {
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 {
-	/* The current quirks happen to be mutually-exclusive */
+	/*
+	 * We will inevitably have to combine model-specific implementation
+	 * quirks with platform-specific integration quirks, but everything
+	 * we currently support happens to work out as straightforward
+	 * mutually-exclusive assignments.
+	 */
+	switch (smmu->model) {
+	case ARM_MMU500:
+		smmu->impl = &arm_mmu500_impl;
+		break;
+	case CAVIUM_SMMUV2:
+		return cavium_smmu_impl_init(smmu);
+	default:
+		break;
+	}
+
 	if (of_property_read_bool(smmu->dev->of_node,
 				  "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
-	if (smmu->model == CAVIUM_SMMUV2)
-		return cavium_smmu_impl_init(smmu);
-
-	if (smmu->model == ARM_MMU500)
-		smmu->impl = &arm_mmu500_impl;
-
 	return smmu;
 }
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 251089d6428d..b8628e2ab579 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -264,7 +264,7 @@ static void arm_smmu_tlb_sync_global(struct arm_smmu_device *smmu)
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu->global_sync_lock, flags);
-	__arm_smmu_tlb_sync(smmu, 0, ARM_SMMU_GR0_sTLBGSYNC,
+	__arm_smmu_tlb_sync(smmu, ARM_SMMU_GR0, ARM_SMMU_GR0_sTLBGSYNC,
 			    ARM_SMMU_GR0_sTLBGSTATUS);
 	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
 }
@@ -276,7 +276,7 @@ static void arm_smmu_tlb_sync_context(void *cookie)
 	unsigned long flags;
 
 	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
-	__arm_smmu_tlb_sync(smmu, smmu->numpage + smmu_domain->cfg.cbndx,
+	__arm_smmu_tlb_sync(smmu, ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx),
 			    ARM_SMMU_CB_TLBSYNC, ARM_SMMU_CB_TLBSTATUS);
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 }
@@ -326,7 +326,7 @@ static void arm_smmu_tlb_inv_range_s1(unsigned long iova, size_t size,
 	reg = leaf ? ARM_SMMU_CB_S1_TLBIVAL : ARM_SMMU_CB_S1_TLBIVA;
 
 	if (cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64) {
-		iova &= ~12UL;
+		iova = (iova >> 12) << 12;
 		iova |= cfg->asid;
 		do {
 			arm_smmu_cb_write(smmu, idx, reg, iova);
@@ -1197,7 +1197,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	else
 		arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_ATS1PR, va);
 
-	reg = arm_smmu_page(smmu, smmu->numpage + idx) + ARM_SMMU_CB_ATSR;
+	reg = arm_smmu_page(smmu, ARM_SMMU_CB(smmu, idx)) + ARM_SMMU_CB_ATSR;
 	if (readl_poll_timeout_atomic(reg, tmp, !(tmp & ATSR_ACTIVE), 5, 50)) {
 		spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 		dev_err(dev,
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index cf367c3b1bee..611ed742e56f 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -366,20 +366,28 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 		writeq_relaxed(val, arm_smmu_page(smmu, page) + offset);
 }
 
-#define arm_smmu_gr0_read(s, r)		arm_smmu_readl((s), 0, (r))
-#define arm_smmu_gr0_write(s, r, v)	arm_smmu_writel((s), 0, (r), (v))
+#define ARM_SMMU_GR0		0
+#define ARM_SMMU_GR1		1
+#define ARM_SMMU_CB(s, n)	((s)->numpage + (n))
 
-#define arm_smmu_gr1_read(s, r)		arm_smmu_readl((s), 1, (r))
-#define arm_smmu_gr1_write(s, r, v)	arm_smmu_writel((s), 1, (r), (v))
+#define arm_smmu_gr0_read(s, o)		\
+	arm_smmu_readl((s), ARM_SMMU_GR0, (o))
+#define arm_smmu_gr0_write(s, o, v)	\
+	arm_smmu_writel((s), ARM_SMMU_GR0, (o), (v))
 
-#define arm_smmu_cb_read(s, n, r)				\
-	arm_smmu_readl((s), (s)->numpage + (n), (r))
-#define arm_smmu_cb_write(s, n, r, v)				\
-	arm_smmu_writel((s), (s)->numpage + (n), (r), (v))
-#define arm_smmu_cb_readq(s, n, r)				\
-	arm_smmu_readq((s), (s)->numpage + (n), (r))
-#define arm_smmu_cb_writeq(s, n, r, v)				\
-	arm_smmu_writeq((s), (s)->numpage + (n), (r), (v))
+#define arm_smmu_gr1_read(s, o)		\
+	arm_smmu_readl((s), ARM_SMMU_GR1, (o))
+#define arm_smmu_gr1_write(s, o, v)	\
+	arm_smmu_writel((s), ARM_SMMU_GR1, (o), (v))
+
+#define arm_smmu_cb_read(s, n, o)	\
+	arm_smmu_readl((s), ARM_SMMU_CB((s), (n)), (o))
+#define arm_smmu_cb_write(s, n, o, v)	\
+	arm_smmu_writel((s), ARM_SMMU_CB((s), (n)), (o), (v))
+#define arm_smmu_cb_readq(s, n, o)	\
+	arm_smmu_readq((s), ARM_SMMU_CB((s), (n)), (o))
+#define arm_smmu_cb_writeq(s, n, o, v)	\
+	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
 
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index dadc707573a2..a2062d13584f 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -156,7 +156,7 @@ static void qcom_iommu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 		struct qcom_iommu_ctx *ctx = to_ctx(fwspec, fwspec->ids[i]);
 		size_t s = size;
 
-		iova &= ~12UL;
+		iova = (iova >> 12) << 12;
 		iova |= ctx->asid;
 		do {
 			iommu_writel(ctx, reg, iova);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
