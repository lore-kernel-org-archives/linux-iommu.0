From: Shuah Khan <shuah.khan@hp.com>
Subject: [PATCH v2 0/4] pci: Add PCI_BUS() and PCI_DEVID() interfaces to
 return bus number and device id
Date: Wed, 27 Feb 2013 17:06:18 -0700
Message-ID: <1362009978.2808.33.camel@lorien2>
Reply-To: shuah.khan@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, bhelgaas@google.com
Cc: jiang.liu@huawei.com, shemminger@vyatta.com, paulmck@linux.vnet.ibm.com, linasvepstas@gmail.com, dhowells@redhat.com, davej@redhat.com, tglx@linutronix.de, mtk.manpages@gmail.com, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, wangyijing@huawei.com, LKML <linux-kernel@vger.kernel.org>, shuahkhan@gmail.com
List-Id: iommu@lists.linux-foundation.org

pci defines PCI_DEVFN(), PCI_SLOT(), and PCI_FUNC() interfaces, however,
it doesn't have interfaces to return PCI bus and PCI device id. Drivers
(AMD IOMMU, and AER) have module specific definitions for PCI_BUS() and
AMD_IOMMU driver also has a module specific interface to calculate PCI
device id from bus number and devfn.

This patch set adds PCI_BUS_NUM(), and PCI_DEVID() to pci.h, changes AER
to use PCI_BUS_NUM() from pci and remove local PCI_BUS() define. Changes
AMD_IOMMU driver to use PCI_BUS_NUM() and PCI_DEVID() from pci and remove
local PCI_BUS() define and local PCI_DEVID() implementation.

Files changed:

[PATCH v2 1/4] pci: Add PCI_BUS_NUM() and PCI_DEVID() interfaces to return bus
           number and device id

 include/linux/pci.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

[PATCH v2 2/4] pci/aer: Remove local PCI_BUS() define and use PCI_BUS_NUM()
           from pci

 drivers/pci/pcie/aer/aerdrv_core.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

[PATCH v2 3/4] iommu/amd: Remove local PCI_BUS() define and use PCI_BUS_NUM()
           from pci

 drivers/iommu/amd_iommu.c       |   12 ++++++------
 drivers/iommu/amd_iommu_init.c  |   34 +++++++++++++++++-----------------
 drivers/iommu/amd_iommu_types.h |    4 +---
 3 files changed, 24 insertions(+), 26 deletions(-)

[PATCH v2 4/4] iommu/amd: Remove calc_devid() and use PCI_DEVID() from pci
(no change to this patch - but tagging it v2 for clarity)

 drivers/iommu/amd_iommu.c       |    2 +-
 drivers/iommu/amd_iommu_init.c  |    6 +++---
 drivers/iommu/amd_iommu_types.h |    7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)
