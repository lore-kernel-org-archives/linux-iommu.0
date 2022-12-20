Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BCB7E
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 21:38:05 +0000 (UTC)
Received: from [192.168.1.18] ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id 7kJ6pP9chfxUs7kJ6pVCVC; Tue, 20 Dec 2022 22:37:58 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Dec 2022 22:37:58 +0100
X-ME-IP: 86.243.100.34
Message-ID: <b27ea07e-67a2-43ed-3611-9a11495fc032@wanadoo.fr>
Date: Tue, 20 Dec 2022 22:37:51 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] iommu: fix smmu initialization memory leak problem
To: liulongfang <liulongfang@huawei.com>, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
References: <20221121030421.19295-1-liulongfang@huawei.com>
 <20221121180552.GB7645@willie-the-truck>
 <cb6fcc72-bb50-5fb9-f7c3-648538fbd376@huawei.com>
 <20221129152452.GB26561@willie-the-truck>
 <fe32de72-caf4-f6bb-565f-93ea1d3a003b@huawei.com>
 <20221201133118.GA28489@willie-the-truck>
 <4fb97e88-92df-2738-a078-f8269aa76870@huawei.com>
Content-Language: fr, en-US
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <4fb97e88-92df-2738-a078-f8269aa76870@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 20/12/2022 à 04:17, liulongfang a écrit :
> On 2022/12/1 21:31, Will Deacon Wrote:
>> On Thu, Dec 01, 2022 at 08:42:02PM +0800, liulongfang wrote:
>>> On 2022/11/29 23:24, Will Deacon wrote:
>>>> On Tue, Nov 22, 2022 at 08:00:39PM +0800, liulongfang wrote:
>>>>> On 2022/11/22 2:05, Will Deacon wrote:
>>>>>> On Mon, Nov 21, 2022 at 11:04:21AM +0800, Longfang Liu wrote:
>>>>>>> When iommu_device_register() in arm_smmu_device_probe() fails,
>>>>>>> in addition to sysfs needs to be deleted, device should also
>>>>>>> be disabled, and the memory of iopf needs to be released to
>>>>>>> prevent memory leak of iopf.
>>>>>>>
>>>>>>> Changes v1 -> v2:
>>>>>>> 	-Improve arm_smmu_device_probe() abnormal exit function.
>>>>>>>
>>>>>>> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>>>>>>> ---
>>>>>>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++-----
>>>>>>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>>> index ab160198edd6..b892f5233f88 100644
>>>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>>>>>> @@ -3815,7 +3815,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>>>>   	/* Initialise in-memory data structures */
>>>>>>>   	ret = arm_smmu_init_structures(smmu);
>>>>>>>   	if (ret)
>>>>>>> -		return ret;
>>>>>>> +		goto err_iopf;
>>>>>>>   
>>>>>>>   	/* Record our private device structure */
>>>>>>>   	platform_set_drvdata(pdev, smmu);
>>>>>>> @@ -3826,22 +3826,28 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>>>>>>>   	/* Reset the device */
>>>>>>>   	ret = arm_smmu_device_reset(smmu, bypass);
>>>>>>>   	if (ret)
>>>>>>> -		return ret;
>>>>>>> +		goto err_iopf;
>>>>>>>   
>>>>>>>   	/* And we're up. Go go go! */
>>>>>>>   	ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
>>>>>>>   				     "smmu3.%pa", &ioaddr);
>>>>>>>   	if (ret)
>>>>>>> -		return ret;
>>>>>>> +		goto err_reset;
>>>>>>>   
>>>>>>>   	ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
>>>>>>>   	if (ret) {
>>>>>>>   		dev_err(dev, "Failed to register iommu\n");
>>>>>>> -		iommu_device_sysfs_remove(&smmu->iommu);
>>>>>>> -		return ret;
>>>>>>> +		goto err_sysfs_add;
>>>>>>>   	}
>>>>>>>   
>>>>>>>   	return 0;
>>>>>>> +err_sysfs_add:
>>>>>>> +	iommu_device_sysfs_remove(&smmu->iommu);
>>>>>>> +err_reset:
>>>>>>> +	arm_smmu_device_disable(smmu);
>>>>>>> +err_iopf:
>>>>>>> +	iopf_queue_free(smmu->evtq.iopf);
>>>>>>> +	return ret;
>>>>>> I previously suggested using devres_alloc() for this instead. Did that
>>>>>> not work?
>>>>>>
>>>>> This patch is only for fixing iopf's memory leak.
>>>>> The use of devres_alloc() is an optimization solution for iopf queue management,
>>>>> which is another set of patch matters.
>>>> Great, I look forward to that set of patches!
>>>>
>>> Will this patch be merged into the next branch?
>> I don't plan to merge this one, no. I'll wait for the other patches which do
>> this using devres_alloc() instead.
>>
>> Thanks,
>>
>> Will
>> .
>>
> Hi Christophe:
> "[PATCH] iommu/arm-smmu-v3: Fix an error handling path in arm_smmu_device_probe()"
>
> the patch you sent is the same as mine. The maintainer hopes to optimize the queue
> application part of iopf with devres_alloc().

