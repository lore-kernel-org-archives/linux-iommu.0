Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC73631F99A
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974962; cv=fail; b=p4d5qzGod4gfasT5+CvbGYMp/CJp3+NwlfafYdzcvrILOUimRhpgNES4nzvo6YMrPUj/sREzFK7g25dJ8PYZzCNpXrguq2moSweyvHWJIb1pFCPpKPQ+d6WVJ89DAYoxmEAd/hXYKSvS1e6qnMG6ECWVBpjhANEUkTbflXx3+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974962; c=relaxed/simple;
	bh=LfmXpEJgb4Ei9OjlOqt8xy4fgtbCJJHxe3CyRF8uW6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JFLsAWB1Tm2mbIHOrvzKfHulQKd79mbmYz50N2fTx3pyrOt3GZWj699vxsPkWZRC3oGleWEHE6V19ziU0Fn2nd8qmGc16U6BJgJ4qtI02SGJhAC6yOUbIOmlEv1zW9Wln6BJWSLh7XNsmu1ePcKVx6iQ4TxdF0NCVg0Zz3+vIPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QEvmSf06; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QEvmSf06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOHhlcaCRnvnUT9+qqYe1zspGEwib3fi4d3EaxL7+36ixB7EUQUFRq4tK8NLZv+5aXBnfV240pQJbhaHFOnwF7wwpk+7AB1lJmsz5unPVw3ElCL4iuo6L68xZ8jhYUoHjQ1gjFh1yOnAHnsPpneZqSjDDzjPME2A8isyzPw/S8lAcwHA4VULJgNelOyyXi6vcU70csncdlH0/wS/leZD270YEcHOKtPj5lEE4Q+/kdP9sh3zBymLhqImO3ZOPw8HQhYGH45yasjfVqIw91dj7RoccEmxvGzJXKCS0f01v/7aVbciEG/2RYYJGA8QlamG/K9VjnStYQl0MDw+Ki9v1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbwXTYHb5oAqCyu2nWsCtn61JkxZ9kGPNq6OKBsdJPo=;
 b=HGtEA8r5GMDRn/UL34Rnx4zYuJNYIdlp/S2M7wIeRhGioARX36V5U1FcnfxvtyBlyNvk4elGp4BXpGbYsfdBFrx7IPKg5OE7PvUWE4wEVX3TCqMkMpvD9i/nZ8gLREl2Sy7/977c5d/uiVEhuskHlGbxKEo9UO30oQN4ZVS9xkm+PqAHqz+G474DBv9JxBC+fcS8wiI5Kz35yk2QSGpKjFfRa3bpR+asdaXmLI74WKdS2IfBiU3cE0TeH+ryeVtOOZOO/DHJz/Egy2uSLY5tQqiuJrTGHH2PPqo2Pss195lOuFkcvxHsd9L2JKtftO2nO19KwuOzRbBk/CdTZIt8Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbwXTYHb5oAqCyu2nWsCtn61JkxZ9kGPNq6OKBsdJPo=;
 b=QEvmSf063xIJyU5LI5rCqFllcraZO96ulsHy78MpoJAaUadLugPXtxWKk0SMJDXFbNrMif/g7HGhOO7JUly5Zw+AxpzsZYks1slHHGDpGBglRy6yCtLeSeZvTf1zU2EHY218ISaVwghhkZKOBj9dNO0UswrBia1F/lvma+APms4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0112.namprd12.prod.outlook.com (2603:10b6:510:27b::15)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 09:55:57 +0000
