Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011037.outbound.protection.outlook.com [40.107.208.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A335AC10
	for <iommu@lists.linux.dev>; Wed, 11 Mar 2026 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773246310; cv=fail; b=TsFCpb5W4BxkG9NEQUmU3OcNp5UAdu1pthUSxc/3v/QSS89QLkfTLqfUlILp8nwo+KJbKVjwwk7QjfvZNxWWWwTTfCMTE8/l/8mVeJhxFH5EoWQPpY/qF9tkb8pyLixUYwDDCS4s8PGG1T87NrxbSVyyI4tkKw4hID1r5qWK6cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773246310; c=relaxed/simple;
	bh=duwexS1ThpH2bzFT1nSzp+ZjwlsyRbptsKzvuWWpo/M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PUcH+cmgOhO4NjoCT6Oe+HFCQVlVM3dg7uGCKzwUy8vUs2pIAkjhZNh8mgsBpdXjAjkhadVYEZEY5GCant76D88vZrTMRHfizX2tVz16DeYNecJBcJrU9KNpY7fV3QwzVnRr6iKgBYmp/V0ePgG38N6H/0vFE3NdOKn1KUYafzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y+rWGqoC; arc=fail smtp.client-ip=40.107.208.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y+rWGqoC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWMvYFCn07aI4/ivdgDnq0clQwPy0IlzbyX7wfTe8/h6LaiAWwowuCfv2NWYYpNkRYfVzH0nWMBBgf3vs/M1WM6zSTH0pHoVxkMELCQQYr8IWHTZxwBttE4zLggruE+4XnTCPAGYrgkNIyOCEjwDACMWcurpTM8aIHlxX2Fgd23a5Bv/heOXBAc2duodyb6N53TPaWymdnO5eN5J+n5RGQXnIaH9fhsDmuFYy8LmmlTss24kCj7bZ2N36j7s2VOXlRKPyAbL8O40Hdb8n0l/tEQSiL4Rbq9CjGDW8QiGUK2TJhTk6oaSvbtK+0D5OLDzNlBdY3Cxmb/CyHZMrk36Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQwYN/YYejowcybzCnIT2a96FqkPsUoZ8xwaX0BSCvo=;
 b=mJL0nPbmjVGSvd9FAy2SboivtR4+vhs8DzpZud5BfwU5O7b50FnF14Siju7/Ij7UpTG2uJ8O4+wso4rRW5sp/tKKTJfHsXYSHXrDufcfSkQhDintO/rrKZFo3AUz9O3qykPHelArpPWrQ+la9bUBqVU1YRgjxn7SlimIoBJiGk9R2m7uw2fAcIVuCDN22JbojCsfdBHL1JKvHduiLxVBNJs5TqncDX0easpwVhyfPJhTiht0RFEDesPXwXhoDgc3DvuB81zryNx5ozy1CMagboKK38fdK85L81I7f0ubYtFX3opNKGiYtOrz9aoxpLM7P/A8PQeuwik+aH/xE/lc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQwYN/YYejowcybzCnIT2a96FqkPsUoZ8xwaX0BSCvo=;
 b=y+rWGqoCS4S7W3ZPrie5GU6ss1Oow7TGgOTUa9mpxXH58YwpfhMnUYl2YTtEsF+cYcLxrmSGEAx7zrn3mURfxsJnq1Yqs9uubDtiktwdhpSFgOg5gk47gDY2Z4BUB/DPU7C7/GRIqsEFpWDTjymPVnnO7ChHfKvJ1Pxe/i2Lato=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Wed, 11 Mar
 2026 16:25:05 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%4]) with mapi id 15.20.9700.009; Wed, 11 Mar 2026
 16:25:05 +0000
Message-ID: <ed1715de-951e-4794-932e-577aee2c76f6@amd.com>
Date: Wed, 11 Mar 2026 21:54:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iommu/amd: Remove PT_FEAT_DYNAMIC_TOP from
 PT_FORCE_ENABLED_FEATURES
