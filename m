Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8202C4A32
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353682; cv=fail; b=Fm+5p5afoRx2wfiwBdnVGi7FsTCr/YRHqAcEHlocAepViT9HnwME04bjK911sVbM8aq+xXGIL89TxQpdpOq4dceSn/G+VuQl2Ic/OAMVG+E8sBWtGOiz51EwcLzERoysBm/kneUDLQAikLd6Pg8mPxOGp3qVeVUCtA1RqhGzuqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353682; c=relaxed/simple;
	bh=st391v3Ng+l83KDciO1mzcYt87/chq/as3xGSLtp1ZE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b2sZYTs+HNw7ncNGCmiv8XLpO5eo0Ilw5t8GK1kK05UOd7Y1LD9hqFnM4No017Xx9pmxSPalwhs9B1mMb95okAxOSo4KLq95yvYsEyT7Cu6Xl+EyZCA18D1KVJKH9Qp2ag2zZPMIv9ZeC8wVXAiaFKqIQGy+c0HR2NUF7tkAUos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sNhZmB+J; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sNhZmB+J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iW/Y1LJdBRYN/qR9Wmra3O3PWcoN35q2Y18ajlCyUWhv9O/B7YzTVAYilC9LPAcc5LyEYK0Qsy5pvDqdEh3j9f+o6T2f7yyKD4knSQ5naOjBRJSXIR/hIN9Z2OuUgd7qetGjpAR8lZYYosoJne3GKa+JvTUmI5BORnr0aVgebr8R7aAMgaEe/AVm/HB0kiIGJngXXQEFaKXRJeFw/je+v/70hQfZ2GLdL/cGX2uQiPWz4BgP6A3V3JIGvkHn7ioTPVCKLgWjP+knTK6ofQD+cHr7kcVDDVplhjQgj3qfGxKIzPRSn1JhmC0UVtOdSgmuAxAcQgJKEHhC8piOcaLwhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZXXz+6VHw7LyaNjrQR3mmCQ1ocpG85F3vbK13Ulw9w=;
 b=kAbltyNq6mn8S+cJqJoJFWKaYq9gZI+V3xp5n+qQ0xFAop6+xx0XvxMl0TXdO4Wr2TVCauF70Hka5vLyiZMG2R6Pl3xTzQewtuMbqaeCQfQF/OFrrkqYyVPvATVQOWCMunR7kT1tb52NgpgLU74gUKuABN0AW7ic7INUUYWDAeOGTM0qNgU8RweMcdZBuS4BfIP6OXcleiiMZSH6WVTNnv+c//2ZSmx5Wq3WLIHQHPSuxk4DMcJWMWI5bDeSGyaIGalV818Cpz114fxe6q0el8ngmrY09hVZO3hPDLq/knzEJDeWF2gOnzFLS75QAX1hN4ajZfjxjkHvwEsvykH7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZXXz+6VHw7LyaNjrQR3mmCQ1ocpG85F3vbK13Ulw9w=;
 b=sNhZmB+Ju7u0bajhv1sitzs/gRV26w6tpJUEZ4Y9CF4K33HVKtJE9IGvsivb7OM3caML030BEKQpqmdxJSfM/0j/c7A7q6xB/XL5VKbCvDupdA0IHqqTIOp20g2Zt0sKENpH50xiGauL5aPBl51hNrUyFf8vHktC4D3jcdoAMWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 09:21:16 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 09:21:16 +0000
