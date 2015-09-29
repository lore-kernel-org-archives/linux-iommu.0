From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [RFC PATCH 1/3] iommu: Add support for out of band flushing
Date: Tue, 29 Sep 2015 14:25:24 +0900
Message-ID: <1443504379-31841-2-git-send-email-tfiga@chromium.org>
References: <1443504379-31841-1-git-send-email-tfiga@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1443504379-31841-1-git-send-email-tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Nicolas Iooss <nicolas.iooss_linux-oWGTIYur0i8@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vince Hsu <vince.h-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch adds a new "flush" callback to iommu_ops, which is supposed
to perform any necessary flushes within given IOMMU domain to make any
changes to mappings of given area [iova; iova + size) be reflected to
IOMMU clients.

The purpose is to let IOMMU drivers skip page-by-page flushes and
replace it with one flush of full address range on devices which support
it.

Signed-off-by: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/iommu.c | 33 ++++++++++++++++++++++++++++++---
 include/linux/iommu.h |  2 ++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 049df49..d6bb8fe 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1286,8 +1286,15 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
 	return pgsize;
 }
 
-int iommu_map(struct iommu_domain *domain, unsigned long iova,
-	      phys_addr_t paddr, size_t size, int prot)
+static void iommu_flush(struct iommu_domain *domain, unsigned long iova,
+			size_t size)
+{
+	if (domain->ops->flush)
+		domain->ops->flush(domain, iova, size);
+}
+
+static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
+		       phys_addr_t paddr, size_t size, int prot)
 {
 	unsigned long orig_iova = iova;
 	unsigned int min_pagesz;
@@ -1340,6 +1347,20 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 
 	return ret;
 }
+
+int iommu_map(struct iommu_domain *domain, unsigned long iova,
+	      phys_addr_t paddr, size_t size, int prot)
+{
+	int ret;
+
+	ret = __iommu_map(domain, iova, paddr, size, prot);
+	if (ret)
+		return ret;
+
+	iommu_flush(domain, iova, size);
+
+	return 0;
+}
 EXPORT_SYMBOL_GPL(iommu_map);
 
 size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
@@ -1389,6 +1410,7 @@ size_t iommu_unmap(struct iommu_domain *domain, unsigned long iova, size_t size)
 		unmapped += unmapped_page;
 	}
 
+	iommu_flush(domain, orig_iova, unmapped);
 	trace_unmap(orig_iova, size, unmapped);
 	return unmapped;
 }
@@ -1419,19 +1441,24 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 		if (!IS_ALIGNED(s->offset, min_pagesz))
 			goto out_err;
 
-		ret = iommu_map(domain, iova + mapped, phys, s->length, prot);
+		ret = __iommu_map(domain, iova + mapped, phys, s->length, prot);
 		if (ret)
 			goto out_err;
 
 		mapped += s->length;
 	}
 
+	iommu_flush(domain, iova, mapped);
+
 	return mapped;
 
 out_err:
 	/* undo mappings already done */
 	iommu_unmap(domain, iova, mapped);
 
+	/* flush in case part of our mapping already got cached */
+	iommu_flush(domain, iova, mapped);
+
 	return 0;
 
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f9c1b6d..18e59a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -164,6 +164,8 @@ struct iommu_ops {
 		     size_t size);
 	size_t (*map_sg)(struct iommu_domain *domain, unsigned long iova,
 			 struct scatterlist *sg, unsigned int nents, int prot);
+	void (*flush)(struct iommu_domain *domain, unsigned long iova,
+		      size_t size);
 	phys_addr_t (*iova_to_phys)(struct iommu_domain *domain, dma_addr_t iova);
 	int (*add_device)(struct device *dev);
 	void (*remove_device)(struct device *dev);
-- 
2.6.0.rc2.230.g3dd15c0
