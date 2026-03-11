Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC65536B043
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245465; cv=fail; b=HqjtjMdwyEABZg9L0C907pxlTL/bLhK1E6qJuJKDDU3faaTjqzagTjll5zAVUe41Bwi2mAOw6aeYnCCi9zuxcMYYjr7yXWbbdqIcqKC4lBHsrfj6CbEP4muaYnB4U/wQ+U61wFyJsebq6DdMGF/4jlHj+ePPLh6dBjzBJjRw60E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245465; c=relaxed/simple;
	bh=uUpzkE+5YUvAnw4itqW7qghXm1s1Dp8SXQ0UqWxInZg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EbhhV/KKFFXWTuj27XE1677yskWQAbjueSdLa8L1piDupstCsrBVe8Zt/mSXVyhp2rcuchO1eEWNsAV/FymX/uJSmKmLotdxom0AZcMHMbeonRNTDYPfwg7cEuNhnHwjfnSGEs4pQWwA7oG0HIngu9MrTeT6qaYYDDSHVDPcEoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m7HsEzmQ; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m7HsEzmQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmB6QDafSCgNZAtPTIVSnbYZvFgexe68rk+KRqN+4w1BFktt8R1VAmmGMpPtdZK0haVq+o8qGBUE33OCRCDd46VrKP5IClmiLqbxhSu2XsE+NHkeWuu2Iffid/z7Pkjgen2z0ABwA5gfdzh1oSS9EsfT68tAkY0XUPmveoz5UX7th8WV3Go0VToJqDuBJGxPzgWLVPp5q1FuIwvlaht5tnZOiHoBl9ptxM7DVr2AaowglmJWMdzIcWnvwKHdJ17Xq1g2L40W0eDGP3v2ERNQpu5kLcwGm1Csoj8CWlnGMrLZHK1qzgPX691LsIO25A/F1DP64sbrSdwqKVxzv6PF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x00QrWILdg9S8gP7mLimPlM0puy58KE9UdVRgGkZwtE=;
 b=MvX0IAOVZfXF/1kOBW8UIi4XsGib3cIAe+E/y4GnzIqqHkcDXk9UbXsJ/LFhq05G/atwFrUyfa1X3L+rQe/wNN9tBxtjZzf6ddoCdQH2Q0dU8fiCeBXB9hiEvlq8xB2l5E5jeDjMU5BMD9I2f7LXsV1v+Iee7IbdBi+80JuP9G+VNyMCXqp6Txft0Dw2FS6uDtMpkeWEU5lCD3aK73yXxrlnzjPggnWNBpmL8jXlHbUI7T1Ya6Vte2I5ppx/mw03bVzDJfqXSUXtSmnK19Iw5LPNEd160WteyZhR+mH7phATUol1564BVaOk2zecsTifgXJjsOBZv81L0rhrXfF1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x00QrWILdg9S8gP7mLimPlM0puy58KE9UdVRgGkZwtE=;
 b=m7HsEzmQt3lWsxl6LRQhsbGnBw80o1ipb1VV8DItCTjyCh6xd/G7Zcf5p7j30L1QH8xswawO2NrapSzhFz7peEPQdpVj0919NLz8vR/xoZCPK3iGnCwUJ1KnlCZ7RM4qenqOsqInnCFOH9XtX+oSr5gXYrwsEs1d3umn+TgTiO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Wed, 11 Mar 2026 16:11:01 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 16:11:01 +0000
