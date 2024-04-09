Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2130.outbound.protection.outlook.com [40.107.244.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91B8C1F
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 14:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673370; cv=fail; b=VEK+kobyRcn144q6TY508rpd96vo1udQ0oZHOQmGUiEnJZcn93uqYFKTno3rzxrpz2nVi6hs4caXzoI00R7hOvhfEeecLwZia5xxM4uA4rBYnzym2VjBax+JOt6O0ceNjaeLtlRLbw/hhEKYfN2vMuOK0haPugS9Mu0bOHfDfR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673370; c=relaxed/simple;
	bh=CR0LXSp0L67pTkxBNA9iKNN73VOcXefQCkj0CDzpOac=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=lLB/sQRpXDPSCPvP24N0U4Q429jPyqMAd9wQQXzKdnCLo/RISdyZar/2YwbiIN7nj2+mLZEyp4k+GPQSO3eIsfMllgqEGDrpm6Qu7IgqG+FEVd37JRHROyr7CbHXnntFUZCtGz/29BzQjnLyiMmMFx1JEB89iFsMsauAoJXii8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZjBK76XI; arc=fail smtp.client-ip=40.107.244.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZjBK76XI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/Q1QCrYP2DVWL7K2TCz3NxDuXRIFZzIJulD3lRUHnvto5rMDR4uvmsEl9Y2jRFQDJSVqH/0s1Ek3+7JPIC/qOKwAnCo1/2yjG1vTjvURg05rrgzxNUUlUIUNcMs11kY5PEulLt8CiQRquaSngnrB2Mr8HIOvBfC5gf/4xtvgU6L5kxGkFLkkkeUAmcTGRVbTSP41lwRdm1yyPXKdl/C8cxTYYisKV9fSjHgij54flgnY9MRBgqNAfIFIXqVIvz72qUP14WUXpflamJeUj3onMjMzvrEXRIE+xW7yW8hAndL9zspRlridFL7Gsv9TrG0bzTHdz2L0UYyuNES9V4UJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXE3fLyhWjNt7QRjrtuTEVLUJSqIOaKq/vwEA5CTBAA=;
 b=WzC6+nSECX3BtAFCQbGHreNiIdAkAoVycvysuP2pcRMbbrmma2bNykBmzbzENWRvIlLkZXD2NBLhRe9jb7AxtxuCVkL9DuN7Mdeg/Jl2P7ke/deu10cDIWFihrYbWtdA47wPv2IoPaARCu53eH3hPwlgG6aLvHVjMAeV6DcOryTQVFfsMvY963GskWIEADD0eoPKM2RtUatVqSj/fV42E1Jh8gK3Lj4G/DOJYWKXxDXvMsFnp5QojZvSiErpLkpHEdXoW6Pj09SjacgDu07HcYa5d/chgQk0ZcHieXgI8od0HJiNEONYkRAOK5dwd72lA1TXWDBgJMf4F7Th0Jw6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXE3fLyhWjNt7QRjrtuTEVLUJSqIOaKq/vwEA5CTBAA=;
 b=ZjBK76XIkHa1mKAYYIJftY3pH/fEyJCVGys1/SDW21T6rVLjfxPrDHdwjtXGTww4Bp5xm9aRFaGIlJIO0377KbcCHBwd7iXkl/NOhnFJTrpuROf59mkkXMxoi30hs4aWzwHV/VcK5vPg83VDtQn2bZGI66vrklfMkzQuwXog6a0=
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 14:36:05 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%6]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 14:36:05 +0000
Message-ID: <9f2ffe44-80bf-d1dc-239a-f5fbff21b237@amd.com>
Date: Tue, 9 Apr 2024 09:36:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, bp@alien8.de,
 Ashish Kalra <ashish.kalra@amd.com>, Michael Roth <michael.roth@amd.com>
References: <20240409051354.26429-1-vasant.hegde@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 rc] iommu/amd: Do not enable SNP when V2 page table is
 enabled
