From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 02/10] iommu: Rename struct iommu_device
Date: Fri,  3 Feb 2017 16:17:40 +0100
Message-ID: <1486135068-23994-3-git-send-email-joro@8bytes.org>
References: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1486135068-23994-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Alex Williamson <alex.williamson@redhat.com>, David Woodhouse <dwmw2@infradead.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

The struct is used to link devices to iommu-groups, so
'struct group_device' is a better name. Further this makes
the name iommu_device available for a struct representing
hardware iommus.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/iommu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ee05bb..e4e8a93 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -55,7 +55,7 @@ struct iommu_group {
 	struct iommu_domain *domain;
 };
 
-struct iommu_device {
+struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
@@ -374,7 +374,7 @@ static int iommu_group_create_direct_mappings(struct iommu_group *group,
 int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	int ret, i = 0;
-	struct iommu_device *device;
+	struct group_device *device;
 
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
@@ -449,7 +449,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 void iommu_group_remove_device(struct device *dev)
 {
 	struct iommu_group *group = dev->iommu_group;
-	struct iommu_device *tmp_device, *device = NULL;
+	struct group_device *tmp_device, *device = NULL;
 
 	pr_info("Removing device %s from group %d\n", dev_name(dev), group->id);
 
@@ -484,7 +484,7 @@ void iommu_group_remove_device(struct device *dev)
 
 static int iommu_group_device_count(struct iommu_group *group)
 {
-	struct iommu_device *entry;
+	struct group_device *entry;
 	int ret = 0;
 
 	list_for_each_entry(entry, &group->devices, list)
@@ -507,7 +507,7 @@ static int iommu_group_device_count(struct iommu_group *group)
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
-	struct iommu_device *device;
+	struct group_device *device;
 	int ret = 0;
 
 	list_for_each_entry(device, &group->devices, list) {
-- 
1.9.1
