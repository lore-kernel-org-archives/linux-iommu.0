From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Fix VM domain ID leak
Date: Tue, 14 Jul 2015 14:48:53 -0600
Message-ID: <20150714204731.10189.28556.stgit@gimli.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This continues the attempt to fix commit fb170fb4c548 ("iommu/vt-d:
Introduce helper functions to make code symmetric for readability").
The previous attempt in commit 71684406905f ("iommu/vt-d: Detach
domain *only* from attached iommus") overlooked the fact that
dmar_domain.iommu_bmp gets cleared for VM domains when devices are
detached:

intel_iommu_detach_device
  domain_remove_one_dev_info
    domain_detach_iommu

The domain is detached from the iommu, but the iommu is still attached
to the domain, for whatever reason.  Thus when we get to domain_exit(),
we can't rely on iommu_bmp for VM domains to find the active iommus,
we must check them all.  Without that, the corresponding bit in
intel_iommu.domain_ids doesn't get cleared and repeated VM domain
creation and destruction will run out of domain IDs.  Meanwhile we
still can't call iommu_detach_domain() on arbitrary non-VM domains or
we risk clearing in-use domain IDs, as 71684406905f attempted to
address.

It's tempting to modify iommu_detach_domain() to test the domain
iommu_bmp, but the call ordering from domain_remove_one_dev_info()
prevents it being able to work as fb170fb4c548 seems to have intended.
Caching of unused VM domains on the iommu object seems to be the root
of the problem, but this code is far too fragile for that kind of
rework to be proposed for stable, so we simply revert this chunk to
its state prior to fb170fb4c548.

Fixes: fb170fb4c548 ("iommu/vt-d: Introduce helper functions to make
                      code symmetric for readability")
Fixes: 71684406905f ("iommu/vt-d: Detach domain *only* from attached
                      iommus")
Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v3.17+
---
 drivers/iommu/intel-iommu.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index a98a7b2..0649b94 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1830,8 +1830,9 @@ static int domain_init(struct dmar_domain *domain, int guest_width)
 
 static void domain_exit(struct dmar_domain *domain)
 {
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
 	struct page *freelist = NULL;
-	int i;
 
 	/* Domain 0 is reserved, so dont process it */
 	if (!domain)
@@ -1851,8 +1852,10 @@ static void domain_exit(struct dmar_domain *domain)
 
 	/* clear attached or cached domains */
 	rcu_read_lock();
-	for_each_set_bit(i, domain->iommu_bmp, g_num_of_iommus)
-		iommu_detach_domain(domain, g_iommus[i]);
+	for_each_active_iommu(iommu, drhd)
+		if (domain_type_is_vm(domain) ||
+		    test_bit(iommu->seq_id, domain->iommu_bmp))
+			iommu_detach_domain(domain, iommu);
 	rcu_read_unlock();
 
 	dma_free_pagelist(freelist);
