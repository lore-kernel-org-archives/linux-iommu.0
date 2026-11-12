Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501115;
	b=qw1A9x/KTgv9hloavVDiO8/y3D9NFilWGgbrG1lj/KJN787v1Ramqyz1mzooQygRWahs
	 bKFg4kc4dDffivYjRvv2mEuwu2aHOsxk1Ca0WW5m/p8Q788pbM68ZDvJeFgfxoEF32axk
	 SLTzHCt1sAxOvF/5gzGE+oCsOA73I/lfgHLckElTPLmH7vxn2LUxXyViUIz8fxDsN4Hpy
	 4R2zX8rYQc3+COfeXyGv1Af8DbubJKyvNtw2P36KDlDZ/0XVudWEgpiEHbkeS81tBx95i
	 uVwu27MS/J/M3aN/Pz8LswMTTOmqDo29UJKc/t65EyyapBO72qHvSxt+Q2bFFsZJqZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501115;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=MdDMpn1E237DWMEcWSJ+1x4vI1+JS6BzFl+hQXT8pFc=;
	b=tMF2/kdfefv16M4pqZF/n/2YRtRL8WMpDP/1lx8O3/xsnNIC/Tw0qDs6lghRUFGDH/w/
	 Jqj3yflgBsz6PmqrV8H5LImJWRGdKnY55c4essyZ7Fd/uRuvSmwVevdAArDndg8xsZZNZ
	 VFNAr24nPFYKzWzeziK9RHurLjs0WMh9na3DLtHc5pXJgQ/rirM9GIodIXdh1vFyQS/ca
	 Zo4ciP2C+/oxWo/3u5upHZg58Wb3PZFoqPkEs4l55zHES0E3/LDhnre4e+gnRoHQLJCFV
	 dC+LqKKWpSrDC7Ei7NXkUxwz0RxF4/8CDNv7UGDHERihk7GySN4W4JU+OrZ8Droz2Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lohlGJF0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.6
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F5606A327
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 16:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA4F5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lohlGJF0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bD5mXiKtK+RDImc5uiuPzv4JupOq9QIAJ2/++jUvTXTTKUHjNkN7A/OfspaP5xWnu3eFi8yUn5MSTgM0PTxf0kLxLDTQP8k0VHLFu2d/hrS0khhkO/0oEFGzLslRNbtGySlrXGqdPgu56n/cMR4NF1HNu399c7R5jBlZbeOYhaZYfamcKYXQ9LBkLNuuZRiaZaWyTWtBaCzd9/MhUmgvU450jX48YlfUX3e3Us2SgPSk8qyt3dRb49ELMLyTlQRG5fKEwLpF8W/XQpED5y0+1Ab5Guilba8PqTg07Zn7z1XBlTQWfvgvOkcGD2UA3zXWhL5FVJDi0UakSObGzM0OPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdDMpn1E237DWMEcWSJ+1x4vI1+JS6BzFl+hQXT8pFc=;
 b=YM4eX6t+OQGd0wT+Ue1LMCvsD/tq6b3WYdhTTfRaSFykjxgSYgg8+/ZWiAxQoz77SWvERY60LZfmaRrP9Jzl3ZIislPLlUWUFmWCzJ18N4emSWSaGWkWlce+HZONb/mKRXJAVYMvx7OwnPsppdS5qZLR/GOpr81VvzSDBXq+JNuIC6uAiyvoS58b/QSNQpTGRUPWm24EJIYuf2Odd/uVPeqvv9jF+iNjXPLXSzA2wCdnocf7gnXDT9UzDmgUjNOgzzljbnKJy/SQ9WXFiUOIm0MrAdnyDloa09BwuOtjpnm3olptv9x1uY3IE3PSCj6FxNg2M3BgR/p8AMW2oytHIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdDMpn1E237DWMEcWSJ+1x4vI1+JS6BzFl+hQXT8pFc=;
 b=lohlGJF0GtlI+2QR3tEh57/riOgWpTtMWYUYKyy1ItotCTGGCNwdv6X4O+5ZdOgoT07KaqJIwZjPIin/tBeAtmQBWdIjwO9EgPwS+INlfUXJe5UUxTaK6rAxj9omAnkopccRLOQ7CoLBfj9TYU7xC6B6TfWGekE/oJWEPF74atY=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by MN0PR12MB5930.namprd12.prod.outlook.com (2603:10b6:208:37d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:31:46 +0000
Received: from PH4PEPF0000B60E.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::81) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Thu, 12
 Nov 2026 16:31:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B60E.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Thu, 12 Nov 2026 16:31:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:31:45 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 10:31:38 -0600
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 10:31:30 -0600
Date: Thu, 12 Nov 2026 16:31:27 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, David Woodhouse
	<dwmw2@infradead.org>, Pranjal Shrivastava <praan@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, "John
 Starks" <dev@jstarks.net>
