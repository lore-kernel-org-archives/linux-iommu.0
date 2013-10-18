From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 09/19] iommu/tegra: smmu: Calculate ASID register offset by
	ID
Date: Fri, 18 Oct 2013 13:26:50 +0300
Message-ID: <1382092020-13170-10-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Calculate ASID register offset by ID so that we can get rid of SoC
specific MACROs. This is needed for the unified SMMU driver over Tegra
SoCs.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 710c671..4dcdd6c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -238,25 +238,7 @@ enum {
 
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
-- 
1.8.1.5
