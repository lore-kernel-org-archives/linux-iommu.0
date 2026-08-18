Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210235028C
	for <iommu@lists.linux.dev>; Tue, 18 Aug 2026 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787063391; cv=fail; b=GU4E0CllF/1Ea+kjo3vmD2kAJ7bHpi7dCUJ4/0QOtzUO4XG+Uh562rtPiOIcqgNVuncieFB18AzpwUh9cylSGhoipW2g2bxiCyqZ9owWrcgLVaum8xZxRVxTAXkN40G7NT8YLX7DF3xu/RUySFF+c8mdCBKufBeyddP6Oyt/CLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787063391; c=relaxed/simple;
	bh=ne4uojYhC7rVLIbb7CvngbUJ2X31h5NrdZTQxvnyobQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fv7ggQNIPu6aohPw3GWwKQtW4IItJJdjC2Z6OHNWgUMhav9BrJKZgjJ2rxGuuRojgnyQVJOBhZKfLMYMUAf+ruqinf+qt9qJ+SFfqmdMXTjjuK1FWEiV/4xybfyAz7eVPY6oxnndu9mnQ8YtAQm1LReRd+rALQYS6CrxyPVPRb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YnQNqu4J; arc=fail smtp.client-ip=40.107.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YnQNqu4J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRIc6fZOuE+b5Z4CUCGQ00dVIgtMP0ClMGmL1sJsHfaplVdZgGWkJ/Xfmn5n+fTpl9INcE3Z0wBfzFUc77/NxlbzrZ0kjxNnS2lfm05VRXTslCiwSpky/jrqmdCJBuqKAwCJnxPDXHhIyQSEmnlj42Yo63jcZOSsYgUdASyOFIfLDcR0QZOnNxMvmHNMWADxsY5YSJBc5l1wOhpRGkmaisB7kPG33U0spzYz4L4C1NK72WG30tnHiS8j1FXV3xIMeAgdkZ6buOZQtJA2NoOmjMPSWcdDpXcrtaQGpu30AQfW0GRGBvNq8N+I189kSBQ3+Pa+tucSTBpFNWfdZ0fM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BobVKsaJOrt22i9oDa6XkPJ7KQmeVA12iUQUvmTcxDc=;
 b=wRcdYRqlojJuWkgIvr6JMvxD5LU+yOaOIVXeluK+dbL2icemduxWwwTg2jBRGbeJI+llDeKfHoHAWnuUzp3QruBlRndmDpnDh45GAe8j+/Y5dHwzRXbcww79+DrPDoRX/S+fpZxnL7ebtPef3Gi7W/bgngji9knu5XzfUqW3f08AwgFZx5H1i0CUfru2enD7Uh024Fnh4Oygrusjcqs7IPHhwxcowBUiM/53hISr2mYxJsgLq4L+ujFdX5rWbgoEp0T6R1U0eOp1vBuJXZiQy30oIDSutY04bKGBTJCnV4lyDF3fJKgzCu7zfVAO4V2fecJBuhnyhPO45UGweCy76g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BobVKsaJOrt22i9oDa6XkPJ7KQmeVA12iUQUvmTcxDc=;
 b=YnQNqu4Ji+wByg9zt6q28K4Y+YRsS+ydAU0K8dWWPaQdIcquQQfnFn31qsLZYvT4E1la9iYUQWVuiM/qQ/h/FGT9964o4arkpiAeFlRUcFUIbhGU+ytftrky5izg1Vx1UnhrJJJ2Rxs3QleDtDECF1YVfms2QKn7uJv27AFeSe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by PH0PR12MB7931.namprd12.prod.outlook.com (2603:10b6:510:289::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 14:29:34 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::c2dd:62c5:67fe:aa46%4]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 14:29:33 +0000
Message-ID: <409d4308-22ca-4c78-b921-e8fc98f55df7@amd.com>
Date: Tue, 18 Aug 2026 09:29:31 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iommu/amd: Use MAX buffer size when SNP is enabled on
 Family 0x19
To: Vasant Hegde <vasant.hegde@amd.com>, Usama Arif <usama.arif@linux.dev>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, bp@alien8.de,
 Joerg Roedel <joerg.roedel@amd.com>, samuelcrossley@gmail.com,
 "Srivastava, Dheeraj Kumar" <DheerajKumar.Srivastava@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <20260817160642.418302-1-usama.arif@linux.dev>
 <5897c4c8-8c31-4821-8de8-5273bbb4ca5a@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 WiyqywZI5g==