Received: from PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333]) by PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 09:55:57 +0000
Message-ID: <655fd173-5dab-40c2-8f77-8b3e891a1c40@amd.com>
Date: Tue, 5 May 2026 15:25:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20250315030928.2373250-1-seanjc@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250315030928.2373250-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::11) To PH7SPRMB0112.namprd12.prod.outlook.com
 (2603:10b6:510:27b::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0112:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 62f3d78f-74b5-48d3-c213-08deaa8c8147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	j3bhOXYYkP+qdKGy3xgE19exmTzIEfkSbYfGiIm849vsXQ1fjlKMWrBY5SZQsuHBH4dI4SvZuYGw0A5C5G9enXohFUL4FhlmIAunwxHXnw9bBFKuLqhErq59iVTFyWDGZedtrPQC1TuXpK5qUu0ipfNKsdgbMKmgBg+J0Phbu794Fljb7Chkl7mn8SP+EXL+K4TvfYJGz9QZrAZmSyST8kLDebNblaLm4hMqDes+4N3lVaymujmzo4CEvArqyKc265maG2nou/waIjJZlKvQ5i4qW8095TehcRw8Q9q+MFuPaWmoTQvRJcEMGTeKqY3DfNiOSF/WUCg3P58OBb9Muo31egDU/sCaOpuVHGYYxxOAzs60BIfB8q/mtysta+X4mtf0ZpCQ7J6WozE4WZTBNBErQF9kacIDKnkXQK4dtKZqCYiV2ED6aXH1o0CemW1hX1acYaZ6D5MdhSQPP+xOzHyDCdd3Xhn5j4yok+2xQc5woLDSAGplhuhD+8mIpRhMLhxBGOL/B68GnGx+5flqGVF7SF/alDZl/SvbPa0r8Rib3C0ZUo5G2GtLYp8KCPhPa00cKv0HRFZ7j7eaQGhOt1sdviZcdX+1kRbs5NEBwmjHHm+rIYtM5/2QGqbTg2bzKakadM6HazgyX/MaUgRDONDNPUn03Ax/gu9qvw/fYgnK531OTuSkKRWWeSj95j6J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0112.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek55WFpjWFFWME9DVXZGSGtxM25sWW5FWjhGVzFuWXI5eEJ4b256K2Z5NDRN?=
 =?utf-8?B?c3JHUTRUbGsrOThEN3lmZjJRQ0QyeEZzT3Q4d2hFay9UVStiNDAzSGlUK2pZ?=
 =?utf-8?B?NU1uUUdycGhvSjFudjJIWFNtUFZEQms3YnBGeEwxZzQ3K0doaDdvc04yZm10?=
 =?utf-8?B?WXZ4YkFJQXdYM3JJZ2VnVmUyUFlaMUZ3ZVNSTXdVRW9iRHI1U2xUSGVvbU02?=
 =?utf-8?B?TWZFYjllV2V3cEVFdUoyd1pnb3dOaDJWVEhwbTM5ZVlzc3V5cnpLQkptRVhj?=
 =?utf-8?B?OHQ1Wmx1THB1SUF2aksvRGtQNnhhL25NeEZTTUE0K056L3RNbHBnWjZiL3Np?=
 =?utf-8?B?Z3NteUhFc2VZd1F3OGdRMWR4VTl1ZWUyTEtneklkRzNXN1pLV2E2bk13NFBP?=
 =?utf-8?B?VEVSSFhZd1lWY0ZMVGw3eW4yTGZ6dVFlYUNnb3h4RDY1L3BPQU9yNDdMQ3Ar?=
 =?utf-8?B?S3FJZWRaWTdLRXcwbFRaVWtqRzQySWdVN1AzZDh0bThZUXJUMlZrSHR5bUt2?=
 =?utf-8?B?NXNxRzFVcEtseWhZWHJ2WnVOMmswTUZDVjAvNUtISWtPL3MxOHJvSnBUOGlR?=
 =?utf-8?B?eEF4V250VUdrS2dVQ3RUdWoyQ3VyNlBWOEw4bE52bWNEeStwTWlMMFQ3Tmhv?=
 =?utf-8?B?b2J1aWVJRTVrZ2FUdEJtek4rMDFQeGl6bERhRTBWek1qMTBPR2hSWWdKcUtz?=
 =?utf-8?B?MG5NSmU4eTZxYlptTlNYUEl4VElHYU5QNHhTb2J3Uk5QUktHdlpCdHlLald5?=
 =?utf-8?B?UVQ3cmM1OENGTUdQcEM0SzhwQ1E1NFJnVDlCZXZ3QXNZejNObVdJaHBtUWhs?=
 =?utf-8?B?NGJ4YTA0QzBOd2xORFBndlYvblgyeERpWFhZR1JNTE14MnpCaVI2ZG5FV0xu?=
 =?utf-8?B?cmN4L0NUc253Zk0vMmZTTTJMaXJvQytSb3pRdVF6b01sdk5tbzdaVmJ5dExT?=
 =?utf-8?B?dFVOUXV5d0RiUVZLanZ1TWtpRytrWUdWbjQ4M2pZK1NEL09pNkNsY0p6V20r?=
 =?utf-8?B?ckdCUFBneEZXVjUwLy9SOVVqV2NQd0oyNk01cmxibFB4a0FmbXJYU2lCVmZE?=
 =?utf-8?B?S1NZZlpIaFZ5WFcrR1RhbVlBeS80TytIeFN4N2pHVUpyZUdjbllJc1I4QmFI?=
 =?utf-8?B?TnpqQ3M1QW9DaTlwYk1rYTU2SnF1R0VveEpwL0lxa1Q4SE01QXZKT2FLdDNI?=
 =?utf-8?B?b3JiRUE0T3NBTFB2eWs3ZmFWRGhtYzBrcGJ5NFVwM0tNOUNSSWtET1EvY0Zi?=
 =?utf-8?B?S0lacklXRjhaYXdMSXpYaXFSb2VQVlBlak5xK0tkTlBrRWsxcGhRVDJvd1pE?=
 =?utf-8?B?czlLei9rejE4bEduU3lRanN1SkdzR0NIeERjTFByc3ZZSmVXa2x1aTdKUENG?=
 =?utf-8?B?SWhjeXJiR3FhQTJOcE4xR0ZmaURPcWIvMFB2ai9FMGEzMUZxQU5ubUI5eXpy?=
 =?utf-8?B?WUYvZlBVL284TnB2U2Vmbng2YmltRlVsNVQ0N0ZERnh1OUFJdXVlUmp3TXBs?=
 =?utf-8?B?N1F5Z2xFekswbTdxNmVVQVlyYjF0dEE1UVN6cFdvak11N1BKc3VzQWtPWEpB?=
 =?utf-8?B?d0g1Y0ppTjhzTUFHY082QzFWYkZZUmcwdE02SFdEL1hCdkt3S3NSdWlXdTdG?=
 =?utf-8?B?YVFrbVp3cm5BcE5qR1VRQjh3Znkvc3RyRHN3d04vUjEvOTJFVGlPRU9OUUVH?=
 =?utf-8?B?RVVPb1l4UCtlSFFXSDJzOGdHcm9Kc3B4RlJQOWI1L0IxTXpXWGZ6V0lzeTY3?=
 =?utf-8?B?a0NXQlFwY3hFKzJGRDkzd1pRZXY0UHFHSm5INHV3SUtBT3FVRWhoelB4VU1k?=
 =?utf-8?B?bWM0aTRnVXMwblZZU0J5a0FoM1FNY1dhdU0ySy85ZEZJL0FJQ1pFT0krdzNL?=
 =?utf-8?B?VXIwek0xUk10N2ZRK1lVRVFYaGpBdGhUKytaQTZHaGczLzRmTHRvKzhXUXpU?=
 =?utf-8?B?VzBvWG9zWktJRWt5SmdUcXdxSGlUV01DeTM1OHkzUERZYUtYNy9OOVV1blcr?=
 =?utf-8?B?SHRZNFdMODVjZkx3MXhLVUNKdUxPY0RRVVlMUlJVV1VleWZXNXdUWFlwYWpa?=
 =?utf-8?B?UnhGQU5ZRXJINUlESXVHMUFMOTBnemxnKzFtdHRGVHI1MXZKVXZEaG5ycjFU?=
 =?utf-8?B?Q2ZobnJrQm1lMTQ1VHBuOE1BS0lzYlY5ODRlK2tZcnpCUEt4Tk9hSVF3M0tO?=
 =?utf-8?B?aW5GVEdwcHF1MDliNjN2bFp4c2xYYy9sNmRTcHJnbFNydEI4WFdveWwwa2NJ?=
 =?utf-8?B?ZXg2c1NGWmZHTnR6NmVnNjJlakN0aENYYW02UTYvQjBYdHQzNGpnY3NJWXhQ?=
 =?utf-8?B?bUVFbExGdWtMQnk3aUJ5cFJCTzV3T1FYbEVqSk1GZFdPeEhGOStjUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f3d78f-74b5-48d3-c213-08deaa8c8147
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 09:55:57.5377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /4ym6VgH7uXSMeVQwNyNWvp/0mgU7mFfgP95G/N+5xhLTUt3jdV/TaThStISkKqzZfip1W8a+UtxJepPGUNDyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

Sean,

On 3/15/2025 8:39 AM, Sean Christopherson wrote:
> Bail early from enable_iommus_vapic() if IOMMUs are configured for either
> of the legacy modes, as it's absurdly difficult to see that
> iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
> skips allocating the ga_log.
> 
> Opportunistically have iommu_ga_log_enable() WARN if it's called without
> IOMMUs being configured to support AVIC/vAPIC.


> 
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/init.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index cb536d372b12..05c568da589a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  
>  static int iommu_init_ga_log(struct amd_iommu *iommu)
>  {
> -	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> -		return 0;
> +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
 +		return -EINVAL;
>  
>  	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
>  	if (!iommu->ga_log)
> @@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
>  			return;
>  	}
>  
> -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> -	    !check_feature(FEATURE_GAM_VAPIC)) {
> +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> +		return;
> +

We should move this down after SNP check. Otherwise we may hit WARN_ON_ONCE in
iommu_init_ga_log().


-Vasant


> +	if (!check_feature(FEATURE_GAM_VAPIC)) {
>  		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
>  		return;
>  	}


> 
> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725

