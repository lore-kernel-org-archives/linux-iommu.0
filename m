Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C1C433DB
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:24:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE6321E92
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE6321E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B1A8D86752;
	Mon, 11 Jan 2021 11:24:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-kuUVFz9Y5V; Mon, 11 Jan 2021 11:24:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A0EF98674E;
	Mon, 11 Jan 2021 11:24:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DF2FC0893;
	Mon, 11 Jan 2021 11:24:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18DAAC013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 04C2E85F0A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 93S5_LJf2Jme for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 11:24:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1FB1585CA8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:24:01 +0000 (UTC)
X-UUID: 65a66b93666646dfbaea86ea01a371f5-20210111
X-UUID: 65a66b93666646dfbaea86ea01a371f5-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 608492469; Mon, 11 Jan 2021 19:24:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:58 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:58 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 30/33] iommu/mediatek: Support master use iova over 32bit
Date: Mon, 11 Jan 2021 19:19:11 +0800
Message-ID: <20210111111914.22211-31-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 linux-arm-kernel@lists.infradead.org
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

After extending v7s, our pagetable already support iova reach
16GB(34bit). the master got the iova via dma_alloc_attrs may reach
34bits, but its HW register still is 32bit. then how to set the
bit32/bit33 iova? this depend on a SMI larb setting(bank_sel).

we separate whole 16GB iova to four banks:
bank: 0: 0~4G; 1: 4~8G; 2: 8-12G; 3: 12-16G;
The bank number is (iova >> 32).

We will preassign which bank the larbs belong to. currently we don't
have a interface for master to adjust its bank number.

Each a bank is a iova_region which is a independent iommu-domain.
the iova range for each iommu-domain can't cross 4G.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org> #for memory part
---
 drivers/iommu/mtk_iommu.c  | 18 ++++++++++++------
 drivers/memory/mtk-smi.c   |  7 +++++++
 include/soc/mediatek/smi.h |  1 +
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 764dc0b93477..7403a7cb90ea 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -345,21 +345,27 @@ static int mtk_iommu_get_domain_id(struct device *dev,
 	return -EINVAL;
 }
 
-static void mtk_iommu_config(struct mtk_iommu_data *data,
-			     struct device *dev, bool enable)
+static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
+			     bool enable, unsigned int domid)
 {
 	struct mtk_smi_larb_iommu    *larb_mmu;
 	unsigned int                 larbid, portid;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	const struct mtk_iommu_iova_region *region;
 	int i;
 
 	for (i = 0; i < fwspec->num_ids; ++i) {
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
+
 		larb_mmu = &data->larb_imu[larbid];
 
-		dev_dbg(dev, "%s iommu port: %d\n",
-			enable ? "enable" : "disable", portid);
+		region = data->plat_data->iova_region + domid;
+		larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
+
+		dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
+			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+			portid, domid, larb_mmu->bank[portid]);
 
 		if (enable)
 			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
@@ -477,7 +483,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 		pm_runtime_put(m4udev);
 	}
 
-	mtk_iommu_config(data, dev, true);
+	mtk_iommu_config(data, dev, true, domid);
 	return 0;
 }
 
@@ -489,7 +495,7 @@ static void mtk_iommu_detach_device(struct iommu_domain *domain,
 	if (!data)
 		return;
 
-	mtk_iommu_config(data, dev, false);
+	mtk_iommu_config(data, dev, false, 0);
 }
 
 static int mtk_iommu_map(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index 89f92fa2afa5..fae61c5fbd70 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -44,6 +44,10 @@
 /* mt2712 */
 #define SMI_LARB_NONSEC_CON(id)	(0x380 + ((id) * 4))
 #define F_MMU_EN		BIT(0)
+#define BANK_SEL(id)		({			\
+	u32 _id = (id) & 0x3;				\
+	(_id << 8 | _id << 10 | _id << 12 | _id << 14);	\
+})
 
 /* SMI COMMON */
 #define SMI_BUS_SEL			0x220
@@ -88,6 +92,7 @@ struct mtk_smi_larb { /* larb: local arbiter */
 	const struct mtk_smi_larb_gen	*larb_gen;
 	int				larbid;
 	u32				*mmu;
+	unsigned char			*bank;
 };
 
 static int mtk_smi_clk_enable(const struct mtk_smi *smi)
@@ -154,6 +159,7 @@ mtk_smi_larb_bind(struct device *dev, struct device *master, void *data)
 		if (dev == larb_mmu[i].dev) {
 			larb->larbid = i;
 			larb->mmu = &larb_mmu[i].mmu;
+			larb->bank = larb_mmu[i].bank;
 			return 0;
 		}
 	}
@@ -172,6 +178,7 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
 	for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
 		reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
 		reg |= F_MMU_EN;
+		reg |= BANK_SEL(larb->bank[i]);
 		writel(reg, larb->base + SMI_LARB_NONSEC_CON(i));
 	}
 }
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 9371bf572ab8..4cf445dbbdaa 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -16,6 +16,7 @@
 struct mtk_smi_larb_iommu {
 	struct device *dev;
 	unsigned int   mmu;
+	unsigned char  bank[32];
 };
 
 /*
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