In-Reply-To: <5897c4c8-8c31-4821-8de8-5273bbb4ca5a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0018.namprd20.prod.outlook.com
 (2603:10b6:610:58::28) To SN7PR12MB8131.namprd12.prod.outlook.com
 (2603:10b6:806:32d::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8131:EE_|PH0PR12MB7931:EE_
X-MS-Office365-Filtering-Correlation-Id: eba314f2-d093-4f53-e0db-08defd351f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|56012099006|10067099003|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/LSDxJ50oZAiSiv+yM6H/T2mstXcybEjaKogDqZ0cVDKfWCDkAcwcJ8K0RwOjuCAQYec+f7bmfYiAa1SK3jMQUFnvxf++W32ZGAqzXH0t1aCklVMT7q95TLXt8esaCOwIJARn25YXIeAcSR4Ls5KC5dK+Nz6KZaADpwu35VZrrEtApyLoYU64yO+PQCgVl2CDm3wcX7QwSQ1sGIHsYbzVELYpzbkNFYWsFJ6LBlzDP0dTMF11b8utEzaaJhPhB7rfP2Bcj8lAuiUUutZFdXU6hQN/hZCe3U2upq+VEX+5CDW/19ypi4siLx0K0P+/iR9l51ORzRrHjaa5t5yxTagq50000L2/J+SvRuDZiIseYhMZUjWtFxkJIRzQy0iJ1CJWoNfaH3jzYOfPGXe+U5uB1Iq4gS3pSJs5cQNiocLn6aKf0w8DlgDLKkoRqgHB0emwJaeQJ+CvNV5vcnos9F36obMHQ+MvNT2IzizUKL/DJg/7s22uX+JnM1nraimS975FVa9edST+GhX3PKdAd1IME6JVWofAWeGzdgm980pSCtF+7mW2faSf9mi9EJKn5FwuD0X1sJLnyawJOVUOytBz5cPl25vHzNwLvmUdY80hHT1zeVEIQY+ToqWBklsPXP8+xc1KzfpBrZeACsUmeGF+1+9I37U8ZPB0+LsL0VYvrM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0dPNmxJTzNrbXZ6ZHIvMjdURXNQRFVEMGJtVzQzOWNaTWQ1VFdIVE9XVFdl?=
 =?utf-8?B?RktjZ0oyL2VSWWM5OERMNUFFY3NMSXBJaEhyR2V2WVhFSmlIbTBUVDAySml5?=
 =?utf-8?B?Y0JuaDNRMzdYVnVGSjhoeWg5Sml0aEpqZU1CbjZuQ2JKczQySXp0czlIeXdI?=
 =?utf-8?B?dURRaE40akZpbU5PYVlHaDhsbTUyYzg3L2NwWWtJR3owN2ZTNmVoRndhKy9a?=
 =?utf-8?B?bDhsM3ZtTnVMQ09DTlU0TU90bDFMSnUzUklSdDcvbC9uMklqakVqM1BCNjVw?=
 =?utf-8?B?bGZ1UWZjYUR0dzFZVG0waG41a0JrOFMvTkRyRWYvdUhvenhLcjExdUZkenly?=
 =?utf-8?B?b1pTUW9HLzlmaGJFZ1lUUis3cUdyNFNYWjVyWWpVajBJS05zd1JoYm16cEJM?=
 =?utf-8?B?UVk5N2NQaWZGY2dqL1ZmYTN2TDFEYUxMNFQxYU9saXJmSll5eTkweTN1UTkv?=
 =?utf-8?B?TzIyVDV5aUdCMkNLWnRqc3RWZmwrODdyeWFTMit1R2FhWDN2Z29yQ3pNVXdI?=
 =?utf-8?B?dEYwTmhwT01LcnovazRCM2NwKzAwQU5qOEdFZk9oc0hUYWhmeG5kV0JVc0xY?=
 =?utf-8?B?cjJFZHVOdTJGVENuby8rdTZvK0tMWEJGVytYb0xKWXVudlROV2dhK2l0Z2hN?=
 =?utf-8?B?a0ZZRzc1SjFjcEN2aW9OWUxNNlVGTFZNaGl1YldVT1dQZXA5VWFXeDBtWk91?=
 =?utf-8?B?Q2VNS0xXL2ZYK2pSV3dwN1Y2K0ZZUEx4SHhDWHl3NlJaQnNrRVBXeUtxaTNH?=
 =?utf-8?B?cEpCUW84bFBzTytPcktpTlI4VEJpTG5Rb2l0MW1RTWpsTWo3cGlMdXk5QzZr?=
 =?utf-8?B?STg5blM0VENEK1p6cVFNUDdtSlliaFdlcm9Jck9ubHZTRHhrTGhqRndCUVk2?=
 =?utf-8?B?eVRIdEJzaTBkbndkbDhwekc4eHFsWUFabm95N2V6RUo1MWR5WjMwN0Z1SXpO?=
 =?utf-8?B?blc4dVErc2lwbGc3MXdEdjh5MVZhRmFsbUtmdmpWV3ErRTFzOEFneVJ4bmEy?=
 =?utf-8?B?SWpyY0cwNGZGSkhVOW5iMEcyM0ZkdWRtOVpkTGNnSTFvdmIzODlJOUlGdTUw?=
 =?utf-8?B?emxWSVJrL3Znc1J3SDZtWUVQanJoTlV6RWFOOFMyQlByN0lPdVI2SHlZZXQ5?=
 =?utf-8?B?cDJ0aEJTTkErMVFzdUE5YW1NdGdkajNueG10R0tiUDZPQ2l0UEhySXZZWGhr?=
 =?utf-8?B?Snc3YmxDMkcvcGxJRFlaSjBab1dBZXNsWmhHUktod2ZXNEcwdDUrWExuS1lD?=
 =?utf-8?B?dmlQUCtGL090dSt2bnIrbk93WVNQNlU2bHZoTHRXNDROSVpybDNoWDA4QjZp?=
 =?utf-8?B?d2czcmEzWE9GeW5ZMUR2bVNJR3JWOE41V2ozS0RUTE1xVkhEWUc1SkJhNHhM?=
 =?utf-8?B?WXhTUEwxRkkzSURObmV0MHhwQ0JUUUlLVVJNZGRzTXduZU5PZ3pvTG1VUXlG?=
 =?utf-8?B?aUlERk52Ums2cnZhRUU1SmFjMUZHOVZLbDU0aXZsS1BLUFUwRkdTUmdrTnZS?=
 =?utf-8?B?M0c5cVlVQWY4enowS1U1Nmt6RWcvNGU5M2xLR29RVWh6Rk0xQ2M2VlFaZkRS?=
 =?utf-8?B?RFhJaGVOdGdDeXBKODczdzNtalAzWTBJcVRXSmFtV3pCejFkZHRYUkVGWTlp?=
 =?utf-8?B?OTkybldacENqckJFTnFuTU01aXh2RDNhTExUeDFNOGU2TmgxSFUwVnh0Umor?=
 =?utf-8?B?SEFWaXFDMmcybWRpczVGdFhMVDB6dTF6SFdpbGZNTE1SQnNnZVhaa0ZVcGoz?=
 =?utf-8?B?ZmNtcmxFRFB1RGRZRDAyUndIK05qU0VvVlRzWDJkOFhoVEc5QkIwU2g3UVh2?=
 =?utf-8?B?YVhQVXJPZWlxTy9HZUNBOXFtK3l4c2tpcHp5QlROMW9QVGNnd0dSSHp4Y01X?=
 =?utf-8?B?S0lWYktiWFAra29QK2lpWjdFSXE3cWVOc25YcUtGVHRDY1RYS1Z5NTYvV2ti?=
 =?utf-8?B?dncyelprT2VzdmZOZno2dnhYUVB0T2ZYY2NPZVgwSVEreVlIV3Nkd3daTXY4?=
 =?utf-8?B?QkdXRlZ5ZWZDZ0thTjJ2c2w5S0NNK2hsMzByVGJsU2g2UDI1bEhlMnF2Ykdn?=
 =?utf-8?B?M3B5UmdnYzd4ODF6RjZPb0RmUm5yUkJvemZLbVBMVkFvem1YS2grdzJYeTZJ?=
 =?utf-8?B?M2FhTG4zOVpVYmxUakg4QkpBNjB4QkYwNzRPbnVVMHIwQm4xZVM0Q295azNa?=
 =?utf-8?B?a0lZWXUrNVBMRUhDWTRQSjZ1d1JDNFpqMThRYzZkdGVQRllSb3JZc215VUxX?=
 =?utf-8?B?ZUk4TWFEM2tOTmt3TVRIY252blR1dG5RQjZpT1cxNVdPU2FGYlVhSHBxM0ZQ?=
 =?utf-8?Q?72PeUWaXeeLi+TTzBJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba314f2-d093-4f53-e0db-08defd351f74
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 14:29:33.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7euaFrAm7pkMYQJLBtqV0HQDQK0+MeIgE408l1L6+84rjoF/9IARnrt6GdPK7R03TzxMOUiDvL/rgNrLRKhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7931

On 8/18/26 01:45, Vasant Hegde wrote:
> Hi Usama,
> 
> 
> On 8/17/2026 9:36 PM, Usama Arif wrote:
>> On Thu, 13 Aug 2026 19:28:55 +0530 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>>> Usama,
>>>
>>> On 8/13/2026 6:48 PM, Usama Arif wrote:
>>>> [You don't often get email from usama.arif@linux.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> On Mon, 20 Apr 2026 08:42:02 +0000 Vasant Hegde <vasant.hegde@amd.com> wrote:
>>>>
>>>>> This series addresses CVE-2023-20585 [1] by increasing the AMD IOMMU
>>>>> Event log and PPR log buffer sizes to the maximum supported value (512K)
>>>>> on affected CPU families when SNP is enabled.
>>>>>
>>>>> Use MAX buffer size when SNP is enabled on Milan/Genoa. Impacted buffers:
>>>>>   - Milan : Event log (PPR/GALog is not supported when SNP is enabled)
>>>>>   - Genoa : Event and PPR log (GALog is not supported when SNP is enabled)
>>>>>
>>>>
>>>> Hi,
>>>>
>>>> This series seems to break kexec in our production on Milan hosts with SEV enabled.
>>>> This is on the 6.18.43 stable kernel backport.
>>>
>>> Do you have dmesg?
>>>
>>>>
>>>> If on top of 6.18.43 release, we revert the 2 commits, i.e.
>>>> Revert "iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19"
>>>> Revert "iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19"
>>>>
>>>> kexec starts working again.
>>>>> Could you help in fixing this issue?
>>>
>>> Sure. We will try to reproduce it internally and get back to you.
>>
>> Hi,
>>
>> Just following up, were you able to reproduce this?
> 
> So far no luck with SEV and SEV/SNP.
> 
>>
>> I was able to trace down the hang to this do while loop [1].
> 
> In allocation path, we explicitly set 4K pages (iommu_alloc_4k_pages()).
> 
> If SNP is enabled in host, then in shutdown path, amd_iommu_snp_disable() gets
> called and it tries to mark event log memory as shared. In this path, it calls
> rmpupdate. But I can't think of reason for it to hang in the rmpupdate loop.
> 
> @Tom, Ashish, Any idea?

Not knowing what the physical address is or what the RMP state is, I
would have to speculate a bit. I wonder if the memory is now PMD aligned
and marked as a 2M page? In iommu_page_make_shared() there is an
explicit check for the level of the page being made shared being greater
than PG_LEVEL_4K. If it is greater than 4K it does a psmash() and then
continues. However, this check is only done if the PFN is not on a 2M
boundary. That could result in RMPUPDATE returning FAIL_OVERLAP if the
RMP has the range marked as 2M but the request is for a 4K page.

What happens if you always take the if path iommu_page_make_shared()?
@Usama, could you try making that modification and see if that helps?

Thanks,
Tom
> 
>>
>> Could this be a firmware bug? We are currently running 1.53 (below
>> shows up in the dmesg).
>>
>> [   22.245942] ccp 0000:41:00.1: SEV-SNP API:1.53 build:5
>> [   22.308933] ccp 0000:41:00.1: SEV API:1.53 build:5
> 
> We are on
> 
> [   24.783307] ccp 0000:46:00.1: SEV-SNP API:1.55 build:29
> [   24.844646] ccp 0000:46:00.1: SEV API:1.55 build:29
> 
> Is it possible to upgrade BIOS and verify?
> 
> 
> Can you please share the dmesg of the booted system (before doing the kexec)?
> 
> -Vasant
> 
> 

