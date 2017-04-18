From: "zhichang.yuan" <yuanzhichang@hisilicon.com>
Subject: [PATCH] iommu: make iommu_bus_notifier return NOTIFY_DONE rather than  error code
Date: Tue, 18 Apr 2017 20:51:48 +0800
Message-ID: <1492519908-65994-1-git-send-email-yuanzhichang@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linuxarm@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, zhichang.yuan02@gmail.com, yankejian@huawei.com, huangdaode@hisilicon.com, "zhichang.yuan" <yuanzhichang@hisilicon.com>
List-Id: iommu@lists.linux-foundation.org

In iommu_bus_notifier(), when action is BUS_NOTIFY_ADD_DEVICE, it will return
'ops->add_device(dev)' directly. But ops->add_device will return ERR_VAL, such
as -ENODEV. These value will make notifier_call_chain() not to traverse the
remain nodes in struct notifier_block list.

This patch revises iommu_bus_notifier() to return NOTIFY_DONE when some errors
heppened in ops->add_device().

Signed-off-by: zhichang.yuan <yuanzhichang@hisilicon.com>
---
 drivers/iommu/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3b67144..2d32911 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1083,8 +1083,12 @@ static int iommu_bus_notifier(struct notifier_block *nb,
 	 * result in ADD/DEL notifiers to group->notifier
 	 */
 	if (action == BUS_NOTIFY_ADD_DEVICE) {
-		if (ops->add_device)
-			return ops->add_device(dev);
+		if (ops->add_device) {
+			int ret;
+
+			ret = ops->add_device(dev);
+			return (ret) ? NOTIFY_DONE : NOTIFY_OK;
+		}
 	} else if (action == BUS_NOTIFY_REMOVED_DEVICE) {
 		if (ops->remove_device && dev->iommu_group) {
 			ops->remove_device(dev);
-- 
1.9.1
