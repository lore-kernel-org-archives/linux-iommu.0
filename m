Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEFC433ED
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2479920720
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="oPAmaX60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2479920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E4F26887FB;
	Sat, 11 Jul 2020 06:51:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XLe0qkIBwTls; Sat, 11 Jul 2020 06:51:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6DBCB887A3;
	Sat, 11 Jul 2020 06:51:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 688B9C088E;
	Sat, 11 Jul 2020 06:51:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E6AAC016F
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0DCF988810
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5lU-0zCBwPjr for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:51:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 33A0188334
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:51:22 +0000 (UTC)
X-UUID: 81a0309cd95e433e82dfbc2cf8b1ea1c-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=48/UK+pMJVg/hE9P6jxoR496KIP33DCqvBZjUELFnFg=; 
 b=oPAmaX60uRSx26koi+eRGvtrdI+O9tYh+fohIAUpS8g5CiG9sBtI1yPgpnyToFlTj72BrGIQao6O8WodtAzpm2SgN1+cv740IwhwMW3WmoHUnyc3w844WY0bqc/ec/DrJE4LlMJI+DuqsfhP/M4GlIiwdYMpg+ZTwD6fGYsOh7M=;
X-UUID: 81a0309cd95e433e82dfbc2cf8b1ea1c-20200711
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 1958700887; Sat, 11 Jul 2020 14:51:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:51:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:51:14 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 10/21] iommu/mediatek: Add device link for smi-common and m4u
Date: Sat, 11 Jul 2020 14:48:35 +0800
Message-ID: <20200711064846.16007-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: D5DE7707B4F1FBFA6AF98E44E3207208E81982E452159E1C3B004CE2ACFBD5282000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

In this patch, a M4U connects with several smi-larbs and their smi-common
always are the same, thus it adds the device-link once is enough.
And the devicelink only is needed while m4u has power-domain.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 26 +++++++++++++++++++++++++-
 drivers/iommu/mtk_iommu.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a6412d454e0b..931fdd19c8f3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -675,8 +675,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return larb_nr;
 
 	for (i = 0; i < larb_nr; i++) {
-		struct device_node *larbnode;
+		struct device_node *larbnode, *smicomm_node;
 		struct platform_device *plarbdev;
+		struct device_link *link;
 		u32 id;
 
 		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
@@ -701,6 +702,28 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 
 		component_match_add_release(dev, &match, release_of,
 					    compare_of, larbnode);
+
+		/*
+		 * Add link for smi-common and m4u once is ok. and the link is
+		 * only needed while m4u has power-domain.
+		 */
+		if (i || !pm_runtime_enabled(dev))
+			continue;
+
+		smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+		if (!smicomm_node) {
+			of_node_put(larbnode);
+			return -EINVAL;
+		}
+
+		plarbdev = of_find_device_by_node(smicomm_node);
+		of_node_put(smicomm_node);
+		data->smicomm_dev = &plarbdev->dev;
+
+		link = device_link_add(&plarbdev->dev, dev,
+				       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+		if (!link)
+			dev_err(dev, "Unable link %s.\n", plarbdev->name);
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -740,6 +763,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (iommu_present(&platform_bus_type))
 		bus_set_iommu(&platform_bus_type, NULL);
 
+	device_link_remove(data->smicomm_dev, &pdev->dev);
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
diff --git a/drivers/iommu/mtk_iommu.h b/drivers/iommu/mtk_iommu.h
index 1a087af50a4e..e965bcb169c0 100644
--- a/drivers/iommu/mtk_iommu.h
+++ b/drivers/iommu/mtk_iommu.h
@@ -66,6 +66,7 @@ struct mtk_iommu_data {
 
 	struct iommu_device		iommu;
 	const struct mtk_iommu_plat_data *plat_data;
+	struct device			*smicomm_dev;
 
 	struct list_head		list;
 	struct mtk_smi_larb_iommu	larb_imu[MTK_LARB_NR_MAX];
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
