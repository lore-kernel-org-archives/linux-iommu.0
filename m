Return-Path: <SRS0=1kRO=GO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6DDC433E0
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:22:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD4C21E92
	for <iommu@archiver.kernel.org>; Mon, 11 Jan 2021 11:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD4C21E92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C10FE85F2D;
	Mon, 11 Jan 2021 11:22:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uNIjQrwsZqA; Mon, 11 Jan 2021 11:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2BF8D85C95;
	Mon, 11 Jan 2021 11:22:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19336C0893;
	Mon, 11 Jan 2021 11:22:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01A74C013A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E544785F0A
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7B53h1ZcEaI0 for <iommu@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 11:22:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1192085CA8
 for <iommu@lists.linux-foundation.org>; Mon, 11 Jan 2021 11:22:22 +0000 (UTC)
X-UUID: aa53b37d93f74f7fa8d200ae0b5abe1c-20210111
X-UUID: aa53b37d93f74f7fa8d200ae0b5abe1c-20210111
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1926634196; Mon, 11 Jan 2021 19:22:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 19:22:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 19:22:17 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 18/33] iommu/mediatek: Add device link for smi-common and
 m4u
Date: Mon, 11 Jan 2021 19:18:59 +0800
Message-ID: <20210111111914.22211-19-yong.wu@mediatek.com>
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

In the lastest SoC, M4U has its special power domain. thus, If the engine
begin to work, it should help enable the power for M4U firstly.
Currently if the engine work, it always enable the power/clocks for
smi-larbs/smi-common. This patch adds device_link for smi-common and M4U.
then, if smi-common power is enabled, the M4U power also is powered on
automatically.

Normally M4U connect with several smi-larbs and their smi-common always
are the same, In this patch it get smi-common dev from the last smi-larb
device, then add the device_link.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 27 ++++++++++++++++++++++++---
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 189165e7a2ab..0fe7c1617dc3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -20,6 +20,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -633,6 +634,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 {
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
+	struct device_node	*larbnode, *smicomm_node;
+	struct platform_device	*plarbdev;
+	struct device_link	*link;
 	struct resource         *res;
 	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
@@ -699,8 +703,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return larb_nr;
 
 	for (i = 0; i < larb_nr; i++) {
-		struct device_node *larbnode;
-		struct platform_device *plarbdev;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -727,12 +729,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 					    compare_of, larbnode);
 	}
 
+	/* Get smi-common dev from the last larb. */
+	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+	if (!smicomm_node)
+		return -EINVAL;
+
+	plarbdev = of_find_device_by_node(smicomm_node);
+	of_node_put(smicomm_node);
+	data->smicomm_dev = &plarbdev->dev;
+
+	link = device_link_add(data->smicomm_dev, dev,
+			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+	if (!link) {
+		dev_err(dev, "Unable link %s.\n", dev_name(data->smicomm_dev));
+		return -EINVAL;
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL,
 				     "mtk-iommu.%pa", &ioaddr);
 	if (ret)
-		return ret;
+		goto out_link_remove;
 
 	iommu_device_set_ops(&data->iommu, &mtk_iommu_ops);
 	iommu_device_set_fwnode(&data->iommu, &pdev->dev.of_node->fwnode);
@@ -762,6 +780,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	iommu_device_unregister(&data->iommu);
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
+out_link_remove:
+	device_link_remove(data->smicomm_dev, dev);
 	return ret;
 }
 
@@ -776,6 +796,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 		bus_set_iommu(&platform_bus_type, NULL);
 
 	clk_disable_unprepare(data->bclk);
+	device_link_remove(data->smicomm_dev, &pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index c1584dea66cb..a9b79e118f02 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -68,6 +68,7 @@ struct mtk_iommu_data {
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
+	struct device			*smicomm_dev;
 
 	struct dma_iommu_mapping	*mapping; /* For mtk_iommu_v1.c */
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
