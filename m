Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3612C11CB
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773247021; cv=fail; b=COjzxqfLjUlYICyHJ8o4ZeiGFEXhJLnDoduPeOuHJJ0+JXrA9n1NcG033Sygk/us5VJTf9KbU1pGi5yccEBzyurE9oO0eWINxj4tgZVFm/gnfMEoy5zXegZAZwOgFY0StSt8BhPCRjmmZbnIQeJLLMXOFxQRwVIsMpRZGHAukWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773247021; c=relaxed/simple;
	bh=sjGovqaPYNdtnhOWpb9HZd5bhuamqSD45OhOQK7QbIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBDyYTEAf9Cj5zwaLNXMxNCe52xiXe2R3syx3wk7wscFOOL37FQz8PqDCEjf/iLG45Uplw7oCe7lY7DMfTMednKoj4Sm3akzd3QZyT4br700UwwlKUVLzzn6FxmzPmxuyyghqjAUWA/7e7hiU+nQ95TVxiXmhR7PjVCHs90oIKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5jVCvhqY; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5jVCvhqY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvxWPHMl/TI8PrxoD9IoN3EbxJbED+HeifJbhPlL1BdPaup626fKRh3EZ248sj9iWjMS+JEYPp2d0xf0JW0b+qxxAq7DOITZVcFxPLYMHlKWW9yfmLUwfMe41Ld89yNHxkKlF9NuZyJDd7Fx2xPv1kzyuCV6YLVUqngT0ORrkgMJzIhy4+C2T53V4qkORD08UHDWQkPUGTnjH3hclH3hLmexNavQ4LvwXan2btWTjjNBzyV6BtUP82Q/kRWRFvaNtaxWJpi7t3Tae9r9bvcwlwjqahm0noiiXzQeSpqEOA9qvVIRpCCry69kVuyz1coh5q+qhS/X9Ne9N+JepXqapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz5yOwNoe4DS04A6l3d47/hpQiWZi3y/i3KDHEzynXM=;
 b=hT7a+qX5e3ns3+Yn6O1nLFgjn8moo9L1SKSk5poaC38ufPDb4SC/tMlvMp1JQyJhWdCBA1AFB3P7brgnvmCLeCI/R0V4ZKDk6+1n16+LfDHgLIEir10bjz78WH6OT8Z3g/Scfz31BVr9QaQvXEP9UpmEQMFOUrm/KW6yyLGj747tJzoEtivIsrzzZMC3wtiamK+7r77QWDMmzNZ3B4dj3+X54fNw5ad8TltfvR9LL9zDRrHBU0Smg5xm2GIQxWzPGRD/FI9UR10W6K2hQQR499Y+GkmwyRKQiPSva/tfr0dWlPlxzQfZxIN56QMWdyaHauHRuNPy1ATlCHAoOdgmDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz5yOwNoe4DS04A6l3d47/hpQiWZi3y/i3KDHEzynXM=;
 b=5jVCvhqYbiC/3xzqXGoKCGJxHdTjh3B9f23mwBha8djEAmm1v1lTFY+XDvpotU5B+l1QispMehlYui7a5sKxOWwqDtoaDnooeWWP3QIGxqr4wfBVRZCHsmb0JZjUr2Kvx9dFl4b9Sr6xP2LHKpxbIOtMjoQpbCyOwhDTv2iSBy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.11; Wed, 11 Mar 2026 16:36:56 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 16:36:55 +0000
