From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] iommu: Add dummy implementations for !IOMMU_IOVA
Date: Mon, 20 Mar 2017 20:11:28 +0100
Message-ID: <20170320191128.26474-2-thierry.reding@gmail.com>
References: <20170320191128.26474-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170320191128.26474-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Currently, building code which uses the API guarded by the IOMMU_IOVA
will fail to link if IOMMU_IOVA is not enabled. Often this code will be
using the API provided by the IOMMU_API Kconfig symbol, but support for
this can be optional, with code falling back to contiguous memory. This
commit implements dummy functions for the IOVA API so that it can be
compiled out.

With both IOMMU_API and IOMMU_IOVA optional, code can now be built with
or without support for IOMMU without having to resort to #ifdefs in the
user code.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/linux/iova.h | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/include/linux/iova.h b/include/linux/iova.h
index f27bb2c62fca..548982ad5f2f 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -82,6 +82,7 @@ static inline unsigned long iova_pfn(struct iova_domain *iovad, dma_addr_t iova)
 	return iova >> iova_shift(iovad);
 }
 
+#ifdef CONFIG_IOMMU_IOVA
 int iova_cache_get(void);
 void iova_cache_put(void);
 
@@ -106,5 +107,95 @@ void put_iova_domain(struct iova_domain *iovad);
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
 	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
+#else
+static inline int iova_cache_get(void)
+{
+	return -ENOTSUPP;
+}
+
+static inline void iova_cache_put(void)
+{
+}
+
+static inline struct iova *alloc_iova_mem(void)
+{
+	return NULL;
+}
+
+static inline void free_iova_mem(struct iova *iova)
+{
+}
+
+static inline void free_iova(struct iova_domain *iovad, unsigned long pfn)
+{
+}
+
+static inline void __free_iova(struct iova_domain *iovad, struct iova *iova)
+{
+}
+
+static inline struct iova *alloc_iova(struct iova_domain *iovad,
+				      unsigned long size,
+				      unsigned long limit_pfn,
+				      bool size_aligned)
+{
+	return NULL;
+}
+
+static inline void free_iova_fast(struct iova_domain *iovad,
+				  unsigned long pfn,
+				  unsigned long size)
+{
+}
+
+static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
+					    unsigned long size,
+					    unsigned long limit_pfn)
+{
+	return 0;
+}
+
+static inline struct iova *reserve_iova(struct iova_domain *iovad,
+					unsigned long pfn_lo,
+					unsigned long pfn_hi)
+{
+	return NULL;
+}
+
+static inline void copy_reserved_iova(struct iova_domain *from,
+				      struct iova_domain *to)
+{
+}
+
+static inline void init_iova_domain(struct iova_domain *iovad,
+				    unsigned long granule,
+				    unsigned long start_pfn,
+				    unsigned long pfn_32bit)
+{
+}
+
+static inline struct iova *find_iova(struct iova_domain *iovad,
+				     unsigned long pfn)
+{
+	return NULL;
+}
+
+static inline void put_iova_domain(struct iova_domain *iovad)
+{
+}
+
+static inline struct iova *split_and_remove_iova(struct iova_domain *iovad,
+						 struct iova *iova,
+						 unsigned long pfn_lo,
+						 unsigned long pfn_hi)
+{
+	return NULL;
+}
+
+static inline void free_cpu_cached_iovas(unsigned int cpu,
+					 struct iova_domain *iovad)
+{
+}
+#endif
 
 #endif
-- 
2.12.0
