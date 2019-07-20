Return-Path: <SRS0=zP7B=VR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F3C7618F
	for <iommu@archiver.kernel.org>; Sat, 20 Jul 2019 01:16:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0C520880
	for <iommu@archiver.kernel.org>; Sat, 20 Jul 2019 01:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0C520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EA21C29B6;
	Sat, 20 Jul 2019 01:16:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AC856294A
	for <iommu@lists.linux-foundation.org>;
	Sat, 20 Jul 2019 01:16:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F3ABFF8
	for <iommu@lists.linux-foundation.org>;
	Sat, 20 Jul 2019 01:16:28 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jul 2019 18:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,284,1559545200"; d="scan'208";a="179791993"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136])
	([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 19 Jul 2019 18:16:25 -0700
Subject: Re: [PATCH v2 7/7] iommu/vt-d: Consolidate domain_init() to avoid
	duplication
To: Alex Williamson <alex.williamson@redhat.com>
References: <20190612002851.17103-1-baolu.lu@linux.intel.com>
	<20190612002851.17103-8-baolu.lu@linux.intel.com>
	<20190718171615.2ed56280@x1.home>
	<f56599a6-77ac-e1ef-4843-51167b1284b3@linux.intel.com>
	<20190719091952.58255c47@x1.home>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <13294960-c040-c501-c279-aa61d780d25e@linux.intel.com>
Date: Sat, 20 Jul 2019 09:15:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190719091952.58255c47@x1.home>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Alex,

On 7/19/19 11:19 PM, Alex Williamson wrote:
> On Fri, 19 Jul 2019 16:27:04 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi Alex,
>>
>> On 7/19/19 7:16 AM, Alex Williamson wrote:
>>> On Wed, 12 Jun 2019 08:28:51 +0800
>>> Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>    
>>>> The domain_init() and md_domain_init() do almost the same job.
>>>> Consolidate them to avoid duplication.
>>>>
>>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>>> ---
>>>>    drivers/iommu/intel-iommu.c | 123 +++++++++++-------------------------
>>>>    1 file changed, 36 insertions(+), 87 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>>>> index 5215dcd535a1..b8c6cf1d5f90 100644
>>>> --- a/drivers/iommu/intel-iommu.c
>>>> +++ b/drivers/iommu/intel-iommu.c
>>>> @@ -1825,63 +1825,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
>>>>    	return agaw;
>>>>    }
>>>>    
>>>> -static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
>>>> -		       int guest_width)
>>>> -{
>>>> -	int adjust_width, agaw;
>>>> -	unsigned long sagaw;
>>>> -	int err;
>>>> -
>>>> -	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
>>>> -
>>>> -	err = init_iova_flush_queue(&domain->iovad,
>>>> -				    iommu_flush_iova, iova_entry_free);
>>>> -	if (err)
>>>> -		return err;
>>>> -
>>>> -	domain_reserve_special_ranges(domain);
>>>> -
>>>> -	/* calculate AGAW */
>>>> -	if (guest_width > cap_mgaw(iommu->cap))
>>>> -		guest_width = cap_mgaw(iommu->cap);
>>>> -	domain->gaw = guest_width;
>>>> -	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>> -	agaw = width_to_agaw(adjust_width);
>>>> -	sagaw = cap_sagaw(iommu->cap);
>>>> -	if (!test_bit(agaw, &sagaw)) {
>>>> -		/* hardware doesn't support it, choose a bigger one */
>>>> -		pr_debug("Hardware doesn't support agaw %d\n", agaw);
>>>> -		agaw = find_next_bit(&sagaw, 5, agaw);
>>>> -		if (agaw >= 5)
>>>> -			return -ENODEV;
>>>> -	}
>>>> -	domain->agaw = agaw;
>>>> -
>>>> -	if (ecap_coherent(iommu->ecap))
>>>> -		domain->iommu_coherency = 1;
>>>> -	else
>>>> -		domain->iommu_coherency = 0;
>>>> -
>>>> -	if (ecap_sc_support(iommu->ecap))
>>>> -		domain->iommu_snooping = 1;
>>>> -	else
>>>> -		domain->iommu_snooping = 0;
>>>> -
>>>> -	if (intel_iommu_superpage)
>>>> -		domain->iommu_superpage = fls(cap_super_page_val(iommu->cap));
>>>> -	else
>>>> -		domain->iommu_superpage = 0;
>>>> -
>>>> -	domain->nid = iommu->node;
>>>> -
>>>> -	/* always allocate the top pgd */
>>>> -	domain->pgd = (struct dma_pte *)alloc_pgtable_page(domain->nid);
>>>> -	if (!domain->pgd)
>>>> -		return -ENOMEM;
>>>> -	__iommu_flush_cache(iommu, domain->pgd, PAGE_SIZE);
>>>> -	return 0;
>>>> -}
>>>> -
>>>>    static void domain_exit(struct dmar_domain *domain)
>>>>    {
>>>>    	struct page *freelist;
>>>> @@ -2563,6 +2506,31 @@ static int get_last_alias(struct pci_dev *pdev, u16 alias, void *opaque)
>>>>    	return 0;
>>>>    }
>>>>    
>>>> +static int domain_init(struct dmar_domain *domain, int guest_width)
>>>> +{
>>>> +	int adjust_width;
>>>> +
>>>> +	init_iova_domain(&domain->iovad, VTD_PAGE_SIZE, IOVA_START_PFN);
>>>> +	domain_reserve_special_ranges(domain);
>>>> +
>>>> +	/* calculate AGAW */
>>>> +	domain->gaw = guest_width;
>>>> +	adjust_width = guestwidth_to_adjustwidth(guest_width);
>>>> +	domain->agaw = width_to_agaw(adjust_width);
>>>
>>>
>>> How do we justify that domain->agaw is nothing like it was previously
>>> here?  I spent some more time working on the failure to boot that I
>>> thought was caused by 4ec066c7b147, but there are so many breakages and
>>> fixes in Joerg's x86/vt-d branch that I think my bisect zero'd in on
>>> the wrong one.  Instead I cherry-picked every commit from Joerg's tree
>>> and matched Fixes patches to their original commit, which led me to
>>> this patch, mainline commit 123b2ffc376e.  The issue I'm seeing is that
>>> we call domain_context_mapping_one() and we are in this section:
>>>
>>>           struct dma_pte *pgd = domain->pgd;
>>>           int agaw;
>>>
>>>           context_set_domain_id(context, did);
>>>
>>>           if (translation != CONTEXT_TT_PASS_THROUGH) {
>>>                   /*
>>>                    * Skip top levels of page tables for iommu which has
>>>                    * less agaw than default. Unnecessary for PT mode.
>>>                    */
>>>                   for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>>>                           ret = -ENOMEM;
>>>                           pgd = phys_to_virt(dma_pte_addr(pgd));
>>>                           if (!dma_pte_present(pgd))
>>>                                   goto out_unlock;
>>>                   }
>>>
>>> Prior to this commit, we had domain->agaw=1 and iommu->agaw=1, so we
>>> don't enter the loop.  With this commit, we have domain->agaw=3,
>>> iommu->agaw=1 with pgd->val=0!
>>>    
>>
>> iommu->agaw presents the level of page table which is by default
>> supported by the @iommu. domain->agaw presents the level of page
>> table which is used by the @domain.
>>
>> agaw = 1: 3-level page table
>> agaw = 2: 4-level page table
>> agaw = 3: 5-level page table
>>
>> The case here is that @iommu only supports 3-level page table, but the
>> @domain was set to use 5-level page table. So we must skip level 4 and 5
>> page tables of the @domain.
>>
>> This code in the loop looks odd to me. It will always goto to unlock and
>> leave pgd->val==0. How about below change? (not tested yet!)
>>
>> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
>> index 412f18aba501..98d6878cd29d 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2020,11 +2020,15 @@ static int domain_context_mapping_one(struct
>> dmar_domain *domain,
>>                            * Skip top levels of page tables for iommu
>> which has
>>                            * less agaw than default. Unnecessary for PT mode.
>>                            */
>> -                       for (agaw = domain->agaw; agaw > iommu->agaw;
>> agaw--) {
>> -                               ret = -ENOMEM;
>> -                               pgd = phys_to_virt(dma_pte_addr(pgd));
>> -                               if (!dma_pte_present(pgd))
>> -                                       goto out_unlock;
>> +                       while (iommu->agaw < domain->agaw) {
>> +                               struct dma_pte *pte;
>> +
>> +                               pte = domain->pgd;
>> +                               if (dma_pte_present(pte)) {
>> +                                       domain->pgd =
>> phys_to_virt(dma_pte_addr(pte));
>> +                                       free_pgtable_page(pte);
>> +                               }
>> +                               domain->agaw--;
>>                           }
>>
>>                           info = iommu_support_dev_iotlb(domain, iommu,
>> bus, devfn);
> 
> 
> The system still fails to boot, now with DMAR faults indicating invalid
> context entry.

Ah! It demands more investigation. Thank you for testing this.

>   
>>> I don't really follow how the setting of these fields above is
>>> equivalent to what they were previously or if they're supposed to be
>>> updated lazily, but the current behavior is non-functional.  Commit
>>> 123b2ffc376e can be reverted with only a bit of offset, which brings
>>> Linus' tree back into working operation for me.  Should we revert or is
>>> there an obvious fix here?  Thanks,
>>
>> This commit is not the root cause of this issue as far as I can see, it
>> only triggers above loop to get entered.
> 
> The system fails to boot with this commit, it does boot without this
> commit.  Whether this commit exposed a latent issue or introduced a bug
> itself is academic.  Thanks,

Okay. I agree wit you. Let's revert this commit first.

Best regards,
Baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
