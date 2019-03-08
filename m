From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
Date: Fri, 8 Mar 2019 16:57:03 +0000
Message-ID: <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
 <F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
 <7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
 <fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
 <4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
 <06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
 <A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
 <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
 <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
 <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bb9c941b-05b6-27aa-d0ca-1d9c56f8f277@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 8 Mar 2019, at 03:09, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/7/19 6:21 PM, James Sewart wrote:
>> Hey Lu,
>>> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>=20
>>> Hi James,
>>>=20
>>> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>>>> -	/*
>>>>>>>> -	 * For each rmrr
>>>>>>>> -	 *   for each dev attached to rmrr
>>>>>>>> -	 *   do
>>>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>>>> -	 *     allocate free domain
>>>>>>>> -	 *     allocate page table entries for rmrr
>>>>>>>> -	 *     if context not allocated for bus
>>>>>>>> -	 *           allocate and init context
>>>>>>>> -	 *           set present in root table for this bus
>>>>>>>> -	 *     init context with domain, translation etc
>>>>>>>> -	 *    endfor
>>>>>>>> -	 * endfor
>>>>>>>> -	 */
>>>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>>>> -		/* some BIOS lists non-exist devices in DMAR =
table. */
>>>>>>>> -		for_each_active_dev_scope(rmrr->devices, =
rmrr->devices_cnt,
>>>>>>>> -					  i, dev) {
>>>>>>>> -			ret =3D iommu_prepare_rmrr_dev(rmrr, =
dev);
>>>>>>>> -			if (ret)
>>>>>>>> -				pr_err("Mapping reserved region =
failed\n");
>>>>>>>> -		}
>>>>>>>> -	}
>>>>>>>> -
>>>>>>>> -	iommu_prepare_isa();
>>>>>>> Why do you want to remove this segment of code?
>>>>>> This will only work if the lazy allocation of domains exists, =
these
>>>>>> mappings will disappear once a default domain is attached to a =
device and
>>>>>> then remade by iommu_group_create_direct_mappings. This code is =
redundant
>>>>>> and removing it allows us to remove all the lazy allocation =
logic.
>>>>> No exactly.
>>>>>=20
>>>>> We need to setup the rmrr mapping before enabling dma remapping,
>>>>> otherwise, there will be a window after dma remapping enabling and
>>>>> rmrr getting mapped, during which people might see dma faults.
>>>> Do you think this patch instead should be a refactoring to simplify =
this initial domain setup before the default domain takes over? It seems =
like duplicated effort to have both lazy allocated domains and =
externally managed domains. We could allocate a domain here for any =
devices with RMRR and call get_resv_regions to avoid duplicating RMRR =
loop.
>>>=20
>>> Agree. We should replace the lazy allocated domains with default =
domain
>>> in a clean way. Actually, your patches look great to me. But I do =
think
>>> we need further cleanups. The rmrr code is one example, and the =
identity
>>> domain (si_domain) is another.
>>>=20
>>> Do you mind if I work on top of your patches for further cleanups =
and
>>> sign off a v2 together with you?
>> Sure, sounds good. I=E2=80=99ll fixup patch 3 and have a go at =
integrating
>> iommu_prepare_isa into get_resv_regions. This should make the initial
>> domain logic here quite concise.
>=20
> Here attached three extra patches which I think should be added before
> PATCH 3/4, and some further cleanup changes which you can merge with
> PATCH 4/4.
>=20
> ----------------
>=20
> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>=20
> These two patches aim to add a generic method for vendor specific =
iommu
> drivers to specify the type of the default domain for a device. Intel
> iommu driver will register an ops for this since it already has its =
own
> identity map adjudicator for a long time.

This seems like a good idea, but as domain alloc is only called for the=20=

default domain on first device attached to a group, we may miss checking=20=

whether a device added later should have an identity domain. Should =
there=20
be paths to downgrade a groups domain if one of the devices requires =
one?

>=20
> ----------------
>=20
> 0008-iommu-vt-d-Enable-DMA-remapping-after-rmrr-mapped.patch
>=20
> This aims to address the requirement of rmrr identity map before
> enabling DMA remapping. With default domain mechanism, the default
> domain will be allocated and attached to the device in bus_set_iommu()
> during boot. Move enabling DMA remapping engines after bus_set_iommu()
> will fix the rmrr issue.

Thats pretty neat, avoids any temporary domain allocation, nice!

>=20
> ----------------
>=20
> 0009-return-si_domain-directly.patch
>=20
> I suggest that we should keep current si_domain implementation since
> changing si_domain is not the purpose of this patch set. Please merge
> this with PATCH 3/4 if you like it.

Seems reasonable.

>=20
> ----------------
>=20
> 0010-iommu-vt-d-remove-floopy-workaround.patch
> 0011-iommu-vt-d-remove-prepare-rmrr-helpers.patch
> 0012-iommu-vt-d-remove-prepare-identity-map-during-boot.patch
>=20
> Above patches are further cleanups as the result of switching to =
default
> domain. Please consider to merge them with PATCH 4/4.

Nice, good catch.

>=20
> ----------------
>=20
> I have done some sanity checks on my local machine against all =
patches.
> I can do more tests after you submit a v2.
>=20
>=20
> Best regards,
> Lu Baolu
>=20
>=20
> =
<0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch><0007-iom=
mu-vt-d-Add-is_identity_map-ops-entry.patch><0008-iommu-vt-d-Enable-DMA-re=
mapping-after-rmrr-mapped.patch><0009-return-si_domain-directly.patch><001=
0-iommu-vt-d-remove-floopy-workaround.patch><0011-iommu-vt-d-remove-prepar=
e-rmrr-helpers.patch><0012-iommu-vt-d-remove-prepare-identity-map-during-b=
oot.patch>

I have revised my patches and hope to do some testing before reposting.

Cheers,
James.