Message-ID: <7a9a2703-d4de-40da-8724-ae9ae79c358c@amd.com>
Date: Mon, 10 Aug 2026 14:51:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU
 instances
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0281.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::11) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: e0e4004b-c96f-4df6-bc78-08def6c0bab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|5023799004|4143699003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rn6Iai3E3vgfKu3T+l+XxYBc26V0HAAD0d0QbbD7h+rQwIXSrOdOB63pdRoJOPTkOIduSovd2c8g6GT3pU+ocUUhcdgqVrsSGUUauZThlMRNgQNXqp1KEFbNYK+AuO4KGjSwhh+TdYX638/LSlt80618fKe8wSLalnoWYHyMHENEg7httAkafQB2YjgV5upAXmId5f/uvf4x/TFOymlHcgjDXq9nGcSIVgzy1EBTIU2YMT9KoL4k5KnqYoXgeRAZhLQet8KOy7okyWSvJtYewCloAR1z1obAmsA60uxoNRk4RMkBlqGQxBMud6qBa/LSm2dzDjR/6KyOyIJIv9wtAWbFInjGCtDJith2OtdWMJ19tyywvHkSWUoO/YtgPIjcHliF1TdJM6DXKm8NkDEhRtvC6PgBhJ52bL9K2DqUqnahH9Qh0poRdkFeBiUuRIFUDxfeI6hgN8WKMfmaQ4lYb9HZj1iw0o59CXlTNJb6yxM8w4IZTaHqbqeNoWKDBdwHULKAYXT/9NMAKgg72rS2TUM5FS3VU9GX8C8dHdiXkVHa63ERgiceOA/bAissThWPSE3NNGQErSxdicB4WkSwEtbe75loT3DER7d9MX/tVcz+0UmUhiW3S5dUlk1At4KP0DrV++NmU2/fphZ8t8OnRt1p+2VU7Tna3xvwO3b+ais=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(5023799004)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1ZpSW45QUtKRndwZDBQSVV5YlNhSElpY0JiWVY3MXlTd2dYbCt6UUQ4Nkh3?=
 =?utf-8?B?ZHl1b0JyOHZFOW5kV0xSZ2FhSEprZUEvclNjc2ErdWlodlllMnBVNWt4UEQv?=
 =?utf-8?B?NktNN002MlVDNVcva1lEQi9wYjdFVjFCS0t5cGp5VnY2Um03cWJncUpVdURV?=
 =?utf-8?B?cmlYNDhqUmxtM0s0VDFzWlpNRVJ1UlI4bHcxR2J0Q1B6OUFwOXVOYXlwekVE?=
 =?utf-8?B?VnRzWlQyQm15RTFXQ0MxSjFEWFpKR3ZrVTBEcDhxRkZWRHd2clZGMDA0RjB6?=
 =?utf-8?B?cUFWbEh2ZVdSOHUvL1lydDlxZU5LU1FpWU9iTzhaREg1cTEvdmRUUFRiV0VL?=
 =?utf-8?B?M3JQVnRwaUhUOFhUODd5SXNZN054VzJBTDhPNG9oWGY4ZGxlcjBTY0dwVWxE?=
 =?utf-8?B?Y0JZWEtqbTRYWXI5aFJ1M3dNUExxemZGU1Q0dzJ5d01ub2VSWHBaeCtNdmNh?=
 =?utf-8?B?bXoybW90TTRIeDhZejlNQzF1OVlyUE9DcVNrSnZ1SEJVVGFFNG5HaGNudDEw?=
 =?utf-8?B?NTZ6S2lkUUl2SEZwY3ZLWUswdk4xN3VZb1dxUE0vNFN3VVEydVJNTWxJSzlP?=
 =?utf-8?B?U3lMSXhkM25IYzFTZ1VydnNVZXVvUFJOd0pneCtORTVQbytoRkVVaXo2Qk5D?=
 =?utf-8?B?VkpkZTREa09odHljSGI1ZExEU2xuRDUrS2p2WGxDUk54bXZzQVFMYWwyQkpW?=
 =?utf-8?B?OTdyQW1vOVdLaTRyOFpjYkdRQXlJd2prU0xlRENZRmRZajJCc3hUeWUxV1Nh?=
 =?utf-8?B?UFU4MWZDQmZsRjhGT2tRSlczN3hHQ2dPNGpEeWZMZlFkZVErWXZMcnVEdGgz?=
 =?utf-8?B?V3hsUk1tL0dURm93YW9mZTdhcDM3RUh4RExRS2xucEJ2WTdtVHFlSGJRaHRY?=
 =?utf-8?B?Nks0MWdxRXFWQjR3VjM3VkgzS0ZiVnBMT1NTOWJzaHlOZ2krcTVmUzBrNi91?=
 =?utf-8?B?Q1lXeTAzd0I2RkE1K0prNWZvWlNLMlc1RjU1V09WZG1xRjFTUmpnN2wxSWxo?=
 =?utf-8?B?Zmw5T3VrM3FrTllMZVN1UmNGcFZyRnNxVktJVDRKZEIwTk9TYzZBUjcwUzQ2?=
 =?utf-8?B?QWprVkI3cnVmZEN1RTY1T0NnRS9ESkVmcm1VdDY2R1NXeHl3YWcveHVRc3JR?=
 =?utf-8?B?Qmp2dTJhbVU3Y0F3NWNtN1VnR3U0MnNwcWNqZEQ5NXBLWmVLOUZyVGdKQjRV?=
 =?utf-8?B?SC9TQ0ptOUlkK3pLR3dGcW5PSVAxaW5QZzNSQ0QxT05LdlpybFR0NGxQTU1B?=
 =?utf-8?B?Y2toQkllYk9nSjh3RUp3TzRDM1R3VEdCV2JqZk8xcnBmVFAxTlN6Uk1zR2RG?=
 =?utf-8?B?VktPNHdEMzlNWWxqMDJIa0Vvc2JZNGRGUGdLRFpXV2lIL2laNmQ1ZHhLYjZz?=
 =?utf-8?B?K2djcEtXQmNVMS8xUkpwY0J6T3UyRndQYy9OU1ErUU1YekFmSGc1eUpaWXNt?=
 =?utf-8?B?bWFNekNQVk84Z3VZU0d2TDdXSVNqMGRBVWNhV2J5MkM2NEZxdml0dytUem9M?=
 =?utf-8?B?QzlhU3o1cXhoSXdoMThBM1JoaGQ0QjU4RVhmWVpHSU9Ld1E5bm9wcVFaMHJE?=
 =?utf-8?B?YncybmcvYzR1NE1xY2JWdndjUHArM0lBU2k2T241Y0prRjcyc0ZWeVNWK2JW?=
 =?utf-8?B?ZXplOGlPMFh1YUFuNGprblNWa1ZaMGRSUTJQclVRU3BQKytwUmtnWC9IZXhB?=
 =?utf-8?B?Wm5YSTU0d24yZUlpakNYQndOK2Q0dXRkTlp4RWN4NGR4QUJ0WWs4d2dVMjJz?=
 =?utf-8?B?UW50amVhUm5OTjAwMFppekVFc21UaUppOWRsWFJVRys2QTJzU2lpUFVaMVJD?=
 =?utf-8?B?a3BMZ1R0UEhVUGkyTkZFa0JmcnIzSkZMbmY5Tkk3dnVWVytqMFg3ekNWRC80?=
 =?utf-8?B?NkJTYXdpZktJa2xadkgwVTc3eEQ3YzVMNW5tbGgwcUM5TUpiSU5sNlJhamZK?=
 =?utf-8?B?S04rcUE0NEg5K0FFMWJ4STBoeTR2UnB2b042c0ViSVF2djNqQzd5TGJrem5S?=
 =?utf-8?B?bWZ5dkk3Q1d2MFZweUFZTGdJUTBhaHZjSG1YMGRweXFsUGJOaWZFdHgydyto?=
 =?utf-8?B?SmZQUjFYME5LVUFZTkVUanhhUFA1amVFSXlzQlFTeW84elBUK0hhVWp6RUVF?=
 =?utf-8?B?a2EzZ1lTVExCWUVCWjR3aFd6MXBrTTBmUWZ0U2tCRkpJQTZnN2RGeWs3UHo5?=
 =?utf-8?B?azRZSEZjbGg4cFQySUFhUWJSclU0b3VwMTFsYVdJdnF5em9ibkhiUEpPQVJW?=
 =?utf-8?B?REJQK0dCSDBIREJYRkpRcWtCNFFHRVl2dlp6VTJVNTBUZjY4NmhHQ2dCSCsw?=
 =?utf-8?B?c0VFcFlRcDJBU1kwWm93VzhNYUNtajBiNHNZTXVLc1g3aW82RHJJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e4004b-c96f-4df6-bc78-08def6c0bab3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 09:21:16.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elHybilv4DGxABuzOC3fxrdWb+5G2xgomyClFwqw6WL+I5e0sB/D05rvIMaqLsI9droR45s0H441+J34IBT7Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036

