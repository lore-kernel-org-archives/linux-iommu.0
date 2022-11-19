Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B328F3
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 12:00:21 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NDsdv1lHqzRpGD;
	Sat, 19 Nov 2022 19:59:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 20:00:11 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 20:00:10 +0800
Subject: Re: [PATCH] iommu/vt-d: fix pci device refcount leak in
 prq_event_thread()
To: Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>
References: <20221119103436.1859167-1-yangyingliang@huawei.com>
 <5067335c-381f-3548-081a-c1a278871c85@linux.intel.com>
 <4d3afa6b-b386-fef4-cfea-0eac4d52175f@linux.intel.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <229799e9-f9ff-820a-e911-deb482c0f2e4@huawei.com>
Date: Sat, 19 Nov 2022 20:00:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4d3afa6b-b386-fef4-cfea-0eac4d52175f@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Hi,

On 2022/11/19 19:37, Baolu Lu wrote:
> On 2022/11/19 19:24, Baolu Lu wrote:
>> Hi Yingliang,
>>
>> On 2022/11/19 18:34, Yang Yingliang wrote:
>>> As comment of pci_get_domain_bus_and_slot() says, it returns
>>> a pci device with refcount increment, when finish using it,
>>> the caller must decrement the reference count by calling
>>> pci_dev_put(). So call pci_dev_put() after using the 'pdev'
>>> to avoid refcount leak.
>>>
>>> Fixes: 06f4b8d09dba ("iommu/vt-d: Remove unnecessary SVA data 
>>> accesses in page fault path")
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   drivers/iommu/intel/svm.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>>> index 7d08eb034f2d..47c07556955e 100644
>>> --- a/drivers/iommu/intel/svm.c
>>> +++ b/drivers/iommu/intel/svm.c
>>> @@ -751,6 +751,7 @@ static irqreturn_t prq_event_thread(int irq, 
>>> void *d)
>>>           trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
>>>                    req->priv_data[0], req->priv_data[1],
>>>                    iommu->prq_seq_number++);
>>> +        pci_dev_put(pdev);
>>>   prq_advance:
>>>           head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>>       }
>>
>> Thanks for the fix.Furthermore, if the returned @pdev is empty, we do
>> not need to trace this fault, nor do we need to put the device. Hence,
>> how about below changes?
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 7d08eb034f2d..2991f9cccf5f 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -745,12 +745,17 @@ static irqreturn_t prq_event_thread(int irq, 
>> void *d)
>>                   * If prq is to be handled outside iommu driver via 
>> receiver of
>>                   * the fault notifiers, we skip the page response here.
>>                   */
>> -               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, 
>> req))
>> -                       handle_bad_prq_event(iommu, req, 
>> QI_RESP_INVALID);
>> +               if (!pdev)
>> +                       goto prq_advance;
>
> Here it should be
>                         goto bad_req;
>
> Sorry about it!

May be this looks more clear:

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 7d08eb034f2d..35e44f79b7ac 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -745,12 +745,16 @@ static irqreturn_t prq_event_thread(int irq, void *d)
                  * If prq is to be handled outside iommu driver via 
receiver of
                  * the fault notifiers, we skip the page response here.
                  */
-               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req))
+               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, req)) {
                         handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+                       goto put_dev;
+               }

                 trace_prq_report(iommu, &pdev->dev, req->qw_0, req->qw_1,
                                  req->priv_data[0], req->priv_data[1],
                                  iommu->prq_seq_number++);
+put_dev:
+               pci_dev_put(pdev);
  prq_advance:
                 head = (head + sizeof(*req)) & PRQ_RING_MASK;
         }

Thanks,
Yang
>
>>
>> -               trace_prq_report(iommu, &pdev->dev, req->qw_0, 
>> req->qw_1,
>> -                                req->priv_data[0], req->priv_data[1],
>> -                                iommu->prq_seq_number++);
>> +               if (intel_svm_prq_report(iommu, &pdev->dev, req))
>> +                       handle_bad_prq_event(iommu, req, 
>> QI_RESP_INVALID);
>> +               else
>> +                       trace_prq_report(iommu, &pdev->dev,
>> +                                        req->qw_0, req->qw_1,
>> +                                        req->priv_data[0], 
>> req->priv_data[1],
>> + iommu->prq_seq_number++);
>> +               pci_dev_put(pdev);
>>   prq_advance:
>>                  head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>          }
>
> Best regards,
> baolu
>
> .
