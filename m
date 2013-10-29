From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/intel: SNP bit is not dependent on iommu domain
	coherency
Date: Tue, 29 Oct 2013 10:21:34 -0600
Message-ID: <20131029162126.23362.58786.stgit@bling.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The setting of the SNP bit in the intel-iommu page tables should not
be dependent on the current capability of the iommu domain.  The
current VT-d spec (2.2) indicates the SNP bit is "treated as
reserved[0] by hardware implementations not supporting Snoop Control".
Furthermore, section 3.7.3 indicates:

  If the Snoop Control (SC) field in extended capability Register is
  reported as 0, snoop behavior for access to the page mapped through
  second-level translation is determined by the no-snoop attribute in
  the request.

This all seems to indicate that hardware incapable of Snoop Control
will handle the SNP bit as zero regardless of the value stored in
the PTE.

The trouble with the current implementation is that mapping flags
depend on the state of the iommu domain at the time of the mapping,
yet no attempt is made to update existing mappings when the iommu
domain composition changes.  This leaves the iommu domain in a state
where some mappings may enforce coherency, others do not, and the user
of the IOMMU API has no ability to later enable the desired flags
atomically with respect to DMA.

If we always honor the IOMMU_CACHE flag then an IOMMU API user who
specifies IOMMU_CACHE for all mappings can assume that the coherency
of the mappings within a domain follow the coherency capability of
the domain itself.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 15e9b57..c46c6a6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4084,7 +4084,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-	if ((iommu_prot & IOMMU_CACHE) && dmar_domain->iommu_snooping)
+	if (iommu_prot & IOMMU_CACHE)
 		prot |= DMA_PTE_SNP;
 
 	max_addr = iova + size;
