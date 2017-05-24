From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 0/7] Add PCI ATS support to SMMUv3
Date: Wed, 24 May 2017 19:01:36 +0100
Message-ID: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org
Cc: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, okaya@codeaurora.org, sunil.kovvuri@gmail.com, thunder.leizhen@huawei.com, tn@semihalf.com
List-Id: iommu@lists.linux-foundation.org

PCIe devices can implement their own TLB, named Address Translation Cache
(ATC). In order to support Address Translation Service (ATS), the
following changes are needed in software:

* Enable ATS on endpoints when the system supports it. Both PCI root
  complex and associated SMMU must implement the ATS protocol.

* When unmapping an IOVA, send an ATC invalidate request to the endpoint
  in addition to the usual SMMU IOTLB invalidations.

I previously sent this as part of a lengthy RFC [1] adding SVM (ATS +
PASID + PRI) support to SMMUv3. The next PASID/PRI version is almost
ready, but isn't likely to get merged because it needs hardware testing,
so I will send it later. PRI depends on ATS, but ATS should be useful on
its own.

Without PASID and PRI, ATS is used for accelerating transactions. Instead
of having all memory accesses go through SMMU translation, the endpoint
can translate IOVA->PA once, store the result in its ATC, then issue
subsequent transactions using the PA, partially bypassing the SMMU. So in
theory it should be faster while keeping the advantages of an IOMMU,
namely scatter-gather and access control.

The ATS patches can now be tested on some hardware, even though the lack
of compatible PCI endpoints makes it difficult to assess what performance
optimizations we need. That's why the ATS implementation is a bit rough at
the moment, and we will work on optimizing things like invalidation ranges
later.

Since the RFC [1]:
* added DT and ACPI patches,
* added invalidate-all on domain detach,
* removed smmu_group again,
* removed invalidation print from the fast path,
* disabled tagged pointers for good,
* some style changes.

These patches are based on Linux v4.12-rc2

[1] https://www.spinics.net/lists/linux-pci/msg58650.html

Jean-Philippe Brucker (7):
  PCI: Move ATS declarations outside of CONFIG_PCI
  dt-bindings: PCI: Describe ATS property for root complex nodes
  iommu/of: Check ATS capability in root complex nodes
  ACPI/IORT: Check ATS capability in root complex nodes
  iommu/arm-smmu-v3: Link domains and devices
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers

 .../devicetree/bindings/pci/pci-iommu.txt          |   8 +
 drivers/acpi/arm64/iort.c                          |  10 +
 drivers/iommu/arm-smmu-v3.c                        | 258 ++++++++++++++++++++-
 drivers/iommu/of_iommu.c                           |   8 +
 include/linux/iommu.h                              |   4 +
 include/linux/pci.h                                |  26 +--
 6 files changed, 293 insertions(+), 21 deletions(-)

-- 
2.12.1

