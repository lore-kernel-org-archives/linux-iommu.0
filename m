From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 00/12] iommu/vt-d: Add scalable mode support
Date: Wed, 28 Nov 2018 11:54:37 +0800
Message-ID: <20181128035449.10226-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

Intel vt-d rev3.0 [1] introduces a new translation mode called
'scalable mode', which enables PASID-granular translations for
first level, second level, nested and pass-through modes. The
vt-d scalable mode is the key ingredient to enable Scalable I/O
Virtualization (Scalable IOV) [2] [3], which allows sharing a
device in minimal possible granularity (ADI - Assignable Device
Interface). It also includes all the capabilities required to
enable Shared Virtual Addressing (SVA). As a result, previous
Extended Context (ECS) mode is deprecated (no production ever
implements ECS).

Each scalable mode pasid table entry is 64 bytes in length, with
fields point to the first level page table and the second level
page table. The PGTT (Pasid Granular Translation Type) field is
used by hardware to determine the translation type.


          A Scalable Mode            .-------------.
           PASID Entry             .-|             |
       .------------------.      .-| | 1st Level   |
      7|                  |      | | | Page Table  |
       .------------------.      | | |             |
      6|                  |      | | |             |
       '------------------'      | | '-------------'
      5|                  |      | '-------------'
       '------------------'      '-------------'
      4|                  |    ^
       '------------------'   /
      3|                  |  /       .-------------.
       .----.-------.-----. /      .-|             |
      2|    | FLPTR |     |/     .-| | 2nd Level   |
       .----'-------'-----.      | | | Page Table  |
      1|                  |      | | |             |
       .-.-------..------..      | | |             |
      0| | SLPTR || PGTT ||----> | | '-------------'
       '-'-------''------''      | '-------------'
       6             |    0      '-------------'
       3             v
             .------------------------------------.
             | PASID Granular Translation Type    |
             |                                    |
             | 001b: 1st level translation only   |
             | 101b: 2nd level translation only   |
             | 011b: Nested translation           |
             | 100b: Pass through                 |
             '------------------------------------'

This patch series adds the scalable mode support in the Intel
IOMMU driver. It will make all the Intel IOMMU features work
in scalable mode. The changes are all constrained within the
Intel IOMMU driver, as it's purely internal format change.

References:
[1] https://software.intel.com/en-us/download/intel-virtualization-technology-for-directed-io-architecture-specification
[2] https://software.intel.com/en-us/download/intel-scalable-io-virtualization-technical-specification
[3] https://schd.ws/hosted_files/lc32018/00/LC3-SIOV-final.pdf

Change log:
v4->v5:
  - [04/12] Add a comment to explain why we only print
            two QWORDs of an invalid descriptor.
  - [06/12] Fix domain agaw being less than iommu agaw.
  - [09/12] Move data type to local branch.
  - [11/12] Hold iommu lock when setup pasid entry for
            SVM.
  - All rebased on top of vt-d branch of iommu tree.

v3->v4:
  - Rebase all patches to 4.20-rc1.
  - Use the right PASID directory table size.
  - Add a function for pass through translation setting up.
  - Refine the parameters passed to first level translation
    mode interface.

v2->v3:
  - Rebase all patches on top of vt-d branch of iommu repo.
  - Set the pasid directory table size to 1 page for devices
    which have no pasid support.
  - Fix various comments received during v2 review period.
    All were code style related.

v1->v2:
  - Rebase all patches on top of v4.19-rc1;
  - Add 256-bit invalidation descriptor support;
  - Reserve a domain id for first level and pass-through
    usage to make hardware cache entries more efficiently;
  - Various code refinements.

Lu Baolu (12):
  iommu/vt-d: Enumerate the scalable mode capability
  iommu/vt-d: Manage scalalble mode PASID tables
  iommu/vt-d: Move page table helpers into header
  iommu/vt-d: Add 256-bit invalidation descriptor support
  iommu/vt-d: Reserve a domain id for FL and PT modes
  iommu/vt-d: Add second level page table interface
  iommu/vt-d: Setup pasid entry for RID2PASID support
  iommu/vt-d: Pass pasid table to context mapping
  iommu/vt-d: Setup context and enable RID2PASID support
  iommu/vt-d: Add first level page table interface
  iommu/vt-d: Shared virtual address in scalable mode
  iommu/vt-d: Remove deferred invalidation

 .../admin-guide/kernel-parameters.txt         |  12 +-
 drivers/iommu/dmar.c                          |  91 ++--
 drivers/iommu/intel-iommu.c                   | 336 ++++++-------
 drivers/iommu/intel-pasid.c                   | 447 +++++++++++++++++-
 drivers/iommu/intel-pasid.h                   |  40 +-
 drivers/iommu/intel-svm.c                     | 170 +++----
 drivers/iommu/intel_irq_remapping.c           |   6 +-
 include/linux/intel-iommu.h                   |  75 ++-
 8 files changed, 826 insertions(+), 351 deletions(-)

-- 
2.17.1
