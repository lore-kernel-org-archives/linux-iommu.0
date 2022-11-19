Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4B136C
	for <iommu@lists.linux.dev>; Sat, 19 Nov 2022 12:31:17 +0000 (UTC)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NDtFf4sPLzqSWj;
	Sat, 19 Nov 2022 20:27:18 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 20:31:09 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 19 Nov 2022 20:31:09 +0800
Subject: Re: [PATCH] iommu/vt-d: fix pci device refcount leak in
 prq_event_thread()
To: Baolu Lu <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <yangyingliang@huawei.com>
References: <20221119103436.1859167-1-yangyingliang@huawei.com>
 <5067335c-381f-3548-081a-c1a278871c85@linux.intel.com>
 <4d3afa6b-b386-fef4-cfea-0eac4d52175f@linux.intel.com>
 <229799e9-f9ff-820a-e911-deb482c0f2e4@huawei.com>
 <878d3750-2561-6fb6-c722-fc40d6e66e85@linux.intel.com>
From: Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <e451b826-b29b-1d01-8365-852320c3ad04@huawei.com>
Date: Sat, 19 Nov 2022 20:31:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <878d3750-2561-6fb6-c722-fc40d6e66e85@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected


On 2022/11/19 20:06, Baolu Lu wrote:
> On 2022/11/19 20:00, Yang Yingliang wrote:
>> May be this looks more clear:
>>
>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
>> index 7d08eb034f2d..35e44f79b7ac 100644
>> --- a/drivers/iommu/intel/svm.c
>> +++ b/drivers/iommu/intel/svm.c
>> @@ -745,12 +745,16 @@ static irqreturn_t prq_event_thread(int irq, 
>> void *d)
>>                   * If prq is to be handled outside iommu driver via 
>> receiver of
>>                   * the fault notifiers, we skip the page response here.
>>                   */
>> -               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, 
>> req))
>> +               if (!pdev || intel_svm_prq_report(iommu, &pdev->dev, 
>> req)) {
>>                          handle_bad_prq_event(iommu, req, 
>> QI_RESP_INVALID);
>> +                       goto put_dev;
>> +               }
>
>     else
>         trace_prq_report(...)
>
> looks more readable.
Well, as I know, in kernel, it always handle error case like this:
if (err) {
     // error path
     goto/return
}
...
// success path

And prq_event_thread() other error handlings use the 'goto' style too.

Thanks,
Yang
>
>>
>>                  trace_prq_report(iommu, &pdev->dev, req->qw_0, 
>> req->qw_1,
>>                                   req->priv_data[0], req->priv_data[1],
>>                                   iommu->prq_seq_number++);
>> +put_dev:
>> +               pci_dev_put(pdev);
>>   prq_advance:
>>                  head = (head + sizeof(*req)) & PRQ_RING_MASK;
>>          }
>
> Best regards,
> baolu
>
> .
