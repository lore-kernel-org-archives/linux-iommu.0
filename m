From: Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH] vfio/pci: Some buggy virtual functions incorrectly report 1 for intx.
Date: Thu,  9 Aug 2018 12:37:06 -0700
Message-ID: <1533843426-79170-1-git-send-email-ashok.raj@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Gage Eads <gage.eads@intel.com>
List-Id: iommu@lists.linux-foundation.org

PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.

Some SRIOV devices have some bugs in RTL and VF's end up reading 1
instead of 0 for the PIN.

Since this is a spec required value, rather than having a device specific
quirk, we could fix it permanently in vfio.

Reworked suggestions from Alex https://lkml.org/lkml/2018/7/16/1052

Reported-by: Gage Eads <gage.eads@intel.com>
Tested-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gage Eads <gage.eads@intel.com>
---
 drivers/vfio/pci/vfio_pci.c        | 12 +++++++++---
 drivers/vfio/pci/vfio_pci_config.c |  3 ++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..32943dd 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -433,10 +433,16 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
 {
 	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
 		u8 pin;
-		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
-		if (IS_ENABLED(CONFIG_VFIO_PCI_INTX) && !vdev->nointx && pin)
-			return 1;
+		/*
+		 * INTx must be 0 for all VF's. Enforce that for all
+		 * VF's since this is a spec requirement.
+		 */
+		if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
+			vdev->pdev->is_virtfn)
+			return 0;
 
+		pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
+		return (pin ? 1 : 0);
 	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX) {
 		u8 pos;
 		u16 flags;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index 115a36f..e36b7c3 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1676,7 +1676,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
 	}
 
-	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx)
+	if (!IS_ENABLED(CONFIG_VFIO_PCI_INTX) || vdev->nointx ||
+		pdev->is_virtfn)
 		vconfig[PCI_INTERRUPT_PIN] = 0;
 
 	ret = vfio_cap_init(vdev);
-- 
2.7.4
