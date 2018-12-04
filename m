From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/5] xhci: Use device_iommu_mapped()
Date: Tue,  4 Dec 2018 18:25:04 +0100
Message-ID: <20181204172504.19708-6-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Mathias Nyman <mathias.nyman@intel.com>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Replace the dev->iommu_group check with a proper function
call that better reprensents its purpose.

Cc: Mathias Nyman <mathias.nyman@intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c928dbbff881..5ab97e54d070 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -244,7 +244,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 	 * an iommu. Doing anything when there is no iommu is definitely
 	 * unsafe...
 	 */
-	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !dev->iommu_group)
+	if (!(xhci->quirks & XHCI_ZERO_64B_REGS) || !device_iommu_mapped(dev))
 		return;
 
 	xhci_info(xhci, "Zeroing 64bit base registers, expecting fault\n");
-- 
2.17.1
