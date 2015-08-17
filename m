From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 1/1] iommu/vt-d: use lo_hi_readq() / lo_hi_writeq()
Date: Mon, 17 Aug 2015 17:04:12 +0300
Message-ID: <1439820252-109537-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is already helper functions to do 64-bit I/O on 32-bit machines or buses,
thus we don't need to reinvent the wheel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 include/linux/intel-iommu.h | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index a868a0f..5439ea4 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -26,6 +26,8 @@
 #include <linux/iova.h>
 #include <linux/io.h>
 #include <linux/dma_remapping.h>
+
+#include <asm-generic/io-64-nonatomic-lo-hi.h>
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -59,26 +61,15 @@
 #define DMAR_IRTA_REG	0xb8    /* Interrupt remapping table addr register */
 
 #define OFFSET_STRIDE		(9)
-/*
-#define dmar_readl(dmar, reg) readl(dmar + reg)
-#define dmar_readq(dmar, reg) ({ \
-		u32 lo, hi; \
-		lo = readl(dmar + reg); \
-		hi = readl(dmar + reg + 4); \
-		(((u64) hi) << 32) + lo; })
-*/
+
 static inline u64 dmar_readq(void __iomem *addr)
 {
-	u32 lo, hi;
-	lo = readl(addr);
-	hi = readl(addr + 4);
-	return (((u64) hi) << 32) + lo;
+	return lo_hi_readq(addr);
 }
 
 static inline void dmar_writeq(void __iomem *addr, u64 val)
 {
-	writel((u32)val, addr);
-	writel((u32)(val >> 32), addr + 4);
+	lo_hi_writeq(val, addr);
 }
 
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
-- 
2.5.0
