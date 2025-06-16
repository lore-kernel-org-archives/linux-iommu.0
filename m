Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267332980AF
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750042613; cv=none; b=WKnX3pAllXfi0IGIjpKBU37y2hDc/9xSTuIvdAYdqUwoqwG6flwkaZMYwpC++uf3f1mJQs0BP4fyL4zS1gJY02mfKf+qdwn6krM4x4yLLPajhCIdpC2HbWGPi8RKPpl7/0HSr788j8jEiYd6yfKL2l7JP05NmU1TNf6vDFupiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750042613; c=relaxed/simple;
	bh=TA/gyKjnaXgl4IS9+8BDKYfndBjVaP6o4QjpD2362hs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CDnzNaM3q2qgqt572dp3YlcbHvTKQU7W36QQ2GMuqtd+4tc1Zw1E6pcYF3kbGeqXC+kysWaWc65E+Dw8ug8oVNLBttaPWujqntPanLid329wBkkjQDNm/X6UprEoq+yJ8wlLCbtV4p6wybCZubaua4qpL/1Eo1MSmBvwVLi2zW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Rb4AW6wp; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rb4AW6wp"
X-UUID: 8a45f1cc4a5d11f0b33aeb1e7f16c2b6-20250616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fnbnrgrBEXGiqecmfaw/rGa+oLa4978wkdeJQzh6awQ=;
	b=Rb4AW6wp9ZtegD9s+j/Tymf+EgkbFAm+qDxI2/QI6YZrbsneQ31LFXVU8SQSC4RQw7SI31tJYzk34yUCi3+t80NZN6Ig7DMqqVfT/rsVWGN1fyUqaMX9V/obuzOJsImpyKe418bHtvat9HGfn0WAUGWMPmyHlhtdHe4j0TgtMc4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.3,REQID:a620c244-6e41-4fcc-ab01-dd3a511767bf,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:09905cf,CLOUDID:903d7d28-fdd2-4021-9c0c-83548fdcf243,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8a45f1cc4a5d11f0b33aeb1e7f16c2b6-20250616
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2030601454; Mon, 16 Jun 2025 10:56:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 16 Jun 2025 10:56:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 16 Jun 2025 10:56:43 +0800
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
Subject: [RFC PATCH 6/8] iommu/arm-smmu-v3: mediatek: Add wrapper handle for IRQ
Date: Mon, 16 Jun 2025 10:56:12 +0800
Message-ID: <20250616025628.25454-7-xueqi.zhang@mediatek.com>
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

Mediatek SMMU interrupt is low level active rather than the standard
edge.Process Mediatek SMMU wrapper interrupt and dump detailed
information when a translation fault occurs.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-mediatek.c    | 349 +++++++++++++++++-
 1 file changed, 347 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
