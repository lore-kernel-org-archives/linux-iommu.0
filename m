Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC896FAD
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:41 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYg-0001RK-6R; Tue, 21 Mar 2023 09:41:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYf-005e9V-HQ; Tue, 21 Mar 2023 09:41:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-006hGl-Og; Tue, 21 Mar 2023 09:41:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 09/10] iommu/omap: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:24 +0100
Message-Id: <20230321084125.337021-10-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=axPxNBr8spZsd3jzcW2DL5kYbw7bzD0D+7GaxWtGGAo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2vixfCSR/Q0RNsOV4k1xKzIP7I23niXRdB6 g45PQaIBDCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltrwAKCRCPgPtYfRL+ TjIeB/9ezt0atI+z7pUgke3sGpY0DgwPJwNBaC8r/rVazSoZaswlERj+m4jPm5N+8tADSe7DhTa CPeLcdpSJm0Ezn5sElPJCyJJ5fA/H3Nwc463G/Z39w2wdMrnTMMMcrYf2rWfITa/AhpFqdPcUXx TbrLG30PbxNoFivkaxYP2uRJn6uZHaS7j0K+gOK8sG9NFuVTt5SoPBpseK6musZs37ayz9wDvzM BtWcUhQDVyGZ6defIsxeATfFKLz4fAYTzs2txOCBS4o6nPqLdJMUEPPVqYYI/N2k2921EmMBDA2 43YPI7GdNQUmdfdqPQExStZukVFO3GJRgBqemxDfCQS+qEm7
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
 drivers/iommu/omap-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 3ab078112a7c..dec7cdcfbe9c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1257,7 +1257,7 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int omap_iommu_remove(struct platform_device *pdev)
+static void omap_iommu_remove(struct platform_device *pdev)
 {
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
@@ -1274,7 +1274,6 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	pm_runtime_disable(obj->dev);
 
 	dev_info(&pdev->dev, "%s removed\n", obj->name);
-	return 0;
 }
 
 static const struct dev_pm_ops omap_iommu_pm_ops = {
@@ -1295,7 +1294,7 @@ static const struct of_device_id omap_iommu_of_match[] = {
 
 static struct platform_driver omap_iommu_driver = {
 	.probe	= omap_iommu_probe,
-	.remove	= omap_iommu_remove,
+	.remove_new = omap_iommu_remove,
 	.driver	= {
 		.name	= "omap-iommu",
 		.pm	= &omap_iommu_pm_ops,
-- 
2.39.2

