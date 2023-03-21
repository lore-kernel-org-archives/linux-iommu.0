Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC76FC4
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:44 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYg-0001RL-P0; Tue, 21 Mar 2023 09:41:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYf-005e9Y-J9; Tue, 21 Mar 2023 09:41:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-006hGp-UK; Tue, 21 Mar 2023 09:41:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 10/10] iommu/sprd: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:25 +0100
Message-Id: <20230321084125.337021-11-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1758; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=srz7jfx37dG4IR48VKUwFM7B7FWvzdOJFQJtpaY1fc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2w32pzaPSpQacCzUB9JqZc5nbLGX3OyLLrz 5u8i9wkP8+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltsAAKCRCPgPtYfRL+ Tj2xB/9LFKHs2UWltUMO+3gX3Uq3fGV1YFhdj39PKqB2vwYWGbosCjL8IAzXp6spx/lMpc/1XHB Qat+1VYVYs8L+FaDY4VZODG02K4QrPZj0UUbbEwyBOxnUVWx8UJwgW4k7YbEe0ok6oNFEXE2Zar R8YZuX70wKfcADDJ8xD0BTnUda6XdBOtHLp9CXXdy3SpYaeMnF4rrpOMn52KEQBkiN4vSzssPx2 hw9NShjcgrgLwmsCTGhtZEGdn/siWz84Ikok+g51mN9/DiYV7mu/7vZNgv8b95BiSfhF3pg2WFp 4xunqSkTX4AKDmZ7amIiojo6lZY2UvFFZM3rOm+TrLh4E4N0
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
 drivers/iommu/sprd-iommu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index ae94d74b73f4..907569e76d59 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -507,7 +507,7 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sprd_iommu_remove(struct platform_device *pdev)
+static void sprd_iommu_remove(struct platform_device *pdev)
 {
 	struct sprd_iommu_device *sdev = platform_get_drvdata(pdev);
 
@@ -519,8 +519,6 @@ static int sprd_iommu_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
-
-	return 0;
 }
 
 static struct platform_driver sprd_iommu_driver = {
@@ -530,7 +528,7 @@ static struct platform_driver sprd_iommu_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe	= sprd_iommu_probe,
-	.remove	= sprd_iommu_remove,
+	.remove_new = sprd_iommu_remove,
 };
 module_platform_driver(sprd_iommu_driver);
 
-- 
2.39.2

