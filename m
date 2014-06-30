From: Olav Haugan <ohaugan@codeaurora.org>
Subject: [RFC/PATCH 1/7] iommu: msm: Rename iommu driver files
Date: Mon, 30 Jun 2014 09:51:50 -0700
Message-ID: <1404147116-4598-2-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, joro@8bytes.org, vgandhi@codeaurora.org, Olav Haugan <ohaugan@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

Rename the MSM IOMMU driver for MSM8960 SoC to "-v0" version to align
with hardware version number for next generation MSM IOMMU (v1).

Signed-off-by: Olav Haugan <ohaugan@codeaurora.org>
---
 arch/arm/configs/qcom_defconfig                          |  2 +-
 drivers/iommu/Kconfig                                    | 11 +++++++++--
 drivers/iommu/Makefile                                   |  2 +-
 drivers/iommu/{msm_iommu.c => msm_iommu-v0.c}            |  2 +-
 drivers/iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c}    |  2 +-
 drivers/iommu/{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h} |  0
 6 files changed, 13 insertions(+), 6 deletions(-)
 rename drivers/iommu/{msm_iommu.c => msm_iommu-v0.c} (99%)
 rename drivers/iommu/{msm_iommu_dev.c => msm_iommu_dev-v0.c} (99%)
 rename drivers/iommu/{msm_iommu_hw-8xxx.h => msm_iommu_hw-v0.h} (100%)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 42ebd72..0414889 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -136,7 +136,7 @@ CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8660=y
 CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
-CONFIG_MSM_IOMMU=y
+CONFIG_MSM_IOMMU_V0=y
 CONFIG_GENERIC_PHY=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index d260605..705a257 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -28,12 +28,19 @@ config FSL_PAMU
 	  transaction types.
 
 # MSM IOMMU support
+
+# MSM_IOMMU always gets selected by whoever wants it.
 config MSM_IOMMU
-	bool "MSM IOMMU Support"
+	bool
+
+# MSM IOMMUv0 support
+config MSM_IOMMU_V0
+	bool "MSM IOMMUv0 Support"
 	depends on ARCH_MSM8X60 || ARCH_MSM8960
 	select IOMMU_API
+	select MSM_IOMMU
 	help
-	  Support for the IOMMUs found on certain Qualcomm SOCs.
+	  Support for the IOMMUs (v0) found on certain Qualcomm SOCs.
 	  These IOMMUs allow virtualization of the address space used by most
 	  cores within the multimedia subsystem.
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 8893bad..894ced9 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
-obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
+obj-$(CONFIG_MSM_IOMMU_V0) += msm_iommu-v0.o msm_iommu_dev-v0.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm-smmu.o
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu-v0.c
similarity index 99%
rename from drivers/iommu/msm_iommu.c
rename to drivers/iommu/msm_iommu-v0.c
index f5ff657..17731061 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu-v0.c
@@ -31,7 +31,7 @@
 #include <asm/cacheflush.h>
 #include <asm/sizes.h>
 
-#include "msm_iommu_hw-8xxx.h"
+#include "msm_iommu_hw-v0.h"
 #include "msm_iommu.h"
 
 #define MRC(reg, processor, op1, crn, crm, op2)				\
diff --git a/drivers/iommu/msm_iommu_dev.c b/drivers/iommu/msm_iommu_dev-v0.c
similarity index 99%
rename from drivers/iommu/msm_iommu_dev.c
rename to drivers/iommu/msm_iommu_dev-v0.c
index 61def7cb..2f86e46 100644
--- a/drivers/iommu/msm_iommu_dev.c
+++ b/drivers/iommu/msm_iommu_dev-v0.c
@@ -27,7 +27,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include "msm_iommu_hw-8xxx.h"
+#include "msm_iommu_hw-v0.h"
 #include "msm_iommu.h"
 
 struct iommu_ctx_iter_data {
diff --git a/drivers/iommu/msm_iommu_hw-8xxx.h b/drivers/iommu/msm_iommu_hw-v0.h
similarity index 100%
rename from drivers/iommu/msm_iommu_hw-8xxx.h
rename to drivers/iommu/msm_iommu_hw-v0.h
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
