From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu: Fix offsetof() usage
Date: Mon,  8 Apr 2019 13:41:47 +0100
Message-ID: <85778a4619eab832eb0b003a68f377aea9d97b22.1554727307.git.robin.murphy@arm.com>
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
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

David rightly points out that, although GCC lets us get away with it,
using offsetof() with a non-constant member designator is not compliant
with the C standard. I'm responsible for a couple of those misuses, but
both in circumstances for which we now have a specific helper, so we can
use that to put things straight.

Suggested-by: David Laight <David.Laight-ZS65k/vG3HxXrIkS9f7CXA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 3 +--
 drivers/iommu/iommu.c    | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 74e944bd4a8d..81d449451494 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1484,8 +1484,7 @@ static int arm_smmu_add_device(struct device *dev)
 	}
 
 	ret = -ENOMEM;
-	cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
-		      GFP_KERNEL);
+	cfg = kzalloc(struct_size(cfg, smendx, i), GFP_KERNEL);
 	if (!cfg)
 		goto out_free;
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 33a982e33716..ad28919e1452 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2021,7 +2021,7 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
 	if (!fwspec)
 		return -EINVAL;
 
-	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
+	size = struct_size(fwspec, ids, fwspec->num_ids + num_ids);
 	if (size > sizeof(*fwspec)) {
 		fwspec = krealloc(fwspec, size, GFP_KERNEL);
 		if (!fwspec)
-- 
2.21.0.dirty
