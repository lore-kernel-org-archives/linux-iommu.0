Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9C6106
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 10:16:01 +0000 (UTC)
X-UUID: eb676d71e55e42748ef2807328b65df3-20221223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OWp2xnx5R/0ElsNe5KrDhebcysznOvenlLTZkh157mc=;
	b=c7CX9BWq69hyINbZIcKRjk/xx6zkCDLG17nCMPo/dX4AxAOheVrvT771CKqGDPCAgIqg0Cn2MVO3D20p7OeK8iSPVlxBc9ih16W1UQDbvDuS4aAbOlCt8ogU2+uIcF9gl+m8Sf2cfAGwunYPYHM3ZKcO20YUTv4MnBHlu/pnvfA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:aacba25f-1b03-434c-969e-615b00ac020e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:aacba25f-1b03-434c-969e-615b00ac020e,IP:0,URL
	:0,TC:0,Content:-25,EDM:25,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
	ION:quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:52f0388a-8530-4eff-9f77-222cf6e2895b,B
	ulkID:2212231815567X2LC78I,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
	il,Content:0,EDM:5,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: eb676d71e55e42748ef2807328b65df3-20221223
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 285787680; Fri, 23 Dec 2022 18:15:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Dec 2022 18:15:52 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 23 Dec 2022 18:15:51 +0800
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
Subject: [PATCH v6 3/4] iommu/mediatek: Add enable IOMMU SMC command for INFRA master
Date: Fri, 23 Dec 2022 18:14:38 +0800
Message-ID: <20221223101439.494-4-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221223101439.494-1-chengci.xu@mediatek.com>
References: <20221223101439.494-1-chengci.xu@mediatek.com>
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
Reviewed-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c  | 32 ++++++++++++++++++++++----------
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d43981c31b5d..ec81d21e33ce 100644
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
 
@@ -144,6 +146,7 @@
 #define PGTABLE_PA_35_EN		BIT(17)
 #define TF_PORT_TO_ADDR_MT8173		BIT(18)
 #define INT_ID_PORT_WIDTH_6		BIT(19)
+#define CFG_IFA_MASTER_IN_ATF		BIT(20)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -543,6 +546,7 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
 	unsigned long portid_msk = 0;
+	struct arm_smccc_res res;
 	int i, ret = 0;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
@@ -568,17 +572,24 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
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
-					 (u32)portid_msk, enable ? (u32)portid_msk : 0);
+			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+						 (u32)portid_msk, enable ? (u32)portid_msk : 0);
+		}
 		if (ret)
 			dev_err(dev, "%s iommu(%s) inframaster 0x%lx fail(%d).\n",
 				enable ? "enable" : "disable",
@@ -1281,7 +1292,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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

