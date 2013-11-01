From: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Subject: [PATCH] KVM: IOMMU: hva align mapping page size
Date: Fri, 1 Nov 2013 10:08:55 -0600
Message-ID: <20131101160855.GB5052@psuche>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When determining the page size we could use to map with the IOMMU, the
page size should be aligned with the hva, not the gfn.  The gfn may not
reflect the real alignment within the hugetlbfs file.

Most of the time, this works fine.  However, if the hugetlbfs file is
backed by non-contiguous huge pages, a multi-huge page memslot starts at
an unaligned offset within the hugetlbfs file, and the gfn is aligned
with respect to the huge page size, kvm_host_page_size() will return the
huge page size and we will use that to map with the IOMMU.

When we later unpin that same memslot, the IOMMU returns the unmap size
as the huge page size, and we happily unpin that many pfns in
monotonically increasing order, not realizing we are spanning
non-contiguous huge pages and partially unpin the wrong huge page.

Instead, ensure the IOMMU mapping page size is aligned with the hva
corresponding to the gfn, which does reflect the alignment within the
hugetlbfs file.

Signed-off-by: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
This resolves the bug previously reported (and misdiagnosed) here:

 http://www.spinics.net/lists/kvm/msg97599.html

 virt/kvm/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/iommu.c b/virt/kvm/iommu.c
index 72a130b..0e2ff32 100644
--- a/virt/kvm/iommu.c
+++ b/virt/kvm/iommu.c
@@ -99,8 +99,8 @@ int kvm_iommu_map_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
 		while ((gfn + (page_size >> PAGE_SHIFT)) > end_gfn)
 			page_size >>= 1;
 
-		/* Make sure gfn is aligned to the page size we want to map */
-		while ((gfn << PAGE_SHIFT) & (page_size - 1))
+		/* Make sure hva is aligned to the page size we want to map */
+		while (__gfn_to_hva_memslot(slot, gfn) & (page_size - 1))
 			page_size >>= 1;
 
 		/*
-- 
1.8.3.2
