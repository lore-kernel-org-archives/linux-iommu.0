Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF81C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 13:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3455D40C3A;
	Thu, 28 Apr 2022 13:18:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iIasu9epeO70; Thu, 28 Apr 2022 13:18:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1336940C35;
	Thu, 28 Apr 2022 13:18:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1D11C0039;
	Thu, 28 Apr 2022 13:18:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAFA7C0081
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95D3A60D69
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FP9L7s9Zxyvt for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:18:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6ADF760E87
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E17651480;
 Thu, 28 Apr 2022 06:18:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB9DD3F73B;
 Thu, 28 Apr 2022 06:18:36 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 05/14] iommu/arm-smmu: Clean up bus_set_iommu()
Date: Thu, 28 Apr 2022 14:18:06 +0100
Message-Id: <7e3e45433e746249a6769a3d76b9088bc02b9bcf.1650890638.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650890638.git.robin.murphy@arm.com>
References: <cover.1650890638.git.robin.murphy@arm.com>
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

Stop calling bus_set_iommu() since it's now unnecessary. With device
probes now replayed for every IOMMU instance registration, the whole
sorry ordering workaround for legacy DT bindings goes too, hooray!

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 84 +--------------------------
 1 file changed, 2 insertions(+), 82 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 568cce590ccc..f0bec4a35df5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -37,7 +37,6 @@
 #include <linux/ratelimit.h>
 #include <linux/slab.h>
 
-#include <linux/amba/bus.h>
 #include <linux/fsl/mc.h>
 
 #include "arm-smmu.h"
@@ -93,8 +92,6 @@ static struct platform_driver arm_smmu_driver;
 static struct iommu_ops arm_smmu_ops;
 
 #ifdef CONFIG_ARM_SMMU_LEGACY_DT_BINDINGS
-static int arm_smmu_bus_init(struct iommu_ops *ops);
-
 static struct device_node *dev_get_dev_node(struct device *dev)
 {
 	if (dev_is_pci(dev)) {
@@ -180,20 +177,6 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 	kfree(sids);
 	return err;
 }
-
-/*
- * With the legacy DT binding in play, we have no guarantees about
- * probe order, but then we're also not doing default domains, so we can
- * delay setting bus ops until we're sure every possible SMMU is ready,
- * and that way ensure that no probe_device() calls get missed.
- */
-static int arm_smmu_legacy_bus_init(void)
-{
-	if (using_legacy_binding)
-		return arm_smmu_bus_init(&arm_smmu_ops);
-	return 0;
-}
-device_initcall_sync(arm_smmu_legacy_bus_init);
 #else
 static int arm_smmu_register_legacy_master(struct device *dev,
 					   struct arm_smmu_device **smmu)
@@ -2022,52 +2005,6 @@ static int arm_smmu_device_dt_probe(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_bus_init(struct iommu_ops *ops)
-{
-	int err;
-
-	/* Oh, for a proper bus abstraction */
-	if (!iommu_present(&platform_bus_type)) {
-		err = bus_set_iommu(&platform_bus_type, ops);
-		if (err)
-			return err;
-	}
-#ifdef CONFIG_ARM_AMBA
-	if (!iommu_present(&amba_bustype)) {
-		err = bus_set_iommu(&amba_bustype, ops);
-		if (err)
-			goto err_reset_platform_ops;
-	}
-#endif
-#ifdef CONFIG_PCI
-	if (!iommu_present(&pci_bus_type)) {
-		err = bus_set_iommu(&pci_bus_type, ops);
-		if (err)
-			goto err_reset_amba_ops;
-	}
-#endif
-#ifdef CONFIG_FSL_MC_BUS
-	if (!iommu_present(&fsl_mc_bus_type)) {
-		err = bus_set_iommu(&fsl_mc_bus_type, ops);
-		if (err)
-			goto err_reset_pci_ops;
-	}
-#endif
-	return 0;
-
-err_reset_pci_ops: __maybe_unused;
-#ifdef CONFIG_PCI
-	bus_set_iommu(&pci_bus_type, NULL);
-#endif
-err_reset_amba_ops: __maybe_unused;
-#ifdef CONFIG_ARM_AMBA
-	bus_set_iommu(&amba_bustype, NULL);
-#endif
-err_reset_platform_ops: __maybe_unused;
-	bus_set_iommu(&platform_bus_type, NULL);
-	return err;
-}
-
 static int arm_smmu_device_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -2185,7 +2122,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	err = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
 	if (err) {
 		dev_err(dev, "Failed to register iommu\n");
-		goto err_sysfs_remove;
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return err;
 	}
 
 	platform_set_drvdata(pdev, smmu);
@@ -2203,24 +2141,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 	}
 
-	/*
-	 * For ACPI and generic DT bindings, an SMMU will be probed before
-	 * any device which might need it, so we want the bus ops in place
-	 * ready to handle default domain setup as soon as any SMMU exists.
-	 */
-	if (!using_legacy_binding) {
-		err = arm_smmu_bus_init(&arm_smmu_ops);
-		if (err)
-			goto err_unregister_device;
-	}
-
 	return 0;
-
-err_unregister_device:
-	iommu_device_unregister(&smmu->iommu);
-err_sysfs_remove:
-	iommu_device_sysfs_remove(&smmu->iommu);
-	return err;
 }
 
 static int arm_smmu_device_remove(struct platform_device *pdev)
@@ -2233,7 +2154,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
-	arm_smmu_bus_init(NULL);
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
