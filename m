From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 01/04] iommu/ipmmu-vmsa: Use iommu_device_register()/unregister()
Date: Thu, 15 Jun 2017 19:29:16 +0900
Message-ID: <149752255681.21887.9984138893493295897.sendpatchset@little-apple>
References: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <149752254550.21887.15183665699230243235.sendpatchset@little-apple>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: joro@8bytes.org
Cc: laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, robin.murphy@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, sricharan@codeaurora.org, m.szyprowski@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend the driver to make use of iommu_device_register()/unregister()
functions together with iommu_device_set_ops() and iommu_set_fwnode().

These used to be part of the earlier posted 64-bit ARM (r8a7795) series but
it turns out that these days they are required on 32-bit ARM as well.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/iommu/ipmmu-vmsa.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2017-06-15 16:57:21.890607110 +0900
@@ -35,6 +35,7 @@
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
+	struct iommu_device iommu;
 	struct list_head list;
 
 	unsigned int num_utlbs;
@@ -1054,6 +1055,13 @@ static int ipmmu_probe(struct platform_d
 
 	ipmmu_device_reset(mmu);
 
+	ret = iommu_device_register(&mmu->iommu);
+	if (ret)
+		return ret;
+
+	iommu_device_set_ops(&mmu->iommu, &ipmmu_ops);
+	iommu_device_set_fwnode(&mmu->iommu, &pdev->dev.of_node->fwnode);
+
 	/*
 	 * We can't create the ARM mapping here as it requires the bus to have
 	 * an IOMMU, which only happens when bus_set_iommu() is called in
@@ -1077,6 +1085,8 @@ static int ipmmu_remove(struct platform_
 	list_del(&mmu->list);
 	spin_unlock(&ipmmu_devices_lock);
 
+	iommu_device_unregister(&mmu->iommu);
+
 #if defined(CONFIG_ARM) && !defined(CONFIG_IOMMU_DMA)
 	arm_iommu_release_mapping(mmu->mapping);
 #endif
