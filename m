Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6469333C9
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 14:12:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxQVNujfRY6442dD4cwiakmkUGi4dJVZfZWr6YaUHaRPLPSgAC4LZKqKHJPw/49nSi1py7RGtMxoq5LP0RLn0OpgiQScpiSon2QCvPoYkRI6K4wu3tvGGkWeJGDqoqxVquV9kKbBNrrSIX73vfQko8xh2D2YhCN3xcz7stv7Sz+Zo42GLHitNqUyRVCOwG0cXy2mZv+QjZZ61HFVXRgrmpWZ6/nDBIAxMgu03JdVeewtsn7rB0J7qhihbbk5BK88SrrVwzBy3CleZPxBEmD55q5sfe//xbxrDkmop6/zrOUj/LZv/MsBgPPH1/+aMx85L3QT2XHyvaryZ3v4aRU6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85ZoOt2iN+VDjWq9LxueUYf4u8qPplzUDcjOkFoXYXQ=;
 b=IS5dcIuwah+yTIsKUvas7UKcgTi11LNZD7x4NBC4DLFQUlXiwDEnl5q9W3N1zW6lvl6Uefw+IyWbVKpVcYRCckf3wDDVYtG5vz1YVWIruToqWuKXXByyWgU+a3ugm5CXoW+eOkDEUUzAh3ZRbdyyFQlzjTtQ9U5etCewlfFZ5hJGgjDgkAQYPYnZF0bOmp5ViQV0kFkSiZlNvfVvfZkhTNLkBKtvK2kuLu+VtF4wKRqIco2O2gcFndSL8qcibBsz+ZAZs40FQ4LWCtdUkg1vVref6ZHSexyL28Se7lcE8Z+l6zLUCwofwyJu/Ai2SJsufuMD8VZHx/k27tdEKYepmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85ZoOt2iN+VDjWq9LxueUYf4u8qPplzUDcjOkFoXYXQ=;
 b=MzkjsAtBt7xNon7T6KBAjxvWWR5dUjBy//GQ7nZLNz0/cd4CY/q3CV4Aj8H4oI/8OwCqMlZABfkyXfT24Fjun9ILh4dEtDN+oiYJo59jaaZ2Mw+dMkZs5Xi3ZI+8ZmfdQ+9HpMZV6Op/dS+l1dNyRLoWDnjwB9vaSx7XwgQFe4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Tue, 7 Feb
 2023 14:11:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 14:11:59 +0000