Subject: Re: [PATCH v7 02/18] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <wirs4vcszlt6wkw2wfauhjnxve4n5ivnnpkg35fqid34htepet@fn4opgt3lt2x>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-3-skhawaja@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261110040828.1774343-3-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60E:EE_|MN0PR12MB5930:EE_
X-MS-Office365-Filtering-Correlation-Id: b1e51c2a-fd48-4c3c-376e-08df40da7150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|23010399003|36860700016|4143699003|261026140227099003|261022113327099003|11063799006|10067099003|56012099006|261026130827099003|261022105027099003|261022115727099003|261021121427099003|261026121527099003|261021130227099003|261028144727099003|261022075727099003|261021123027099003|261102130727099003|261021135927099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	gcv8q9LASyoR5PTbwBTxNOvb4rZ3kqFw02Fm0J0H57WeB2+DEDd7PEmGIpBF2pb5xhSCtMs7MmCaIxqmIx7ZD33okUEvXGBfrDhP1KYqukh7CjNW3XNjlEbVQbdUFKP7AyMoAL24wVupD6D9uxnV49kNWTjVl7yeM6hJ0EI+ZHsREHDxQudL91iSEoBP0UjoUeBe/F7rvGaW+pTQ6SNdhV3wA7q4+jsrvs2ToylzESyoXEWGSWrSIGE4SsOG6ohsi0DzJQM+Os6fXJ3CpV/+yFkL3hF1U0F3s0L1FmdIeyRA8TujVuw3RxsyzhanaSHaO4za7c8vou37r6E4X77/tmvGF08oS1J2ysv5C0ICavDEOuk4skLppOruht7U1uW0VBeZfOCzaBdK1uIhs9KegEoNsT/Uo+q34z4j7JdccFvFwca66gnDuPP3y6/UC/HxmU5NSN7bDh4tbRP5W0GxEErsR1ifFPdf9R5kHoXQ/DG1vLgOwhQSW1EfhO5OUvKOKQt1IA0VNzg4DHrhnOJYkFnmarx7udN0iZPdrGJD89aezpxcU5796sDi8mqHbVmoJjiTESymm1qvwSZtnic+XoVHMkfFN1O2MQwYvvAwWmuoi/FDAUV+2nFynTwQ32hUKsL6HmzJJyRRa5iIEmSikmFPUGQUx3CBDEvxrVKNjFE8/TRBIWcEpzXV9w83wqDMRqsD2JZcaAtuhZf7THdXJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(4143699003)(261026140227099003)(261022113327099003)(11063799006)(10067099003)(56012099006)(261026130827099003)(261022105027099003)(261022115727099003)(261021121427099003)(261026121527099003)(261021130227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261102130727099003)(261021135927099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kOoCFkF49m1skZCxHv5Pvl5fQfalUkBQ7P4+ACALb97CV/1XWms1yGMa+S7C+RiheRv7yD2Dt1//anSF0sP157J+lviqgUOeUq4Cx//zasOHRUe/Py2TpefNDbgnkw8J0/kycG+NsPhfI+fC5N9c3UPAkSxYTBofTv05gC92W9+FBPmNj3flwxw/nCBbv14CaRb4Hh8Nj0IWNeRuJ24YqpKUhqRjrnBxK6N09fHjbNjfv01MKCzvq+dNOdx02iMsx1nH2h08Il0vYEbmA3x6sD+au6nHlmM8LY1aIYpgHfvVpt0cmfyF/LHBbv3KKdhLj0+G1ZvkGLDHVS4eJV/M4goggdrthJvB8desqcdrN9RlUkN4ciPCUiYfEp0jOIbtGe2l4Tgr2FwnykLZT3XpQ5T2iShe1Dhb7/UD1Sxs2AwGO+I1iPv58g01iJD6GiYX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:31:45.6794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e51c2a-fd48-4c3c-376e-08df40da7150
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5930

On Tue, Nov 10, 2026 at 04:08:08AM +0000, Samiullah Khawaja wrote:
> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> the proper preservation and restoration of ioptdesc add helper
> functions.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu-pages.c | 109 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/iommu-pages.h |  30 ++++++++++
>  2 files changed, 135 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
> index 3bab175d8557..0aa18c771baa 100644
> --- a/drivers/iommu/iommu-pages.c
> +++ b/drivers/iommu/iommu-pages.c
> @@ -6,6 +6,7 @@
>  #include "iommu-pages.h"
>  #include <linux/dma-mapping.h>
>  #include <linux/gfp.h>
> +#include <linux/kexec_handover.h>
>  #include <linux/mm.h>
>  
>  #define IOPTDESC_MATCH(pg_elm, elm)                    \
> @@ -28,6 +29,13 @@ static inline size_t ioptdesc_mem_size(struct ioptdesc *desc)
>  	return 1UL << (folio_order(ioptdesc_folio(desc)) + PAGE_SHIFT);
>  }
>  
> +static inline void iommu_folio_update_stats(struct folio *folio,
> +					    unsigned long nr_pages)
> +{
> +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
> +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
> +}
> +
>  /**
>   * iommu_alloc_pages_node_sz - Allocate a zeroed page of a given size from
>   *                             specific NUMA node
> @@ -80,8 +88,7 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size)
>  	 * rather large, i.e. multiple gigabytes in size.
>  	 */
>  	pgcnt = 1UL << order;
> -	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> -	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
> +	iommu_folio_update_stats(folio, pgcnt);
>  
>  	return folio_address(folio);
>  }
> @@ -95,8 +102,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
>  	if (IOMMU_PAGES_USE_DMA_API)
>  		WARN_ON_ONCE(iopt->incoherent);
>  
> -	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
> -	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
> +	iommu_folio_update_stats(folio, -pgcnt);
>  	folio_put(folio);
>  }
>  
> @@ -131,6 +137,101 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
>  }
>  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
>  
> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
> +/**
> + * iommu_unpreserve_pages - Unpreserve pages that were preserved in KHO
> + * @virt: Virtual address of page to be unpreserved
> + */
> +void iommu_unpreserve_pages(void *virt)
> +{
> +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
> +/**
> + * iommu_preserve_pages - Preserve pages using KHO
> + * @virt: Virtual address of page to preserve
> + *
> + * Returns 0 on success, negative error on failure
> + */
> +int iommu_preserve_pages(void *virt)
> +{
> +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
> +
> +/**
> + * iommu_unpreserve_pages_list - Unpreserve a list of KHO preserved pages
> + * @list: List of pages to unpreserve
> + */
> +void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages_list);
> +
> +/**
> + * iommu_restore_pages - Restore pages that were preserved in KHO
> + * @phys: Physical address of page to restore
> + */
> +void iommu_restore_pages(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	if (!folio)
> +		panic("Failed to restore preserved IOMMU page %llx\n", phys);
> +
> +	iopt = folio_ioptdesc(folio);
> +
> +	/*
> +	 * For the restored pages incoherent is set to false as these are not
> +	 * mapped using the DMA_API. The remapping of these pages using DMA_API
> +	 * is not needed as these are not going to be written to by the new
> +	 * kernel.
> +	 */
> +	iopt->incoherent = false;
> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	iommu_folio_update_stats(folio, pgcnt);
> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_pages);
> +
> +/**
> + * iommu_preserve_pages_list - Preserve list of pages using KHO
> + * @list: List of pages to preserve
> + *
> + * Returns 0 on success, negative error on failure
> + */
> +int iommu_preserve_pages_list(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +	int ret;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
> +		if (ret)
> +			goto err;
> +	}
> +
> +	return 0;
> +
> +err:
> +	list_for_each_entry_continue_reverse(iopt, &list->pages, iopt_freelist_elm)
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages_list);
> +#endif
> +
>  /**
>   * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
>   * @virt: The page to setup
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index e9e605b5fa3a..3c409ec3d170 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
>  void iommu_free_pages(void *virt);
>  void iommu_put_pages_list(struct iommu_pages_list *list);
>  
> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
> +int iommu_preserve_pages(void *virt);
> +void iommu_unpreserve_pages(void *virt);
> +int iommu_preserve_pages_list(struct iommu_pages_list *list);
> +void iommu_unpreserve_pages_list(struct iommu_pages_list *list);
> +void iommu_restore_pages(u64 phys);
> +#else
> +static inline int iommu_preserve_pages(void *virt)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_pages(void *virt)
> +{
> +}
> +
> +static inline int iommu_preserve_pages_list(struct iommu_pages_list *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_pages_list(struct iommu_pages_list *list)
> +{
> +}
> +
> +static inline void iommu_restore_pages(u64 phys)
> +{
> +}
> +#endif
> +
>  /**
>   * iommu_pages_list_add - add the page to a iommu_pages_list
>   * @list: List to add the page to
> -- 
> 2.56.0.506.g506a7eabc5-goog
> 
