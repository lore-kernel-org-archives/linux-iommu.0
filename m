Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22FD3D88
	for <iommu@lists.linux.dev>; Tue,  6 Sep 2022 11:59:34 +0000 (UTC)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMP6x3T8nz6897Z;
	Tue,  6 Sep 2022 19:58:49 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 13:59:31 +0200
Received: from [10.126.175.248] (10.126.175.248) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Sep 2022 12:59:31 +0100
Message-ID: <1fd99fb4-bec1-9695-89f3-499477c88bb7@huawei.com>
Date: Tue, 6 Sep 2022 12:59:31 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] iova: Some misc changes
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
 <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
 <318d9157-6f2b-4ae5-70fc-a54d5919496e@arm.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <318d9157-6f2b-4ae5-70fc-a54d5919496e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.248]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 05/09/2022 16:51, Robin Murphy wrote:
>>
>> Any thoughts on this? Since I got no review of patch #3 I assume that 
>> it is not keenly welcome either.
> 
> Yeah, I applied patch #3 to have a look at the result, but couldn't 
> really convince myself either way - there are certainly a few functions 
> in weirdly incongruous places at the moment, but afterwards we end up 
> with certain other things in rather contrived order for the sake of 
> avoiding declarations, so overall it just didn't feel objectively better 
> to me. Plus the fact that rewriting nearly 2/3 of the file stands to 
> make backporting tweaks or fixes unnecessarily painful is hard to 
> overlook. 

Yeah, that was my main concern. But if it is going to be done, then now 
is as good a time as ever...

> Hence I guess I'm leaning towards "worth trying to see how it 
> looked, but let's not".
> 

ok, fine. But I do still feel that iova.c does need tidying to some 
extent along these lines.

> As for the stubs, it seems that they're currently unused due to linkage 
> issues with IOMMU_IOVA=m - if we want better compile-test coverage, I 
> wonder if we couldn't replace the IS_ENABLED() with IS_REACHABLE() and 
> restore some of the previously-conditional selects?

Sorry, but I am not familiar - what were some examples of 
previously-conditional selects?

Thanks,
John
