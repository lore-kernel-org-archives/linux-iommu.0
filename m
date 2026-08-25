Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09A41F345
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 12:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787660490; cv=fail; b=Oc1n6M9/8NyzLfsw40/jhi6DcX48rqxveoRxq627P3BhjoD4ZouGVi7jlV2n6DR88EfT8K8eJSGToL3fU5vgvPraEdRf/UChf5j0ImQrk+hO3SPerbIgpVH0orZ6hvvbfpFbMm6zWrdkFEFITE46lVgre/n5DmAi2Ur2TJbcPR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787660490; c=relaxed/simple;
	bh=yJVDFxw4KPCa8sdiIPHDWZKR26Pip5bkWfN/O/Lqgjk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/QFkw1Rn+N2eZN7eKg7W3v8fVtp6j1pI51vaXmvSqBFhKw7zBCMjdYnwhfZHEKjrYAgSp1yyy5RzeeB2hlW/sDiLmS0NI6GGlmPJHzlSPuECxK1jnBonl3kSTlbaMZJTFOmHB4Y59Y7LlXXmk/vOuE+faGMQsAGL60gN6r723Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxoN3HgO; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxoN3HgO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIhihe+KoWHaBhYVfnAQacwnJ/k4f5QjibYC2uVY1xyBMoQnadR9rMr54td4cVa889HdlGloA9b+rU+svLH0Zq0DlIfLaXTHZsuDX//O81P98ZqPpVZlKkZ6mt2xuypJwiLnmd6oxMcyJf5P6kO3Gq7SzrvRe8n4R8OUuKL1zZGsKTMvPUizGyndGunodqIxQKg0P+IYTRiYdBh/0P3tpufoGOh90Wv1R5R7BiWGdbjSeA6RcwT+bA0NX1DOWo+sKj88UT0CKTYsBVZgNSw1N72bF9Hynh9kDOzqhP3/IHMs27aEVMHdjRcKmdZ4LxuD6kXq6PTMItFjzBnvNaEE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mrGFhCmLwqQVo4Ci6eFj/Qn1bAG5Sp7m6RL7RjynZA=;
 b=K7dcN5MVE7xW/08tQ47bN9WtTHZN4R+N40RlvO+xvHYvXGxWaMRjS5CXN3iPMKFaO8I12jhJWcd6VpWLu9So8pn/XMRkDmFY0bWrbFbN1YVt8nV2tN0n8Ya28W4pLOAYpXJfREl4WY4u9ZcM/fsSC0jt6kTyxBrXMiN9cMiwqH8rC0Gjkb9s2+IAbpZuskzjRhb5TRpvBJAmUQBhqg9BDmERnWN6A4EVBHQAxJqZqOwXd3WoVPVez1d5rgKgNebvAEjZbxIxKEoEysJuv0EKN46Qefh6mXpPRhUfbekQj7ERHcb8ODbzvtZzdCBcEFCOVBdA1tb7kqf/26Qbf9Ke1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mrGFhCmLwqQVo4Ci6eFj/Qn1bAG5Sp7m6RL7RjynZA=;
 b=wxoN3HgO3Tonkz4SI1XBYWX7QHMY/Xue4uG1330FUhUSfgYEW9W3QNRNlFWalhbSZWnK0/Cq4JmAhwEqxBie65/FGhLh3aylKza8hPhSiliWCIOWd3YdFO1BJX/Z0hiqDMYnvaoELh2QhLHrHiZq/sjQG9c0ZhWpu4jzr5U6MTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS4PR12MB9819.namprd12.prod.outlook.com (2603:10b6:8:2a0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 12:21:17 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 12:21:16 +0000
Message-ID: <1dbe374e-c5cd-4ac6-9ec0-c42b04e685a0@amd.com>
Date: Tue, 25 Aug 2026 17:51:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Do not reallocate GA log buffers on resume
From: Vasant Hegde <vasant.hegde@amd.com>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260819032349.20354-1-kmehltretter@gmail.com>
 <3fcdf5ea-37c6-430e-b1c6-1277008148fa@amd.com>
Content-Language: en-US
In-Reply-To: <3fcdf5ea-37c6-430e-b1c6-1277008148fa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS4PR12MB9819:EE_
X-MS-Office365-Filtering-Correlation-Id: f8bcd048-25c9-4755-9bda-08df02a35c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0TqZw/d9Y7Cc2cXxi1XLeuG9V6Wb5nFf1TqKCn91ABSDUXRGZY3g4aaJ3RVkGClUt8xVBqLXap5YCrHB35cGe7/p87XaB4pD7ZlcomMkuG2r0yHOOxw6Ft7mvmvL98ONRHQLVqeGr8Y/C37jvl867ANXshEae9r3pKxUKkKSxdcexRDpIKWBDOYiyozI6c2t+Z2qQeE1JF0J8fWpjqnF+Dr+tMBErHBnrdqDL3hONKgyLffr3TV3wHV+Fiaw09sPfqwbbq2DHX2r9D7Z8F9f0KmBzHEQQCg4FnKo8IYb5At48Ma8gMfjIkn5paU1AxuP453L9f88JGQRV4oGD7pB//w2CEuwvEx2VKNGwwD3X+Vn7KCxK7xyyZF46avmsLfvvewIIqWQuIw04npOVUAyB4dU2CdwKEPodTCCo3xe3FKniRQN5Is8L/rXHOZcKP7wsDQY5U+bBhuAHSpLMBRgdSfbT6RdpHQXPUSLp5Yt3hRMgS4YxQEdDTUbgoZJjEVURpNFVCeDn/8c7+1Ur0FjmaUL/FgGnd3ifOoKcCrEV4p3UstyoOarvInDR/HgttVmhh/XtZonRczUOgMBCiYh0Q3GHNCIeiFyiNr6/WeW4nT5WKmFdo+wR458YdPZ8B1GtkRTh9MCQshB5QWwgxMObgH4MlgI2nazKvgrlySG1co=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ay91YWFuZnlvSFo3M05RZVRyU0NFa0poV2xoemI2TThVWmtGUWhsdTRCTHFT?=
 =?utf-8?B?NVk4WURjNHkvcXdwTHFWeFN6WXJ1UEtNTTRxZjZ4ek5Hb05HR2ZLOEN1RVNC?=
 =?utf-8?B?L3oyYXQwa2FsV0s4QnVVOElnRHo2eEFvZzFJMXlJRklRY0xUQm1sSStOUHR0?=
 =?utf-8?B?K05FekU2UVdSVnRiQzJ3b1JOSEw4QUFiOE9JTkZuNktPWVhTRGtzcGVET1hj?=
 =?utf-8?B?TGpZT0Nlc2FGb1FsZDFKNjZqQXBsd2h2Y0o2WWxZK1pwaVZjWkpNdlcxWmxY?=
 =?utf-8?B?cFNqUmVub3R1RWl0bUhocUtFdXR4Y3ZnMzBicnhja1ZoRW1HdEtDcUhaRkRh?=
 =?utf-8?B?OEN6YURUQzJPaTZGN3Nobm1mOWFHNXNZVS90dnViQUdURmlHVld1VVpFMVdq?=
 =?utf-8?B?V2Z4ZGZhWjVyVTRLZkdXZldvekxYMjgvK2ZVaTFFME9zUzExRzlsUW5CK1pP?=
 =?utf-8?B?dk95Q1JYcnl6a2tPZjRJYU1uU09CQzBTS0N5YStjRkIxdDZsNWpRTk44U0tK?=
 =?utf-8?B?Mk80dTA0bXVvdGtWOWFNWjlHNXhBWmlFaWRKZWtQTktOUWJNT3JHYlhubmVu?=
 =?utf-8?B?ZTJOVHRINXBmMkloc2p3UjFONUVSUDh0dzdPKzJOVXNsbVNVWWF2MzdOU3Nm?=
 =?utf-8?B?bnJXTm9DbDRXbEhBVzhaUlpKcjg1ZVNVWU9tWWZKQTlVZW9JN0xzWmNya0xq?=
 =?utf-8?B?eTdjWjJVRC9CMHhrNTBaUThOc0l3OUFBeXpzTGZlcXIwZld2dUt2c0EwTjJp?=
 =?utf-8?B?dTIxYjdqVEV5cUNWRUwzTGoyR0JQUm1Bd3FTanlweVA1aVAzQk0rSTZzMWRy?=
 =?utf-8?B?VXFndWRXYjY1QXNKbmFGcmJPKzVYbXhsamVRb1B5b0dpSXBvUCs5MWNrL0tL?=
 =?utf-8?B?TnRRR1Q0T2haOStseDFRMUVocmxFTEJLMmJWcC85bzh5Zlk5Ry9CaGMxR2Vu?=
 =?utf-8?B?V2I4N1ZuaWhDUWhxVU1KWUxkdGU4MVJKUlIrc1JtTHR6bVhpWTZvUXBTQnI5?=
 =?utf-8?B?cS9CcXBRaGZaZXN2QTJIUzg4aGdSMkdKcEI5VGdXOUN6MEVqYk52eTJEMkZH?=
 =?utf-8?B?eEhXa2h6aGp6RHppdDhzNUdOQjdBZTVGbk9Ua0NldHcvQ1FtbldDQWNROHdz?=
 =?utf-8?B?cVRuS043SHVZN1ErUnB2d1RuZWRqdDl6N3BiNjZybDNaSkVBdUNVaTl5dnZs?=
 =?utf-8?B?Q2dqTUNwdi94bCtxclQ1K1phbUpvU2c5OVVhTy8rQ1JSeis4bUQ3N2ZBdkg1?=
 =?utf-8?B?WVJMSTFTQUZTMFpjMDJLOXhOMC9ZaW9qT3VoUlNLeW1RbDFWYUZ2OWdWT3g5?=
 =?utf-8?B?QlgrZnRaRkdtTzZtQmdDa2hneFE5czQ0NGpySEJ1UFdGUUdZOFhWUG0yN0ZZ?=
 =?utf-8?B?aktrZnZkbUJURjd0WHdZU0FNZjJ1a3RTMUkrNVZaWlM5ekswdUhMVlhNMzkv?=
 =?utf-8?B?Tm1vdThkdWlCaElCVnlkdGt0SVZaSjB2b2MrOTNUcjVJYlZqTHFPMFF4Z3hn?=
 =?utf-8?B?Q1B2bVBCZGFCWlhMQStpMGhZN3ZOTmJ2dFpXV3Q5bGdYNVk4VkhhcTdsOFdv?=
 =?utf-8?B?WXAvaXUwR0g1cW1NWmdLT0Y4bFczcG8wUHV3UEVrV1RtNm1FT3R3aEVuVXhL?=
 =?utf-8?B?NVo5RzkvbFdhOHIwcWxUQkZadGFNU1BIUzZJeEhWaDlWV0FubUtONGsvMDVW?=
 =?utf-8?B?RGhtUURUV1Z3WHhkbThlNkdpNkdId0J4dmIxczhRZFQyRGZIKzh1VWVua09o?=
 =?utf-8?B?WUNiYUlGU05iR1BwRTJoQVRJaG5QUHRZUmUrbTlpemhnQSs1S1RhK2VkTUxy?=
 =?utf-8?B?bEFiMFpkckVIYWJ0WiswdGZZLzNrQ05OeFNyVkN4N1JHeFppYkNNNStMY2hE?=
 =?utf-8?B?ZGdJUEFlbUNpMEVZTUpGMzJ0Q1FqTDI5NE9sVmlHYmhxWmhYbThsQXhlNmky?=
 =?utf-8?B?UkROV204WWFXejJYL3FhRlZOMmdRZVJFNzRpTGJpV0xHUmJJN2ZmWldqZlhZ?=
 =?utf-8?B?TUs3TW5rUUlrU2NjN2lURlBRVFZYTWhJQzRkb0ZmUW9zaUZ3eEhuOVpTM3N6?=
 =?utf-8?B?VWc1dlhJRXMyaW5zYTcrRDU0WVpZVVFRNFV3ZmQ0UE90M05GK1JidHdoYys0?=
 =?utf-8?B?VHZQVFh6M3MrcFpQRzJxWXdZUW8vZUt2eGZXMDBvQWo1NFBhM1d2NDRtVnFT?=
 =?utf-8?B?MXN6SE52Zzhna3YwQVlLQk9KMDc4aUhhQk5YNmZJcG9aMm5pZWRROWpmZWUy?=
 =?utf-8?B?Ukt5a0V3eHJ5TDl1cUh6eTEyNUk4SXFUaGlTZlRYR2ZoM2lOTW1Tck9uWUVo?=
 =?utf-8?B?SHlPUE54LzkwV2ZtVzZOakdxb0sybVo4aTVEWExvNW02bXFVUExTZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8bcd048-25c9-4755-9bda-08df02a35c6d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 12:21:16.4576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWrL0CknTJ8wM68ZSQu+0RNDnDi2yu5+hvmn5rbaSNr6KBKeTLHOIxfJYkSQZyPnyN3wttTvzL/irNoLa3eYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9819



On 8/25/2026 3:58 PM, Vasant Hegde wrote:
> 
> 
> On 8/19/2026 8:53 AM, Karl Mehltretter wrote:
>>
>> Commit c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC
>> (AVIC) Enablement") moved the GA log allocation from iommu_init_pci()
>> to enable_iommus_vapic(), which is called on every resume.
>>
>> iommu_init_ga_log() assigns iommu->ga_log and iommu->ga_log_tail
>> unconditionally. Each resume therefore replaces the boot-time pointers
>> and leaks both old allocations. The function also uses GFP_KERNEL from a
>> syscore resume callback, where interrupts are disabled and the non-boot
>> CPUs are offline.
>>
>> Return early if both buffers are already allocated. Clear the pointers
>> in free_ga_log() so a partial allocation failure cannot leave ga_log
>> dangling.
>>
>> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
>> Assisted-by: Claude:claude-opus-5
>> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> @Joerg, I think we should pick this for -rc.


Just to be clear, I have a patch to remove all these checks in iommu_init_ga_log
and re-arrange a code bit. But its slightly bigger change and backporting to
stable becomes difficult.

Hence I'd say lets apply this patch. I will send my patches on top of this patch.

-Vasant

