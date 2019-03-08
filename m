From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
Date: Fri, 8 Mar 2019 09:09:09 +0800
Message-ID: <7913a6b9-aa46-8085-0b5e-6fd641f285ac@linux.intel.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ED1B579-C6B9-49E0-BD9A-5751474682D1@arista.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: James Sewart <jamessewart@arista.com>
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/7/19 6:21 PM, James Sewart wrote:
> Hey Lu,
> 
>> On 7 Mar 2019, at 06:31, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> Hi James,
>>
>> On 3/7/19 2:08 AM, James Sewart wrote:
>>>>>>> -	/*
>>>>>>> -	 * For each rmrr
>>>>>>> -	 *   for each dev attached to rmrr
>>>>>>> -	 *   do
>>>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>>>> -	 *     allocate free domain
>>>>>>> -	 *     allocate page table entries for rmrr
>>>>>>> -	 *     if context not allocated for bus
>>>>>>> -	 *           allocate and init context
>>>>>>> -	 *           set present in root table for this bus
>>>>>>> -	 *     init context with domain, translation etc
>>>>>>> -	 *    endfor
>>>>>>> -	 * endfor
>>>>>>> -	 */
>>>>>>> -	pr_info("Setting RMRR:\n");
>>>>>>> -	for_each_rmrr_units(rmrr) {
>>>>>>> -		/* some BIOS lists non-exist devices in DMAR table. */
>>>>>>> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>>>>>> -					  i, dev) {
>>>>>>> -			ret = iommu_prepare_rmrr_dev(rmrr, dev);
>>>>>>> -			if (ret)
>>>>>>> -				pr_err("Mapping reserved region failed\n");
>>>>>>> -		}
>>>>>>> -	}
>>>>>>> -
>>>>>>> -	iommu_prepare_isa();
>>>>>> Why do you want to remove this segment of code?
>>>>> This will only work if the lazy allocation of domains exists, these
>>>>> mappings will disappear once a default domain is attached to a device and
>>>>> then remade by iommu_group_create_direct_mappings. This code is redundant
>>>>> and removing it allows us to remove all the lazy allocation logic.
>>>> No exactly.
>>>>
>>>> We need to setup the rmrr mapping before enabling dma remapping,
>>>> otherwise, there will be a window after dma remapping enabling and
>>>> rmrr getting mapped, during which people might see dma faults.
>>> Do you think this patch instead should be a refactoring to simplify this initial domain setup before the default domain takes over? It seems like duplicated effort to have both lazy allocated domains and externally managed domains. We could allocate a domain here for any devices with RMRR and call get_resv_regions to avoid duplicating RMRR loop.
>>
>> Agree. We should replace the lazy allocated domains with default domain
>> in a clean way. Actually, your patches look great to me. But I do think
>> we need further cleanups. The rmrr code is one example, and the identity
>> domain (si_domain) is another.
>>
>> Do you mind if I work on top of your patches for further cleanups and
>> sign off a v2 together with you?
> 
> Sure, sounds good. I’ll fixup patch 3 and have a go at integrating
> iommu_prepare_isa into get_resv_regions. This should make the initial
> domain logic here quite concise.

Very appreciated! Thank you!

Best regards,
Lu Baolu