To: Ankit Soni <Ankit.Soni@amd.com>, iommu@lists.linux.dev,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: suravee.suthikulpanit@amd.com, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org
References: <cover.1773058553.git.Ankit.Soni@amd.com>
 <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <0e71bed81bd7ce5e40a7fb24e6aab32dfb7de306.1773058553.git.Ankit.Soni@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000189.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::54) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: b34a6665-2e6f-47fb-1f0a-08de7f8ac0b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	22PcQcDQGEpCZUpKaE26draKwTyfx5EjGnM7lY0FVHxs/mgkoSE8qTtaZPzAgi8tyBHjHLD0IyRo8o9VsNlMIkDM7EZGLKQu+cfN0UeTwOs5Pk3SWbMD6k8YSI8lB4eikKbdFZS9xxH+NS6DV9WUY1I1qZa/aMFeX+4xa9bc+yytkpf46xqsqKSSILBBUoUCEW5AFUI9E78smPwZ0GLVtVA/myfx6MQprPGJXqeQ2tCFWag9aZDnRvsi5DnOnzoXW/Eg0NXdl/FS/EZasdapVzlTML0jsJIlGsuHGNatjxAaMsH8E6a+gjyfO5KhIKcboqEapRMa2dnOc+KOGBbY6Z3QOWMbUDjBzufiXHx3pLgr/PgvyIgzQVqriLnSYWLcnfsjcP0hr8jpK/e1QTMsxQiFj7g3MRLm0J8Ga/7yD1auB9VSEoRetCEd2o9/uNY3iyhP8CM9V0aj+sDBXYk1uHGZAItBNlrmzEdh+0cCUkFLefEL0M9dsx5P/u6AKk3qFScLF/DTD+q1eJLHSPW4TIUEXvjY8t5UTy4jDvICn2WqVPtczhRPiseIRXxC1es+LRBb0i3B3LyxuR2tuF1m2bz2+3GlGQEfKrL2EfqvKRKmBaGBYBaQzSA3nVNlmBZ5OJq0Xed92Z9XPmUs9utnYdn4q56q9YrplXHfNvOmKZGKcZ5p/8W/Rqt3ce79kz93+VHJBZojvoevZlHI75DzaV4P83DX/3RWvIW40dROBQU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3g0b3hHZUQ1alNFUFRDa0VtYXlEamxENWpBSmF2d0JDVmxKOHJDVnlPOVZz?=
 =?utf-8?B?Tm8ybWpaZ1ljVm9BcXpzbGx4US9pa09FT3lXS0x5RWdPK0NIMzlmdTFvY2VT?=
 =?utf-8?B?Lys5Mmt3QW9uck5RMXVmSFI5UjNLallPZWNzQ3NlQ2NIWiszdUtya3loeWRO?=
 =?utf-8?B?RzZ3UFd5VXBqbXNTKzQ0bUNXcjhWbyt5WE9mUUM1OXEvU1N2aDdnOW5pZ3Ay?=
 =?utf-8?B?WXFoSTI5bzlXODdocm4rd001SWNsUGM4VWdqWTQ1Z05SNzd3M0psUUg2Uy9r?=
 =?utf-8?B?Q0pVS1B0WXJjcU5GVHJJTVFmNnJDSGJlaXdRR3VBU3N6dDBTMU9jNlFXRVlC?=
 =?utf-8?B?VDJMZjZlWUxPVm1ERjFKekRKTWFhckpjUTVRL1ZRZkg2QTllQ3RMWkp0ampo?=
 =?utf-8?B?ekkybUo4eFpkdW5DNU03cHp2QzNudnVkdFFPbUlPdVBPZzZEdXl6RUJYSXc5?=
 =?utf-8?B?YjJDS2diaUY3Q0d4UDNONkUrWnhxTDUrYTJMNzM5RE1ocGpZUGlPTHB3WXl3?=
 =?utf-8?B?UFh6VWQrWG9QcTlENEp1Rk1VVDdVU1p5ZFpKZUsvTFF2UXU0dkQrY1lkTW9p?=
 =?utf-8?B?bjhNdUhNWHhFNG9DQ3JqZzRnYldKQjRDcmpQSldBRVJjT0RvOUpTZ043QUxt?=
 =?utf-8?B?TlhqR201dS9SUDAzOUtVRTRnWThheFpCT1BHZlk1V2t1MS9LTXg4L3NnMllL?=
 =?utf-8?B?c2FjZWhVeTUwTExvUHUzZjQ2YU44Snp3SDEwYjdTaHFLTXJBVTZ4dUdrWXNV?=
 =?utf-8?B?L1JFOFZ3VjRSL3gxNXJSaEFOTGZOaFRDL1pQaUpjQm5oZUpXVGcwaS9jakIv?=
 =?utf-8?B?dFgrUTBBMlFPYkRhL2M1aExxY0M2Z0ovOGNadjFyZStNYXdqTzlFdzd6dFpF?=
 =?utf-8?B?NlVQTFBQejVRRk1ESTR6SXQyR09vazhZZi9UNGs2NzVBT1dwQThoMVFreitH?=
 =?utf-8?B?MWM1RVJhREcwMUZmbmI0UzY5aEMzbnVCLzR0eGduTHk5NjV6M0RZRGpMR1lk?=
 =?utf-8?B?WTEzcXA2cDZuUVR3ZGxReTNFYjBrelRQRk4vMEIxaFhKMEtzZ3lyU3Fsbmxs?=
 =?utf-8?B?Um5RODdPRTJzN3VsTHU1TGpoN2FLRThrRmVKY2VQSmY5NTFZMHV0TUo3ZVJY?=
 =?utf-8?B?ejd3TnozQzNKcXExb3FWbHlqd3k2aEdzU0RWejJhSHRRQ0FCcVdGMW0zYjd1?=
 =?utf-8?B?R2oxbDZZQkxvQ0hRTEZadVpsOVlGRXM4OW1Xd1pldStMa1h6Q0NOZDhxMHVT?=
 =?utf-8?B?U1Q1YkZrVW9iNlVPQ1V5YVhJVlNLU29xWGIrVzhGS2Q2cy9KUEUyclE5bGkr?=
 =?utf-8?B?VklnZ2hpemt6bkE3Q1lBNDk1elM3NHpjS2w3blFZMmZKVmRDSmkxMmhJT3V1?=
 =?utf-8?B?RFZ0RFRiSEl3cm55dE85WFV2Q3FHZ3lWYVZ5clJlcnByWU04VzdIejFaT29N?=
 =?utf-8?B?Z3l1TnNuTGZDM2k0R3NUeDNBQ1JLai9HbnBDQmVmS21VQjJNV0QrbFRkTjFE?=
 =?utf-8?B?bTNOVlhGK3d3ZTcyU0drOGRkL21oTGtCSUxPMlRPSEpKSTBzZ1FiVUx1RHZJ?=
 =?utf-8?B?dDZuZkN5S1lMVS9HTjNOdFNYZXVGL1VEdXBoSGVoaWp3bXdZRis5SUk0d0J4?=
 =?utf-8?B?Z1lwdkF3eWdldjRQSlpsOEVBUzVtUlMxVytpZ0V4OVV1QlEvODh2Mi8rRW9a?=
 =?utf-8?B?NmJ4QjhqUHkzZnl0SlZOUEJWTVorWEh1eXg3K2dmdmdHU2ZxcHVlQmUrZWFq?=
 =?utf-8?B?M0JpejVRTmhVRHlmVnVCa1hJVTR6VkNKQ2F0cldkZGs2djI2cFdmK082aVBv?=
 =?utf-8?B?eTRGdmMvVUNmYUo0eW1KWFZTKytSR0NLcUFKOHVLcEwwODJzSXhhdVN0MFN0?=
 =?utf-8?B?S3NYT2QrdC9VQitrWm5UNjhOc3VFQXd2U1gzY1ZzSzhkNkRwdnlVa3p1RUxK?=
 =?utf-8?B?K2xOWjdTdGI5eGxtbzRoa0YyK0ZGNnRtYVBNbnd5ckk1R0FqQzdOYktzWVY3?=
 =?utf-8?B?SGxFVnF2MEdqYU5ta3N1eVRzZ2Z5MkhicllOcDhneU9NaFhiVTVpV3hOMWto?=
 =?utf-8?B?VEF4bHJibU9aenhSblNYL1NrVm8yeXIvN1F4SzVkcFNQRkNHSExPSWJhajRo?=
 =?utf-8?B?UlJEdGZ6UlBSdWNFVFZHYnQxOFhHdlE3YnV6UWxsaUlFa1JyNkhYN0h1MDFy?=
 =?utf-8?B?VzA0bVRNYUF4bU0wMmt4b0RaNWRsRnNndVFrdEhLdEt0SWhxdXdld0Z1Tzdo?=
 =?utf-8?B?NFNnNy9OcTErOEZCaWErTm95VUJYZUQ1UmwxanpOK1EyVlc2ci9kekZQM3NE?=
 =?utf-8?B?aEljWWx5VnQ0ekxLZXR5Njg3SWFpeTBWQ3R3bFpDUEJiMERZOGhGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a6665-2e6f-47fb-1f0a-08de7f8ac0b6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 16:25:05.4212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYqo1o+Kfz5Bcx1OQUbIoNhrvlA+6mj/uG38ofYfpG5PmCpz45atbbGLYF4hje0k5oUBS3oXxRBU/NZ0qcVmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9


