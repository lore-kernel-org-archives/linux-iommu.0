From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 4/7] iommu/tegra: smmu: Calculate ASID register offset by ID
Date: Mon, 11 Nov 2013 10:31:55 +0200
Message-ID: <1384158718-4756-5-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

ASID register offset is caclulated by SWGROUP ID so that we can get
rid of old SoC specific MACROs. This ID conversion is needed for the
unified SMMU driver over Tegra SoCs. We use dt-bindings MACRO instead
of SoC dependent MACROs. The formula is:

  MC_SMMU_<swgroup name>_ASID_0 = MC_SMMU_AFI_ASID_0 + ID * 4;

Now SWGROUP ID is the global HardWare Accelerator(HWA) identifier
among all Tegra SoC except Tegra2.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
Combined the following patches from v3:
[PATCHv3 09/19] iommu/tegra: smmu: Calculate ASID register offset by ID
[PATCHv3 16/19] iommu/tegra: smmu: Use dt-bindings MACRO
---
 drivers/iommu/tegra-smmu.c | 62 +++-------------------------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 6968c11..67252e1 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -41,45 +41,7 @@
 #include <asm/cacheflush.h>
 #include <asm/dma-iommu.h>
 
-enum smmu_hwgrp {
-	HWGRP_AFI,
-	HWGRP_AVPC,
-	HWGRP_DC,
-	HWGRP_DCB,
-	HWGRP_EPP,
-	HWGRP_G2,
-	HWGRP_HC,
-	HWGRP_HDA,
-	HWGRP_ISP,
-	HWGRP_MPE,
-	HWGRP_NV,
-	HWGRP_NV2,
-	HWGRP_PPCS,
-	HWGRP_SATA,
-	HWGRP_VDE,
-	HWGRP_VI,
-
-	HWGRP_COUNT,
-
-	HWGRP_END = ~0,
-};
-
-#define HWG_AFI		(1 << HWGRP_AFI)
-#define HWG_AVPC	(1 << HWGRP_AVPC)
-#define HWG_DC		(1 << HWGRP_DC)
-#define HWG_DCB		(1 << HWGRP_DCB)
-#define HWG_EPP		(1 << HWGRP_EPP)
-#define HWG_G2		(1 << HWGRP_G2)
-#define HWG_HC		(1 << HWGRP_HC)
-#define HWG_HDA		(1 << HWGRP_HDA)
-#define HWG_ISP		(1 << HWGRP_ISP)
-#define HWG_MPE		(1 << HWGRP_MPE)
-#define HWG_NV		(1 << HWGRP_NV)
-#define HWG_NV2		(1 << HWGRP_NV2)
-#define HWG_PPCS	(1 << HWGRP_PPCS)
-#define HWG_SATA	(1 << HWGRP_SATA)
-#define HWG_VDE		(1 << HWGRP_VDE)
-#define HWG_VI		(1 << HWGRP_VI)
+#include <dt-bindings/memory/tegra-swgroup.h>
 
 /* bitmap of the page sizes currently supported */
 #define SMMU_IOMMU_PGSIZES	(SZ_4K)
@@ -238,25 +200,7 @@ enum {
 
 #define HWGRP_INIT(client) [HWGRP_##client] = SMMU_##client##_ASID
 
-static const u32 smmu_hwgrp_asid_reg[] = {
-	HWGRP_INIT(AFI),
-	HWGRP_INIT(AVPC),
-	HWGRP_INIT(DC),
-	HWGRP_INIT(DCB),
-	HWGRP_INIT(EPP),
-	HWGRP_INIT(G2),
-	HWGRP_INIT(HC),
-	HWGRP_INIT(HDA),
-	HWGRP_INIT(ISP),
-	HWGRP_INIT(MPE),
-	HWGRP_INIT(NV),
-	HWGRP_INIT(NV2),
-	HWGRP_INIT(PPCS),
-	HWGRP_INIT(SATA),
-	HWGRP_INIT(VDE),
-	HWGRP_INIT(VI),
-};
-#define HWGRP_ASID_REG(x) (smmu_hwgrp_asid_reg[x])
+#define HWGRP_ASID_REG(x) ((x) * sizeof(u32) + SMMU_AFI_ASID)
 
 /*
  * Per client for address space
@@ -826,7 +770,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 	 * Reserve "page zero" for AVP vectors using a common dummy
 	 * page.
 	 */
-	if (map & HWG_AVPC) {
+	if (map & TEGRA_SWGROUP_BIT(AVPC)) {
 		struct page *page;
 
 		page = as->smmu->avp_vector_page;
-- 
1.8.1.5
