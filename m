Return-Path: <SRS0=ZsFK=UJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFF9C282DD
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 12:57:26 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E496206BA
	for <iommu@archiver.kernel.org>; Mon, 10 Jun 2019 12:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E496206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 66B40AA5;
	Mon, 10 Jun 2019 12:57:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E002FA64
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 12:57:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 210C77F8
	for <iommu@lists.linux-foundation.org>;
	Mon, 10 Jun 2019 12:57:23 +0000 (UTC)
X-UUID: 41fd390c4ad648da8f5726511c9ed376-20190610
X-UUID: 41fd390c4ad648da8f5726511c9ed376-20190610
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(mhqrelay.mediatek.com ESMTP with TLS)
	with ESMTP id 2045054028; Mon, 10 Jun 2019 20:57:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
	mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server
	(TLS) id 15.0.1395.4; Mon, 10 Jun 2019 20:57:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
	(172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
	Transport; Mon, 10 Jun 2019 20:57:11 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 10/12] iommu/mediatek: Use builtin_platform_driver
Date: Mon, 10 Jun 2019 20:55:11 +0800
Message-ID: <1560171313-28299-11-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
References: <1560171313-28299-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0B4467784B60C69D2AAF2FE86A910E03F9188BE23B7075579B2F4AFD6A43305B2000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
	Nicolas Boichat <drinkcat@chromium.org>,
	srv_heupstream@mediatek.com, Will Deacon <will.deacon@arm.com>,
	linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
	Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
	linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
	anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

MediaTek IOMMU should wait for smi larb which need wait for the
power domain(mtk-scpsys.c) and the multimedia ccf who both are
module init. Thus, subsys_initcall for MediaTek IOMMU is not helpful.
Switch to builtin_platform_driver.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c    | 31 +------------------------------
 drivers/iommu/mtk_iommu_v1.c | 24 +-----------------------
 2 files changed, 2 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7b70574..8459597 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -712,22 +712,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -808,23 +792,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = of_match_ptr(mtk_iommu_of_ids),
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init mtk_iommu_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&mtk_iommu_driver);
-	if (ret != 0)
-		pr_err("Failed to register MTK IOMMU driver\n");
-
-	return ret;
-}
-
-subsys_initcall(mtk_iommu_init)
+builtin_platform_driver(mtk_iommu_driver);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 845e20b..1c0fb82 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -650,22 +650,6 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
-{
-	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-
-	iommu_device_sysfs_remove(&data->iommu);
-	iommu_device_unregister(&data->iommu);
-
-	if (iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, NULL);
-
-	clk_disable_unprepare(data->bclk);
-	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
-	return 0;
-}
-
 static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
@@ -702,16 +686,10 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_of_ids,
 		.pm = &mtk_iommu_pm_ops,
 	}
 };
-
-static int __init m4u_init(void)
-{
-	return platform_driver_register(&mtk_iommu_driver);
-}
-subsys_initcall(m4u_init);
+builtin_platform_driver(mtk_iommu_driver);
-- 
1.9.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
