Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0EB2569
	for <iommu@lists.linux.dev>; Tue, 14 Feb 2023 15:19:44 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EEPX9J023815;
	Tue, 14 Feb 2023 15:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=RNn24WMncYpG1WZiiL9SwUs4Vx6FstrQ3cKXsmoo6DY=;
 b=KK1nAXvj8NxjI8SAnDVkznN5sXU2HJHtocnmt5PB9/0vzjUjl8rs5aJa3tjHo2j5WSyv
 x5ULovwlrwWcZeCpDf5Gipw0D9Gufmsrzz3o65scX3pNAU1QzdO+seCZiY62ByVyyMaw
 CzRL7OYzPTdS0wJM9HQ1qRqk6aePF+2WRmJ0khFAfn588gArSLtymDV2g63WxwAZeyC/
 01VCokCFBDqGwKe+iRRNrlJH5wTItvqSAdI0WUtXnll2yjBb7E/Nq/xi5Z5PP5G2fCmC
 tJxY8W6kv5aQcEEBrPlB2Y8X3CrWXpVIZa8yqaokSTfmk3FogaBqVhkkwYfWZpYvHZr4 xg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nqyygstcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Feb 2023 15:05:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31EF5QKY022496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Feb 2023 15:05:26 GMT
Received: from [10.253.73.60] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 14 Feb
 2023 07:05:25 -0800
Message-ID: <8fe546b5-2cac-7f52-d875-c66c4458996a@quicinc.com>
Date: Tue, 14 Feb 2023 23:05:22 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iommu: Fix potential concurrent free issue
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <quic_tingweiz@quicinc.com>
References: <1676358214-25732-1-git-send-email-quic_zhenhuah@quicinc.com>
 <2f1e67de-645d-2da9-d46c-d37d28ddc03b@arm.com>
 <6e1b0bea-00d9-6aeb-2d0a-a8fd4650e389@quicinc.com>
 <9687190c-eb3b-f72a-d2a7-964ccd640f8c@arm.com>
From: Zhenhua Huang <quic_zhenhuah@quicinc.com>
In-Reply-To: <9687190c-eb3b-f72a-d2a7-964ccd640f8c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 31DvdoUg5TEElDJKKBU1Z4L4iZvuc2U6
X-Proofpoint-GUID: 31DvdoUg5TEElDJKKBU1Z4L4iZvuc2U6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140130

Thanks Robin.

On 2023/2/14 19:20, Robin Murphy wrote:
> On 2023-02-14 10:51, Zhenhua Huang wrote:
>> Thanks Robin.
>>
>> On 2023/2/14 18:25, Robin Murphy wrote:
>>> On 2023-02-14 07:03, Zhenhua Huang wrote:
>>>> Some cases in which probing with a non-iommu bind device,
>>>> we saw dev_iommu_free() called in the same time. Add checking
>>>> to avoid NULL dereference.
>>>>
>>>> One path was with smmu driver probing:
>>>> [    0.538555][  T165]  dev_iommu_free+0xa0/0x198
>>>> [    0.538557][  T165]  __iommu_probe_device+0x244/0x2e4
>>>> [    0.538559][  T165]  probe_iommu_group+0x38/0x54
>>>> [    0.538561][  T165]  bus_iommu_probe+0x70/0x37c
>>>> [    0.538563][  T165]  bus_set_iommu+0xcc/0x1b8
>>>> [    0.538578][  T165]  arm_smmu_bus_init+0x38/0xd0 [arm_smmu]
>>>> [    0.538592][  T165]  arm_smmu_device_probe+0x630/0x6d8 [arm_smmu]
>>>> The other was with device itself probing:
>>>> [    0.529488][    T9]  __iommu_probe_device+0x244/0x354
>>>> [    0.529490][    T9]  iommu_probe_device+0x44/0x460
>>>> [    0.529492][    T9]  iommu_bus_notifier+0x44/0x160
>>>> [    0.529494][    T9]  device_add+0x9f0/0x12a0
>>>> [    0.529497][    T9]  of_platform_device_create_pdata+0xc8/0x168
>>>> [    0.529499][    T9]  of_platform_bus_create+0x1b0/0x254
>>>> [    0.529500][    T9]  of_platform_populate+0x9c/0x114
>>>> [    0.529502][    T9]  devm_of_platform_populate+0xb4/0x118
>>>> [    0.529507][    T9]  pmic_spmi_probe+0x108/0x140 [qcom_spmi_pmic]
>>>> [    0.529511][    T9]  spmi_drv_probe+0x70/0x140
>>>> [    0.529514][    T9]  really_probe+0x3f0/0x8dc
>>>> [    0.529515][    T9]  driver_probe_device+0x1b0/0x230
>>>> ...
>>>
>>> This looks like the same thing that commit 01657bc14a39 ("iommu: 
>>> Avoid races around device probe") was supposed to have fixed. But 
>>> then bus_set_iommu() no longer exists in mainline anyway, so I'm not 
>>> sure what kernel you're using :/
>>>
>>> Thanks,
>>> Robin.
>>>
>>
>> Yes, Robin. The change you provided are with same purpose. I was using 
>> 5.10 kernel.
> 
> Aha, I did note in that commit that it appeared theoretically possible 
> to hit the same race on older kernels, but I hadn't fully realised that 
> even a single bus_set_iommu() call could effectively race with its own 
> notifier, if a new device was added to the bus at just the right time 
> while the initial bus_iommu_probe() walk was still running. Nice find!
> 
> Off the top of my head, I don't *think* there should be any major issue 
> with backporting 01657bc14a39 beyond its nominal fixes tag, if you need it.

Nice for me, will pick the fix. Thanks very much.

> 
> Thanks,
> Robin.
> 
>>>> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
>>>> ---
>>>>   drivers/iommu/iommu.c | 16 +++++++++++-----
>>>>   1 file changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 42891e5..30f8d8f 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -276,12 +276,18 @@ static void dev_iommu_free(struct device *dev)
>>>>   {
>>>>       struct dev_iommu *param = dev->iommu;
>>>> -    dev->iommu = NULL;
>>>> -    if (param->fwspec) {
>>>> -        fwnode_handle_put(param->fwspec->iommu_fwnode);
>>>> -        kfree(param->fwspec);
>>>> +    if (!param)
>>>> +        return;
>>>> +
>>>> +    if (param == cmpxchg(&dev->iommu, param, NULL)) {
>>>> +        if (param->fwspec) {
>>>> +            fwnode_handle_put(param->fwspec->iommu_fwnode);
>>>> +            kfree(param->fwspec);
>>>> +        }
>>>> +        kfree(param);
>>>> +    } else {
>>>> +        return;
>>>>       }
>>>> -    kfree(param);
>>>>   }
>>>>   static u32 dev_iommu_get_max_pasids(struct device *dev)
