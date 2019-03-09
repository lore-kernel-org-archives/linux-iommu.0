From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
Date: Sat, 9 Mar 2019 09:53:32 +0800
Message-ID: <de8f306a-f7f9-f1f4-a8f6-97897b4c78e7@linux.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <A5E61244-386C-4FD8-AAF8-3135F471B92E@arista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Sewart <jamessewart@arista.com>
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi James,

On 3/9/19 12:57 AM, James Sewart wrote:
> Hey Lu,
> 
>> On 8 Mar 2019, at 03:09, Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>>
>>>> Do you mind if I work on top of your patches for further cleanups and
>>>> sign off a v2 together with you?
>>> Sure, sounds good. I’ll fixup patch 3 and have a go at integrating
>>> iommu_prepare_isa into get_resv_regions. This should make the initial
>>> domain logic here quite concise.
>> Here attached three extra patches which I think should be added before
>> PATCH 3/4, and some further cleanup changes which you can merge with
>> PATCH 4/4.
>>
>> ----------------
>>
>> 0006-iommu-Add-ops-entry-for-vendor-specific-default-doma.patch
>> 0007-iommu-vt-d-Add-is_identity_map-ops-entry.patch
>>
>> These two patches aim to add a generic method for vendor specific iommu
>> drivers to specify the type of the default domain for a device. Intel
>> iommu driver will register an ops for this since it already has its own
>> identity map adjudicator for a long time.
> This seems like a good idea, but as domain alloc is only called for the
> default domain on first device attached to a group, we may miss checking
> whether a device added later should have an identity domain. Should there
> be paths to downgrade a groups domain if one of the devices requires one?
> 

Good catch!

This is supposed to be handled in iommu_no_mapping(). But, obviously
current code sticks to lazy domain allocation. I'm not sure whether
there are any real such cases, but we should handle it in a clean way.
My idea is that we could downgrade to multiple domains per group (just
like what we have now) in this case and print a kernel message for this.

Or any other thoughts?

Best regards,
Lu Baolu
