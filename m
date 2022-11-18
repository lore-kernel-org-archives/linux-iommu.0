Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD8829A1
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 11:54:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0F2923A;
	Fri, 18 Nov 2022 03:54:36 -0800 (PST)
Received: from [10.57.70.144] (unknown [10.57.70.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B16E83F587;
	Fri, 18 Nov 2022 03:54:29 -0800 (PST)
Message-ID: <75fa75cf-a4ab-d7d8-e3ab-adb402600f7e@arm.com>
Date: Fri, 18 Nov 2022 11:54:15 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] iommu: fix smmu initialization memory leak problem
To: liulongfang <liulongfang@huawei.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20221021035147.15292-1-liulongfang@huawei.com>
 <20221021035147.15292-3-liulongfang@huawei.com>
 <20221114180821.GC31476@willie-the-truck>
 <26e8c338-7e4b-b35e-c68a-78a7cbdf2d45@huawei.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <26e8c338-7e4b-b35e-c68a-78a7cbdf2d45@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-18 09:28, liulongfang wrote:
> On 2022/11/15 2:08, Will Deacon Wrote:
>> On Fri, Oct 21, 2022 at 11:51:47AM +0800, Longfang Liu wrote:
>>> When iommu_device_register() in arm_smmu_device_probe() fails,
>>> in addition to sysfs needs to be deleted, device should also
>>> be disabled, and the memory of iopf needs to be released to
>>> prevent memory leak of iopf.
>>>
>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index a1db07bed6a9..c70defb0c866 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -3816,11 +3816,16 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>   	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>>>   	if (ret) {
>>>   		dev_err(dev, "Failed to register iommu\n");
>>> -		iommu_device_sysfs_remove(&smmu->iommu);
>>> -		return ret;
>>> +		goto err_sysfs_remove;
>>>   	}
>>>   
>>>   	return 0;
>>> +
>>> +err_sysfs_remove:
>>> +	iommu_device_sysfs_remove(&smmu->iommu);
>>> +	arm_smmu_device_disable(smmu);
>>> +	iopf_queue_free(smmu->evtq.iopf);
>>> +	return ret;
>>
>> Doesn't this miss the cases where iommu_device_sysfs_add() or
>> arm_smmu_device_reset() fail?
>>
>> We'd probably be better off using something like devres_alloc() to track
>> the iopf queue here.
>>
> This is actually not a problem found by the test, but a problem found
> by the code logic analysis. When an error exits, the memory allocated
> by the iopf queue is not released during the entire exit process.

Sure, but the point is that there are at least 5 points of failure after 
iopf_queue_alloc() succeeds, which could result in an early exit from 
probe. This patch only affects the last one of those, so the theoretical 
problem it claims to fix still exists just as much as before.

Robin.
