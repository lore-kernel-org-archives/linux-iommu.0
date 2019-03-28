From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date: Thu, 28 Mar 2019 18:37:31 +0000
Message-ID: <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 26 Mar 2019, at 01:24, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/25/19 8:57 PM, James Sewart wrote:
>>>> Theres an issue that if we choose to alloc a new resv_region with =
type
>>>> IOMMU_RESV_DIRECT, we will need to refactor =
intel_iommu_put_resv_regions
>>>> to free this entry type which means refactoring the rmrr regions in
>>>> get_resv_regions. Should this work be in this patchset?
>>> Do you mean the rmrr regions are not allocated in get_resv_regions, =
but
>>> are freed in put_resv_regions? I think we should fix this in this =
patch
>>> set since this might impact the device passthrough if we don't do =
it.
>> They=E2=80=99re not allocated and not freed currently, only type =
IOMMU_RESV_MSI is
>> freed in put_resv_regions. If we allocate a new resv_region with type
>> IOMMU_RESV_DIRECT for the isa region, then it won=E2=80=99t be freed. =
If we modify
>> put_resv_regions to free type IOMMU_RESV_DIRECT, then we will try to =
free
>> the static RMRR regions.
>> Either the ISA region is static and not freed as with my =
implementation,
>> or the RMRR regions are converted to be allocated on each call to
>> get_resv_regions and freed in put_resv_regions.
>=20
> By the way, there's another way in my mind. Let's add a new region =
type
> for LPC devices, e.x. IOMMU_RESV_LPC, and then handle it in the same =
way
> as those MSI regions. Just FYI.

This solution would require adding some extra code to=20
iommu_group_create_direct_mappings as currently only type=20
IOMMU_RESV_DIRECT is identity mapped, other types are only reserved.


>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