Suravee,

On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> Hardware vIOMMU uses a 16-bit Guest ID (GID) per guest IOMMU to
> index driver and hardware state. Allocate one GID per IOMMUFD vIOMMU
> from a per-amd_iommu IDA (unique within that IOMMU; a VM behind
> multiple IOMMUs may hold more than one GID).
> 
> Add amd_iommu_gid_alloc() and amd_iommu_gid_free(), store the ID in
> amd_iommu_viommu::gid, and call them from amd_iommufd_viommu_init() and
> destroy after copying struct iommu_viommu_amd to userspace.
> 
> ida_init() for gid_ida is done when vIOMMU MMIO is mapped (next patch).
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  4 ++++
>  drivers/iommu/amd/amd_iommu_types.h |  8 ++++++++
>  drivers/iommu/amd/iommu.c           | 19 +++++++++++++++++
>  drivers/iommu/amd/iommufd.c         | 32 +++++++++++++++++++++++++++++
>  4 files changed, 63 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 17fc0b5b3fa8..9f2a1a8a6d3c 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -228,4 +228,8 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
>  struct iommu_domain *
>  amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  			      const struct iommu_user_data *user_data);
> +
> +/* Guest ID for vIOMMU */
> +int amd_iommu_gid_alloc(struct amd_iommu *iommu);
> +void amd_iommu_gid_free(struct amd_iommu *iommu, int gid);
>  #endif /* AMD_IOMMU_H */
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index b5327bf6814b..00f964d5b149 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -21,6 +21,7 @@
>  #include <linux/iommufd.h>
>  #include <linux/irqreturn.h>
>  #include <linux/generic_pt/iommu.h>
> +#include <linux/idr.h>
>  
>  #include <uapi/linux/iommufd.h>
>  
> @@ -413,6 +414,9 @@
>  
>  #define MAX_DOMAIN_ID 65536
>  
> +/* For vIOMMU, the GID is 16-bit. */
> +#define VIOMMU_MAX_GID		0xFFFF
> +
>  /* Timeout stuff */
>  #define LOOP_TIMEOUT		100000
>  #define MMIO_STATUS_TIMEOUT	2000000
> @@ -509,6 +513,7 @@ struct amd_iommu_viommu {
>  	struct iommufd_viommu core;
>  	struct protection_domain *parent; /* nest parent domain for this viommu */
>  	struct list_head pdom_list;	  /* For protection_domain->viommu_list */
> +	u16 gid;			  /* Guest ID for the vIOMMU */
>  
>  	/*
>  	 * Per-vIOMMU guest domain ID to host domain ID mapping.
> @@ -768,6 +773,9 @@ struct amd_iommu {
>  	/* IOPF support */
>  	struct iopf_queue *iopf_queue;
>  	unsigned char iopfq_name[32];
> +
> +	struct ida gid_ida;		 /* guest IDs for this IOMMU */
> +	bool gid_ida_inited;

Redundant variable? May be remove gid_ida_inited.

>  };
>  
>  static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 50f26c8123f3..73fba8be40d1 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -252,6 +252,25 @@ static inline bool pdom_is_sva_capable(struct protection_domain *pdom)
>  	return pdom_is_v2_pgtbl_mode(pdom) || pdom_is_in_pt_mode(pdom);
>  }
>  
> +int amd_iommu_gid_alloc(struct amd_iommu *iommu)
> +{
> +	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);