+ Jason

On 3/9/2026 7:35 PM, Ankit Soni wrote:
> Dynamic top is used to grow the page table levels. However, if the VA
> size is small and the initial page table level already covers the entire
> address space, table growth is not required. In that case, the generic
> page table framework clears PT_FEAT_DYNAMIC_TOP, which in turn causes
> error -EOPNOTSUPP and leads to domain initialization failure.
> 
> Remove PT_FEAT_DYNAMIC_TOP from PT_FORCE_ENABLED_FEATURES, since during
> domain allocation AMD IOMMU driver explicitly sets PT_FEAT_DYNAMIC_TOP
> via cfg.common.features, this keeps normal runtime behavior unchanged.
> 

Fixes: 879ced2bab1 ("iommupt: Add the AMD IOMMU v1 page table format")

> Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant

> ---
>  drivers/iommu/generic_pt/fmt/iommu_amdv1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
> index 72a2337d0c55..61e025a85e6a 100644
> --- a/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
> +++ b/drivers/iommu/generic_pt/fmt/iommu_amdv1.c
> @@ -9,7 +9,7 @@
>  	 BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |                           \
>  	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
>  #define PT_FORCE_ENABLED_FEATURES                                       \
> -	(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
> +	(BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |				\
>  	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))
>  
>  #include "iommu_template.h"

