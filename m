From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH/RFC 1/4] iommu: dma: track mapped iova
Date: Wed, 25 Jan 2017 21:53:59 +0900
Message-ID: <1485348842-23712-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1485348842-23712-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

To track mapped iova for a workaround code in the future.

Signed-off-by: Magnus Damm <damm+renesas-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/iommu/dma-iommu.c | 29 +++++++++++++++++++++++------
 include/linux/iommu.h     |  2 ++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 2db0d64..a0b8c0f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -19,6 +19,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/dma-iommu.h>
 #include <linux/gfp.h>
@@ -147,6 +148,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
 	end_pfn = (base + size - 1) >> order;
+	atomic_set(&domain->iova_pfns_mapped, 0);
 
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
@@ -209,6 +211,7 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 	struct iova_domain *iovad = cookie_iovad(domain);
 	unsigned long shift = iova_shift(iovad);
 	unsigned long length = iova_align(iovad, size) >> shift;
+	struct iova *iova;
 
 	if (domain->geometry.force_aperture)
 		dma_limit = min(dma_limit, domain->geometry.aperture_end);
@@ -216,9 +219,23 @@ static struct iova *__alloc_iova(struct iommu_domain *domain, size_t size,
 	 * Enforce size-alignment to be safe - there could perhaps be an
 	 * attribute to control this per-device, or at least per-domain...
 	 */
-	return alloc_iova(iovad, length, dma_limit >> shift, true);
+	iova = alloc_iova(iovad, length, dma_limit >> shift, true);
+	if (iova)
+		atomic_add(iova_size(iova), &domain->iova_pfns_mapped);
+
+	return iova;
 }
 
+void
+__free_iova_domain(struct iommu_domain *domain, struct iova *iova)
+{
+	struct iova_domain *iovad = cookie_iovad(domain);
+
+	atomic_sub(iova_size(iova), &domain->iova_pfns_mapped);
+	__free_iova(iovad, iova);
+}
+
+
 /* The IOVA allocator knows what we mapped, so just unmap whatever that was */
 static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
 {
@@ -235,7 +252,7 @@ static void __iommu_dma_unmap(struct iommu_domain *domain, dma_addr_t dma_addr)
 	size -= iommu_unmap(domain, pfn << shift, size);
 	/* ...and if we can't, then something is horribly, horribly wrong */
 	WARN_ON(size > 0);
-	__free_iova(iovad, iova);
+	__free_iova_domain(domain, iova);
 }
 
 static void __iommu_dma_free_pages(struct page **pages, int count)
@@ -401,7 +418,7 @@ struct page **iommu_dma_alloc(struct device *dev, size_t size, gfp_t gfp,
 out_free_sg:
 	sg_free_table(&sgt);
 out_free_iova:
-	__free_iova(iovad, iova);
+	__free_iova_domain(domain, iova);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -447,7 +464,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 
 	dma_addr = iova_dma_addr(iovad, iova);
 	if (iommu_map(domain, dma_addr, phys - iova_off, len, prot)) {
-		__free_iova(iovad, iova);
+		__free_iova_domain(domain, iova);
 		return DMA_ERROR_CODE;
 	}
 	return dma_addr + iova_off;
@@ -613,7 +630,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	return __finalise_sg(dev, sg, nents, dma_addr);
 
 out_free_iova:
-	__free_iova(iovad, iova);
+	__free_iova_domain(domain, iova);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 	return 0;
@@ -689,7 +706,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return msi_page;
 
 out_free_iova:
-	__free_iova(iovad, iova);
+	__free_iova_domain(domain, iova);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ff5111..91d0159 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -19,6 +19,7 @@
 #ifndef __LINUX_IOMMU_H
 #define __LINUX_IOMMU_H
 
+#include <linux/atomic.h>
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <linux/of.h>
@@ -84,6 +85,7 @@ struct iommu_domain {
 	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	void *iova_cookie;
+	atomic_t iova_pfns_mapped;
 };
 
 enum iommu_cap {
-- 
1.9.1
