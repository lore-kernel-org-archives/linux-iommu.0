Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BD20F8
	for <iommu@lists.linux.dev>; Thu, 13 Oct 2022 07:26:40 +0000 (UTC)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mp0tC2wMyz6H74g;
	Thu, 13 Oct 2022 15:06:11 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 09:07:46 +0200
Received: from [10.126.172.19] (10.126.172.19) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 08:07:45 +0100
Message-ID: <4ffc662d-5c73-5047-81d5-ad78ca3a7d7e@huawei.com>
Date: Thu, 13 Oct 2022 08:07:46 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH AUTOSEL 5.15 10/47] iommu/arm-smmu-v3: Make default domain
 type of HiSilicon PTT device to identity
To: Sasha Levin <sashal@kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: Yicong Yang <yangyicong@hisilicon.com>, Will Deacon <will@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <baolu.lu@linux.intel.com>, <jgg@ziepe.ca>,
	<tglx@linutronix.de>, <shameerali.kolothum.thodi@huawei.com>,
	<christophe.jaillet@wanadoo.fr>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>
References: <20221013002124.1894077-1-sashal@kernel.org>
 <20221013002124.1894077-10-sashal@kernel.org>
From: John Garry <john.garry@huawei.com>
In-Reply-To: <20221013002124.1894077-10-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.172.19]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected

On 13/10/2022 01:20, Sasha Levin wrote:
> From: Yicong Yang<yangyicong@hisilicon.com>
> 
> [ Upstream commit 24b6c7798a0122012ca848ea0d25e973334266b0 ]
> 
> The DMA operations of HiSilicon PTT device can only work properly with
> identical mappings. So add a quirk for the device to force the domain
> as passthrough.
> 
> Acked-by: Will Deacon<will@kernel.org>
> Signed-off-by: Yicong Yang<yangyicong@hisilicon.com>
> Reviewed-by: John Garry<john.garry@huawei.com>
> Link:https://lore.kernel.org/r/20220816114414.4092-2-yangyicong@huawei.com
> Signed-off-by: Mathieu Poirier<mathieu.poirier@linaro.org>
> Signed-off-by: Sasha Levin<sashal@kernel.org>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

I don't think that this commit should be backported to any stable tree. 
It's only required for a new driver.

Thanks,
John
