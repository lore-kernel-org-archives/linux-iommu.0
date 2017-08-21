From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] iommu/ipmmu-vmsa: Use iommu_device_sysfs_add()/remove()
Date: Mon, 21 Aug 2017 14:53:35 +0900
Message-ID: <150329481531.31395.6238405988822544474.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, sricharan@codeaurora.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, robin.murphy@arm.com, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the driver to make use of iommu_device_sysfs_add()/remove()
functions to hook up initial sysfs support.

Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Applies on top of next-20170817

 drivers/iommu/ipmmu-vmsa.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-08-21 14:40:13.940607110 +0900
@@ -953,6 +953,11 @@ static int ipmmu_probe(struct platform_d
 
 	ipmmu_device_reset(mmu);
 
+	ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL,
+				     dev_name(&pdev->dev));
+	if (ret)
+		return ret;
+
 	iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
 	iommu_device_set_fwnode(&mmu->iommu, &pdev->dev.of_node->fwnode);
 
@@ -975,6 +980,7 @@ static int ipmmu_remove(struct platform_
 {
 	struct ipmmu_vmsa_device *mmu = platform_get_drvdata(pdev);
 
+	iommu_device_sysfs_remove(&mmu->iommu);
 	iommu_device_unregister(&mmu->iommu);
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
