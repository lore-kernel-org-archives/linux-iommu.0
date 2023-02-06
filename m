Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B405251
	for <iommu@lists.linux.dev>; Mon,  6 Feb 2023 13:55:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVFLRNxBkVYGbuZ/0VzehF3nPY5+lcIHahSy/pJy4PW2iiEKcKDpKmXrRPk9pgGfVZaO/7LvgU7hmREl6lP4JEJ6OzQW6lk+jJFLGtZhe9w+9N4hL+BK6pu24CSf7c9ZCzP1scNR4RiDtHxu4rpEPfXho1kjukyAvT72qJ0l10qNsnTOJlUDtYdzJ+e5BXgSWpMQP+u+D0ASJf6VFeMzbC4Nxs048HdCfPmWd8w5DhLeZ4bx24rjVZoAia7Ffiq4LxSyBPzvY98Ruzzpba+5b2hiufkq3aaoABJb4ByRxibjioCPB6Fd8ydN/TYQuQi5xphMuEqqMapC9ZC9YsF7yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRANBRdFl54n8tvmLbG7JDPZx3+JxczFYMiInlekEOA=;
 b=exqIdZ0Tb+o90kCvm0mclPgSfRsf8C4rPtYm4XwKCvRjfenz4WPKwJ8PRHaekhLQxSdxjidkS00W5ptzszpT/hKUrtt9xVi2kWXQ61pFTUq4ptaSmeWTDnulnCh59kyGQZM+wtmfQbJHhY0mhbYwJxw9tfrKa7TgLIItt+fdDi8M/7cbIfa7+dWo9yr0LSLr1A7AMtpHlq/j0LAPrnuW6dJqT7VrFtfw0SkUwzVIkrER3VK48C9XI7vkPCEIRY+pCo0RjTxU/E8qD8e+L+tyoiBFWqFoVDsZ0LTQ8RmRlDfHtdta9PRS0E9MmIv/rUVzcKa//j2zDKtIUpy9xO828w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRANBRdFl54n8tvmLbG7JDPZx3+JxczFYMiInlekEOA=;
 b=iZU2x48c8YiCxLF/Awy+Za+utHZ9qYbkhyN5yCk/e2q2USk39TlRcLfILFz+GCMcu8vQ3nk9Jh2mc4h1UHPmE3xYnwYTpc6x5dBRmsDv2dvV5PR8C6ML3QYjSuJhKZwiwj2moDWFEYvp3j+DuuOhZ0+dL9jKXfNy9MvPDKd9If0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 13:55:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 13:55:25 +0000
