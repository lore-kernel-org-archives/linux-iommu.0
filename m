Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35B3E1204
	for <iommu@lists.linux.dev>; Fri, 16 Oct 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159894; cv=fail; b=ZtkK4miJ1be1fIboK1ELR4zbf9PS0icCqcrgO7aGJ7R5D+0FYSWr1GNeffAebxlZf7wT4iRtG/9DlRev8biwHstMTdD3RSF6pVcoujBIQYNMc9y2xXNOasvfCO/YpgKhiBcuZseepBUYtw62utnejm077qGORSLUfJVHrjkjNJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159894; c=relaxed/simple;
	bh=HSMAUIzgqXWQ+7khb2Sgg8DuFVxTg+6zf/9xfecOqgQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sm6vo89VDFotovdxb/HhkLDWiZzCZzlZIx6BlR8ok2KfFUysJNL9RRm7K7yEqbJH7NdAIykxae18/92vitunTMJSO7CTBtoqorSdjU6qN0CRjvX5Aq6JWLuieBP/o+fvGN/Dqmt9F1E6aZoXRgDn3sWA/I35Lx8NEB/Trbd7s7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=426GB16N; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="426GB16N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpyvMqegISmm+XsnQkzy/TmZ/X+AtMkVJ6y1PMUIM7Tz4Jc3BalJ6iOW7QlRer7KK298p5AI+hQlNuXJ5BeQttY5AJLEbukyTRr8PgZ2ODLKzDKeIrI9nWBwjr9VKenUnAa+LYxO12RSCDsV3stAzwRFuGWTvcia9NXkXtLVQKOGK/tJJQyKksD2Ckzq6McdZxmBBKt3RcYA/ff2XA2LBo9Czgp4imxacoe7t5dM1DEdx4APTFbi9L2PyVe/fUK30pOsYNTEz1iDoBBKdpJ8yOwGMXzhOIT2bUHcn75cHk6iSpVT25Ls06fO52jrCO8bjMTJjmcJeYwGxJNb18MRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kjqx7bonlTr8ko0esHpDVni1Bm8fzych6RIJ1G7YzX8=;
 b=qtSVKxA9VDv6Rgk2d0S6i4pm0qfwdAR9MZafnLqDDHmkoi6AzRv4j+ohoc+m6qRjdAPP+4qzzXZeEm6AFitWD1YshoobUcB4aOP7nSFVLgBq05YY6ED8EAUCMTm2mmj71qL5LFsZTa7s1AlpF1s1izGSBpeML2xcbA4ggqqVxLRZO0/sVkl49DRyHHxHpAYTCWS2jtGTlgxR2iHmW2ENHUhHGWGhtC0fjYUX6HAbmvvOMlZJ3xsxurDf1hzquUAmEUQioLI8UophLGWMH9JTrRKnDlryqbdq6exltmPEx7hTBvLcSQLvnUfEv6BB+lkmT4pcw9PY+4uz0GzDS980Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjqx7bonlTr8ko0esHpDVni1Bm8fzych6RIJ1G7YzX8=;
 b=426GB16Nr1+LKNJN+GhDdye2r5kNTWxfV2xldVwtqqaAbIt0KUHuFbjxQysb13iW0BnObebyQkObRfReaT3qp4Ro+QrzQEF7AiPvQi+94Bt71uRnCBhdMvlY0Dbw+J1k8kZKC4EYxlPY8lxR5FhOQ4qgdzamAqHc4HT7/9awIqo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CYYPR12MB8890.namprd12.prod.outlook.com (2603:10b6:930:c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 14:11:23 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 14:11:23 +0000
Message-ID: <29b82596-b8a8-44b3-b1db-f438c5d18114@amd.com>
Date: Fri, 16 Oct 2026 19:41:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Make Vasant Hegde AMD IOMMU maintainer
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <20261015160119.1005966-1-joro@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261015160119.1005966-1-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::6) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CYYPR12MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 71aba2af-ff6e-4e0f-eabe-08df2b8f5c26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MG/puSP0ddCofQqfi6VTrDMWDKSJz5bmogLuWTbMcA0uIZe3i2TWRCbb1FFz2Oo2OJihgzBoP9U9UQ4ElUEPJzjYn9S+H7AOwLH9FL3i9uC31g97DDxi3QLyLpyUUkQlTKRMDoYoTwH8GddB4rDV/4QQluvVL8DzdAF/an93QqpJPsFYb4YU2lGklw75kvF5skyH9ubUFODSqvV5xo7ALbSj/tbP6VwHpjOe+jQ8Q7O3F2m4ix+ZSVw6SPbi3MygLf/LkijgQauFnCyrznwWKQXavnVQwzSC6olEizs2YotZ0DdC6j9xRzSr4TqTiRixhJTA2ZnW9xqjKypqrWTqs8Q5zDuP72au8NemjQCXl5NFkCONOB88kVC4yTaUYk8GC0xP7wojzk1LMI6pG7+uegYm5HXDFsBPBXyoHYeVTAXuqvBF2j16qgmL6zfskoCQS99zbzq12ZDrCk4Xs5RfsiX89TyvQDOrWZ4GsPUxS0oWMzqtTcfzvmhCwqzU++UXCya7gZn9acdzRQ8mfxfYujjAJD6xj2B8jepxJVb3SPPHW8yXm6k5vL6dDj7AIZzl4s8w2Xk+3AFeB62yA2PbQkZ86l83y1VDF6eYoGmLQLftUfg2llNIXFuxbsbQ3g3tCnagmtqNnUg+REiM6tej8v0nyryJWxzDOfP3S0ULcYg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjM2c3J3SEhNK3ZVRDl2VnVoVzZDSFMvMlhDdzlTT1dETjBYMVBlVXQvNk4r?=
 =?utf-8?B?c3FkR0RwY25ZMW1EWEJyNmlYejFtRy8xTE5HYStCWHVZVGxRVGVXREpHQTVq?=
 =?utf-8?B?ZGNneWFSMUcwU2VaUnVlL3F3RkowTEhyV2ppOE5EWWs4ZEMxWUgwZ29RYkNl?=
 =?utf-8?B?KzE5b3BMY2pDMTRFbXRtdG82R1JxcG9pSGVHSUVMUlFmeWd6dmFVR2N5SVJr?=
 =?utf-8?B?QUJYb1dJM0p1R0FXbDN1TzhzMXZwM0xVcmlyVGFSUVZUcEM0bWp0b2NYT2Z3?=
 =?utf-8?B?ZUlHbGNmQmVuQUFIa2VJZ1NkOUt2Y2J1K3poZGtrM0xDMHpDL3g1clRremlq?=
 =?utf-8?B?bWRDYTR3L3FOZk91ci9xN1hjckRKaWJPUEdweUNUU09PSGZiYllVTlFua3A5?=
 =?utf-8?B?YXdZQ1gxQk1RbDJ6UCtzRzVoNThOL1JZRjA3aXJDeWV6WFRxcXovVXJ5NVNj?=
 =?utf-8?B?WUJWUVB5RGFNWXhyT3FIa0wzMC9lb3VOZkhNNEMySXU5ZEdDeUhhaUJsS1JL?=
 =?utf-8?B?Z1BHRXJjZGpHTWxUbGJXelhteWdiaWR2bm9lZjhtb1RwYjFFQnpENnlXMlB0?=
 =?utf-8?B?Q3JCOUtXK0JPZ1JCeDlSRGp3bXBzNmlUQnNHS3FJMTU0UFE2MDJiajdibEtz?=
 =?utf-8?B?U3hYYkZWMGtmVVhDazl5bDB1RnVvRFVzSFJmbDdwZ2hhTXRlckFtK0R0N0NB?=
 =?utf-8?B?VnVZQ2paYXQ1NVBRc3o4U3hWaVZ2bHhGaEsvQno5eTdPQmowOC82RUlHeU5y?=
 =?utf-8?B?cEJmdGtOcWZZb2tUUE44bk0yY1luUWpMTGpBTUp1NmcrMlRUdmE2ZkZRUnVM?=
 =?utf-8?B?Rng5a2VJSnJBektCck01QWU4MWdNeGZuT1pCMXNhejIzcUJySzJ6MUZSMElk?=
 =?utf-8?B?S3BseVltNlY0S1lORmdyNjdnaGhqaHpubEw1NHVFZkVCZ1NtT2JZVk1PVkJX?=
 =?utf-8?B?ZG9oL3IzMmR0dkxSallITFVvTnEycjRmUTdtd1AxaDF4RVJaRFc3V0dwWTBG?=
 =?utf-8?B?N2hQWVhqSlJkMGF1Z1NRdTY1Z1J3SHhnWU9pbVpWMjNwNlI4ZDhGTjA3NE9k?=
 =?utf-8?B?RHlWbStzb0dBdnMrN2VVN2EvVGlLbXFEZGNRK2RJQjZOS3UvRG5ZS3dBTXh0?=
 =?utf-8?B?U0x6UDBLNGNaWm9IOUpaMU9aRW9ZN3RHMnhJUmV1MWV1eDlLYldkUDRtOXg2?=
 =?utf-8?B?VTRvek50ci9zbUFVYVFjREo0RGZZYWZHSnFqOXhRQjBIazlDVEFmRXFGeGZ1?=
 =?utf-8?B?d2V3TnArd0lqakdvRnN1azhTWDhoTXl2dWl5dzlnRU5McXpqeUowUm01bytQ?=
 =?utf-8?B?c0d3UVpoRjBNdmNQMnRIL1I5NVNBSGhrcHNQeFJzNkFFcXN5T0k3eFlCYWxJ?=
 =?utf-8?B?S1JST3pXTy9zeHJBZzBYMUxzUURxaTZxbTI0Yzh4clFyeXQ2cUh0ekh2S2Fj?=
 =?utf-8?B?K1phSm1mbmdYdEJ1Nkdub2czK2IzZkVldlZVWlg3dkswQ3ZsbllLMnBrNFc3?=
 =?utf-8?B?OEd2dGVXc21XODkwenJZYUVQcENyREpQaUdsVlBXUTdSOEl6Y0E4aUFUcC9z?=
 =?utf-8?B?bWRMcmQ4UU5CQW1nWGl1MG5zL05GWWRWTitTTDRqU284OGJNNk1ZaUVWRHRh?=
 =?utf-8?B?NGVZV25CVlZEVTFsNUxTdldLNjAxVGxWUUIrVzdFeU9ZamladzJMSUtaUWk0?=
 =?utf-8?B?NHdQbW1ZMUViWXViOXNMZ1E0VDVqZTVoUnQrVEczWFRKTlJvb3psendyUEt4?=
 =?utf-8?B?Um96RmZmbDNZMTJ4QUZlN1JkcDR1SkpsRWNNZTdCYW1TcThkU1cybmdvS0Nz?=
 =?utf-8?B?R3ZqOVhyR0w3RGF2am8rdGJybWNDWmI3M2pXVnBFdVZPVEZHSzd0VTh3V2hN?=
 =?utf-8?B?QlYrYjBTVmhUbEQ2K0NxQVFPUzJ5cEg3UnM5b1lpVU1zOXpBMGdKbm5ZelZG?=
 =?utf-8?B?N2M5TEpUYm5GaDJ5cDNwSzV3MndGdFcyVktiYXJPMEwrNTZKOTY0WUxTRHN4?=
 =?utf-8?B?N2tOLzNoQXU1Ris3NStXemRSL2taOHhyU2NrTVJ4QzFja3NVenQrR05SNHRz?=
 =?utf-8?B?eC9hWSs3bEN3RVcrTlpQeXFacXlHVTMvbVgvUnQyM01LN3Y0MlRQRG1Qb1lS?=
 =?utf-8?B?U2VVY29NQ1Btc05tT3ZJN2J5SHFRM1d0LzFDRkhveHZ5NUdONnpVMmFMMWNy?=
 =?utf-8?B?RVZad3Uzd0ZjS2tLS3pXNFFtZmlmQXZQV1Z1dVNTdWRVWHdtb0xrMlBuL294?=
 =?utf-8?B?SVR3TGdYMmdBblA4dUJPZkxiTmlJNENTMHJpNzF5SDVubHBDQ1BPM1NtN2My?=
 =?utf-8?Q?RBkChiLlSjbzvSO96w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71aba2af-ff6e-4e0f-eabe-08df2b8f5c26
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:11:23.7972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ru6TmnkXpKVZWTKoZ7Kjy1qDZYsWe8diGL9q9/kJKO9uZ/ghB2gSeCFDYpPsa0Hythldx9OfHp4uN+jVP2tcEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8890



On 10/15/2026 9:31 PM, Jörg Rödel wrote:
> From: Joerg Roedel <joerg.roedel@amd.com>
> 
> Vasant reviews and tests most of the AMD IOMMU patches and is critical
> for maintaining the driver. Make him an official maintainer.
> 
> Cc: Vasant Hegde <vasant.hegde@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

Acked-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc3cae2e378b..64052e51c3cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1181,8 +1181,8 @@ F:	drivers/platform/x86/amd/hfi/
>  
>  AMD IOMMU (AMD-VI)
>  M:	Joerg Roedel (AMD) <joro@8bytes.org>
> +M:	Vasant Hegde <vasant.hegde@amd.com>
>  R:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> -R:	Vasant Hegde <vasant.hegde@amd.com>
>  L:	iommu@lists.linux.dev
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git

