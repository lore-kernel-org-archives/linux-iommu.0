From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 2/2] iommu/arm-smmu: Plumb in new ACPI identifiers
Date: Fri, 12 May 2017 11:41:42 +0100
Message-ID: <18776416ca1543f13b85209851b0e5dfab511b06.1494585645.git.robin.murphy@arm.com>
References: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: will.deacon-5wv7dgnIgG8@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, gakula-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linu.cherian-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Revision C of IORT now allows us to identify ARM MMU-401 and the Cavium
ThunderX implementation; wire them up so that the appropriate quirks get
enabled when booting with ACPI.

Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 6dadd51d486c..d9ec840defc9 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2018,6 +2018,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
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
@@ -2026,6 +2030,10 @@ static int acpi_smmu_get_data(u32 model, struct arm_smmu_device *smmu)
 		smmu->version = ARM_SMMU_V2;
 		smmu->model = ARM_MMU500;
 		break;
+	case ACPI_IORT_SMMU_CAVIUM_SMMUV2:
+		smmu->version = ARM_SMMU_V2;
+		smmu->model = CAVIUM_SMMUV2;
+		break;
 	default:
 		ret = -ENODEV;
 	}
-- 
2.12.2.dirty
