Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804517D6
	for <iommu@lists.linux.dev>; Thu, 15 Sep 2022 06:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBFMWgsltZcb+WwRsbEf4/IeXcTz3je+HVWxcxwgt3phJMox7CboCqBENDtICSwzHoS/yLQlnnVPK1Pv/uQgUpxn22xu89dvEatUST2uUNKda19jVqdhgduNo3/QiIXT+UCnpOBt0LYAOGaJv1R6I8DiGS1efB6Qqq6UXHUEadnqq5KQtjQ9Nwydy1qxkxY8GQJKuIYwZk9b7lfHur3LoVyUyjP7fTI5VwB6NX8XqPVcNUSHoBh86da4eEjux79lp3sLOMiGX5PIrlAnYJtA0ZrJ2mSY2xK/S6NEwvH6k5Bpa9GmkAKVwyOcFeM7Tgs4mQ3IC015fp1EWLTtBPKCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnovmUcKOMyJiil+r/LKMn5peQddH9SZVwkxVwUwuBM=;
 b=alXK2XCbjmUo7bysOz/FTf/RORQcYnqQUEBG11sdlwI1sqZtE5soyBbVCibvIqbgq5odkF2JZ5x3u6sJhAMCx7tppiBY99s0Hd97Awk8K/IXJXYlkUqsbodqqucn9oXS8RsDhrlAkDWI4MF+UXxHklPs8s6mR9P89CMYjLoi+gHuPcAzalmn2c8aeymlRpdrwzzkNlLy1J1U3LR77v1Gj8jXeEJhuPlFrnM7CzeKWbY/Hhh8pG+e86liDOYZt4pUO96Mq18Z0qq202/tgGX62K9k9pcwaiMcYsjbqA8FM9DaJO+S+3ote70dneYQq7YY4RfL7oOg9Nsw3PKM0mtQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnovmUcKOMyJiil+r/LKMn5peQddH9SZVwkxVwUwuBM=;
 b=4vm+bOFsLNsVJY7AMzdRJ8ueSe8x6wB9aXOA0JrPMGhUz2rY3SzjDflbWxjd5321M6Ch6ldVgh+JcCfmbXltN1EdSrkGWDV38fDqeeGk7yLtgFpgledzr24WSNAhj2rif8Sna20/f/s5Gok8IBhdFVvXFZkFJGURN3gSCaamWNg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 06:13:23 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::fead:76e:aef5:b431]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::fead:76e:aef5:b431%7]) with mapi id 15.20.5612.016; Thu, 15 Sep 2022
 06:13:23 +0000
