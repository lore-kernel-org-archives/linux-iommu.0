From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v2] io-64-nonatomic: Add relaxed accessor variants
Date: Tue, 26 Apr 2016 11:38:20 +0100
Message-ID: <4eeca6f53113aca2ab7a645339c78235999ee7a9.1461666736.git.robin.murphy@arm.com>
References: <cover.1460391217.git.robin.murphy@arm.com>
	<44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <44173fd4e8efd27d670cadc6b30e215243a14099.1460391217.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Whilst commit 9439eb3ab9d1 ("asm-generic: io: implement relaxed
accessor macros as conditional wrappers") makes the *_relaxed forms of
I/O accessors universally available to drivers, in cases where writeq()
is implemented via the io-64-nonatomic helpers, writeq_relaxed() will
end up falling back to writel() regardless of whether writel_relaxed()
is available (identically for s/write/read/).

Add corresponding relaxed forms of the nonatomic helpers to delegate
to the equivalent 32-bit accessors as appropriate. We also need to fix
io.h to avoid defining default relaxed variants if the basic accessors
themselves don't exist.

CC: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
CC: Darren Hart <dvhart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
CC: Hitoshi Mitake <mitake.hitoshi-Zyj7fXuS5i5L9jVzuh4AOg@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Changes since v1:
- Fix the embarassing copy-paste errors which we all managed to miss.
- Fix io.h so that the nonatomic relaxed definitions are actually used.

Arnd, I've taken the liberty of leaving your ack in place for the
additional io.h tweak - please yell at me if that's not OK.

Robin.

 include/asm-generic/io.h              |  4 ++--
 include/linux/io-64-nonatomic-hi-lo.h | 25 +++++++++++++++++++++++++
 include/linux/io-64-nonatomic-lo-hi.h | 25 +++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index eed3bbe88c8a..002b81f6f2bc 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -191,7 +191,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #define readl_relaxed readl
 #endif
 
-#ifndef readq_relaxed
+#if defined(readq) && !defined(readq_relaxed)
 #define readq_relaxed readq
 #endif
 
@@ -207,7 +207,7 @@ static inline void writeq(u64 value, volatile void __iomem *addr)
 #define writel_relaxed writel
 #endif
 
-#ifndef writeq_relaxed
+#if defined(writeq) && !defined(writeq_relaxed)
 #define writeq_relaxed writeq
 #endif
 
diff --git a/include/linux/io-64-nonatomic-hi-lo.h b/include/linux/io-64-nonatomic-hi-lo.h
index 11d7e840d913..defcc4644ce3 100644
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
+#define writeq_relaxed hi_lo_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_HI_LO_H_ */
diff --git a/include/linux/io-64-nonatomic-lo-hi.h b/include/linux/io-64-nonatomic-lo-hi.h
index 1a4315f97360..084461a4e5ab 100644
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
+#define readq_relaxed lo_hi_readq_relaxed
+#endif
+
+#ifndef writeq_relaxed
+#define writeq_relaxed lo_hi_writeq_relaxed
+#endif
+
 #endif	/* _LINUX_IO_64_NONATOMIC_LO_HI_H_ */
-- 
2.8.1.dirty
