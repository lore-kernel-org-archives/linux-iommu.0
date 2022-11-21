Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392297E6
	for <iommu@lists.linux.dev>; Mon, 21 Nov 2022 02:09:37 +0000 (UTC)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NFrN62zVfzFqS2;
	Mon, 21 Nov 2022 10:06:14 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:09:27 +0800
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 10:09:27 +0800
Subject: Re: [PATCH 2/2] iommu: fix smmu initialization memory leak problem
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>
References: <20221021035147.15292-1-liulongfang@huawei.com>
 <20221021035147.15292-3-liulongfang@huawei.com>
 <20221114180821.GC31476@willie-the-truck>
 <26e8c338-7e4b-b35e-c68a-78a7cbdf2d45@huawei.com>
 <75fa75cf-a4ab-d7d8-e3ab-adb402600f7e@arm.com>
From: liulongfang <liulongfang@huawei.com>
Message-ID: <83f46995-1142-109b-bad2-4e55f05b7d79@huawei.com>
Date: Mon, 21 Nov 2022 10:09:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <75fa75cf-a4ab-d7d8-e3ab-adb402600f7e@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected

On 2022/11/18 19:54, Robin Murphy wrote:
> On 2022-11-18 09:28, liulongfang wrote:
>> On 2022/11/15 2:08, Will Deacon Wrote:
>>> On Fri, Oct 21, 2022 at 11:51:47AM +0800, Longfang Liu wrote:
>>>> When iommu_device_register() in arm_smmu_device_probe() fails,
>>>> in addition to sysfs needs to be deleted, device should also
>>>> be disabled, and the memory of iopf needs to be released to
>>>> prevent memory leak of iopf.
>>>>
>>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
>>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> index a1db07bed6a9..c70defb0c866 100644
>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>> @@ -3816,11 +3816,16 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>       ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>>>>       if (ret) {
>>>>           dev_err(dev, "Failed to register iommu\n");
>>>> -        iommu_device_sysfs_remove(&smmu->iommu);
>>>> -        return ret;
>>>> +        goto err_sysfs_remove;
>>>>       }
>>>>         return 0;
>>>> +
>>>> +err_sysfs_remove:
>>>> +    iommu_device_sysfs_remove(&smmu->iommu);
>>>> +    arm_smmu_device_disable(smmu);
>>>> +    iopf_queue_free(smmu->evtq.iopf);
>>>> +    return ret;
>>>
>>> Doesn't this miss the cases where iommu_device_sysfs_add() or
>>> arm_smmu_device_reset() fail?
>>>
>>> We'd probably be better off using something like devres_alloc() to track
>>> the iopf queue here.
>>>
>> This is actually not a problem found by the test, but a problem found
>> by the code logic analysis. When an error exits, the memory allocated
>> by the iopf queue is not released during the entire exit process.
> 
> Sure, but the point is that there are at least 5 points of failure after iopf_queue_alloc() succeeds, 

OK! Let me change this patch and modify the abnormal exit part related to iopf_queue_alloc() in probe()

Thanks,
Longfang.

which could result in an early exit from probe. This patch only affects the last one of those, so the theoretical problem it claims to fix still exists just as much as before.
> 
> Robin.
> 
> .
> 
