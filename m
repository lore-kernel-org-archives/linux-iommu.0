From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v1 4/4] iommu/tegra: gart: Optimize map/unmap
Date: Mon,  9 Apr 2018 23:07:22 +0300
Message-ID: <f21a7b6a8f141b87f75687904a76f3728ea639a8.1523304324.git.digetx@gmail.com>
References: <cover.1523304324.git.digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1523304324.git.digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Currently GART writes one page entry at a time. More optimal would be to
aggregate the writes and flush BUS buffer in the end, this gives map/unmap
10-40% (depending on size of mapping) performance boost compared to a
flushing after each entry update.

Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-gart.c | 63 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 4a0607669d34..9f59f5f17661 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -36,7 +36,7 @@
 #define GART_APERTURE_SIZE	SZ_32M
 
 /* bitmap of the page sizes currently supported */
-#define GART_IOMMU_PGSIZES	(SZ_4K)
+#define GART_IOMMU_PGSIZES	GENMASK(24, 12)
 
 #define GART_REG_BASE		0x24
 #define GART_CONFIG		(0x24 - GART_REG_BASE)
@@ -269,25 +269,21 @@ static void gart_iommu_domain_free(struct iommu_domain *domain)
 	kfree(gart_domain);
 }
 
-static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
-			  phys_addr_t pa, size_t bytes, int prot)
+static int gart_iommu_map_page(struct gart_device *gart,
+			       unsigned long iova,
+			       phys_addr_t pa)
 {
-	struct gart_domain *gart_domain = to_gart_domain(domain);
-	struct gart_device *gart = gart_domain->gart;
 	unsigned long flags;
 	unsigned long pfn;
 	unsigned long pte;
 
-	if (!gart_iova_range_valid(gart, iova, bytes))
-		return -EINVAL;
-
-	spin_lock_irqsave(&gart->pte_lock, flags);
 	pfn = __phys_to_pfn(pa);
 	if (!pfn_valid(pfn)) {
 		dev_err(gart->dev, "Invalid page: %pa\n", &pa);
-		spin_unlock_irqrestore(&gart->pte_lock, flags);
 		return -EINVAL;
 	}
+
+	spin_lock_irqsave(&gart->pte_lock, flags);
 	if (gart_debug) {
 		pte = gart_read_pte(gart, iova);
 		if (pte & GART_ENTRY_PHYS_ADDR_VALID) {
@@ -297,8 +293,41 @@ static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
 		}
 	}
 	gart_set_pte(gart, iova, GART_PTE(pfn));
+	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
+	return 0;
+}
+
+static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
+			  phys_addr_t pa, size_t bytes, int prot)
+{
+	struct gart_domain *gart_domain = to_gart_domain(domain);
+	struct gart_device *gart = gart_domain->gart;
+	size_t mapped;
+	int ret = -1;
+
+	if (!gart_iova_range_valid(gart, iova, bytes))
+		return -EINVAL;
+
+	for (mapped = 0; mapped < bytes; mapped += GART_PAGE_SIZE) {
+		ret = gart_iommu_map_page(gart, iova + mapped, pa + mapped);
+		if (ret)
+			break;
+	}
+
 	FLUSH_GART_REGS(gart);
+	return ret;
+}
+
+static int gart_iommu_unmap_page(struct gart_device *gart,
+				 unsigned long iova)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&gart->pte_lock, flags);
+	gart_set_pte(gart, iova, 0);
 	spin_unlock_irqrestore(&gart->pte_lock, flags);
+
 	return 0;
 }
 
@@ -307,16 +336,20 @@ static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 {
 	struct gart_domain *gart_domain = to_gart_domain(domain);
 	struct gart_device *gart = gart_domain->gart;
-	unsigned long flags;
+	size_t unmapped;
+	int ret;
 
 	if (!gart_iova_range_valid(gart, iova, bytes))
 		return 0;
 
-	spin_lock_irqsave(&gart->pte_lock, flags);
-	gart_set_pte(gart, iova, 0);
+	for (unmapped = 0; unmapped < bytes; unmapped += GART_PAGE_SIZE) {
+		ret = gart_iommu_unmap_page(gart, iova + unmapped);
+		if (ret)
+			break;
+	}
+
 	FLUSH_GART_REGS(gart);
-	spin_unlock_irqrestore(&gart->pte_lock, flags);
-	return bytes;
+	return unmapped;
 }
 
 static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
-- 
2.16.3