Hi,

more or less.

You also added a arm_smmu_device_disable() call in the error handling path.
Looks good to me, but should be confirmed by s.o who knows the hardware.

That said, I think that what has been suggested by Will Deacon would be 
something like:


diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index ab160198edd6..1994990decb8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2930,6 +2930,11 @@ static int arm_smmu_cmdq_init(struct 
arm_smmu_device *smmu)
      return 0;
  }

+static void arm_smmu_free_queues(void *ptr)
+{
+    iopf_queue_free(ptr);
+}
+
  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
  {
      int ret;
@@ -2957,6 +2962,11 @@ static int arm_smmu_init_queues(struct 
arm_smmu_device *smmu)
          smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
          if (!smmu->evtq.iopf)
              return -ENOMEM;
+
+        ret = devm_add_action_or_reset(smmu->dev, arm_smmu_free_queues,
+                           smmu->evtq.iopf);
+        if (ret)
+            return ret;
      }

      /* priq */
@@ -3832,16 +3842,21 @@ static int arm_smmu_device_probe(struct 
platform_device *pdev)
      ret = iommu_device_sysfs_add(&smmu->iommu, dev, NULL,
                       "smmu3.%pa", &ioaddr);
      if (ret)
-        return ret;
+        goto err_reset;

      ret = iommu_device_register(&smmu->iommu, &arm_smmu_ops, dev);
      if (ret) {
          dev_err(dev, "Failed to register iommu\n");
-        iommu_device_sysfs_remove(&smmu->iommu);
-        return ret;
+        goto err_sysfs_add;
      }

      return 0;
+
+err_sysfs_add:
+    iommu_device_sysfs_remove(&smmu->iommu);
+err_reset:
+    arm_smmu_device_disable(smmu);
+    return ret;
  }

  static int arm_smmu_device_remove(struct platform_device *pdev)
@@ -3851,7 +3866,6 @@ static int arm_smmu_device_remove(struct 
platform_device *pdev)
      iommu_device_unregister(&smmu->iommu);
      iommu_device_sysfs_remove(&smmu->iommu);
      arm_smmu_device_disable(smmu);
-    iopf_queue_free(smmu->evtq.iopf);

      return 0;
  }


I'm not a really big fan because it adds too much code for me. But I'm 
not a maintainer, so let them have the last word on it.
At least, this avoids an odd iopf_queue_free() call that comes from 
nowhere without looking deeper in the code.

It has been compile tested only on arm64.

> I hope you can modify it, and I will quit this repair work.

If it please you and Will, feel free to propose it as a v3 of your patch.

CJ

> Thanks,
> Longfang.
