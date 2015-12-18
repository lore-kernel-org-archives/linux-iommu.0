From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/2] io-64-nonatomic: Add relaxed accessor variants
Date: Fri, 18 Dec 2015 18:54:45 +0000
Message-ID: <a2664d5691ff1889d80c711577cbd20680191b98.1450464706.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
accessor macros as conditional wrappers") makes the *_relaxed forms of
I/O accessors universally available to drivers, in cases where writeq()
is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
end up falling back to writel() regardless of whether writel_relaxed()
is available (identically for s/write/read/).

Add corresponding relaxed forms of the nonatomic helpers to delegate
to the equivalent 32-bit accessors as appropriate.

CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
CC: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
CC: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 include/linux/io-64-nonatomic-hi-lo.h | 25 +++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index 11d7e84..1a85566 100644
--- a/include/linux/io-64-nonatomic-hi-lo.h
+++ b/include/linux/io-64-nonatomic-hi-lo.h
@@ -21,6 +21,23 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
 	writel(val, addr);
 }
 
+static inline __u64 hi_lo_readq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	high = readl_relaxed(p + 1);
+	low = readl_relaxed(p);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void hi_lo_writeq_relaxed(__u64 val, volatile void __iomem *addr)
+{
+	writel_relaxed(val >> 32, addr + 4);
+	writel_relaxed(val, addr);
+}
+
 #ifndef readq
 #define readq hi_lo_readq
 #endif
@@ -29,4 +46,12 @@ static inline void hi_lo_writeq(__u64 val, volatile void __iomem *addr)
 #define writeq hi_lo_writeq
 #endif
 
+#ifndef readq_relaxed
+#define readq_relaxed hi_lo_readq_relaxed
+#endif
+
+#ifndef writeq_relaxed
+#define writeq hi_lo_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index 1a4315f..1b7411d 100644
--- a/include/linux/io-64-nonatomic-lo-hi.h
+++ b/include/linux/io-64-nonatomic-lo-hi.h
@@ -21,6 +21,23 @@ static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
 	writel(val >> 32, addr + 4);
 }
 
+static inline __u64 lo_hi_readq_relaxed(const volatile void __iomem *addr)
+{
+	const volatile u32 __iomem *p = addr;
+	u32 low, high;
+
+	low = readl_relaxed(p);
+	high = readl_relaxed(p + 1);
+
+	return low + ((u64)high << 32);
+}
+
+static inline void lo_hi_writeq_relaxed(__u64 val, volatile void __iomem *addr)
+{
+	writel_relaxed(val, addr);
+	writel_relaxed(val >> 32, addr + 4);
+}
+
 #ifndef readq
 #define readq lo_hi_readq
 #endif
@@ -29,4 +46,12 @@ static inline void lo_hi_writeq(__u64 val, volatile void __iomem *addr)
 #define writeq lo_hi_writeq
 #endif
 
+#ifndef readq_relaxed
+#define readq_relaxed hi_lo_readq_relaxed
+#endif
+
+#ifndef writeq_relaxed
+#define writeq hi_lo_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
-- 
1.9.1
