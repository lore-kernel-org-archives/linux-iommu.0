From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v3] iommu/arm-smmu: Plumb in new ACPI identifiers
Date: Mon, 19 Jun 2017 16:41:56 +0100
Message-ID: <063a50cff2942c96dc6f24d4f8c8a854a4a6cc30.1497886335.git.robin.murphy@arm.com>
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
Cc: rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Revision C of IORT now allows us to identify ARM MMU-401 and the Cavium
ThunderX implementation. Wire them up so that we can probe these models
once firmware starts using the new codes in place of generic ones, and
so that the appropriate features and quirks get enabled when we do.

For the sake of backports and mitigating sychronisation problems with
the ACPICA headers, we'll carry a backup copy of the new definitions
locally for the short term to make life simpler.

CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # 4.10
Acked-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Tested-by: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---

v3: The patch that actually landed in ACPICA was slightly tweaked for
    self-consistency, so s/CAVIUM_SMMUV2/CAVIUM_THUNDERX/ to match.

 drivers/iommu/arm-smmu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 7ec30b08b3bd..7ecd1a0b8419 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -312,6 +312,14 @@ enum arm_smmu_implementation {
 	CAVIUM_SMMUV2,
 };
 
+/* Until ACPICA headers cover IORT rev. C */
+#ifndef ACPI_IORT_SMMU_CORELINK_MMU401
+#define ACPI_IORT_SMMU_CORELINK_MMU401	0x4
+#endif
+#ifndef ACPI_IORT_SMMU_CAVIUM_THUNDERX
+#define ACPI_IORT_SMMU_CAVIUM_THUNDERX	0x5
+#endif
+
 struct arm_smmu_s2cr {
 	struct iommu_group		*group;
 	int				count;
@@ -2073,6 +2081,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 		smmu->version = ARM_SMMU_V1;
 		smmu->model = GENERIC_SMMU;
 		break;
+	case ACPI_IORT_SMMU_CORELINK_MMU401:
+		smmu->version = ARM_SMMU_V1_64K;
+		smmu->model = GENERIC_SMMU;
+		break;
 	case ACPI_IORT_SMMU_V2:
 		smmu->version = ARM_SMMU_V2;
 		smmu->model = GENERIC_SMMU;
@@ -2081,6 +2093,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 		smmu->version = ARM_SMMU_V2;
 		smmu->model = ARM_MMU500;
 		break;
+	case ACPI_IORT_SMMU_CAVIUM_THUNDERX:
+		smmu->version = ARM_SMMU_V2;
+		smmu->model = CAVIUM_SMMUV2;
+		break;
 	default:
 		ret = -ENODEV;
 	}
-- 
2.12.2.dirty
