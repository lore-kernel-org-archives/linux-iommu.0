From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: reduce extra first level entry in
 iommu->domains
Date: Thu, 26 May 2016 11:11:51 +0100
Message-ID: <5746CBE7.2080206@arm.com>
References: <1463798511-4015-1-git-send-email-richard.weiyang@gmail.com>
 <20160524230655.GA28550@vultr.guest> <57457BCD.7080909@arm.com>
 <20160525214359.GA4132@vultr.guest>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160525214359.GA4132@vultr.guest>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yang <richard.weiyang@gmail.com>
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 25/05/16 22:43, Wei Yang wrote:
> On Wed, May 25, 2016 at 11:17:49AM +0100, Robin Murphy wrote:
>> On 25/05/16 00:06, Wei Yang wrote:
>>> Hi, Joerg
>>>
>>> Not sure whether you think this calculation is correct.
>>>
>>> If I missed something for this " + 1" in your formula, I am glad to hear your
>>> explanation. So that I could learn something from you :-)
>>
>> I'm not familiar enough with this aspect of the driver to confirm whether the
>> change is appropriate or not, but it does seem worth noting that using
>> DIV_ROUND_UP would be an even neater approach.
>>
>
> Hi, Robin,
>
> Thanks for your comment.
>
> Yes, I agree DIV_ROUND_UP would make the code more easy to read.
>
> I have thought about using DIV_ROUND_UP, while from the definition
> DIV_ROUND_UP use operation "/", and ALIGN use bit operation. So the change in
> my patch chooses the second one and tries to keep the efficiency.

The efficiency of what, though?

It's an unsigned division by a constant power of two, which GCC 
implements with a shift instruction regardless of optimisation - and at 
-O1 and above the machine code generated for either form of expression 
is completely identical (try it and see!).

On the other hand, the small amount of time and cognitive effort it took 
to parse "ALIGN(x, 256) >> 8" as "divide by 256, rounding up" compared 
to simply seeing "DIV_ROUND_UP(x, 256)" and knowing instantly what's 
intended, certainly makes it less efficient to _maintain_; thus it's 
exactly the kind of thing to which Dijkstra's famous quotation applies.

Does that count towards learning something? ;)

Robin.

>>> Have a good day~
>>>
>>> On Sat, May 21, 2016 at 02:41:51AM +0000, Wei Yang wrote:
>>>> In commit <8bf478163e69> ("iommu/vt-d: Split up iommu->domains array"), it
>>>> it splits iommu->domains in two levels. Each first level contains 256
>>>> entries of second level. In case of the ndomains is exact a multiple of
>>>> 256, it would have one more extra first level entry for current
>>>> implementation.
>>>>
>>>> This patch refines this calculation to reduce the extra first level entry.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> ---
>>>> drivers/iommu/intel-iommu.c |    4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>> index e3061d3..2204ca4 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -1634,7 +1634,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>>>> 		return -ENOMEM;
>>>> 	}
>>>>
>>>> -	size = ((ndomains >> 8) + 1) * sizeof(struct dmar_domain **);
>>>> +	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
>>>> 	iommu->domains = kzalloc(size, GFP_KERNEL);
>>>>
>>>> 	if (iommu->domains) {
>>>> @@ -1699,7 +1699,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>>>> static void free_dmar_iommu(struct intel_iommu *iommu)
>>>> {
>>>> 	if ((iommu->domains) && (iommu->domain_ids)) {
>>>> -		int elems = (cap_ndoms(iommu->cap) >> 8) + 1;
>>>> +		int elems = ALIGN(cap_ndoms(iommu->cap), 256) >> 8;
>>>> 		int i;
>>>>
>>>> 		for (i = 0; i < elems; i++)
>>>> --
>>>> 1.7.9.5
>>>
>
