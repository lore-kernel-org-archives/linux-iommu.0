Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FF7C4363A
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:35:07 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A2A20731
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 15:35:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A2A20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 89B602010C;
	Thu, 29 Oct 2020 15:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cFKvpAPnQFoG; Thu, 29 Oct 2020 15:35:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0047D227AA;
	Thu, 29 Oct 2020 15:35:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFA73C088B;
	Thu, 29 Oct 2020 15:35:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCB9CC0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ACFED86739
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:34:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tp2sCyXiuFn7 for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 15:34:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5D5AB862F4
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 15:34:58 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BA871063;
 Thu, 29 Oct 2020 08:34:57 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 23AB73F66E;
 Thu, 29 Oct 2020 08:34:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org
Subject: [PATCH] iommu: Clarify .of_xlate assumptions
Date: Thu, 29 Oct 2020 15:34:48 +0000
Message-Id: <e86ad0f733a9fe7b209bb7c5ac58760266b97414.1603985657.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: geert+renesas@glider.be, mripard@kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Yu Kuai <yukuai3@huawei.com>
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

A common idiom for .of_xlate is to use of_find_device_by_node() to
retrieve the relevant IOMMU instance data when translating IOMMU
specifiers for a client device. Although it's slightly roundabout,
this is simply looking up something we know exists - if it *were*
to return NULL, that would mean that no platform device is associated
with the given DT node, therefore the driver couldn't have probed
and called iommu_device_register() with the ops that .of_xlate was
called from in the first place. By construction, we can also assume
that the instance data for any registered IOMMU must be valid.

This isn't necessarily obvious at first glance, though, so add some
comments to document these assumptions in-place.

Suggested-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c |  7 ++++---
 drivers/iommu/exynos-iommu.c            | 15 ++++++---------
 drivers/iommu/ipmmu-vmsa.c              | 13 ++++++-------
 drivers/iommu/mtk_iommu.c               |  8 ++++----
 drivers/iommu/rockchip-iommu.c          |  5 ++++-
 drivers/iommu/sun50i-iommu.c            |  5 ++++-
 6 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index b30d6c966e2c..1dec28801eac 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -573,10 +573,11 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;
 	}
 
+	/*
+	 * We're simply retrieving the same platform device that called
+	 * iommu_device_register() when it probed, so it must be valid.
+	 */
 	iommu_pdev = of_find_device_by_node(args->np);
-	if (WARN_ON(!iommu_pdev))
-		return -EINVAL;
-
 	qcom_iommu = platform_get_drvdata(iommu_pdev);
 
 	/* make sure the asid specified in dt is valid, so we don't have
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index de324b4eedfe..73df251d5bcb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -630,6 +630,8 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	platform_set_drvdata(pdev, data);
+
 	iommu_device_set_ops(&data->iommu, &exynos_iommu_ops);
 	iommu_device_set_fwnode(&data->iommu, &dev->of_node->fwnode);
 
@@ -637,8 +639,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	platform_set_drvdata(pdev, data);
-
 	__sysmmu_get_version(data);
 	if (PG_ENT_SHIFT < 0) {
 		if (MMU_MAJ_VER(data->version) < 5) {
@@ -1291,14 +1291,11 @@ static int exynos_iommu_of_xlate(struct device *dev,
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
 	struct sysmmu_drvdata *data, *entry;
 
-	if (!sysmmu)
-		return -ENODEV;
-
+	/*
+	 * We're simply retrieving the same platform device that called
+	 * iommu_device_register() when it probed, so it must be valid.
+	 */
 	data = platform_get_drvdata(sysmmu);
-	if (!data) {
-		put_device(&sysmmu->dev);
-		return -ENODEV;
-	}
 
 	if (!owner) {
 		owner = kzalloc(sizeof(*owner), GFP_KERNEL);
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0f18abda0e20..6be8dea03d97 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -725,11 +725,11 @@ static int ipmmu_init_platform_device(struct device *dev,
 				      struct of_phandle_args *args)
 {
 	struct platform_device *ipmmu_pdev;
-
+	/*
+	 * We're simply retrieving the same platform device that called
+	 * iommu_device_register() when it probed, so it must be valid.
+	 */
 	ipmmu_pdev = of_find_device_by_node(args->np);
-	if (!ipmmu_pdev)
-		return -ENODEV;
-
 	dev_iommu_priv_set(dev, platform_get_drvdata(ipmmu_pdev));
 
 	return 0;
@@ -1075,6 +1075,8 @@ static int ipmmu_probe(struct platform_device *pdev)
 		}
 	}
 
+	platform_set_drvdata(pdev, mmu);
+
 	/*
 	 * Register the IPMMU to the IOMMU subsystem in the following cases:
 	 * - R-Car Gen2 IPMMU (all devices registered)
@@ -1105,9 +1107,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 	 * an IOMMU, which only happens when bus_set_iommu() is called in
 	 * ipmmu_init() after the probe function returns.
 	 */
-
-	platform_set_drvdata(pdev, mmu);
-
 	return 0;
 }
 
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index c072cee532c2..46cba18189ec 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -520,11 +520,11 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
 	}
 
 	if (!dev_iommu_priv_get(dev)) {
-		/* Get the m4u device */
+		/*
+		 * We're simply retrieving the same platform device that called
+		 * iommu_device_register() when it probed, so it must be valid.
+		 */
 		m4updev = of_find_device_by_node(args->np);
-		if (WARN_ON(!m4updev))
-			return -EINVAL;
-
 		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
 	}
 
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e5d86b7177de..6a047d6963c0 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1096,7 +1096,10 @@ static int rk_iommu_of_xlate(struct device *dev,
 	data = devm_kzalloc(dma_dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
-
+	/*
+	 * We're simply retrieving the same platform device that called
+	 * iommu_device_register() when it probed, so it must be valid.
+	 */
 	iommu_dev = of_find_device_by_node(args->np);
 
 	data->iommu = platform_get_drvdata(iommu_dev);
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index ea6db1341916..c0b7a5175b83 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -763,7 +763,10 @@ static int sun50i_iommu_of_xlate(struct device *dev,
 {
 	struct platform_device *iommu_pdev = of_find_device_by_node(args->np);
 	unsigned id = args->args[0];
-
+	/*
+	 * We're simply retrieving the same platform device that called
+	 * iommu_device_register() when it probed, so it must be valid.
+	 */
 	dev_iommu_priv_set(dev, platform_get_drvdata(iommu_pdev));
 
 	return iommu_fwspec_add_ids(dev, &id, 1);
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
