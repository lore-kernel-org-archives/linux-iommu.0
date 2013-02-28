From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH v2 2/4] pci/aer: Remove local PCI_BUS() define and use
 PCI_BUS_NUM() from pci
Date: Wed, 27 Feb 2013 17:07:05 -0700
Message-ID: <1362010025.2808.35.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, bhelgaas@google.com
Cc: jiang.liu@huawei.com, shemminger@vyatta.com, paulmck@linux.vnet.ibm.com, linasvepstas@gmail.com, dhowells@redhat.com, davej@redhat.com, tglx@linutronix.de, mtk.manpages@gmail.com, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, wangyijing@huawei.com, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

Change to remove local PCI_BUS() define and use the new PCI_BUS_NUM()
interface from pci.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 drivers/pci/pcie/aer/aerdrv_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 564d97f..8ec8b4f 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -89,8 +89,6 @@ static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 	return -ENOSPC;
 }
 
-#define	PCI_BUS(x)	(((x) >> 8) & 0xff)
-
 /**
  * is_error_source - check whether the device is source of reported error
  * @dev: pointer to pci_dev to be checked
@@ -106,7 +104,7 @@ static bool is_error_source(struct pci_dev *dev, struct aer_err_info *e_info)
 	 * When bus id is equal to 0, it might be a bad id
 	 * reported by root port.
 	 */
-	if (!nosourceid && (PCI_BUS(e_info->id) != 0)) {
+	if (!nosourceid && (PCI_BUS_NUM(e_info->id) != 0)) {
 		/* Device ID match? */
 		if (e_info->id == ((dev->bus->number << 8) | dev->devfn))
 			return true;
-- 
1.7.9.5
