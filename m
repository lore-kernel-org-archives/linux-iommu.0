From: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [RFC 2/2] arm-smmu-v3: Add tlbi_on_map option
Date: Sun,  9 Jul 2017 17:15:03 +0200
Message-ID: <1499613303-30173-3-git-send-email-eric.auger@redhat.com>
References: <1499613303-30173-1-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1499613303-30173-1-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will.Deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, Jean-Philippe.Brucker-5wv7dgnIgG8@public.gmane.org
Cc: Marc.Zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

When running a virtual SMMU on a guest we sometimes need to trap
all changes to the translation structures. This is especially useful
to integrate with VFIO. This patch adds a new option that forces
the IO_PGTABLE_QUIRK_TLBI_ON_MAP to be applied on LPAE page tables.

TLBI commands then can be trapped.

Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 4 ++++
 drivers/iommu/arm-smmu-v3.c                             | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
index be57550..a25337a 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
@@ -46,6 +46,10 @@ the PCIe specification.
                         devicetree/bindings/interrupt-controller/msi.txt
                       for a description of the msi-parent property.
 
+- tlbi-on-map       : invalidate caches whenever there is an update of
+                      any remapping structure (updates to not-present or
+                      present entries).
+
 - hisilicon,broken-prefetch-cmd
                     : Avoid sending CMD_PREFETCH_* commands to the SMMU.
 
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 380969a..5003ff7 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -597,6 +597,7 @@ struct arm_smmu_device {
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
+#define ARM_SMMU_OPT_TLBI_ON_MAP	(1 << 1)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -663,6 +664,7 @@ struct arm_smmu_option_prop {
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
+	{ ARM_SMMU_OPT_TLBI_ON_MAP, "tlbi-on-map" },
 	{ 0, NULL},
 };
 
@@ -1555,6 +1557,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		.iommu_dev	= smmu->dev,
 	};
 
+	if (smmu->options & ARM_SMMU_OPT_TLBI_ON_MAP)
+		pgtbl_cfg.quirks = IO_PGTABLE_QUIRK_TLBI_ON_MAP;
+
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
-- 
2.5.5