Message-ID: <182b6bea-19b4-4bb2-b170-9fa13e8bd841@amd.com>
Date: Wed, 11 Mar 2026 22:06:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iommu/amd: Adhere to IVINFO[VASIZE] for address
 limits
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <b1dc7207fbfc46d6bad89bc484d2034cd2bdd2db.1773058553.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <b1dc7207fbfc46d6bad89bc484d2034cd2bdd2db.1773058553.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::15) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ae9cb7-7a8b-40b9-9ab7-08de7f8c67f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	nB2KuQsR2iMsn6KMlB9+HNLwAsqLZAdo29RGkjxrfPK3Qs+1iDC3PmU3Q1YDR63l7idRUGbOoOYqN63ILvCRavM+1Fg7Zw9VDdPZzj3o1xafZGzFS0Cm22hIMBg+ZodGgtULdCs6ja4J40J6YG+oXeX7CQi385GPyZPDpulTKH9VIYsBWSPUujG20nU3UmnR08CfEGIjDgGUDSlg7wWXTgTewNNFbcuCmKCS2hi8FWxFnSIEars06VdQ1nOUHPWidMkSRr6kzSVCtOpPCWgNGQ3PH2Rq5WfQZZjOkVRinLGh6et5FggZCVi1im7j8Fv3OBrn55fEvunlvw6+hjOJFLgK+4ODf0VMQzgXnTftDI19wRr6S8jxFdMedJhe0d6H/xqCmsUA1OazdmX467I/owtP6LbMTltBlFvZXjsrhoStL5nRPSIvibFnFLyEGAHlY6oUtqCskcISJVYqFH3VjtW4lzKes7EMriduGr8NUtAL7iexlupgyfIzDvO1Uaddb1mi/JSD1zbG4aUzp0CWd1Skpycv1GBo61qRLzWrM53p0s+GLm+s0uw+u+AJWcZtCFgpM39vBozLmYhdGvbUmkCxn/WbRhwAcO8wYzn7BM20sZO6uppc3MBYb9BtbVYQtTw8fKrcT5mlWmM+bumteAI4V/bD4B2BkDY9e8kDS/TXZ20BQH05CXCXkmlHA6YM36i3kz5Y/bb+WCUq7CQbgxfss0gm3qDdT4uotzlQJJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2c4cmxTdWRYbFFSd2J5WElHWERRWU1tTy9QZUE2U0l0VEFoUHFncW8rNExs?=
 =?utf-8?B?TGpFeWNXaG1CN1VZV3lkaGljOXZha0lRUGxndGRUYjIzRjlEak9nRkJSOG8w?=
 =?utf-8?B?UXg2U1ppa0ZlMTh0cmgvZzAyQjJPOTlZV0ZSQWpnc25XbDdBQldJaG5YbWVq?=
 =?utf-8?B?cU1SRVM1TUlVQjg4R2V4NkVqWDZaK2xqbkNFakE3YmhBZHNqMU9mbHlabkNS?=
 =?utf-8?B?WXY2K0doaXZMVTBFS0hHK1BFQ29TRTN6d0MvMUx5c0J3T09lM0IvUTlad2M2?=
 =?utf-8?B?V0JlTkE5TU9OLy9KZWRVYkJFWmRZUUJtZGZINE1ZVFAzaGNRbXZwOUptd0w5?=
 =?utf-8?B?TG8zYXNEc1BjZWRJeW1SclRVeGFGd1NyMHZwSFUyaHpMUnhXUXFsSXpQTFR5?=
 =?utf-8?B?RVRGMlRMUUNrUDNlNFFCemZBWkFMVWgrb1UvUFQ3OUpvbCsxV0xHeXM3alA3?=
 =?utf-8?B?UUFvRDA0Yk9YVXNBeHg5Lys1OGgycDFUSjRCYTJETHFhWENXVitVRTZicldn?=
 =?utf-8?B?ODR4cjB4TklEV29kUE1VWklwNGxEZnZqZmQ2SC84b1FrUXRkc09YK3BYRThi?=
 =?utf-8?B?N3ZBRWdOazgxWmpZWmQwNWUzdm0yOHhwQWpvaCtOT2NnOTFjKzJrWUZLTFBI?=
 =?utf-8?B?TCtzK0hkVXkzQ3Y0SzJ6andEaG53dzVnTTA5WkhFek1JUm8rbzBIejAwZXZP?=
 =?utf-8?B?cGNZbHNiSUh5aWx4d0g0SEkwR2JiSFo0bUVteXVmMEZ4VGJCOWhwV21adDU3?=
 =?utf-8?B?YVVGOU8yTmliZ1pHbnl1cmNTNHZBekw2TmpKRmZtQjRuRlhEenRBVnJXa08w?=
 =?utf-8?B?M1lXZWErM1EySTlRM1BXNWNBaUU1NjQ5dXZOb0cxVG9yVGJncXRvY3lzNGM2?=
 =?utf-8?B?dXRHeG1yVU9NLzZqcmpZWUxFa2Y3Z0owa2IzMzh1WERYUmd6QzFvVFVJUHNo?=
 =?utf-8?B?OGR0bnp4cDFEd0FVSi9jMSs0S2lzTkVyOHJubjRUK2ZFczlsOFk3TUM0WStq?=
 =?utf-8?B?Snd3QXhqdTFZN3lLcm5YN0FGNmJzVk92Q0JaQk5kT0pqd0Z2cjBKem4vdnpQ?=
 =?utf-8?B?WUFoQmM4Q2VwTzY4RUZvY3FMdHpiK3pJVnZGOTJpb3B6aFM3Yi9VaVNiQUR1?=
 =?utf-8?B?RkFkajBBRTlLRFJzZEcySHJGMXQwSFlCMlFBUEFlNDRYZUZvaHpXU0FhMkhs?=
 =?utf-8?B?QmVFdnUvWEd0ZEN2RFh5YWJiZ3RQWHhZbGtQVHNZTkRxaVdGWXdoTWl6Q1hY?=
 =?utf-8?B?eFpUa0NTZ2d5VXNmeDBPa1ZSWTdHOXc0UERsN1VzeFRQbko1L2E1RFRyREN4?=
 =?utf-8?B?OHVETElkRitVYlVKbm90Zy9ZSUZ3c01CMzVycFVMMnZHL0diRWRzZ1V0V1Fv?=
 =?utf-8?B?SkI0OEtRYlFuVFNLZVduUmVURDg2aVYxTWUzLytCWFJMVUVDUUxEOGFwNk91?=
 =?utf-8?B?R0orVHRzaTluaU8rQlA0SDJwNllKQ09qSVluUit4M0pSZUhFY0VzKzhQZ2dv?=
 =?utf-8?B?TGY3Z3dQRG1qYzhaekMxNHltWlhjWUtHTllSb2V1YmNvN2YrSW9PVVBGMVNr?=
 =?utf-8?B?VmNTajdHaFNDSnZadmdLQkg3M1FvdEE2TVJVOFNMNWsrejViS0lrdXBuUzRo?=
 =?utf-8?B?NkxXQ1FjZXpvOGYxajI4MWFVTVFGWlBDalNnMit6SlM1ZGgyM0VKblJBM3JB?=
 =?utf-8?B?SnhBdWxIY1hmV1NSQXdOcHUyb2tuY3pjbFNieGNtaWE2VmpVSDYrbHlscWdo?=
 =?utf-8?B?b0FLN2hVUWMwV2NHbzVIUlI1Z3ljRXcydDJ5T1BmUkx5aFN1QTJDQjRwc0JJ?=
 =?utf-8?B?bDEyM2JmT09kLzVZL25ZSEFsakNMQm5lVU1pNThIR0VlNmxpWjN5Nmx3WE9E?=
 =?utf-8?B?Yi9zOFdEWUZDQWsyWnhaWEVUVzFZbkl2aWhwbUxkSTkyajVKTFBJMkxFYk92?=
 =?utf-8?B?YlFMc3RPYkZQOVRRWG1OaWVwS3N6anpUNFh5d3pCMzVwcWxMTjkvaWxoUlRp?=
 =?utf-8?B?bE0zWVhkb2FBUk4wVjNpUDBoaG05cVR4c2psMFFFa0xQV2ExRlMremt3elUz?=
 =?utf-8?B?amNpbzdzZllmQXZNNG1FTldUN0FxWHM3cDRTSlg0cUpVbjF4WUNlQktWRmli?=
 =?utf-8?B?MzRNVjBNVTRrSE9hQWZQbExWbVZ4cXI5MW5VNkI5eHd6YnJldVZwQ09vbmNC?=
 =?utf-8?B?a2NYaUlrOTZqZmdabytvdCtzU2pVM3p3KzNuMHN3UmZRWUFQMzc1cUtLelNZ?=
 =?utf-8?B?UHREb1d6dytjTkJKRnVTTHdSNmVlWEp5SUlUeHFaNlVNNjB3QStLMHhrRDZU?=
 =?utf-8?B?WnA3UDM3WWZMMlFZWms4N0NrR0RWU3F0T1ZhU2lVb0xEZ3dNRXk3dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ae9cb7-7a8b-40b9-9ab7-08de7f8c67f9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:36:55.6782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCER35QtQfz1Poe0P+5zcFnTjPf+fwC9a9AElOyObHKU9J2KughFQFIt6YBTY/FARlfyjx34JwweNUVqHcx+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111



