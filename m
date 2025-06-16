Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2380217AE11
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042606; cv=none; b=isq5jB9DZ3f3vew4+5mqhHCujx8EEHdBMJS0Xl0DhqI2GOQHUGvxehh/JbH34XHwh20QQLvpAEWTkjN/oytPYxW/3bIt3lb73Yribl5AKoemYtJHk8EDGmfKC55sb9vVGTpDwRNG+pwW1BMF29n50rRfQ67OUGwQEEk5b5rI2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042606; c=relaxed/simple;
	bh=QTxndpX87zWcLNEBcDGGRY4zszTJXwnFeJhwseeADds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbUwiXyHRmaFwGVS9N516Lm4xhdTCw2H5wXd2NdHo6eWlKR3x1tm1+Wb+mJ/U0SsSfhw2FzR4cLntYAeibQhm716TgHFoyvC1PEe0+Nx0mt4VAEzLn7HlQxCBuZzb5/4LadOIxwU3n/ru57QHJQAbfG0TnAFScVLafygWw/o1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IZnFyciQ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IZnFyciQ"
X-UUID: 85ca8ffe4a5d11f0b910cdf5d4d8066a-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mYmlyXHiNFhbRtbqPR7vS3N39bKSmKnGG7ZsjxUW5bQ=;
	b=IZnFyciQw7SEIA9pSs2ZUyqd4f1vPehHwj69n1W7IJFTy/gvpT8PhIN1LzcI7eGX1z4+SyBOCzOHzp0O0unOP7stw75k7dlxkwNNV3l1DgF7Ew4UtvAyQJgeohWu6VdRX63755MyYseXzrMt/PBmKPjasTVI8U2iz4WK78EyE+o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:73dfd6af-10d2-44e3-a580-01c9e66a3860,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:be08b758-abad-4ac2-9923-3af0a8a9a079,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 85ca8ffe4a5d11f0b910cdf5d4d8066a-20250616
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 976834261; Mon, 16 Jun 2025 10:56:38 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:36 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:35 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>, Ning li
	<ning.li@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <iommu@lists.linux.dev>, Xueqi Zhang
	<xueqi.zhang@mediatek.com>
Subject: [RFC PATCH 2/8] iommu/arm-smmu-v3: Add SMMU implementation
Date: Mon, 16 Jun 2025 10:56:08 +0800
Message-ID: <20250616025628.25454-3-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Mediatek has its own implementation for wrapper interrupts and
power management.So add SMMU implementation when smmu device probe.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 drivers/iommu/arm/Kconfig                        |  7 +++++++
 drivers/iommu/arm/arm-smmu-v3/Makefile           |  3 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c | 16 ++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c | 13 +++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      |  3 +++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |  4 ++++
 6 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c

diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
index ef42bbe07dbe..a7f98fd0f2bf 100644
--- a/drivers/iommu/arm/Kconfig
+++ b/drivers/iommu/arm/Kconfig
@@ -88,6 +88,13 @@ config ARM_SMMU_V3
 	  the ARM SMMUv3 architecture.
 
 if ARM_SMMU_V3
+config ARM_SMMU_V3_MEDIATEK
+	bool "ARM Ltd. System MMU Version 3 (SMMUv3) MediaTek Support"
+	depends on ARM_SMMU_V3 && ARCH_MEDIATEK
+	help
+	  When running on a MediaTek platform that has the custom variant
+	  of the ARM SMMUv3, this needs to be built into the SMMU driver.
+
 config ARM_SMMU_V3_SVA
 	bool "Shared Virtual Addressing support for the ARM SMMUv3"
 	select IOMMU_SVA
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 493a659cc66b..0670065d6e9a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
-arm_smmu_v3-y := arm-smmu-v3.o
+arm_smmu_v3-y := arm-smmu-v3.o arm-smmu-v3-impl.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
+arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_MEDIATEK) += arm-smmu-v3-mediatek.o
 arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
new file mode 100644
index 000000000000..d39587b965ef
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Ning li <ning.li@mediatek.com>
+ * Author: Xueqi Zhang <xueqi.zhang@mediatek.com>
+ */
+
+#include "arm-smmu-v3.h"
+
+struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu)
+{
+#if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
+	smmu = arm_smmu_v3_impl_mtk_init(smmu);
+#endif
+	return smmu;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
new file mode 100644
index 000000000000..381268968185
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Ning li <ning.li@mediatek.com>
+ * Author: Xueqi Zhang <xueqi.zhang@mediatek.com>
+ */
+
+#include "arm-smmu-v3.h"
+
+struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
+{
+	return NULL;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 10cc6dc26b7b..d36124a6bb54 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4754,6 +4754,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	}
 	ioaddr = res->start;
 
+	smmu = arm_smmu_v3_impl_init(smmu);
+	if (IS_ERR(smmu))
+		return PTR_ERR(smmu);
 	/*
 	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
 	 * the PMCG registers which are reserved by the PMU driver.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ea41d790463e..99eeb6143c49 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -998,6 +998,10 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
 				bool sync);
 
+struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
+#if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
+struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu);
+#endif
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.46.0