We know that top half is reserved for secure vIOMMU and we have to construct
that differently. May be restrict max GID to 0x7FFF ?


> +
> +	if (ret < 0)
> +		pr_err("%s: Failed to allocate guest ID (devid=%#x)\n",
> +		       __func__, iommu->devid);
> +	else
> +		pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, ret);
> +
> +	return ret;
> +}
> +
> +void amd_iommu_gid_free(struct amd_iommu *iommu, int gid)
> +{
> +	pr_debug("%s: iommu devid=%#x, gid=%u\n", __func__, iommu->devid, gid);
> +	ida_free(&iommu->gid_ida, gid);
> +}
> +
>  static inline int get_acpihid_device_id(struct device *dev,
>  					struct acpihid_map_entry **entry)
>  {
> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
> index eee29c26169a..ec3c14e18c7b 100644
> --- a/drivers/iommu/amd/iommufd.c
> +++ b/drivers/iommu/amd/iommufd.c
> @@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>  int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>  			    const struct iommu_user_data *user_data)
>  {
> +	int ret;
>  	unsigned long flags;
> +	struct iommu_viommu_amd data = {};
>  	struct protection_domain *pdom = to_pdomain(parent);
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>  
>  	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>  	aviommu->parent = pdom;
>  
> +	if (!user_data)
> +		return -EINVAL;
> +
> +	ret = iommu_copy_struct_from_user(&data, user_data,
> +					  IOMMU_VIOMMU_TYPE_AMD,
> +					  out_vfmmio_mmap_offset);
> +	if (ret)
> +		return ret;

May be move this before "xa_init_flags" ?

> +
> +	ret = amd_iommu_gid_alloc(iommu);

Looks like you missed initializing "iommu->gid_ida" ?

> +	if (ret < 0)
> +		goto err_gid;
> +	aviommu->gid = ret;
> +	pr_debug("%s: gid=%#x", __func__, aviommu->gid);

Redundat as you already have pr_debug inside amd_iommu_gid_alloc()?

-Vasant

