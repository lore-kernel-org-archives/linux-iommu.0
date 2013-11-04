From: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Subject: [PATCH v2] KVM: IOMMU: hva align mapping page size
Date: Mon, 4 Nov 2013 09:08:12 -0700
Message-ID: <20131104160812.GA6026@psuche>
References: <20131101160855.GB5052@psuche>
 <20131102011433.GA30381@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131102011433.GA30381-I4X2Mt4zSy4@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

When determining the page size we could use to map with the IOMMU, the
page size should also be aligned with the hva, not just the gfn.  The
gfn may not reflect the real alignment within the hugetlbfs file.

Signed-off-by: Greg Edwards <gedwards-LfVdkaOWEx8@public.gmane.org>
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
 virt/kvm/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/virt/kvm/iommu.c b/virt/kvm/iommu.c
index 72a130b..c329c8f 100644
--- a/virt/kvm/iommu.c
+++ b/virt/kvm/iommu.c
@@ -103,6 +103,10 @@ int kvm_iommu_map_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
 		while ((gfn << PAGE_SHIFT) & (page_size - 1))
 			page_size >>= 1;
 
+		/* Make sure hva is aligned to the page size we want to map */
+		while (__gfn_to_hva_memslot(slot, gfn) & (page_size - 1))
+			page_size >>= 1;
+
 		/*
 		 * Pin all pages we are about to map in memory. This is
 		 * important because we unmap and unpin in 4kb steps later.
-- 
1.8.3.2
