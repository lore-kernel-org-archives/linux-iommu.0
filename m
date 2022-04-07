Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38606C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E7F8E40B72;
	Thu,  7 Apr 2022 08:02:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cIC-jbhUKgvp; Thu,  7 Apr 2022 08:02:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B255E40B76;
	Thu,  7 Apr 2022 08:02:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A8C6C001D;
	Thu,  7 Apr 2022 08:02:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5EF28C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:02:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C45783E7A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:02:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9PIA3juN00Dk for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:02:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF39883E1F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:02:02 +0000 (UTC)
X-UUID: 45a6a7b398d147989f85e03bf20f84e6-20220407
X-UUID: 45a6a7b398d147989f85e03bf20f84e6-20220407
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1063664014; Thu, 07 Apr 2022 16:01:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Thu, 7 Apr 2022 16:01:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:01:53 +0800
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v6 31/34] iommu/mediatek: Get the proper bankid for multi banks
Date: Thu, 7 Apr 2022 15:57:23 +0800
Message-ID: <20220407075726.17771-32-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
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
From: Yong Wu via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yong Wu <yong.wu@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

We preassign some ports in a special bank via the new defined
banks_portmsk. Put it in the plat_data means it is not expected to be
adjusted dynamically.

If the iommu id in the iommu consumer's dtsi node is inside this
banks_portmsk, then we switch it to this special iommu bank, and
initialise the IOMMU bank HW.

Each a bank has the independent pgtable(4GB iova range). Each a bank
is a independent iommu domain/group. Currently we don't separate different
iova ranges inside a bank.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 0828cff97625..d42b3d35a36e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -191,6 +191,7 @@ struct mtk_iommu_plat_data {
 
 	u8                  banks_num;
 	bool                banks_enable[MTK_IOMMU_BANK_MAX];
+	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];
 	unsigned char       larbid_remap[MTK_LARB_COM_MAX][MTK_LARB_SUBCOM_MAX];
 };
 
@@ -467,6 +468,30 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static unsigned int mtk_iommu_get_bank_id(struct device *dev,
+					  const struct mtk_iommu_plat_data *plat_data)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	unsigned int i, portmsk = 0, bankid = 0;
+
+	if (plat_data->banks_num == 1)
+		return bankid;
+
+	for (i = 0; i < fwspec->num_ids; i++)
+		portmsk |= BIT(MTK_M4U_TO_PORT(fwspec->ids[i]));
+
+	for (i = 0; i < plat_data->banks_num && i < MTK_IOMMU_BANK_MAX; i++) {
+		if (!plat_data->banks_enable[i])
+			continue;
+
+		if (portmsk & plat_data->banks_portmsk[i]) {
+			bankid = i;
+			break;
+		}
+	}
+	return bankid; /* default is 0 */
+}
+
 static int mtk_iommu_get_iova_region_id(struct device *dev,
 					const struct mtk_iommu_plat_data *plat_data)
 {
@@ -619,13 +644,14 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct list_head *hw_list = data->hw_list;
 	struct device *m4udev = data->dev;
 	struct mtk_iommu_bank_data *bank;
-	unsigned int bankid = 0;
+	unsigned int bankid;
 	int ret, region_id;
 
 	region_id = mtk_iommu_get_iova_region_id(dev, data->plat_data);
 	if (region_id < 0)
 		return region_id;
 
+	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
 	mutex_lock(&dom->mutex);
 	if (!dom->bank) {
 		/* Data is in the frstdata in sharing pgtable case. */
@@ -802,6 +828,7 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	struct mtk_iommu_data *c_data = dev_iommu_priv_get(dev), *data;
 	struct list_head *hw_list = c_data->hw_list;
 	struct iommu_group *group;
+	unsigned int bankid, groupid;
 	int regionid;
 
 	data = mtk_iommu_get_frst_data(hw_list);
@@ -812,12 +839,18 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 	if (regionid < 0)
 		return ERR_PTR(regionid);
 
+	bankid = mtk_iommu_get_bank_id(dev, data->plat_data);
 	mutex_lock(&data->mutex);
-	group = data->m4u_group[regionid];
+	/*
+	 * If the bank function is enabled, each a bank is a iommu group/domain.
+	 * otherwise, each a iova region is a iommu group/domain.
+	 */
+	groupid = bankid ? bankid : regionid;
+	group = data->m4u_group[groupid];
 	if (!group) {
 		group = iommu_group_alloc();
 		if (!IS_ERR(group))
-			data->m4u_group[regionid] = group;
+			data->m4u_group[groupid] = group;
 	} else {
 		iommu_group_ref_get(group);
 	}
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
