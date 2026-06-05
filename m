Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010045.outbound.protection.outlook.com [52.101.61.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AC28B4FA
	for <iommu@lists.linux.dev>; Fri,  5 Jun 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668349; cv=fail; b=RcgBnMDb9ghy8GPa/eyoDN4HZopnIGRn24hA2CvmmIyqYu6lhHMrJW3Nu0abYVfBvDsie5aizkIgKP+OcsQk4BzONDLvB0AXwOxzdMlBeh/ovE8HALDr7Wr3RwHe2fg/XnwlGq/sPHPfRAdDtd7rJubOLI6LToYG246n5JApQ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668349; c=relaxed/simple;
	bh=5BX1wT9Rwal+GULdUo4MMZxYXmKwnTxZPzerko5bXdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B6CQORNFArqzFtPxDiVfMt6nWVLs9aJ/JoHxlaa2ezoMAFzfD393aDQBrvByns/VFPrRdOh7OKb5iD3lVgtUogIsCR/lc3lLYnZianeEbRFLLaksNHTwu88Z+bMfYsJCj1FFm1Fx2bhBMJBEf0b6pTyv3TeFJsyz4xjEbYKea1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EVbzSUBa; arc=fail smtp.client-ip=52.101.61.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EVbzSUBa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2TFeEy4SFfSWLUMwZnu6zFpONFDfp12e9Gn+V+QiI+HDFdUHE7USd5WWQC0jyP5TnoXvmgIHjBucxVT/sUiTe4b6jTbVLIDngtnxRYbF5Y4eK1Q6mm4i1U+UpGsZEVsvre6ekQX9SWHwYogCyXQBlSqKYviGII6Va37HBO3qZUJp25PTQIYf4vAqGskoWnXlO1xEBXO0BIhe9rM3ba3GlbWcM90MxpX9qlZubUU6oQwk4sSd/0GvAjtcmB4DSMfHBh8oasS5sZh1EQKmHuV1b4kwHQT/jBX0bVFlyBluV5eFTVZet0FA3nKENwdq9q11+PLUfbkMeX1ztxENfVRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSOl9WNniV2Hw+VGcMOMm86Ci9J9McaLNuyFfQBI9PQ=;
 b=hugoggw8BZU6K8vbUlS/Bq0MDTgwW7D47Q9NNzd2o0HcFL6VWnCEYXAuxrjd46dgJI4W96fmI+XySu6CigFzCkbi10BUQf8CeUfW+yIlgj9ylXB67C9ywoa+iIh6h/1v4B+H9h+G8txaeBoEHJuVqqgyztrZjSRGWXJ+NTGpp4GEyhUTMxJYDdXHzhLJOOajdxNSdWYqAcCCtv/ZRL7gFuPaoL0dIboC98Vahy9N1sqfGS9Rgs4qMxNndgCo8aS23Wa/D8/AgTPO6e3yq5qVzfxkEi/MoXsmG7tBgziu72paThE0LkgCN1y1XVRyZpJ8kOHLuvHBUq2z8Pr8gnuAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSOl9WNniV2Hw+VGcMOMm86Ci9J9McaLNuyFfQBI9PQ=;
 b=EVbzSUBacgrR/xETMLA8YnRPhEOF3XXamviZjglmibMn0Wfe8QKdl+7WvKKSFniHzlAo3pEaOJJpzpT6v6g/ZL9ZFa1XqXC9U3y70A9qEM6fsqasGjL+DVvhNdBMKznyNGkAoM8Mix2er/sp7YF5wkPCQzEVBOMSk5p5Ec9Fc1hzQlPLbRgLFs/qvtpO4ZBC5+4hzCTCGUZlttsHLmvuAPnpNDKyNHXaVf7WxQDdofEWUOyaDE6K9N8FVrcsK78XP5aQ47fbCrtwEPQlkHARRn035m0jMC/jNv6tIU36ddi9jIAVW6RiuXdm57Y4QShhCxjRH+6r3Fle85oH/7s0EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN5PR12MB9511.namprd12.prod.outlook.com (2603:10b6:408:2a9::14)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 14:05:43 +0000
Received: from BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c]) by BN5PR12MB9511.namprd12.prod.outlook.com
 ([fe80::4d8d:5f91:6c3c:dc8c%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 14:05:43 +0000
Message-ID: <09a501ff-d1e8-4035-95c1-a6df9f0cb9d0@nvidia.com>
Date: Fri, 5 Jun 2026 19:35:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
To: Will Deacon <will@kernel.org>
Cc: robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, nicolinc@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-3-amhetre@nvidia.com>
 <ah85c4u011WNJQgE@willie-the-truck>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <ah85c4u011WNJQgE@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYPR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::9) To BN5PR12MB9511.namprd12.prod.outlook.com
 (2603:10b6:408:2a9::14)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PR12MB9511:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bdae32-137b-4ddf-573f-08dec30b882f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|11063799006|18002099003|22082099003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	lojocUIQ08rjCz9RDuWDUg/sPVdX9NjIbdTLZctbJ/95MBC0oLcSAbr8F6rDkrLe7xSlJFdjme2AWatff2XXhchhcGxa8Zp1zOcLML2e3SlL4INiEZiTJGmpJn+iHC6SV2IX4gBcQdJhUXZLup5BkC4H/kvjWfNL0IkinNbi5Rxj014jDui3xkQGHY5MBlLeNnL+bNGDDYDCsC54em4A4B0XF/NcDA+q4dqxzvgvWUqJfIRLVuycJGMwTZ0Uxde34CTNEYFj8tcMAU1lJuxCnjpNBaTinmm2bSwlu2QXCLrYHYMkIeex8yXhs43DAf1RZYq6d1B+T6TAEjfZ68bSNYip11vtfYnykd0B612jRJjd876G10jKhFGyVLHG4MBJlJiXhV3Zxg7tXh+Iz3s8wFTFKZnaQSzRf84ppnb3tUVdupHphJBDZ8GLDV3b6vnoRR5vVkQWBNy69zzKSmGHQ8o7qSuWCNR4y5bGVLN2vCPA9JSWY/MdQyH6+xazDGqoKVtvCGItpQHzsZq2WugunAt1v/Mcng7p6+iCG75+Xx28mnkn3zpzJ6Ohn26Sc+VDlZ/lK7vxumiwKaNvGRiVxnqf66kO0nnD4NafO4cFWWGzafzXRMl+xfFq56Hl4D41WUSiVj9IgkTUoKd8MoUHqGhm1f9XdbSX2X7PBwGZxs9VdVW9NeLE/mlFA5Yq4Zs1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN5PR12MB9511.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799006)(18002099003)(22082099003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmJraXBRSE1mME9adG1raVRCdm5TYno2MEUwVlJvMlk3N08rQ2w1ZzlDY2FE?=
 =?utf-8?B?TXdJYVdUUnd2NFZEZkk3ZkVUYlFPUnoyVmY4ODZ0d3BFbzZJQzQwY0tMOVZw?=
 =?utf-8?B?MDZoaTFXYm5jSndZZm14UXprMlJpSDhLbWlRaXVpZm9aZ3gzTXBPVEhReWF1?=
 =?utf-8?B?OG9ydlZmaEN6SC9ZWE0wdkthQ2NxdWFKNjAwNy9XMFdTTTQ4RGJYU2tHRU41?=
 =?utf-8?B?SkdwamJjNFg3WWFnNGhQTmNHaU5KakM1WWxyYVFhTG9qck81aDJtV3U1dmtU?=
 =?utf-8?B?WkRhZi9pMlJ5T3k2RFc4NC90ZUdSMElNVjJJaEg3VjdjbHFBYkxic0taNldG?=
 =?utf-8?B?VnBNN1N5M0hIcmtlbisyVHVDR3BsMXRKZzZFQ1JWWUZCdTlIOGM1RDFValN2?=
 =?utf-8?B?NktOaUtWa0ptWUtTR1ZPVG9IY3Z3NkxqL2RlSkphUUtteXY3MGlHelJBYUox?=
 =?utf-8?B?Wmw2bHFlZ1JjYnNTTU45LzZLNnFxM3hCdDNBM1YwWHhUVFU4Z29rMmhBUjF5?=
 =?utf-8?B?Wjcxc2d5bVp3MkhoNDM5RDIrai8rN0tJSUc4QmZwZTlKYUZFYjN2OHNvUDhh?=
 =?utf-8?B?dWMzbWVVZTVkZVFLZlkwMkt5UXN4bzVObWpGQVdSSTNpREpNbk9JaWJnbzVm?=
 =?utf-8?B?NzVZZWYwVE40aFlMK3AvaU9kcUloMXp2SWlScGJaQkc5SG1jS3pNWFdOeE8r?=
 =?utf-8?B?b2RYT3pwVFZ4d28veGR2eUFkR083Z2RGVHM2WjZKSExYY3F4N2NZU3hKNEVa?=
 =?utf-8?B?MmFqMzhWdGpwbVB0VnRRSTA5TGJTSUJqT0d5SG1kZGY3UVE1R3YrYTJlcWs2?=
 =?utf-8?B?NUVaQks1Nzk5L0ZZNlVYOGlOaFM0K3pGcDhKK3R5K0txblB5R00zc1o3QWlD?=
 =?utf-8?B?L3FLMUVLYXBBa3RTQmZBbzBUNEpqajVtbnlBalB3UDlNYkRRNE5TbkJ4cVBl?=
 =?utf-8?B?RnorQnZyWU1yOGk4bUFCSzlsaUV1aDVpc3dDbUV6UUxmdnMzakFyVS82dEJk?=
 =?utf-8?B?NHlDd1lVM0Nmbmg3S2IrMVdQRmtTYkhTdEx2Y1hXZHo5VnlZeG1VbE5SbFBI?=
 =?utf-8?B?dUJwbGxGNW1xSkJZcTFMVTNYaGs2Z1o3bGNIV011TlZ4blZ4UjNXeVYydjRC?=
 =?utf-8?B?NTk5U0RYQ1AwcWNyR0NXenNDNDZJVWFCdlhJV1JnbjlNWDZ5NmtsN3UwR3pT?=
 =?utf-8?B?VFB2d0czbzhndTBSWEpDNDVGeEw2TWtlZUswZ0JiTFNKY28rVUN6a2VrZ0lp?=
 =?utf-8?B?SC9kU3IyQllLMUpyVU95Z1huRURiSWlyL1JqK2o0TmNTbDNXcHlWLzdMYjBP?=
 =?utf-8?B?S0k1MlFCcjRzN0JyWVprTElwL2hPaDdyUTkrM0FpQ0RoQWU5VmVXNDZSSDZt?=
 =?utf-8?B?S1UzZEYxbkxwc3dZbkhza0JUMERieFhLa21Gbit1ZHNnLzVsTkZEYjZIWmdE?=
 =?utf-8?B?bkVLaHAveUF4TVo2SVlQTU4wajUzOGtudXpIUTRBd0F2em1XdEFVeTBvNlhx?=
 =?utf-8?B?QzhIOXlWRXRxQkdDVzQ5NHNLeEpRakh2dm9jRnJvZ2VFZElMamEwTTQ5S05v?=
 =?utf-8?B?aEtvcExNQi9qend2dEg4UUZFcWFJUTVjc0F2YStKS1B6RnJuTndTbjNxRll0?=
 =?utf-8?B?MTd4L2dvazVLS0o1ODZJSjRqWlVaOUZOVVJudWVjL2tDTURON3J0U1ptb3dU?=
 =?utf-8?B?MHRROGZlRnFhL0ovUm5QRWNWMVJZMUpFckVLVnNEYTRTclpFS3VVSkdvYkVl?=
 =?utf-8?B?TEFoN2ZIcTBidzM5SlI1QitBbkZmSFFHZVFsWncvNTI5K1hNT0poRjlOQU5O?=
 =?utf-8?B?UXUwNjM2TXUzSmhZbi9IRFhqN3YrWHdKcDBESjF0MmJGWkxIckk3a1VmL3Mx?=
 =?utf-8?B?YVc2NHRESmlwRTRndUNXZG4wazNqL3hkWGRuOXhGQnc5UHNXNVdCbXg2ZHVl?=
 =?utf-8?B?VU9JMVBlYklscnVQU1NNaVVpYTU0bXAyWld6cGtwcUNQTFIyby92VGNEeDVs?=
 =?utf-8?B?cU5JbzViODFvTktlU0VabzBLMDBxczIwUVUvM3ZESnY1b1RURTdhVmg0NzRy?=
 =?utf-8?B?UDRwUW5WdDFCeG9tb2gyUXBpY1JQQS9nb2NlT01wL1V6RDRNUFUwV1lNZE9V?=
 =?utf-8?B?RXpKdVluQ0h5RUNQUHM1WlNtTFVRd2xmbDlLN1QzV0NTVkJHRVIwMXhwb29r?=
 =?utf-8?B?TUpadlBlZUNDVnErZWhaQ2JHMXloT0MrYkMzcXpqdC92U3JXUDYrdjZWM1hW?=
 =?utf-8?B?ZHdHZTRacWwrald3UlVJYzVhaVN3R0lvcXBjeEYxcjVUSmpyZjhsTXFMRE9Z?=
 =?utf-8?B?ekkxb0N0QUFmUXpSOVh1WnlZcTJyOVlsMG5xMm9tamxaNW1zbHBwdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bdae32-137b-4ddf-573f-08dec30b882f
X-MS-Exchange-CrossTenant-AuthSource: BN5PR12MB9511.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 14:05:43.3519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFVGIadcAa6bzao2tws4SN6kzaf3Yv5Fe40ejfqw2/GmI0PjZZtEK5/iAwZzDrx8jOu3twdSwA241gsGuQg/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356



On 6/3/2026 1:43 AM, Will Deacon wrote:
> External email: Use caution opening links or attachments
>
>
> On Mon, Jun 01, 2026 at 10:48:44AM +0000, Ashish Mhetre wrote:
>> Tegra264 SMMU is affected by erratum where a TLB entry can survive an
>> invalidation that races with concurrent traffic targeting the same
>> entry. The hardware-recommended software workaround is to issue every
>> CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
>> is guaranteed to evict the entry. ATC_INV is not affected and must not
>> be doubled.
>>
>> The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
>> cannot be detected from hardware ID. Tegra264 boots from device tree
>> only and has no ACPI/IORT support, so detection is through device
>> tree only.
> That seems odd to me -- whether the hardware has the erratum is
> completely unrelated to whether it probes using DT or ACPI, so I find it
> really weird to have the workaround enabled when booting with DT and not
> when booting with ACPI. We should have consistent behaviour between the
> two.
>
>> Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
>> the existing "nvidia,tegra264-smmu" compatible. Also add a
>> static-inline arm_smmu_cmd_needs_tlbi_twice() classifier in
>> arm-smmu-v3.h so that subsequent changes wiring the workaround into the
>> CMDQ submission and iommufd batching paths can share a single
>> predicate.
>>
>> No callers consume the option yet; a subsequent change will wire the
>> workaround into the CMDQ issue paths.
>>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> ---
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++-
>>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 40 +++++++++++++++++++++
>>   2 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> index 4d29bd343460..08684bd40a6d 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>> @@ -5243,8 +5243,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
>>        if (of_dma_is_coherent(dev->of_node))
>>                smmu->features |= ARM_SMMU_FEAT_COHERENCY;
>>
>> -     if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
>> +     if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
>>                tegra_cmdqv_dt_probe(dev->of_node, smmu);
>> +             smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
>> +     }
>>
>>        return ret;
>>   }
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> index 16353596e08a..106034c348a1 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
>> @@ -928,6 +928,14 @@ struct arm_smmu_device {
>>   #define ARM_SMMU_OPT_MSIPOLL         (1 << 2)
>>   #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC (1 << 3)
>>   #define ARM_SMMU_OPT_TEGRA241_CMDQV  (1 << 4)
>> +/*
>> + * Tegra264 erratum: a TLB entry can survive an invalidation that races
>> + * with concurrent traffic targeting the same entry. The software
>> + * workaround is to issue every CFGI/TLBI command twice, each followed
>> + * by CMD_SYNC. The second issue is guaranteed to evict the entry.
>> + * ATC_INV commands are not affected and must not be doubled.
>> + */
>> +#define ARM_SMMU_OPT_TLBI_TWICE              (1 << 5)
> nit: I think this should be named slightly differently as it covers CFGI
> as well. Maybe ARM_SMMU_OPT_REPEAT_TLBI_CFGI ?
>
> The comment can be simpler too and avoid being specific to Tegra264. The
> main things to say are that it repeats {CFGI,TLBI}; SYNC sequences and
> does not apply to ATC_INV.

Ack, I will fix this in V4.

>> +/*
>> + * Returns true if @cmd is one of the CFGI_* or TLBI_* commands covered
>> + * by the Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE) on an affected
>> + * SMMU instance.
>> + */
> (remove the comment)

Ack.

>> +static inline bool arm_smmu_cmd_needs_tlbi_twice(struct arm_smmu_device *smmu,
>> +                                              struct arm_smmu_cmd *cmd)
> Rename the function to something like arm_smmu_erratum_cmd_needs_repeating()?

Ack.

>> +{
>> +     if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
>> +             return false;
> Maybe we should make this a static key?

Okay. Shall I add just static key and remove option bit, or
have static key alongside existing option bit such that
static_branch_unlikely will precede the option bit check?

>> +     switch (FIELD_GET(CMDQ_0_OP, cmd->data[0])) {
>> +     case CMDQ_OP_CFGI_STE:
>> +     case CMDQ_OP_CFGI_ALL:
>> +     case CMDQ_OP_CFGI_CD:
>> +     case CMDQ_OP_CFGI_CD_ALL:
>> +     case CMDQ_OP_TLBI_NH_ALL:
>> +     case CMDQ_OP_TLBI_NH_ASID:
>> +     case CMDQ_OP_TLBI_NH_VA:
>> +     case CMDQ_OP_TLBI_NH_VAA:
>> +     case CMDQ_OP_TLBI_EL2_ALL:
>> +     case CMDQ_OP_TLBI_EL2_ASID:
>> +     case CMDQ_OP_TLBI_EL2_VA:
>> +     case CMDQ_OP_TLBI_S12_VMALL:
>> +     case CMDQ_OP_TLBI_S2_IPA:
>> +     case CMDQ_OP_TLBI_NSNH_ALL:
>> +             return true;
> Isn't this just everything < ATC_INV || >= CFGI_STE? Seems better than
> enumerating everything.

Ack.

> Will

Thanks,
Ashish Mhetre
