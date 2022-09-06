Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772207E
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 17:37:03 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMXXT5FVkz67yfJ;
	Wed,  7 Sep 2022 01:32:57 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 19:36:59 +0200
Received: from [10.126.175.248] (10.126.175.248) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 18:36:58 +0100
Message-ID: <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
Date: Tue, 6 Sep 2022 18:36:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: Robin Murphy <robin.murphy@arm.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
In-Reply-To: <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.175.248]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

>>>
>>> iommu_probe_device
>>>    ops->probe_finalize(dev);
>>>      intel_iommu_probe_finalize
>>>         iommu_setup_dma_ops
>>>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>>>             iova_domain_init_rcaches
>>>               {
>>>               ...
>>>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>>>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>>>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>>>                  ret = -ENOMEM;
>>>                        goto out_err;
>>>
>>> Do you mean iova_magazine_alloc() is impossible to fail ?
>>
>> No, iova_magazine_alloc() may fail and return NULL. But if it does 
>> then we set iovad rcache pointer = NULL in the error path and don't 
>> use the rcache.
>>
>> However we have a !iovad->rcache check on the "fast" alloc but not 
>> "insert". I need to check why that is again.
> 
> Right, if you find a good reason to respin the patch then perhaps also 
> tweaking the commit message to clarify that it's impossible to have a 
> NULL rcache *at any point where those checks are made* might avoid all 
> possible doubt, however I'd hope that it's clear enough that the 
> transient case while iova_domain_init_rcaches() is in the process of 
> failing really doesn't need consideration in its own right.

Yeah, I would think so. But I still don't mind tweaking it to be extra 
clear.

> 
> I guess the check in iova_rcache_get() was maybe with the intent of 
> allowing alloc_iova_fast() to seamlessly fall back to standard 
> allocation, so an API user can treat iova_domain_init_rcaches() failure 
> as non-fatal?

The 2x users treat iova_domain_init_rcaches() as fatal:
- dma-iommu falls back to platform ops in iommu_setup_dma_ops()

Caveat: on the chance that the IOVA domain init fails due to the rcache 
init failing, then, if there were another device in the group which 
probes later, its probe would be ok as the start_pfn is set. Not Good.

- vdpa just fails to create the domain in vduse_domain_create()

> That makes a fair amount of sense, but does mean that 
> we're missing the equivalent in iova_rcache_insert() for it to actually 
> work. Or we just remove it and tighten up the documentation to say 
> that's not valid 

I'd be more inclined to remove it. I would rather remove fathpath checks 
as much as possible and have robust error handling in the domain init.

Afterall I do have the "remove check" craze going.

> - I would like a way to make rcaches optional in 
> iommu-dma for systems where they're a pointless waste of memory, but we 
> can always revisit this when we get there.
> 

thanks,
John
