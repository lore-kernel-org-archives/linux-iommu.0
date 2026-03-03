Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013019.outbound.protection.outlook.com [40.93.196.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51B8370D6C
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556145; cv=fail; b=DUamzpcy7kgaaIjd5zxSMIQ0puWwWrsTF7MTANWQYOYg0v9I+2TeXFthv4NjoFKD6GCX9i2XeJXjGwSIB7FmFfh9+MfmeQvy/ajn4a11CMpswKQlD4p32shllrmNrTAUUGbvcw7PpiVvGcBU1mbYTwF0vk1uHhadqvNmqnzbuQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556145; c=relaxed/simple;
	bh=qY+Or/Pj8WA85HJxwU6gZr6gOCBm+SSCrnU/Be6H3Tc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWTW/Co2Ub26kNsyPxluLHLiJ402hR6mCmDWyiBHgld0xXZEYXZpidmBleZUe82biJ8iSO3GFNuztqOVGEOA5wojhMAyPQsvFxPdUZu2uwsXSKdiHC5WeEWOueh/ahaypPjMA+1qNW4937+hA3lORAKmPzDBfZXjLCHcr3PsDec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3NGumcdE; arc=fail smtp.client-ip=40.93.196.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3NGumcdE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oST6ZB/zoPLYoSCJoT90sz+JkOhJaPB2ZIBLnqczpi+GZ52yzHcy1eLU6qcBLD5aIOVXpN9jUnNcIA3M7/6rYpvCJtAqTskSl1FoC8FmrhORuGtM5mUyikMVPwDmkzGOxksBnfHVbcWe6+rteg3XlLkWs1WPPs3aldtE5jbHL5Tm2Ja+yXq7HYz0xTv/2RidNiMJN98Uu4K5LuEMG9PKt4w53gWxt9VhJG2D4wexa68SB/YjsHlm+h+JAkuEl3jB0ZPU1ndyQLfyqcVbeOweFxND0MAggBPo2AynZJSpH9LR/qhb5NTI2YPAOSClRT7kmOpj64NtKBiYyiXSoch+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHvvu0150biblmBk70w45Y2vFVJIq/GGU4ywCPnhD5A=;
 b=IZ8xtRa+kTKFNNarLzx/tw734EeRq3oT32NwwToyFU9ZvwGDC0bWH2yOwEirB233IBaeMc/E2GETdT6+PewiK/cQzY/X49XQKXtasRn8zA8vcG46Z42x/VZPNsdTME/Lh1clQQdWVSLW/JtleDg4vZUo0kMjLBXMOb/uYk4bMGcxFmQhBMuibdno6MzYhCa4a1QzycTZaVepq6W9ui58ZqsHItPjcY+ku293rWFK9mNzeLV4lnd1q037qDPrFrbVFd0QjpSi11RCWnYDpndDnAM4nXHTdTrWL0Y6l2/a7RGr7zVpzR5m1t0nO/iebqotSA6WsYYnMt9DbNnSlaBnYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHvvu0150biblmBk70w45Y2vFVJIq/GGU4ywCPnhD5A=;
 b=3NGumcdEIawJsKg5C2SiV3r+QansUer+pi7939eaFse+bgx/rNv57RKErtoaYtpr3jexpoevDHQZ1a+r3pv9jhSF/0nw/giHftxAtDMQi/U3N58FIkrrKTATyX32un6//WwmKzlWtgMqEQsltnl23DvPHHgsf1MbwOUgCQDgZd0=
Received: from CYXP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:ee::9) by
 SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.11; Tue, 3 Mar 2026 16:42:19 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:ee:cafe::33) by CYXP220CA0005.outlook.office365.com
 (2603:10b6:930:ee::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Tue,
 3 Mar 2026 16:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 16:42:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 10:42:16 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Mar
 2026 08:42:15 -0800
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Mar 2026 10:42:08 -0600
Date: Tue, 3 Mar 2026 16:42:02 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Vipin Sharma <vipinsh@google.com>, YiFei Zhu
	<zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <d3wmnc43r3mir2emoitj432j3bfdw362dqmkvywa2qvu5tskb4@oqjkseil5i54>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-5-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e56f276-48c8-4664-1dd6-08de7943d5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	+Ti0W6qV0MAaBzRg6A291zKOQ79kusEdovl1EPX7zYLeQQytYkW9xDPEVzQlIXtCYag5TOnorzLxXC28Nx3EOyhwQqJXxGaHMddxKduU4pr62kcogwVDrybI7avm04CTYv+FYcvdrPAZuCHATOD9dri2+XGUAiyuVwhmxys7WX7pqGdKq/bG1Fc+YGRc8Mh/eodANgiEBaaH3gJjp9Ho2OVODs3YC2YTITdpMIMqW+x0hLU740lJ8g0c9wwY18VrkedpMkG0JwPYs1G+ZgHAbqhYXLlAYUPqUUOiRV/KS1W9qMYA3FG0/U/HiVuYm6l+bv/EjpqzAu8Bva8fC6I9WFEKbHuU9hObmaFrnSkVsKDsdHux5CU5EvNnCDzP/5hOmuPkZDV+7kgHTZ7AbxzhUeQG73SJS45xGIwp5MWHd1k8Hv9rLrqIOhu0wBs3wk90IoHO9VqBtdtc8mI1YSdcZwoZpLz6VkludZstbAf5Bfn1VPsl5dYSwwPuJQm455WajKg9yq9zediUIJrHH4w1gago97h3UpbEMLOJ9qJYcc4MlEhj5OnZTqbvGb95JLQIaAUkugbpbdS26XVTeuqp6N7yX3QphZO4emXWua3MKFJjqTBJQpMsr4BQvf1FhyQT5xOcKrfgyHJn831kICRdNSC4VnR+0IcB1TqXjwRPEHZw6N2axjnRX/D54eOlYSPmzR2s3oemYqdHYxR78LD5U9L5U6VKhDAot6g1pIE4k8oTr4X0Ygv4AXo3SbKTABD9VZ7UY2AeLWv2WPe34l5ZfKo1Ytgv4kWnntQVwYe5mhD+gnhOpHxePHIX+N5zQn1vEAYe3+TP5SCOoPHdlE6bsQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o0djPpce7WhHxJQzzXR50czY4+zRQFbUhvUgdX3JWaHKv5VnIfZYSEhiu46QitprbP3plGNsQ9SsaJq3gxdWbud7MoBtGUcUtGDOAvn1Xz+7zJu79CbG509S12l7AUg5Opb+/HDjM0ZEWcByIZWab9WQU50fIoU6fjIjIgfCSIPYQ1MIVq1OBifvXFP/DHtBQNilwbrZxitKHvkaBUPGHA88O/TmtWX9vBVhc9JVBoFLQjfUq+KpIv78Njv09l2c2k19HkPVn0mK1oYOn1+k1DExodhETMCo7Tt02DU1mdqFYhSwDJNOR6hYFCWDBCNndcsnmaA4BylQrqZaRn0hfVrFTTtKmBMBTHmjV01rScpQuZJOU39oWGhKog37vkFr2QIsDlW5vyEQOSNT556FaoYdjUuWHmHn2Q949dpXoJcq5P0W52N358sg8GFrai5B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 16:42:18.9709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e56f276-48c8-4664-1dd6-08de7943d5d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400

On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
> IOMMU pages are allocated/freed using APIs using struct ioptdesc. For
> the proper preservation and restoration of ioptdesc add helper
> functions.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/iommu-pages.c | 74 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu-pages.h | 30 +++++++++++++++
>  2 files changed, 104 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-pages.c b/drivers/iommu/iommu-pages.c
> index 3bab175d8557..588a8f19b196 100644
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
> @@ -131,6 +132,79 @@ void iommu_put_pages_list(struct iommu_pages_list *list)
>  }
>  EXPORT_SYMBOL_GPL(iommu_put_pages_list);
>  
> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
> +void iommu_unpreserve_page(void *virt)
> +{
> +	kho_unpreserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_page);
> +
> +int iommu_preserve_page(void *virt)
> +{
> +	return kho_preserve_folio(ioptdesc_folio(virt_to_ioptdesc(virt)));
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_page);
> +
> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> +{
> +	struct ioptdesc *iopt;
> +
> +	if (!count)
> +		return;
> +
> +	/* If less than zero then unpreserve all pages. */
> +	if (count < 0)
> +		count = 0;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		kho_unpreserve_folio(ioptdesc_folio(iopt));
> +		if (count > 0 && --count ==  0)
> +			break;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
> +
> +void iommu_restore_page(u64 phys)
> +{
> +	struct ioptdesc *iopt;
> +	struct folio *folio;
> +	unsigned long pgcnt;
> +	unsigned int order;
> +
> +	folio = kho_restore_folio(phys);
> +	BUG_ON(!folio);
> +
> +	iopt = folio_ioptdesc(folio);

iopt->incoherent = false; should be here?

> +
> +	order = folio_order(folio);
> +	pgcnt = 1UL << order;
> +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
> +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
> +}
> +EXPORT_SYMBOL_GPL(iommu_restore_page);
> +
> +int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	struct ioptdesc *iopt;
> +	int count = 0;
> +	int ret;
> +
> +	list_for_each_entry(iopt, &list->pages, iopt_freelist_elm) {
> +		ret = kho_preserve_folio(ioptdesc_folio(iopt));
> +		if (ret) {
> +			iommu_unpreserve_pages(list, count);
> +			return ret;
> +		}
> +
> +		++count;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_pages);
> +
> +#endif
> +
>  /**
>   * iommu_pages_start_incoherent - Setup the page for cache incoherent operation
>   * @virt: The page to setup
> diff --git a/drivers/iommu/iommu-pages.h b/drivers/iommu/iommu-pages.h
> index ae9da4f571f6..bd336fb56b5f 100644
> --- a/drivers/iommu/iommu-pages.h
> +++ b/drivers/iommu/iommu-pages.h
> @@ -53,6 +53,36 @@ void *iommu_alloc_pages_node_sz(int nid, gfp_t gfp, size_t size);
>  void iommu_free_pages(void *virt);
>  void iommu_put_pages_list(struct iommu_pages_list *list);
>  
> +#if IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE)
> +int iommu_preserve_page(void *virt);
> +void iommu_unpreserve_page(void *virt);
> +int iommu_preserve_pages(struct iommu_pages_list *list);
> +void iommu_unpreserve_pages(struct iommu_pages_list *list, int count);
> +void iommu_restore_page(u64 phys);
> +#else
> +static inline int iommu_preserve_page(void *virt)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_page(void *virt)
> +{
> +}
> +
> +static inline int iommu_preserve_pages(struct iommu_pages_list *list)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_pages(struct iommu_pages_list *list, int count)
> +{
> +}
> +
> +static inline void iommu_restore_page(u64 phys)
> +{
> +}
> +#endif
> +
>  /**
>   * iommu_pages_list_add - add the page to a iommu_pages_list
>   * @list: List to add the page to
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
