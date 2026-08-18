Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D527FB1C
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787035549; cv=fail; b=s4lvgYSO3AdPG7tRj50/1SqFbHEnkgY2kmq5gXGjc20gE17QYTCkFYgDE6OZMjztGGNbWyHU+K5pHBqnzrDZa7b5TIjB7zr6+djFyMSzOcIIZaUS2dRuWrL1yIbAjFHSoWxKB+jmfON8i6SrimXxJNntg9sZ4my+XyShl1KWBsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787035549; c=relaxed/simple;
	bh=j7AJ7omY59WuYxGiHbSshbjUxqCYkB/DPwoZdjeAsu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qXXrv/hwojjJdMbTq011ty0fsmWscD49QJwGPUF9WWd7a56di1GKZqKtr4hp9DdfHkcsqds3wwW6YO82HiU4wGAZZwMevljm9dCzlCzbO7kEOyXm5CyKE3HJafLjrhOKZ5cF+0UdkoXJS+hUxxIJN5k3heoV3fGJC22kab7sx5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioTLoi8+; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioTLoi8+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMWWbqcg0Bia8EQ+vppH3ZaWWV2bWoMeQn8B2EkVzadY93NEA4N7FdsMMYhOuVyTYwoK0wggo4nTTqDteypYzBf4x6ZLAWUWDWx7n3DJFKWaAb2vQSJRSIg2by1ZmjKvWuMD7QxWvVF3omTwhbY1DUIWBLyKXL9TytbKZM4F9Qa7ndHrSxdwIM3udrGDYfnErMYF9NJRg9/GYHSnQxMvvdMo/kfkW+7DPT/qyp4dNlC6el7T1ru1cwQIXMWEg/IrizsSkiyAaBkvAojRCZ4QziTO79Xlugly4yOdI4mVLierL6tbR9HXsNFx56k0H65hm5y4rOV2UeahUV46vYVIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIaaa6fCTGL6RlRuYIbjrZpxgaD1ARBXMhp8EGbcD5M=;
 b=BbsQvIsm5/mIpzhXMmuaJk4v3U31aJioE1/o7Z7QLBjPk3fslDQ7n7RCp+ro2scyFcFn53CRGIRuvCnOC/x83ROKmGt4fE73/XgXpzHqgxFcxl7fFyTARxgCQpae6cSfpH3Y/ItHzUJZWrvES5+OyDxomtZwITGYh1ExTIfccM/n1JKrjd2XPB9/9hMJ3215wwx6MAeJPQG0nhoNlLKgh6Qoi63rstlacJuEwvwIIFnmrHw2N1aXs+zr0otphv944zyHu1OcRms9I/qzY3zCAWUyxWFGclk0EtA0Zawn6d+fVxFyrXsqRvN+TWljsvTYyDJa6/nCeAm+5hNONHw1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIaaa6fCTGL6RlRuYIbjrZpxgaD1ARBXMhp8EGbcD5M=;
 b=ioTLoi8+JJX8/9MUob2oYsPBMu14jN+Cfl4Vq4VpqQREok9mbYNiSXKwM1aF0aQCCP7ynR4YrUPXfS15/di9hSQtfLeoqyGUd/TvcVuD/GW6+qMkM6rW6WUFWemThhzWJBWwv1ocjDsZiJfk1xkj8CBQ1m0RLoq4+YqFgpHPBYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Tue, 18 Aug
 2026 06:45:43 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 06:45:42 +0000