Message-ID: <ae54a94b-5927-927d-1fad-1bb49a2a64b9@amd.com>
Date: Mon, 6 Feb 2023 19:25:14 +0530
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
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b2061df7-d28b-207f-1968-a7dac3171cfe@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: cc865105-f5c4-46a5-a018-08db0849cbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y42Z+TxEvWSdLs2sZkiYkFRIwzhjDl3Z1qXh4VQe5oLYlzFsgwxfhj2SBRCdBC+mP2APWT7A8qXulcYHcFk+xxIo9WqKY0eZjg3FgUUucEtPYnDHv47Oa7xjRjv3qYZ9RBo6MSaJt+iv8DZVN1vuBSzgt+bh1Hf7lRelDug9DirKHCTFiMsfi//X7P3/RN/f92kKZj0qxNHRZSaFPtfPyrKRk50zTn7BCM/fUAUZKlxpdwsy7F/gJ9Nawrgf0hSAsvFopV/3fcI/tyq+Tb4wetfpBk0vmVDqCrQJxnBriKxNdOXVLjcGSbMB/hlRIQJkg6BdCIvSB3SmeMubgRNw7HSEOBMNjLJXOq7BK8P3BPO+r0jC78F/m3UDr2Pbh5T2TQaipNHB8uVX7XmP4FOkZJTMljaBp2+AF1fjikPeJq7jV5ouFEVnPnnzAt9rFaEVOeoqisatarbrmJoUUmoK4xeGZKd5AXCUWpF5AiCc4dOvVHh3SUi83nRqO9Ud6Lv35L2XMsYtcuMO407LWEn08m6YfXAF11JzlXtuvA0raNx7zxdo2lW01m13hi1LdOSpan2YU0CdWV1OogXrvBrCaVJoQkr5sn1O+B6Ess7q1aw/x+qNQcKx+ONoB8OB+DQGLGU5i3PYxmt+wQiYNZHMT7nv7KOysm3ZUycU29kk4EUrcE/AP3P0twtCXx7ZCGhvJy6Zjy+vTrsff3UVVEgmJUdtD/VR+xtNWUkzu8+bLR/zKlEd9XyYUo0ryq1HEHv90rK8h5v+nnqS/eivOiaR3Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199018)(478600001)(966005)(316002)(6506007)(53546011)(6666004)(44832011)(2616005)(6512007)(26005)(186003)(31686004)(31696002)(36756003)(6486002)(5660300002)(86362001)(38100700002)(83380400001)(66946007)(4326008)(8676002)(2906002)(8936002)(41300700001)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFRyUmVTOWM3MVdvMHpGZ1pxQ3FNNXhmUXhUaXp5RzBOdXh1eVdTME9sdExE?=
 =?utf-8?B?UHNjc2JRWmJGZmJ6dXZkeFR1aEpqNURxMzVJNStDeTVaNFhpUDdUT042RlJB?=
 =?utf-8?B?UUtncksySFRWSDdOVWdPenJaYit6UE81RVVEUTlPdkZmTlY5UngwUnlKVWJa?=
 =?utf-8?B?cUM4L29aYWV6MEppdGt3TTcveFFqY2JZVkRoZWlMUmpnNUVnR3V0TzFPOSs5?=
 =?utf-8?B?eDlRUHY3NEVGQUNSNU0rQVFabzlRMGRyZ0dYb1pBK1E2QzQ5bkgwVWFKVVA0?=
 =?utf-8?B?S1NGbHRWN1JXMTBtY1Y0czlIbUJiL1VwNHdzaFR1NjFBYkFYSDVOUFAxSXlq?=
 =?utf-8?B?Q0VJUG5sck9ERG40RVo5SjluNy9JRmVobzdBRnIrQlAybHBNRFY1Tm82bGVm?=
 =?utf-8?B?K2JIdnZGTkhZd2VZa25JdHZSc01CdVJTeFhleWVpbGxpWUFSbENRcWttNm5i?=
 =?utf-8?B?RmFWWGMvK1lBSGRsMXZtUUdqNUlSS2F1c2IzVk42bDR5UzBqelQ2YWt5dTdp?=
 =?utf-8?B?QXJGdzl5VkxZbEl1bjkrNXFFejNyM3hZYVA5eksxVUNudWRJbmRCc3JzMUpi?=
 =?utf-8?B?NkROWG94QURXb011M0d5SU4zOXNXUXkzeUlkeVRUVzhKTDB6dDlBU3IwQWhk?=
 =?utf-8?B?MHR4aG9XeEdsL0hRUG1RT2RRc21ia3BCYVFybnNmZmw5WnBFdFVRb1YvVG9k?=
 =?utf-8?B?WGpqdWJGQXl4Uk9oczlTNHF4emdGazRrSVp5RHFiVlJXUCtMa051WGJGbG9B?=
 =?utf-8?B?YUZJbzE0Um5sdHRpYzNVOGoyMGFUOXJKeUFvQnRuTlBJUlcyQ1ZPTXRKWjhC?=
 =?utf-8?B?Wk1ZeXRLMFJ3c1lId3phQ1BOQkFVMFJ2SDNzcy9uOVljRFhyRWdRNUZzdUNo?=
 =?utf-8?B?QWdMbmh1clJPUnl1SllqTkJHOGRTVVJFdFNxNWVKS1ZldTZkMUg5UzduZG9n?=
 =?utf-8?B?VkRmTENxclBiTmUwS1h1dGxRZGVsMHNWdHRPUkRUN04rd3I4d3VMclJJcXp1?=
 =?utf-8?B?QzR6Z3Z4aElTa0tkTzA2UVRudk53dGxZMXRhalZmUmpPUzhlRTRxb0tOb2lC?=
 =?utf-8?B?OFBXaXIwVmZvSm8xVVdZOWhIemJOMWRTdGFpZE9GS3JTaFg1eEpqSnlSQVJL?=
 =?utf-8?B?cW5ncjgxOWpOdEgxVngwWFhYNWVYak9pVXl3SGNWOVdCVlBpRUNjdm40V0t4?=
 =?utf-8?B?ckFkVS9wWHhwdTh1QWgwSWhqdVdPZkxaTisya0ZJbk5QZnpMdnloSWlEUmpY?=
 =?utf-8?B?cmkxeHdScVovRGtEbGVUQi9Cd0k4Q1poTjk3N2tXalp5NDJzL29RT3VIeUp3?=
 =?utf-8?B?a056U3F3Ui8yNWVWMTJKdWsxd0tkYVVDZWdabEZQSk1yQUxIL1dTVFZGRGtw?=
 =?utf-8?B?bXQ5bVlOaXladmh6UmZmL1NpMjRrV1ZWdlNPZXJDZy9JSG1MZWswbmFUaWlZ?=
 =?utf-8?B?VjJxYmRrQ05ISEh6SHFReW5lb2VFZzVrTVJSWHhrb3BsbUlSVC81SCtkNWxM?=
 =?utf-8?B?SkZFUnBEN05veUtGdFpYaGpKZXpJcjZ1a3hVSzAvK2JmUDBFNVVCWThYaHRY?=
 =?utf-8?B?aithUzM0Zzg0VEhzTDNTdGVuSTFYSUdoa0ZlbmNlTXdjVnlYcithSXB6cVIw?=
 =?utf-8?B?YUUvSGg3YkQyc2JGbjd6N3kzODczVmVPaHozY1A4OFRLRzdDRWhLbThCa3lM?=
 =?utf-8?B?V3lUN0g5dTVsdnpQL3Z4U0pjeDhyYkZVakVXUHRNamlQMzVFL3A5aWlpSysr?=
 =?utf-8?B?T2hFdnpTd05zcnQ3Vlh4WDdGenMvYS9RSEhsWnY2eDRRVHpSbDRFV05SYm5y?=
 =?utf-8?B?OUhWRVdvMlU4eFdjVW1ROWI4QS9FVE9iRGpFS25reTlxRHJNSU02UUQ2WmxS?=
 =?utf-8?B?Qnh3U1J0YjU3a3hQWEx1VHYxdGFyOUU4cHh6azhxQzNqMjdzNGFrTVNYbXZP?=
 =?utf-8?B?MEZ3L256dXVnZVpycTNOeWNmcGlRKy9uaHZFTlF6amJmaDgrclcvS3hMdkhV?=
 =?utf-8?B?UnVNbDFhTmUxeCtvUWRKYzVPTDJmRVk2b3RlYUpCWkhVRm5BWDhsN2p0MDVO?=
 =?utf-8?B?SC9ueUdLbVpTK1Y1dmowNTB4NHhKZU45RGdUZit4SG02Zy9seWNSaEJMeGJw?=
 =?utf-8?Q?VGlyvtcr2iiW7WdRmA/TzUcFT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc865105-f5c4-46a5-a018-08db0849cbcd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:55:25.1379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmL8TFYxoJqGZ6Mk2RgQDUwErOdZ2KQh9SO/9mBloL72pXRTNAqU6ptVOZG8l3ZJPanvv85HJEe96yAMWWMgNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231

