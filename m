Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF86FAD
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:39 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYf-0001Qy-If; Tue, 21 Mar 2023 09:41:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-005e9G-IW; Tue, 21 Mar 2023 09:41:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-006hGV-Re; Tue, 21 Mar 2023 09:41:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 05/10] iommu/ipmmu-vmsa: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:20 +0100
Message-Id: <20230321084125.337021-6-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1626; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pnZlPUIlTGtuvrjvQAwMBJZ2GtM+icw8KG7NtBnO/tQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2q5VvEbZy9J/CU5+6QuVHSwymw5Ty2hfuWb jKyvPxYpW2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltqgAKCRCPgPtYfRL+ Tj8TB/0QEn0QDhD1kz38sgBi6oLFENTLRd+1ZhPBFnZ38uxOxa55zcpIIYG7Z4zGelwvNulES7P ESC5wAn3flvvd+Pz/B1k2IxVYe/OqyJn3ggn5diBy0klsYHMtJyG3S9W/K+aB2rz3+FfXV0oRLd 1is/vR59boEgW57GVinHL49XJOigUQgk9y9Hwh3gpc+8SBuGXq/rCL64uJKGVqL4FuUgwsJY1Jd 3x2cRFYa+XTiWUIjV/UJItrbm+L8pRAQ3MKB9A9FTjt7Rdor4Fvgnz3sG1jhg+9Lg8hMMvTniVE UspgdQUA3CVeOTSkZ5LoCR2Fv9abPhai6QSm6tfPC8z8yWmk
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
 drivers/iommu/ipmmu-vmsa.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index bdf1a4e5eae0..813dbd1f7ba0 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1073,7 +1073,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ipmmu_remove(struct platform_device *pdev)
+static void ipmmu_remove(struct platform_device *pdev)
 {
 	struct ipmmu_vmsa_device *mmu = platform_get_drvdata(pdev);
 
@@ -1083,8 +1083,6 @@ static int ipmmu_remove(struct platform_device *pdev)
 	arm_iommu_release_mapping(mmu->mapping);
 
 	ipmmu_device_reset(mmu);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -1131,6 +1129,6 @@ static struct platform_driver ipmmu_driver = {
 		.pm = DEV_PM_OPS,
 	},
 	.probe = ipmmu_probe,
-	.remove	= ipmmu_remove,
+	.remove_new = ipmmu_remove,
 };
 builtin_platform_driver(ipmmu_driver);
-- 
2.39.2

