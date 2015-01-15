From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] vfio/type1: Chunk contiguous reserved/invalid page
	mappings
Date: Thu, 15 Jan 2015 10:35:20 -0700
Message-ID: <20150115173520.29162.13613.stgit@gimli.home>
References: <20150115171023.29162.90105.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150115171023.29162.90105.stgit-GCcqpEzw8uZBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

We currently map invalid and reserved pages, such as often occur from
mapping MMIO regions of a VM through the IOMMU, using single pages.
There's really no reason we can't instead follow the methodology we
use for normal pages and find the largest possible physically
contiguous chunk for mapping.  The only difference is that we don't
do locked memory accounting for these since they're not back by RAM.

In most applications this will be a very minor improvement, but when
graphics and GPGPU devices are in play, MMIO BARs become non-trivial.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---

 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index e6e7f15..35c9008 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -265,6 +265,7 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
 	unsigned long limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
 	bool lock_cap = capable(CAP_IPC_LOCK);
 	long ret, i;
+	bool rsvd;
 
 	if (!current->mm)
 		return -ENODEV;
@@ -273,10 +274,9 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
 	if (ret)
 		return ret;
 
-	if (is_invalid_reserved_pfn(*pfn_base))
-		return 1;
+	rsvd = is_invalid_reserved_pfn(*pfn_base);
 
-	if (!lock_cap && current->mm->locked_vm + 1 > limit) {
+	if (!rsvd && !lock_cap && current->mm->locked_vm + 1 > limit) {
 		put_pfn(*pfn_base, prot);
 		pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n", __func__,
 			limit << PAGE_SHIFT);
@@ -284,7 +284,8 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
 	}
 
 	if (unlikely(disable_hugepages)) {
-		vfio_lock_acct(1);
+		if (!rsvd)
+			vfio_lock_acct(1);
 		return 1;
 	}
 
@@ -296,12 +297,14 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
 		if (ret)
 			break;
 
-		if (pfn != *pfn_base + i || is_invalid_reserved_pfn(pfn)) {
+		if (pfn != *pfn_base + i ||
+		    rsvd != is_invalid_reserved_pfn(pfn)) {
 			put_pfn(pfn, prot);
 			break;
 		}
 
-		if (!lock_cap && current->mm->locked_vm + i + 1 > limit) {
+		if (!rsvd && !lock_cap &&
+		    current->mm->locked_vm + i + 1 > limit) {
 			put_pfn(pfn, prot);
 			pr_warn("%s: RLIMIT_MEMLOCK (%ld) exceeded\n",
 				__func__, limit << PAGE_SHIFT);
@@ -309,7 +312,8 @@ static long vfio_pin_pages(unsigned long vaddr, long npage,
 		}
 	}
 
-	vfio_lock_acct(i);
+	if (!rsvd)
+		vfio_lock_acct(i);
 
 	return i;
 }
