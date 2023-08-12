Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40862110B
	for <iommu@lists.linux.dev>; Sat, 12 Aug 2023 02:21:54 +0000 (UTC)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RN4B10YCTzTmCx;
	Sat, 12 Aug 2023 10:19:53 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 12 Aug 2023 10:21:51 +0800
Message-ID: <6ab1684e-fc81-9840-7973-87966e4284e8@huawei.com>
Date: Sat, 12 Aug 2023 10:21:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [RESEND PATCH 1/2] iommu/iova: Add check for cpu_rcache in
 free_iova_rcaches
To: Robin Murphy <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <robh@kernel.org>, <nicolinc@nvidia.com>,
	<john.g.garry@oracle.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
 <20230811130246.42719-2-zhangzekun11@huawei.com>
 <9582503d-6d48-e5e8-6eb0-a170eb0c1150@arm.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <9582503d-6d48-e5e8-6eb0-a170eb0c1150@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected

在 2023/8/11 21:32, Robin Murphy 写道:
> On 2023-08-11 14:02, Zhang Zekun wrote:
>> free_iova_rcaches() needs to check if cpu_rcache->loaded and
>> cpu_rcache->prev is NULL before freeing them.
>
> Why? iova_magazine_free() is just kfree(), and kfree(NULL) is 
> perfectly valid, specifically to avoid having to make cleanup paths 
> all fiddly and overcomplicated like this.
>
> Thanks,
> Robin.
>
Hi, Robin
Thanks for your review, I have missed that kfree() can handle NULL and 
it is safe
to iterate through all cpus, because __alloc_percpu() will alloc a 
zero-filled area,
and pointers passed to kfree() will be either NULL or a vaild one. There 
is no need
to add check before these pointers.

Thanks,
Zekun
