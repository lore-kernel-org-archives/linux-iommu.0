From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 2/5] iommu/dmar: Return directly from a loop in
	dmar_dev_scope_status()
Date: Thu, 16 Mar 2017 16:23:52 +0200
Message-ID: <20170316142355.16307-2-andriy.shevchenko@linux.intel.com>
References: <20170316142355.16307-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170316142355.16307-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J . Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is no need to have a temporary variable.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/dmar.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index edcf7410f736..71d774f1d406 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -557,11 +557,10 @@ static int __init dmar_table_detect(void)
 static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 				       size_t len, struct dmar_res_callback *cb)
 {
-	int ret = 0;
 	struct acpi_dmar_header *iter, *next;
 	struct acpi_dmar_header *end = ((void *)start) + len;
 
-	for (iter = start; iter < end && ret == 0; iter = next) {
+	for (iter = start; iter < end; iter = next) {
 		next = (void *)iter + iter->length;
 		if (iter->length == 0) {
 			/* Avoid looping forever on bad ACPI tables */
@@ -570,8 +569,7 @@ static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 		} else if (next > end) {
 			/* Avoid passing table end */
 			pr_warn(FW_BUG "Record passes table end\n");
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
 		if (cb->print_entry)
@@ -582,15 +580,19 @@ static int dmar_walk_remapping_entries(struct acpi_dmar_header *start,
 			pr_debug("Unknown DMAR structure type %d\n",
 				 iter->type);
 		} else if (cb->cb[iter->type]) {
+			int ret;
+
 			ret = cb->cb[iter->type](iter, cb->arg[iter->type]);
+			if (ret)
+				return ret;
 		} else if (!cb->ignore_unhandled) {
 			pr_warn("No handler for DMAR structure type %d\n",
 				iter->type);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
-- 
2.11.0
