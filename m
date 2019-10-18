Return-Path: <SRS0=1rIG=YL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA3CA9EA0
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05395222C2
	for <iommu@archiver.kernel.org>; Fri, 18 Oct 2019 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TvdTe96a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05395222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E5576DD8;
	Fri, 18 Oct 2019 23:31:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8261FDD1
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 23:31:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9CB73828
	for <iommu@lists.linux-foundation.org>;
	Fri, 18 Oct 2019 23:31:23 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
	hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
	id <B5daa4b4f0000>; Fri, 18 Oct 2019 16:31:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
	by hqpgpgate101.nvidia.com (PGP Universal service);
	Fri, 18 Oct 2019 16:31:23 -0700
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Fri, 18 Oct 2019 16:31:23 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
	(172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3;
	Fri, 18 Oct 2019 23:31:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
	(172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via
	Frontend Transport; Fri, 18 Oct 2019 23:31:22 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
	hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
	id <B5daa4b4a0005>; Fri, 18 Oct 2019 16:31:22 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: 
Subject: [PATCH v3 2/7] iommu/arm-smmu: add NVIDIA implementation for dual ARM
	MMU-500 usage
Date: Fri, 18 Oct 2019 16:31:27 -0700
Message-ID: <1571441492-21919-3-git-send-email-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
References: <1571441492-21919-1-git-send-email-vdumpa@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1571441488; bh=YfkroDUB1HCDYogd1mM74mLYeqXcB27C4E2bHgsrtSI=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	Content-Type;
	b=TvdTe96ah5NRf0GSRRZVwDcQ01OQXYrcT4gf3shmylM6GKq71glw0RcGQ3z8hpfTP
	o+VmHEScBVbo/4+OQemjAodgQMMKg9MIlDOm3FdBhLeB39DjIFOybJDR1XquewtTrj
	j9WftIJaZR524LQet+w4cIJSxjhOx/uFJqhYdLg/H5ZPgUIGU2O22gGIKZ6QqPBIj6
	DHKhAniAy3p5uYSSrkMOnx0kUP1cNlJExlkOa31A1Vmzz2xxV4q4FJjKtbrhHKu4f4
	02NTnEhzd6to2PhDfrAQqxdvCy6lT8iDMCrZnhXDetKhLI3oBt0h4CpNnUAuWUdjqA
	CKtQcK+7Q9F6Q==
Cc: snikam@nvidia.com, thomasz@nvidia.com, jtukkinen@nvidia.com,
	mperttunen@nvidia.com, will@kernel.org,
	linux-kernel@vger.kernel.org, praithatha@nvidia.com,
	talho@nvidia.com, iommu@lists.linux-foundation.org,
	nicolinc@nvidia.com, linux-tegra@vger.kernel.org,
	yhsu@nvidia.com, treding@nvidia.com, robin.murphy@arm.com,
	avanbrunt@nvidia.com, linux-arm-kernel@lists.infradead.org
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

NVIDIA's Tegra194 soc uses two ARM MMU-500s together to interleave
IOVA accesses across them.
Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
string for Tegra194 soc.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 MAINTAINERS                     |   2 +
 drivers/iommu/Makefile          |   2 +-
 drivers/iommu/arm-smmu-impl.c   |   3 +
 drivers/iommu/arm-smmu-nvidia.c | 187 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.h        |   1 +
 5 files changed, 194 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a69e6db..b61dbda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15974,9 +15974,11 @@ F:	drivers/i2c/busses/i2c-tegra.c
 
 TEGRA IOMMU DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
+R:	Krishna Reddy <vdumpa@nvidia.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
 F:	drivers/iommu/tegra*
+F:	drivers/iommu/arm-smmu-nvidia.c
 
 TEGRA KBC DRIVER
 M:	Laxman Dewangan <ldewangan@nvidia.com>
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 35d1709..4ef8b74 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
-obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o
+obj-$(CONFIG_ARM_SMMU) += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index 5c87a38..1a19687 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -158,6 +158,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	 */
 	switch (smmu->model) {
 	case ARM_MMU500:
+		if (of_device_is_compatible(smmu->dev->of_node,
+					    "nvidia,tegra194-smmu"))
+			return nvidia_smmu_impl_init(smmu);
 		smmu->impl = &arm_mmu500_impl;
 		break;
 	case CAVIUM_SMMUV2:
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
new file mode 100644
index 0000000..ca871dc
--- /dev/null
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Nvidia ARM SMMU v2 implementation quirks
+// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.
+
+#define pr_fmt(fmt) "nvidia-smmu: " fmt
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "arm-smmu.h"
+
+/* Tegra194 has three ARM MMU-500 Instances.
+ * Two of them are used together for Interleaved IOVA accesses and
+ * used by Non-Isochronous Hw devices for SMMU translations.
+ * Third one is used for SMMU translations from Isochronous HW devices.
+ * It is possible to use this Implementation to program either
+ * all three or two of the instances identically as desired through
+ * DT node.
+ *
+ * Programming all the three instances identically comes with redundant tlb
+ * invalidations as all three never need to be tlb invalidated for a HW device.
+ *
+ * When Linux Kernel supports multiple SMMU devices, The SMMU device used for
+ * Isochornous HW devices should be added as a separate ARM MMU-500 device
+ * in DT and be programmed independently for efficient tlb invalidates.
+ *
+ */
+#define MAX_SMMU_INSTANCES 3
+
+struct nvidia_smmu {
+	struct arm_smmu_device	smmu;
+	unsigned int		num_inst;
+	void __iomem		*bases[MAX_SMMU_INSTANCES];
+};
+
+#define to_nvidia_smmu(s) container_of(s, struct nvidia_smmu, smmu)
+
+#define nsmmu_page(smmu, inst, page) \
+	(((inst) ? to_nvidia_smmu(smmu)->bases[(inst)] : smmu->base) + \
+	((page) << smmu->pgshift))
+
+static u32 nsmmu_read_reg(struct arm_smmu_device *smmu,
+			      int page, int offset)
+{
+	return readl_relaxed(nsmmu_page(smmu, 0, page) + offset);
+}
+
+static void nsmmu_write_reg(struct arm_smmu_device *smmu,
+			    int page, int offset, u32 val)
+{
+	unsigned int i;
+
+	for (i = 0; i < to_nvidia_smmu(smmu)->num_inst; i++)
+		writel_relaxed(val, nsmmu_page(smmu, i, page) + offset);
+}
+
+static u64 nsmmu_read_reg64(struct arm_smmu_device *smmu,
+				int page, int offset)
+{
+	return readq_relaxed(nsmmu_page(smmu, 0, page) + offset);
+}
+
+static void nsmmu_write_reg64(struct arm_smmu_device *smmu,
+				  int page, int offset, u64 val)
+{
+	unsigned int i;
+
+	for (i = 0; i < to_nvidia_smmu(smmu)->num_inst; i++)
+		writeq_relaxed(val, nsmmu_page(smmu, i, page) + offset);
+}
+
+static void nsmmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+			   int sync, int status)
+{
+	u32 reg;
+	unsigned int i;
+	unsigned int spin_cnt, delay;
+
+	arm_smmu_writel(smmu, page, sync, 0);
+
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			reg = 0;
+			for (i = 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
+				reg |= readl_relaxed(
+					nsmmu_page(smmu, i, page) + status);
+			}
+			if (!(reg & sTLBGSTATUS_GSACTIVE))
+				return;
+			cpu_relax();
+		}
+		udelay(delay);
+	}
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
+}
+
+static void nsmmu_tlb_sync_context(void *cookie)
+{
+	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->cb_lock, flags);
+	nsmmu_tlb_sync(smmu, ARM_SMMU_CB(smmu, smmu_domain->cfg.cbndx),
+		       ARM_SMMU_CB_TLBSYNC, ARM_SMMU_CB_TLBSTATUS);
+	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
+}
+
+static void nsmmu_tlb_sync_global(struct arm_smmu_device *smmu)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&smmu->global_sync_lock, flags);
+	nsmmu_tlb_sync(smmu, ARM_SMMU_GR0, ARM_SMMU_GR0_sTLBGSYNC,
+		       ARM_SMMU_GR0_sTLBGSTATUS);
+	spin_unlock_irqrestore(&smmu->global_sync_lock, flags);
+}
+
+static int nsmmu_reset(struct arm_smmu_device *smmu)
+{
+	u32 reg;
+	unsigned int i;
+
+	for (i = 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
+		/* clear global FSR */
+		reg = readl_relaxed(nsmmu_page(smmu, i, ARM_SMMU_GR0) +
+				    ARM_SMMU_GR0_sGFSR);
+		writel_relaxed(reg, nsmmu_page(smmu, i, ARM_SMMU_GR0) +
+				    ARM_SMMU_GR0_sGFSR);
+	}
+
+	nsmmu_tlb_sync_global(smmu);
+	return 0;
+}
+
+static int nsmmu_init_context(struct arm_smmu_domain *smmu_domain)
+{
+	smmu_domain->flush_ops->tlb_sync = nsmmu_tlb_sync_context;
+	return 0;
+}
+
+static const struct arm_smmu_impl nvidia_smmu_impl = {
+	.read_reg = nsmmu_read_reg,
+	.write_reg = nsmmu_write_reg,
+	.read_reg64 = nsmmu_read_reg64,
+	.write_reg64 = nsmmu_write_reg64,
+	.reset = nsmmu_reset,
+	.init_context = nsmmu_init_context,
+};
+
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
+{
+	unsigned int i;
+	struct nvidia_smmu *nsmmu;
+	struct resource *res;
+	struct device *dev = smmu->dev;
+	struct platform_device *pdev = to_platform_device(smmu->dev);
+
+	nsmmu = devm_kzalloc(smmu->dev, sizeof(*nsmmu), GFP_KERNEL);
+	if (!nsmmu)
+		return ERR_PTR(-ENOMEM);
+
+	nsmmu->smmu = *smmu;
+	/* Instance 0 is ioremapped by arm-smmu.c */
+	nsmmu->num_inst = 1;
+
+	for (i = 1; i < MAX_SMMU_INSTANCES; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+		nsmmu->bases[i] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nsmmu->bases[i]))
+			return (struct arm_smmu_device *)nsmmu->bases[i];
+		nsmmu->num_inst++;
+	}
+
+	nsmmu->smmu.impl = &nvidia_smmu_impl;
+	devm_kfree(smmu->dev, smmu);
+	pr_info("NVIDIA ARM SMMU Implementation, Instances=%d\n",
+		nsmmu->num_inst);
+
+	return &nsmmu->smmu;
+}
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index b2d6c7f..4520ef7 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -400,5 +400,6 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 
 #endif /* _ARM_SMMU_H */
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
