Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2112.outbound.protection.outlook.com [40.107.243.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8108613E
	for <iommu@lists.linux.dev>; Thu,  4 Apr 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237704; cv=fail; b=lSwLmdjS9E/ttlVJ9R7diFgpPDZvLULlbczuAe6nCj8zRGj7XgOfRQQ7wmJdDKDGHDHOovfIPLIzRWebjvjG1rczuhnWsv2CRX48kCNmFxbobvhidsVRmhjX5aBhqJSbWe2CNwjjgk9Z1fYnkCXAcXlNht393pREo654G51/ao8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237704; c=relaxed/simple;
	bh=FvPifMwB9XK3lRHyV6EXBD/KSP8iE90Th+gwRGaYD4s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcMpYPupc3J1Tx0oCP5JnXRMaTTN5U9wvrrM/JFBvMM7UzlvllmD40pAkiUSAU22+fSENULP3QUnxcZCF6G1VM9Nts1kvbyB0RGcpE0JBgFTZukSLfh3FzMtZoPXrIrLbhsKbmz12NB3IfoPMyIk7xSP9SX0OEiVxlAhJwOarDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WitRh3ja; arc=fail smtp.client-ip=40.107.243.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WitRh3ja"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n5zFp0tkht3eGU4CBAF5NvgJYX4U/m2xKw9EadHyMV2rpVUvHQBs1gSDCLyD34fdSnxzOJ96VKCk7YI4o4Bcdn/HlnjsN+ec+qrpF2Xhj2Dt3X6qx6UqTVHnpF2CjmFj25yuDYxz/hUpN6qcgxEhu2G/MUkzAGbUKKD2r7feKdJOXPOL2LcaRv5d7sWSdMWKMdfM7A8nCuDy7MgLccDOjuTjwItCRU1SBSMzcEtGhWPR9IM11ZQYCVRNWumwMTKiDL6eueSP/bJ7DN7Kf4rN2w2cx7K8stV/XDSclv1oeokr30Oh2tn0nAUqmjoejmBIKIAh+k6TBEy33q1T19Ok7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOrPURoQgrX1rYAzQZPA0JSJbW/SXREcmZDi81/83rY=;
 b=JcBsOWvsP8w+MSQTI2QjrQ899h8YajXKkJ0OCztkmM9fZ1shaUUnlwc//s9pUW4prXWCXjBRDunaSLwyV5IcIB9/cL7QeKr4JOa32IkDtVNli53hHO3W/cn/D+A992olmf/VHfJUT6Km1a7cIPmPL7MYNAo8DfBdyhlO5Pcpn8/gEvXQ1Zo5zxGGMA42FSQmWBG9PJ2jM0nFgAM4tzT23YrrLX70jcKhZxVUMhflcksfJs1/ZRZJl/tPY6zo+l19azveei4ZWk7QGxx0m0nz2wbj3Oyxd0bdKhqFZCk2wdLUAGM/CThHIdBbVsH8/+jaHTK7GrUXAjgWjvj0TsCAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOrPURoQgrX1rYAzQZPA0JSJbW/SXREcmZDi81/83rY=;
 b=WitRh3ja8KDam+ohbNutTXZ4ZK6oWEtmo0HtIYeISbYXImHgMPsv7e3khtp1aIyeagsjDACViXv3BSs4CHmfk2hPbHpn6+KHXgmFfraemQv19WGumQAGsXoQKFgplTYdWdC1ZQkX6omqJY4vQ7ZZiAXcLUHnprva4mGmwMP2KGY=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 13:34:58 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 13:34:58 +0000
Message-ID: <5187cf7a-7263-7635-90ad-b298e14b8ce1@amd.com>
Date: Thu, 4 Apr 2024 08:34:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH rc] iommu/amd: Do not enable SNP when V2 page table is
 enabled
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Ashish Kalra <ashish.kalra@amd.com>,
 Michael Roth <michael.roth@amd.com>