Message-ID: <ee56caa0-770e-4bcb-89c2-5f21cd8498a8@amd.com>
Date: Wed, 11 Mar 2026 21:40:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Block identity domain when SNP enabled
To: Joe Damato <joe@dama.to>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
References: <20260309235234.3367768-1-joe@dama.to>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260309235234.3367768-1-joe@dama.to>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::22) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: c19b4cf4-9b2d-4f41-84ef-08de7f88c9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wl+Z5Wm1OdxCQMBO8sNMHemXXKKVV9eAUO7T36YOCAVOf1a7se9fXDPYwbLrQV0vfLvjjC1rdmyjCJiF7e+Cow3xLkC/TJJ6IARD7BFZAkMCxBSfqkPCznr9OljZ4F9qwDtmfUpORvyAlL0rNIxpG2ANgtMcaK48kV8FJ9aFTKqOJamQ7KwCm7Mte/Cc5ILcRbJwy/J77w183dimW9cwQneORv8goyr2Bqc9kHE1iVt/0aenIM3yDCsJrklWtXvZ1LeVysWY/qPAIBkkLpNeveD/zIGhTK6RlIujG5qSnPQqlvhElKol2BYLch8LeaJHdxRbRw0AqlJBFqxcmEJfKX6Bc5kz49IMRBAC8ksxXFH0O7zajZbI9yvyZ90INxIeuwGreyJTPVJKa/iCCLJErXhMR4EQqpM6XtpDIQZGnMhc+Ak7P5Bv9aLv8ZobUAo7dCRXXr1euzHZK6vsyB9MVn5BqgxUNhZ1jpAKvWoUWtfPL+m9NEhkCVkZJA9KuRTTizFy39ndzZ0gQ2kFPAKDTpglGOwYUdaoQFazz88v4phuqI2V7yWPq71Tr5ybJwAjU4j5szycC9WRFpDeYJa5PBsZWt1kizBOIIfK/Kzmhxh/MzEFU8fBVhn/85ypxeMy7pXLLrVwHpy2yXruFLKIF6pBXPzo4C2HlsPnLiLqLNRk+UAklT17Q92OmHhd3DVea00kc8HLRhvCqlwkNRbvNrhUiqtnWQY/uOo8Wa87PD4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGY2MEttVXF6V0ZaOHRHSHBNQXd5ZDBFcDZVTEhFamcvZWhqbjV6dmloOFNV?=
 =?utf-8?B?WXozbTJYU1U1M1ZSWWpzZzE3VVNleU9FQ2xoUm1tWCttQXk1NXR1SGQveHRh?=
 =?utf-8?B?WXdXTFRZQTdicEs4RmdZTStmZkNnK1dRNzhodzkyS3BwTjNOZkpuSFhhVHln?=
 =?utf-8?B?UDJYQ2dWMTZtSFkzczR5eU1POWNkcG51T0p6WHlTdDFxSTRhM3NLQWc3aHJW?=
 =?utf-8?B?dDhpZEg4S2NJaSt4bjd4bU14VnZwV3lTanRYS3F4UWRnMmhDdlVwWHRvSGpF?=
 =?utf-8?B?RllqcllCZ1BGQ0J2Q0lZSXhPM3lMelpPMmhuQmM1OUhrd0VRT3NZNWxwN3dW?=
 =?utf-8?B?UGF4d0ZVRkdka1VpOElLN0trdzFXbGdObHROcEg0WE5oZUhNQ0NlSWh4Nlpa?=
 =?utf-8?B?MmpjeWFKYzE0Z0w1bzBlUXRQcTIrZVBLNjFKcGJtM2JsSHNoY0UyWUZDY011?=
 =?utf-8?B?V0VRTnVpUjU3cDBvS0F6QnJvSjBBUmJnWGJybnZDMW0rcHZUbEY5SG01TFBY?=
 =?utf-8?B?MFVocFlwZmF0MmgrUUZoZXNWcTY5Zk1lc0p3UHNGdnVoSldGcGY3Ty9wMU5G?=
 =?utf-8?B?QmFkaGFuajB1K3VIeHV1MkVESTdTYTZTZUpIcStDaVpjYjg2OHp3MEcxWHpF?=
 =?utf-8?B?dFNRb0tCUVpxa2tOMnZZL3hXTm1TMU5BbkVseFgreUpBenFQZHJ6UGtCUUFJ?=
 =?utf-8?B?SnhLb1RQWlpoN1VhZkw0bTcxaDk5SEpHZjE1NW9YTVh1dTFXMGdqRFI0Z1VO?=
 =?utf-8?B?dHRIU05ZNjRZTGt3cTQzLzl0R3lYeUNqdzZDcFU3alRSdUpDbTFvV1NMMm8v?=
 =?utf-8?B?eTNRcU5wRVhtdTNLOFpkcTNnVGMvWmlrT3Nmcm1yZGFkN2FIeW4xQzNLb1Bm?=
 =?utf-8?B?Tmk0YytsUVI1MnNOOWs0cTRTbW9vQUwxd0c2STFHZ0RUK1hFSmVQdTd0Y09F?=
 =?utf-8?B?NUVJb21VdHgvbm9pZnMzaFNJTGc5ZWo4S1R0clJWTC9PRkxCdDRlaEpaT2FF?=
 =?utf-8?B?SHp4UWdRdGw4NldKTDRKZng3ZUNiRDVPZVUyek9vb0phUjNkMmpsWmljdDBU?=
 =?utf-8?B?a2Fxbm9rQXl5dHFSVmQ1TEkyOXRUQ1VDWFY2aTVHUVJjdytPbFJSTHY5TzZL?=
 =?utf-8?B?QzBra2pUQWZtcmVSMjVhZ1kzSnpFeUN6WVRXN3VDbnNkQXlzWjd3MXdONStF?=
 =?utf-8?B?QXYxRTh6TVJRSnV1RXlQQjBjMUNQRDdMcDNMODJFYkRPNHluODJaUmZvK3BU?=
 =?utf-8?B?Q0lXcmVlOFYrcFMwQUJFQncwNWpXUzZRbmJkcnBNaDZsL3pXRmpqMDd0UmRy?=
 =?utf-8?B?R25XVDd0SlF0cVloK2FCbUpudURsTFEwRld2M2lzYmZvT2FmeUp6akZ6dGxI?=
 =?utf-8?B?bkt1czRVZEowUytKSjdIZE1UYXN6R2x5WkRyY2dTQ2hvVzVzNUNJVGV0SDZ2?=
 =?utf-8?B?TVVCVmRhd1pBTWc0SWJRMHdUeUZ0YUcxQ3pmRFJaN2k1MCtaZG8wUXIzQ2Yr?=
 =?utf-8?B?cXM0NEVjOWthMWFOaGNCUWVZbnRLeHc5VkFOUm9kcWJsSkFZbVZiQko0ampQ?=
 =?utf-8?B?b0RKMk9HaEJTSzFQblU5QzF0dmdrc3JYcGxQVG9DS29XeWNrdDJhV3ZMU1lP?=
 =?utf-8?B?YSt2UEJwOXZaR3RHbWkvTFBvK3JmYlJldk1LelAwVndRUUNhVWh3dnNtL3h4?=
 =?utf-8?B?N1JFVVZlQUJoZUNIYzlDUjhtT3U2bTkrMnpRYkhFZjBaeDBrenpnWnZVdDhC?=
 =?utf-8?B?QjR6Q0hOcytMMWkwbkNBSWFFV1NZbUxrdzQ5MXowV2lCVlJsR2EybXRVQUl2?=
 =?utf-8?B?WGgrQWthOUJiS2Q2SDE4UmdIWEFrNW03Zkt5SnRiblJ2M3h6TXRabkhuYnNt?=
 =?utf-8?B?b2hUTnFkNGkxUElmVEdUNmFOTDBlb05nVTlsQ3VjT0FaT0l5MitRWm0wWHRO?=
 =?utf-8?B?RXR0YXh1ejhXZ1BlUlowWnRLcTNtdXZXbHhtQXAzckZOU0E5MUtPNnJGZ1ZT?=
 =?utf-8?B?VjVRay9McGFIY2R5Y1NkMUVDSEVSUkhqYSsrSFQ5L09LOUphTlB2aEtSZXVW?=
 =?utf-8?B?T1FLOXNPM1NTM28rdTJ1NHBVL0UwOUhsSmtDVnhoQWo5b3BHSFJYaVFFTitE?=
 =?utf-8?B?TjdQOEtGRS9XQWdSL0ZJRS9ma1ZZMDlzYjQ1dUZzM3FIdTNrVzNWelppMU8z?=
 =?utf-8?B?aEM0eTk1UUEwZWQ3L1NDTmpVNVMwckc1S1lZOHJIb1pPNFRpTy90aTd6ODNk?=
 =?utf-8?B?QzJSSTlqaDJ4TGtNMDJCdmlBVVVqcmhQaHcxMDRnbUg2Ty8wMkxMYlc5WXZV?=
 =?utf-8?B?T0FMenBLanR4SzNVYjNSYmFRamhtY21yMFFpSW5PdFNoN0ExcDVJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c19b4cf4-9b2d-4f41-84ef-08de7f88c9f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:11:01.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZINW7rJ1Bkg5O4C3l4h/FRKDnviDOyXJ6TIzSuvJYv7nZa19PPzCIqdAnrCqxV4O/A6wIhN0XdplSHjeD/Cbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446



