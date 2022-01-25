Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F014C433F5
	for <iommu@archiver.kernel.org>; Tue, 25 Jan 2022 08:59:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EA6541786;
	Tue, 25 Jan 2022 08:59:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NOEWnVCMedgE; Tue, 25 Jan 2022 08:59:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0863F4177B;
	Tue, 25 Jan 2022 08:59:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA0CEC0031;
	Tue, 25 Jan 2022 08:59:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22730C002F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 100DB84CA5
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:59:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nCAMdGCukqEB for <iommu@lists.linux-foundation.org>;
 Tue, 25 Jan 2022 08:59:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0573182A0B
 for <iommu@lists.linux-foundation.org>; Tue, 25 Jan 2022 08:59:55 +0000 (UTC)
X-UUID: 4bbf0ff7e3934ecf9c0869d24ab044aa-20220125
X-UUID: 4bbf0ff7e3934ecf9c0869d24ab044aa-20220125
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 124532831; Tue, 25 Jan 2022 16:59:51 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 25 Jan 2022 16:59:49 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 16:59:48 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 21/35] iommu/mediatek: Add infra iommu support
Date: Tue, 25 Jan 2022 16:56:20 +0800
Message-ID: <20220125085634.17972-22-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220125085634.17972-1-yong.wu@mediatek.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
 linux-arm-kernel@lists.infradead.org, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
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

The infra iommu enable bits in mt8195 is in the pericfg register segment,
use regmap to update it.

If infra iommu master translation fault, It doesn't have the larbid/portid,
thus print out the whole register value.

Since regmap_update_bits may fail, add return value for mtk_iommu_config.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 36 +++++++++++++++++++++++++++++-------
 drivers/iommu/mtk_iommu.h |  2 ++
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 531f4750c721..7176c212037f 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -112,6 +112,8 @@
 
 #define MTK_PROTECT_PA_ALIGN			256
 
+#define PERICFG_IOMMU_1				0x714
+
 #define HAS_4GB_MODE			BIT(0)
 /* HW will use the EMI clock if there isn't the "bclk". */
 #define HAS_BCLK			BIT(1)
@@ -343,8 +345,8 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
 		dev_err_ratelimited(
 			data->dev,
-			"fault type=0x%x iova=0x%llx pa=0x%llx larb=%d port=%d layer=%d %s\n",
-			int_state, fault_iova, fault_pa, fault_larb, fault_port,
+			"fault type=0x%x iova=0x%llx pa=0x%llx master=0x%x(larb=%d port=%d) layer=%d %s\n",
+			int_state, fault_iova, fault_pa, regval, fault_larb, fault_port,
 			layer, write ? "write" : "read");
 	}
 
@@ -388,14 +390,15 @@ static int mtk_iommu_get_domain_id(struct device *dev,
 	return -EINVAL;
 }
 
-static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
-			     bool enable, unsigned int domid)
+static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
+			    bool enable, unsigned int domid)
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	const struct mtk_iommu_iova_region *region;
-	int i;
+	u32 peri_mmuen, peri_mmuen_msk;
+	int i, ret = 0;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
@@ -415,8 +418,19 @@ static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
 			else
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+			peri_mmuen_msk = BIT(portid);
+			peri_mmuen = enable ? peri_mmuen_msk : 0;
+
+			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
+						 peri_mmuen_msk, peri_mmuen);
+			if (ret)
+				dev_err(dev, "%s iommu(%s) inframaster 0x%x fail(%d).\n",
+					enable ? "enable" : "disable",
+					dev_name(data->dev), peri_mmuen_msk, ret);
 		}
 	}
+	return ret;
 }
 
 static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
@@ -531,8 +545,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	}
 	mutex_unlock(&data->mutex);
 
-	mtk_iommu_config(data, dev, true, domid);
-	return 0;
+	return mtk_iommu_config(data, dev, true, domid);
 
 data_unlock:
 	mutex_unlock(&data->mutex);
@@ -956,6 +969,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
 		if (ret)
 			goto out_runtime_disable;
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   data->plat_data->pericfg_comp_str) {
+		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
+		if (IS_ERR(infracfg)) {
+			ret = PTR_ERR(infracfg);
+			goto out_runtime_disable;
+		}
+
+		data->pericfg = infracfg;
 	}
 
 	platform_set_drvdata(pdev, data);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 82c51a034e6b..04e5e5e7fd62 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -55,6 +55,7 @@ struct mtk_iommu_plat_data {
 	u32                 flags;
 	u32                 inv_sel_reg;
 
+	char					*pericfg_comp_str;
 	struct list_head			*hw_list;
 	unsigned int				iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
@@ -80,6 +81,7 @@ struct mtk_iommu_data {
 	struct device			*smicomm_dev;
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
+	struct regmap			*pericfg;
 
 	struct mutex			mutex; /* Protect m4u_group/m4u_dom above */
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
