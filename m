From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] iommu/arm-smmu: Fix out-of-bounds dereference
Date: Mon,  7 Nov 2016 15:39:02 +0000
Message-ID: <dea89ff1b2bd97b08d72f5c32fcf228bec767142.1478533142.git.robin.murphy@arm.com>
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
To: will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When we iterate a master's config entries, what we generally care
about is the entry's stream map index, rather than the entry index
itself, so it's nice to have the iterator automatically assign the
former from the latter. Unfortunately, booting with KASAN reveals
the oversight that using a simple comma operator results in the
entry index being dereferenced before being checked for validity,
so we always access one element past the end of the fwspec array.

Flip things around so that the check always happens before the index
may be dereferenced.

Fixes: adfec2e709d2 ("iommu/arm-smmu: Convert to iommu_fwspec")
Reported-by: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index f86683eec446..44ffe3a391d6 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -324,8 +324,10 @@ struct arm_smmu_master_cfg {
 #define INVALID_SMENDX			-1
 #define __fwspec_cfg(fw) ((struct arm_smmu_master_cfg *)fw->iommu_priv)
 #define fwspec_smmu(fw)  (__fwspec_cfg(fw)->smmu)
-#define for_each_cfg_sme(fw, i, idx) \
-	for (i = 0; idx = __fwspec_cfg(fw)->smendx[i], i < fw->num_ids; ++i)
+#define for_each_cfg_sme(fw, i, idx)					\
+	for (i = 0;							\
+	     i < fw->num_ids && (idx = __fwspec_cfg(fw)->smendx[i], true); \
+	     ++i)
 
 struct arm_smmu_device {
 	struct device			*dev;
-- 
2.10.2.dirty
