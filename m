Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94175662
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 13:17:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjhRHHs2196Q1iJvxgMqqzmdUxJu87tz8rEj4dMvZTI7OEeRutwkadKUxuDfyIdIyIF5PmUNT7c2Gfq1cJKcfhHnUbnppQN5AMA1UUEDkE51WVKPu9pnGqvAzM9FHzhVQssgZv5o8Ltg/E+JpxoSrAf/y3IVqViJK0YSn30zXPP13a0Pf41bNOC5ZKx/xXOuegSXf9qjnt2EyUbJM6rCvx0q25zNmLDUWedo2Hko1WgDgMfpTyex6gF0jPfirQsHzLNxnUUQoLDFLygcRrqJufqEBEo9knGlHbRXDdmh1VQp+WIYWTdb0jrgsAl5bFKSsaN3sX+guxfSyEwhH/DtdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXkIfdezh99ygLEwdlJse9uF1E5CwcofU6urmNk2IL4=;
 b=S+UBzrbDIpOGkKFw8OZYc1o4ZIoOS4VHVhIuUvjdUBtT4WQJz30UhXqo6l/mVJl1HgdN7TOrtGE05pWWIv4iHm1TndlpuRHNN4n8yGDDElUCS4xUEFPlZlFjgsx4efPdAGQenloA0zfIAT0d2S8elViyYpk7wKbR35m4nyxAIXm1DrltZA1RIfMn6Dpk4MG9FgDX3Ej+jLszCcdlepk9sI4xm89Q1JlOhk/R5jHMh7CTzSc95ZD7xIqMHvMXSdrn50QUokJOgWXe4EKu8I2nYOT0wBRydjH0poLbkAUleNd+efPUUj3RN9InhVkkTT8VMlvT4O1Odz+BFiwcezAuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXkIfdezh99ygLEwdlJse9uF1E5CwcofU6urmNk2IL4=;
 b=znlq5+eHMOyguvozgwUCXQhkoTvIxG4qnHEGq3VeNijUf2cNR0jo7W5JQ8GMbv2A9ZJ50DqfH8IwiOV5CfrUGouiJmyBqLjIel1K8gr7+yTWhzfJUziBKR7Mz1C5lMT/NkkKbC4gDtPd+AjLq9a962WuB5iXU/y/fjI05NyPHlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 13:17:23 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab%8]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 13:17:22 +0000