index 48290366e596..448166c1ca64 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
@@ -14,7 +14,122 @@
 
 #include "arm-smmu-v3.h"
 
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+#include <linux/arm-smccc.h>
+
+#define SMMUWP_GLB_CTL0			(0x0)
+#define CTL0_STD_AXI_MODE_DIS		BIT(0)
+#define CTL0_MON_DIS			BIT(1)
+#define CTL0_DCM_EN			BIT(2)
+#define CTL0_WRAPPER_CK_AOEN		BIT(3)
+#define CTL0_AUTO_AXDOMAIN_EN		BIT(4)
+#define CTL0_IRQ_BUSY_EN		BIT(5)
+#define CTL0_ABT_CNT_CLR		BIT(6)
+#define CTL0_LEGACY_AXCACHE		BIT(7)
+#define CTL0_COMMIT_DIS			BIT(8)
+#define CTL0_AUTO_SLP_DIS		BIT(9)
+#define CTL0_STTSL_DIS			BIT(10)
+#define CTL0_CFG_TAB_DCM_EN		BIT(11)
+#define CTL0_CPU_PARTID_DIS		BIT(14)
+/* New bits of SMMU wrapper extension */
+#define CTL0_TCU2SLC_DCM_EN		BIT(18)
+#define CTL0_APB_DCM_EN			BIT(19)
+#define CTL0_DVM_DCM_EN			BIT(20)
+#define CTL0_CPU_TBU_PARTID_DIS		BIT(21)
+
+#define SMMUWP_IRQ_STA			(0x80)
+#define STA_TCU_GLB_INTR		BIT(0)
+#define STA_TCU_CMD_SYNC_INTR		BIT(1)
+#define STA_TCU_EVTQ_INTR		BIT(2)
+#define STA_TCU_PRI_INTR		BIT(3)
+#define STA_TCU_PMU_INTR		BIT(4)
+#define STA_TCU_RAS_CRI			BIT(5)
+#define STA_TCU_RAS_ERI			BIT(6)
+#define STA_TCU_RAS_FHI			BIT(7)
+
+#define SMMUWP_IRQ_ACK			(0x84)
+
+#define SMMUWP_IRQ_ACK_CNT		(0x88)
+#define IRQ_ACK_CNT_MSK			GENMASK(7, 0)
+
+/* SMMU non-secure interrupt pending count register, count 20 */
+#define SMMUWP_IRQ_CNTx(cnt)		(0x100 + 0x4 * (cnt))
+
+#define SMMU_TCU_CTL1_AXSLC		(0x204)
+#define AXSLC_BIT_FIELD			GENMASK(8, 4)
+#define AXSLC_CACHE			BIT(5)
+#define AXSLC_ALLOCATE			BIT(6)
+#define AXSLC_SPECULATIVE		BIT(7)
+#define AXSLC_SET			(AXSLC_CACHE | AXSLC_ALLOCATE | AXSLC_SPECULATIVE)
+#define SLC_SB_ONLY_EN			BIT(1)
+
+/* SMMU TBUx read translation fault monitor0 */
+#define SMMUWP_TBUx_RTFM0(tbu)		(0x380 + 0x100 * (tbu))
+#define RTFM0_FAULT_AXI_ID		GENMASK_ULL(19, 0)
+#define RTFM0_FAULT_DET			BIT(31)
+
+/* SMMU TBUx read translation fault monitor1 */
+#define SMMUWP_TBUx_RTFM1(tbu)		(0x384 + 0x100 * (tbu))
+#define RTFM1_FAULT_VA_35_32		GENMASK_ULL(3, 0)
+#define RTFM1_FAULT_VA_31_12		GENMASK_ULL(31, 12)
+
+/* SMMU TBUx read translation fault monitor2 */
+#define SMMUWP_TBUx_RTFM2(tbu)		(0x388 + 0x100 * (tbu))
+#define RTFM2_FAULT_SID			GENMASK_ULL(7, 0)
+#define RTFM2_FAULT_SSID		GENMASK_ULL(15, 8)
+#define RTFM2_FAULT_SSIDV		BIT(16)
+#define RTFM2_FAULT_SECSID		BIT(17)
+
+/* SMMU TBUx write translation fault monitor0 */
+#define SMMUWP_TBUx_WTFM0(tbu)		(0x390 + 0x100 * (tbu))
+#define WTFM0_FAULT_AXI_ID		GENMASK_ULL(19, 0)
+#define WTFM0_FAULT_DET			BIT(31)
+
+/* SMMU TBUx write translation fault monitor1 */
+#define SMMUWP_TBUx_WTFM1(tbu)		(0x394 + 0x100 * (tbu))
+#define WTFM1_FAULT_VA_35_32		GENMASK_ULL(3, 0)
+#define WTFM1_FAULT_VA_31_12		GENMASK_ULL(31, 12)
+
+/* SMMU TBUx write translation fault monitor2 */
+#define SMMUWP_TBUx_WTFM2(tbu)		(0x398 + 0x100 * (tbu))
+#define WTFM2_FAULT_SID			GENMASK_ULL(7, 0)
+#define WTFM2_FAULT_SSID		GENMASK_ULL(15, 8)
+#define WTFM2_FAULT_SSIDV		BIT(16)
+#define WTFM2_FAULT_SECSID		BIT(17)
+
+/* SMMU TBU Manual OG Control High Register0 */
+#define SMMUWP_TBU0_MOGH0		(0x3b4)
+#define MOGH_EN				BIT(29)
+#define MOGH_RW				BIT(28)
+
+/* SMMU translation fault TBUx */
+#define SMMUWP_TF_TBU_MSK		GENMASK(26, 24)
+#define SMMUWP_TF_TBU(tbu)		FIELD_PREP(SMMUWP_TF_TBU_MSK, tbu)
+
+#define SMMU_FAULT_RS_INTERVAL		DEFAULT_RATELIMIT_INTERVAL
+#define SMMU_FAULT_RS_BURST		(1)
+
+#define STRSEC(sec)			((sec) ? "SECURE" : "NORMAL")
+
+#define WP_OFFSET_MT8196		0x1e0000
+
 #define MTK_SMMU_COMP_STR_LEN		64
