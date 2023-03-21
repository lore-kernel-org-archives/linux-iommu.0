Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3DE6FC4
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:42:04 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYh-0001Qx-JC; Tue, 21 Mar 2023 09:41:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYe-005e9C-DI; Tue, 21 Mar 2023 09:41:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-006hGN-Er; Tue, 21 Mar 2023 09:41:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 03/10] iommu/arm-smmu-v3: Convert to platform remove callback returning void
Date: Tue, 21 Mar 2023 09:41:18 +0100
Message-Id: <20230321084125.337021-4-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TBwGhWJIvFbVY5yG03phNYmCUlO0KS/rRI72qzNttaw=; b=owGbwMvMwMXY3/A7olbonx/jabUkhhTJ3BXnFOcLi4c2ekRwSscxKGRcZpk1W8Oluu7VnyUFU uoVR951MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjAR03QOhvUF9lOenl50bkJk nF1y0KnC81YlWznCd90zEJyqwu9nLXE7sMAhvp5VhldudfgHfv2p6+J361Yz+cpKuUpasWwQWay dNeNa3IXwlbxZD92zo2or44vNfsxIuGEm9TKaS2umnf7tu3skn68+JZxtF56yfFbe5EVZqxzVzn 3U+rTgyfbzutb+9eJfIkwti6z+t5zM6IwzmGPUYtVS9a/3ZOzW9bJml2fHZjnm7OE/Za3637C3k 6FCTeNxjW67xvYTTiVaZ5l4jZ66q3w9+Vk+T9Tk0aSrsza7LF1R2Xrw634Vz8t7z63SUQmsf2zI at6vf+HXf8ZLgj2vrWedD2jZ47bIvSYxI2K93bYbqpIA
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f2425b0f0cd6..d99e1a8dbe44 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3844,7 +3844,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int arm_smmu_device_remove(struct platform_device *pdev)
+static void arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
@@ -3852,8 +3852,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
 	iopf_queue_free(smmu->evtq.iopf);
-
-	return 0;
 }
 
 static void arm_smmu_device_shutdown(struct platform_device *pdev)
@@ -3882,7 +3880,7 @@ static struct platform_driver arm_smmu_driver = {
 		.suppress_bind_attrs	= true,
 	},
 	.probe	= arm_smmu_device_probe,
-	.remove	= arm_smmu_device_remove,
+	.remove_new = arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
 module_driver(arm_smmu_driver, platform_driver_register,
-- 
2.39.2

