From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2] iommu/of: Remove PCI host bridge node check
Date: Thu, 21 Sep 2017 11:20:58 +0100
Message-ID: <56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
References: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jean-philippe.brucker@arm.com
List-Id: iommu@lists.linux-foundation.org

of_pci_iommu_init() tries to be clever and stop its alias walk at the
device represented by master_np, in case of weird PCI topologies where
the bridge to the IOMMU and the rest of the system is not at the root.
It turns out this is a bit short-sighted, since there are plenty of
other callers of pci_for_each_dma_alias() which would also need the same
behaviour in that situation, and the only platform so far with such a
topology (Cavium ThunderX2) already solves it more generally via a PCI
quirk. As this check is effectively redundant, and returning a boolean
value as an int is a bit broken anyway, let's just get rid of it.

Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Ugh, I'm really failing to spot the obvious today...

 drivers/iommu/of_iommu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index e60e3dba85a0..50947ebb6d17 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -157,10 +157,7 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 
 	err = of_iommu_xlate(info->dev, &iommu_spec);
 	of_node_put(iommu_spec.np);
-	if (err)
-		return err;
-
-	return info->np == pdev->bus->dev.of_node;
+	return err;
 }
 
 const struct iommu_ops *of_iommu_configure(struct device *dev,
-- 
2.13.4.dirty
