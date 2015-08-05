From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 11/26] iommu/vt-d: Simplify io/tlb flushing in
	intel_iommu_unmap
Date: Wed,  5 Aug 2015 17:18:42 +0200
Message-ID: <1438787937-7340-12-git-send-email-joro@8bytes.org>
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

We don't need to do an expensive search for domain-ids
anymore, as we keep track of per-iommu domain-ids.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index c46afb6..ae2343c 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4811,7 +4811,7 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	struct intel_iommu *iommu;
 	unsigned long start_pfn, last_pfn;
 	unsigned int npages;
-	int iommu_id, num, ndomains, level = 0;
+	int iommu_id, level = 0;
 
 	/* Cope with horrid API which requires us to unmap more than the
 	   size argument if it happens to be a large-page mapping. */
@@ -4831,17 +4831,8 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 	for_each_domain_iommu(iommu_id, dmar_domain) {
 		iommu = g_iommus[iommu_id];
 
-		/*
-		 * find bit position of dmar_domain
-		 */
-		ndomains = cap_ndoms(iommu->cap);
-		for_each_set_bit(num, iommu->domain_ids, ndomains) {
-			if (get_iommu_domain(iommu, num) == dmar_domain)
-				iommu_flush_iotlb_psi(iommu, dmar_domain,
-						      start_pfn, npages,
-						      !freelist, 0);
-		}
-
+		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
+				      start_pfn, npages, !freelist, 0);
 	}
 
 	dma_free_pagelist(freelist);
-- 
1.9.1
