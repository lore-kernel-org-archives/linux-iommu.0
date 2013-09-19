From: Bharat Bhushan <r65777-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: [PATCH 3/7] fsl iommu: add get_dev_iommu_domain
Date: Thu, 19 Sep 2013 12:59:19 +0530
Message-ID: <1379575763-2091-4-git-send-email-Bharat.Bhushan@freescale.com>
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

From: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

returns the iommu_domain of the requested device for fsl pamu.

Use PCI controller dev struct for pci devices as current LIODN schema
assign LIODN to PCI controller not PCI device. This will be corrected
with proper LIODN schema.

Signed-off-by: Bharat Bhushan <bharat.bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
---
 drivers/iommu/fsl_pamu_domain.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index 14d803a..1d0dfe3 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -1140,6 +1140,35 @@ static u32 fsl_pamu_get_windows(struct iommu_domain *domain)
 	return dma_domain->win_cnt;
 }
 
+static struct iommu_domain *fsl_get_dev_domain(struct device *dev)
+{
+	struct pci_controller *pci_ctl;
+	struct device_domain_info *info;
+	struct pci_dev *pdev;
+
+	/*
+	 * Use PCI controller dev struct for pci devices as current
+	 * LIODN schema assign LIODN to PCI controller not PCI device
+	 * This should get corrected with proper LIODN schema.
+	 */
+	if (dev->bus == &pci_bus_type) {
+		pdev = to_pci_dev(dev);
+		pci_ctl = pci_bus_to_host(pdev->bus);
+		/*
+		 * make dev point to pci controller device
+		 * so we can get the LIODN programmed by
+		 * u-boot.
+		 */
+		dev = pci_ctl->parent;
+	}
+
+	info = dev->archdata.iommu_domain;
+	if (info && info->domain)
+		return info->domain->iommu_domain;
+
+	return NULL;
+}
+
 static struct iommu_ops fsl_pamu_ops = {
 	.domain_init	= fsl_pamu_domain_init,
 	.domain_destroy = fsl_pamu_domain_destroy,
@@ -1155,6 +1184,7 @@ static struct iommu_ops fsl_pamu_ops = {
 	.domain_get_attr = fsl_pamu_get_domain_attr,
 	.add_device	= fsl_pamu_add_device,
 	.remove_device	= fsl_pamu_remove_device,
+	.get_dev_iommu_domain = fsl_get_dev_domain,
 };
 
 int pamu_domain_init()
-- 
1.7.0.4
