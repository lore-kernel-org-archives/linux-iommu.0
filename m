Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989CF389
	for <iommu@lists.linux.dev>; Fri, 23 Jun 2023 04:38:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAkfVwdK6+RDG9Qs81k5/0Xska2EEoqwWjHL6Zep2Bp1YbwL2yaq5wiBxA7XtlzOCQz/T52uHcRLl8UmuhWp8l2wzwDns/OmLilTTZGM6dMehgFf0EbA57htOnJ5rWcoomc/2kZqk7FM/7LWzLr+7bTFgeqZPXwrsBgInNEs4GBdtdQPzMvaYZw+y1+Bkoa547dRABrJ/uEsIyFu5ZTlZWKKM/0H4skO1HJvDgadOwqYSxWksfIwKgC6xHFIV+92oSfnouxrhPiYqiCQAfVhyIOXsB/rf+1GsTODZ7p2C7vxXznrSOCRFjrvQEKfIEFnFffspuKRpB0KFu08nqXnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elfUTLnwT09A2IueBBZoTcO0N4bFdDypIXnvIcTqSPU=;
 b=LeTOZlCRrr+qXh87/yDYS6LKh1p12NIJed1FTK6vxmN7bFIUvJsaFjMrNMYwPVrgncEu6ldVgh4+NXT+c3JwkEx6Bqai2nlRZ6EIJ9JSdtNs747uf2I4Pg4HzxyP7wJQoyg+utHBL+dp6Pf5/iFbWc3jUUtfXsSTrFFbjrNFH7YO5MBlaM0RjOh97XWqtiWby0NW9Jo6oKHlmbhPFYx2lFSjzSo4tq/6JDePT3tgWRFeLqPa2Jj7REhpdQdWKcIchdiDi8xW0jifo2CUG3PTK3DCdg6wcVSjBQ71SPsczFV00poFRvpgsEyCqhiX2/0Evn+wHIwIscAEj9FMVZhDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elfUTLnwT09A2IueBBZoTcO0N4bFdDypIXnvIcTqSPU=;
 b=KdZut+FpjfQrG0RUuP7Mycq1A8dp+MdjLkA8ByBG6D4yWn0CZX0aiB82j+Cy8rK1TMEMHA5MIfEQQsRIOaXOcmoUpVlAal3lXCsYk6OlnnGHA8CIe4qJjJhYzOl8MeQhYsuXFysizj8jw2n5rIfLGlxefHBJetAVr7eoQLWBTvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB6671.namprd12.prod.outlook.com (2603:10b6:806:26d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Fri, 23 Jun
 2023 04:38:51 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 04:38:51 +0000
Message-ID: <b69af01e-d2ee-c8cc-4e59-9ca890e9fe4a@amd.com>
Date: Fri, 23 Jun 2023 10:08:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 iommu/next] iommu: Fix default domain setup
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230619084945.6427-1-vasant.hegde@amd.com>
 <13d072e5-df86-d3c8-6742-e52b66fd96a4@linux.intel.com>
 <ZJGQsWXkgTuj7xC1@ziepe.ca> <13b8b3a8-4dc5-7e61-4e0b-f545a3679a8a@amd.com>
 <ZJRSuBsVBVSi8Swn@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZJRSuBsVBVSi8Swn@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: ad05d691-e7af-4ec6-c0d0-08db73a3bdfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	En1vtpEOhERidOaOiYtMn+0jz2HKpSgIZF7YMsSkmgFN1WRh14LOYFh2jPei2d5GkNPGLF6zo0uvS457q3ChHUnS5D8tejfsI4A4DcZVVDO/IBVQQF73GbQfZp3jnL6cRX+9DfbNL0V5/smRvqBJ1SShcKfYZ8pDHE0e8HEkTvF7s4TWJ41ElEvoyNYu7OdKLENSXyWfAYB2CxwRTXDZxQkHZOm4dZtOJdQeY3evFPH5qHI0yOwrhI/Zix9jKh3PCznHqmDpjwTNgjcXEFQZjl+ivOXQV16zNxDMyxFMqhctRqTWoLjW9uE1DnWdA4iwVA4U0I2mLuYBpNgF/VdK5Q5qbXCA3/I2dnf3IILtDiofQxm0sxhZKERZ6ipi40uJwcp77cal4rGKpwoBNbOWNFj4c9zQqLHgowzK/xcXTzVhjg075NqkGOYj2fX97KanpRqANEWPAHtWmYRVQIA8EhcLOtX2IUc0+RaPTRsFJENHjO7EjgMkeIecrQGH6nJ+ogL8eUSso3BmNYsKJ/x5f1bVnjOK2eN8MQy0MFJSO+HXAIRVM58+QPQPN0RX2ynUUuRHzS6vjybh7HoKCnd7ZC3jkXquqVKlJYDbfG+/oG5s4Sc3hllRlsX+SmXKRrY7Owdfs2ukR2VSwG9kea2Dcg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(53546011)(38100700002)(26005)(6506007)(83380400001)(186003)(6512007)(2616005)(44832011)(41300700001)(8676002)(8936002)(5660300002)(36756003)(6666004)(66946007)(6486002)(45080400002)(478600001)(6916009)(4326008)(66476007)(66556008)(31696002)(86362001)(316002)(54906003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1UwWWVvQk5TcVVjOTJRcjg0UWUyMTBNRHZaVjRlT3hsYS9mcU9hZlJlZTJy?=
 =?utf-8?B?eFdqbE4vdnorR2VhSGZzVE9FOExsTWJsTnNTRGJQV0tWNmdmNWc1K1ZFSzJU?=
 =?utf-8?B?cFlmaGJxV2s4cTdNR3pxc1pQVFBJVkhJM1VoR1hJWjZsTVhaQTc4bENUSTFH?=
 =?utf-8?B?YTZFSWY2WTNpWldKMXRpcDJEZWN3cGxHNjVVZDlxcElSRjZLcHRYUEE0SU9O?=
 =?utf-8?B?TWlhUCswREVROHVtNkFaSVZja2Q3eVBaeFVJejYyQTNRZXZuakcxMURQVUFT?=
 =?utf-8?B?TlV1YzJZeTBpWXArYUZtM1hUUTRVczQ5S2RvMU1qaURvTVdLK3Jsa3BEMWRF?=
 =?utf-8?B?WDJRajljc3EwVWl0VW5ubFdYOW5zcDRSYnRKZjBSQk9HSTlwTzlENTgxY1VK?=
 =?utf-8?B?M1hFcUlKcXV0a2dTbFoybzdlL1EreHJDWWxGc3pDSFN0Mld1YWpRcGVUdWJB?=
 =?utf-8?B?RW1EenEwbFpIVDRqRHFlRXN3QUdPaC9saVp6WlI3T2d1cEo5Zncxb0VRaStp?=
 =?utf-8?B?TG56MWFxUHpUcnBNYi8xQ2JVeUNvZ2ZpRE9CZjV1M0hvMEdjYWRkS3p3R3gv?=
 =?utf-8?B?a3BtRUJDYUMzcTRrTGptMEdQbnFYQ0hkVDFFR1ZOTUtLUnBUQVRiVjdvWDRj?=
 =?utf-8?B?TFNtaG91TEZta0lpUkhqdmVWSFUrSU9taytxbmJ3ZEFqMkhObmNoYjFwMnpN?=
 =?utf-8?B?RDMwZDQvRFpDVG1YNEVsYVVvWjFHOXVBcy9velNBVUpNelJDbjI2c01iRmhp?=
 =?utf-8?B?bWhQaVQwMkRiUndDUmVuNUNzYk5tcWtEVkdZWjZSa1ZhOTYzYzdtUDh4dFY1?=
 =?utf-8?B?ODVJRkFjVVRjbSthRytvckxjdVBuNVJISTBsSVlaZGloQlF1b3hNUHNBd1Ar?=
 =?utf-8?B?TTh6U0grcnc2KzFoVDNkSHFvLzdTWnNhbkh0UGR3SkxUZlFUOUFLKzFsc1Ju?=
 =?utf-8?B?bFE5NlYrQTBKNEtaT1RRMVlmem1SaHBLZzNxVlI0RUJLOWJsWHpNZ3pNZlJP?=
 =?utf-8?B?dktpbjRWZXpmNGJLL2htY3NTU0YwN25XQk9oR3IzZEk4aDR0N3RNb2JWakZt?=
 =?utf-8?B?cmRUd1gzSkFkdnE1a2liOUhERlVNaHNhOWgrdXpLQlFJSlhBemphTUFJUVFS?=
 =?utf-8?B?WUh2cnVKR1JXWDROaXQ5UDlkWnRSalFSZmF0andSTFpIQ0pQZGtYQW9WVkJQ?=
 =?utf-8?B?a1lpYmprUjl5YnNtL0o0RzE0R3RnYWFVenFkaC9PTmxGdkg0L3JaeHUzN0xr?=
 =?utf-8?B?RnVNTlFLTHFaSGNBQkx6R3JFRFVMRHdKZTAxLzgzdWxWbG5uSWhxRkl6QkZh?=
 =?utf-8?B?TDB4U2ZaaFg2TitvOXJqZ01JaUlieE5Nc1FEZjQ4dTZxNjdmeDlWQkl6NGFG?=
 =?utf-8?B?VGtLY3J0UUZ0UGxkbk5SR0R3RXVOVCtpR1o2a2YxdzhLZ1V4TDZKS2c4ZDZk?=
 =?utf-8?B?VGVSbVZoRTc2cTFidE1lOUhSbXFkcEJSQWlZRXVUQjI5cHd0dXVmdldpM0Fp?=
 =?utf-8?B?akhLOW5FUElaSkl0WDJPOG9OVElENWUycWxUZkc3VW02RElzZzROLzRVSmUr?=
 =?utf-8?B?WU1hTzMyS05HdXNRQ1NlSTRyRldoczF0dlBrVk5adTRIWnBhSjVlRVp2RWZv?=
 =?utf-8?B?WlhGM3hxaldBYjFZam1DOGlzOXNrSEdrSzB4SUQ3cUpvQk1FNkxDTTd6N3JQ?=
 =?utf-8?B?ZlBiazYvVEFZZXNwKzBTYnlhcmxtRGhiam9zbFcxRGp6Yk92KzBIK3gvRXU1?=
 =?utf-8?B?cUw4Zytlc0tnd2pOUVV6OEUvRjZqTk1LRmFQNEM3bHhKZDgvN05yNC9iUUVY?=
 =?utf-8?B?eEpGNmxlaC9Id3Z0ZlowUHIxSUpERk9pelh2SmR0d0FPTk5EcUVvT2NRcEp0?=
 =?utf-8?B?cnYyRGJSVk9YVHlkSVJNRU5Vd2JCcHRNRVVLRVZlSG05MHdkYnFrZk1peEhT?=
 =?utf-8?B?VjFNTHdOaUh3RFhWT2NwK3RHdjZhOEtOY2lJbzN1bDhDZm1XTWZtK3B3cnJw?=
 =?utf-8?B?aUF0bmczVkZ5K2duMnJwR1QvV3k0L2lWMm1NUWRsTzBtRSt5QXVJTFZ5aU02?=
 =?utf-8?B?Q1ZTV2k0YTVJYXlOWmFkanBWbzRNOFZQU2ZsL0NwYS9BOTFiUWhCUVhaUi9k?=
 =?utf-8?Q?xzPMfieL+5l7kudHY9AGFGev6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad05d691-e7af-4ec6-c0d0-08db73a3bdfd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 04:38:51.1492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqpEpQoUHuWVmWOSUVKbgDNnGQXDlm/E3Nz8Dx8S8jTdNmwPcoexfoLGF5CX2iJQbPlPmhRqUDNzD9WtXCdO4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6671

Jason,


On 6/22/2023 7:25 PM, Jason Gunthorpe wrote:
> On Thu, Jun 22, 2023 at 10:29:58AM +0530, Vasant Hegde wrote:
>> Hi Baolu, Jason,
>>
>>
>> On 6/20/2023 5:12 PM, Jason Gunthorpe wrote:
>>> On Tue, Jun 20, 2023 at 02:31:43PM +0800, Baolu Lu wrote:
>>>>>   err_restore:
>>>>>   	if (old_dom) {
>>>>>   		__iommu_group_set_domain_internal(
>>>>>   			group, old_dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>>>> +		group->default_domain = old_dom;
>>>>>   		iommu_domain_free(dom);
>>>>>   		old_dom = NULL;
>>>>>   	}
>>>>
>>>> The err_restore branch doesn't work if old_dom is NULL. We have no means
>>>> to restore a group from a successful first-time attaching to NULL
>>>> attaching.
>>>
>>> Yes, this is what I fixed in my alternative version
>>
>> Not really. Even your version has
> 
> I though what Baolu means is that it crashes in some of the cases.
> 
>> +err_restore_domain:
>> +	if (old_dom)
>>
>>
>> Only first time we will have old_dom is NULL and this functions returns error
>> code. iommu_probe_device()/bus_iommu_probe() handler error path properly and
>> frees resources. So I think this is fine.
> 
> Yes, the design is to leave it as-is and know that the error unwind
> will fail to attach the device and free the domain after
> release. There is a comment explaining this.
> 
>> @Jason,
>>   I'm fine with your version of patch as well. Are you going to send proper
>> patch -OR- do you want me to respin?
> 
> I was hoping you'd test it and can you share the oops message?

This has been tested. Sorry. I should have mentioned it explicitly.


One of the call trace without this fix:

[  350.334395] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  350.341356] #PF: supervisor read access in kernel mode
[  350.346494] #PF: error_code(0x0000) - not-present page
[  350.351625] PGD 0 P4D 0
[  350.354164] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  350.358523] CPU: 1 PID: 3417 Comm: avocado Not tainted 6.4.0-rc4-next-20230602 #3
[  350.366003] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.3.6
07/06/2021
[  350.373567] RIP: 0010:__iommu_attach_device+0xc/0xa0
[  350.378533] Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48
85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
[  350.397269] RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
[  350.402488] RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
[  350.409620] RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
[  350.416751] RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
[  350.423875] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
[  350.431001] R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
[  350.438133] FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000)
knlGS:0000000000000000
[  350.446217] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.451956] CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
[  350.459086] PKRU: 55555554
[  350.461792] Call Trace:
[  350.464235]  <TASK>
[  350.466335]  ? __die+0x24/0x70
[  350.469392]  ? page_fault_oops+0x82/0x150
[  350.473404]  ? __iommu_queue_command_sync+0x80/0xc0
[  350.478283]  ? exc_page_fault+0x69/0x150
[  350.482210]  ? asm_exc_page_fault+0x26/0x30
[  350.486396]  ? __iommu_attach_device+0xc/0xa0
[  350.490756]  ? __iommu_attach_device+0x1c/0xa0
[  350.495201]  __iommu_device_set_domain+0x42/0x80
[  350.499820]  __iommu_group_set_domain_internal+0x5d/0x160
[  350.505220]  iommu_setup_default_domain+0x318/0x400
[  350.510097]  iommu_group_store_type+0xb1/0x200
[  350.514536]  kernfs_fop_write_iter+0x12f/0x1c0
[  350.518982]  vfs_write+0x2a2/0x3b0
[  350.522389]  ksys_write+0x63/0xe0
[  350.525707]  do_syscall_64+0x3f/0x90
[  350.529284]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  350.534338] RIP: 0033:0x7f02e2f14a6f
[  350.537918] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 19 c0 f7 ff 48 8b
54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0
ff ff 77 31 44 89 c7 48 89 44 24 08 e8 5c c0 f7 ff 48
[  350.556663] RSP: 002b:00007ffe5451b6e0 EFLAGS: 00000293 ORIG_RAX:
0000000000000001
[  350.564226] RAX: ffffffffffffffda RBX: 000055f381c20a20 RCX: 00007f02e2f14a6f
[  350.571352] RDX: 0000000000000008 RSI: 000055f382f36220 RDI: 000000000000000d
[  350.578485] RBP: 000055f3829e0340 R08: 0000000000000000 R09: 0000000000000000
[  350.585615] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000008
[  350.592740] R13: 00007f02e30adf80 R14: 000000000000000d R15: 000055f382f36220
[  350.599865]  </TASK>
[  350.602057] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack
ipt_REJECT nf_reject_ipv4 nft_compat nft_chain_nat nf_nat nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 nf_tables nfnetlink bridge stp llc binfmt_misc
ipmi_ssif vfat fat intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd
kvm_amd kvm irqbypass acpi_ipmi rapl wmi_bmof acpi_cpufreq ccp sg k10temp
ipmi_si acpi_power_meter squashfs loop dm_multipath ipmi_devintf ipmi_msghandler
ramoops reed_solomon fuse ip_tables ext4 mbcache jbd2 raid10 raid456
async_raid6_recov async_memcpy async_pq async_xor xor async_tx raid6_pq
libcrc32c raid1 raid0 linear dm_mod sd_mod t10_pi crc64_rocksoft_generic
crc64_rocksoft crc64 mgag200 i2c_algo_bit drm_shmem_helper crct10dif_pclmul
crc32_pclmul ahci drm_kms_helper crc32c_intel libahci ghash_clmulni_intel
mpt3sas sha512_ssse3 drm tg3 raid_class libata i2c_piix4 scsi_transport_sas wmi
[  350.679856] CR2: 0000000000000000
[  350.683174] ---[ end trace 0000000000000000 ]---
[  350.687791] RIP: 0010:__iommu_attach_device+0xc/0xa0
[  350.692758] Code: c0 c3 cc cc cc cc 48 89 f0 c3 cc cc cc cc 90 90 90 90 90 90
90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 54 55 48 8b 47 08 <48> 8b 00 48
85 c0 74 74 48 89 f5 e8 64 12 49 00 41 89 c4 85 c0 74
[  350.711495] RSP: 0018:ffffabae0220bd48 EFLAGS: 00010246
[  350.716721] RAX: 0000000000000000 RBX: ffff9ac04f70e410 RCX: 0000000000000001
[  350.723844] RDX: ffff9ac044db20c0 RSI: ffff9ac044fa50d0 RDI: ffff9ac04f70e410
[  350.730968] RBP: ffff9ac044fa50d0 R08: 1000000100209001 R09: 00000000000002dc
[  350.738092] R10: 0000000000000000 R11: 0000000000000000 R12: ffff9ac043d54700
[  350.745215] R13: ffff9ac043d54700 R14: 0000000000000001 R15: 0000000000000001
[  350.752339] FS:  00007f02e30ae000(0000) GS:ffff9afeb2440000(0000)
knlGS:0000000000000000
[  350.760417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  350.766154] CR2: 0000000000000000 CR3: 000000012afca006 CR4: 0000000000770ee0
[  350.773279] PKRU: 55555554
[  350.775989] Kernel panic - not syncing: Fatal exception
[  351.399507] Kernel Offset: 0x2fe00000 from 0xffffffff81000000 (relocation
range: 0xffffffff80000000-0xffffffffbfffffff)
[  351.410284] ---[ end Kernel panic - not syncing: Fatal exception ]---


-Vasant