+
+#define MTK_SMMU_FAULT_IOVA(low, high) ((low) | (((u64)(high) & 0xf) << 32))
+
+#define SMMU_SUCCESS			(0)
+#define SMMU_ID_ERR			(1)
+#define SMMU_CMD_ERR			(2)
+#define SMMU_PARA_INVALID		(3)
+#define SMMU_NEED			(4)
+#define SMMU_NONEED			(5)
+
+/* plat flags: */
+#define SMMU_SKIP_PM_CLK		BIT(0)
+#define SMMU_CLK_AO_EN			BIT(1)
+#define SMMU_AXSLC_EN			BIT(2)
+#define SMMU_DIS_CPU_PARTID		BIT(3)
+#define SMMU_DIS_CPU_TBU_PARTID		BIT(4)
 #define SMMU_REQUIRE_PARENT		BIT(5)
 #define MTK_SMMU_HAS_FLAG(pdata, _x)    (!!(((pdata)->flags) & (_x)))
 
@@ -25,22 +140,30 @@ enum mtk_smmu_type {
 };
 
 struct mtk_smmu_v3_plat {
+	u32			wp_offset;
+	unsigned int		tbu_cnt;
 	enum mtk_smmu_type	smmu_type;
 	u32			flags;
 };
 
 struct mtk_smmu_v3 {
 	struct arm_smmu_device	smmu;
+	void __iomem			*wp_base;
 	const struct mtk_smmu_v3_plat *plat_data;
 };
 
 static const struct mtk_smmu_v3_plat mt8196_data_mm = {
+	.wp_offset		= WP_OFFSET_MT8196,
+	.tbu_cnt		= 3,
 	.smmu_type		= MTK_SMMU_MM,
+	.flags			= SMMU_AXSLC_EN,
 };
 
 static const struct mtk_smmu_v3_plat mt8196_data_apu = {
+	.wp_offset		= WP_OFFSET_MT8196,
+	.tbu_cnt		= 3,
 	.smmu_type		= MTK_SMMU_APU,
-	.flags			= SMMU_REQUIRE_PARENT,
+	.flags			= SMMU_AXSLC_EN | SMMU_REQUIRE_PARENT,
 };
 
 struct mtk_smmu_v3_of_device_data {
@@ -70,17 +193,228 @@ static const struct mtk_smmu_v3_plat *mtk_smmu_v3_get_plat_data(const struct dev
 	return NULL;
 }
 
+static inline void smmu_write_field(void __iomem *base,
+				    unsigned int reg,
+				    unsigned int mask,
+				    unsigned int val)
+{
+	unsigned int regval;
+
+	regval = readl_relaxed(base + reg);
+	regval = (regval & (~mask)) | val;
+	writel_relaxed(regval, base + reg);
+}
+
+static void smmu_init_wpcfg(struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmu_v3 = to_mtk_smmu_v3(smmu);
+	void __iomem *wp_base = mtk_smmu_v3->wp_base;
+
+	/* DCM basic setting */
+	smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_DCM_EN, CTL0_DCM_EN);
+	smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_CFG_TAB_DCM_EN,
+			 CTL0_CFG_TAB_DCM_EN);
+
+	smmu_write_field(wp_base, SMMUWP_GLB_CTL0,
+			 CTL0_TCU2SLC_DCM_EN | CTL0_APB_DCM_EN |
+			 CTL0_DVM_DCM_EN,
+			 CTL0_TCU2SLC_DCM_EN | CTL0_APB_DCM_EN |
+			 CTL0_DVM_DCM_EN);
+
+	if (MTK_SMMU_HAS_FLAG(mtk_smmu_v3->plat_data, SMMU_DIS_CPU_PARTID))
+		smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_CPU_PARTID_DIS,
+				 CTL0_CPU_PARTID_DIS);
+	if (MTK_SMMU_HAS_FLAG(mtk_smmu_v3->plat_data, SMMU_DIS_CPU_TBU_PARTID))
+		smmu_write_field(wp_base, SMMUWP_GLB_CTL0,
+				 CTL0_CPU_TBU_PARTID_DIS, CTL0_CPU_TBU_PARTID_DIS);
+
+	/* Used for MM_SMMMU read command overtaking */
+	if (mtk_smmu_v3->plat_data->smmu_type == MTK_SMMU_MM)
+		smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_STD_AXI_MODE_DIS,
+				 CTL0_STD_AXI_MODE_DIS);
+
+	/* Set AXSLC */
+	if (MTK_SMMU_HAS_FLAG(mtk_smmu_v3->plat_data, SMMU_AXSLC_EN)) {
+		smmu_write_field(wp_base, SMMUWP_GLB_CTL0,
+				 CTL0_STD_AXI_MODE_DIS, CTL0_STD_AXI_MODE_DIS);
+		smmu_write_field(wp_base, SMMU_TCU_CTL1_AXSLC, AXSLC_BIT_FIELD,
+				 AXSLC_SET);
+		smmu_write_field(wp_base, SMMU_TCU_CTL1_AXSLC, SLC_SB_ONLY_EN,
+				 SLC_SB_ONLY_EN);
+	}
+}
+
+/* Consume SMMU wrapper interrupt bit */
+static unsigned int
+smmuwp_consume_intr(void __iomem *wp_base, unsigned int irq_bit)
+{
+	unsigned int pend_cnt;
+
+	pend_cnt = readl_relaxed(wp_base + SMMUWP_IRQ_CNTx(__ffs(irq_bit)));
+	smmu_write_field(wp_base, SMMUWP_IRQ_ACK_CNT, IRQ_ACK_CNT_MSK, pend_cnt);
+	writel_relaxed(irq_bit, wp_base + SMMUWP_IRQ_ACK);
+
+	return pend_cnt;
+}
+
+/* clear translation fault mark */
+static void smmuwp_clear_tf(void __iomem *wp_base)
+{
+	smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_ABT_CNT_CLR, CTL0_ABT_CNT_CLR);
+	smmu_write_field(wp_base, SMMUWP_GLB_CTL0, CTL0_ABT_CNT_CLR, 0);
+}
+
+static u32 smmuwp_fault_id(u32 axi_id, u32 tbu_id)
+{
+	u32 fault_id = (axi_id & ~SMMUWP_TF_TBU_MSK) | (SMMUWP_TF_TBU(tbu_id));
+
+	return fault_id;
+}
+
+/* Process TBU translation fault Monitor */
+static bool smmuwp_process_tf(struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmu_v3 = to_mtk_smmu_v3(smmu);
+	void __iomem *wp_base = mtk_smmu_v3->wp_base;
+	unsigned int sid, ssid, secsidv, ssidv;
+	u32 i, regval, va35_32, axiid, fault_id;
+	u64 fault_iova;
+	bool tf_det = false;
+
+	for (i = 0; i < mtk_smmu_v3->plat_data->tbu_cnt; i++) {
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_RTFM0(i));
+		if (!(regval & RTFM0_FAULT_DET))
+			goto write;
+
+		tf_det = true;
+		axiid = FIELD_GET(RTFM0_FAULT_AXI_ID, regval);
+		fault_id = smmuwp_fault_id(axiid, i);
+
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_RTFM1(i));
+		va35_32 = FIELD_GET(RTFM1_FAULT_VA_35_32, regval);
+		fault_iova = MTK_SMMU_FAULT_IOVA(regval & RTFM1_FAULT_VA_31_12, va35_32);
+
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_RTFM2(i));
+		sid = FIELD_GET(RTFM2_FAULT_SID, regval);
+		ssid = FIELD_GET(RTFM2_FAULT_SSID, regval);
+		ssidv = FIELD_GET(RTFM2_FAULT_SSIDV, regval);
+		secsidv = FIELD_GET(RTFM2_FAULT_SECSID, regval);
+		dev_err_ratelimited(smmu->dev, "TF read in %s world, TBU_id-%d-fault_id:0x%x(0x%x)\n",
+				    STRSEC(secsidv), i, fault_id, axiid);
+		dev_err_ratelimited(smmu->dev,
+				    "iova:0x%llx, sid:%d, ssid:%d, ssidv:%d, secsidv:%d\n",
+				    fault_iova, sid, ssid, ssidv, secsidv);
+
+write:
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_WTFM0(i));
+		if (!(regval & WTFM0_FAULT_DET))
+			continue;
+
+		tf_det = true;
+		axiid = FIELD_GET(WTFM0_FAULT_AXI_ID, regval);
+		fault_id = smmuwp_fault_id(axiid, i);
+
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_WTFM1(i));
+		va35_32 = FIELD_GET(WTFM1_FAULT_VA_35_32, regval);
+		fault_iova = MTK_SMMU_FAULT_IOVA(regval & RTFM1_FAULT_VA_31_12, va35_32);
+
+		regval = readl_relaxed(wp_base + SMMUWP_TBUx_WTFM2(i));
+		sid = FIELD_GET(WTFM2_FAULT_SID, regval);
+		ssid = FIELD_GET(WTFM2_FAULT_SSID, regval);
+		ssidv = FIELD_GET(WTFM2_FAULT_SSIDV, regval);
+		secsidv = FIELD_GET(WTFM2_FAULT_SECSID, regval);
+		dev_err_ratelimited(smmu->dev, "TF write in %s world, TBU_id-%d-fault_id:0x%x(0x%x)\n",
+				    STRSEC(secsidv), i, fault_id, axiid);
+		dev_err_ratelimited(smmu->dev,
+				    "iova:0x%llx, sid:%d, ssid:%d, ssidv:%d, secsidv:%d\n",
+				    fault_iova, sid, ssid, ssidv, secsidv);
+	}
+
+	if (!tf_det)
+		dev_info(smmu->dev, "No TF detected or has been cleaned\n");
+
+	return tf_det;
+}
+
+static int
+mtk_smmu_evt_handler(int irq, struct arm_smmu_device *smmu, u64 *evt, struct ratelimit_state *rs)
+{
+	if (!__ratelimit(rs)) {
+		smmuwp_clear_tf(smmu);
+		return 0;
+	}
+
+	smmuwp_process_tf(smmu);
+	smmuwp_clear_tf(smmu);
+
+	return 0;
+}
+
+/* Process SMMU wrapper interrupt */
+static int mtk_smmu_v3_smmuwp_irq_handler(int irq, struct arm_smmu_device *smmu)
+{
+	struct mtk_smmu_v3 *mtk_smmuv3 = to_mtk_smmu_v3(smmu);
+	void __iomem *wp_base = mtk_smmuv3->wp_base;
+	unsigned int irq_sta, pend_cnt;
+
+	irq_sta = readl_relaxed(wp_base + SMMUWP_IRQ_STA);
+	if (irq_sta == 0)
+		return 0;
+
+	if (irq_sta & STA_TCU_GLB_INTR) {
+		pend_cnt = smmuwp_consume_intr(wp_base, STA_TCU_GLB_INTR);
+		dev_dbg(smmu->dev,
+			"IRQ_STA:0x%x, Non-secure TCU global interrupt detected pending_cnt: %d\n",
+			irq_sta, pend_cnt);
+	}
+
+	if (irq_sta & STA_TCU_CMD_SYNC_INTR) {
+		pend_cnt = smmuwp_consume_intr(wp_base, STA_TCU_CMD_SYNC_INTR);
+		dev_dbg(smmu->dev,
+			"IRQ_STA:0x%x, Non-secure TCU CMD_SYNC interrupt detected pending_cnt: %d\n",
+			irq_sta, pend_cnt);
+	}
+
+	if (irq_sta & STA_TCU_EVTQ_INTR) {
+		pend_cnt = smmuwp_consume_intr(wp_base, STA_TCU_EVTQ_INTR);
+		dev_dbg(smmu->dev,
+			"IRQ_STA:0x%x, Non-secure TCU EVTQ interrupt detected pending_cnt: %d\n",
+			irq_sta, pend_cnt);
+	}
+
+	if (irq_sta & STA_TCU_PRI_INTR) {
+		pend_cnt = smmuwp_consume_intr(wp_base, STA_TCU_PRI_INTR);
+		dev_dbg(smmu->dev, "IRQ_STA:0x%x, TCU PRI interrupt detected pending_cnt: %d\n",
+			irq_sta, pend_cnt);
+	}
+
+	if (irq_sta & STA_TCU_PMU_INTR) {
+		pend_cnt = smmuwp_consume_intr(wp_base, STA_TCU_PMU_INTR);
+		dev_dbg(smmu->dev, "IRQ_STA:0x%x, TCU PMU interrupt detected pending_cnt: %d\n",
+			irq_sta, pend_cnt);
+	}
+
+	return 0;
+}
+
+static const struct arm_smmu_v3_impl mtk_smmu_v3_impl = {
+	.combined_irq_handle = mtk_smmu_v3_smmuwp_irq_handler,
+	.smmu_evt_handler = mtk_smmu_evt_handler,
+};
+
 struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
 {
 	struct mtk_smmu_v3 *mtk_smmu_v3;
 	struct device *dev = smmu->dev;
-	struct platform_device *parent_pdev;
+	struct platform_device *pdev = to_platform_device(dev), *parent_pdev;
+	struct resource *res, wp_res;
 	struct device_node *parent_node;
 
 	mtk_smmu_v3 = devm_krealloc(dev, smmu, sizeof(*mtk_smmu_v3), GFP_KERNEL);
 	if (!mtk_smmu_v3)
 		return ERR_PTR(-ENOMEM);
 
+	mtk_smmu_v3->smmu.impl = &mtk_smmu_v3_impl;
 	mtk_smmu_v3->plat_data = mtk_smmu_v3_get_plat_data(dev->of_node);
 	if (!mtk_smmu_v3->plat_data) {
 		dev_err(dev, "Get platform data fail\n");
@@ -111,5 +445,16 @@ struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
 		}
 	}
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return ERR_PTR(-EINVAL);
+	wp_res = DEFINE_RES_MEM(res->start + mtk_smmu_v3->plat_data->wp_offset,  SZ_4K);
+	mtk_smmu_v3->wp_base = devm_ioremap_resource(dev, &wp_res);
+	if (IS_ERR(mtk_smmu_v3->wp_base))
+		return mtk_smmu_v3->wp_base;
+
+	mtk_smmu_pm_get(dev, mtk_smmu_v3->plat_data->smmu_type);
+	smmu_init_wpcfg(smmu);
+	mtk_smmu_pm_put(dev, mtk_smmu_v3->plat_data->smmu_type);
 	return &mtk_smmu_v3->smmu;
 }
-- 
2.46.0

