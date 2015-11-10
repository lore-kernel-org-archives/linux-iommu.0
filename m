From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/4] iommu/amd: Do proper access checking before calling
	handle_mm_fault()
Date: Tue, 10 Nov 2015 14:26:43 +0100
Message-ID: <1447162006-20672-2-git-send-email-joro@8bytes.org>
References: <1447162006-20672-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1447162006-20672-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The handle_mm_fault function expects the caller to do the
access checks. Not doing so and calling the function with
wrong permissions is a bug (catched by a BUG_ON).
So fix this bug by adding proper access checking to the io
page-fault code in the AMD IOMMUv2 driver.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/amd_iommu_v2.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index d21d4ed..612f7c8 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -494,6 +494,22 @@ static void handle_fault_error(struct fault *fault)
 	}
 }
 
+static bool access_error(struct vm_area_struct *vma, struct fault *fault)
+{
+	unsigned int allowed = 0;
+
+	if (fault->flags & PPR_FAULT_EXEC)
+		allowed = vma->vm_flags & VM_EXEC;
+
+	if (fault->flags & PPR_FAULT_READ)
+		allowed = vma->vm_flags & VM_READ;
+
+	if (fault->flags & PPR_FAULT_WRITE)
+		allowed = vma->vm_flags & VM_WRITE;
+
+	return allowed ? false : true;
+}
+
 static void do_fault(struct work_struct *work)
 {
 	struct fault *fault = container_of(work, struct fault, work);
@@ -516,8 +532,8 @@ static void do_fault(struct work_struct *work)
 		goto out;
 	}
 
-	if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE))) {
-		/* handle_mm_fault would BUG_ON() */
+	/* Check if we have the right permissions on the vma */
+	if (access_error(vma, fault)) {
 		up_read(&mm->mmap_sem);
 		handle_fault_error(fault);
 		goto out;
-- 
1.9.1
