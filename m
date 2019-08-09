Return-Path: <SRS0=HAoA=WF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549EC31E40
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:09:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457DE20820
	for <iommu@archiver.kernel.org>; Fri,  9 Aug 2019 17:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457DE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 79951E1E;
	Fri,  9 Aug 2019 17:08:37 +0000 (UTC)
Received: from smtp2.linuxfoundation.org (smtp2.linux-foundation.org
	[172.17.192.36])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 00B4FC9A
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp2.linuxfoundation.org (Postfix) with ESMTP id 362251DAA7
	for <iommu@lists.linux-foundation.org>;
	Fri,  9 Aug 2019 17:08:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C613D15AB;
	Fri,  9 Aug 2019 10:08:34 -0700 (PDT)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com
	[10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DDDA3F575; 
	Fri,  9 Aug 2019 10:08:33 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Subject: [PATCH 15/15] iommu/arm-smmu: Add context init implementation hook
Date: Fri,  9 Aug 2019 18:07:52 +0100
Message-Id: <6adbec8e4757f3b6c9f47135544a0302f8e7c55c.1565369764.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <cover.1565369764.git.robin.murphy@arm.com>
References: <cover.1565369764.git.robin.murphy@arm.com>
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

Allocating and initialising a context for a domain is another point
where certain implementations are known to want special behaviour.
Currently the other half of the Cavium workaround comes into play here,
so let's finish the job to get the whole thing right out of the way.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-impl.c | 39 +++++++++++++++++++++++++--
 drivers/iommu/arm-smmu.c      | 51 +++++++----------------------------
 drivers/iommu/arm-smmu.h      | 42 +++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c8904da08354..7a657d47b6ec 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -48,6 +48,12 @@ const struct arm_smmu_impl calxeda_impl = {
 };
 
 
+struct cavium_smmu {
+	struct arm_smmu_device smmu;
+	u32 id_base;
+};
+#define to_csmmu(s)	container_of(s, struct cavium_smmu, smmu)
+
 static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 {
 	static atomic_t context_count = ATOMIC_INIT(0);
@@ -56,17 +62,46 @@ static int cavium_cfg_probe(struct arm_smmu_device *smmu)
 	 * Ensure ASID and VMID allocation is unique across all SMMUs in
 	 * the system.
 	 */
-	smmu->cavium_id_base = atomic_fetch_add(smmu->num_context_banks,
+	to_csmmu(smmu)->id_base = atomic_fetch_add(smmu->num_context_banks,
 						   &context_count);
 	dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
 
 	return 0;
 }
 
+int cavium_init_context(struct arm_smmu_domain *smmu_domain)
+{
+	u32 id_base = to_csmmu(smmu_domain->smmu)->id_base;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
+		smmu_domain->cfg.vmid += id_base;
+	else
+		smmu_domain->cfg.asid += id_base;
+
+	return 0;
+}
+
 const struct arm_smmu_impl cavium_impl = {
 	.cfg_probe = cavium_cfg_probe,
+	.init_context = cavium_init_context,
 };
 
+struct arm_smmu_device *cavium_smmu_impl_init(struct arm_smmu_device *smmu)
+{
+	struct cavium_smmu *csmmu;
+
+	csmmu = devm_kzalloc(smmu->dev, sizeof(*csmmu), GFP_KERNEL);
+	if (!csmmu)
+		return ERR_PTR(-ENOMEM);
+
+	csmmu->smmu = *smmu;
+	csmmu->smmu.impl = &cavium_impl;
+
+	devm_kfree(smmu->dev, smmu);
+
+	return &csmmu->smmu;
+}
+
 
 #define ARM_MMU500_ACTLR_CPRE		(1 << 1)
 
@@ -121,7 +156,7 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 		smmu->impl = &calxeda_impl;
 
 	if (smmu->model == CAVIUM_SMMUV2)
-		smmu->impl = &cavium_impl;
+		return cavium_smmu_impl_init(smmu);
 
 	if (smmu->model == ARM_MMU500)
 		smmu->impl = &arm_mmu500_impl;
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 298ab9e6a6cd..1c1c9ef91d7b 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -27,7 +27,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
-#include <linux/io-pgtable.h>
 #include <linux/iopoll.h>
 #include <linux/init.h>
 #include <linux/moduleparam.h>
@@ -111,44 +110,6 @@ struct arm_smmu_master_cfg {
 #define for_each_cfg_sme(fw, i, idx) \
 	for (i = 0; idx = fwspec_smendx(fw, i), i < fw->num_ids; ++i)
 
-enum arm_smmu_context_fmt {
-	ARM_SMMU_CTX_FMT_NONE,
-	ARM_SMMU_CTX_FMT_AARCH64,
-	ARM_SMMU_CTX_FMT_AARCH32_L,
-	ARM_SMMU_CTX_FMT_AARCH32_S,
-};
-
-struct arm_smmu_cfg {
-	u8				cbndx;
-	u8				irptndx;
-	union {
-		u16			asid;
-		u16			vmid;
-	};
-	enum arm_smmu_cbar_type		cbar;
-	enum arm_smmu_context_fmt	fmt;
-};
-#define INVALID_IRPTNDX			0xff
-
-enum arm_smmu_domain_stage {
-	ARM_SMMU_DOMAIN_S1 = 0,
-	ARM_SMMU_DOMAIN_S2,
-	ARM_SMMU_DOMAIN_NESTED,
-	ARM_SMMU_DOMAIN_BYPASS,
-};
-
-struct arm_smmu_domain {
-	struct arm_smmu_device		*smmu;
-	struct io_pgtable_ops		*pgtbl_ops;
-	const struct iommu_gather_ops	*tlb_ops;
-	struct arm_smmu_cfg		cfg;
-	enum arm_smmu_domain_stage	stage;
-	bool				non_strict;
-	struct mutex			init_mutex; /* Protects smmu pointer */
-	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
-	struct iommu_domain		domain;
-};
-
 static bool using_legacy_binding, using_generic_binding;
 
 static inline int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
@@ -749,9 +710,16 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	}
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2)
-		cfg->vmid = cfg->cbndx + 1 + smmu->cavium_id_base;
+		cfg->vmid = cfg->cbndx + 1;
 	else
-		cfg->asid = cfg->cbndx + smmu->cavium_id_base;
+		cfg->asid = cfg->cbndx;
+
+	smmu_domain->smmu = smmu;
+	if (smmu->impl && smmu->impl->init_context) {
+		ret = smmu->impl->init_context(smmu_domain);
+		if (ret)
+			goto out_unlock;
+	}
 
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
@@ -765,7 +733,6 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
 	if (smmu_domain->non_strict)
 		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
 
-	smmu_domain->smmu = smmu;
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops) {
 		ret = -ENOMEM;
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index 616cc87a05e3..a18b5925b43c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -14,6 +14,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -270,14 +271,50 @@ struct arm_smmu_device {
 	struct clk_bulk_data		*clks;
 	int				num_clks;
 
-	u32				cavium_id_base; /* Specific to Cavium */
-
 	spinlock_t			global_sync_lock;
 
 	/* IOMMU core code handle */
 	struct iommu_device		iommu;
 };
 
+enum arm_smmu_context_fmt {
+	ARM_SMMU_CTX_FMT_NONE,
+	ARM_SMMU_CTX_FMT_AARCH64,
+	ARM_SMMU_CTX_FMT_AARCH32_L,
+	ARM_SMMU_CTX_FMT_AARCH32_S,
+};
+
+struct arm_smmu_cfg {
+	u8				cbndx;
+	u8				irptndx;
+	union {
+		u16			asid;
+		u16			vmid;
+	};
+	enum arm_smmu_cbar_type		cbar;
+	enum arm_smmu_context_fmt	fmt;
+};
+#define INVALID_IRPTNDX			0xff
+
+enum arm_smmu_domain_stage {
+	ARM_SMMU_DOMAIN_S1 = 0,
+	ARM_SMMU_DOMAIN_S2,
+	ARM_SMMU_DOMAIN_NESTED,
+	ARM_SMMU_DOMAIN_BYPASS,
+};
+
+struct arm_smmu_domain {
+	struct arm_smmu_device		*smmu;
+	struct io_pgtable_ops		*pgtbl_ops;
+	const struct iommu_gather_ops	*tlb_ops;
+	struct arm_smmu_cfg		cfg;
+	enum arm_smmu_domain_stage	stage;
+	bool				non_strict;
+	struct mutex			init_mutex; /* Protects smmu pointer */
+	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
+	struct iommu_domain		domain;
+};
+
 
 /* Implementation details, yay! */
 struct arm_smmu_impl {
@@ -289,6 +326,7 @@ struct arm_smmu_impl {
 			    u64 val);
 	int (*cfg_probe)(struct arm_smmu_device *smmu);
 	int (*reset)(struct arm_smmu_device *smmu);
+	int (*init_context)(struct arm_smmu_domain *smmu_domain);
 };
 
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, int n)
-- 
2.21.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