On 3/9/2026 7:35 PM, Ankit Soni wrote:
> ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
> size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
> caps this with pagetable level reported by EFR[HATS] when configuring
> paging domains (hw_max_vasz_lg2). On systems where firmware or VM
> advertises smaller or different limits, the driver may over-advertise
> capabilities and create domains outside the hardware’s actual bounds.


> 
> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 +-
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/init.c            | 13 +++++++++----
>  drivers/iommu/amd/iommu.c           |  3 +--
>  4 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 1342e764a548..f915938a3a08 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -41,7 +41,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
>  extern int amd_iommu_guest_ir;
>  extern enum protection_domain_mode amd_iommu_pgtable;
>  extern int amd_iommu_gpt_level;
> -extern u8 amd_iommu_hpt_level;
> +extern u8 amd_iommu_hpt_vasize;
>  extern unsigned long amd_iommu_pgsize_bitmap;
>  extern bool amd_iommu_hatdis;
>  
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index c685d3771436..6a85a38d34bd 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -395,6 +395,7 @@
>  #define IOMMU_IVINFO_OFFSET     36
>  #define IOMMU_IVINFO_EFRSUP     BIT(0)
>  #define IOMMU_IVINFO_DMA_REMAP  BIT(1)
> +#define IOMMU_IVINFO_VASIZE	GENMASK_ULL(21, 15)
>  
>  /* IOMMU Feature Reporting Field (for IVHD type 10h */
>  #define IOMMU_FEAT_GASUP_SHIFT	6
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39efb4..e874a4135d5c 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -152,8 +152,8 @@ bool amd_iommu_dump;
>  bool amd_iommu_irq_remap __read_mostly;
>  
>  enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
> -/* Host page table level */
> -u8 amd_iommu_hpt_level;
> +/* Virtual address size */
> +u8 amd_iommu_hpt_vasize;
>  /* Guest page table level */
>  int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  
> @@ -3188,7 +3188,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	int ret;
>  	acpi_status status;
> -	u8 efr_hats;
> +	u8 efr_hats, max_vasize;
>  
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -3218,6 +3218,10 @@ static int __init early_amd_iommu_init(void)
>  
>  	ivinfo_init(ivrs_base);
>  
> +	max_vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
> +	if (!max_vasize)
> +		max_vasize = 64;
> +
>  	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
>  	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
>  
> @@ -3240,7 +3244,8 @@ static int __init early_amd_iommu_init(void)
>  		 * efr[HATS] bits specify the maximum host translation level
>  		 * supported, with LEVEL 4 being initial max level.
>  		 */
> -		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
> +		amd_iommu_hpt_vasize = min_t(unsigned int, max_vasize,
> +					 (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
>  	} else {
>  		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
>  			     efr_hats);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 81c4d7733872..e8d15ac9b2bd 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2712,8 +2712,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
>  	else
>  		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
>  
> -	cfg.common.hw_max_vasz_lg2 =
> -		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
> +	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
>  	cfg.common.hw_max_oasz_lg2 = 52;
>  	cfg.starting_level = 2;
>  	domain->domain.ops = &amdv1_ops;

