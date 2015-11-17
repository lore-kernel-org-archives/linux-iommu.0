From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 2/4] iommu/amd: Correctly set flags for handle_mm_fault call
Date: Tue, 17 Nov 2015 16:11:37 +0100
Message-ID: <1447773099-2444-3-git-send-email-joro@8bytes.org>
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

Instead of just checking for a write access, calculate the
flags that are passed to handle_mm_fault() more precisly and
use the pre-defined macros.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 7caf2fa..a7edbd6 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -513,16 +513,20 @@ static bool access_error(struct vm_area_struct *vma, struct fault *fault)
 static void do_fault(struct work_struct *work)
 {
 	struct fault *fault = container_of(work, struct fault, work);
-	struct mm_struct *mm;
 	struct vm_area_struct *vma;
+	unsigned int flags = 0;
+	struct mm_struct *mm;
 	u64 address;
-	int ret, write;
-
-	write = !!(fault->flags & PPR_FAULT_WRITE);
+	int ret;
 
 	mm = fault->state->mm;
 	address = fault->address;
 
+	if (fault->flags & PPR_FAULT_USER)
+		flags |= FAULT_FLAG_USER;
+	if (fault->flags & PPR_FAULT_WRITE)
+		flags |= FAULT_FLAG_WRITE;
+
 	down_read(&mm->mmap_sem);
 	vma = find_extend_vma(mm, address);
 	if (!vma || address < vma->vm_start) {
@@ -539,7 +543,7 @@ static void do_fault(struct work_struct *work)
 		goto out;
 	}
 
-	ret = handle_mm_fault(mm, vma, address, write);
+	ret = handle_mm_fault(mm, vma, address, flags);
 	if (ret & VM_FAULT_ERROR) {
 		/* failed to service fault */
 		up_read(&mm->mmap_sem);
-- 
1.9.1
