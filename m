Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [85.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6216FC4
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 08:41:55 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYh-0001Qu-1a; Tue, 21 Mar 2023 09:41:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-005e90-OG; Tue, 21 Mar 2023 09:41:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1peXYd-006hGH-0V; Tue, 21 Mar 2023 09:41:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Jon Nettleton <jon@solid-run.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH 01/10] iommu/arm-smmu: Drop if with an always false condition
Date: Tue, 21 Mar 2023 09:41:16 +0100
Message-Id: <20230321084125.337021-2-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uxAPAufpJWcGUVj4TzPQgE6O50+Gau94nmx++9GZ+bw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkGW2mmwwXih1cW8yfuHuobdtzU7ky93VYVDvCS QNP6LFkNxOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZBltpgAKCRCPgPtYfRL+ TsSnB/9/SHKhydXl87XCjrH76+61OILZtTHsV/1yi31PVuJHNc/KBlmvk8QjR43r3dtAQXY6JJo mUeJKY6xJh952eYGfwn+OqSnURtARwwsB53vJR7KdBxUBJSQmDMEWTHsEe+h2icYk09k1VotNz8 qOqox7DHmNcJNYvH/iXPc+xJ2/dWHlzrcDhuPpelKAzkFds+V6lACFtjyIuusfk5rqbe9q1uXCU e0ytIBLvwF/SFiGjtLnc3n/tOGuwUKSWc3TzHpyMimYCRC37q7mdeohmwtN40yegKclzNX72AmZ CFtNpvzGsQvjFnJ0cs7L7Nk2wWEqjFRkgawknZSEAxuqPZqq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux.dev

The remove and shutdown callback are only called after probe completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so smmu is never NULL. Other functions in this
driver also don't check for smmu being non-NULL before using it.

Also note that returning an error code from a remove callback doesn't
result in the device staying bound. It's still removed and devm allocated
resources are freed (among others *smmu and the register mapping). So
after an early exit to iommu device stayed around and using it probably
oopses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ff7a72cf377..f4a36533ae47 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2195,9 +2195,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return;
-
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
@@ -2218,9 +2215,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return -ENODEV;
-
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.39.2

