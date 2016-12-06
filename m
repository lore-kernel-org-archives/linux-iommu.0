From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] iommu/intel-iommu: fix pasid table size encoding
Date: Tue,  6 Dec 2016 10:14:23 -0800
Message-ID: <1481048063-56808-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mika Kuoppala <mika.kuoppala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Different encodings are used to represent supported PASID bits
and number of PASID table entries.
The current code assigns ecap_pss directly to extended context
table entry PTS which is wrong and could result in writing
non-zero bits to the reserved fields. IOMMU fault reason
11 will be reported when reserved bits are nonzero.
This patch converts ecap_pss to extend context entry pts encoding
based on VT-d spec. Chapter 9.4 as follows:
 - number of PASID bits = ecap_pss + 1
 - number of PASID table entries = 2^(pts + 5)
Software assigned limit of pasid_max value is also respected to
match the allocation limitation of PASID table.

cc: Mika Kuoppala <mika.kuoppala-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 27596e6..5d9cddc 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5173,6 +5173,25 @@ static void intel_iommu_remove_device(struct device *dev)
 }
 
 #ifdef CONFIG_INTEL_IOMMU_SVM
+#define MAX_NR_PASID_BITS (20)
+static inline unsigned long intel_iommu_get_pts(struct intel_iommu *iommu)
+{
+	/*
+	 * Convert ecap_pss to extend context entry pts encoding, also
+	 * respect the soft pasid_max value set by the iommu.
+	 * - number of PASID bits = ecap_pss + 1
+	 * - number of PASID table entries = 2^(pts + 5)
+	 * Therefore, pts = ecap_pss - 4
+	 * e.g. KBL ecap_pss = 0x13, PASID has 20 bits, pts = 15
+	 */
+	if (ecap_pss(iommu->ecap) < 5)
+		return 0;
+
+	/* pasid_max is encoded as actual number of entries not the bits */
+	return find_first_bit((unsigned long *)&iommu->pasid_max,
+			MAX_NR_PASID_BITS) - 5;
+}
+
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sdev)
 {
 	struct device_domain_info *info;
@@ -5205,7 +5224,9 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
 		context[1].hi = (u64)virt_to_phys(iommu->pasid_state_table);
-		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) | ecap_pss(iommu->ecap);
+		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
+			intel_iommu_get_pts(iommu);
+
 		wmb();
 		/* CONTEXT_TT_MULTI_LEVEL and CONTEXT_TT_DEV_IOTLB are both
 		 * extended to permit requests-with-PASID if the PASIDE bit
-- 
2.7.4
