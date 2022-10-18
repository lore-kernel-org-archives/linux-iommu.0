Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3F1C3D
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 06:43:41 +0000 (UTC)
X-UUID: ba8d7a85b29f4733a1097e542a264ac8-20221018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XLjpNmmzQfrCx04W/9OkBGz4SSpfbEEzwXgH5RbWvZE=;
	b=HVANC9E8n9qc17SU71a1dbE/sbaEtg1kvBJg1XCMXVUibve+2uopbpJEIJlmMtUq4CWq2prkVtjsUB12Cb9bEWLIPOhda1uIybD2niMc6oc2AVpvwNjhiT2pWNevJjGw4If23SGj1Ef2uzs1Ok8n8kY/lOx4DYVDyAiIP877nZU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:456cbf24-4098-45c8-9e76-4c9049b920df,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:39a5ff1,CLOUDID:e43b21a4-ebb2-41a8-a87c-97702aaf2e20,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ba8d7a85b29f4733a1097e542a264ac8-20221018
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 130291350; Tue, 18 Oct 2022 14:43:37 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 18 Oct 2022 14:43:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Tue, 18 Oct 2022 14:43:35 +0800
From: Chengci.Xu <chengci.xu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chengci.Xu
	<chengci.xu@mediatek.com>
Subject: [PATCH v4 3/4] iommu/mediatek: Add enable IOMMU SMC command for INFRA master
Date: Tue, 18 Oct 2022 14:42:38 +0800
Message-ID: <20221018064239.13391-4-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221018064239.13391-1-chengci.xu@mediatek.com>
References: <20221018064239.13391-1-chengci.xu@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The register which can enable IOMMU for INFRA master should be setted
in secure world for security concerns. Therefore, we add a SMC command
for INFRA master to enable/disable INFRA IOMMU in ATF. This function is
prepared for MT8188.

Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c  | 32 ++++++++++++++++++++++----------
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index fbaf401f34e0..cb62cb89a2f4 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
+#include <linux/arm-smccc.h>
 #include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
@@ -28,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/soc/mediatek/infracfg.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
 #include <asm/barrier.h>
 #include <soc/mediatek/smi.h>
 
@@ -139,6 +141,7 @@
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
+#define CFG_IFA_MASTER_IN_ATF		BIT(19)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -535,6 +538,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
 	unsigned long portid_msk_ext;
+	struct arm_smccc_res res;
 	u32 portid_msk = 0;
 	int i, ret = 0;
 
@@ -562,17 +566,24 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		else
 			larb_mmu->mmu &= ~portid_msk;
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
-		/* PCI dev has only one output id, enable the next writing bit for PCIe */
-		if (dev_is_pci(dev)) {
-			if (fwspec->num_ids != 1) {
-				dev_err(dev, "PCI dev can only have one port.\n");
-				return -ENODEV;
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
+			arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
+				      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
+				      portid_msk, enable, 0, 0, 0, 0, &res);
+			ret = res.a0;
+		} else {
+			/* PCI dev has only one output id, enable the next writing bit for PCIe */
+			if (dev_is_pci(dev)) {
+				if (fwspec->num_ids != 1) {
+					dev_err(dev, "PCI dev can only have one port.\n");
+					return -ENODEV;
+				}
+				portid_msk |= BIT(portid + 1);
 			}
-			portid_msk |= BIT(portid + 1);
-		}
 
-		ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
-					 portid_msk, enable ? portid_msk : 0);
+			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+						 portid_msk, enable ? portid_msk : 0);
+		}
 		if (ret)
 			dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
 				enable ? "enable" : "disable",
@@ -1223,7 +1234,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			dev_err_probe(dev, ret, "mm dts parse fail\n");
 			goto out_runtime_disable;
 		}
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   !MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
 		p = data->plat_data->pericfg_comp_str;
 		data->pericfg = syscon_regmap_lookup_by_compatible(p);
 		if (IS_ERR(data->pericfg)) {
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index dfd8efca5e60..000eb1cf68b7 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -13,6 +13,7 @@
 
 enum iommu_atf_cmd {
 	IOMMU_ATF_CMD_CONFIG_SMI_LARB,		/* For mm master to en/disable iommu */
+	IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,	/* For infra master to enable iommu */
 	IOMMU_ATF_CMD_MAX,
 };
 
-- 
2.25.1

