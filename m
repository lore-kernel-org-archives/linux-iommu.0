Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB46FAD
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:43 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYi-0001R0-Cy; Tue, 21 Mar 2023 09:41:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-005e9N-Tp; Tue, 21 Mar 2023 09:41:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-006hGc-9C; Tue, 21 Mar 2023 09:41:28 +0100
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
Subject: [PATCH 07/10] iommu/mtk: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:22 +0100
Message-Id: <20230321084125.337021-8-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Zuh6b5S6TGy8h9T6DahIz0XMhGa3B1vkDHhUQ58S6CM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhTJ3DWGDC58D3kevv3hMNnD5+dtXe/X5Yd0YrvaZsTcl 9O8bb6lk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJfHzKwdDPVGjcFW679vr7 wt+fb/LPP96V5RkSuPVQ+kHfawk3t7nXR3Tu0sxsscy4qeOu/22GhMpVLx2mcoVwd/+e33aRLzn 451QphQVcjSj6XXdV+AZP7M3e7E36bJKR/FO33VpaP1k6p7lQc92mLlaGO1u/cAeU6M56o9u+a5 avRvDG8Ba/H1IGpz3NFivtmcOwLNkm/nz45qU+x35nzD/DKnHvmEuQ2pT86bnPlN6n5p97Fl3wu jlQojp0ddzaG/81O7fOSWY2v/VJ+9Sl+8YRu5f98LnW3uISLR8cm/ahbM2O12bPeR3dBPQkfdUf luasV9+z6+O8fQYbAo65xW/yts+xzPt9PbyM62p+peZRAA==
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
 drivers/iommu/mtk_iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d5a4955910ff..bcc7ccdb2d6e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1316,7 +1316,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mtk_iommu_remove(struct platform_device *pdev)
+static void mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
 	struct mtk_iommu_bank_data *bank;
@@ -1338,7 +1338,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 			continue;
 		devm_free_irq(&pdev->dev, bank->irq, bank);
 	}
-	return 0;
 }
 
 static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
@@ -1595,7 +1594,7 @@ static const struct of_device_id mtk_iommu_of_ids[] = {
 
 static struct platform_driver mtk_iommu_driver = {
 	.probe	= mtk_iommu_probe,
-	.remove	= mtk_iommu_remove,
+	.remove_new = mtk_iommu_remove,
 	.driver	= {
 		.name = "mtk-iommu",
 		.of_match_table = mtk_iommu_of_ids,
-- 
2.39.2

