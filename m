From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 03/18] ioasid: Convert ioasid_idr to XArray
Date: Mon,  8 Apr 2019 16:59:18 -0700
Message-ID: <1554767973-30125-4-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1554767973-30125-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

IDR is to be replaced by XArray, keep up with the changes.
XArray has internal locking for normal APIs used here, also removed
radix tree related preload.

Suggested-by: Ira Weiny <ira.weiny-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/ioasid.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index 294e856..35bdc680 100644
--- a/drivers/base/ioasid.c
+++ b/drivers/base/ioasid.c
@@ -4,7 +4,7 @@
  * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
  * free IOASIDs with ioasid_alloc and ioasid_free.
  */
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/ioasid.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -16,7 +16,7 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_IDR(ioasid_idr);
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 static DEFINE_MUTEX(ioasid_allocator_lock);
 static const struct ioasid_allocator *ioasid_allocator;
 
@@ -24,9 +24,9 @@ static const struct ioasid_allocator *ioasid_allocator;
 /**
  * ioasid_set_allocator - register a custom allocator
  *
- * Custom allocator take precedence over the default IDR based allocator.
+ * Custom allocator take precedence over the default xarray based allocator.
  * Private data associated with the ASID are managed by ASID common code
- * similar to IDR data.
+ * similar to data stored in xa.
  */
 int ioasid_set_allocator(struct ioasid_allocator *allocator)
 {
@@ -72,13 +72,12 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		ioasid_data->private = data;
 	else
 		ret = -ENOENT;
-	idr_unlock(&ioasid_idr);
+
 	/* getter may use the private data */
 	synchronize_rcu();
 
@@ -110,7 +109,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 	data->set = set;
 	data->private = private;
 
-	/* Use custom allocator if available, otherwise default to IDR */
+	/* Use custom allocator if available, otherwise default to xarray */
 	if (ioasid_allocator) {
 		mutex_lock(&ioasid_allocator_lock);
 		id = ioasid_allocator->alloc(min, max, ioasid_allocator->pdata);
@@ -120,17 +119,18 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 			goto exit_free;
 		}
 		/*
-		 * Use IDR to manage private data also sanitiy check custom
+		 * Use XA to manage private data also sanitiy check custom
 		 * allocator for duplicates.
 		 */
 		min = id;
 		max = id + 1;
 	}
-	idr_preload(GFP_KERNEL);
-	idr_lock(&ioasid_idr);
-	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
-	idr_unlock(&ioasid_idr);
-	idr_preload_end();
+
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
+	data->id = id;
 
 exit_free:
 	if (id < 0 || id == INVALID_IOASID) {
@@ -160,10 +160,7 @@ int ioasid_free(ioasid_t ioasid)
 		return ret;
 	}
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_remove(&ioasid_idr, ioasid);
-	idr_unlock(&ioasid_idr);
-
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
 	if (ioasid_data)
 		kfree_rcu(ioasid_data, rcu);
 
@@ -192,7 +189,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (!ioasid_data) {
 		priv = ERR_PTR(-ENOENT);
 		goto unlock;
-- 
2.7.4