Message-ID: <5897c4c8-8c31-4821-8de8-5273bbb4ca5a@amd.com>
Date: Tue, 18 Aug 2026 12:15:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Usama Arif <usama.arif@linux.dev>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
References: <20260817160642.418302-1-usama.arif@linux.dev>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260817160642.418302-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0235.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::17) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbf2a1e-9718-4d81-c3ba-08defcf452ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LUDzNZ3gD6JSa+/qKgANqrpQ+VeCZlcnb1xXuXrOeOcY9PHt2zkDPprBU9dCHvSK4jmR9HYse/rh0dg0q8bxsdtpL2/wzVa9Hw1xZfHp1MVDglZ8JK/5jjbr7TjUymH9VZbrIZjN1D4UjmQherPyW0KYGVDg/Y9p/ZrSfXpIueFMt3NmY7fRau/4ir1sZBeMgZP3RXhlaJOHZu52Gcw8sFj/5FR39H2pscJ6YWl9t/sfDqRqMFs1laeO+H73hXSgItsKHTRCn+Mw3FooQEMBhUlIY7DgU6T+0kH/9+lXxlC8NjZbr+zBbb1faBy/n1BLMRoMVUtfZVUbtdiA8G2TSCVTt9F1pud3IsJc6t2efjVy3/NKiu2lgw/TIUhhCmcpAZYvrc7Cn8X3eGiU56y81IsL4mlh8V2gzhM5ds4CNnMFmyoypNZyATBcKuEu99A4xkV2v9r7fDMQ6msPtuwDdExycUjqg6vM4rwfngvBrApXBS3Kmm24tfRslkyJOchZxw96HI4hZbFfrOVjzRvVenPjq6T8pd6Qjgat8NQA4rHwU1MsKvq1pQ0y0++FYxzNI450M8Fx0Csk4HmKnITbqZHEP/srdxE8wHOi3xYQqpLadKaRYgqCVIBCGmGwr+XeNt76714Okq2BF6sAzaJmPFsHYIRb6cxOtk2hwa1e7XA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkF2akNZSFI4dzZCTnN2SjY4SFpXVWVNSS9SWWNjQmZVc0JFUytvbDRkWWdT?=
 =?utf-8?B?RGZaTFIvNVpTN0tDZFJjRDJtK2s2ZVBZdkZaSW5uM1lONG55TS9yRG9MWXJt?=
 =?utf-8?B?NEREV2dMcjJINnlxc25NLzVTSVhuQmU0NHdQUkJPd0thN0QyZTNZb1ArUVFv?=
 =?utf-8?B?bHdHMHpjeEtpR3BNcDhsQnJMZUdvVVpHT0kwVU5lUEJRTGU3cDlwMEJ2dE9L?=
 =?utf-8?B?eUZNSnlmcDlRRG9wZ3NYNWtDOVJEYytEdDhRUWdzVS80bmNyajBsMEpTSUFm?=
 =?utf-8?B?SFFWZzZNN0VJMFNUV0luaVE2aUo3cEpadEt5eENkQnNqTnRRVjcvNEloVEJ5?=
 =?utf-8?B?MDhjeVZFTkhMNG5EaXNPRUxZWVdGQmpFcm5CdFdIUUdhYzFoS0RveGo4TklX?=
 =?utf-8?B?d2RvNzBqMGlLNjdFTDRtQ1FyMHd0ZEFGTUtGSlpjUlJERUhuWTd0S2xPaHY3?=
 =?utf-8?B?dURXWVlEbGMxZ3h0SzhpZ1d3SVo0cXVlRTAvMXBFdXdmNWxvUFF3V1drY0NN?=
 =?utf-8?B?T2hVRXFNZDlWVXFUbXlQSDF2Rnc1QWxDYkdyazJLK3lucHJsd2JwbkdldDVM?=
 =?utf-8?B?cW9KeFdnZ2M2MjZEL1RJZjJINFB6ZlJNVGhwVTVKZ210Uk9naDA1UWZHTjRr?=
 =?utf-8?B?bmczcE5BVnNKK3VIREk1Y1BtTFFhYVpnYzhQSlNoeE9KdVd0cXRNMExKRE0r?=
 =?utf-8?B?eXl2TVA0blpNa0djSkY3VnZFbVNIQkNNaHJKY21rYjQyOFYreW1Kb2p1ak1P?=
 =?utf-8?B?aGd3T2tqYnVEM3R4bGVSQ0M4bEFURWR5WjlDOHhVdXBTRjdJRmJXYllLNjNk?=
 =?utf-8?B?NjBHc3RuVUhZdno3a2RYQ2Qra2sxeFRGTTJQbmJNZTdnNlhLaW9nb0tFM1Ry?=
 =?utf-8?B?amVETk5VaXR4UHBjaGp3YWhpTks3S2d2bGUrdjJtNmx1ZEJRVVB0MTFkUHk5?=
 =?utf-8?B?OWpGKzZWQlFZaWdCNlNkdWpIQkxVYXI2bkRnSkdjclAxVDJBdDZ6b29RS1BF?=
 =?utf-8?B?UmhZSDF2MWwxa3NzQkJpbWFZNng1QkVvOHVBU1BzUXo2Z1B6Q0h4ZWJ5YUNh?=
 =?utf-8?B?anpvMzlHbWZORURtNGhzZWxYTFU4U0hDbWx1U3UwdW5McStrQ3c3c1RFZko4?=
 =?utf-8?B?M0RzTWdORFFIQWRiM1BHcDBqN0lLQzAxbHpjMU1LNUliMm44Q1BpU08rZEc2?=
 =?utf-8?B?VmgramFiZHQ1SzZwczltc3RzSHhSWUVCaDR4bzZ5aXNleDJQT3lSWE91eEFC?=
 =?utf-8?B?SElhVUp1UHFRVmZMZUs4Z2prQjNsaVAyc3ByVVJBNC96eWNqZE5JZDBSZDIx?=
 =?utf-8?B?SHgvNU5HZWtuV2s1NUx0b0NLNms0cDhwNUEwa2Fsc0pWbS9RSEJoWDdZS1VV?=
 =?utf-8?B?cGFLUW96ZU05ZFFEVEZpS1k4UzNHR0VqbUM3SmN0dEJCbm1uSVJjRVdndUVJ?=
 =?utf-8?B?T0JSK3pPc3FCQXVGU2dYd1FvaURLZEs5MHVVNlBXdkR1ckx2SFowMmF2UkZT?=
 =?utf-8?B?OXZnTEtxSDR1b1B6MExrRjg0TXBxb0plbnlNWTE4ekJqNjA4a0xlcUZBaThH?=
 =?utf-8?B?MHlDSkYyMzUrMXRIVUpBRnpXejlYNVlBU0VOSVpBN041WnRmcFNCa3BOZkM5?=
 =?utf-8?B?aGxRVnFyT3FuL1BSVXArN1JWMzA5TnRPQmF3NU0xVjRtSjkweHNqWWc1SjFh?=
 =?utf-8?B?TTRQRThwSEFaT2h4TWUxQVdUS28xN2d1NCt1VjZSRitLQVZGTEFDaFdCWFE0?=
 =?utf-8?B?SWZXSEhFK1JjYnBYMU4rK005emJIWEZmeTV6ZmNCcTRhc1hPU2xPSzE4YWZv?=
 =?utf-8?B?L1hkdVdoQW1UZHhOeTNpQmtRUWhCVmswYXU2TTJHNXhLSXVDcVJhZXBrMlhw?=
 =?utf-8?B?L2JTQTdaYmxoeGkxVEJWR3Bmd1ltRHc1blVwWWdUbzM3azg4NStScElrTGtl?=
 =?utf-8?B?Ly9EYm8rVGJzSC9ydDRCOUFRd04xWTNNYmxnb1F0bVFzV09NSWt2eS8xUCtk?=
 =?utf-8?B?cjZWekp3amRmU0tsd3ZKOWVzZEprcmxxTG9oL3VhSTdoUXhUVUVnTGdUZU1N?=
 =?utf-8?B?aDljZlVPYVNiT20wYWRPWGdnWXlDSXc0ejV2RGcvZm5oQXdYaUx6SUUrQ1VH?=
 =?utf-8?B?ZWdYeW01SWJJa1crTTVyV0l0WjY1ZzM2NXN2OThQZTJiS2lVZlVzQ1JxUGxj?=
 =?utf-8?B?NXlTSkM3cFNlNEtyM2pNSmY0YW45dll3TjRiZHRLcnBwcUxxNllVZXErV09L?=
 =?utf-8?B?aklJclZuTnJQd3ZwSUVHdXNPcU1KeVhMYlpEVFJmbXVFQ2tUak1rcDF4VHRo?=
 =?utf-8?B?UmFYTHNYdHdveTVkMUJUTVZTYzdDODNWRnFhTlBaUzJCMEhpWExIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbf2a1e-9718-4d81-c3ba-08defcf452ec
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 06:45:42.8402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcT4ZdnrZWLETAIMHbiejHf3b8SawbblP5vw5/5bKuUMQJXGezzbPiMhpueZzUG3T179sYwDAL+0hrP6zOB2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792