Hi Robin,


On 2/6/2023 6:59 PM, Robin Murphy wrote:
> On 2023-02-03 17:36, Vasant Hegde wrote:
>> iommu_attach_group() attaches all devices in a group to domain and then
>> sets group domain (group->domain). Current code (__iommu_attach_group())
>> does not handle error path. This creates problem as devices to domain
>> attachment is in inconsistent state.
> 
> Can you clarify the circumstances for this happening? I think the implicit
> assumption here is that if first attach_dev succeeds, then the group is
> compatible with the domain in general, so then any subsequent attach_dev calls
> are mostly just updating data for additional RIDs, and as such would not be
> expected to fail.

It can happen with even single device in the device group.

Flow :
  - Try to attach device to new domain (say IOMMU_DOMAIN_UMANAGED)
  - In iommu_attach_group() path we detach device from current domain. Then it
tries to attach device to new group.
  - If it fails then device to domain link is broken.
  - iommu_attach_group() returns error.
  - At this stage caller assumes attaching device to new domain failed.
  - But it should work fine with old domain.
    This is what I'm trying to fix it in this patch.


Recently we hit this issue with AMD IOMMU v2 driver [1], but it can happen with
any other code path (like VFIO path).

[1]
https://lore.kernel.org/linux-iommu/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/

