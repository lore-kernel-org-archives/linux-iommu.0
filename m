Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698C06FC4
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:58 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYh-0001Qv-6P; Tue, 21 Mar 2023 09:41:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-005e94-UY; Tue, 21 Mar 2023 09:41:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-006hGK-7d; Tue, 21 Mar 2023 09:41:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Robin Murphy <robin.murphy@arm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 02/10] iommu/apple-dart: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:17 +0100
Message-Id: <20230321084125.337021-3-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZBtPdxjokN/P3yU0G57xGrh/1Tzerjv3QnDoCu8hR6g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2nyGYlPpqFjPDtwIB6sElzLYMOEYsdurT5N BQRpU1VTfyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltpwAKCRCPgPtYfRL+ TnhCB/4sUXIOu/AVp+b1TvMu7aMLmQkM/2lQGygPvhTQuZi6Q74VMFeJffI38rK8HqjhRPuekZu osnTbpXj1+L1jYoX7f22U74/e+xqbnRzwBXi/hfo/wUNfyhS5vxreGURnSyzgSN4V0xR59sqsda JRjvJmqShlFhnqZwaxCh4TRy29jUkePuvI+9Oy4JxUk5ALLovMtFG5IBUYrG8/HfRN6+s/hYg9X fwvZZFmCMYAVo6AaoC6ClfWQQbxXL4/x2xzy+ghEr/e2IMaEnejh8nkt9grixJ9Uv8eq6+aj/5v dl3Pg6G4XmHtt5XDjDjswu/6/VGAwbdqk0yZgZ2kbRIUQbUg
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
 drivers/iommu/apple-dart.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 06169d36eab8..8af64b57f048 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -1150,7 +1150,7 @@ static int apple_dart_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int apple_dart_remove(struct platform_device *pdev)
+static void apple_dart_remove(struct platform_device *pdev)
 {
 	struct apple_dart *dart = platform_get_drvdata(pdev);
 
@@ -1161,8 +1161,6 @@ static int apple_dart_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&dart->iommu);
 
 	clk_bulk_disable_unprepare(dart->num_clks, dart->clks);
-
-	return 0;
 }
 
 static const struct apple_dart_hw apple_dart_hw_t8103 = {
@@ -1296,7 +1294,7 @@ static struct platform_driver apple_dart_driver = {
 		.pm			= pm_sleep_ptr(&apple_dart_pm_ops),
 	},
 	.probe	= apple_dart_probe,
-	.remove	= apple_dart_remove,
+	.remove_new = apple_dart_remove,
 };
 
 module_platform_driver(apple_dart_driver);
-- 
2.39.2