Message-ID: <9c10ed06-9326-4fb5-7af1-973d6094465a@amd.com>
Date: Thu, 15 Sep 2022 11:43:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] iommu: Handle domain allocation failure gracefully
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20220914144424.7356-1-vasant.hegde@amd.com>
 <1a5195b4-eef2-00dd-1b16-806d662148ea@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <1a5195b4-eef2-00dd-1b16-806d662148ea@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::11) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 520f7fd4-f792-488d-c1c3-08da96e16507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4VII0zgnv23DgkXQ3gNc+F/A+Hv4VhWvLqKqTsh9y4V3qwImMa/er2r4jX7mfT0QtGf+Qol04pirShMP+oIj0W8KwBaGIEQ9F3LHhixljbAE6dIjZ3jB6hZ8k85UKyBmiY91Fr3bzwDPNxCTkk9OapJbSK4pcIBr4q3lok+LVZ7ph+4gQ4ZYqEAWc4y7SOAwqb3kr5GWdaCoYH9rcm72lJciL2eTwxKq/bmSH3STCpwbfbLLRcTO0MemnHidOUmiV9i1wfLf7AfoaxtxetOQpCqIFHrjmbJImyNc07s58jf8IaLlhE3xrXyY7QABG50G4vRTVXNLQyhhK2gAQhhtHgZ7MW8yVkIAONFVHlYk1HyBgmM0OCmvBznrnEqMsekkROqEhKWJMNEClC/8bukbD2eO1akucIa27SS7u5BfNGIWtO57cwqR/sZfD8cWd4Ga8173FL5mz+I2y9Z4bxVHU24HKOMgLQ+5NzCO1QFwMbEaIp56WZNlnKpxjCfB4gfK0M8hAObL+OYIsWxHHcjSDGGu0WthXtINMwrfuK5b7lqdpcNPt8BdeLgyw+lm5ZrDTUAoCUm/sP05v9IqnEM8ertk4ssjgYN4B0uiqSYzyQsTcZ1ED0K6yiweZfKfRUiYgHCgqthwDhwbGp59wClgkEzNJpfAyupxFPWzpKXC0shq8RwyY+4FngSNOoCbxHsUteOb/wjRRLyT6JR0RSrpcslaCrzOru5XV8oYdRGio2zBSZCYl/58iexvGHTbenF/wYVWwfOfoporjUcLXBpoitcDBegjuaVGK/S2FGSGwWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(316002)(38100700002)(8676002)(5660300002)(36756003)(44832011)(31696002)(86362001)(4326008)(66556008)(66476007)(66946007)(8936002)(2906002)(41300700001)(2616005)(478600001)(186003)(6506007)(53546011)(26005)(6512007)(6486002)(6666004)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1lFcFFoZXRnaXVLWFZaMm9SaGhEa29JeVYzZGlLSERTZ1VoYnF4RENQYkla?=
 =?utf-8?B?d291MXZQckNFdGhQU1RzZzFEc3F0VFpzL0tUUURVWjRSeXpMMzZ1aW5uUTc0?=
 =?utf-8?B?RmN5ajhPTisxaUxpRnNVU2hpU0JqRXpGRjh2S1F1NVMwc04yZUZNbmUxSEdR?=
 =?utf-8?B?L2FPa3F6QnpkQnFPbHNWNHFDUi94ckF0VVlzMVluMUZsZ01PN0tHVkhaZis4?=
 =?utf-8?B?T244V3hCa3FQTXFqQUhlWnZBYjNscldsSW51NmFCVkpFVHRBTUVLRVBYTm1N?=
 =?utf-8?B?SStwdmR6Z2IzSSs2c2pFUFY1T0I2WS80UUdjdWp0aUwzdGxuVVRwcjFsN3Ft?=
 =?utf-8?B?azk5SkZ4UWpOTnZna3IzWm8ySlFqWUtWQ3pHK3A1YWl4bjVXSzNYR1VHV21t?=
 =?utf-8?B?QWpXZHJVZEdZNGJmZkhVakJuM1BEV1BmR1VRdkhDQUpyMUhFckR1OTNLZ1Nl?=
 =?utf-8?B?Q0YvTXNndXkzSjlxNGFwNEFoa1hwNTgzQVdTT2pOSk1pZXpJcWM2QlYrcmNw?=
 =?utf-8?B?alVrcFQ4TTY1RDdBWmhDcVZ2OXpqVnpTbEhIUFIwVkE4NlpGNDk0YnhTVktp?=
 =?utf-8?B?b2psdmoyTmJYamlFbTRzdk13dGs1OXlVMHdrdHJTeVlBZ1paa2gwYnNiUFk5?=
 =?utf-8?B?dHl6cEVaZ0R5NitXUmFVZ1ptMlAzbHpZcUR4OWNqUjZDMitjd1NjeEQvOXJ6?=
 =?utf-8?B?QXp3Y2lRNnpqTktGbXZSUjFTOURqbFdOZTZKNUkvYzRiUnZWNXpPOFB3Nm96?=
 =?utf-8?B?RzA5OFFkaFFFb0cvcTZMZmk4T2dkV0tReExxY3RTSEczMHR3M1NVbUhmcGdB?=
 =?utf-8?B?bDVCKzNHanlGamNEMFRUbno4T3Q0SFZ2cXRGN3NIWWhKSUE2NWpEVTZRcWFy?=
 =?utf-8?B?cVJacjM2QmszUk1NWkhNRURVYTBtWTAycUFFaHhIdE11NGNpb0lndnJ6NnJz?=
 =?utf-8?B?SFAySTdFMmEzVlBBekRZd3BTdTRFbk9xaW1peXo5d0FMQ2h4cUp4S1ZkU0U1?=
 =?utf-8?B?NGJ0UjRwZUJZZm1zbU0wNGVZemVLMHQ5N3k4SWJnMFVwZlEyTTdudFJOTUVo?=
 =?utf-8?B?a0tRN1V3RFliQk9qTEV5V2RNRGtYdTQrdzc3K21lWjRPeFk1Z2lzSGFlMGg2?=
 =?utf-8?B?Zis5TWVRZDlFMDRVOHVpTDFlSElEVkc4Vk9ET2VXZXV6Szc2QzBSeG1tVlhG?=
 =?utf-8?B?cjcwQUFZdEdFdXJvcCtEVVpQVWl5NjNkWFRuQTFRYTdPYVd0cDl1Q1htSDlQ?=
 =?utf-8?B?QmFvUDB3R0VDUlYvWFZtV3dwMS9Qc1F1VGozQ2d2YmdMdUdnbzZIbnNDZzZV?=
 =?utf-8?B?eDNueThoc3YyT2JCY3lnSFZZc0ZheEgwRkJVT2RuTWxFYzU5dzA1eHVLZXFs?=
 =?utf-8?B?bFd5OFFkNXgxZGwyTFhMTVFydTNpSnA3Q0xUQ1dzRDlQbEtEY2JGM0tmNkpR?=
 =?utf-8?B?SThBcEZPd1JRK0l6M0pycUlTUC9oaHpXUkpFOWh1OFZYbzZEL3h4Y1IwbHYr?=
 =?utf-8?B?ZDMyN21uVDJ4ODN6dDdsZkw5ZWtEQUc1cnBVSDYxaVpSemNEMDRkdzZCNmxF?=
 =?utf-8?B?djdDbjhJTVNvMGFvanJJSEJQWVVwdjdLc3hYanI4cUdWSldZYWFiMmxQUnF0?=
 =?utf-8?B?Y0RVMUhneSs2V0t3RVhYU2lKS3pIZzY2V2xySlc2SFloTHFnS0oxYWl5M1kr?=
 =?utf-8?B?MFBOZ1pyTkpsL05UMjg3Vi9aaGE2WlY5cjRVbnRvYTJsalY0RWRBWGxiVEx1?=
 =?utf-8?B?dDRnNDNCTmNPb2t5bEl2QkdxaEpYc2ZGcS9iamQ4T29WMmU4RWREQVFCb2hX?=
 =?utf-8?B?aS95eHVyQWZXQWZPY2p6RDhNYkhSTlNnZEluOGZLMTk4ejdGc1JBc0dRb21r?=
 =?utf-8?B?ZzJUSGtuaThlYzhVa0JJNFNJZjdnYzRkVlFWblFrU2pncTh0dTduWERndlZq?=
 =?utf-8?B?MjlPWjRQSTlKZFg1cWx6angveDBaOGVIeHRPRXZSK0JocTUvZ244VXFGNlVV?=
 =?utf-8?B?ZXZqcWFjZXI0R3d4ekx5NTNudEU5RlN0YXVPcGY3a0pGTU85ZFVaeGtKRGJ6?=
 =?utf-8?B?Q1kvbG53a3hvUTJZQnkyem02dlhqYTRsL0VuSkRrUUZhd0pFQXh5S2Vja3lX?=
 =?utf-8?Q?CRNGNyyWoNAmFnYWAKE2pwVpj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520f7fd4-f792-488d-c1c3-08da96e16507
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 06:13:23.6285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1txNB2fif0Qrs+/OJUcNVODTjMon7c8U8+sfqIArZENI3h7fcWZ6MK12opQXJ/wglomTRsneTz5d/vOtV+U6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

