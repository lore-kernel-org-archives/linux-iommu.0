From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Handle memory shortage on pasid table
	allocation
Date: Sat,  8 Sep 2018 09:42:53 +0800
Message-ID: <20180908014253.14722-1-baolu.lu@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Pasid table memory allocation could return failure due to memory
shortage. Limit the pasid table size to 1MiB because current 8MiB
contiguous physical memory allocation can be hard to come by. W/o
a PASID table, the device could continue to work with only shared
virtual memory impacted. So, let's go ahead with context mapping
even the memory allocation for pasid table failed.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=107783
Fixes: cc580e41260d ("iommu/vt-d: Per PCI device pasid table interfaces")

Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reported-and-tested-by: Pelton Kyle D <kyle.d.pelton-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 Change log:
 v1->v2:
   - Add "Tested-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>"
   - Add bugzilla reference

 drivers/iommu/intel-iommu.c | 6 +++---
 drivers/iommu/intel-pasid.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5f3f10cf9d9d..bedc801b06a0 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2540,9 +2540,9 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	if (dev && dev_is_pci(dev) && info->pasid_supported) {
 		ret = intel_pasid_alloc_table(dev);
 		if (ret) {
-			__dmar_remove_one_dev_info(info);
-			spin_unlock_irqrestore(&device_domain_lock, flags);
-			return NULL;
+			pr_warn("No pasid table for %s, pasid disabled\n",
+				dev_name(dev));
+			info->pasid_supported = 0;
 		}
 	}
 	spin_unlock_irqrestore(&device_domain_lock, flags);
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index 1c05ed6fc5a5..1fb5e12b029a 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -11,7 +11,7 @@
 #define __INTEL_PASID_H
 
 #define PASID_MIN			0x1
-#define PASID_MAX			0x100000
+#define PASID_MAX			0x20000
 
 struct pasid_entry {
 	u64 val;
-- 
2.17.1
