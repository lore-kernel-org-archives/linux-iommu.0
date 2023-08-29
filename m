Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F2366
	for <iommu@lists.linux.dev>; Tue, 29 Aug 2023 01:20:24 +0000 (UTC)
Received: from kwepemi500019.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RZTzj1Z5gzLpCP;
	Tue, 29 Aug 2023 09:17:05 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 kwepemi500019.china.huawei.com (7.221.188.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 29 Aug 2023 09:20:15 +0800
Message-ID: <38f79e2d-45a6-2377-9ad0-ee32461bd9d7@huawei.com>
Date: Tue, 29 Aug 2023 09:20:14 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH v2 0/2] iommu/iova: Make the rcache depot properly
 flexible
To: Robin Murphy <robin.murphy@arm.com>
CC: <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <john.g.garry@oracle.com>,
	<dheerajkumar.srivastava@amd.com>, <jsnitsel@redhat.com>, <joro@8bytes.org>
References: <cover.1692641204.git.robin.murphy@arm.com>
From: "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <cover.1692641204.git.robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500019.china.huawei.com (7.221.188.117)
X-CFilter-Loop: Reflected



在 2023/8/22 2:22, Robin Murphy 写道:
> v1: https://lore.kernel.org/linux-iommu/cover.1692033783.git.robin.murphy@arm.com/
>
> Hi all,
>
> Here's a quick update, cleaning up the silly bugs from v1 and taking
> John's suggestion to improve the comments.
>
> Cheers,
> Robin.
>
>
> Robin Murphy (2):
>    iommu/iova: Make the rcache depot scale better
>    iommu/iova: Manage the depot list size
>
>   drivers/iommu/iova.c | 94 ++++++++++++++++++++++++++++++--------------
>   1 file changed, 64 insertions(+), 30 deletions(-)
>

Sorry for the delay, I got some trouble with our performance test 
environment. I had made some performance test for this patches, and the 
result looks good.

Thanks,
Zekun
