From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v2 00/19] Shared virtual address IOMMU and VT-d support
Date: Tue, 23 Apr 2019 16:31:00 -0700
Message-ID: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Eric Auger <eric.auger@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to enable SVA virtualization, i.e. shared guest
application address space and physical device DMA address. Only IOMMU portion
of the changes are included in this series. Additional support is needed in
VFIO and QEMU (will be submitted separately) to complete this functionality.

To make incremental changes and reduce the size of each patchset. This series
does not inlcude support for page request services.

In VT-d implementation, PASID table is per device and maintained in the host.
Guest PASID table is shadowed in VMM where virtual IOMMU is emulated.

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables


This work is based on collaboration with other developers on the IOMMU
mailing list. Notably,

[1] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
https://lkml.org/lkml/2019/3/17/124

[2] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
Brucker
https://www.spinics.net/lists/iommu/msg30639.html

[3] [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation by Lu Baolu
https://lkml.org/lkml/2018/11/12/1921

[4] [PATCH v5 00/23] IOMMU and VT-d driver support for Shared Virtual
    Address (SVA)
    https://lwn.net/Articles/754331/

There are roughly three parts:
1. Generic PASID allocator [1] with extension to support custom allocator
2. IOMMU cache invalidation passdown from guest to host
3. Guest PASID bind for nested translation

All generic IOMMU APIs are reused from [1], which has a v7 just published with
no real impact to the patches used here. It is worth noting that unlike sMMU
nested stage setup, where PASID table is owned by the guest, VT-d PASID table is
owned by the host, individual PASIDs are bound instead of the PASID table.

This series is based on the new VT-d 3.0 Specification (https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf).
This is different than the older series in [4] which was based on the older
specification that does not have scalable mode.


ChangeLog:
	- V2
	  - Rebased on Joerg's IOMMU x86/vt-d branch v5.1-rc4
	  - Integrated with Eric Auger's new v7 series for common APIs
	  (https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7)
	  - Addressed review comments from Andy Shevchenko and Alex Williamson on
	    IOASID custom allocator.
	  - Support multiple custom IOASID allocators (vIOMMUs) and dynamic
	    registration.


Jacob Pan (16):
  driver core: add per device iommu param
  iommu: introduce device fault data
  iommu: introduce device fault report API
  iommu: Introduce attach/detach_pasid_table API
  ioasid: Convert ioasid_idr to XArray
  ioasid: Add custom IOASID allocator
  iommu/vt-d: Add custom allocator for IOASID
  iommu/vt-d: Replace Intel specific PASID allocator with IOASID
  iommu/vt-d: Move domain helper to header
  iommu/vt-d: Add nested translation support
  iommu: Add guest PASID bind function
  iommu/vt-d: Add bind guest PASID support
  iommu/vtd: Clean up for SVM device list
  iommu: Add max num of cache and granu types
  iommu/vt-d: Support flushing more translation cache types
  iommu/vt-d: Add svm/sva invalidate function

Jean-Philippe Brucker (1):
  drivers core: Add I/O ASID allocator

Liu, Yi L (1):
  iommu: Introduce cache_invalidate API

Lu Baolu (1):
  iommu/vt-d: Enlightened PASID allocation

 drivers/base/Kconfig        |   6 +
 drivers/base/Makefile       |   1 +
 drivers/base/ioasid.c       | 265 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/dmar.c        |  48 ++++++++
 drivers/iommu/intel-iommu.c | 236 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-pasid.c | 189 ++++++++++++++++++++++++-----
 drivers/iommu/intel-pasid.h |  24 +++-
 drivers/iommu/intel-svm.c   | 289 +++++++++++++++++++++++++++++++++++---------
 drivers/iommu/iommu.c       | 188 +++++++++++++++++++++++++++-
 include/linux/device.h      |   3 +
 include/linux/intel-iommu.h |  41 ++++++-
 include/linux/intel-svm.h   |   7 ++
 include/linux/ioasid.h      |  53 ++++++++
 include/linux/iommu.h       | 121 +++++++++++++++++++
 include/uapi/linux/iommu.h  | 255 ++++++++++++++++++++++++++++++++++++++
 16 files changed, 1625 insertions(+), 102 deletions(-)
 create mode 100644 drivers/base/ioasid.c
 create mode 100644 include/linux/ioasid.h
 create mode 100644 include/uapi/linux/iommu.h

-- 
2.7.4