Baolu,


On 9/15/2022 8:44 AM, Baolu Lu wrote:
> On 9/14/22 10:44 PM, Vasant Hegde wrote:
>> Current code does not validate domain allocation failures. This will
>> result in random failure at later stage. Hence handle domain allocation
>> failures.
>>
>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>> ---
>> Hi Joerg,
>>    With current code whenever amd driver failes to allocate domain we hit
>>    failure at late stage and it became difficult to debug. Hence I
>>    thought of adding this fix.
>>
>>    I see that in commit 6e1aa2049154 you have intentionally didn't check
>>    the return value. Looking into drivers/iommu/* it looks like all
>>    drivers has domain_alloc() callback handler. But some drivers (like msm
>>    - msm_iommu_domain_alloc()) allocates default domain for certain type
>>    only. Hence I'm not sure whether its ok to handle domain allocation
>>    failures or not. Hence I have marked this patch as RFC.
>>
>>    Let me know whether this patch is fine -OR- is there any other way we can
>>    handle domain allocation failures?
>>
>> -Vasant
>>
>>   drivers/iommu/iommu.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 780fb7071577..e8a1e7fbffb9 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -289,18 +289,21 @@ int iommu_probe_device(struct device *dev)
>>         /*
>>        * Try to allocate a default domain - needs support from the
>> -     * IOMMU driver. There are still some drivers which don't
>> -     * support default domains, so the return value is not yet
>> -     * checked.
>> +     * IOMMU driver.
>>        */
>>       mutex_lock(&group->mutex);
>> -    iommu_alloc_default_domain(group, dev);
>> +    ret = iommu_alloc_default_domain(group, dev);
>> +    if (ret) {
>> +        mutex_unlock(&group->mutex);
>> +        iommu_group_put(group);
>> +        goto err_release;
>> +    }
> 
> Some IOMMU drivers (s390, gart, tegra...) don't support default domains.
> iommu_alloc_default_domain() returns a ENOMEM and the probe process
> continues.

Thanks for the clarification.

> 
> Above changes this behavior. The probe process will always fails with
> those IOMMU drivers.

Right. I am wondering whether we have any other way to check the return value?



-Vasant
