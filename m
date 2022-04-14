Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C56C4332F
	for <iommu@archiver.kernel.org>; Thu, 14 Apr 2022 12:43:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E234984177;
	Thu, 14 Apr 2022 12:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wzC5gfRGwQvN; Thu, 14 Apr 2022 12:43:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CB41E8417B;
	Thu, 14 Apr 2022 12:43:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A60F9C0033;
	Thu, 14 Apr 2022 12:43:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7418BC002C
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62737401F4
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:43:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PP_StQ5QA1hI for <iommu@lists.linux-foundation.org>;
 Thu, 14 Apr 2022 12:43:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 854B7400CF
 for <iommu@lists.linux-foundation.org>; Thu, 14 Apr 2022 12:43:01 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09D2A15DB;
 Thu, 14 Apr 2022 05:43:01 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0777C3F70D;
 Thu, 14 Apr 2022 05:42:58 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH 06/13] iommu/dart: Clean up bus_set_iommu()
Date: Thu, 14 Apr 2022 13:42:35 +0100
Message-Id: <36df696dacfffd52e79b471572de9893b52ad0d9.1649935679.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649935679.git.robin.murphy@arm.com>
References: <cover.1649935679.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, zhang.lyra@gmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org,
 gerald.schaefer@linux.ibm.com
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

Stop calling bus_set_iommu() since it's now unnecessary, and simplify
the probe failure path accordingly.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/apple-dart.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index decafb07ad08..a679e4c02291 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -823,27 +823,6 @@ static irqreturn_t apple_dart_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int apple_dart_set_bus_ops(const struct iommu_ops *ops)
-{
-	int ret;
-
-	if (!iommu_present(&platform_bus_type)) {
-		ret = bus_set_iommu(&platform_bus_type, ops);
-		if (ret)
-			return ret;
-	}
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		ret = bus_set_iommu(&pci_bus_type, ops);
-		if (ret) {
-			bus_set_iommu(&platform_bus_type, NULL);
-			return ret;
-		}
-	}
-#endif
-	return 0;
-}
-
 static int apple_dart_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -899,14 +878,10 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dart);
 
-	ret = apple_dart_set_bus_ops(&apple_dart_iommu_ops);
-	if (ret)
-		goto err_free_irq;
-
 	ret = iommu_device_sysfs_add(&dart->iommu, dev, NULL, "apple-dart.%s",
 				     dev_name(&pdev->dev));
 	if (ret)
-		goto err_remove_bus_ops;
+		goto err_free_irq;
 
 	ret = iommu_device_register(&dart->iommu, &apple_dart_iommu_ops, dev);
 	if (ret)
@@ -920,8 +895,6 @@ static int apple_dart_probe(struct platform_device *pdev)
 
 err_sysfs_remove:
 	iommu_device_sysfs_remove(&dart->iommu);
-err_remove_bus_ops:
-	apple_dart_set_bus_ops(NULL);
 err_free_irq:
 	free_irq(dart->irq, dart);
 err_clk_disable:
@@ -936,7 +909,6 @@ static int apple_dart_remove(struct platform_device *pdev)
 
 	apple_dart_hw_reset(dart);
 	free_irq(dart->irq, dart);
-	apple_dart_set_bus_ops(NULL);
 
 	iommu_device_unregister(&dart->iommu);
 	iommu_device_sysfs_remove(&dart->iommu);
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
