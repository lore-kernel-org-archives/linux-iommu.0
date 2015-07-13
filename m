From: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 3/4] iommu: Make the iova library a module
Date: Mon, 13 Jul 2015 14:31:30 +0300
Message-ID: <1436787091-11943-4-git-send-email-sakari.ailus@linux.intel.com>
References: <1436787091-11943-1-git-send-email-sakari.ailus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1436787091-11943-1-git-send-email-sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jian.xu.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The iova library has use outside the intel-iommu driver, thus make it a
module.

Signed-off-by: Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/Kconfig | 2 +-
 drivers/iommu/iova.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 40f37a2..e7e9a51b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -42,7 +42,7 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 endmenu
 
 config IOMMU_IOVA
-	bool
+	tristate
 
 config OF_IOMMU
        def_bool y
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index dd87123..dd64d33 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 void
@@ -559,3 +560,6 @@ error:
 		free_iova_mem(prev);
 	return NULL;
 }
+
+MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
+MODULE_LICENSE("GPL");
-- 
2.1.0.231.g7484e3b
