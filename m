Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A831C03
	for <iommu@lists.linux.dev>; Tue, 22 Nov 2022 12:00:49 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGjVs0PPPzHvsd;
	Tue, 22 Nov 2022 20:00:05 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:00:40 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 20:00:40 +0800
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>
References: <20221121030421.19295-1-liulongfang@huawei.com>
 <20221121180552.GB7645@willie-the-truck>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
Date: Tue, 22 Nov 2022 20:00:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20221121180552.GB7645@willie-the-truck>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

On 2022/11/22 2:05, Will Deacon wrote:
> On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
>> When iommu_device_register() in arm_smmu_device_probe() fails,
>> in addition to sysfs needs to be deleted, device should also
>> be disabled, and the memory of iopf needs to be released to
>> prevent memory leak of iopf.
>>
>> Changes v1 -> v2:
>> 	-Improve arm_smmu_device_probe() abnormal exit function.
>>
>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>> ---
>>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index ab160198edd6..b892f5233f88 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -3815,7 +3815,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>  	/* Initialise in-memory data structures */
>>  	ret = arm_smmu_init_structures(smmu);
>>  	if (ret)
>> -		return ret;
>> +		goto err_iopf;
>>  
>>  	/* Record our private device structure */
>>  	platform_set_drvdata(pdev, smmu);
>> @@ -3826,22 +3826,28 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>  	/* Reset the device */
>>  	ret = arm_smmu_device_reset(smmu, bypass);
>>  	if (ret)
>> -		return ret;
>> +		goto err_iopf;
>>  
>>  	/* And we're up. Go go go! */
>>  	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>>  				     "smmu3.%pa", &ioaddr);
>>  	if (ret)
>> -		return ret;
>> +		goto err_reset;
>>  
>>  	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>>  	if (ret) {
>>  		dev_err(dev, "Failed to register iommu\n");
>> -		iommu_device_sysfs_remove(&smmu->iommu);
>> -		return ret;
>> +		goto err_sysfs_add;
>>  	}
>>  
>>  	return 0;
>> +err_sysfs_add:
>> +	iommu_device_sysfs_remove(&smmu->iommu);
>> +err_reset:
>> +	arm_smmu_device_disable(smmu);
>> +err_iopf:
>> +	iopf_queue_free(smmu->evtq.iopf);
>> +	return ret;
> 
> I previously suggested using devres_alloc() for this instead. Did that
> not work?
> 

This patch is only for fixing iopf's memory leak.
The use of devres_alloc() is an optimization solution for iopf queue management,
which is another set of patch matters.

Thanks,
Longfang.
> Will
> .
> 