Message-ID: <f2151603-de54-7717-60f9-748e9205139e@amd.com>
Date: Tue, 7 Feb 2023 19:41:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, will@kernel.org
References: <20230203173623.18308-1-vasant.hegde@amd.com>
 <b2061df7-d28b-207f-1968-a7dac3171cfe@arm.com>
 <ae54a94b-5927-927d-1fad-1bb49a2a64b9@amd.com>
 <acf8fbd2-907c-01dc-0bff-23d28a869b66@arm.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <acf8fbd2-907c-01dc-0bff-23d28a869b66@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::29) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 956173f1-4b67-49d8-ab8c-08db091546cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5n6lyI+oKsqZTc8THgQZwykz1aTgihn0NmHVVVsP9q3biGYeQBMF7vTpUH8qCR4Ux1UH54QVQpg2jntr5QaO8SvyfOimGW10nntWKegHQTH9PbO3IVHN28Rh0IcJihq0e57p8aRaDGwmDP4ukaN18V4LAWORpX/KFUy7uKQI2WhrgKTmbt+BOPW14Rd8JzrOJ4PP/XGyB246j8cDhcZHEglOP1e8FnuKwXO6zyapi/PGyckNOyOJvPec/qUW7mMKeo2/CWWdfaNPfAS3cQSKIEX2HuZ9ELq0JyuWXwhbMEKv0X32vhqNZvA0r8c2uWcHw6lVjYZE0caa+7hquBJdkbLL2aixNk32LwSSHO5QvpEWcRWF6iv94Q6OgErb34gn376pgMDr8k8yYnb5upgtDxiNv3aK2FlS0xtRuvl4DdCpolDjajqrk5GCHPqWsLDOjF9L/cCZjt7jAWWZkwFinukuqiV6a2Sg6cMlH/a0CLdeXNLc7TdyuPtgzx6c1fg+492jO0tUITDs1CxyCWl/smB1wTjxrz7df+cAQBlTBQI+ypRsbstiYXwJJp/vGxp5VkhfPInTFXulxdWWOGvXJ758BE15KCTeNP4K6pH91FvsgEIvgo0zeUJf1Kd2VbvRFww7pOCIbF1aBrAr/8hUfMvzDn++7w8+i2sS0lLvIJC7WpGnAfS6WDZw80H0fBlRRVuxA0XgqQx6+W932l/H6yDSDG3f5vhQ/S8rYx7gfHQkPyDv2X6g4Vkqa5nQLSfnrwlZPFYyLI0fqNOWr0oCsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199018)(86362001)(31696002)(38100700002)(36756003)(6486002)(2906002)(316002)(966005)(478600001)(66946007)(6506007)(41300700001)(5660300002)(66556008)(83380400001)(8676002)(8936002)(4326008)(6512007)(6666004)(26005)(44832011)(186003)(53546011)(66476007)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MVViWUxyWWFFMTNMNk1jRzZyem5LcllrRmsra1hvWm5NQS92LzdRQUZMSEMz?=
 =?utf-8?B?UGI3QmFUVmJCUm9DQlUwbkpnNVFia2NqWmJ1WkhyMmwyaytGTWtISXo2cmVv?=
 =?utf-8?B?MjR4SkNhOXZXSE4zOUJ0VDJnVWxHYURkekJYdDYyaTBOUldkMFhUMFBUdVFs?=
 =?utf-8?B?d2Q0ZFhENC9aR2JzTTVPNE9SOHAxWWZTMXpXcFVtVUpRRERUdU42eWQwMGdM?=
 =?utf-8?B?eWxHU0MzYU1lSFZsaDJGTTNzZXR1UlhtS0hWbW9KZnJBUTlkd21JcHpucWt6?=
 =?utf-8?B?QWRuK2gvdGo2M3lsVjVPKzhWVEt3c0ZOQXdHbTFFZUVrYVI5aGc5VS96aVdN?=
 =?utf-8?B?bFl6ZHNOTlFmNzRUNUtqWXdWYkJ4dksvdTgzd2RtZGxPM3VjZGxQVlZsanpU?=
 =?utf-8?B?Y1A0dkxyWTBOdDlNSnJpU1ZmVW5QYU81ODdJUXRGWGRrL1YzREFsbkg1YjRu?=
 =?utf-8?B?S2NQUzAwbXd3YmRhb0dNMTd0QTgrRnU2c0x6Z09RWHJXbEk2bk9KdFJUU1FQ?=
 =?utf-8?B?NVZjQVNkeGl2NThTbEllRjdKQ2tHUHljeVhvTm5xU1JyY1R3R3pUcE82U0Zr?=
 =?utf-8?B?MHJGVGZDQlJxNmVjeEt2ODFlVzJUQUdhN3NJT0tlZldaUHdhNnpKQTRQWHg1?=
 =?utf-8?B?VUlhTzAxR3puTVJoNkFnUlZpbVdHRmdLVEVpTEs4VVZkN3c2ZlY4ODV0Ujhq?=
 =?utf-8?B?TVlubTBnWlhtSDRzVW1qZTJxYkU0dkdiVXYvYlN6aWJjbjVGanMzTTNVcVVQ?=
 =?utf-8?B?Ti83WHVMd3RzYTY1ZlpxM2tHV0JjMkdKMGFLeU4wa0ROamZBSjJTVEo3dXNr?=
 =?utf-8?B?dUI5L29tOXhzTWhXYUtMQTd1N1hoUzM4K3lWNWFRd1FqdGFqQ1cwaE53UXRM?=
 =?utf-8?B?SVhUWnVSaTVEaE9rekZIbFJOMEdzOUV6WC9Zb2NrVStzSHFjc3h2OC9kUkUz?=
 =?utf-8?B?ZGRBZFlCMkN3NDJVZ0FibGFYSmx0T3g1czEraHI0YVMvc2ZBdmhmdTVrVm9M?=
 =?utf-8?B?djBXM1RoQWg4b2c2b25DaEtkNTZudStVYXJHcUxyRE05Z0FvSHpWRk5nWWhs?=
 =?utf-8?B?SmZSUm5iQ0FFUjI0OGlMaGVRSmQ4aDZ3ZGUyTkJQaS9pczVuV0I0Qy9yUG13?=
 =?utf-8?B?ZnJoejVrWUJ6VjhhN3lsM2VEQ0pKemtVeXBUMHRycVBVc3lZUTJBWG9rN1lB?=
 =?utf-8?B?SVFPcVBjVUJuYXA3VjF6aFRIQ2dVRHJ6eERPaVFINVlaSjBhTW5na0JFMk9X?=
 =?utf-8?B?djBoazRRV2VKM0JVRUc2cGxZSjI4WVNVcGpST1Ztd0R6eUdLbFc0WkM0UUZF?=
 =?utf-8?B?Nzc1QkJaQlAreUJhekdMa1hQWkpBaVBpM21WOEtNWU9IVExwMEhBMnN1bFRQ?=
 =?utf-8?B?NFhsODZSUjNscjVnY3k1YnpVd3VXSUQrMEM2b0d6SHBSbEtFbHplMGhkQ1Ex?=
 =?utf-8?B?MVlwbWYzZ2l2RWRSdzY1SmNQSFNQSU9NdzBReVQwQkJnbXJGbmtxWVhEUlQy?=
 =?utf-8?B?eHU3cUthWG1oWVZ6aDZqNkp4K3E5eVN2dWZDYkQ2amFMcmFWbCs5L3lqYVc1?=
 =?utf-8?B?eHJsMklQUkFKeEwxWGVrR0kzTmx5S09leEZzTDc5ci9yOHJDenJQU1htR3Ni?=
 =?utf-8?B?dWNsdStYdzl2WGhzd3BoMmpsYXJHOEdYRmd5UXplMW5NSmtnQUd2ZzJLaVI0?=
 =?utf-8?B?Z2s4Z2IrbXZzTU8rRU50ZmYrN2xiV1lwQ1k3TmxkL3NtSkIzTFE2VmxYckkv?=
 =?utf-8?B?UnFvY0lvNzh4L0xLb0s5aEw0YXZYZ3BnRU9rSDRiR1lMaG5YWXFHQlRabU5C?=
 =?utf-8?B?Wno2ZGtMeElMMGl0NWRQR3hPT2FRMzNERlhtZzU4RFY0VEdCYjcycFExYno3?=
 =?utf-8?B?SU0ra0ZBZ0lVVitCMUR4YUZhbi80aVNIWnIzK29wc0o4OGJBR09GdGkzVmNN?=
 =?utf-8?B?WlVadFk4RThPMGV5SmRWUEJETllqZlZHa0lVQjVwdURoSTBvNG96VzNMZFRu?=
 =?utf-8?B?TlUxOXI4cUZaVzVsMWw5SEpMVmU5QXkvVWVWaDljNnZpTldzRlM2L1BLcWYv?=
 =?utf-8?B?QWtjN0drOGlyU29qaWp1VWkxaWdVbkRrM1BIOUpNWkJmL0t4Wjd6bEkzbldv?=
 =?utf-8?Q?VBT5ZIWa47skqFDvrrIdzKzar?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 956173f1-4b67-49d8-ab8c-08db091546cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 14:11:59.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cr8SS/cpEhacbXN7MaQB18zu17PSi9AEGQvXkQ2gav/68++bMkJRU7N1tZwYI6ENje+dd0ojrNMUdC1Bm9kP5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129

