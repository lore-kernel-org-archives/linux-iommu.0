Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DADEC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:23:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302292220F
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302292220F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id CDB3C20C41;
	Mon, 11 Jan 2021 11:23:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9AkV3flp3KcD; Mon, 11 Jan 2021 11:23:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 177B3214E6;
	Mon, 11 Jan 2021 11:23:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04FDBC0893;
	Mon, 11 Jan 2021 11:23:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 083D8C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:23:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EC14385F19
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LwFkCX_BRROG for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 11:23:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2183685F0A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:23:39 +0000 (UTC)
X-UUID: 47bfbcef09be4534bfd2b8fb72d7e07a-20210111
X-UUID: 47bfbcef09be4534bfd2b8fb72d7e07a-20210111
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 261536895; Mon, 11 Jan 2021 19:23:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:23:36 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:23:35 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 27/33] iommu/mediatek: Add get_domain_id from
 dev->dma_range_map
Date: Mon, 11 Jan 2021 19:19:08 +0800
Message-ID: <20210111111914.22211-28-yong.wu@mediatek.com>
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

Add a new interface _get_domain_id from dev->dma_range_map,
The iommu consumer device will use dma-ranges in dtsi node to indicate
its dma address region requirement. In this iommu driver, we will get
the requirement and decide which iova domain it should locate.

In the lastest SoC, there will be several iova-regions(domains), we will
compare and calculate which domain is right. If the start/end of device
requirement equal some region. it is best fit of course. If it is inside
some region, it is also ok. the iova requirement of a device should not
be inside two or more regions.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 6875ca1225f0..8fc17158bc28 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-iommu.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -314,6 +315,36 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int mtk_iommu_get_domain_id(struct device *dev,
+				   const struct mtk_iommu_plat_data *plat_data)
+{
+	const struct mtk_iommu_iova_region *rgn = plat_data->iova_region;
+	const struct bus_dma_region *dma_rgn = dev->dma_range_map;
+	int i, candidate = -1;
+	dma_addr_t dma_end;
+
+	if (!dma_rgn || plat_data->iova_region_nr == 1)
+		return 0;
+
+	dma_end = dma_rgn->dma_start + dma_rgn->size - 1;
+	for (i = 0; i < plat_data->iova_region_nr; i++, rgn++) {
+		/* Best fit. */
+		if (dma_rgn->dma_start == rgn->iova_base &&
+		    dma_end == rgn->iova_base + rgn->size - 1)
+			return i;
+		/* ok if it is inside this region. */
+		if (dma_rgn->dma_start >= rgn->iova_base &&
+		    dma_end < rgn->iova_base + rgn->size)
+			candidate = i;
+	}
+
+	if (candidate >= 0)
+		return candidate;
+	dev_err(dev, "Can NOT find the iommu domain id(%pad 0x%llx).\n",
+		&dma_rgn->dma_start, dma_rgn->size);
+	return -EINVAL;
+}
+
 static void mtk_iommu_config(struct mtk_iommu_data *data,
 			     struct device *dev, bool enable)
 {
@@ -400,11 +431,15 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 	struct device *m4udev = data->dev;
-	int ret;
+	int ret, domid;
 
 	if (!data)
 		return -ENODEV;
 
+	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
+	if (domid < 0)
+		return domid;
+
 	if (!dom->data) {
 		if (mtk_iommu_domain_finalise(dom, data))
 			return -ENODEV;
@@ -534,10 +569,15 @@ static void mtk_iommu_release_device(struct device *dev)
 static struct iommu_group *mtk_iommu_device_group(struct device *dev)
 {
 	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
+	int domid;
 
 	if (!data)
 		return ERR_PTR(-ENODEV);
 
+	domid = mtk_iommu_get_domain_id(dev, data->plat_data);
+	if (domid < 0)
+		return ERR_PTR(domid);
+
 	/* All the client devices are in the same m4u iommu-group */
 	if (!data->m4u_group) {
 		data->m4u_group = iommu_group_alloc();
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
