Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE47536F
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 01:36:48 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N28cV1FgPzHvXq;
	Wed,  2 Nov 2022 09:36:26 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:36:44 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 09:36:44 +0800
Subject: Re: [PATCH 1/2] iommu: fix memory leak of iopf
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <20221021035147.15292-1-liulongfang@huawei.com>
 <20221021035147.15292-2-liulongfang@huawei.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <d4f9a31e-41cb-16a0-b071-976dacacc07c@huawei.com>
Date: Wed, 2 Nov 2022 09:36:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221021035147.15292-2-liulongfang@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

kindly ping!
On 2022/10/21 11:51, Longfang Liu wrote:
> In arm_smmu_init_queues(), if ARM_SMMU_FEAT_SVA and ARM_SMMU_FEAT_STALLS
> are enabled, iopf will be allocated a queue memory, and after
> arm_smmu_init_one_queue() processing fails, this part of iopf
> memory is not released, and there is a memory leak problem.
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index b788a38d8fdf..a1db07bed6a9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2939,9 +2939,13 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
>  
> -	return arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
> +	ret = arm_smmu_init_one_queue(smmu, &smmu->priq.q, smmu->page1,
>  				       ARM_SMMU_PRIQ_PROD, ARM_SMMU_PRIQ_CONS,
>  				       PRIQ_ENT_DWORDS, "priq");
> +	if (ret)
> +		iopf_queue_free(smmu->evtq.iopf);
> +
> +	return ret;
>  }
>  
>  static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> 