Hi Robin,


On 2/7/2023 3:39 PM, Robin Murphy wrote:
> On 2023-02-06 13:55, Vasant Hegde wrote:
>> Hi Robin,
>>
>>
>> On 2/6/2023 6:59 PM, Robin Murphy wrote:
>>> On 2023-02-03 17:36, Vasant Hegde wrote:
>>>> iommu_attach_group() attaches all devices in a group to domain and then
>>>> sets group domain (group->domain). Current code (__iommu_attach_group())
>>>> does not handle error path. This creates problem as devices to domain
>>>> attachment is in inconsistent state.
>>>
>>> Can you clarify the circumstances for this happening? I think the implicit
>>> assumption here is that if first attach_dev succeeds, then the group is
>>> compatible with the domain in general, so then any subsequent attach_dev calls
>>> are mostly just updating data for additional RIDs, and as such would not be
>>> expected to fail.
>>
>> It can happen with even single device in the device group.
>>
>> Flow :
>>    - Try to attach device to new domain (say IOMMU_DOMAIN_UMANAGED)
>>    - In iommu_attach_group() path we detach device from current domain. Then it
>> tries to attach device to new group.
>>    - If it fails then device to domain link is broken.
>>    - iommu_attach_group() returns error.
>>    - At this stage caller assumes attaching device to new domain failed.
>>    - But it should work fine with old domain.
>>      This is what I'm trying to fix it in this patch.
> 
> Oh, I see. However, in that case the assumption in the core code is definitely
> that if the attach failed then the device remains attached to the original
> domain. If the AMD driver is doing something different, shouldn't that just be
> fixed in the driver (i.e. do all the preparation on the new domain *before* the
> detach_device()/do_attach() cycle)?