Message-ID: <7d8c2ce2-f36a-6565-edbb-c68d213933a6@amd.com>
Date: Fri, 24 Mar 2023 18:47:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] iommu/amd: Add 5 level guest page table support
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, Wei Huang <wei.huang2@amd.com>
References: <20230310090000.1117786-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230310090000.1117786-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0203.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f2e7d89-b65c-4a2f-9e99-08db2c6a1a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hh6m4s3nxXAZsIrA+sdczxOiypBaPOHuKdjXIY+84jhVzKstd97Qp4cBrh6OVXG2Um/ZIjuv3ro2JO72T98X8R1/LXcqPSUSP+8eHuJ1BOj0kUvkKewEkNl72BeqncKiIRSx85aMunSLrllrI5wA6er9/5eSHjZjdKwHiG6X9V6h38gJPe/pwmhKUCK4+lyPgNYS8KiRaBsZsILp1sjD1t33AlHMTIaADbzRgBD86zed3i5jw2M9k108K6lMNrpAu2a5Ei1qeL+jOuSeTxVqhwLN8S9yIGt0NrRiUMuT3HXAQZqGirWd4ZGN79DpIiyCNYbiProHW7V+Z60goSmNXa0rWsd2c4tnzHbHf4BseZuP3g6Q3DuG5nFF/d/diIzNKmRl1A9d6dxEWgPMfWdNPuboEGSwlVC+s7D1lOAaoVBnPhUFJjDJogFks+m2Rtruug0iD1r9KQfw+U994QIh4UJNglJmyn1wBMJ6KRSCI7HOhWKlOQ7yXLOh2FCNzm5cAVfmliUXE7wxjKfzDqjTmXIUyaNL5ac2lIdkjR6JXkEW2pu3eS+7o/VQ2SSCanT6CybOtW5MyUJwDQVouXGWhG4r0Viqrm+A/D/nWtF0iDMTO78Ia4mIX7truzPyuBPs0u06IW6LdJmUOR4dEpU4pxn4KR3Y3FF6boNOpHvW+uUKMtnABPGU+3PJTg+ncE7JTUFHmta2n0yn+Hou/h59XP2EMTgjlTMZAMMq8NlR9RQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(36756003)(41300700001)(66476007)(86362001)(4326008)(8676002)(66946007)(66556008)(8936002)(6486002)(316002)(5660300002)(44832011)(2906002)(31696002)(53546011)(6506007)(38100700002)(478600001)(26005)(6666004)(186003)(6512007)(2616005)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dRdzJQSE01aHZRT0RBQmVZbXZWSCtPdHU0N1BqWlAvYUpSckZUSElJaDZG?=
 =?utf-8?B?KzU5aUI4V2ExK200bXdMYkpMNWdlY0dpNWlqY1luM3hsNUJaNEkwNCt3cWt1?=
 =?utf-8?B?bWZXYXpZbVhFMzBMM1dycDQ3dWNJRkd6ZW12ekhRWSthQjdENEdTV2ZQbGR5?=
 =?utf-8?B?bWRvTUNnWGxUU25RNXVmQWwxMFV4YlRlcEgvUm5aTU1kUnVrY3hYZjhFdS9C?=
 =?utf-8?B?YkxCMVdqWG5qN1dEOVJKUm1sVFBWcWJCSWVwT2pPekpkNUhSeVFzNlNQdUFF?=
 =?utf-8?B?VHpDT0NaNUV2ckI4QWJzdzl0TDViV2liTlNmNWdhLzJlLzVvR0ttVmc4YlJL?=
 =?utf-8?B?VjZ6TkxxeW1JMEhnUFpMRjlUeEduNVJsdEh3eU1YYVV2SGdzWFVVdnVMTVVi?=
 =?utf-8?B?OWl0UytUTUpUT0RjMnZUVkxGS2oyQnlzL2lLOEIvYXRpb1M1a29XQWh1UmFH?=
 =?utf-8?B?dDBJcXE0V3o4MURNTXAyWnVEeFlzODlibkpLVWloNE9iV0Y5RzdYMk52RnRp?=
 =?utf-8?B?Y1VWa3NGWERrcGlJRU1hUmkrUllmZXBTb0FESHVoOHMxcXJmZW5RellseHpo?=
 =?utf-8?B?TWQ5M2JmZVdxOEVvVndKY1ErMGJVOWRDdEI4NFBGbXNxSm1SbUVoQVNyQjFx?=
 =?utf-8?B?K2locGFGOXp0T0Y5VzdiakgrVFFsUVRYdVhMaXd3TFQ0Y2JWVG9UNFcyQm9P?=
 =?utf-8?B?KzNVKzRLa1JNT3piYS9aekhyTnNuUUpIMFE4NUJGSDRsZXVlM0hQM2FiYmpD?=
 =?utf-8?B?WWpsVkV5ZytrbkxSZGowb3FvVXlWNVJLTjBtZkFvZjh3cTAwbjJuUzZ0SDR1?=
 =?utf-8?B?NjZQSC9PWFZsNEttMXN1OStnWXZXOUYzREhPSk1nQ1E2dDFCK2syL3BHb2xQ?=
 =?utf-8?B?WFRSSzdkTzZRaDRnSU90U0hPNzU3eXozcy9zVWtFVmpZMy9IdVh1ZkltVlcy?=
 =?utf-8?B?akUwUFZ5S0ducVQ4SEpmZXFtSlBQY3MxK05ZZ3FxMlQzMUl6YmRBck95d0tU?=
 =?utf-8?B?OExVZGR5Y3FMdTJoZXVmNXRnaHAweXJ6dDdaWGcrREhFRytBVlNmL2lKTW5u?=
 =?utf-8?B?YURNOTJoRk42VkthYjJZWFpneHQzSE44WGFZeEcrTnltUDhxTVdJeEp3SlZm?=
 =?utf-8?B?MldOd2FuTkp6ZGZ0UmNPemU1aDQ2a0ZjeXUxRzd5QkZoU0JGd1pSRFhVS2t4?=
 =?utf-8?B?dmxKK2hKT05tNmE2b29aa21ldm00VXR6SC9qcU4weE1RdzBHUStWUi9lckFS?=
 =?utf-8?B?S0RheDRqTndVa3pPd04vOVBJc25XckFTMFdnYXlZUVArRDB6cjhmUmU2K01J?=
 =?utf-8?B?ZW1LNjJERTZFZ2E1N2plQ1lwall1WXhVR01wRUJ5YWxJTUFKa2pyS0wrMisw?=
 =?utf-8?B?NGVYUlZJS1VmN09yTTI1T2llZUVVcERpQmdJd1dEbHJzLzFPNXgrSXltWG1E?=
 =?utf-8?B?V2UxRGNTalNuZVJZMzIxRjhIYW8zSGNTaUZjNk55MnE4NjQ3b0dVb3M4UEVJ?=
 =?utf-8?B?YTRvSVl2b1F6TDI1QXJEb2g4bHh5em9xWTVsQ3gyMEIzL3h1WHZGenJURmxH?=
 =?utf-8?B?U1dLZXJtQ2syaExkeHF5TG8xaFVzbDFFU3dOVm85RThXRVhZcGdhbTg0Wlcr?=
 =?utf-8?B?cm1jWlVCWEhUUy96cmxmblNZOXdrYmU5T0F2TmtNUkhKV1BsRS9vNGRPU0hZ?=
 =?utf-8?B?M1JsR0FoWE52d0JSNXJFc2Rwem81a0taNG4yeGoxbnFLQUVkUEpCREJBWmNQ?=
 =?utf-8?B?UVZzVzBPYkFoZXNaR2xLSTcxa3lyR0R5ZjJUZUhyRS9lNUZaZ3hCRXZvQk1F?=
 =?utf-8?B?bHN5eEdmcUo3ZnBScndZeGI4U3pMTWpsdWloMklSbFcxVC9JaXZ2bEs1enlR?=
 =?utf-8?B?NUZ2dW10Nm5BZW03YWdTNFEzRHlkQktOT1MxenNPdnd3akZWeEV3bHFKTkdm?=
 =?utf-8?B?Tjc0UVAzblA3M05VS1JyYlNFNkloblhKelEzVFdBWFJjNEFLaVhXQWZtaUx4?=
 =?utf-8?B?Z2ZJKzNhSFpKV05ZN3pzRytFbEFpWkJDdWhmRW5DdkJEUEVqYmFrV05UYUZv?=
 =?utf-8?B?dGhVK05IWkE2TncvYVJRb3BaMVdOTGloTVBNSzErNnRJMUdNZ2ZJNlg5eUti?=
 =?utf-8?Q?F0h1doFpl/H7Tca4p/ievB+Jm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f2e7d89-b65c-4a2f-9e99-08db2c6a1a6a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 13:17:22.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdPu51GQRx2+KsDcXHkTPibISOKqgrgSaNekz/bVoqi6h5/qUvrkZMAnb9+QGkwI+nwU3RaGYIQGrUxdWczeQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

