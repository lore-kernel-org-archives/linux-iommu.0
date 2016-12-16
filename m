From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH] iommu/arm-smmu: Add global SMR masking property
Date: Fri, 16 Dec 2016 13:19:29 +0000
Message-ID: <ad6b6a4937b1fe183e6d48ccbaf4cb46db92fed4.1481893907.git.robin.murphy@arm.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: will.deacon-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, stuart.yoder-3arQi8VN3Tc@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The current SMR masking support using a 2-cell iommu-specifier is
primarily intended to handle individual masters with large and/or
complex Stream ID assignments; it quickly gets a bit clunky in other SMR
use-cases where we just want to consistently mask out the same part of
every Stream ID (e.g. for MMU-500 configurations where the appended TBU
number gets in the way unnecessarily). Let's add a new property to allow
a single global mask value to better fit the latter situation.

CC: Stuart Yoder <stuart.yoder-3arQi8VN3Tc@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

Compile-tested only...

 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 8 ++++++++
 drivers/iommu/arm-smmu.c                             | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index e862d1485205..98f5cbe5fdb4 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -60,6 +60,14 @@ conditions.
                   aliases of secure registers have to be used during
                   SMMU configuration.
 
+- stream-match-mask : Specifies a fixed SMR mask value to combine with
+                  the Stream ID value from every iommu-specifier. This
+                  may be used instead of an "#iommu-cells" value of 2
+                  when there is no need for per-master SMR masks, but
+                  it is still desired to mask some portion of every
+                  Stream ID (e.g. for certain MMU-500 configurations
+                  given globally unique external IDs).
+
 ** Deprecated properties:
 
 - mmu-masters (deprecated in favour of the generic "iommus" binding) :
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8f7281444551..f1abcb7dde36 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1534,13 +1534,15 @@ static int arm_smmu_domain_set_attr(struct iommu_domain *domain,
 
 static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 {
-	u32 fwid = 0;
+	u32 mask, fwid = 0;
 
 	if (args->args_count > 0)
 		fwid |= (u16)args->args[0];
 
 	if (args->args_count > 1)
 		fwid |= (u16)args->args[1] << SMR_MASK_SHIFT;
+	else if (!of_property_read_u32(args->np, "stream-match-mask", &mask))
+		fwid |= (u16)mask << SMR_MASK_SHIFT;
 
 	return iommu_fwspec_add_ids(dev, &fwid, 1);
 }
-- 
2.10.2.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