In-Reply-To: <20240409051354.26429-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|SN7PR12MB7372:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IUFs/aZxjyKCMirJOVX/mHfTxiRRm5Rmj7mGxeGeA6W1uF4ctpbGi7UxUj5bQ4fC+dC+e9dTLwXcure8S0zQr1ORCW3HLwt4XQT6PCM0+eR1d9tgJYx49PLW6essHyOuO7c2AUiTLkay2H+Je2qBkeICVuAr9WKchSF/dDKapZTGRvrWHoU73REpeFp0Rng5ps1jYT7uJgRd5m3+h9Rf4O8pD4SpdBS9J1ZLCjrV07bFUH9cwZcWHZ0l7FPJv2DB4ueGN50QHnaaUd2Wl+oo1gpBbZOjOEkEcaxnxmiFnBWkmzBqNJWC+FBjgqjWzgecSbC0zidEppEP86s+Z1fUBPHUawLYwSsCLrtaGQgt6Sk7VtXXPMu/CoN9i4cZ+BusqxIQoo/YKYI3jxc/8nziRqvTyM0DflCrTTbCMUP/Lc+DyMfZp3EMzSodS8uqfBAIb55vlDoUzpfsutcS+2s2tdiPZ0Ys0XPYfoMHinlOGjKagJpI78zMY/c6BbVxoEz0AOUGKuF5Ce36RcqjgHlViL9SczcNLnDLtjrOLlN36iR7yiBHvOnaLVJ4d+mptAeA/C7jeKwz4wpeeLHRpom/70sj7QT7u6sDgUXMu5wRM1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1hRdXc2dGtrSDUwQ1ptWGo1VkdkbDVMV0RGczR0ZmpmRnRrbVN3REJSSlYy?=
 =?utf-8?B?YWhwQ3Z3bUs2cTVKZ09sSWpmeSt5YVB4Q1VScmNxN2hBcklyc0hibG9GS0No?=
 =?utf-8?B?ZjdqdTc3L3ZZL2UwVXQ2VkFxdEVjcSs1SGljbDd3YVA4T2ZiYkVYeTZZandB?=
 =?utf-8?B?akJCcGUzcVVhanJSNGlLYzdZSlpVRXN5Zk9ub2FudWpKempJTzFEU3A3d29z?=
 =?utf-8?B?OXcrb3liM0p2VUFNenJ2bG1mNkUwTGtvN2NjZ1pmT0J1blhWZTY4Wll5WURN?=
 =?utf-8?B?eDB4dFZSdG4rdnV0REhPQlJraTRNVE0rZ1JsQm45NDN0VXJWeW1HOW1WUC83?=
 =?utf-8?B?czJBOHNUUkkzcDJKbkFzNVdFUDlvYVk5ZnBxMDNqR1lmWWI2bjQ5cGw1UDBL?=
 =?utf-8?B?bmdFT1NmeFBUTTNwa3JDMWhOS0RpZjlsUVRhSXBCc1IzaW9kUG5lY3hZdExY?=
 =?utf-8?B?NjhiemxXZnh1S3BMNUtkWmNRQTd0RHdhR3UyYlNabkxVVG5kdU9uREZNRE50?=
 =?utf-8?B?TEVtbkQvNHBPNUdrOEJHc3FTNmhlclNXdk1QQnRMUEJvQkZnSmY5SDJsenpu?=
 =?utf-8?B?dmMzOFRkWkl1VWFaaDZscGozWU4rVTFOVjFUdEU4RXVyVk9vdExON3I5ajNz?=
 =?utf-8?B?clpDVVBPVVdiWUs3bjZmcTl4eCtzeEhIUFNQb1dFRG4wbGpqQ1ZiMEpoS25P?=
 =?utf-8?B?VjdnL09xTnJUMHc0a0FHN3R5QTZKc25WQ2xQVlA3UGdUQVpUdVVkYk1YUUFj?=
 =?utf-8?B?bStHT0JjcWkzeGY1ZmtnS1lERHlDd1ZPZjNRLzJrMlpHaWFUKzlpWjl6c0Qr?=
 =?utf-8?B?TnFUZ3VQWXBrSHMxOGJRMVVqdUdCUU02eXRsKzBPaVhxZEJNNFk5cjJFaHR4?=
 =?utf-8?B?RU5BSHlzVXZUMC9IeHhOdC9UdXpRS1BPMDcrZXlLc3lpUFphL2ZxZ0lTbzho?=
 =?utf-8?B?VWRndnppeXVxY1JjUTZqMWNFZGp1eE82UDFzbWNyOFRRZEtpeEYwNS9SclAx?=
 =?utf-8?B?eUVlUGhKeFNuWUZRQTBDNzY1ekUrT3BUUldjS3pZVGJ5dGRjVnFrUU55Rzc5?=
 =?utf-8?B?NDk3cFBjT1N5NFoxbnU1WCtPek94UHR6ampDbnM2QlVyU1lZejFaUVA4V0xP?=
 =?utf-8?B?bVBzKzJPZXJrRVVIdk0yaUxRSGV1S2FTQTdDY1puQ0I5R0tQNFZlbUJjdUhm?=
 =?utf-8?B?RGhMU3FGV1lBTVhOeU1QM0lrQ2pPVmo2SVdHRFFrUkVtZjIxSnNyS0s5UmZ3?=
 =?utf-8?B?MWQvZTVkQVRiMldWK2RKem9tSVdkR1FxNVhlOTlYN0gvcE1VZ3V5TXVad051?=
 =?utf-8?B?ek1ON0RvNWVJOEZvT1N0WnRhR3FjT3hpODdHRjBRVW5NUTBBbE50Q0RwZmk0?=
 =?utf-8?B?Smt3eUlSZHE4bTZHZlNIV3RNWUE4OXBaK1VZZU45Q0F2amVvQ3pMaFpRalJV?=
 =?utf-8?B?bUVXVmtwSEQ2aEpscTYrL2I0ZjRVVy9rTXRKcCtKc3ZhNTBkUWtML080TDJw?=
 =?utf-8?B?QWNodzNHRG9VM2VHbjRXV1NyMWVKb1lOQVdKZnorVzNLVWJubmloQTlzOUh1?=
 =?utf-8?B?YUkvazdrZ0R5SFo0U0d2aDcySndHL2NiV3hLVHZ2L0pWTXBpYWl3bkVtMnFJ?=
 =?utf-8?B?OVhVTUVwMUFJWG5YY3MyZFNSLzlxeXp1cExCV1d3QUdGTlpLNUkwWk05NTk3?=
 =?utf-8?B?bGRxdWxuTnlWNU8zS2JRWjRCMzU3dklDTE5LMTBEMTJ3bk1UWEFETERvYTBZ?=
 =?utf-8?B?cUxqM3huaEVCQStvNWpqSzYyc3I0NlJlUzk0Q2RvTDB6VXBkT1hEZktnUjIx?=
 =?utf-8?B?ZFNzRW1FdXdoOWo2UURVazlzRzUwQm1xcEJRTTB4T3NSN0pueDcvemNORU5k?=
 =?utf-8?B?cHZYVXU1RTMvTXNQUXB5c0hJYTdGd2N1MGUxdzJWanJQekFQcWhxK0drNVRk?=
 =?utf-8?B?bHp1dVVycE15dy9oN0ZVeHpDR0x4eW44ekEwcjdVbDlTVnBvU0pVREUrVGJi?=
 =?utf-8?B?aVU1TWNWWGg0aXdNK0dOYzdIME9YRjBYMy83a1Y3VFVBTGxFRlNWRlViNWJ6?=
 =?utf-8?B?enZ5OUxsTnJDaE1Ob2FMNzBSOUIyb2NJK1FhY05Pajd0eGg5d1lFWGg2eFpz?=
 =?utf-8?Q?IzzIzXeMHoYr7xCIdqhhZw/e/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bbdc34-0974-464f-fdfe-08dc58a26346
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 14:36:05.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFpchTpcv6QbbHbfLAfIzKIgnBNQrKquoNaWBRLceDdgNyzMJJxe/gyQmGNkZd5/D/XeIXyTqn2tGIpk367VbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

