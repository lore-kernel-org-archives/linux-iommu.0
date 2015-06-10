From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu/vt-d: Don't copy translation tables if we find
	unexpected RTT setting
Date: Wed, 10 Jun 2015 11:10:31 +0200
Message-ID: <1433927431-28574-1-git-send-email-joro@8bytes.org>
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
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>

The RTT bit in the RTADDR_REG can not be changed while
translation is enabled. So check its value if we boot into a
kdump kernel and find translation enabled, and if it is
different from what we would set it to, bail out and don't
try to copy over the translation tables from the old kernel.

Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/intel-iommu.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 58abddb..08209c4 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -389,6 +389,7 @@ static void unmap_device_dma(struct dmar_domain *domain,
 				struct device *dev,
 				struct intel_iommu *iommu);
 static void iommu_check_pre_te_status(struct intel_iommu *iommu);
+static bool iommu_check_rtt(struct intel_iommu *iommu);
 static u8 g_translation_pre_enabled;
 
 /*
@@ -2917,9 +2918,11 @@ static int __init init_dmars(void)
 
 		/*
 		 * We don't even try to preserve anything when we are not in a
-		 * kdump kernel.
+		 * kdump kernel or when we have to change the RTT bit in the
+		 * RTADDR_REG.
 		 */
-		if (!is_kdump_kernel() && iommu->pre_enabled_trans) {
+		if (iommu->pre_enabled_trans &&
+		    (!is_kdump_kernel() || iommu_check_rtt(iommu))) {
 			iommu_disable_translation(iommu);
 			iommu->pre_enabled_trans = 0;
 			g_translation_pre_enabled = 0;
@@ -5087,3 +5090,13 @@ static void iommu_check_pre_te_status(struct intel_iommu *iommu)
 		g_translation_pre_enabled = 1;
 	}
 }
+
+static bool iommu_check_rtt(struct intel_iommu *iommu)
+{
+	u64 rtaddr;
+
+	rtaddr = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
+
+	return (!!ecap_ecs(iommu->ecap) != !!(rtaddr & DMA_RTADDR_RTT));
+}
+
-- 
1.9.1
