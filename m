Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85225395
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 10:10:54 +0000 (UTC)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMyg42hXcz67vlM;
	Wed,  7 Sep 2022 18:10:08 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Wed, 7 Sep 2022 12:10:51 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:10:51 +0100
Message-ID: <ba82816c-3d43-4256-17d7-bd3d358e942b@huawei.com>
Date: Wed, 7 Sep 2022 11:10:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Robin Murphy
	<robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <555fa5aa-a575-d783-dc97-79f63dcf2f57@arm.com>
 <cc950d77-2a97-ac75-4a1d-19aaf864a3be@huawei.com>
 <ad67a859-dc57-e30f-e422-3f9a0cb5239b@arm.com>
 <ef7622de-c1f3-c6cd-a50e-bbcbf8288b64@huawei.com>
 <a9f959ed-b528-681d-f941-d615360c0be3@linux.intel.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <a9f959ed-b528-681d-f941-d615360c0be3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 07/09/2022 10:58, Ethan Zhao wrote:

Hi Ethan,

>> Or also add this:
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 0d6d8edf782d..e8f0b8f47f45 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -578,6 +578,12 @@ static int iommu_dma_init_domain(struct 
>> iommu_domain *domain, dma_addr_t base,
>>              goto done_unlock;
>>          }
>>
>> +        if (!iovad->rcaches) {
>> +            pr_warn("IOVA domain rcache not properly initialised\n");
>> +            ret = -EFAULT;
>> +            goto done_unlock;
>> +        }
>> +
>>          ret = 0;
>>          goto done_unlock;
>>
> If the iovad->rcaches allocation failed, will skip iommu domain dma ops, 
> so no need *any* iovad,->rcaches check, right ?
> 
> and there is already warning about the fallback.

It's not as simple as that. We use the iovad->start_pfn member as a flag 
for the IOVA domain being initialized. However that does not mean always 
properly initialized. As above, the rcache init may fail, but in this 
case we still set start_pfn.

This comes into play when we have multiple devices in the same IOMMU 
group, for example, as I mentioned yesterday.

Thanks,
John
