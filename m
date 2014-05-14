From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] iommu/intel: Exclude devices using RMRRs from IOMMU API
	domains
Date: Wed, 14 May 2014 13:27:18 -0600
Message-ID: <20140514192620.7767.43842.stgit@bling.home>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, chegu_vinod-VXdhtT5mjnY@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

The user of the IOMMU API domain expects to have full control of
the IOVA space for the domain.  RMRRs are fundamentally incompatible
with that idea.  We can neither map the RMRR into the IOMMU API
domain, nor can we guarantee that the device won't continue DMA with
the area described by the RMRR as part of the new domain.  Therefore
we must prevent such devices from being used by the IOMMU API.

Signed-off-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/intel-iommu.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f256ffc..eb77149 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4188,6 +4188,21 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 	int addr_width;
 	u8 bus, devfn;
 
+	/*
+	 * With IOMMU API domains we don't have the freedom to insert RMRR
+	 * entries into the domain mapping, the IOMMU API user expects full
+	 * control of the IOVA space of the device.  We also have no ability
+	 * to shutdown whatever back channel operations occur through the
+	 * RMRR.  Therefore our only option is to prevent devices making use
+	 * of RMRRs from being used by the IOMMU API.  As usual we exempt
+	 * USB devices since their RMRR support is largely historical.
+	 */
+	if (device_has_rmrr(dev) && (!dev_is_pci(dev) ||
+	    (to_pci_dev(dev)->class >> 8) != PCI_CLASS_SERIAL_USB)) {
+		dev_warn(dev, "Device is ineligible for IOMMU domain attach due to platform RMRR requirement.  Contact your platform vendor.\n");
+		return -EPERM;
+	}
+
 	/* normally dev is not mapped */
 	if (unlikely(domain_context_mapped(dev))) {
 		struct dmar_domain *old_domain;
