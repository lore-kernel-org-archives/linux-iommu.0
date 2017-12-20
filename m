From: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] iommu/vt-d: Enable 5-level paging mode in the PASID entry
Date: Wed, 20 Dec 2017 11:59:27 -0800
Message-ID: <1513799967-22454-5-git-send-email-sohil.mehta@intel.com>
References: <1513799967-22454-1-git-send-email-sohil.mehta@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513799967-22454-1-git-send-email-sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Ravi V Shankar <ravi.v.shankar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Gayatri Kammela <gayatri.kammela-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kirill Shutemov <kirill.shutemov-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

If the CPU has support for 5-level paging enabled and the IOMMU also
supports 5-level paging then enable the 5-level paging mode for first-
level translations - used when SVM is enabled.

Signed-off-by: Sohil Mehta <sohil.mehta-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/intel-svm.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 4072a18..d7095dd 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -26,6 +26,10 @@
 #include <linux/interrupt.h>
 #include <asm/page.h>
 
+#define PASID_ENTRY_P		BIT_ULL(0)
+#define PASID_ENTRY_FLPM_5LP	BIT_ULL(9)
+#define PASID_ENTRY_SRE		BIT_ULL(11)
+
 static irqreturn_t prq_event_thread(int irq, void *d);
 
 struct pasid_entry {
@@ -297,6 +301,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm = NULL;
 	struct mm_struct *mm = NULL;
+	u64 pasid_entry_val;
 	int pasid_max;
 	int ret;
 
@@ -403,9 +408,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
 				kfree(sdev);
 				goto out;
 			}
-			iommu->pasid_table[svm->pasid].val = (u64)__pa(mm->pgd) | 1;
+			pasid_entry_val = (u64)__pa(mm->pgd) | PASID_ENTRY_P;
 		} else
-			iommu->pasid_table[svm->pasid].val = (u64)__pa(init_mm.pgd) | 1 | (1ULL << 11);
+			pasid_entry_val = (u64)__pa(init_mm.pgd) |
+					  PASID_ENTRY_P | PASID_ENTRY_SRE;
+		if (cpu_feature_enabled(X86_FEATURE_LA57))
+			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
+
+		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
+
 		wmb();
 		/* In caching mode, we still have to flush with PASID 0 when
 		 * a PASID table entry becomes present. Not entirely clear
-- 
2.7.4
