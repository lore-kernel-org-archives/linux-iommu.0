From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 07/19] ioasid: Convert ioasid_idr to XArray
Date: Tue, 23 Apr 2019 16:31:07 -0700
Message-ID: <1556062279-64135-8-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1556062279-64135-1-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Raj Ashok <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Andriy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

IDR is to be replaced by XArray, keep up with the changes.
XArray has internal locking for normal APIs used here, also removed
radix tree related preload.

Suggested-by: Ira Weiny <ira.weiny-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/ioasid.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/base/ioasid.c b/drivers/base/ioasid.c
index cf122b2..c4012aa 100644
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
@@ -16,13 +16,12 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
-static DEFINE_IDR(ioasid_idr);
-
+static DEFINE_XARRAY_ALLOC(ioasid_xa);
 /**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
- * @max: the maximum ID (exclusive)
+ * @max: the maximum ID (inclusive)
  * @private: data private to the caller
  *
  * Allocate an ID between @min and @max (or %0 and %INT_MAX). Return the
@@ -41,13 +40,13 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
 
 	data->set = set;
 	data->private = private;
+	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
+		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
+		goto exit_free;
+	}
 
-	idr_preload(GFP_KERNEL);
-	idr_lock(&ioasid_idr);
-	data->id = id = idr_alloc(&ioasid_idr, data, min, max, GFP_ATOMIC);
-	idr_unlock(&ioasid_idr);
-	idr_preload_end();
-
+	data->id = id;
+exit_free:
 	if (id < 0) {
 		kfree(data);
 		return INVALID_IOASID;
@@ -64,12 +63,8 @@ void ioasid_free(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
 
-	idr_lock(&ioasid_idr);
-	ioasid_data = idr_remove(&ioasid_idr, ioasid);
-	idr_unlock(&ioasid_idr);
-
-	if (ioasid_data)
-		kfree_rcu(ioasid_data, rcu);
+	ioasid_data = xa_erase(&ioasid_xa, ioasid);
+	kfree_rcu(ioasid_data, rcu);
 }
 EXPORT_SYMBOL_GPL(ioasid_free);
 
@@ -93,7 +88,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 	struct ioasid_data *ioasid_data;
 
 	rcu_read_lock();
-	ioasid_data = idr_find(&ioasid_idr, ioasid);
+	ioasid_data = xa_load(&ioasid_xa, ioasid);
 	if (ioasid_data && ioasid_data->set == set) {
 		priv = ioasid_data->private;
 		if (getter && !getter(priv))
-- 
2.7.4
