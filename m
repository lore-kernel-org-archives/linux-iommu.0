From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 08/26] iommu/vt-d: Don't pre-allocate domain ids for si_domain
Date: Wed,  5 Aug 2015 17:18:39 +0200
Message-ID: <1438787937-7340-9-git-send-email-joro@8bytes.org>
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

There is no reason for this special handling of the
si_domain. The per-iommu domain-id can be allocated
on-demand like for any other domain. So remove the
pre-allocation code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 31e8100..35a918e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2556,37 +2556,18 @@ static int md_domain_init(struct dmar_domain *domain, int guest_width);
 
 static int __init si_domain_init(int hw)
 {
-	struct dmar_drhd_unit *drhd;
-	struct intel_iommu *iommu;
 	int nid, ret = 0;
-	bool first = true;
 
 	si_domain = alloc_domain(DOMAIN_FLAG_STATIC_IDENTITY);
 	if (!si_domain)
 		return -EFAULT;
 
-	for_each_active_iommu(iommu, drhd) {
-		ret = iommu_attach_domain(si_domain, iommu);
-		if (ret < 0) {
-			domain_exit(si_domain);
-			return -EFAULT;
-		} else if (first) {
-			si_domain->id = ret;
-			first = false;
-		} else if (si_domain->id != ret) {
-			domain_exit(si_domain);
-			return -EFAULT;
-		}
-		domain_attach_iommu(si_domain, iommu);
-	}
-
 	if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
 		domain_exit(si_domain);
 		return -EFAULT;
 	}
 
-	pr_debug("Identity mapping domain is domain %d\n",
-		 si_domain->id);
+	pr_debug("Identity mapping domain allocated\n");
 
 	if (hw)
 		return 0;
@@ -4195,13 +4176,6 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
 	iommu_enable_translation(iommu);
 
-	if (si_domain) {
-		ret = iommu_attach_domain(si_domain, iommu);
-		if (ret < 0 || si_domain->id != ret)
-			goto disable_iommu;
-		domain_attach_iommu(si_domain, iommu);
-	}
-
 	iommu_disable_protect_mem_regions(iommu);
 	return 0;
 
-- 
1.9.1
