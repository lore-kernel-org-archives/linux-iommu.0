From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 1/1] iommu/vt-d: use lo_hi_readq() / lo_hi_writeq()
Date: Thu, 19 Nov 2015 18:22:47 +0200
Message-ID: <1447950167-111241-1-git-send-email-andriy.shevchenko@linux.intel.com>
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
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

There is already helper functions to do 64-bit I/O on 32-bit machines or buses,
thus we don't need to reinvent the wheel.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
Cahngelog v2:
- rebase on top of recent linux-next
 include/linux/intel-iommu.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 821273c..34066ee 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -29,6 +29,8 @@
 #include <linux/dma_remapping.h>
 #include <linux/mmu_notifier.h>
 #include <linux/list.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
 #include <asm/cacheflush.h>
 #include <asm/iommu.h>
 
@@ -71,24 +73,8 @@
 
 #define OFFSET_STRIDE		(9)
 
-#ifdef CONFIG_64BIT
 #define dmar_readq(a) readq(a)
 #define dmar_writeq(a,v) writeq(v,a)
-#else
-static inline u64 dmar_readq(void __iomem *addr)
-{
-	u32 lo, hi;
-	lo = readl(addr);
-	hi = readl(addr + 4);
-	return (((u64) hi) << 32) + lo;
-}
-
-static inline void dmar_writeq(void __iomem *addr, u64 val)
-{
-	writel((u32)val, addr);
-	writel((u32)(val >> 32), addr + 4);
-}
-#endif
 
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
 #define DMAR_VER_MINOR(v)		((v) & 0x0f)
-- 
2.6.2
