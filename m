From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/4] iommu/sysfs: Rename iommu_release_device()
Date: Wed,  5 Dec 2018 15:36:43 +0100
Message-ID: <20181205143646.4876-2-joro@8bytes.org>
References: <20181205143646.4876-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205143646.4876-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Remove the iommu_ prefix from the function and a few other
static data structures so that the iommu_release_device name
can be re-used in iommu core code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu-sysfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu-sysfs.c b/drivers/iommu/iommu-sysfs.c
index 36d1a7ce7fc4..71c2249d3260 100644
--- a/drivers/iommu/iommu-sysfs.c
+++ b/drivers/iommu/iommu-sysfs.c
@@ -22,25 +22,25 @@ static struct attribute *devices_attr[] = {
 	NULL,
 };
 
-static const struct attribute_group iommu_devices_attr_group = {
+static const struct attribute_group devices_attr_group = {
 	.name = "devices",
 	.attrs = devices_attr,
 };
 
-static const struct attribute_group *iommu_dev_groups[] = {
-	&iommu_devices_attr_group,
+static const struct attribute_group *dev_groups[] = {
+	&devices_attr_group,
 	NULL,
 };
 
-static void iommu_release_device(struct device *dev)
+static void release_device(struct device *dev)
 {
 	kfree(dev);
 }
 
 static struct class iommu_class = {
 	.name = "iommu",
-	.dev_release = iommu_release_device,
-	.dev_groups = iommu_dev_groups,
+	.dev_release = release_device,
+	.dev_groups = dev_groups,
 };
 
 static int __init iommu_dev_init(void)
-- 
2.17.1
