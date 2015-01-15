From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 3/3] vfio/type1: Add conditional rescheduling
Date: Thu, 15 Jan 2015 10:35:26 -0700
Message-ID: <20150115173526.29162.63925.stgit@gimli.home>
References: <20150115171023.29162.90105.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150115171023.29162.90105.stgit@gimli.home>
Sender: kvm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

IOMMU operations can be expensive and it's not very difficult for a
user to give us a lot of work to do for a map or unmap operation.
Killing a large VM will vfio assigned devices can result in soft
lockups and IOMMU tracing shows that we can easily spend 80% of our
time with need-resched set.  A sprinkling of conf_resched() calls
after map and unmap calls has a very tiny affect on performance
while resulting in traces with <1% of calls overflowing into needs-
resched.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

 drivers/vfio/vfio_iommu_type1.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 35c9008..57d8c37 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -351,8 +351,10 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 	domain = d = list_first_entry(&iommu->domain_list,
 				      struct vfio_domain, next);
 
-	list_for_each_entry_continue(d, &iommu->domain_list, next)
+	list_for_each_entry_continue(d, &iommu->domain_list, next) {
 		iommu_unmap(d->domain, dma->iova, dma->size);
+		cond_resched();
+	}
 
 	while (iova < end) {
 		size_t unmapped, len;
@@ -384,6 +386,8 @@ static void vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma)
 					     unmapped >> PAGE_SHIFT,
 					     dma->prot, false);
 		iova += unmapped;
+
+		cond_resched();
 	}
 
 	vfio_lock_acct(-unlocked);
@@ -528,6 +532,8 @@ static int vfio_iommu_map(struct vfio_iommu *iommu, dma_addr_t iova,
 			    map_try_harder(d, iova, pfn, npage, prot))
 				goto unwind;
 		}
+
+		cond_resched();
 	}
 
 	return 0;

