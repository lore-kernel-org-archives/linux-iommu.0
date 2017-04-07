From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] iommu/omap: Move data structures to omap-iommu.h
Date: Fri,  7 Apr 2017 16:41:29 +0200
Message-ID: <1491576092-23339-2-git-send-email-joro@8bytes.org>
References: <1491576092-23339-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1491576092-23339-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The internal data-structures are scattered over various
header and C files. Consolidate them in omap-iommu.h.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/omap-iommu.c               | 16 ----------------
 drivers/iommu/omap-iommu.h               | 32 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/iommu-omap.h | 17 -----------------
 3 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e2583cc..e9c9b08 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -42,22 +42,6 @@
 /* bitmap of the page sizes currently supported */
 #define OMAP_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
 
-/**
- * struct omap_iommu_domain - omap iommu domain
- * @pgtable:	the page table
- * @iommu_dev:	an omap iommu device attached to this domain. only a single
- *		iommu device can be attached for now.
- * @dev:	Device using this domain.
- * @lock:	domain lock, should be taken when attaching/detaching
- */
-struct omap_iommu_domain {
-	u32 *pgtable;
-	struct omap_iommu *iommu_dev;
-	struct device *dev;
-	spinlock_t lock;
-	struct iommu_domain domain;
-};
-
 #define MMU_LOCK_BASE_SHIFT	10
 #define MMU_LOCK_BASE_MASK	(0x1f << MMU_LOCK_BASE_SHIFT)
 #define MMU_LOCK_BASE(x)	\
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 59628e5..3cd414a 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -14,6 +14,7 @@
 #define _OMAP_IOMMU_H
 
 #include <linux/bitops.h>
+#include <linux/iommu.h>
 
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
 	for (__i = 0;							\
@@ -27,6 +28,22 @@ struct iotlb_entry {
 	u32 endian, elsz, mixed;
 };
 
+/**
+ * struct omap_iommu_domain - omap iommu domain
+ * @pgtable:	the page table
+ * @iommu_dev:	an omap iommu device attached to this domain. only a single
+ *		iommu device can be attached for now.
+ * @dev:	Device using this domain.
+ * @lock:	domain lock, should be taken when attaching/detaching
+ */
+struct omap_iommu_domain {
+	u32 *pgtable;
+	struct omap_iommu *iommu_dev;
+	struct device *dev;
+	spinlock_t lock;
+	struct iommu_domain domain;
+};
+
 struct omap_iommu {
 	const char	*name;
 	void __iomem	*regbase;
@@ -52,6 +69,21 @@ struct omap_iommu {
 	u32 id;
 };
 
+/**
+ * struct iommu_arch_data - omap iommu private data
+ * @name: name of the iommu device
+ * @iommu_dev: handle of the iommu device
+ *
+ * This is an omap iommu private data object, which binds an iommu user
+ * to its iommu device. This object should be placed at the iommu user's
+ * dev_archdata so generic IOMMU API can be used without having to
+ * utilize omap-specific plumbing anymore.
+ */
+struct omap_iommu_arch_data {
+	const char *name;
+	struct omap_iommu *iommu_dev;
+};
+
 struct cr_regs {
 	u32 cam;
 	u32 ram;
diff --git a/include/linux/platform_data/iommu-omap.h b/include/linux/platform_data/iommu-omap.h
index 0496d17..cd42721 100644
--- a/include/linux/platform_data/iommu-omap.h
+++ b/include/linux/platform_data/iommu-omap.h
@@ -12,23 +12,6 @@
 
 #include <linux/platform_device.h>
 
-#define MMU_REG_SIZE		256
-
-/**
- * struct iommu_arch_data - omap iommu private data
- * @name: name of the iommu device
- * @iommu_dev: handle of the iommu device
- *
- * This is an omap iommu private data object, which binds an iommu user
- * to its iommu device. This object should be placed at the iommu user's
- * dev_archdata so generic IOMMU API can be used without having to
- * utilize omap-specific plumbing anymore.
- */
-struct omap_iommu_arch_data {
-	const char *name;
-	struct omap_iommu *iommu_dev;
-};
-
 struct iommu_platform_data {
 	const char *name;
 	const char *reset_name;
-- 
1.9.1
