From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation
Date: Mon, 12 Nov 2018 14:44:56 +0800
Message-ID: <20181112064501.2290-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com, tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

This adds an uniformed API set for global PASIDs used by IOMMU
and device drivers which depend on IOMMU. It works for drivers
running on bare metal, full virtualized environments and para-
virtualized environment.

When PASID requests come from components running on the bare
metal hardware, the requests will be routed to the system wide
I/O ASID allocator.


            ^   ^  iommu_pasid_init() 
            |   |  iommu_pasid_exit() 
            |   |  iommu_pasid_alloc()
            |   |  iommu_pasid_free() 
      .-------------------------------.
      |       IOMMU PASID APIs        |
      '-------------------------------'
           |   ^
           v   |
      .------------.  .---------------.
      | I/O ASID   |  |               |
      | allocator  |  | IOMMU drivers |
      | (drivers/  |  |      or       |
      | base/      |  | virtio IOMMU  |
      | ioasid.c)  |  |               |
      '------------'  '---------------'

When PASID requests come from components running in full-virtualized
or para-virtualized environments, they will be routed to the vendor-
specific or virtio IOMMU driver, where the requests will be intercepted
and routed to the Host Linux via VFIO interfaces.

    ......................................
    .            Guest Linux             .
    ......................................
    .                                    .
    . .----------------------------.     .
    . |       IOMMU PASID APIs     |     .
    . '----------------------------'     .
    .                           |        .
    .                           v        .
    .  .----------. .---------------.    ..---------.
    .  | I/O ASID | | IOMMU drivers |    .|  QEMU   |
    .  '----------' | /virtio IOMMU |---->'---------'
    .               '---------------'    .| virtio  |
    ......................................'---------'
                                               |
                                               |
    ...........................................|....
    .                  Host Linux              |   .
    ...........................................|....
    .                      |-------------------'   .
    .                      v                       .
    .         .----------------------------.       .
    .         |       IOMMU PASID APIs     |       .
    .         '----------------------------'       .
    .               |                              .
    .               v       .---------------.      .
    .         .----------.  | IOMMU drivers |      .
    .         | I/O ASID |  | /virtio IOMMU |      .
    .         '----------'  '---------------'      .
    ................................................

Below APIs are introduced:
    
* iommu_pasid_init(pasid)
  - Initialize a PASID consumer. The vendor specific IOMMU
    drivers are able to set the PASID range imposed by IOMMU
    hardware through a callback in iommu_ops.

* iommu_pasid_exit(pasid)
  - The PASID consumer stops consuming any PASID.

* iommu_pasid_alloc(pasid, min, max, private, *ioasid)
  - Allocate a PASID and associate a @private data with this
    PASID. The PASID value is stored in @ioaisd if returning
    success.

* iommu_pasid_free(pasid, ioasid)
  - Free a PASID to the pool so that it could be consumed by
    others.

It also adds below helpers to lookup or iterate PASID items.

* iommu_pasid_for_each(pasid, func, data)
  - Iterate PASID items of the consumer identified by @pasid,
    and call @func() against each item. An error returned from
    @func() will break the iteration.

* iommu_pasid_find(pasid, ioasid)
  - Retrieve the private data associated with @ioasid.

This patch set depends on the I/O APSID allocator posted here
[1] for discussion.

[1] https://www.spinics.net/lists/iommu/msg30639.html

Best regards,
Lu Baolu

Lu Baolu (5):
  iommu: Add APIs for IOMMU PASID management
  iommu/vt-d: Initialize a PASID consumer
  iommu/vt-d: Enlightened PASID allocation
  iommu/vt-d: Allocate and free a pasid
  iommu/vt-d: Use global pasid allocator

 drivers/iommu/Kconfig       |  1 +
 drivers/iommu/intel-iommu.c | 83 +++++++++++++++++++++++++++++++---
 drivers/iommu/intel-pasid.c | 88 +++++++++++++++++++++++++-----------
 drivers/iommu/intel-pasid.h | 16 +++++--
 drivers/iommu/intel-svm.c   | 24 +++++-----
 drivers/iommu/iommu.c       | 89 +++++++++++++++++++++++++++++++++++++
 include/linux/intel-iommu.h |  5 +++
 include/linux/iommu.h       | 73 ++++++++++++++++++++++++++++++
 8 files changed, 332 insertions(+), 47 deletions(-)

-- 
2.17.1
