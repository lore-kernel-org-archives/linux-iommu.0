Return-Path: <SRS0=0Jez=AL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF48CC433E5
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C4F206DA
	for <iommu@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kS4KkyDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C4F206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 66DA288A4E;
	Tue, 30 Jun 2020 23:59:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q0u7gB6Xd3FU; Tue, 30 Jun 2020 23:59:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F0FC88A41;
	Tue, 30 Jun 2020 23:59:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AC68C0892;
	Tue, 30 Jun 2020 23:59:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47527C016E
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 36E558879D
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:59:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnK+byQS9T3j for <iommu@lists.linux-foundation.org>;
 Tue, 30 Jun 2020 23:59:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 569C3887AE
 for <iommu@lists.linux-foundation.org>; Tue, 30 Jun 2020 23:59:17 +0000 (UTC)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5efbd1a30001>; Tue, 30 Jun 2020 16:58:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Tue, 30 Jun 2020 16:59:16 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 16:59:16 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 23:59:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:59:11 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by
 hqnvemgw03.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5efbd1cf0009>; Tue, 30 Jun 2020 16:59:11 -0700
From: Krishna Reddy <vdumpa@nvidia.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
 <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
Subject: [PATCH v9 2/4] iommu/arm-smmu: add NVIDIA implementation for ARM
 MMU-500 usage
Date: Tue, 30 Jun 2020 16:57:50 -0700
Message-ID: <20200630235752.8737-3-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630235752.8737-1-vdumpa@nvidia.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1593561507; bh=fMqx6uZVex3BcgP7NxAT863LjXlo1WwRHL0dSMqyUQ8=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=kS4KkyDkha0v3IMDjF6hHyuaUeF1F70MmQUw4rABTb/sjfqK/C0BrXjmY1ML9Lcgw
 O1cLxr0N/yPTlqEmDNzX/RdDYCAWNcfD38OOlFX0bphY3l1E5OKK6G1rrNwnI5ZoT7
 ya3A4OnaWOPJcrkiy/G+i8XMjOIhngxxRXTVaFiBXph2AW2c0wjxlLc9An9s+k5kNf
 xKbM52CRvLm05+Iae8XQ13dDfuqPO+PRPG+zM1PpubCqBPXwUUz2cipijLacyd2yf8
 RjnapOVpJAIMmB/EvpOZoUTfTimQRe2XZpqwKxfxr9oGInrqlNUI3WGB5++HJWTtdq
 ucl4WELawO9gg==
Cc: snikam@nvidia.com, devicetree@vger.kernel.org, nicoleotsuka@gmail.com,
 mperttunen@nvidia.com, bhuntsman@nvidia.com, yhsu@nvidia.com,
 linux-kernel@vger.kernel.org, talho@nvidia.com,
 iommu@lists.linux-foundation.org, nicolinc@nvidia.com,
 linux-tegra@vger.kernel.org, praithatha@nvidia.com,
 linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
It uses two of ARM MMU-500s together to interleave IOVA accesses
across them and must be programmed identically.
The third SMMU instance is used as a regular ARM MMU-500 and it
can either be programmed independently or identical to other
two ARM MMU-500s.

This implementation supports programming two or three ARM MMU-500s
identically as per DT config.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 MAINTAINERS                     |   2 +
 drivers/iommu/Makefile          |   2 +-
 drivers/iommu/arm-smmu-impl.c   |   3 +
 drivers/iommu/arm-smmu-nvidia.c | 206 ++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.h        |   1 +
 5 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd646c6b9..64c37dbdd4426 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16808,8 +16808,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
 
 TEGRA IOMMU DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
+R:	Krishna Reddy <vdumpa@nvidia.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
+F:	drivers/iommu/arm-smmu-nvidia.c
 F:	drivers/iommu/tegra*
 
 TEGRA KBC DRIVER
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 342190196dfb0..2b8203db73ec3 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
-arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b702..f15571d05474e 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl = &calxeda_impl;
 
+	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
+		return nvidia_smmu_impl_init(smmu);
+
 	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
 	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidia.c
