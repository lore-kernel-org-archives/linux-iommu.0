From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv4 7/7] iommu/tegra: smmu: Allow duplicate ASID wirte
Date: Mon, 11 Nov 2013 10:31:58 +0200
Message-ID: <1384158718-4756-8-git-send-email-hdoyu@nvidia.com>
References: <1384158718-4756-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384158718-4756-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The device, which belongs to the same ASID, can try to enable the same
ASID as the other swgroup devices. This should be allowed but just
skip the actual register write. If the write value is different, it
will return -EINVAL.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Update:
This was the part of v3, which isn't used any more.
  [PATCHv3 10/19] iommu/tegra: smmu: Get "nvidia,swgroups" from DT
---
 drivers/iommu/tegra-smmu.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 904c36a..70f974c 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -346,8 +346,11 @@ static int __smmu_client_set_swgroups(struct smmu_client *c,
 		offs = SWGROUP_ASID_REG(i);
 		val = smmu_read(smmu, offs);
 		if (on) {
-			if (WARN_ON(val & mask))
-				goto err_hw_busy;
+			if (val) {
+				if (WARN_ON(val != mask))
+					return -EINVAL;
+				goto skip;
+			}
 			val |= mask;
 		} else {
 			WARN_ON((val & mask) == mask);
@@ -357,16 +360,8 @@ static int __smmu_client_set_swgroups(struct smmu_client *c,
 	}
 	FLUSH_SMMU_REGS(smmu);
 	c->swgroups = map;
+skip:
 	return 0;
-
-err_hw_busy:
-	for_each_set_bit(i, bitmap, TEGRA_SWGROUP_MAX) {
-		offs = SWGROUP_ASID_REG(i);
-		val = smmu_read(smmu, offs);
-		val &= ~mask;
-		smmu_write(smmu, val, offs);
-	}
-	return -EBUSY;
 }
 
 static int smmu_client_set_swgroups(struct smmu_client *c, u32 map, int on)
-- 
1.8.1.5
