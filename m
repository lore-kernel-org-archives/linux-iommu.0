Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADDEDD
	for <iommu@lists.linux.dev>; Thu,  1 Sep 2022 10:46:07 +0000 (UTC)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJHkQ4j58z67Q1Y;
	Thu,  1 Sep 2022 18:45:18 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Thu, 1 Sep 2022 12:45:59 +0200
Received: from [10.48.151.166] (10.48.151.166) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 11:45:59 +0100
Message-ID: <1351998d-4fd7-dffb-c1fa-a0b1ca759123@huawei.com>
Date: Thu, 1 Sep 2022 11:45:58 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To: Peng Zhang <zhangpeng.00@bytedance.com>, Ethan Zhao
	<haifeng.zhao@linux.intel.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
 <06c215c6-cbae-d6b9-312c-6535e51a3128@linux.intel.com>
 <486fcde8-e9f5-e40c-db5d-fd3ade59b267@bytedance.com>
 <a2479500-479a-22ef-3bd2-90606a26a35e@linux.intel.com>
 <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
In-Reply-To: <4527c925-076b-a477-4ff8-697d75f16761@bytedance.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.151.166]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 26/08/2022 11:28, Peng Zhang wrote:
> 
>> Though only 3-4 drivers use alloc_iova() directly, in my understanding
>>
>> your test has simulated the worst case, rcache doesn't work at all,
>>
>> "alloc_iova" +“remove_iova” number looks great for worst case.
> 
> There is another case, when the size to allocate greater to 2^5, even if 
> alloc_iova_fast() is used, alloc_iova() will always be called because 
> the maximum iova size that rcache supports to allocate is 32.
> IOVA_RANGE_CACHE_MAX_SIZE specifies the maximum size.
> 


If you really have a performance issue with alloc_iova_fast() -> 
alloc_iova() then I suggest that you consider trying to use 
dma_opt_mapping_size() to teach the DMA engine driver to not create 
requests whose overall size exceeds to the rcache limit.

Thanks,
John

