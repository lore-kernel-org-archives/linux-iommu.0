From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 0/8] iommu/vt-d: Delegate DMA domain to generic iommu
Date: Mon, 29 Apr 2019 10:09:17 +0800
Message-ID: <20190429020925.18136-1-baolu.lu@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, jacob.jun.pan@intel.com, kevin.tian@intel.com, jamessewart@arista.com, tmurphy@arista.com, dima@arista.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hi,

This patchset delegates the iommu DMA domain management to the
generic iommu layer. It avoids the use of find_or_alloc_domain
whose domain assignment is inconsistent with the iommu grouping
as determined by pci_device_group.

The major change is to permit domains of type IOMMU_DOMAIN_DMA
and IOMMU_DOMAIN_IDENTITY to be allocated via the iommu_ops api.
This allows the default_domain of an iommu group to be set in
iommu.c. This domain will be attached to every device that is
brought up with an iommu group, and the devices reserved regions
will be mapped using regions returned by get_resv_regions.

The default domain implementation defines a default domain type
and a domain of the default domain type will be allocated and
attached to devices which belong to a same group. Unfortunately,
this doesn't work for some quirky devices which is known to only
work with a specific domain type. PATCH 1/8 adds an iommu ops
which allows the IOMMU driver to return whether a device requires
a specific domain type, otherwise the staic defined type will be
applied.

Other changes are limited within the Intel IOMMU driver. They
mainly allow the driver to adapt to allocating domains, attaching
domains, applying and direct mapping reserved memory regions,
deferred domain attachment, and so on, via the iommu_ops api's.

This patchset was initiated by James Sewart. The v1 and v2 were
posted here [1] [2] for discussion. Lu Baolu took over the work
for testing and bug fixing with permission from James Sewart.

Reference:
[1] https://lkml.org/lkml/2019/3/4/644
[2] https://lkml.org/lkml/2019/3/14/299

Best regards,
Lu Baolu

Change log:
 v2->v3:
  - Add supported default domain type callback.
  - Make the iommu map() callback work even the domain is not
    attached.
  - Add domain deferred attach when iommu is pre-enabled in
    kdump kernel. 

 v1->v2:
  - https://lkml.org/lkml/2019/3/14/299
  - Refactored ISA direct mappings to be returned by
    iommu_get_resv_regions.
  - Integrated patch by Lu to defer turning on DMAR until iommu.c
    has mapped reserved regions.
  - Integrated patches by Lu to remove more unused code in cleanup.

 v1:
  -Original post https://lkml.org/lkml/2019/3/4/644

James Sewart (4):
  iommu/vt-d: Implement apply_resv_region iommu ops entry
  iommu/vt-d: Expose ISA direct mapping region via
    iommu_get_resv_regions
  iommu/vt-d: Allow DMA domains to be allocated by iommu ops
  iommu/vt-d: Remove lazy allocation of domains

Lu Baolu (4):
  iommu: Add ops entry for supported default domain type
  iommu/vt-d: Enable DMA remapping after rmrr mapped
  iommu/vt-d: Implement def_domain_type iommu ops entry
  iommu/vt-d: Implement is_attach_deferred iommu ops entry

 drivers/iommu/intel-iommu.c | 630 +++++++++++-------------------------
 drivers/iommu/iommu.c       |  13 +-
 include/linux/iommu.h       |  11 +
 3 files changed, 210 insertions(+), 444 deletions(-)

-- 
2.17.1
