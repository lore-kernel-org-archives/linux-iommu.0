From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2] iommu/vt-d: respect max guest address width in agaw
Date: Tue,  6 Nov 2018 14:47:15 -0800
Message-ID: <1541544435-52624-1-git-send-email-jacob.jun.pan@linux.intel.com>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Supported guest address witdh (SGAW) only indicates
what the iommu's capabilities are wrt page table levels
for second level page-tables. IOMMU should pick the
right level depending on the Maximum Guest Address Width
(MGAW).

For pass-through translation type, address width must be
programmed with the largest AGAW supported by the HW.

Reported-by: Ramos Falcon, Ernesto R <ernesto.r.ramos.falcon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 140d6ab..f16db3b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -719,7 +719,11 @@ int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
  */
 int iommu_calculate_agaw(struct intel_iommu *iommu)
 {
-	return __iommu_calculate_agaw(iommu, DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	unsigned long mgaw;
+
+	/* Respect Max Guest Address Width */
+	mgaw = min(cap_mgaw(iommu->cap), DEFAULT_DOMAIN_ADDRESS_WIDTH);
+	return __iommu_calculate_agaw(iommu, mgaw);
 }
 
 /* This functionin only returns single iommu in a domain */
-- 
2.7.4
