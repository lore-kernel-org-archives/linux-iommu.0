From: Wei Chen <Wei.Chen@arm.com>
Subject: [PATCH] iommu/arm-smmu: request pcie devices to enable ACS
Date: Mon, 13 Jun 2016 17:20:17 +0800
Message-ID: <1465809617-13003-1-git-send-email-Wei.Chen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, steve.capper@arm.com
List-Id: iommu@lists.linux-foundation.org

The PCIe ACS capability will affect the layout of iommu groups.
Generally speaking, if the path from root port to the PCIe device
is ACS enabled, the iommu will create a single iommu group for this
PCIe device. If all PCIe devices on the path are ACS enabled then
Linux can determine this path is ACS enabled.

Linux use two PCIe configuration registers to determine the ACS
status of PCIe devices:
ACS Capability Register and ACS Control Register.

The first register is used to check the implementation of ACS function
of a PCIe device, the second register is used to check the enable status
of ACS function. If one PCIe device has implemented and enabled the ACS
function then Linux will determine this PCIe device enabled ACS.

>From the Chapter:6.12 of PCI Express Base Specification Revision 3.1a,
we can find that when a PCIe device implements ACS function, the enable
status is set to disabled by default and can be enabled by ACS-aware
software.

ACS will affect the iommu groups topology, so, the iommu driver is
ACS-aware software. This patch adds a call to pci_request_acs() to the
arm-smmu driver to enable the ACS function in PCIe devices that support
it.

Signed-off-by: Wei Chen <Wei.Chen@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 drivers/iommu/arm-smmu.c    | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 94b6821..30ea899 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2686,6 +2686,8 @@ static int __init arm_smmu_init(void)
        if (ret)
                return ret;

+       pci_request_acs();
+
        return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 }

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 9345a3f..ab365ec 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -2096,8 +2096,10 @@ static int __init arm_smmu_init(void)
 #endif

 #ifdef CONFIG_PCI
-       if (!iommu_present(&pci_bus_type))
+       if (!iommu_present(&pci_bus_type)) {
+               pci_request_acs();
                bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
+       }
 #endif

        return 0;
