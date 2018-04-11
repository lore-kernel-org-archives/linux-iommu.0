From: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 1/2] iommu: Gracefully allow drivers to not attach to a
	default domain
Date: Wed, 11 Apr 2018 12:55:09 -0600
Message-ID: <20180411185510.11594-2-jcrouse@codeaurora.org>
References: <20180411185510.11594-1-jcrouse@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180411185510.11594-1-jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, freedreno-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Provide individual device drivers the chance to gracefully refuse
to attach a device to the default domain. If the attach_device
op returns -ENOTSUPP don't print a error message and don't set
group->domain but still return success from iommu_group_add_dev().

This allows all the usual APIs to work and the next domain to try
to attach will take group->domain for itself and everything will
proceed as normal.

Signed-off-by: Jordan Crouse <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/iommu/iommu.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 69fef991c651..2403cce138d2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -592,7 +592,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	if (group->domain)
 		ret = __iommu_attach_device(group->domain, dev);
 	mutex_unlock(&group->mutex);
-	if (ret)
+	if (ret && ret != -ENOTSUPP)
 		goto err_put_group;
 
 	/* Notify any listeners about change to group. */
@@ -617,7 +617,9 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
 	kfree(device);
-	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
+	if (ret != -ENOTSUPP)
+		pr_err("Failed to add device %s to group %d: %d\n",
+			dev_name(dev), group->id, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -1039,8 +1041,16 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 
 	ret = iommu_group_add_device(group, dev);
 	if (ret) {
-		iommu_group_put(group);
-		return ERR_PTR(ret);
+		/*
+		 * If the driver chooses not to bind the device, reset
+		 * group->domain so a new domain can be added later
+		 */
+		if (ret == -ENOTSUPP)
+			group->domain = NULL;
+		else {
+			iommu_group_put(group);
+			return ERR_PTR(ret);
+		}
 	}
 
 	return group;
-- 
2.16.1
