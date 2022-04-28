Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCDAC433FE
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 13:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 806CC60F2D;
	Thu, 28 Apr 2022 13:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ymdbas_GF0Y8; Thu, 28 Apr 2022 13:19:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CB8DF60E95;
	Thu, 28 Apr 2022 13:19:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE841C0039;
	Thu, 28 Apr 2022 13:19:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 736F0C0039
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:19:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EC5440B95
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:19:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a36NmjqR5xrR for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 13:18:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B85740A63
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 13:18:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B95E1480;
 Thu, 28 Apr 2022 06:18:59 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0441E3F73B;
 Thu, 28 Apr 2022 06:18:56 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH v2 14/14] iommu: Clean up bus_set_iommu()
Date: Thu, 28 Apr 2022 14:18:15 +0100
Message-Id: <e272d3f5faf1db917f294a549277482ee0dab9d4.1650890638.git.robin.murphy@arm.com>
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

Clean up the remaining trivial bus_set_iommu() callsites along
with the implementation. Now drivers only have to know and care
about iommu_device instances, phew!

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/qcom_iommu.c |  4 ----
 drivers/iommu/fsl_pamu_domain.c         |  4 ----
 drivers/iommu/intel/iommu.c             |  1 -
 drivers/iommu/iommu.c                   | 24 ------------------------
 drivers/iommu/msm_iommu.c               |  2 --
 drivers/iommu/rockchip-iommu.c          |  2 --
 drivers/iommu/s390-iommu.c              |  6 ------
 drivers/iommu/sprd-iommu.c              |  5 -----
 drivers/iommu/sun50i-iommu.c            |  2 --
 include/linux/iommu.h                   |  1 -
 10 files changed, 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4c077c38fbd6..80af00f468b4 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -845,8 +845,6 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	bus_set_iommu(&platform_bus_type, &qcom_iommu_ops);
-
 	if (qcom_iommu->local_base) {
 		pm_runtime_get_sync(dev);
 		writel_relaxed(0xffffffff, qcom_iommu->local_base + SMMU_INTR_SEL_NS);
@@ -864,8 +862,6 @@ static int qcom_iommu_device_remove(struct platform_device *pdev)
 {
 	struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
 
-	bus_set_iommu(&platform_bus_type, NULL);
-
 	pm_runtime_force_suspend(&pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&qcom_iommu->iommu);
diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 69a4a62dc3b9..7274f86b2bc4 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -480,11 +480,7 @@ int __init pamu_domain_init(void)
 	if (ret) {
 		iommu_device_sysfs_remove(&pamu_iommu);
 		pr_err("Can't register iommu device\n");
-		return ret;
 	}
 
-	bus_set_iommu(&platform_bus_type, &fsl_pamu_ops);
-	bus_set_iommu(&pci_bus_type, &fsl_pamu_ops);
-
 	return ret;
 }
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 9507b64fdf6b..e0a31fa6a70c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4178,7 +4178,6 @@ int __init intel_iommu_init(void)
 	}
 	up_read(&dmar_global_lock);
 
-	bus_set_iommu(&pci_bus_type, &intel_iommu_ops);
 	if (si_domain && !hw_pass_through)
 		register_memory_notifier(&intel_iommu_memory_nb);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c89af4dc54c2..5f10e7ad04b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1887,30 +1887,6 @@ static int iommu_bus_init(struct bus_type *bus)
 	return err;
 }
 
-/**
- * bus_set_iommu - set iommu-callbacks for the bus
- * @bus: bus.
- * @ops: the callbacks provided by the iommu-driver
- *
- * This function is called by an iommu driver to set the iommu methods
- * used for a particular bus. Drivers for devices on that bus can use
- * the iommu-api after these ops are registered.
- * This special function is needed because IOMMUs are usually devices on
- * the bus itself, so the iommu drivers are not initialized when the bus
- * is set up. With this function the iommu-driver can set the iommu-ops
- * afterwards.
- */
-int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
-{
-	if (bus->iommu_ops && ops && bus->iommu_ops != ops)
-		return -EBUSY;
-
-	bus->iommu_ops = ops;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(bus_set_iommu);
-
 bool iommu_present(struct bus_type *bus)
 {
 	return bus->iommu_ops != NULL;
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 50f57624610f..5b89fb16feb8 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -789,8 +789,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 		goto fail;
 	}
 
-	bus_set_iommu(&platform_bus_type, &msm_iommu_ops);
-
 	pr_info("device mapped at %p, irq %d with %d ctx banks\n",
 		iommu->base, iommu->irq, iommu->ncb);
 
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab57c4b8fade..a3fc59b814ab 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1300,8 +1300,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (!dma_dev)
 		dma_dev = &pdev->dev;
 
-	bus_set_iommu(&platform_bus_type, &rk_iommu_ops);
-
 	pm_runtime_enable(dev);
 
 	for (i = 0; i < iommu->num_irq; i++) {
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 3833e86c6e7b..5f5f4bd91e6f 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -376,9 +376,3 @@ static const struct iommu_ops s390_iommu_ops = {
 		.free		= s390_domain_free,
 	}
 };
-
-static int __init s390_iommu_init(void)
-{
-	return bus_set_iommu(&pci_bus_type, &s390_iommu_ops);
-}
-subsys_initcall(s390_iommu_init);
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index bd409bab6286..6770e6a72283 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -507,9 +507,6 @@ static int sprd_iommu_probe(struct platform_device *pdev)
 	if (ret)
 		goto remove_sysfs;
 
-	if (!iommu_present(&platform_bus_type))
-		bus_set_iommu(&platform_bus_type, &sprd_iommu_ops);
-
 	ret = sprd_iommu_clk_enable(sdev);
 	if (ret)
 		goto unregister_iommu;
@@ -545,8 +542,6 @@ static int sprd_iommu_remove(struct platform_device *pdev)
 	iommu_group_put(sdev->group);
 	sdev->group = NULL;
 
-	bus_set_iommu(&platform_bus_type, NULL);
-
 	platform_set_drvdata(pdev, NULL);
 	iommu_device_sysfs_remove(&sdev->iommu);
 	iommu_device_unregister(&sdev->iommu);
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index c54ab477b8fd..e104543b78d9 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -968,8 +968,6 @@ static int sun50i_iommu_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_unregister;
 
-	bus_set_iommu(&platform_bus_type, &sun50i_iommu_ops);
-
 	return 0;
 
 err_unregister:
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4123693ae319..17be860a3194 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -416,7 +416,6 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 #define IOMMU_GROUP_NOTIFY_UNBIND_DRIVER	5 /* Pre Driver unbind */
 #define IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER	6 /* Post Driver unbind */
 
-extern int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops);
 extern int bus_iommu_probe(struct bus_type *bus);
 extern bool iommu_present(struct bus_type *bus);
 extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
