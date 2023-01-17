Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80E1C27
	for <iommu@lists.linux.dev>; Tue, 17 Jan 2023 04:56:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwZ/4P/XHiu2VtYLTo0IjkZF0j2He7I3WURsjbeDChfe2pla7J5Hj1HzTUe2Z7rBJIXtic7kPt6BI93jFabRBQyMpjTXMG7lCl9z3vucOYXDqZ9HTYYirQJnfopxIyJUR41nTikiH9K6Xav3bohg9FITtDChWExuL8Cpnfp4qlPrBeJONJ2zdVOcDo89qt8pjZ5LfdEIxQSUfad13M7dHCVhKEjKX/xyI/noiUhaChD9558K3uR6r1R+K9BcoECdxi4NugKFdl/Vnw1/H3KBQ73jILCQIU0+BFRqh2SpjazB5wqWMCz/jtHmwvfdfVQEb+Q1tFgpDMZFX305LfqPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEnfVUfwn0sxOygFl14VvJxRautOYIOibWViYQFBPsw=;
 b=gPPlBtRwqnVPdO4iQ8L90fn1TSpsNU3ubm8ixBUq33zYjb5oLtCcgyAiFVMtdm+Sh7ZqUNZN4sBYZ5+ogV622lTRJ/odS2ImZQSKuzdsQFdC18pVZKG3Qh2eRrPWe+rAFqV5oWwKYYBmAIT7UB5rTAyNTgClRqSPowPSejwDi7A0KDPoe7Z/kv4HXmOAEwzF1qC4LNM398jmXV72Ljj4MR9RvabuRhU15qZhwy9CBDq4Mwp4uRl0bKcY/ahbg9RJ07E/yrauP4ipjkm2OEMAhCvkYMMQd7uFePyAAsy/m861HlBONiC/8oaiMlKoIyqMog3ejoXpXFIDNFzO6/9jLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEnfVUfwn0sxOygFl14VvJxRautOYIOibWViYQFBPsw=;
 b=unc9/WqEcufbDJcpDIPaTDaESP9pVu098SfNlzyL69sLhApwC+FbJO5TCE9V1QcD0OO7YRCs5DZQqtSL016QZ6cVRmDP+rvXco8hTPtGqQBCofYgN65wcAG51MgMcNi9wAXjMEOrKCTMHrB07yRQQzmhRuVXIUWw2vyQ4bGsS7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 04:56:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 04:56:19 +0000
