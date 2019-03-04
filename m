From: James Sewart <jamessewart@arista.com>
Subject: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Mon, 4 Mar 2019 15:41:26 +0000
Message-ID: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

Hey,

This patchset moves IOMMU_DOMAIN_DMA iommu domain management to iommu.c.=20=

This avoids the use of find_or_alloc_domain whose domain assignment is=20=

inconsistent with the iommu grouping as determined by pci_device_group.

Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the=20
iommu_ops api, allowing the default_domain of an iommu group to be set =
in=20
iommu.c. This domain will be attached to every device that is brought up=20=

with an iommu group, and the devices reserved regions will be mapped =
using=20
regions returned by get_resv_regions.

In intel_iommu_domain_alloc we don=E2=80=99t know the IOMMU this domain =
will be=20
associated with so we defer full initialisation until=20
intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device will=20=

try to map a devices reserved regions before attaching the domain which=20=

would cause issue if the domain is not fully initialised. This is=20
addressed in patch 1 by moving the mapping to after attaching.

Patch 2 implements function apply_resv_region, used in=20
iommu_group_create_direct_mappings to mark the reserved regions as non=20=

mappable for the dma_map_ops api.

Patch 4 removes the domain lazy allocation logic. Before this patch the=20=

lazy allocation logic would not be used as any domain allocated using=20
these paths would be replaced when attaching the group default domain.=20=

Default domain allocation has been tested with and without this patch on=20=

4.19.

Cheers,
James.

James Sewart (4):
  iommu: Move iommu_group_create_direct_mappings to after device_attach
  iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
  iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be =
allocated
  iommu/vt-d: Remove lazy allocation of domains

 drivers/iommu/intel-iommu.c | 329 ++++++++++++------------------------
 drivers/iommu/iommu.c       |   4 +-
 2 files changed, 108 insertions(+), 225 deletions(-)

--=20
2.17.1
