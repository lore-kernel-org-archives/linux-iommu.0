From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: [RFC PATCH 0/8] Shared Virtual Memory virtualization for VT-d
Date: Wed, 26 Apr 2017 18:11:57 +0800
Message-ID: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com
List-Id: iommu@lists.linux-foundation.org

Hi,

This patchset introduces SVM virtualization for intel_iommu in
IOMMU/VFIO. The total SVM virtualization for intel_iommu touched
Qemu/IOMMU/VFIO.

Another patchset would change the Qemu. It is "[RFC PATCH 0/20] Qemu:
Extend intel_iommu emulator to support Shared Virtual Memory"

In this patchset, it adds two new IOMMU APIs and their implementation
in intel_iommu driver. In VFIO, it adds two IOCTL cmd attached on
container->fd to propagate data from QEMU to kernel space.

[Patch Overview]
* 1 adds iommu API definition for binding guest PASID table
* 2 adds binding PASID table API implementation in VT-d iommu driver
* 3 adds iommu API definition to do IOMMU TLB invalidation from guest
* 4 adds IOMMU TLB invalidation implementation in VT-d iommu driver
* 5 adds VFIO IOCTL for propagating PASID table binding from guest
* 6 adds processing of pasid table binding in vfio_iommu_type1
* 7 adds VFIO IOCTL for propagating IOMMU TLB invalidation from guest
* 8 adds processing of IOMMU TLB invalidation in vfio_iommu_type1

Best Wishes,
Yi L


Jacob Pan (3):
  iommu: Introduce bind_pasid_table API function
  iommu/vt-d: add bind_pasid_table function
  iommu/vt-d: Add iommu do invalidate function

Liu, Yi L (5):
  iommu: Introduce iommu do invalidate API function
  VFIO: Add new IOTCL for PASID Table bind propagation
  VFIO: do pasid table binding
  VFIO: Add new IOCTL for IOMMU TLB invalidate propagation
  VFIO: do IOMMU TLB invalidation from guest

 drivers/iommu/intel-iommu.c     | 146 ++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c           |  32 +++++++++
 drivers/vfio/vfio_iommu_type1.c |  98 +++++++++++++++++++++++++++
 include/linux/dma_remapping.h   |   1 +
 include/linux/intel-iommu.h     |  11 +++
 include/linux/iommu.h           |  47 +++++++++++++
 include/uapi/linux/vfio.h       |  26 +++++++
 7 files changed, 361 insertions(+)

-- 
1.9.1
