From: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 2/7] iommu/fsl: Work around erratum A-007907
Date: Mon, 7 Mar 2016 17:34:18 +0200
Message-ID: <1457364863-18004-3-git-send-email-codrin.ciubotariu@nxp.com>
References: <1457364863-18004-1-git-send-email-codrin.ciubotariu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457364863-18004-1-git-send-email-codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
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
Cc: scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Shengzhou Liu <Shengzhou.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Erratum A-007907 can cause a core hang under certain circumstances.
Part of the workaround involves not stashing to L1 Cache.  On affected
chips, stash to L2 when L1 is requested.

Signed-off-by: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu-3arQi8VN3Tc@public.gmane.org>
---
 drivers/iommu/fsl_pamu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index c64cdef..a00c473 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -25,6 +25,7 @@
 #include <linux/genalloc.h>
 
 #include <asm/mpc85xx.h>
+#include <asm/reg.h>
 
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
@@ -534,6 +535,16 @@ void get_ome_index(u32 *omi_index, struct device *dev)
 		*omi_index = OMI_QMAN_PRIV;
 }
 
+static bool has_erratum_a007907(void)
+{
+	u32 pvr = mfspr(SPRN_PVR);
+
+	if (PVR_VER(pvr) == PVR_VER_E6500 && PVR_REV(pvr) <= 0x20)
+		return true;
+
+	return false;
+}
+
 /**
  * get_stash_id - Returns stash destination id corresponding to a
  *                cache type and vcpu.
@@ -551,6 +562,9 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
 	int len, found = 0;
 	int i;
 
+	if (stash_dest_hint == PAMU_ATTR_CACHE_L1 && has_erratum_a007907())
+		stash_dest_hint = PAMU_ATTR_CACHE_L2;
+
 	/* Fastpath, exit early if L3/CPC cache is target for stashing */
 	if (stash_dest_hint == PAMU_ATTR_CACHE_L3) {
 		node = of_find_matching_node(NULL, l3_device_ids);
-- 
1.9.3
