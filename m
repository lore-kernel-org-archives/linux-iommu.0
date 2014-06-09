From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: [PATCH 3.14 78/78] [stable PATCH] iommu/vt-d: Fix missing IOTLB flush
	in intel_iommu_unmap()
Date: Mon,  9 Jun 2014 15:48:58 -0700
Message-ID: <20140609224815.816758729@linuxfoundation.org>
References: <20140609224813.282275135@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140609224813.282275135-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

3.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Based on commit ea8ea460c9ace60bbb5ac6e5521d637d5c15293d upstream

This missing IOTLB flush was added as a minor, inconsequential bug-fix
in commit ea8ea460c ("iommu/vt-d: Clean up and fix page table clear/free
behaviour") in 3.15. It wasn't originally intended for -stable but a
couple of users have reported issues which turn out to be fixed by
adding the missing flush.

Signed-off-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
For 3.14 and earlier. As noted, this fix is in 3.15 already.

 drivers/iommu/intel-iommu.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4075,7 +4075,7 @@ static size_t intel_iommu_unmap(struct i
 			     unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = domain->priv;
-	int order;
+	int order, iommu_id;
 
 	order = dma_pte_clear_range(dmar_domain, iova >> VTD_PAGE_SHIFT,
 			    (iova + size - 1) >> VTD_PAGE_SHIFT);
@@ -4083,6 +4083,22 @@ static size_t intel_iommu_unmap(struct i
 	if (dmar_domain->max_addr == iova + size)
 		dmar_domain->max_addr = iova;
 
+	for_each_set_bit(iommu_id, dmar_domain->iommu_bmp, g_num_of_iommus) {
+		struct intel_iommu *iommu = g_iommus[iommu_id];
+		int num, ndomains;
+
+		/*
+		 * find bit position of dmar_domain
+		 */
+		ndomains = cap_ndoms(iommu->cap);
+		for_each_set_bit(num, iommu->domain_ids, ndomains) {
+			if (iommu->domains[num] == dmar_domain)
+				iommu_flush_iotlb_psi(iommu, num,
+						      iova >> VTD_PAGE_SHIFT,
+						      1 << order, 0);
+		}
+	}
+
 	return PAGE_SIZE << order;
 }
 
