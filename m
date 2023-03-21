Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE65F6FBF
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:43 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYi-0001R1-Cx; Tue, 21 Mar 2023 09:41:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYf-005e9S-9R; Tue, 21 Mar 2023 09:41:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-006hGh-Gk; Tue, 21 Mar 2023 09:41:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/10] iommu/mtk_iommu_v1: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:23 +0100
Message-Id: <20230321084125.337021-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
References: <20230321084125.337021-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1871; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bc1ivtReTOp/uOzDgtcAGj4TxntH44wGdZur6UUu7+Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2upuVTHwXXFld/iH+pFBW7wSrwQsv7CDul3 0RfxLJLfSeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltrgAKCRCPgPtYfRL+ ThbrCACs3l+Awc/bDwjnM3HaWbfvyX/oKUbXxxTuv2NhZ1WMbjxbQyize4vpjjm2fiYcwjxIRne my0NGdJRDHtBmWjVAWUIZmpj23+4Sw2SqrtnTOt/SPvRae5lIb0vakj+ONuEIe76sIzYTntgmPp 8dtTN7q15ejHpigkCgEl7PXFrKGr21H9nFZhope5CiPXEQy4/r83ALEkW4STp21r3n6LK2iM3xF iyapKGQk2I089qfRkAvio0spF1SM80fRcXdcNPttbObdTF4UIq+rXQM7lt3WgbOmj/CIBSsEg0d 2YilNfGik4jAm78uf2VddKYTe9nkTGNWrFswFDYqRmhjXvev
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iommu/mtk_iommu_v1.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 43e4c8f89e23..8a0a5e5d049f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -703,7 +703,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_iommu_v1_remove(struct platform_device *pdev)
+static void mtk_iommu_v1_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_v1_data *data = platform_get_drvdata(pdev);
 
@@ -713,7 +713,6 @@ static int mtk_iommu_v1_remove(struct platform_device *pdev)
 	clk_disable_unprepare(data->bclk);
 	devm_free_irq(&pdev->dev, data->irq, data);
 	component_master_del(&pdev->dev, &mtk_iommu_v1_com_ops);
-	return 0;
 }
 
 static int __maybe_unused mtk_iommu_v1_suspend(struct device *dev)
@@ -752,7 +751,7 @@ static const struct dev_pm_ops mtk_iommu_v1_pm_ops = {
 
 static struct platform_driver mtk_iommu_v1_driver = {
 	.probe	= mtk_iommu_v1_probe,
-	.remove	= mtk_iommu_v1_remove,
+	.remove_new = mtk_iommu_v1_remove,
 	.driver	= {
 		.name = "mtk-iommu-v1",
 		.of_match_table = mtk_iommu_v1_of_ids,
-- 
2.39.2

