From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH 0/4] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Tue, 5 Mar 2019 11:14:27 +0000
Message-ID: <855ED37F-2E4A-4BDD-9B09-64C41179C319@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dfad72a1-ce47-35bd-d965-27ef2e8bd504@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

The motivation for this is buggy domain <-> IOMMU group relationship =
when=20
using find_or_alloc_domain. =46rom what I have read it should be the =
case=20
that an IOMMU domain is shared by all devices in the same group, thus =
the=20
same mappings. This is because the IOMMU group is determined by things=20=

like ACS settings on pci switches which determines whether devices can=20=

talk to each other.

In find_or_alloc_domain we only determine domain sharing based on =
devices=20
returned by pci_for_each_dma_alias, whereas there are many more checks =
in=20
pci_device_group(e.g. ACS settings of intermediary pci switches), which =
is=20
used for determining which IOMMU group a device is in. This =
discontinuity=20
means it can be the case that each device within an IOMMU group will =
have=20
different domains.

We see issues as it is supposed to be safe to assume that devices within =
a=20
group should be considered to be in the same address space, but if each=20=

device has its own domain then any mapping created won=E2=80=99t be =
valid for the=20
other devices, and even could be mapped differently for each device. =
This=20
also could cause issues with a device whose RMRR's are not applied to =
the=20
domains of other devices within its group, these regions could be =
remapped=20
for the other devices resulting in unexpected behaviour during=20
peer-to-peer transfers.

Cheers,
James


> On 5 Mar 2019, at 06:05, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> Very glad to see this. Thank you!
>=20
> On 3/4/19 11:41 PM, James Sewart wrote:
>> Hey,
>> This patchset moves IOMMU_DOMAIN_DMA iommu domain management to =
iommu.c.
>> This avoids the use of find_or_alloc_domain whose domain assignment =
is
>> inconsistent with the iommu grouping as determined by =
pci_device_group.
>=20
> Is this a bug fix or an improvement? What's the real issue will it =
cause
> if we go without this patch set?
>=20
> Best regards,
> Lu Baolu
>=20
>> Patch 3 permits domain type IOMMU_DOMAIN_DMA to be allocated via the
>> iommu_ops api, allowing the default_domain of an iommu group to be =
set in
>> iommu.c. This domain will be attached to every device that is brought =
up
>> with an iommu group, and the devices reserved regions will be mapped =
using
>> regions returned by get_resv_regions.
>> In intel_iommu_domain_alloc we don=E2=80=99t know the IOMMU this =
domain will be
>> associated with so we defer full initialisation until
>> intel_iommu_attach_device. Currently iommu.c:iommu_group_add_device =
will
>> try to map a devices reserved regions before attaching the domain =
which
>> would cause issue if the domain is not fully initialised. This is
>> addressed in patch 1 by moving the mapping to after attaching.
>> Patch 2 implements function apply_resv_region, used in
>> iommu_group_create_direct_mappings to mark the reserved regions as =
non
>> mappable for the dma_map_ops api.
>> Patch 4 removes the domain lazy allocation logic. Before this patch =
the
>> lazy allocation logic would not be used as any domain allocated using
>> these paths would be replaced when attaching the group default =
domain.
>> Default domain allocation has been tested with and without this patch =
on
>> 4.19.
>> Cheers,
>> James.
>> James Sewart (4):
>>   iommu: Move iommu_group_create_direct_mappings to after =
device_attach
>>   iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>>   iommu/vt-d: Allow IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_IDENTITY to be =
allocated
>>   iommu/vt-d: Remove lazy allocation of domains
>>  drivers/iommu/intel-iommu.c | 329 =
++++++++++++------------------------
>>  drivers/iommu/iommu.c       |   4 +-
>>  2 files changed, 108 insertions(+), 225 deletions(-)
