From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH 0/1] IOMMU SVA device driver interface
Date: Wed, 20 Feb 2019 14:27:58 +0000
Message-ID: <20190220142759.33308-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, christian.koenig@amd.com, kevin.tian@intel.com, jacob.jun.pan@linux.intel.com, ashok.raj@intel.com, baolu.lu@linux.intel.com, alex.williamson@redhat.com
List-Id: iommu@lists.linux-foundation.org

This series focuses on the device driver API for SVA, as I'd like to get
at least parts of it merged in v5.2 [1]. If we can get consensus on the
interface, it will be easier for device drivers to start adding SVA
support while we're improving the IOMMU side.

Since v3 [2] I changed the interface as requested, and changed iommu-sva
to be a set of helpers rather than the main entry point. This way
intel-svm and amd_iommu_v2 can support the common bind() API without
having to move to the generic implementation (which I'm still rewriting).

The four dev_feature functions are implemented by Lu Baolu's IOMMU-aware
mdev series [3].
 
* iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_SVA) -> true/false
  - reports if SVA is supported by IOMMU and device
  - iommu_ops->dev_has_feat()

* iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
  - enables SVA if IOMMU and device support it.
  - iommu_ops->dev_enable_feat()

* iommu_dev_disable_feature(dev, IOMMU_DEV_FEAT_SVA) -> 0/err
  - disable SVA if it was enabled
  - iommu_ops->dev_disable_feat()

* iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_SVA) -> true/false
  - shows the SVA state (could be implemented in iommu.c)
  - iommu_ops->dev_feature_enabled()

* iommu_sva_bind(dev, mm, &pasid, mm_exit_cb, drvdata) -> 0/err
  - Binds dev to mm
  - Sets a callback to disable the PASID, in case mm exits before the dd
    calls unbind()
  - iommu_ops->bind_mm()

* iommu_sva_unbind(dev, &pasid)
  - Unbinds dev from mm
  - iommu_ops->unbind_mm()

Please have a look and tell me what needs to change to be compatible
with intel-svm, amd_iommu_v2 and AMD KFD. As the only SVA user currently
upstream AMD KFD will get preferential treatment, but to keep this
simple I didn't add the min/max_pasid params that AMD KFD requires to
set non-discoverable PASID limits. I could add iommu_dev_set_sva_param()
or something like that?

Thanks,
Jean

[1] The full patch stack contains:
    * bind()/unbind() API
    * fault reporting API
    * ATS for SMMUv3
    * generic IOASID
    * IO mm tracking
    * IO page fault handler
    * PRI + stall for SMMUv3
    * PASID for SMMUv3
    * VFIO usage example
    I'd like to get at least the first three into v5.2

    git://linux-arm.org/linux-jpb.git sva/current
    http://www.linux-arm.org/git?p=linux-jpb.git;a=shortlog;h=refs/heads/sva/current
    Passes all my tests, but needs some refinement.

[2] [PATCH v3 00/10] Shared Virtual Addressing for the IOMMU
    https://www.spinics.net/lists/iommu/msg30076.html
    See also, for more recent interface discussion:
    [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
    https://www.spinics.net/lists/iommu/msg30637.html

[3] [PATCH v6 0/9] vfio/mdev: IOMMU aware mediated device
    https://lore.kernel.org/lkml/20190213040301.23021-10-baolu.lu@linux.intel.com/T/


---
If you're not sure what this all means:

Shared Virtual Addressing (SVA) is the ability to share process address
spaces with devices. It is called "SVM" (Shared Virtual Memory) by OpenCL
and some IOMMU architectures, but since that abbreviation is already used
for AMD virtualisation in Linux (Secure Virtual Machine), we prefer the
less ambiguous "SVA".

Sharing process address spaces with devices allows to rely on core kernel
memory management for DMA, removing some complexity from application and
device drivers. After binding to a device, applications can instruct it to
perform DMA on buffers obtained with malloc.

The device, bus and IOMMU must support the following features:

* Multiple address spaces per device, for example using the PCI PASID
  (Process Address Space ID) extension. The IOMMU driver allocates a
  PASID and the device uses it in DMA transactions.
* I/O Page Faults (IOPF), for example PCI PRI (Page Request Interface) or
  Arm SMMU stall. The core mm handles translation faults from the IOMMU.
* MMU and IOMMU implement compatible page table formats.
---

Jean-Philippe Brucker (1):
  iommu: Bind process address spaces to devices

 drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  24 ++++++++++
 2 files changed, 128 insertions(+)

-- 
2.20.1
