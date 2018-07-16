From: Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH] x86/pci: Some buggy virtual functions incorrectly report 1 for intx.
Date: Mon, 16 Jul 2018 13:42:25 -0700
Message-ID: <1531773745-41876-1-git-send-email-ashok.raj@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Bjorn Helgaas <helgaas@kernel.org>, Gage Eads <gage.eads@intel.com>
List-Id: iommu@lists.linux-foundation.org

PCI_INTERRUPT_PIN should always read  0 for SRIOV Virtual Functions.

Some SRIOV devices have some bugs in RTL and VF's end up reading 1
instead of 0 for the PIN.

We could enforce it by default in vfio_pci_nointx.

Reported-by: Gage Eads <gage.eads@intel.com>
Tested-by: Gage Eads <gage.eads@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gage Eads <gage.eads@intel.com>
---
 drivers/vfio/pci/vfio_pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a30..bc3f4fa 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -192,6 +192,13 @@ static void vfio_pci_disable(struct vfio_pci_device *vdev);
  */
 static bool vfio_pci_nointx(struct pci_dev *pdev)
 {
+	/*
+	 * Per PCI, no VF's should have INTx
+	 * Simply disable it here
+	 */
+	if (pdev->is_virtfn)
+		return true;
+
 	switch (pdev->vendor) {
 	case PCI_VENDOR_ID_INTEL:
 		switch (pdev->device) {
-- 
2.7.4
