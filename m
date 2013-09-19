From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 4/7] powerpc: translate msi addr to iova if iommu is in use
Date: Thu, 19 Sep 2013 12:59:20 +0530
Message-ID: <1379575763-2091-5-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1379575763-2091-1-git-send-email-Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

If the device is attached with iommu domain then set MSI address
to the iova configured in PAMU.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 arch/powerpc/sysdev/fsl_msi.c |   56 +++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ed045cb..c7cf018 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -18,6 +18,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/of_platform.h>
+#include <linux/iommu.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
@@ -150,7 +151,40 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	return;
 }
 
-static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
+static uint64_t fsl_iommu_get_iova(struct pci_dev *pdev, dma_addr_t msi_phys)
+{
+	struct iommu_domain *domain;
+	struct iommu_domain_geometry geometry;
+	u32 wins = 0;
+	uint64_t iova, size;
+	int ret, i;
+
+	domain = iommu_get_dev_domain(&pdev->dev);
+	if (!domain)
+		return 0;
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_WINDOWS, &wins);
+	if (ret)
+		return 0;
+
+	ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_GEOMETRY, &geometry);
+	if (ret)
+		return 0;
+
+	iova = geometry.aperture_start;
+	size = geometry.aperture_end - geometry.aperture_start + 1;
+	do_div(size, wins);
+	for (i = 0; i < wins; i++) {
+		phys_addr_t phys;
+		phys = iommu_iova_to_phys(domain, iova);
+		if (phys == (msi_phys & ~(PAGE_SIZE - 1)))
+			return (iova + (msi_phys & (PAGE_SIZE - 1)));
+		iova += size;
+	}
+	return 0;
+}
+
+static int fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 				struct msi_msg *msg,
 				struct fsl_msi *fsl_msi_data)
 {
@@ -168,6 +202,16 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 		address = fsl_pci_immrbar_base(hose) +
 			   (msi_data->msiir & 0xfffff);
 
+	/*
+	 * If the device is attached with iommu domain then set MSI address
+	 * to the iova configured in PAMU.
+	 */
+	if (iommu_get_dev_domain(&pdev->dev)) {
+		address = fsl_iommu_get_iova(pdev, msi_data->msiir);
+		if (!address)
+			return -ENODEV;
+	}
+
 	msg->address_lo = lower_32_bits(address);
 	msg->address_hi = upper_32_bits(address);
 
@@ -175,6 +219,8 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
 		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
+
+	return 0;
 }
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -244,7 +290,13 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		/* chip_data is msi_data via host->hostdata in host->map() */
 		irq_set_msi_desc(virq, entry);
 
-		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
+		if (fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data)) {
+			dev_err(&pdev->dev, "Fail to set MSI for hwirq %i\n",
+				hwirq);
+			msi_bitmap_free_hwirqs(&msi_data->bitmap, hwirq, 1);
+			rc = -ENODEV;
+			goto out_free;
+		}
 		write_msi_msg(virq, &msg);
 	}
 	return 0;
-- 
1.7.0.4
