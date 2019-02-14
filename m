From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
Date: Thu, 14 Feb 2019 12:44:33 -0800
Message-ID: <20190214204433.155715-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>, evgreen@chromium.org, tfiga@chromium.org, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Right now the only way to disable the iommu bypass for the ARM SMMU is
with the kernel command line parameter 'arm-smmu.disable_bypass'.

In general kernel command line parameters make sense for things that
someone would like to tweak without rebuilding the kernel or for very
basic communication between the bootloader and the kernel, but are
awkward for other things.  Specifically:
* Human parsing of the kernel command line can be difficult since it's
  just a big runon space separated line of text.
* If every bit of the system was configured via the kernel command
  line the kernel command line would get very large and even more
  unwieldly.
* Typically there are not easy ways in build systems to adjust the
  kernel command line for config-like options.

Let's introduce a new config option that allows us to disable the
iommu bypass without affecting the existing default nor the existing
ability to adjust the configuration via kernel command line.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/iommu/Kconfig    | 22 ++++++++++++++++++++++
 drivers/iommu/arm-smmu.c |  3 ++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 46fcd75d4364..c614beab08f8 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -359,6 +359,28 @@ config ARM_SMMU
 	  Say Y here if your SoC includes an IOMMU device implementing
 	  the ARM SMMU architecture.
 
+config ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT
+	bool "Default to disabling bypass on ARM SMMU v1 and v2"
+	depends on ARM_SMMU
+	default n
+	help
+	  Say Y here to (by default) disable bypass streams such that
+	  incoming transactions from devices that are not attached to
+	  an iommu domain will report an abort back to the device and
+	  will not be allowed to pass through the SMMU.
+
+	  Historically the ARM SMMU v1 and v2 driver has defaulted
+	  to allow bypass by default but it could be disabled with
+	  the parameter 'arm-smmu.disable_bypass'.  The parameter is
+	  still present and can be used to override this config
+	  option, but this config option allows you to disable bypass
+	  without bloating the kernel command line.
+
+	  Disabling bypass is more secure but presumably will break
+	  old systems.
+
+	  Say N if unsure.
+
 config ARM_SMMU_V3
 	bool "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..930c07635956 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -110,7 +110,8 @@ static int force_stage;
 module_param(force_stage, int, S_IRUGO);
 MODULE_PARM_DESC(force_stage,
 	"Force SMMU mappings to be installed at a particular stage of translation. A value of '1' or '2' forces the corresponding stage. All other values are ignored (i.e. no stage is forced). Note that selecting a specific stage will disable support for nested translation.");
-static bool disable_bypass;
+static bool disable_bypass =
+	IS_ENABLED(CONFIG_ARM_SMMU_DISABLE_BYPASS_BY_DEFAULT);
 module_param(disable_bypass, bool, S_IRUGO);
 MODULE_PARM_DESC(disable_bypass,
 	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
-- 
2.21.0.rc0.258.g878e2cd30e-goog