References: <20240404103729.6752-1-vasant.hegde@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240404103729.6752-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB6638:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Ja0NQne/j0j8MYH/qganhl5H6zqw2DsI7U1ZiZARkUzd7CioQeXgjtP2R/yD06/LvjeJWfIWB5muQzneaVmcEioCQqUymut24uW314JpctkMR5LX/gJikTAWWwNPm8QyNW5peF+gD4P6ra8yh1lAMPmLrZTkYYaA3l2OoEFZktC4DytEXR1Ctao9kEj0N7ujWTsOBRZIgEWskp6KleKmmKbRUPI/dzFYWq1fUvat7euO7bCiTjN0ZszPUQNzDOTJgo0putyx+HehwOeAnJuOak7VBYFuSeOKUQpI5pc0cZZ5xeDDJsWM0LLUxah79lAToZEmwkvV3TCyClfQh7Vr4NGdope6NEEq7RBroT+8uRT6kO1nnpGu4SyAqQFt8jUN2DKrnMvpq20Y+jaAPk/qmnm11CQFqFDKluE5XYK53JVuYj9OPxz6tVllr6IK3VVYxOCqnNECIOGiSupBVqN/d+BwGAmLOkjFO93DKn3Y9blEFumldLyLZdzWDG6A/pYU7GUY8y2E4H4NcdaZj5YmU+DpZUdMQiQDoK+5G2OEpYxw+2G+lUQTPH7aN1unOO8We7RO0nZHVtt9pwbXfDcVzI0loCYiFpNGVM66+7J9opDrR5FYhhtBYYYfD4NRd60
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck40c3E0UHoxZGthMFA2YUhRcUd4RnZTSlNjbXp2WTN0UDFmMlB3QkNOUUdp?=
 =?utf-8?B?RE0ySEhRWlFDbGVSYytpMk9BVDVzTTNCWHlRcDcrbjdCdXhGVGY0MlZ6OGdh?=
 =?utf-8?B?YUpoR0tnYXllVk50WHZ0OFhZWEY1SjVnTHdFVWFQQ3FscXo4NnBBcHR0eHhY?=
 =?utf-8?B?NVBMVk9ILzBtQWR1RTJ3cmdHYnJGVlFsNDlwYmlNTGFXeVJCUzZhdXI1cStj?=
 =?utf-8?B?ZndPdWVibWhhNndFRWtPc2h4RnpxRyt6aU5TazFZUWk3cDY4MDFXRHJCT0lN?=
 =?utf-8?B?MmdkeTBVVjhKNTREbTVDZGh2NlFRVTNRaFNzQmhKU3lRRzlld2t4Zlp0TFEw?=
 =?utf-8?B?TnYySG9CMVNmUCs5Qm1oYXlHc2NZMGZyRGhMMDg2YkRqa0ZxeW1FQzNudDBs?=
 =?utf-8?B?MndJTloramlxZVM3MktQaHc0bldPcWV1WVV3S2JTSkRSL3I4VDlydURCby9m?=
 =?utf-8?B?NkUyTTR6dCsyMVlUaHRWcVJsV0dUazNiQVo3dEJwcW4ycmN2Z0ZadmlUWitL?=
 =?utf-8?B?RExhVHIvNkVYaXF1M0loUi9ZeW1yWC9YMGRpUlRMU3ljZUVDS0tEMXVCMHFZ?=
 =?utf-8?B?UWRIWjYzTWxTTmZ3My9MZlR0NmdUOUowUXQrVGZmaGVoQ1N2eTJsUmdTYmhW?=
 =?utf-8?B?enc1TSs4aDdtNFRXV1dMZFpVcDhpTWQvbysvUVV5WTZyZTlwbkJnUjZ4ZENS?=
 =?utf-8?B?M1YzdUtEK2JiMWRza0pad3NLK2NYVUo5TlJLRnQ1VXk3MUJyVEFZSWp0RE5T?=
 =?utf-8?B?QVZsOXhvanlZVmJiTUR2RTdCcmppWEs2eHUwdzl6MEQ1TkMrNXRoMG9aUk00?=
 =?utf-8?B?RjZEK3ZrT0pvTHZzc1BNcHN4MEdqanh3SlJDTUpVZzE2T3JMbzFuUUVKNU5B?=
 =?utf-8?B?cUxUMmJYbnJBb0M5c1JzUWMzTDN0NVJPNUxVZlFzWXAySFF0T1hVcjU3LzUy?=
 =?utf-8?B?Ym1JdDl4eStJaGlXRjl6bHJqUW1IRTVSaXUvdnJTQU1TRmVaTnZuRlpsSnBV?=
 =?utf-8?B?b0E4alJaOTZwZkd2bmJ5YVRsU0NrZFc5TVFPZGNteTRjSGxVdFZGdWY2RVRN?=
 =?utf-8?B?SGpqdjBCOSthdldwN2o1OXpMMjFST1V3elJoeU1lNkFDMThFR3pkendnUXQ0?=
 =?utf-8?B?UlJweEY0TjFsMS9wNVpNRUNyeHNoa3Y3TFhyWUxNcnhidlZZZ3k2WGFPbzQv?=
 =?utf-8?B?UXZZSHZvZWdCQnlUYmpYQ1RyQWZmZEczcHZrbCtZU3ZFZnVoU1FQWjZpczhI?=
 =?utf-8?B?UFk3VmdWMjMzaXdjdDhCV3NqRTFkT00yb0E3TS9KSjAydFBMRC9mQUN4V0g2?=
 =?utf-8?B?OXpUMzB4b2c2bWdGSGs5QXpncmIzbUEwRHE3dlNXTWRuN0JRRVNWMll4Um5U?=
 =?utf-8?B?YWZFb1E2aDVIQUxaSHNxWEFzY2lIKzFPOElPRkY4b1dKaXloRTlRU0JhN1FY?=
 =?utf-8?B?VGg4VCszTk5idUVXRUY3dFVITGhVR0tnK0NFVlFMdlZjaTlwTlhOL2xOUlBy?=
 =?utf-8?B?c0RtaHQvZEExbi9TMVNXUE5KTmVjV0lTN01uaEp0Vk0wOVZaOWdCNGE0OWtz?=
 =?utf-8?B?ZG5XR3J0NHBUNzdXVzF6bU1CNUZzalZVRU9xUWZBbVZ3SEFreDJXRkF3eUFS?=
 =?utf-8?B?MzFiMkRZU0VKaVdOT3JHZVRhWU9RQWF6RGN1VWtzZERBNEFjaStMZHNmSmJv?=
 =?utf-8?B?d212dyt3WVBoVDVVd0tXdjBnTXJrS0RHcEdCU29obU1ubWM0OTRmMCthS3hY?=
 =?utf-8?B?cTF0elNQdWFka0E4dU5xVUpRSFZ4QTdFcnk1V1Q5UmFqek9LdWhVM3o5a25X?=
 =?utf-8?B?ajVCSHBwai92LzUyNzNZMWR5V0xJTjdFL2ZWK3hhK1pVdVNIekhETUtrekkv?=
 =?utf-8?B?Z2h1U01JdDdoRWxqWjNKcUFEcTgyR1VGNFU3cTBXNEIzKzZISlRIMEhMZVRv?=
 =?utf-8?B?dzZJcVY0OHdRdFJTUHZidG9LOWdDd2oyR2tzaWM3MDVMQTE3ZWhlVHVmZjBX?=
 =?utf-8?B?RVNVK2hiZ0J6bU04Z2crNEZCTjEvVTQ5TERkazBpSWtzWXd2UEV3Ri9Hcysv?=
 =?utf-8?B?ZVpjZ2ZjTmFRbWFBcFJWNDVPdVhyWmNFcE5QalZYQTZ3WmVRRWN2L3hTSUN2?=
 =?utf-8?Q?A3O6oPc3RPRFjSy5ymqMBbQgv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0d3a7e-b8aa-4c87-21f6-08dc54ac0590
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 13:34:58.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eku9xrxSEPWrzik+zWDK7+xyo8IdW/5lXJKY00Db7HIVOMoRYjjtD8dGwn5kwXNI5Kek8mTMZ5n4sWw6fV5EDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638

