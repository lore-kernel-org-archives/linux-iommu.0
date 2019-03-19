From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 0/7] iommu/vt-d: Fix-up device-domain relationship by
 refactoring to use iommu group default domain.
Date: Tue, 19 Mar 2019 13:35:21 +0000
Message-ID: <94706334-3DE4-4964-8FDD-125C58D493A0@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0e74cc54-bb90-a620-5763-466cb11aaef7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 15 Mar 2019, at 03:13, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/14/19 7:56 PM, James Sewart wrote:
>> Patches 1 and 2 are the same as v1.
>> v1-v2:
>>   Refactored ISA direct mappings to be returned by =
iommu_get_resv_regions.
>>   Integrated patch by Lu to defer turning on DMAR until iommu.c has =
mapped
>> reserved regions.
>>   Integrated patches by Lu to remove more unused code in cleanup.
>> Lu: I didn't integrate your patch to set the default domain type as =
it
>> isn't directly related to the aim of this patchset. Instead patch 4
>=20
> Without those patches, user experience will be affected and some =
devices
> will not work on Intel platforms anymore.
>=20
> For a long time, Intel IOMMU driver has its own logic to determine
> whether a device requires an identity domain. For example, when user
> specifies "iommu=3Dpt" in kernel parameter, all device will be =
attached
> with the identity domain. Further more, some quirky devices require
> an identity domain to be used before enabling DMA remapping, =
otherwise,
> it will not work. This was done by adding quirk bits in Intel IOMMU
> driver.
>=20
> So from my point of view, one way is porting all those quirks and =
kernel
> parameters into IOMMU generic layer, or opening a door for vendor =
IOMMU
> driver to determine the default domain type by their own. I prefer the
> latter option since it will not impact any behaviors on other
> architectures.

I see your point. I=E2=80=99m not confident that using the proposed door =
to set a=20
groups default domain has the desired behaviour. As discussed before the=20=

default domain type will be set based on the desired type for only the=20=

first device attached to a group. I think to change the default domain=20=

type you would need a slightly different door that wasn=E2=80=99t =
conditioned on=20
device.

For situations where individual devices require an identity domain =
because=20
of quirks then maybe calling is_identity_map per device in=20
iommu_group_get_for_dev is a better solution than the one I proposed.

>=20
>> addresses the issue of a device requiring an identity domain by =
ignoring
>> the domain param in attach_device and printing a warning.
>=20
> This will not work as I commented in that thread.
>=20
>> I booted some of our devices with this patchset and haven't seen any
>> issues. It doesn't look like we have any devices with RMRR's though =
so
>> those codepaths aren't tested.
>> James Sewart (7):
>>   iommu: Move iommu_group_create_direct_mappings to after =
device_attach
>>   iommu/vt-d: Implement apply_resv_region for reserving IOVA ranges
>>   iommu/vt-d: Expose ISA direct mapping region via
>>     iommu_get_resv_regions
>>   iommu/vt-d: Ignore domain parameter in attach_device if device
>>     requires identity map
>>   iommu/vt-d: Allow IOMMU_DOMAIN_DMA to be allocated by iommu_ops
>>   iommu/vt-d: Remove lazy allocation of domains
>> Lu Baolu (1):
>>   iommu/vt-d: Enable DMA remapping after rmrr mapped
>>  drivers/iommu/intel-iommu.c | 444 =
+++++++++++-------------------------
>>  drivers/iommu/iommu.c       |   4 +-
>>  2 files changed, 131 insertions(+), 317 deletions(-)
>=20
> Best regards,
> Lu Baolu

Cheers,
James.
