Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653633C1
	for <iommu@lists.linux.dev>; Wed,  7 Sep 2022 09:53:44 +0000 (UTC)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MMyCM6myzz687wc;
	Wed,  7 Sep 2022 17:49:35 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 11:53:39 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 10:53:39 +0100
Message-ID: <d9cf492e-1236-8446-9651-dfe848a5932d@huawei.com>
Date: Wed, 7 Sep 2022 10:53:39 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/2] iova: Remove some magazine pointer NULL checks
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>
References: <1662369083-238529-1-git-send-email-john.garry@huawei.com>
 <1662369083-238529-2-git-send-email-john.garry@huawei.com>
 <1d80f56c-bef7-6e5f-0bca-dad35f5e5a8e@linux.intel.com>
 <3fa23318-6fa7-eba0-30b8-1fb71e6c327e@huawei.com>
 <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <7c4383ac-0b0b-dd43-9958-dbd4abeea63f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 07/09/2022 10:33, Ethan Zhao wrote:

Hi Ethan,

>>> Do you mean iova_magazine_alloc() is impossible to fail ?
>>
>> No, iova_magazine_alloc() may fail and return NULL. But if it does 
>> then we set iovad rcache pointer = NULL in the error path and don't 
>> use the rcache.
> 
> Yup,  if iova_magazine_alloc() failed ,
> 
> iovad->rcaches = NULL;
> 
> was set by free_iova_rcaches()
> 
> in error path of iova_domain_init_rcache().
> 
> and checked in
> 
> alloc_iova_fast()->iova_rcache_get().
> 
> More comment in code would wipe off my curiosity.

As discussed with Robin, we will actually remove that check in 
iova_rcache_get() for now and in future make the IOVA domain init more 
robust.

As for the "loaded" and "prev" NULL checks removal in this specific 
patch, I will add more words in the commit message to make it clearer 
that failure in init was the only way in which they NULL previously.

thanks,
John