On 4/9/24 00:13, Vasant Hegde wrote:
> DTE[Mode]=0 is not supported when SNP is enabled in the host. That means
> to support SNP, IOMMU must be configured with V1 page table (See IOMMU
> spec [1] for the details). If user passes kernel command line to configure
> IOMMU domains with v2 page table (amd_iommu=pgtbl_v2) then disable SNP.

Might be nice to say that you are doing as the user asked by not forcing 
the pagetables to v1.

One minor comment below, otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Cc: Ashish Kalra <ashish.kalra@amd.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Changes in v2:
>    - Rebased on top of v6.9-rc3 and resolved the conflict.
> 
> -Vasant
> 
>   drivers/iommu/amd/init.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 005981c2f96a..0d9b69765099 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3215,28 +3215,29 @@ static void iommu_snp_enable(void)
>   		return;
>   	/*
>   	 * The SNP support requires that IOMMU must be enabled, and is
> -	 * not configured in the passthrough mode.
> +	 * configured with V1 page table (DTE[Mode] = 0 is not supported).
>   	 */
>   	if (no_iommu || iommu_default_passthrough()) {
>   		pr_err("SNP: IOMMU disabled or configured in passthrough mode, SNP cannot be supported.\n");
> -		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
> -		return;
> +		goto disable_snp;
> +	}
> +
> +	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> +		pr_warn("SNP: IOMMU is configured with V2 page table mode, SNP cannot be supported.\n");

In the previous check, pr_err() is used, while here pr_warn() is used. 
Should be consistent. Not sure if that means changing the pr_err() to 
pr_warn() or making this pr_warn() a pr_err().

Thanks,
Tom

> +		goto disable_snp;
>   	}
>   
>   	amd_iommu_snp_en = check_feature(FEATURE_SNP);
>   	if (!amd_iommu_snp_en) {
>   		pr_err("SNP: IOMMU SNP feature not enabled, SNP cannot be supported.\n");
> -		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
> -		return;
> +		goto disable_snp;
>   	}
>   
>   	pr_info("IOMMU SNP support enabled.\n");
> +	return;
>   
> -	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
> -	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
> -		pr_warn("Forcing use of AMD IOMMU v1 page table due to SNP.\n");
> -		amd_iommu_pgtable = AMD_IOMMU_V1;
> -	}
> +disable_snp:
> +	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
>   #endif
>   }
>   