Hi Joerg,

Did you get a chance to look into this patch?

-Vasant

On 3/10/2023 2:30 PM, Vasant Hegde wrote:
> Newer AMD IOMMU supports 5 level guest page table (v2 page table). If both
> processor and IOMMU supports 5 level page table then enable it. Otherwise
> fall back to 4 level page table.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  1 +
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
>  drivers/iommu/amd/io_pgtable_v2.c   |  9 ++++++---
>  drivers/iommu/amd/iommu.c           |  5 +++++
>  5 files changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index c160a332ce33..1db1c30aeed4 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -34,6 +34,7 @@ extern int amd_iommu_reenable(int);
>  extern int amd_iommu_enable_faulting(void);
>  extern int amd_iommu_guest_ir;
>  extern enum io_pgtable_fmt amd_iommu_pgtable;
> +extern int amd_iommu_gpt_level;
>  
>  /* IOMMUv2 specific functions */
>  struct iommu_domain;
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 3d684190b4d5..27f0d6499996 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -93,6 +93,8 @@
>  #define FEATURE_GA		(1ULL<<7)
>  #define FEATURE_HE		(1ULL<<8)
>  #define FEATURE_PC		(1ULL<<9)
> +#define FEATURE_GATS_SHIFT	(12)
> +#define FEATURE_GATS_MASK	(3ULL)
>  #define FEATURE_GAM_VAPIC	(1ULL<<21)
>  #define FEATURE_GIOSUP		(1ULL<<48)
>  #define FEATURE_EPHSUP		(1ULL<<50)
> @@ -305,6 +307,9 @@
>  #define PAGE_MODE_6_LEVEL 0x06
>  #define PAGE_MODE_7_LEVEL 0x07
>  
> +#define GUEST_PGTABLE_4_LEVEL	0x00
> +#define GUEST_PGTABLE_5_LEVEL	0x01
> +
>  #define PM_LEVEL_SHIFT(x)	(12 + ((x) * 9))
>  #define PM_LEVEL_SIZE(x)	(((x) < 6) ? \
>  				  ((1ULL << PM_LEVEL_SHIFT((x))) - 1): \
> @@ -398,6 +403,8 @@
>  #define DTE_GCR3_SHIFT_B	16
>  #define DTE_GCR3_SHIFT_C	43
>  
> +#define DTE_GPT_LEVEL_SHIFT	54
> +
>  #define GCR3_VALID		0x01ULL
>  
>  #define IOMMU_PAGE_MASK (((1ULL << 52) - 1) & ~0xfffULL)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 19a46b9f7357..f7f975462fe2 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -153,6 +153,8 @@ bool amd_iommu_dump;
>  bool amd_iommu_irq_remap __read_mostly;
>  
>  enum io_pgtable_fmt amd_iommu_pgtable = AMD_IOMMU_V1;
> +/* Guest page table level */
> +int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  
>  int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
>  static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
> @@ -306,6 +308,11 @@ static bool check_feature_on_all_iommus(u64 mask)
>  	return !!(amd_iommu_efr & mask);
>  }
>  
> +static inline int check_feature_gpt_level(void)
> +{
> +	return ((amd_iommu_efr >> FEATURE_GATS_SHIFT) & FEATURE_GATS_MASK);
> +}
> +
>  /*
>   * For IVHD type 0x11/0x40, EFR is also available via IVHD.
>   * Default to IVHD EFR since it is available sooner
> @@ -2155,8 +2162,10 @@ static void print_iommu_info(void)
>  		if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
>  			pr_info("X2APIC enabled\n");
>  	}
> -	if (amd_iommu_pgtable == AMD_IOMMU_V2)
> -		pr_info("V2 page table enabled\n");
> +	if (amd_iommu_pgtable == AMD_IOMMU_V2) {
> +		pr_info("V2 page table enabled (Paging mode : %d level)\n",
> +			amd_iommu_gpt_level);
> +	}
>  }
>  
>  static int __init amd_iommu_init_pci(void)
> @@ -3025,6 +3034,11 @@ static int __init early_amd_iommu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	/* 5 level guest page table */
> +	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +	    check_feature_gpt_level() == GUEST_PGTABLE_5_LEVEL)
> +		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> @@ -3556,6 +3570,11 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
>  
>  bool amd_iommu_v2_supported(void)
>  {
> +	/* CPU page table size should match IOMMU guest page table size */
> +	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +	    amd_iommu_gpt_level != PAGE_MODE_5_LEVEL)
> +		return false;
> +
>  	/*
>  	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system
>  	 * (i.e. EFR[SNPSup]=1), IOMMUv2 page table cannot be used without
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index 8638ddf6fb3b..0a302138b488 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -37,8 +37,7 @@
>  
>  static inline int get_pgtable_level(void)
>  {
> -	/* 5 level page table is not supported */
> -	return PAGE_MODE_4_LEVEL;
> +	return amd_iommu_gpt_level;
>  }
>  
>  static inline bool is_large_pte(u64 pte)
> @@ -383,6 +382,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
>  	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
>  	struct protection_domain *pdom = (struct protection_domain *)cookie;
>  	int ret;
> +	int ias = IOMMU_IN_ADDR_BIT_SIZE;
>  
>  	pgtable->pgd = alloc_pgtable_page();
>  	if (!pgtable->pgd)
> @@ -392,12 +392,15 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
>  	if (ret)
>  		goto err_free_pgd;
>  
> +	if (get_pgtable_level() == PAGE_MODE_5_LEVEL)
> +		ias = 57;
> +
>  	pgtable->iop.ops.map_pages    = iommu_v2_map_pages;
>  	pgtable->iop.ops.unmap_pages  = iommu_v2_unmap_pages;
>  	pgtable->iop.ops.iova_to_phys = iommu_v2_iova_to_phys;
>  
>  	cfg->pgsize_bitmap = AMD_IOMMU_PGSIZES_V2,
> -	cfg->ias           = IOMMU_IN_ADDR_BIT_SIZE,
> +	cfg->ias           = ias,
>  	cfg->oas           = IOMMU_OUT_ADDR_BIT_SIZE,
>  	cfg->tlb           = &v2_flush_ops;
>  
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 5a505ba5467e..a79a6862b493 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1611,6 +1611,11 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
>  		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
>  		flags    |= tmp;
>  
> +		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
> +			dev_table[devid].data[2] |=
> +				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
> +		}
> +
>  		if (domain->flags & PD_GIOV_MASK)
>  			pte_root |= DTE_FLAG_GIOV;
>  	}

