From: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
Subject: [PATCH] iommu/amd: Fix BUG when faulting a PROT_NONE VMA
Date: Wed, 16 Sep 2015 14:10:03 -0500
Message-ID: <1442430603-1962-1-git-send-email-jay@jcornwall.me>
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
List-Id: iommu@lists.linux-foundation.org

handle_mm_fault indirectly triggers a BUG in do_numa_page when given
a VMA without read/write/execute access. Check this condition in do_fault.

do_fault -> handle_mm_fault -> handle_pte_fault -> do_numa_page

  mm/memory.c
  3147  static int do_numa_page(struct mm_struct *mm, struct vm_area_struct *vma,
  ....
  3159  /* A PROT_NONE fault should not end up here */
  3160  BUG_ON(!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)));

Signed-off-by: Jay Cornwall <jay-gJmSnxjMpeIFV7jr3Ov9Ew@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 1131664..d21d4ed 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -516,6 +516,13 @@ static void do_fault(struct work_struct *work)
 		goto out;
 	}
 
+	if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))) {
+		/* handle_mm_fault would BUG_ON() */
+		up_read(&mm->mmap_sem);
+		handle_fault_error(fault);
+		goto out;
+	}
+
 	ret = handle_mm_fault(mm, vma, address, write);
 	if (ret & VM_FAULT_ERROR) {
 		/* failed to service fault */
-- 
1.9.1
