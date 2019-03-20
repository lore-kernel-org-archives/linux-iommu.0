From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu: Remove iommu_callback_data
Date: Wed, 20 Mar 2019 09:40:24 +0800
Message-ID: <20190320014024.22332-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

The iommu_callback_data is not used anywhere, remove it to make
the code more concise.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..1164b9926a2b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,10 +45,6 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
 static bool iommu_dma_strict __read_mostly = true;
 
-struct iommu_callback_data {
-	const struct iommu_ops *ops;
-};
-
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -1215,9 +1211,6 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 {
 	int err;
 	struct notifier_block *nb;
-	struct iommu_callback_data cb = {
-		.ops = ops,
-	};
 
 	nb = kzalloc(sizeof(struct notifier_block), GFP_KERNEL);
 	if (!nb)
@@ -1229,7 +1222,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 	if (err)
 		goto out_free;
 
-	err = bus_for_each_dev(bus, NULL, &cb, add_iommu_group);
+	err = bus_for_each_dev(bus, NULL, NULL, add_iommu_group);
 	if (err)
 		goto out_err;
 
@@ -1238,7 +1231,7 @@ static int iommu_bus_init(struct bus_type *bus, const struct iommu_ops *ops)
 
 out_err:
 	/* Clean up */
-	bus_for_each_dev(bus, NULL, &cb, remove_iommu_group);
+	bus_for_each_dev(bus, NULL, NULL, remove_iommu_group);
 	bus_unregister_notifier(bus, nb);
 
 out_free:
-- 
2.17.1