On 3/10/2026 5:22 AM, Joe Damato wrote:
> 
> Previously, commit 8388f7df936b ("iommu/amd: Do not support
> IOMMU_DOMAIN_IDENTITY after SNP is enabled") prevented users from
> changing the IOMMU domain to identity if SNP was enabled.
> 
> This resulted in an error when writing to sysfs:
> 
>   # echo "identity" > /sys/kernel/iommu_groups/50/type
>   -bash: echo: write error: Cannot allocate memory
> 
> However, commit 4402f2627d30 ("iommu/amd: Implement global identity
> domain") changed the flow of the code, skipping the SNP guard and
> allowing users to change the IOMMU domain to identity after a machine
> has booted.
> 
> Once the user does that, they will probably try to bind and the
> device/driver will start to do DMA which will trigger errors:
> 
>   iommu ivhd3: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:43:00.0 pasid=0x00000 address=0x3737b01000 flags=0x0020]
>   iommu ivhd3: AMD-Vi: Control Reg : 0xc22000142148d
>   AMD-Vi: DTE[0]: 6000000000000003
>   AMD-Vi: DTE[1]: 0000000000000001
>   AMD-Vi: DTE[2]: 2000003088b3e013
>   AMD-Vi: DTE[3]: 0000000000000000
>   bnxt_en 0000:43:00.0 (unnamed net_device) (uninitialized): Error (timeout: 500015) msg {0x0 0x0} len:0
>   iommu ivhd3: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:43:00.0 pasid=0x00000 address=0x3737b01000 flags=0x0020]
>   iommu ivhd3: AMD-Vi: Control Reg : 0xc22000142148d
>   AMD-Vi: DTE[0]: 6000000000000003
>   AMD-Vi: DTE[1]: 0000000000000001
>   AMD-Vi: DTE[2]: 2000003088b3e013
>   AMD-Vi: DTE[3]: 0000000000000000
>   bnxt_en 0000:43:00.0: probe with driver bnxt_en failed with error -16
> 
> To prevent this from happening, create an attach wrapper for
> identity_domain_ops which returns EINVAL if amd_iommu_snp_en is true.
> 
> With this commit applied:
> 
>   # echo "identity" > /sys/kernel/iommu_groups/62/type
>   -bash: echo: write error: Invalid argument
> 
> Fixes: 4402f2627d30 ("iommu/amd: Implement global identity domain")
> Signed-off-by: Joe Damato <joe@dama.to>

Thanks for the fix.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


