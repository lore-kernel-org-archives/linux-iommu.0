Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4557B3D77
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 10:24:14 +0000 (UTC)
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.206])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M73yk1QRBz67Pn6;
	Wed, 17 Aug 2022 18:23:58 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 17 Aug 2022 12:24:11 +0200
Received: from [10.48.158.152] (10.48.158.152) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 11:24:11 +0100
Message-ID: <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
Date: Wed, 17 Aug 2022 11:24:12 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 0/3] iova: Some misc changes
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
In-Reply-To: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.158.152]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 17/08/2022 11:09, John Garry wrote:
> This series includes:
> - remove checks in the code which are not required
> - the re-org, which I had originally posted separately

BTW, Can we drop the !IOMMU_IOVA stubs in iova.h? I could not find a 
kernel config which actually exercises that code (so testing changes 
there is difficult).

> 
> Based on v6.0-rc1
> 
> John Garry (3):
>    iova: Remove some magazine pointer NULL checks
>    iova: Remove magazine BUG_ON() checks
>    iova: Re-order code to remove forward declarations
> 
>   drivers/iommu/iova.c | 1074 +++++++++++++++++++++---------------------
>   include/linux/iova.h |   60 +--
>   2 files changed, 559 insertions(+), 575 deletions(-)
> 

