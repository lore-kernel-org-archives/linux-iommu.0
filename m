From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/vt-d: Remove lazy allocation of domains
Date: Thu, 7 Mar 2019 14:31:09 +0800
Message-ID: <4b3e29ce-1dff-eb7d-9b7e-1cde54a24dec@linux.intel.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
	<2C75F46E-78FE-45E9-9E7D-280B3138EA13@arista.com>
	<F83456DB-81DD-4E9B-9204-12ED9972D2FA@arista.com>
	<7F6B5F6A-EC76-4A9F-8EB6-AEAB9994D91A@arista.com>
	<fdd74d83-acd4-23da-6c0c-b52573d999bb@linux.intel.com>
	<4B054B40-0B13-4F1E-87D6-8D2F072B5B9C@arista.com>
	<06aa306a-278a-a22f-7718-200f6f9e5e87@linux.intel.com>
	<A8A495EE-D3EA-4D84-AB92-9B4742E6E500@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <A8A495EE-D3EA-4D84-AB92-9B4742E6E500-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: James Sewart <jamessewart-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, Tom Murphy <tmurphy-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi James,

On 3/7/19 2:08 AM, James Sewart wrote:
>>>>> -	/*
>>>>> -	 * For each rmrr
>>>>> -	 *   for each dev attached to rmrr
>>>>> -	 *   do
>>>>> -	 *     locate drhd for dev, alloc domain for dev
>>>>> -	 *     allocate free domain
>>>>> -	 *     allocate page table entries for rmrr
>>>>> -	 *     if context not allocated for bus
>>>>> -	 *           allocate and init context
>>>>> -	 *           set present in root table for this bus
>>>>> -	 *     init context with domain, translation etc
>>>>> -	 *    endfor
>>>>> -	 * endfor
>>>>> -	 */
>>>>> -	pr_info("Setting RMRR:\n");
>>>>> -	for_each_rmrr_units(rmrr) {
>>>>> -		/* some BIOS lists non-exist devices in DMAR table. */
>>>>> -		for_each_active_dev_scope(rmrr->devices, rmrr->devices_cnt,
>>>>> -					  i, dev) {
>>>>> -			ret = iommu_prepare_rmrr_dev(rmrr, dev);
>>>>> -			if (ret)
>>>>> -				pr_err("Mapping reserved region failed\n");
>>>>> -		}
>>>>> -	}
>>>>> -
>>>>> -	iommu_prepare_isa();
>>>> Why do you want to remove this segment of code?
>>> This will only work if the lazy allocation of domains exists, these
>>> mappings will disappear once a default domain is attached to a device and
>>> then remade by iommu_group_create_direct_mappings. This code is redundant
>>> and removing it allows us to remove all the lazy allocation logic.
>> No exactly.
>>
>> We need to setup the rmrr mapping before enabling dma remapping,
>> otherwise, there will be a window after dma remapping enabling and
>> rmrr getting mapped, during which people might see dma faults.
> Do you think this patch instead should be a refactoring to simplify this initial domain setup before the default domain takes over? It seems like duplicated effort to have both lazy allocated domains and externally managed domains. We could allocate a domain here for any devices with RMRR and call get_resv_regions to avoid duplicating RMRR loop.
> 

Agree. We should replace the lazy allocated domains with default domain
in a clean way. Actually, your patches look great to me. But I do think
we need further cleanups. The rmrr code is one example, and the identity
domain (si_domain) is another.

Do you mind if I work on top of your patches for further cleanups and
sign off a v2 together with you?

Best regards,
Lu Baolu
