Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E337A
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 09:28:55 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D74EB1474;
	Fri, 15 Jul 2022 02:28:54 -0700 (PDT)
Received: from [10.57.86.139] (unknown [10.57.86.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A3A13F792;
	Fri, 15 Jul 2022 02:28:53 -0700 (PDT)
Message-ID: <5d056fea-ee52-b7f8-a8c1-095f695ac805@arm.com>
Date: Fri, 15 Jul 2022 10:28:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] iommu/dma: Fix missing mutex_init() in
 iommu_get_msi_cookie()
Content-Language: en-GB
To: Joerg Roedel <joro@8bytes.org>, Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 iommu@lists.linux-foundation.org, will@kernel.org, yf.wang@mediatek.com
References: <20220627085533.1469141-1-yangyingliang@huawei.com>
 <YtEcB6717b3d5suQ@8bytes.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YtEcB6717b3d5suQ@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-15 08:49, Joerg Roedel wrote:
> Adding Robin.
> 
> On Mon, Jun 27, 2022 at 04:55:33PM +0800, Yang Yingliang wrote:
>> cookie_alloc() is called by iommu_get_dma_cookie() and iommu_get_msi_cookie(),
>> but the mutex is only initialized in iommu_get_dma_cookie(), move mutex_init()
>> into cookie_alloc() to make sure the mutex will be initialized.

The mutex is only used in iommu_dma_init_domain(), which is only called 
by iommu_setup_dma_ops() for IOMMU_DOMAIN_DMA domains. How is there a 
problem here?

Robin.

>> Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain initialization")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 1910f4f1612b..e29157380c48 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -294,6 +294,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>>   	if (cookie) {
>>   		INIT_LIST_HEAD(&cookie->msi_page_list);
>>   		cookie->type = type;
>> +		mutex_init(&cookie->mutex);
>>   	}
>>   	return cookie;
>>   }
>> @@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>>   	if (!domain->iova_cookie)
>>   		return -ENOMEM;
>>   
>> -	mutex_init(&domain->iova_cookie->mutex);
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.25.1
