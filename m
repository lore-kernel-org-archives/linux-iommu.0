From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu: simplify and fix ida handling
Date: Wed, 29 Jun 2016 21:13:59 +0200
Message-ID: <e6d78cf6-2af6-8638-6f08-70025b720265@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Ida handling can be much simplified by using the ida_simple_.. functions.

This change also fixes the bug that previously checking for errors
returned by ida_get_new() was incomplete.
ida_get_new() can return errors other than EAGAIN, e.g. ENOSPC.
This case wasn't handled.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/iommu.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index debce45..4d3c4a8 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -35,7 +35,6 @@
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
-static DEFINE_MUTEX(iommu_group_mutex);
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -144,9 +143,7 @@ static void iommu_group_release(struct kobject *kobj)
 	if (group->iommu_data_release)
 		group->iommu_data_release(group->iommu_data);
 
-	mutex_lock(&iommu_group_mutex);
-	ida_remove(&iommu_group_ida, group->id);
-	mutex_unlock(&iommu_group_mutex);
+	ida_simple_remove(&iommu_group_ida, group->id);
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
@@ -186,26 +183,17 @@ struct iommu_group *iommu_group_alloc(void)
 	INIT_LIST_HEAD(&group->devices);
 	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
 
-	mutex_lock(&iommu_group_mutex);
-
-again:
-	if (unlikely(0 == ida_pre_get(&iommu_group_ida, GFP_KERNEL))) {
+	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
 		kfree(group);
-		mutex_unlock(&iommu_group_mutex);
-		return ERR_PTR(-ENOMEM);
+		return ERR_PTR(ret);
 	}
-
-	if (-EAGAIN == ida_get_new(&iommu_group_ida, &group->id))
-		goto again;
-
-	mutex_unlock(&iommu_group_mutex);
+	group->id = ret;
 
 	ret = kobject_init_and_add(&group->kobj, &iommu_group_ktype,
 				   NULL, "%d", group->id);
 	if (ret) {
-		mutex_lock(&iommu_group_mutex);
-		ida_remove(&iommu_group_ida, group->id);
-		mutex_unlock(&iommu_group_mutex);
+		ida_simple_remove(&iommu_group_ida, group->id);
 		kfree(group);
 		return ERR_PTR(ret);
 	}
-- 
2.9.0
