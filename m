From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v2 3/7] iommu/vt-d: Expose ISA direct mapping region via
 iommu_get_resv_regions
Date: Mon, 15 Apr 2019 15:16:59 +0100
Message-ID: <1D51CB31-089A-4D71-A9C1-E54E50A56C46@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
 <F531CABB-FFDA-4E0A-A3D5-095FF338DD5A@arista.com>
 <b6b3dda7-31e3-c1e8-16cb-07feb7d5431d@linux.intel.com>
 <A489539F-4DD4-438A-AD9A-1A2F50404DB9@arista.com>
 <fb1565dc-d991-acf9-e275-c0090f69f47e@linux.intel.com>
 <445F31EA-20F3-481C-B1DF-8B163791FF8C@arista.com>
 <cf43d26b-f1ee-8469-c17a-e5c412dcfeab@linux.intel.com>
 <6C211BF1-B5A0-4821-AB42-092B573DE667@arista.com>
 <8B1FC0C7-9BAC-498D-B1F0-0138EACF75C2@arista.com>
 <ddcaa472-7bff-ddd3-0518-f2ba694b3279@linux.intel.com>
 <9AECB54A-2DA7-4ABD-A9B5-0549E108D1AF@arista.com>
 <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abbfecda-8990-315c-ac7a-7f571e86aba2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 10 Apr 2019, at 06:22, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 4/6/19 2:02 AM, James Sewart wrote:
>> Hey Lu,
>> My bad, did some debugging on my end. The issue was swapping out
>> find_domain for iommu_get_domain_for_dev. It seems in some situations =
the
>> domain is not attached to the group but the device is expected to =
have the
>> domain still stored in its archdata.
>> I=E2=80=99ve attached the final patch with find_domain unremoved =
which seems to
>> work in my testing.
>=20
> Just looked into your v3 patch set and some thoughts from my end =
posted
> here just for your information.
>=20
> Let me post the problems we want to address.
>=20
> 1. When allocating a new group for a device, how should we determine =
the
> type of the default domain?
>=20
> 2. If we need to put a device into an existing group which uses a
> different type of domain from what the device desires to use, we might
> break the functionality of the device.
>=20
> My new thought is letting the iommu generic code to determine the
> default domain type (hence my proposed vendor specific default domain
> type patches could be dropped).
>=20
> If the default domain type is dynamical mapping, and later in =
iommu_no_mapping(), we determines that we must use an identity domain,
> we then call iommu_request_dm_for_dev(dev).
>=20
> If the default domain type is identity mapping, and later in
> iommu_no_mapping(), we determined that we must use a dynamical domain,
> we then call iommu_request_dma_domain_for_dev(dev).
>=20
> We already have iommu_request_dm_for_dev() in iommu.c. We only need to
> implement iommu_request_dma_domain_for_dev().
>=20
> With this done, your patch titled "Create an IOMMU group for devices
> that require an identity map" could also be dropped.
>=20
> Any thoughts?

Theres a couple issues I can think of. iommu_request_dm_for_dev changes=20=

the domain for all devices within the devices group, if we may have=20
devices with different domain requirements in the same group then only =
the=20
last initialised device will get the domain it wants. If we want to add=20=

iommu_request_dma_domain_for_dev then we would still need another IOMMU=20=

group for identity domain devices.

Both with v3 and the proposed method here, iommu_should_identity_map is=20=

determining whether the device requires an identity map. In v3 this is=20=

called once up front by the generic code to determine for the IOMMU =
group=20
which domain type to use. In the proposed method I think this would =
happen=20
after initial domain allocation and would trigger the domain to be=20
replaced with a different domain.

I prefer the solution in v3. What do you think?

>=20
>> Cheers,
>> James.
>=20
> Best regards,
> Lu Baolu

Cheers,
James.
