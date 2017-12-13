From: "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Fix shift overflow in qi_flush_dev_iotlb
Date: Wed, 13 Dec 2017 11:31:02 -0600
Message-ID: <b8d7c8fd-8370-a0f0-e5db-f211423d7b9b@amd.com>
References: <20171212224250.22173.74201.stgit@gimli.home>
	<20171213071355.GD7780@xz-mi> <20171213085847.3d3245c6@t450s.home>
	<ae778a81-a500-d8d2-5c7e-10630fe42734@amd.com>
	<20171213101518.7807ae4b@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171213101518.7807ae4b-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tursulin-9sj9WOxYP5jR7s880joybQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/13/2017 11:15 AM, Alex Williamson wrote:
> On Wed, 13 Dec 2017 10:41:47 -0600
> "Hook, Gary" <ghook-5C7GfCeVMHo@public.gmane.org> wrote:
> 
>> On 12/13/2017 9:58 AM, Alex Williamson wrote:
>>> On Wed, 13 Dec 2017 15:13:55 +0800
>>> Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>    
>>>> On Tue, Dec 12, 2017 at 03:43:08PM -0700, Alex Williamson wrote:
>>>>
>>>> [...]
>>>>   
>>>>> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
>>>>> index 9a7ffd13c7f0..87888b102057 100644
>>>>> --- a/drivers/iommu/dmar.c
>>>>> +++ b/drivers/iommu/dmar.c
>>>>> @@ -1345,7 +1345,9 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 qdep,
>>>>>    	struct qi_desc desc;
>>>>>    
>>>>>    	if (mask) {
>>>>> -		BUG_ON(addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1));
>>>>> +		BUG_ON((mask > MAX_AGAW_PFN_WIDTH) ||
>>>>> +		       ((mask == MAX_AGAW_PFN_WIDTH) && addr) ||
>>>>> +		       (addr & ((1 << (VTD_PAGE_SHIFT + mask)) - 1)));
>>>>
>>>> Could it work if we just use 1ULL instead of 1 here?  Thanks,
>>>
>>> In either case we're talking about shifting off the end of the
>>> variable, which I understand to be undefined.  Right?  Thanks,
>>
>> How so? Bits fall off the left (MSB) end, zeroes fill in the right (LSB)
>> end. I believe that behavior is pretty set.
> 
> Maybe I'm relying too much on stackoverflow, but:
> 
> https://stackoverflow.com/questions/11270492/what-does-the-c-standard-say-about-bitshifting-more-bits-than-the-width-of-type

No, probably not. I don't have my copy of c99 handy, so can't check it. 
But it is beyond me why any compiler implementation would choose to use 
a rotate instead of a shift... probably a performance issue.

So, yeah, when you have silly parameters, you get what you get.

I'll stick to my suggestion. Which seems unambiguous... but I could be 
wrong.
