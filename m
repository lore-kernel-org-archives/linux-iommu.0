From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 4/4] iommu/vt-d: Do access checks before calling
	handle_mm_fault()
Date: Tue, 17 Nov 2015 16:11:39 +0100
Message-ID: <1447773099-2444-5-git-send-email-joro@8bytes.org>
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

Not doing so is a bug and might trigger a BUG_ON in
handle_mm_fault(). So add the proper permission checks
before calling into mm code.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-svm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index c69e3f9..5046483 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -484,6 +484,23 @@ struct page_req_dsc {
 };
 
 #define PRQ_RING_MASK ((0x1000 << PRQ_ORDER) - 0x10)
+
+static bool access_error(struct vm_area_struct *vma, struct page_req_dsc *req)
+{
+	unsigned long requested = 0;
+
+	if (req->exe_req)
+		requested |= VM_EXEC;
+
+	if (req->rd_req)
+		requested |= VM_READ;
+
+	if (req->wr_req)
+		requested |= VM_WRITE;
+
+	return (requested & ~vma->vm_flags) != 0;
+}
+
 static irqreturn_t prq_event_thread(int irq, void *d)
 {
 	struct intel_iommu *iommu = d;
@@ -539,6 +556,9 @@ static irqreturn_t prq_event_thread(int irq, void *d)
 		if (!vma || address < vma->vm_start)
 			goto invalid;
 
+		if (access_error(vma, req))
+			goto invalid;
+
 		ret = handle_mm_fault(svm->mm, vma, address,
 				      req->wr_req ? FAULT_FLAG_WRITE : 0);
 		if (ret & VM_FAULT_ERROR)
-- 
1.9.1
