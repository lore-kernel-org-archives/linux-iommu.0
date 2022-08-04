Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E52816
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 10:59:07 +0000 (UTC)
X-UUID: e82b86c15ff2420ea0a64e7ba729e47d-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QYQI8ZAN0zE26a5BP7WCGe9wf5/d6qH7Jqf+D6VvtAc=;
	b=QLemO5Zi62VVbMiLoklv1HIp15zi/tB1Jo1xOl32xeLrWcYu+soa+TYYf3lFvOLjMuJLGiBGA0EV+/CQlt/MMB3Go4MieUGvnw9g6OADizkZd2ioy9QMzHdEcqcaf6uR2q13PYq/klbCH1FKa9URHYj8RWV/FPhcAbeXXCM5mbI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:9139c80b-7785-4869-9f97-598ea5c3e98a,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
	ION:release,TS:-5
X-CID-META: VersionHash:0f94e32,CLOUDID:55454ad0-a6cf-4fb6-be1b-c60094821ca2,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
	,QS:nil,BEC:nil,COL:0
X-UUID: e82b86c15ff2420ea0a64e7ba729e47d-20220804
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 521824539; Thu, 04 Aug 2022 18:59:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 18:58:59 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Aug 2022 18:58:59 +0800
From: Chengci.Xu <chengci.xu@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chengci.Xu
	<chengci.xu@mediatek.com>
Subject: [PATCH 2/3] iommu/mediatek: Add enable IOMMU SMC command for INFRA master
Date: Thu, 4 Aug 2022 18:58:33 +0800
Message-ID: <20220804105834.626-3-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220804105834.626-1-chengci.xu@mediatek.com>
References: <20220804105834.626-1-chengci.xu@mediatek.com>
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
This patch depends on "Add enable IOMMU SMC command for MM master"[1].

Patch[1] enables SMI to help MM masters configure MM IOMMU in secure world.
Similarly, INFRA masters also need to configure INFRA IOMMU in secure world.
 
So please also accept this patch together with patch[1].

[1]https://lore.kernel.org/linux-mediatek/20220801021851.7169-4-chengci.xu@mediatek.com/
---
 drivers/iommu/mtk_iommu.c  | 34 ++++++++++++++++++++++++++--------
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7e363b1f24df..6fe780783ec8 100644
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
 
@@ -138,6 +140,7 @@
 #define PM_CLK_AO			BIT(15)
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 #define PGTABLE_PA_35_EN		BIT(17)
+#define CFG_IFA_MASTER_IN_ATF		BIT(18)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -554,14 +557,29 @@ static int mtk_iommu_config(struct mtk_iommu_data
 *data, struct device *dev,
 			else
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
 		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
-			peri_mmuen_msk = BIT(portid);
-			/* PCI dev has only one output id, enable the next writing bit for PCIe
 */
-			if (dev_is_pci(dev))
-				peri_mmuen_msk |= BIT(portid + 1);
-
-			peri_mmuen = enable ? peri_mmuen_msk : 0;
-			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
-						 peri_mmuen_msk, peri_mmuen);
+			if (MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
+				struct arm_smccc_res res;
+
+				portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+				arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
+					      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
+					      portid, enable, 0, 0, 0, 0, &res);
+				ret = (int)res.a0;
+
+			} else {
+				peri_mmuen_msk = BIT(portid);
+				/* PCI dev has only one output id,
+				 * enable the next writing bit for PCIe
+				 */
+				if (dev_is_pci(dev))
+					peri_mmuen_msk |= BIT(portid + 1);
+
+				peri_mmuen = enable ? peri_mmuen_msk : 0;
+				ret = regmap_update_bits(data->pericfg,
+							 PERICFG_IOMMU_1,
+							 peri_mmuen_msk,
+							 peri_mmuen);
+			}
 			if (ret)
 				dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
 					enable ? "enable" : "disable",
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index dfd8efca5e60..99f13b0e416d 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -13,6 +13,7 @@
 
 enum iommu_atf_cmd {
 	IOMMU_ATF_CMD_CONFIG_SMI_LARB,		/* For mm master to en/disable iommu */
+	IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,	/* For infra master en/disable iommu */
 	IOMMU_ATF_CMD_MAX,
 };
 
-- 
2.25.1