new file mode 100644
index 0000000000000..5c874912e1c1a
--- /dev/null
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// NVIDIA ARM SMMU v2 implementation quirks
+// Copyright (C) 2019-2020 NVIDIA CORPORATION.  All rights reserved.
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "arm-smmu.h"
+
+/*
+ * Tegra194 has three ARM MMU-500 Instances.
+ * Two of them are used together for interleaved IOVA accesses and
+ * used by non-isochronous HW devices for SMMU translations.
+ * Third one is used for SMMU translations from isochronous HW devices.
+ * It is possible to use this implementation to program either
+ * all three or two of the instances identically as desired through
+ * DT node.
+ *
+ * Programming all the three instances identically comes with redundant TLB
+ * invalidations as all three never need to be TLB invalidated for a HW device.
+ *
+ * When Linux kernel supports multiple SMMU devices, the SMMU device used for
+ * isochornous HW devices should be added as a separate ARM MMU-500 device
+ * in DT and be programmed independently for efficient TLB invalidates.
+ */
+#define MAX_SMMU_INSTANCES 3
+
+struct nvidia_smmu {
+	struct arm_smmu_device	smmu;
+	unsigned int		num_inst;
+	void __iomem		*bases[MAX_SMMU_INSTANCES];
+};
+
+static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *smmu)
+{
+	return container_of(smmu, struct nvidia_smmu, smmu);
+}
+
+static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
+					     unsigned int inst, int page)
+{
+	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
+
+	if (!nvidia_smmu->bases[0])
+		nvidia_smmu->bases[0] = smmu->base;
+
+	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
+}
+
+static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
+				int page, int offset)
+{
+	void __iomem *reg = nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readl_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
+				  int page, int offset, u32 val)
+{
+	unsigned int i;
+	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
+
+	for (i = 0; i < nvidia_smmu->num_inst; i++) {
+		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
+
+		writel_relaxed(val, reg);
+	}
+}
+
+static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
+				  int page, int offset)
+{
+	void __iomem *reg = nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readq_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
+				    int page, int offset, u64 val)
+{
+	unsigned int i;
+	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
+
+	for (i = 0; i < nvidia_smmu->num_inst; i++) {
+		void __iomem *reg = nvidia_smmu_page(smmu, i, page) + offset;
+
+		writeq_relaxed(val, reg);
+	}
+}
+
+static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+				 int sync, int status)
+{
+	unsigned int delay;
+	struct nvidia_smmu *nvidia_smmu = to_nvidia_smmu(smmu);
+
+	arm_smmu_writel(smmu, page, sync, 0);
+
+	for (delay = 1; delay < TLB_LOOP_TIMEOUT; delay *= 2) {
+		unsigned int spin_cnt;
+
+		for (spin_cnt = TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			u32 val = 0;
+			unsigned int i;
+
+			for (i = 0; i < nvidia_smmu->num_inst; i++) {
+				void __iomem *reg =
+					nvidia_smmu_page(smmu, i, page) + status;
+
+				val |= readl_relaxed(reg);
+			}
+
+			if (!(val & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
+				return;
+
+			cpu_relax();
+		}
+
+		udelay(delay);
+	}
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
+}
+
+static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
+{
+	unsigned int i;
+
+	for (i = 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
+		u32 val;
+		void __iomem *reg = nvidia_smmu_page(smmu, i, ARM_SMMU_GR0) +
+				    ARM_SMMU_GR0_sGFSR;
+
+		/* clear global FSR */
+		val = readl_relaxed(reg);
+		writel_relaxed(val, reg);
+	}
+
+	return 0;
+}
+
+static const struct arm_smmu_impl nvidia_smmu_impl = {
+	.read_reg = nvidia_smmu_read_reg,
+	.write_reg = nvidia_smmu_write_reg,
+	.read_reg64 = nvidia_smmu_read_reg64,
+	.write_reg64 = nvidia_smmu_write_reg64,
+	.reset = nvidia_smmu_reset,
+	.tlb_sync = nvidia_smmu_tlb_sync,
+};
+
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
+{
+	struct resource *res;
+	struct device *dev = smmu->dev;
+	struct nvidia_smmu *nvidia_smmu;
+	struct platform_device *pdev = to_platform_device(dev);
+
+	nvidia_smmu = devm_kzalloc(dev, sizeof(*nvidia_smmu), GFP_KERNEL);
+	if (!nvidia_smmu)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Copy the data from arm_smmu_device struct allocated in arm-smmu.c.
+	 * The memory for the arm_smmu_device struct from arm-smmu.c is freed
+	 * subsequently.
+	 */
+	nvidia_smmu->smmu = *smmu;
+	/* Instance 0 is ioremapped by arm-smmu.c after this function returns */
+	nvidia_smmu->num_inst = 1;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	/* Minimum two SMMU instances are expected. */
+	if (!res)
+		return ERR_PTR(-ENODEV);
+
+	nvidia_smmu->bases[1] = devm_ioremap_resource(dev, res);
+	if (IS_ERR(nvidia_smmu->bases[1]))
+		return ERR_CAST(nvidia_smmu->bases[1]);
+
+	nvidia_smmu->num_inst++;
+
+	/* 3rd SMMU instance is Optional. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+	if (res) {
+		nvidia_smmu->bases[2] = devm_ioremap_resource(dev, res);
+		if (IS_ERR(nvidia_smmu->bases[2]))
+			return ERR_CAST(nvidia_smmu->bases[2]);
+
+		nvidia_smmu->num_inst++;
+	}
+
+	nvidia_smmu->smmu.impl = &nvidia_smmu_impl;
+	/*
+	 * Free the arm_smmu_device struct allocated in arm-smmu.c.
+	 * Once this function returns, arm-smmu.c would use arm_smmu_device
+	 * allocated as part of nvidia_smmu struct.
+	 */
+	devm_kfree(dev, smmu);
+
+	return &nvidia_smmu->smmu;
+}
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index c7d0122a7c6ca..fad63efa1a72d 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -452,6 +452,7 @@ static inline void arm_smmu_writeq(struct arm_smmu_device *smmu, int page,
 	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
 
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
 
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
