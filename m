Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D22F4E
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 09:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662543191; x=1694079191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=k5YPzoTF8zWkG4kDDBbQlRFazp3TFOTCHVAL/rlhWIw=;
  b=i4gZRpFCRX+avRQcRfxwbKokWACTXxBppIEuumdoS/5R4h3ZpWe5D+cg
   yoeyM0/U5+DhjZAC15EkgwUb6AfNkEBuEljOYfg+G9H9hZwaSQVk+8xYi
   InsAB/bhe2KwcitFJRo7aQf/+PfZDsqA7RFnj4RDxBc6JK/qzH0QVWNxb
   69s8TefJTegHxtrGbsOOcBGrm9paSmKt2OGnS9h1zo1RGVL6nR+godlzu
   l3tGjYumk0J9qabQlQjPRnKH1pTW0IegcuqFAV7+mx7rFoD7L0OvMN/yh
   0d5KHk8zUhStholhcT2zS4/elgsKE+3pImSvX1cu1X7S2k4M/6ToVoKXg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="296826025"
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="296826025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="644545512"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.212.12]) ([10.254.212.12])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 02:33:05 -0700
Message-ID: <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
Date: Wed, 7 Sep 2022 17:33:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: John Garry <john.garry@huawei.com>, robin.murphy@arm.com,
 joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

John,

在 2022/9/6 18:50, John Garry 写道:
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
> No, iova_magazine_alloc() may fail and return NULL. But if it does 
> then we set iovad rcache pointer = NULL in the error path and don't 
> use the rcache.

Yup,  if iova_magazine_alloc() failed ,

iovad->rcaches = NULL;

was set by free_iova_rcaches()

in error path of iova_domain_init_rcache().

and checked in

alloc_iova_fast()->iova_rcache_get().

More comment in code would wipe off my curiosity.


Thanks,

Ethan

>
> However we have a !iovad->rcache check on the "fast" alloc but not 
> "insert". I need to check why that is again.
>
> Thanks,
> john

-- 
"firm, enduring, strong, and long-lived"

