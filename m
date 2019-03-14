From: James Sewart via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: [PATCH v2 1/7] iommu: Move iommu_group_create_direct_mappings to
	after device_attach
Date: Thu, 14 Mar 2019 11:57:36 +0000
Message-ID: <864DF17D-7D9D-445B-B3FC-5AA308C0B179@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Reply-To: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If an IOMMU driver requires to know which IOMMU a domain is associated
to initialise a domain then it will do so in device_attach, before which
it is not safe to call iommu_ops.

Signed-off-by: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db334341..1c6ffbb2d20e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -652,8 +652,6 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	dev->iommu_group = group;
 
-	iommu_group_create_direct_mappings(group, dev);
-
 	mutex_lock(&group->mutex);
 	list_add_tail(&device->list, &group->devices);
 	if (group->domain)
@@ -662,6 +660,8 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	if (ret)
 		goto err_put_group;
 
+	iommu_group_create_direct_mappings(group, dev);
+
 	/* Notify any listeners about change to group. */
 	blocking_notifier_call_chain(&group->notifier,
 				     IOMMU_GROUP_NOTIFY_ADD_DEVICE, dev);
-- 
2.17.1
