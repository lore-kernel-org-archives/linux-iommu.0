Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5D4A24
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 13:37:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C88F3139F;
	Tue,  6 Sep 2022 06:37:30 -0700 (PDT)
Received: from [10.57.15.197] (unknown [10.57.15.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 437753F7B4;
	Tue,  6 Sep 2022 06:37:23 -0700 (PDT)
Message-ID: <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
Date: Tue, 6 Sep 2022 14:37:18 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>,
 Ethan Zhao <haifeng.zhao@linux.intel.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-09-06 11:50, John Garry wrote:
> On 06/09/2022 10:28, Ethan Zhao wrote:
> 
> Hi Ethan,
> 
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/iommu/iova.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>>> index 47d1983dfa2a..580fdf669922 100644
>>> --- a/drivers/iommu/iova.c
>>> +++ b/drivers/iommu/iova.c
>>> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine 
>>> *mag, struct iova_domain *iovad)
>>>       unsigned long flags;
>>>       int i;
>>> -    if (!mag)
>>> -        return;
>>> -
>>
>> iommu_probe_device
>>    ops->probe_finalize(dev);
>>      intel_iommu_probe_finalize
>>         iommu_setup_dma_ops
>>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>>             iova_domain_init_rcaches
>>               {
>>               ...
>>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>>                  ret = -ENOMEM;
>>                        goto out_err;
>>
>> Do you mean iova_magazine_alloc() is impossible to fail ?
> 
> No, iova_magazine_alloc() may fail and return NULL. But if it does then 
> we set iovad rcache pointer = NULL in the error path and don't use the 
> rcache.
> 
> However we have a !iovad->rcache check on the "fast" alloc but not 
> "insert". I need to check why that is again.

Right, if you find a good reason to respin the patch then perhaps also 
tweaking the commit message to clarify that it's impossible to have a 
NULL rcache *at any point where those checks are made* might avoid all 
possible doubt, however I'd hope that it's clear enough that the 
transient case while iova_domain_init_rcaches() is in the process of 
failing really doesn't need consideration in its own right.

I guess the check in iova_rcache_get() was maybe with the intent of 
allowing alloc_iova_fast() to seamlessly fall back to standard 
allocation, so an API user can treat iova_domain_init_rcaches() failure 
as non-fatal? That makes a fair amount of sense, but does mean that 
we're missing the equivalent in iova_rcache_insert() for it to actually 
work. Or we just remove it and tighten up the documentation to say 
that's not valid - I would like a way to make rcaches optional in 
iommu-dma for systems where they're a pointless waste of memory, but we 
can always revisit this when we get there.

Cheers,
Robin.
