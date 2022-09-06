Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702AB3D88
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 10:50:36 +0000 (UTC)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMMWP5jc8z688r1;
	Tue,  6 Sep 2022 18:46:25 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:50:27 +0200
Received: from [10.126.175.248] (10.126.175.248) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 11:50:26 +0100
Message-ID: <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
Date: Tue, 6 Sep 2022 11:50:26 +0100
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
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
In-Reply-To: <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.175.248]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 06/09/2022 10:28, Ethan Zhao wrote:

Hi Ethan,

>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>   drivers/iommu/iova.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 47d1983dfa2a..580fdf669922 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -661,9 +661,6 @@ iova_magazine_free_pfns(struct iova_magazine *mag, 
>> struct iova_domain *iovad)
>>       unsigned long flags;
>>       int i;
>> -    if (!mag)
>> -        return;
>> -
> 
> iommu_probe_device
>    ops->probe_finalize(dev);
>      intel_iommu_probe_finalize
>         iommu_setup_dma_ops
>           iommu_dma_init_domain(domain, dma_base, dma_limit, dev)
>             iova_domain_init_rcaches
>               {
>               ...
>               cpu_rcache->loaded = iova_magazine_alloc(GFP_KERNEL);
>               cpu_rcache->prev = iova_magazine_alloc(GFP_KERNEL);
>             if (!cpu_rcache->loaded || !cpu_rcache->prev) {
>                  ret = -ENOMEM;
>                        goto out_err;
> 
> Do you mean iova_magazine_alloc() is impossible to fail ?

No, iova_magazine_alloc() may fail and return NULL. But if it does then 
we set iovad rcache pointer = NULL in the error path and don't use the 
rcache.

However we have a !iovad->rcache check on the "fast" alloc but not 
"insert". I need to check why that is again.

Thanks,
john
