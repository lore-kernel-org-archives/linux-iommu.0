From: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Subject: [PATCH 231/493] iommu: remove use of __devinit
Date: Mon, 19 Nov 2012 13:23:00 -0500
Message-ID: <1353349642-3677-231-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p-4Ng6DfrEGID2fBVCVOL8/A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org )
---
 drivers/iommu/intel-iommu.c | 4 ++--
 drivers/iommu/omap-iommu.c  | 2 +-
 drivers/iommu/tegra-gart.c  | 2 +-
 drivers/iommu/tegra-smmu.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d4a4cd4..246c7ce 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4196,7 +4196,7 @@ static struct iommu_ops intel_iommu_ops = {
 	.pgsize_bitmap	= INTEL_IOMMU_PGSIZES,
 };
 
-static void __devinit quirk_iommu_rwbf(struct pci_dev *dev)
+static void quirk_iommu_rwbf(struct pci_dev *dev)
 {
 	/*
 	 * Mobile 4 Series Chipset neglects to set RWBF capability,
@@ -4224,7 +4224,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2a40, quirk_iommu_rwbf);
 #define GGC_MEMORY_SIZE_3M_VT	(0xa << 8)
 #define GGC_MEMORY_SIZE_4M_VT	(0xb << 8)
 
-static void __devinit quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
+static void quirk_calpella_no_shadow_gtt(struct pci_dev *dev)
 {
 	unsigned short ggc;
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e7b0a17..c13979d 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -905,7 +905,7 @@ static void omap_iommu_detach(struct omap_iommu *obj)
 /*
  *	OMAP Device MMU(IOMMU) detection
  */
-static int __devinit omap_iommu_probe(struct platform_device *pdev)
+static int omap_iommu_probe(struct platform_device *pdev)
 {
 	int err = -ENODEV;
 	int irq;
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index c16e8fc..58ae73c 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -448,7 +448,7 @@ static struct platform_driver tegra_gart_driver = {
 	},
 };
 
-static int __devinit tegra_gart_init(void)
+static int tegra_gart_init(void)
 {
 	bus_set_iommu(&platform_bus_type, &gart_iommu_ops);
 	return platform_driver_register(&tegra_gart_driver);
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4167863..e635a90 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1273,7 +1273,7 @@ static struct platform_driver tegra_smmu_driver = {
 	},
 };
 
-static int __devinit tegra_smmu_init(void)
+static int tegra_smmu_init(void)
 {
 	bus_set_iommu(&platform_bus_type, &smmu_iommu_ops);
 	return platform_driver_register(&tegra_smmu_driver);
-- 
1.8.0
