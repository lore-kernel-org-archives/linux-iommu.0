Return-Path: <SRS0=a2WC=ZN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85844C43215
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1E220C01
	for <iommu@archiver.kernel.org>; Thu, 21 Nov 2019 11:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rq6UzZLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1E220C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3A892887F3;
	Thu, 21 Nov 2019 11:49:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gRHq6QEGLnS9; Thu, 21 Nov 2019 11:49:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AB617887CA;
	Thu, 21 Nov 2019 11:49:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99DB8C1DD8;
	Thu, 21 Nov 2019 11:49:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BF7CC18DA
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 17A422151E
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wud5mRCmcCMO for <iommu@lists.linuxfoundation.org>;
 Thu, 21 Nov 2019 11:49:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 4161424DF9
 for <iommu@lists.linuxfoundation.org>; Thu, 21 Nov 2019 11:49:46 +0000 (UTC)
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa
 [217.169.31.236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DADE2208A3;
 Thu, 21 Nov 2019 11:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574336986;
 bh=YjLRpJ96k5R2QtyyqQSk8fMZ+8IBHYLrzEpFmmGfKw4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rq6UzZLOj4j+o5Y888wbzDtXO1WUh085TsyeYxgsCHjAsLp3t+1/hM9kdMpDjC1qU
 iHkCqSZp4MVycCJr68nzJocwKYI9XI7BvAVEW+mJJwupnIgGksU8eMozQG2vpda0qL
 eKv7EDugQNsYP3OE8mCC5D4BiYCHdTRR1JpRWwIU=
From: Will Deacon <will@kernel.org>
To: iommu@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/14] Revert "iommu/arm-smmu: Make arm-smmu explicitly
 non-modular"
Date: Thu, 21 Nov 2019 11:49:12 +0000
Message-Id: <20191121114918.2293-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121114918.2293-1-will@kernel.org>
References: <20191121114918.2293-1-will@kernel.org>
MIME-Version: 1.0
Cc: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

This reverts commit addb672f200f4e99368270da205320b83efe01a0.

Let's get the SMMU driver building as a module, which means putting
back some dead code that we used to carry.

Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/iommu/arm-smmu.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7c503a6bc585..53bbe0663b9e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -27,8 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-#include <linux/init.h>
-#include <linux/moduleparam.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -59,10 +58,6 @@
 #define MSI_IOVA_LENGTH			0x100000
 
 static int force_stage;
-/*
- * not really modular, but the easiest way to keep compat with existing
- * bootargs behaviour is to continue using module_param() here.
- */
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
@@ -1878,6 +1873,7 @@ static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "qcom,smmu-v2", .data = &qcom_smmuv2 },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arm_smmu_of_match);
 
 #ifdef CONFIG_ACPI
 static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
@@ -2165,12 +2161,12 @@ static int arm_smmu_legacy_bus_init(void)
 }
 device_initcall_sync(arm_smmu_legacy_bus_init);
 
-static void arm_smmu_device_shutdown(struct platform_device *pdev)
+static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	if (!smmu)
-		return;
+		return -ENODEV;
 
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_err(&pdev->dev, "removing device with active domains!\n");
@@ -2186,6 +2182,12 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 		clk_bulk_disable(smmu->num_clks, smmu->clks);
 
 	clk_bulk_unprepare(smmu->num_clks, smmu->clks);
+	return 0;
+}
+
+static void arm_smmu_device_shutdown(struct platform_device *pdev)
+{
+	arm_smmu_device_remove(pdev);
 }
 
 static int __maybe_unused arm_smmu_runtime_resume(struct device *dev)
@@ -2235,12 +2237,16 @@ static const struct dev_pm_ops arm_smmu_pm_ops = {
 
 static struct platform_driver arm_smmu_driver = {
 	.driver	= {
-		.name			= "arm-smmu",
-		.of_match_table		= of_match_ptr(arm_smmu_of_match),
-		.pm			= &arm_smmu_pm_ops,
-		.suppress_bind_attrs	= true,
+		.name		= "arm-smmu",
+		.of_match_table	= of_match_ptr(arm_smmu_of_match),
+		.pm		= &arm_smmu_pm_ops,
 	},
 	.probe	= arm_smmu_device_probe,
+	.remove	= arm_smmu_device_remove,
 	.shutdown = arm_smmu_device_shutdown,
 };
-builtin_platform_driver(arm_smmu_driver);
+module_platform_driver(arm_smmu_driver);
+
+MODULE_DESCRIPTION("IOMMU API for ARM architected SMMU implementations");
+MODULE_AUTHOR("Will Deacon <will.deacon@arm.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.24.0.432.g9d3f5f5b63-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
