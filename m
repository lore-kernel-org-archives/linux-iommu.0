From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 3/4] iommu/amd: Cleanup error handling in do_fault()
Date: Tue, 17 Nov 2015 16:11:38 +0100
Message-ID: <1447773099-2444-4-git-send-email-joro@8bytes.org>
References: <1447773099-2444-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447773099-2444-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jesse Barnes <jbarnes-Y1mF5jBUw70BENJcbMCuUQ@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

Get rid of the three error paths that look the same and move
error handling to a single place.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index a7edbd6..6a28b74 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -514,10 +514,10 @@ static void do_fault(struct work_struct *work)
 {
 	struct fault *fault = container_of(work, struct fault, work);
 	struct vm_area_struct *vma;
+	int ret = VM_FAULT_ERROR;
 	unsigned int flags = 0;
 	struct mm_struct *mm;
 	u64 address;
-	int ret;
 
 	mm = fault->state->mm;
 	address = fault->address;
@@ -529,31 +529,23 @@ static void do_fault(struct work_struct *work)
 
 	down_read(&mm->mmap_sem);
 	vma = find_extend_vma(mm, address);
-	if (!vma || address < vma->vm_start) {
+	if (!vma || address < vma->vm_start)
 		/* failed to get a vma in the right range */
-		up_read(&mm->mmap_sem);
-		handle_fault_error(fault);
 		goto out;
-	}
 
 	/* Check if we have the right permissions on the vma */
-	if (access_error(vma, fault)) {
-		up_read(&mm->mmap_sem);
-		handle_fault_error(fault);
+	if (access_error(vma, fault))
 		goto out;
-	}
 
 	ret = handle_mm_fault(mm, vma, address, flags);
-	if (ret & VM_FAULT_ERROR) {
-		/* failed to service fault */
-		up_read(&mm->mmap_sem);
-		handle_fault_error(fault);
-		goto out;
-	}
 
+out:
 	up_read(&mm->mmap_sem);
 
-out:
+	if (ret & VM_FAULT_ERROR)
+		/* failed to service fault */
+		handle_fault_error(fault);
+
 	finish_pri_tag(fault->dev_state, fault->state, fault->tag);
 
 	put_pasid_state(fault->state);
-- 
1.9.1
