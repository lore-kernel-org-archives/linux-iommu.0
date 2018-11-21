From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Handle domain agaw being less than iommu agaw
Date: Wed, 21 Nov 2018 15:29:33 -0800
Message-ID: <20181121232933.158582-1-sohil.mehta@intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

The Intel IOMMU driver opportunistically skips a few top level page
tables from the domain paging directory while programming the IOMMU
context entry. However there is an implicit assumption in the code that
domain's adjusted guest address width (agaw) would always be greater
than IOMMU's agaw.

The IOMMU capabilities in an upcoming platform cause the domain's agaw
to be lower than IOMMU's agaw. The issue is seen when the IOMMU supports
both 4-level and 5-level paging. The domain builds a 4-level page table
based on agaw of 2. However the IOMMU's agaw is set as 3 (5-level). In
this case the code incorrectly tries to skip page page table levels.
This causes the IOMMU driver to avoid programming the context entry. The
fix handles this case and programs the context entry accordingly.

Fixes: de24e55395698 ("iommu/vt-d: Simplify domain_context_mapping_one")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reviewed-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Reported-by: Ramos Falcon, Ernesto R <ernesto.r.ramos.falcon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Tested-by: Ricardo Neri <ricardo.neri-calderon-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f3ccf025108b..fdf79baf1d79 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2044,7 +2044,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	 * than default.  Unnecessary for PT mode.
 	 */
 	if (translation != CONTEXT_TT_PASS_THROUGH) {
-		for (agaw = domain->agaw; agaw != iommu->agaw; agaw--) {
+		for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
 			ret = -ENOMEM;
 			pgd = phys_to_virt(dma_pte_addr(pgd));
 			if (!dma_pte_present(pgd))
@@ -2058,7 +2058,7 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 			translation = CONTEXT_TT_MULTI_LEVEL;
 
 		context_set_address_root(context, virt_to_phys(pgd));
-		context_set_address_width(context, iommu->agaw);
+		context_set_address_width(context, agaw);
 	} else {
 		/*
 		 * In pass through mode, AW must be programmed to
-- 
2.19.0
