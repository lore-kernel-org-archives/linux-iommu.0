From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 13/19] iommu/tegra: smmu: Workaround PCIe IOMMU'able
Date: Fri, 18 Oct 2013 13:26:54 +0300
Message-ID: <1382092020-13170-14-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Make PCIe work as it is. IOMMU support can be implemented later. We
need the same kind of registration framework for PCIe as platform_bus
does currently.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 22951e6..f0ff48e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -384,6 +384,9 @@ static int __smmu_client_set_hwgrp(struct smmu_client *c,
 		map = smmu_client_hwgrp(c);
 
 	for_each_set_bit(i, bitmap, sizeof(map) * BITS_PER_BYTE) {
+		if (i == TEGRA_SWGROUP_AFI) /* FIXME: IOMMU'able PCIe */
+			continue;
+
 		offs = HWGRP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-- 
1.8.1.5