Message-ID: <d77104a1-3433-1f34-62da-6ffec8d44d2a@amd.com>
Date: Tue, 17 Jan 2023 10:26:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] iommu/amd: Call BUG_ON in page fault hanlder path if
 domain is NULL
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, suravee.suthikulpanit@amd.com,
 Matt Fagnani <matt.fagnani@bell.net>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20230113135956.5788-1-vasant.hegde@amd.com>
 <20230113135956.5788-3-vasant.hegde@amd.com>
 <700deece-41bd-a10f-2be8-a0f30fe1a4eb@arm.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <700deece-41bd-a10f-2be8-a0f30fe1a4eb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::31) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: efa60e76-ded8-4f93-7b22-08daf8472be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eQfQWgjX0/KIe0YQTeNdoQR+hYn96lYrreMMePGyGklKKEHEIY/vv/TsZR13Q2yw3HM/JYYK8+xY0BGt7E5N1DbWps8CIowLyGbso5EEuP4H3yhMcLQ6ZiLrbMB5SOzEC/wx5vsTo0qig7oVRrxMIcDtBK33wyQDsIn2fxofrjqmJm8IyNKSLIev7x6apvxCF0rvwJMG9B71ofhs2KmB8EKtN5LA1Dy6Nqv3NAlW/yExWnS0FEX7I0gRvf68BvrriBqeF+WNIV5qm0UPiYfpcLjgvYjd0KkZOIm2QdT6WCErB01QVYLrT1v3P4Xa9V1+rgIX3k00CThGw3n7+CO/9KgPJa76SrKkmS4rjNZhl7uACU6DbbLxBZ3L4KdFcX3vrFQYBHVkzjXNAOdG5O2dxFblQlYrfcfwx+PHdzTcah8XZ4KXHnBWn066VtxSjRfGcGtFgQ5gpcfbN/MdKmr+r3p8AuIviRfhIqf7PEBTjhudnIQ6M4q/pEaNkQWxTiqQGc3I6kN0Dce60wn3kuGKwkOFlIaEpf3lei4MtRFY06GnhG5wOWyMoRrYfRs9TsZkPRpvbXnOn4BYrQ4m91Uw0CKG3m3qd/lwDqgFA8pFgOmhrw/Y8TEszme64YMSKXbNnDHHwNdF9KtcJodskUt1ueipKOQhFF3z3tO2E5gMnyKgcqzsO7qDn4P7bam/2xguzrTrrUx2GAGSdVIsK2UgfHneHNbpFkwncPCpmdG4mvqKynjFPuUIYNCPx+rP+dcjmGlf9N81JmmRaaokfXdxqw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(8936002)(31686004)(6486002)(966005)(44832011)(5660300002)(4326008)(66476007)(66556008)(53546011)(26005)(41300700001)(36756003)(66946007)(8676002)(2906002)(316002)(31696002)(54906003)(86362001)(478600001)(38100700002)(6506007)(6666004)(6512007)(186003)(83380400001)(2616005)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0tseFRGOXcxQ2hDeGJmNHhsVUlRaXVIaE8vdkNJL1ZFbm5pVGJ0K1kxalJV?=
 =?utf-8?B?S0grWTBxbC8rRm1ZR0FyVDZMRFlpMHUyN3JxNWcwaE01Z3hNbFlFTER4S0kx?=
 =?utf-8?B?TXJnMzZ0Z05tTHRpcGRndDBtdVZmS2c5UWRBdkZGT3Z6NjlDeTV2bFVyeHJ4?=
 =?utf-8?B?dnpkZW0rK3ROVVN2cllXNnUvTHh1dll1SnlqQU1IendpZXNUajVUdHRYQUln?=
 =?utf-8?B?TDh5UEp3U1BWVzRTd2NtcUVUcG9mUDFmamdnYkZ6VzgwSjI0RzZwa21oYnF2?=
 =?utf-8?B?RjJpTXRSVVlHcnJRVnhNdGNyZ0RiUVUySjlQcXJlR09FV0tDWDhPQmQvSFF5?=
 =?utf-8?B?bDlkcktUdU43U213eE1XR0R4MGdMc1Z3QnB6djVLamNSWTh1bWxlNGtMaWpS?=
 =?utf-8?B?Z3ppdkVjbGlCc0dWeHpjNnVLT2RVNnNoQlFJVDNjTXUwTE5UdUo4MThVb1Jk?=
 =?utf-8?B?UVVkWFJjUUMxM1kwVGFIcGFWZFN5YzJtblJqbVlINmxRVFdKeWF0bDVNMmJN?=
 =?utf-8?B?aXhCK0NjZ25EQVV4ZlBwcTdWRk9BSW8wSDNPMXRwaFlRNWJpaUdtQUVIcG1O?=
 =?utf-8?B?Uk5ySnpQMzhZTndWMEhzM2lnaDR5MWFLUzYzQkRUYlEzd3pZQTN0ajMrMFhT?=
 =?utf-8?B?V2drMkkwNndaYjZsd3Qzd21NM0Q5ajlPNlNyN1N3RUh0MHdNRlpleHJQeTdW?=
 =?utf-8?B?L1dRZGx5UWhtcnAxWExxZ1VYanZ3UDljOGpzV08zeGgzNTBYWHMxRXg0cWw2?=
 =?utf-8?B?Vzl4cXlBMUlpaXZhdWsvMGFPaTY2alZQeUFMb1BRRkVDY2pOR2ZPaktQRnMy?=
 =?utf-8?B?c1NJMmVYY25xellKVHNVbGEwLzlySDZxNTNScHc0TlJYUUh3QStvZUZjK1d4?=
 =?utf-8?B?VTR5NGRxd0lVczhaUjArOVdZanRTSnh6Qkk3Q1I1TXZTWkgwOENYdGF1cXA2?=
 =?utf-8?B?NHdzTzZXbmNwNHVJcHNXbkVkTXJWbkROQUhHeGIzYU02VFF5WDZDNjNSRlFw?=
 =?utf-8?B?TEpLUVNoYjVjMk00RVN2eENkNWFzaTlrRi9pa2d4cSswQkZTN2EyMHR1S0xN?=
 =?utf-8?B?TkxxSnNJRHl6S015VVhLb1d6c3FIVmN5V2dIY2Z1VkVzbzZYak5lUHhadXFN?=
 =?utf-8?B?WVBsUE5hRVBCbDdTdlR2VytvRlBTbWhkWjh2QVd4NlNMWlNyOTNyemUzc1Zq?=
 =?utf-8?B?ZG1XVlRuOXdsTWNMRjJ3ZkpUZ283ZVBnWjNzY2RXcGc0WUtpNlVmcnVDL0tZ?=
 =?utf-8?B?T1h6RjFDMWYyTy90SWtsaWFmd3o4RTM3SFhEVE5aMExvK3VaTGhQcSsxV0hh?=
 =?utf-8?B?S1FoeXdmamovL2loYk94amJUTG5hbExsTkttVWdCUDFWRTNwMDdmVVpKdUJj?=
 =?utf-8?B?TVpXeWFNbUF3SWdPZ2ZJQ0g1ejBIQjVqTXJFeFhHbmJpdzlGdGlkeFdiSUJy?=
 =?utf-8?B?SmlsUnJ3Rk9paTdWb1dmdnZkTVA5MFd3dUN0MEJDRHVlV3pqSGJ1VXdyeFVP?=
 =?utf-8?B?QlQwRHFIbVFwOVlLRFppQjBObXh1NTFiTitRcnRBWnhUc2lCZEtyNDg0WGpa?=
 =?utf-8?B?eWY3a3dNQjhVSCsxN2dEN1hXSGp1WEtNQjM1bDJZeWJvZFBWamg1Y05WVmIv?=
 =?utf-8?B?aVVYVURHbFBFMmhFMldER1NWZEx3QVFXUkZoRlIyUWJJYjBtZklCWmZhenFU?=
 =?utf-8?B?T1FyU0hwYU5pdm5NSE9uSmN1RU5EV3dKak9jMkpqVlh4Z2pIenR4dHErNXE2?=
 =?utf-8?B?MENtdkcyZFRQTVVjUkRBZmRLL1ArTFM3dzQxNWdYbUZ3blJ1S1N1Mkp2amV1?=
 =?utf-8?B?eUNWaXE5anNzUGltTmpxVFF1VlQxajBXTE42ZWhicm1MSHdPZUR5V0xSVGwx?=
 =?utf-8?B?WG1zYkF4a1pIVVk1TmtGd01JRlg5eHFQcW5GRjZKUXp3dGZ5SXV6NXcxTUN0?=
 =?utf-8?B?RGh4UDMwdm9SbnJ1cFRCa2xSN0VlaWlZT1NIQ3BiSjJEa2orMnRwNHZUTk45?=
 =?utf-8?B?SkRTT2xGYjh6akNkN2xQQ2x4K2UzeXhhWW1tRVdQT1FXV1ZVemh5ZHlndlY2?=
 =?utf-8?B?a3krUkFEMUEyNzlaWUUxajcrdGNJT2l1dmZmcjljWjNRSWdkeHpSQzAxZXZC?=
 =?utf-8?Q?j7s+rac4h9u533vJCJ+4aSNvN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa60e76-ded8-4f93-7b22-08daf8472be0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:56:18.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EckjrVb83xkT4w0C/KeO0zjrrJ/C6MaX+VwOEcgP3GiQOql8RcvNgoUXohaWKuThOHws4TZ1Ee/JLZnGZ7rmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

