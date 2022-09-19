Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC05A48
	for <iommu@lists.linux.dev>; Mon, 19 Sep 2022 08:26:51 +0000 (UTC)
X-UUID: fc8d88f722da4115b17d112e593aeb31-20220919
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LTZNciyBkNwy95/RoMBu6/ycwdKscgUxR6iM9crgHfo=;
	b=tZwORYVvEqHuJsDoWLAfwAdpea36F5JDMu9JSH7+P9K6QXd0j+ONNAxi4xwJ8zsSbNuf+EOPzCDA/epwdyqNwYyiJ5TcW2bgASiAw+NEsPCun/1SKBErCn6F7qKQhqHmgg45yCXQRTpGxssK9+czjJfYlcBvTh6B1lEc77Rv3Qk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:04cd6786-4cb9-4dfa-a14f-8ab29467be6a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:70
X-CID-INFO: VERSION:1.1.11,REQID:04cd6786-4cb9-4dfa-a14f-8ab29467be6a,IP:0,URL
	:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
	ON:quarantine,TS:70
X-CID-META: VersionHash:39a5ff1,CLOUDID:01f8d818-0314-4ae7-b2d1-7295be49255e,B
	ulkID:220919162645JIZQGETL,BulkQuantity:0,Recheck:0,SF:28|17|19|48|823|824
	,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL
	:0
X-UUID: fc8d88f722da4115b17d112e593aeb31-20220919
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chengci.xu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1804475167; Mon, 19 Sep 2022 16:26:42 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 19 Sep 2022 16:26:41 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 19 Sep 2022 16:26:40 +0800
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
Subject: [PATCH v3 2/3] iommu/mediatek: Add enable IOMMU SMC command for INFRA master
Date: Mon, 19 Sep 2022 16:26:10 +0800
Message-ID: <20220919082611.19824-3-chengci.xu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220919082611.19824-1-chengci.xu@mediatek.com>
References: <20220919082611.19824-1-chengci.xu@mediatek.com>
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
 drivers/iommu/mtk_iommu.c  | 21 +++++++++++++++++++--
 include/soc/mediatek/smi.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 552e4eb8c610..8b8a289bab2c 100644
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
@@ -553,7 +556,20 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
 			else
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
-		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+			   MTK_IOMMU_HAS_FLAG(data->plat_data, CFG_IFA_MASTER_IN_ATF)) {
+			struct arm_smccc_res res;
+
+			arm_smccc_smc(MTK_SIP_KERNEL_IOMMU_CONTROL,
+				      IOMMU_ATF_CMD_CONFIG_INFRA_IOMMU,
+				      portid, enable, 0, 0, 0, 0, &res);
+			if (res.a0 != 0) {
+				dev_err(dev, "%s iommu(%s) inframaster %d fail(%ld).\n",
+					enable ? "enable" : "disable",
+					dev_name(data->dev), portid, res.a0);
+				ret = -EINVAL;
+			}
+		} else {
 			peri_mmuen_msk = BIT(portid);
 			/* PCI dev has only one output id, enable the next writing bit for PCIe */
 			if (dev_is_pci(dev))
@@ -1213,7 +1229,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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

