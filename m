From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: reduce extra first level entry in
 iommu->domains
Date: Wed, 25 May 2016 11:17:49 +0100
Message-ID: <57457BCD.7080909@arm.com>
References: <1463798511-4015-1-git-send-email-richard.weiyang@gmail.com>
 <20160524230655.GA28550@vultr.guest>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524230655.GA28550@vultr.guest>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yang <richard.weiyang@gmail.com>
Cc: dwmw2@infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 25/05/16 00:06, Wei Yang wrote:
> Hi, Joerg
>
> Not sure whether you think this calculation is correct.
>
> If I missed something for this " + 1" in your formula, I am glad to hear your
> explanation. So that I could learn something from you :-)

I'm not familiar enough with this aspect of the driver to confirm 
whether the change is appropriate or not, but it does seem worth noting 
that using DIV_ROUND_UP would be an even neater approach.

Robin.

> Have a good day~
>
> On Sat, May 21, 2016 at 02:41:51AM +0000, Wei Yang wrote:
>> In commit <8bf478163e69> ("iommu/vt-d: Split up iommu->domains array"), it
>> it splits iommu->domains in two levels. Each first level contains 256
>> entries of second level. In case of the ndomains is exact a multiple of
>> 256, it would have one more extra first level entry for current
>> implementation.
>>
>> This patch refines this calculation to reduce the extra first level entry.
>>
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>> drivers/iommu/intel-iommu.c |    4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index e3061d3..2204ca4 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -1634,7 +1634,7 @@ static int iommu_init_domains(struct intel_iommu *iommu)
>> 		return -ENOMEM;
>> 	}
>>
>> -	size = ((ndomains >> 8) + 1) * sizeof(struct dmar_domain **);
>> +	size = (ALIGN(ndomains, 256) >> 8) * sizeof(struct dmar_domain **);
>> 	iommu->domains = kzalloc(size, GFP_KERNEL);
>>
>> 	if (iommu->domains) {
>> @@ -1699,7 +1699,7 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>> static void free_dmar_iommu(struct intel_iommu *iommu)
>> {
>> 	if ((iommu->domains) && (iommu->domain_ids)) {
>> -		int elems = (cap_ndoms(iommu->cap) >> 8) + 1;
>> +		int elems = ALIGN(cap_ndoms(iommu->cap), 256) >> 8;
>> 		int i;
>>
>> 		for (i = 0; i < elems; i++)
>> --
>> 1.7.9.5
>