Hi Robin,


On 1/13/2023 9:45 PM, Robin Murphy wrote:
> On 2023-01-13 13:59, Vasant Hegde wrote:
>> If IOMMU domain for device group is not setup properly then we may hit
>> IOMMU page fault. Current page fault handler assumes that domain is
>> always setup and it will hit NULL pointer dereference (see below sample log).
>>
>> This is mostly programming error and difficult to recover from here. Hence
>> call BUG_ON().
> 
> Is it particularly difficult to skip calling report_iommu_fault()? Certainly it

Not really. In fact initially I was thinking of logging error message if domain
is not set properly and return. But in this case we hit the issue because setup
was not proper (not like fault handler getting called before initialization).
But since we can't recover it properly I didn't see the point to return.


> didn't seem much of a challenge in 00ef8885a945 ("iommu/mediatek: Fix crash on
> isr after kexec()"), for example.

> 
> Otherwise, even disregarding [1], a BUG_ON() for a condition that's guaranteed

Thanks for reminding the link! I thought explicit BUG_ON is better. But yeah its
not a big function and fairly easy to debug. We can drop this patch.

-Vasant


> to crash right there anyway doesn't seem particularly valuable. The fact that it
> crashes already pretty conclusively documents the fact that it wasn't expected.
> report_iommu_fault() is not a big complex function, with only one possible
> callsite related to amd_iommu_int_thread(), so even with
> amd_iommu_report_page_fault() inlined I'd hope the stacktrace as below is
> sufficiently obvious even without logging an explicit line number.
> 
> Thanks,
> Robin.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
> 
>>
>> Sample log:
>> ----------
>> Jan 06 02:07:52 kernel: amdgpu 0000:00:01.0: amdgpu: SE 1, SH per SE 1, CU per
>> SH 8, active_cu_number 6
>> Jan 06 02:07:52 kernel: BUG: kernel NULL pointer dereference, address:
>> 0000000000000058
>> Jan 06 02:07:52 kernel: #PF: supervisor read access in kernel mode
>> Jan 06 02:07:53 kernel: #PF: error_code(0x0000) - not-present page
>> Jan 06 02:07:53 kernel: PGD 0 P4D 0
>> Jan 06 02:07:53 kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
>> Jan 06 02:07:53 kernel: CPU: 2 PID: 56 Comm: irq/24-AMD-Vi Not tainted
>> 6.2.0-rc2+ #89
>> Jan 06 02:07:53 kernel: Hardware name: xxx
>> Jan 06 02:07:53 kernel: RIP: 0010:report_iommu_fault+0x11/0x90
>> Jan 06 02:07:53 kernel: Code: 0f 0b eb cd 0f 1f 44 00 00 90 90 90 90 90 90 90
>> 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 41 89 cc 55 48 89 d5 53
>> <48> 8b 47 48 48 89 f3 48 85 c0 74 64 4c 8b 47 50 e8 ea e8 4a 00 41
>> Jan 06 02:07:53 kernel: RSP: 0018:ffffb9b7803ebe08 EFLAGS: 00010246
>> Jan 06 02:07:53 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX:
>> 0000000000000000
>> Jan 06 02:07:53 kernel: RDX: 00000001522e2500 RSI: ffff940cc09e30d0 RDI:
>> 0000000000000010
>> Jan 06 02:07:53 kernel: RBP: 00000001522e2500 R08: ffff940cc12c2b00 R09:
>> 0000000000000050
>> Jan 06 02:07:53 kernel: R10: ffff940cc021e000 R11: 0000000000000000 R12:
>> 0000000000000000
>> Jan 06 02:07:53 kernel: R13: ffff940cc005b000 R14: 0000000000000008 R15:
>> 0000000000000000
>> Jan 06 02:07:53 kernel: FS:  0000000000000000(0000) GS:ffff940db7500000(0000)
>> knlGS:0000000000000000
>> Jan 06 02:07:53 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Jan 06 02:07:53 kernel: CR2: 0000000000000058 CR3: 000000010230a000 CR4:
>> 00000000001506e0
>> Jan 06 02:07:53 kernel: Call Trace:
>> Jan 06 02:07:53 kernel:  <TASK>
>> Jan 06 02:07:53 kernel:  amd_iommu_int_thread+0x60c/0x760
>> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_fn+0x10/0x10
>> Jan 06 02:07:53 kernel:  irq_thread_fn+0x1f/0x60
>> Jan 06 02:07:53 kernel:  irq_thread+0xea/0x1a0
>> Jan 06 02:07:53 kernel:  ? preempt_count_add+0x6a/0xa0
>> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread_dtor+0x10/0x10
>> Jan 06 02:07:53 kernel:  ? __pfx_irq_thread+0x10/0x10
>> Jan 06 02:07:53 kernel:  kthread+0xe9/0x110
>> Jan 06 02:07:53 kernel:  ? __pfx_kthread+0x10/0x10
>> Jan 06 02:07:53 kernel:  ret_from_fork+0x2c/0x50
>> Jan 06 02:07:53 kernel:  </TASK>
>>
>> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/iommu.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 26c96b821fa2..2421acba08c7 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -558,6 +558,9 @@ static void amd_iommu_report_page_fault(struct amd_iommu
>> *iommu,
>>            * prevent logging it.
>>            */
>>           if (IS_IOMMU_MEM_TRANSACTION(flags)) {
>> +            /* Device not attached to domain properly */
>> +            BUG_ON(dev_data->domain == NULL);
>> +
>>               if (!report_iommu_fault(&dev_data->domain->domain,
>>                           &pdev->dev, address,
>>                           IS_WRITE_REQUEST(flags) ?