On 4/4/24 05:37, Vasant Hegde wrote:
> DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
> to support SNP, IOMMU must be configued with V1 page table (See IOMMU
> spec [1] for the details). If user passes kernel command line to configure
> IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Cc: Ashish Kalra <ashish.kalra@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Just a heads up, but this will likely end up with a conflict after tip
just merged changes around this area.

https://lore.kernel.org/lkml/171222187434.10875.5343618940901502172.tip-bot2@tip-bot2/

Thanks,
Tom

> ---
>   drivers/iommu/amd/init.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index e7a44929f0da..e643949b697a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3232,13 +3232,18 @@ static void iommu_snp_enable(void)
>   		return;
>   	/*
>   	 * The SNP support requires that IOMMU must be enabled, and is
> -	 * not configured in the passthrough mode.
> +	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
>   	 */
>   	if (no_iommu || iommu_default_passthrough()) {
>   		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
>   		return;
>   	}
>   
> +	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> +		pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");
> +		return;
> +	}
> +
>   	amd_iommu_snp_en = check_feature(FEATURE_SNP);
>   	if (!amd_iommu_snp_en) {
>   		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
> @@ -3246,12 +3251,6 @@ static void iommu_snp_enable(void)
>   	}
>   
>   	pr_info("IOMMU SNP support enabled.\n");
> -
> -	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
> -	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> -		pr_warn("Forcing use of AMD IOMMU v1 page table due to SNP.\n");
> -		amd_iommu_pgtable = AMD_IOMMU_V1;
> -	}
>   #endif
>   }
>   