I tried to fix it in core code instead of AMD driver because:
  - If we have multiple devices in group, then recovering inside hardware driver
(like AMD driver) becomes difficult. Say we have two devices and second device
attachment failed then how do we re-attach first device back to old domain.
  - As I understand its not AMD specific driver issue. I did look into few other
driver (like s390-iommu.c, arm-smmu-v3.c). They also detach devices before
attaching devices to new domain.
  - Finally fixing it in core code makes it easy for all driver. The flow I was
thinking is something like:
  iommu_attach_group() -> __iommu_attach_group()
    -> iommu_domain_ops->attach_dev() : if failed return error
      -> __iommu_attach_group() recovers for the failure for entire group.
        -> device group to domain attachement is consistent and return error
           from iommu_attach_group()


Please let me know if we have better way to fix this issue.

-Vasant




> 
> Thanks,
> Robin.
> 
>>
>>
>> Recently we hit this issue with AMD IOMMU v2 driver [1], but it can happen with
>> any other code path (like VFIO path).
>>
>> [1]
>> https://lore.kernel.org/linux-iommu/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
>>
>>
>> -Vasant
>>
>>
>>
>>>
>>> Thanks,
>>> Robin.
>>>
>>>> To recover from this situation, we need force attaching all devices back
>>>> to the old domain. This patch introduces `force` parameter to
>>>> __iommu_group_set_domain() so that we can attach devices back to old
>>>> domain.
>>>>
>>>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>>>> ---
>>>>    drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>>>>    1 file changed, 17 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index de91dd88705b..e58683cd3bf7 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>>>    static int __iommu_attach_group(struct iommu_domain *domain,
>>>>                    struct iommu_group *group);
>>>>    static int __iommu_group_set_domain(struct iommu_group *group,
>>>> -                    struct iommu_domain *new_domain);
>>>> +                    struct iommu_domain *new_domain,
>>>> +                    bool force);
>>>>    static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>>>                               struct device *dev);
>>>>    static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>>>> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct
>>>> iommu_group *group)
>>>>        else
>>>>            new_domain = group->default_domain;
>>>>    -    ret = __iommu_group_set_domain(group, new_domain);
>>>> +    ret = __iommu_group_set_domain(group, new_domain, false);
>>>>        WARN(ret, "iommu driver failed to attach the default/blocking domain");
>>>>    }
>>>>    @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain
>>>> *domain,
>>>>          ret = __iommu_group_for_each_dev(group, domain,
>>>>                         iommu_group_do_attach_device);
>>>> -    if (ret == 0)
>>>> +    if (ret == 0) {
>>>>            group->domain = domain;
>>>> +    } else {
>>>> +        /*
>>>> +         * To recover from the case when certain device within the
>>>> +         * group fails to attach to the new domain, we need force
>>>> +         * attaching all devices back to the old domain.
>>>> +         */
>>>> +        __iommu_group_set_domain(group, group->domain, true);
>>>> +    }
>>>>          return ret;
>>>>    }
>>>> @@ -2164,11 +2173,12 @@ static int iommu_group_do_detach_device(struct device
>>>> *dev, void *data)
>>>>    }
>>>>      static int __iommu_group_set_domain(struct iommu_group *group,
>>>> -                    struct iommu_domain *new_domain)
>>>> +                    struct iommu_domain *new_domain,
>>>> +                    bool force)
>>>>    {
>>>>        int ret;
>>>>    -    if (group->domain == new_domain)
>>>> +    if (!force && group->domain == new_domain)
>>>>            return 0;
>>>>          /*
>>>> @@ -3135,7 +3145,7 @@ static int __iommu_take_dma_ownership(struct iommu_group
>>>> *group, void *owner)
>>>>        ret = __iommu_group_alloc_blocking_domain(group);
>>>>        if (ret)
>>>>            return ret;
>>>> -    ret = __iommu_group_set_domain(group, group->blocking_domain);
>>>> +    ret = __iommu_group_set_domain(group, group->blocking_domain, false);
>>>>        if (ret)
>>>>            return ret;
>>>>    @@ -3222,7 +3232,7 @@ static void __iommu_release_dma_ownership(struct
>>>> iommu_group *group)
>>>>          group->owner_cnt = 0;
>>>>        group->owner = NULL;
>>>> -    ret = __iommu_group_set_domain(group, group->default_domain);
>>>> +    ret = __iommu_group_set_domain(group, group->default_domain, false);
>>>>        WARN(ret, "iommu driver failed to attach the default domain");
>>>>    }
>>>>    
