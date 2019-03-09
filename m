From: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
Date: Sat, 9 Mar 2019 11:49:46 +0000
Message-ID: <A7A831AB-A7A0-407F-A7E3-B84E354E9986@arista.com>
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
 <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
 <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hey Lu,

> On 9 Mar 2019, at 01:53, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>=20
> Hi James,
>=20
> On 3/9/19 12:57 AM, James Sewart wrote:
>> Hey Lu,
>>> On 8 Mar 2019, at 03:09, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>>>=20
>>>>> Do you mind if I work on top of your patches for further cleanups =
and
>>>>> sign off a v2 together with you?
>>>> Sure, sounds good. I=E2=80=99ll fixup patch 3 and have a go at =
integrating
>>>> iommu_prepare_isa into get_resv_regions. This should make the =
initial
>>>> domain logic here quite concise.
>>> Here attached three extra patches which I think should be added =
before
>>> PATCH 3/4, and some further cleanup changes which you can merge with
>>> PATCH 4/4.
>>>=20
>>> ----------------
>>>=20
>>> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
>>> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>>>=20
>>> These two patches aim to add a generic method for vendor specific =
iommu
>>> drivers to specify the type of the default domain for a device. =
Intel
>>> iommu driver will register an ops for this since it already has its =
own
>>> identity map adjudicator for a long time.
>> This seems like a good idea, but as domain alloc is only called for =
the
>> default domain on first device attached to a group, we may miss =
checking
>> whether a device added later should have an identity domain. Should =
there
>> be paths to downgrade a groups domain if one of the devices requires =
one?
>=20
> Good catch!
>=20
> This is supposed to be handled in iommu_no_mapping(). But, obviously
> current code sticks to lazy domain allocation. I'm not sure whether
> there are any real such cases, but we should handle it in a clean way.
> My idea is that we could downgrade to multiple domains per group (just
> like what we have now) in this case and print a kernel message for =
this.

I think if a device requires an identity domain, then it should ignore=20=

attempts to attach to something else. A print to warn a user about this=20=

would be a good idea.

I figure during attach: if iommu_no_mapping() then attach to si_domain =
and=20
print, else continue with the given domain.

>=20
> Or any other thoughts?
>=20
> Best regards,
> Lu Baolu

Cheers,
James.=
