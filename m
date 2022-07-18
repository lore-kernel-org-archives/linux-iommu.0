Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CCFA42
	for <iommu@lists.linux.dev>; Mon, 18 Jul 2022 07:01:05 +0000 (UTC)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LmXS417GGzFq85;
	Mon, 18 Jul 2022 14:41:40 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 14:42:40 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Jul 2022 14:42:40 +0800
Subject: Re: [PATCH -next] iommu/dma: Fix missing mutex_init() in
 iommu_get_msi_cookie()
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<iommu@lists.linux-foundation.org>, <will@kernel.org>, <yf.wang@mediatek.com>
References: <20220627085533.1469141-1-yangyingliang@huawei.com>
 <YtEcB6717b3d5suQ@8bytes.org> <5d056fea-ee52-b7f8-a8c1-095f695ac805@arm.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <a3fd3fef-f5fc-d89c-99de-4e7870cc9974@huawei.com>
Date: Mon, 18 Jul 2022 14:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5d056fea-ee52-b7f8-a8c1-095f695ac805@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Hi,

On 2022/7/15 17:28, Robin Murphy wrote:
> On 2022-07-15 08:49, Joerg Roedel wrote:
>> Adding Robin.
>>
>> On Mon, Jun 27, 2022 at 04:55:33PM +0800, Yang Yingliang wrote:
>>> cookie_alloc() is called by iommu_get_dma_cookie() and 
>>> iommu_get_msi_cookie(),
>>> but the mutex is only initialized in iommu_get_dma_cookie(), move 
>>> mutex_init()
>>> into cookie_alloc() to make sure the mutex will be initialized.
>
> The mutex is only used in iommu_dma_init_domain(), which is only 
> called by iommu_setup_dma_ops() for IOMMU_DOMAIN_DMA domains. How is 
> there a problem here?
It's no problem now, but I thinks it's better to initialize the 'mutex' 
in cookie_alloc() to make code stronger.

Thanks,
Yang
>
> Robin.
>
>>> Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during 
>>> iova_domain initialization")
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   drivers/iommu/dma-iommu.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>> index 1910f4f1612b..e29157380c48 100644
>>> --- a/drivers/iommu/dma-iommu.c
>>> +++ b/drivers/iommu/dma-iommu.c
>>> @@ -294,6 +294,7 @@ static struct iommu_dma_cookie 
>>> *cookie_alloc(enum iommu_dma_cookie_type type)
>>>       if (cookie) {
>>>           INIT_LIST_HEAD(&cookie->msi_page_list);
>>>           cookie->type = type;
>>> +        mutex_init(&cookie->mutex);
>>>       }
>>>       return cookie;
>>>   }
>>> @@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain 
>>> *domain)
>>>       if (!domain->iova_cookie)
>>>           return -ENOMEM;
>>>   -    mutex_init(&domain->iova_cookie->mutex);
>>>       return 0;
>>>   }
>>>   --
>>> 2.25.1
> .
