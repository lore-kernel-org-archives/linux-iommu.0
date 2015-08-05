From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 02/26] iommu/vt-d: Add access functions for iommu->domains
Date: Wed,  5 Aug 2015 17:18:33 +0200
Message-ID: <1438787937-7340-3-git-send-email-joro@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438787937-7340-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

This makes it easier to change the layout of the data
structure later.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c3c5167..e6a5966 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -567,6 +567,17 @@ __setup("intel_iommu=", intel_iommu_setup);
 static struct kmem_cache *iommu_domain_cache;
 static struct kmem_cache *iommu_devinfo_cache;
 
+static struct dmar_domain* get_iommu_domain(struct intel_iommu *iommu, u16 did)
+{
+	return iommu->domains[did];
+}
+
+static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
+			     struct dmar_domain *domain)
+{
+	iommu->domains[did] = domain;
+}
+
 static inline void *alloc_pgtable_page(int node)
 {
 	struct page *page;
@@ -1461,7 +1472,8 @@ static void iommu_flush_iotlb_psi(struct intel_iommu *iommu, u16 did,
 	 * flush. However, device IOTLB doesn't need to be flushed in this case.
 	 */
 	if (!cap_caching_mode(iommu->cap) || !map)
-		iommu_flush_dev_iotlb(iommu->domains[did], addr, mask);
+		iommu_flush_dev_iotlb(get_iommu_domain(iommu, did),
+				      addr, mask);
 }
 
 static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
@@ -1571,7 +1583,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
 			if (i == 0)
 				continue;
 
-			domain = iommu->domains[i];
+			domain = get_iommu_domain(iommu, i);
 			clear_bit(i, iommu->domain_ids);
 			if (domain_detach_iommu(domain, iommu) == 0 &&
 			    !domain_type_is_vm(domain))
@@ -1629,7 +1641,7 @@ static int __iommu_attach_domain(struct dmar_domain *domain,
 	num = find_first_zero_bit(iommu->domain_ids, ndomains);
 	if (num < ndomains) {
 		set_bit(num, iommu->domain_ids);
-		iommu->domains[num] = domain;
+		set_iommu_domain(iommu, num, domain);
 		domain->iommu_did[iommu->seq_id] = num;
 	} else {
 		num = -ENOSPC;
@@ -1678,7 +1690,7 @@ static void iommu_detach_domain(struct dmar_domain *domain,
 	WARN_ON(num == 0);
 
 	clear_bit(num, iommu->domain_ids);
-	iommu->domains[num]		 = NULL;
+	set_iommu_domain(iommu, num, NULL);
 
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
@@ -4828,7 +4840,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
                 */
                ndomains = cap_ndoms(iommu->cap);
                for_each_set_bit(num, iommu->domain_ids, ndomains) {
-                       if (iommu->domains[num] == dmar_domain)
+                       if (get_iommu_domain(iommu, num) == dmar_domain)
                                iommu_flush_iotlb_psi(iommu, num, start_pfn,
 						     npages, !freelist, 0);
 	       }
-- 
1.9.1
