From: Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH 2/3] PCI: iproc: CRS state check in config request
Date: Fri, 18 Jan 2019 09:53:22 +0530
Message-ID: <1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>
List-Id: iommu@lists.linux-foundation.org

In the current implementation, config read of 0xffff0001 data
is assumed as CRS completion. but sometimes 0xffff0001 can be
a valid data.
IPROC PCIe RC has a register to show config request status flags
like SC, UR, CRS and CA.
So that extra check is added in the code to confirm the CRS
state using this register before reissue config request.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 13ce80f..ee89d56 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -63,6 +63,10 @@
 #define APB_ERR_EN_SHIFT		0
 #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
 
+#define CFG_RD_SUCCESS			0
+#define CFG_RD_UR			1
+#define CFG_RD_CRS			2
+#define CFG_RD_CA			3
 #define CFG_RETRY_STATUS		0xffff0001
 #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
 
@@ -300,6 +304,9 @@ enum iproc_pcie_reg {
 	IPROC_PCIE_IARR4,
 	IPROC_PCIE_IMAP4,
 
+	/* config read status */
+	IPROC_PCIE_CFG_RD_STATUS,
+
 	/* link status */
 	IPROC_PCIE_LINK_STATUS,
 
@@ -370,6 +377,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 	[IPROC_PCIE_IMAP3]		= 0xe08,
 	[IPROC_PCIE_IARR4]		= 0xe68,
 	[IPROC_PCIE_IMAP4]		= 0xe70,
+	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
 	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
 	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
 	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
@@ -501,10 +509,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
 	return (pcie->base + offset);
 }
 
-static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
+static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
+					 void __iomem *cfg_data_p)
 {
 	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
 	unsigned int data;
+	u32 status;
 
 	/*
 	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
@@ -525,6 +535,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
 	 */
 	data = readl(cfg_data_p);
 	while (data == CFG_RETRY_STATUS && timeout--) {
+		/*
+		 * CRS state is set in CFG_RD status register
+		 * This will handle the case where CFG_RETRY_STATUS is
+		 * valid config data.
+		 */
+		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
+		if (status != CFG_RD_CRS)
+			return data;
+
 		udelay(1);
 		data = readl(cfg_data_p);
 	}
@@ -603,7 +622,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
 	if (!cfg_data_p)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	data = iproc_pcie_cfg_retry(cfg_data_p);
+	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
 
 	*val = data;
 	if (size <= 2)
-- 
2.7.4