Hi Usama,


On 8/17/2026 9:36 PM, Usama Arif wrote:
> On Thu, 13 Aug 2026 19:28:55 +0530 Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> Usama,
>>
>> On 8/13/2026 6:48 PM, Usama Arif wrote:
>>> [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>>
>>>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>>>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>>>> on affected CPU families when SNP is enabled.
>>>>
>>>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>>>
>>>
>>> Hi,
>>>
>>> This series seems to break kexec in our production on Milan hosts with SEV enabled.
>>> This is on the 6.18.43 stable kernel backport.
>>
>> Do you have dmesg?
>>
>>>
>>> If on top of 6.18.43 release, we revert the 2 commits, i.e.
>>> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
>>> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
>>>
>>> kexec starts working again.
>>>> Could you help in fixing this issue?
>>
>> Sure. We will try to reproduce it internally and get back to you.
> 
> Hi,
> 
> Just following up, were you able to reproduce this?

So far no luck with SEV and SEV/SNP.

> 
> I was able to trace down the hang to this do while loop [1].

In allocation path, we explicitly set 4K pages (iommu_alloc_4k_pages()).

If SNP is enabled in host, then in shutdown path, amd_iommu_snp_disable() gets
called and it tries to mark event log memory as shared. In this path, it calls
rmpupdate. But I can't think of reason for it to hang in the rmpupdate loop.

@Tom, Ashish, Any idea?

> 
> Could this be a firmware bug? We are currently running 1.53 (below
> shows up in the dmesg).
> 
> [   22.245942] ccp 0000:41:00.1: SEV-SNP API:1.53 build:5
> [   22.308933] ccp 0000:41:00.1: SEV API:1.53 build:5

We are on

[   24.783307] ccp 0000:46:00.1: SEV-SNP API:1.55 build:29
[   24.844646] ccp 0000:46:00.1: SEV API:1.55 build:29

Is it possible to upgrade BIOS and verify?


Can you please share the dmesg of the booted system (before doing the kexec)?

-Vasant