-Vasant



> 
> Thanks,
> Robin.
> 
>> To recover from this situation, we need force attaching all devices back
>> to the old domain. This patch introduces `force` parameter to
>> __iommu_group_set_domain() so that we can attach devices back to old
>> domain.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/iommu.c | 24 +++++++++++++++++-------
>>   1 file changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index de91dd88705b..e58683cd3bf7 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -95,7 +95,8 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>>                   struct iommu_group *group);
>>   static int __iommu_group_set_domain(struct iommu_group *group,
>> -                    struct iommu_domain *new_domain);
>> +                    struct iommu_domain *new_domain,
>> +                    bool force);
>>   static int iommu_create_device_direct_mappings(struct iommu_group *group,
>>                              struct device *dev);
>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>> @@ -1974,7 +1975,7 @@ static void __iommu_group_set_core_domain(struct
>> iommu_group *group)
>>       else
>>           new_domain = group->default_domain;
>>   -    ret = __iommu_group_set_domain(group, new_domain);
>> +    ret = __iommu_group_set_domain(group, new_domain, false);
>>       WARN(ret, "iommu driver failed to attach the default/blocking domain");
>>   }
>>   @@ -2124,8 +2125,16 @@ static int __iommu_attach_group(struct iommu_domain
>> *domain,
>>         ret = __iommu_group_for_each_dev(group, domain,
>>                        iommu_group_do_attach_device);
>> -    if (ret == 0)
>> +    if (ret == 0) {
>>           group->domain = domain;
>> +    } else {
>> +        /*
>> +         * To recover from the case when certain device within the
>> +         * group fails to attach to the new domain, we need force
>> +         * attaching all devices back to the old domain.
>> +         */
>> +        __iommu_group_set_domain(group, group->domain, true);
>> +    }
>>         return ret;
>>   }
>> @@ -2164,11 +2173,12 @@ static int iommu_group_do_detach_device(struct device
>> *dev, void *data)
>>   }
>>     static int __iommu_group_set_domain(struct iommu_group *group,
>> -                    struct iommu_domain *new_domain)
>> +                    struct iommu_domain *new_domain,
>> +                    bool force)
>>   {
>>       int ret;
>>   -    if (group->domain == new_domain)
>> +    if (!force && group->domain == new_domain)
>>           return 0;
>>         /*
>> @@ -3135,7 +3145,7 @@ static int __iommu_take_dma_ownership(struct iommu_group
>> *group, void *owner)
>>       ret = __iommu_group_alloc_blocking_domain(group);
>>       if (ret)
>>           return ret;
>> -    ret = __iommu_group_set_domain(group, group->blocking_domain);
>> +    ret = __iommu_group_set_domain(group, group->blocking_domain, false);
>>       if (ret)
>>           return ret;
>>   @@ -3222,7 +3232,7 @@ static void __iommu_release_dma_ownership(struct
>> iommu_group *group)
>>         group->owner_cnt = 0;
>>       group->owner = NULL;
>> -    ret = __iommu_group_set_domain(group, group->default_domain);
>> +    ret = __iommu_group_set_domain(group, group->default_domain, false);
>>       WARN(ret, "iommu driver failed to attach the default domain");
>>   }
>>   
