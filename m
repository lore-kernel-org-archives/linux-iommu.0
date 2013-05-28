From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2 0/2] iommu/intel: Quirk non-compliant PCIe-to-PCI bridges
Date: Tue, 28 May 2013 12:40:11 -0600
Message-ID: <20130528183527.3318.5365.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, dwmw2@infradead.org, joro@8bytes.org
Cc: stephen@networkplumber.org, linux-pci@vger.kernel.org, ddutile@redhat.com
List-Id: iommu@lists.linux-foundation.org

This series tries to address:

https://bugzilla.kernel.org/show_bug.cgi?id=3D44881

Where pci_find_upstream_pcie_bridge() gets lost trying to find the
upstream PCIe-to-PCI bridge for a device because the bridge doesn't
expose a PCIe capability.=C2=A0 To do this, we add a iommu_pci_is_pcie_=
bridge
function which includes a quirk to look to the next upstream device
as a sanity check.=C2=A0 We can then replace pci_find_upstream_pcie_bri=
dge
with a function that's a bit more generic and less tied to intel-iommu
eccentricities.

v2 uses the same logic as v1, but moves the search and match code to
IOMMU-core since PCI-core doesn't want it.  v1 has several reports
from users that this solves the problem they have in the above bz.
Thanks,

Alex

---

Alex Williamson (2):
      iommu: Quirked PCIe bridge test and search function
      intel-iommu: Convert to iommu_pci_find_upstream + iommu_pci_is_pc=
ie_bridge


 drivers/iommu/Kconfig               |    5 ++
 drivers/iommu/Makefile              |    1=20
 drivers/iommu/intel-iommu.c         |   77 ++++++++++++++++++++++-----=
--------
 drivers/iommu/intel_irq_remapping.c |   15 +++++--
 drivers/iommu/pci.c                 |   69 +++++++++++++++++++++++++++=
++++
 drivers/iommu/pci.h                 |   23 ++++++++++
 6 files changed, 157 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iommu/pci.c
