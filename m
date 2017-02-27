From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: [RFC PATCH 00/30] Add PCIe SVM support to ARM SMMUv3
Date: Mon, 27 Feb 2017 19:54:11 +0000
Message-ID: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
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
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

This series adds support for PCI ATS, PRI and PASID extensions to the
SMMUv3 driver. In systems that support it, it is now possible for some
high-end devices to perform DMA into process address spaces. Page tables
are shared between MMU and SMMU; page faults from devices are recoverable
and handled by the mm subsystem.

We propose an extension to the IOMMU API that unifies existing SVM
implementations (AMD, Intel and ARM) in patches 22 and 24. Nothing is set
in stone, the goal is to start discussions and find an intersection
between implementations.

We also propose a VFIO interface in patches 29 and 30, that allows
userspace device drivers to make use of SVM. It would also serve as
example implementation for other device drivers.

Overview of the patches:

* 1 and 2 prepare the SMMUv3 structures for ATS,
* 3 to 5 enable ATS for devices that support it.
* 6 to 10 prepare the SMMUv3 structures for PASID and PRI. Patch 9,
  in particular, provides details on the structure requirements.
* 11 introduces an interface for sharing ASIDs on ARM64,
* 12 to 17 add more infrastructure for sharing page tables,
* 18 and 19 add minor helpers to PCI,
* 20 enables PASID in devices that support it,
* 21 enables PRI and adds device fault handler,
* 22 and 24 draft a possible interface for SVM in the IOMMU API
* 23 and 25-28 finalize support for SVM in SMMUv3
* 29 and 30 draft a possible interface for SVM in VFIO. 

The series is available on git://linux-arm.org/linux-jpb.git svm/rfc1
Enable CONFIG_PCI_PASID, CONFIG_PCI_PRI and you should be good to go.

So far, this has only been tested with a software model of an SMMUv3 and a
PCIe DMA engine. We don't intend to get this merged until it has been
tested on silicon, but at least the driver implementation should be mature
enough. I might split next versions depending on what is ready and what
needs more work so we can merge it progressively.

A lot of open questions remain:

1. Can we declare that PASID 0 is always invalid?

2. For this prototype, I kept the interface simple from an implementation
   perspective. At the moment is is "bind this device to that address
   space". For consistency with the rest of VFIO and IOMMU, I think "bind
   this container to that address space" would be more in line with VFIO,
   and "bind that group to that address space" more in line with IOMMU.
   VFIO would tell the IOMMU "for all groups in this container, bind to
   that address space".
   This raises the question of inconsistency between device capabilities.
   When adding a device that supports less PASID bits to a group, what do
   we do? What if we already allocated a PASID that is out of range for
   the new device?

3. How do we reconcile the IOMMU fault reporting infrastructure with the
   SVM interface?

4. SVM is the product of two features: handling device faults, and devices
   having multiple address spaces. What about one feature without the
   other?
   a. If we cannot afford to have a device fault, can we at least share a
      pinned address space? Pinning all current memory would be done by
      vfio, but there also need to be pinning of all future mappings.
      (mlock isn't sufficient, still allows for minor faults.)
   b. If the device has a single address space, can we still bind it to a
      process? The main issue with unifying DMA and process page tables is
      reserved regions on the device side. What do we do if, for instance,
      and MSI frame address clashes with a process mapping? Or if a
      process mapping exists outside of the device's DMA window?

Please find more details in the IOMMU API and VFIO patches.

Thanks,
Jean-Philippe

Cc: Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
Cc: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>

Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Jean-Philippe Brucker (30):
  iommu/arm-smmu-v3: Link groups and devices
  iommu/arm-smmu-v3: Link groups and domains
  PCI: Move ATS declarations outside of CONFIG_PCI
  iommu/arm-smmu-v3: Add support for PCI ATS
  iommu/arm-smmu-v3: Disable tagged pointers when ATS is in use
  iommu/arm-smmu-v3: Add support for Substream IDs
  iommu/arm-smmu-v3: Add second level of context descriptor table
  iommu/arm-smmu-v3: Add support for VHE
  iommu/arm-smmu-v3: Support broadcast TLB maintenance
  iommu/arm-smmu-v3: Add task contexts
  arm64: mm: Pin down ASIDs for sharing contexts with devices
  iommu/arm-smmu-v3: Keep track of process address spaces
  iommu/io-pgtable-arm: Factor out ARM LPAE register defines
  iommu/arm-smmu-v3: Share process page tables
  iommu/arm-smmu-v3: Steal private ASID from a domain
  iommu/arm-smmu-v3: Use shared ASID set
  iommu/arm-smmu-v3: Add SVM feature checking
  PCI: Make "PRG Response PASID Required" handling common
  PCI: Cache PRI and PASID bits in pci_dev
  iommu/arm-smmu-v3: Enable PCI PASID in masters
  iommu/arm-smmu-v3: Handle device faults from PRI
  iommu: Bind/unbind tasks to/from devices
  iommu/arm-smmu-v3: Bind/unbind device and task
  iommu: Specify PASID state when unbinding a task
  iommu/arm-smmu-v3: Safe invalidation and recycling of PASIDs
  iommu/arm-smmu-v3: Fix PRI queue overflow acknowledgement
  iommu/arm-smmu-v3: Handle PRI queue overflow
  iommu/arm-smmu-v3: Add support for Hardware Translation Table Update
    at stage 1
  vfio: Add support for Shared Virtual Memory
  vfio: Allow to bind foreign task

 MAINTAINERS                          |    1 +
 arch/arm64/include/asm/mmu.h         |    1 +
 arch/arm64/include/asm/mmu_context.h |   11 +-
 arch/arm64/mm/context.c              |   80 +-
 drivers/iommu/amd_iommu.c            |   19 +-
 drivers/iommu/arm-smmu-v3.c          | 2593 ++++++++++++++++++++++++++++++++--
 drivers/iommu/io-pgtable-arm.c       |   48 +-
 drivers/iommu/io-pgtable-arm.h       |   67 +
 drivers/iommu/iommu.c                |  116 ++
 drivers/pci/ats.c                    |   40 +
 drivers/vfio/pci/vfio_pci.c          |   24 +
 drivers/vfio/vfio.c                  |  135 ++
 include/linux/iommu.h                |   57 +
 include/linux/pci-ats.h              |    8 +
 include/linux/pci.h                  |   28 +-
 include/uapi/linux/pci_regs.h        |    1 +
 include/uapi/linux/vfio.h            |   70 +
 17 files changed, 3084 insertions(+), 215 deletions(-)
 create mode 100644 drivers/iommu/io-pgtable-arm.h

-- 
2.11.0
