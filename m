From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/10] iommu: Rename struct iommu_device
Date: Mon,  6 Feb 2017 17:10:21 +0100
Message-ID: <1486397429-29327-3-git-send-email-joro@8bytes.org>
References: <1486397429-29327-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1486397429-29327-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The struct is used to link devices to iommu-groups, so
'struct group_device' is a better name. Further this makes
the name iommu_device available for a struct representing
hardware iommus.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
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
