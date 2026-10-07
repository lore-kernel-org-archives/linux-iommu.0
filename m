Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614BC3E49C0
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 21:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791408749; cv=fail; b=EiAzTdVuEKGJ1vHfUhPvBycsSioJQRR/ChiSrbfrXnLbUBP07xWnHTzi39rQo2ePTFOlUM1todJNDKHSD2bR/weQOTu1/p3Z5EC1D/Y3QJjxs8w0GY9YnhbDC/DKT4n7Bvbw1XPfSlowDpmNJTBDuc94d6vGq7YLsHymUlmmoQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791408749; c=relaxed/simple;
	bh=6zJLz89EP8MCzcvemEKMR3gIs67RESBVAjhxPhiHimQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtIqujLGn20mBVJE/j/bOHuCUGZ8r1gK9l27IEVO5nkGxH3gmAszitE/vaKBte7LL2WOnetEzqMMYrR5Sk2hmBQe6VsigbRSj2Wm8HOFqzl0UIzAZKYRYvFSgStbLsoz3EAsVBNGGr8nCHCuNXQvxWqoCfur6AOhuZTcdx1ZP28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K+Hg1Wb0; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+Hg1Wb0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQgeqsPYIvuOAUHPCEDk/3Gfkfw6UXEP/N3xiMdi5ros5b5sGacUMz4cLNH3gQExTm2W+Y6gJCaYv7XNwzezv0EidLwtKsJujhT0TaKiB5RViBTrmJonFczTdQKosfY4ROL0cI4Xl/SncRC3GriK9CajEcszmvRF/Sv/9SOHelTTgwoLubsCBfHhBCEnzAGBIpvzbm4rgR83o0EreFlf/DSTvVKM9IJGzqYFL9Qxc/8iaz4ZUTbeGhxCxmdfpbzzWrinoNN0+FmlCPP9ZaA1g+gBR5r7lC/qcX6V0Lw2yq8nmV6BYhjM0u3pHijBjpjFbKmb2WAzFMLeSevgVugqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=550O7TyUcyThvPjjLxpyYTBC8yEk6ILUkCULHID716M=;
 b=h2NIJic0gSCddc1Av1y0v6uNiEDoshNAFUP2CpKJAvrenn+bQ4UR76nSU3R70tZl5ia+Jsnap/DKlwZ3PU0r6lCEKh58+A0qwCXbYDTOhRGuoQsNQ/XnNabCec7nnKe08LE3CUPboY+12K0e6OGS8ALi4SvbuvXNfR42xEpVoht7evmpqo9uOU+/ZLwca6PMfvl8afANrtYgkhbjjwEg/kmUbXMF47Cc3jp13D6Bj3+piwoix8G9TvvMKpzuyDxXsUK0dGaNFW1o9s1E+PbMgEHZiejiFLoT9/gaurxQK/Sl6rYseAk+LijMnRPs8PO6nwywzB6UtuHL3pmlw0EEjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=550O7TyUcyThvPjjLxpyYTBC8yEk6ILUkCULHID716M=;
 b=K+Hg1Wb0ZlBxfH0nIFYU4/Sq2SmOwb31lNrtsdHPBqXcP/0m/1H71s1aCzZLN4KGwBR/shU2plf/ITmqgEM3lCEZ8F9l1bEZFfcUrDeqoEusO7m7n4IxTjvXPHM8/gjJcLnXiOaBPJ6cRqZHlBGkkBZDZEYrt/+HP9e4AEIarbtbb6HXxFUn9U+60wACntx2ABeRYwrF1E4kWr893eKhMeB15aGc/3YSOjP8B3fMcggHMmSb44OmloUTlQMNikPAAYweOiFXlI/OYGOpGeeVTGQxftnsTRN48pDKrtoZcXWf69dIDe9GPgwRT7W1nAKXKEnsNzrcVbs21NW/SArIUA==
Received: from BN0PR04CA0201.namprd04.prod.outlook.com (2603:10b6:408:e9::26)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 21:32:20 +0000
Received: from BN5PEPF0004698A.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::3a) by BN0PR04CA0201.outlook.office365.com
 (2603:10b6:408:e9::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 21:32:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN5PEPF0004698A.mail.protection.outlook.com (10.167.245.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 21:32:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 14:31:51 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 14:31:50 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 14:31:49 -0700
Date: Wed, 7 Oct 2026 14:31:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, YiFei Zhu
	<zhuyifei@google.com>, Robin Murphy <robin.murphy@arm.com>, Kevin Tian
	<kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, Shuah Khan
	<shuah@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>,
	Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 15/18] iommufd: Persist iommu hardware pagetables for
 live update
Message-ID: <asa6Q4t1pqn9gz3P@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-16-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-16-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN5PEPF0004698A:EE_|SJ1PR12MB6218:EE_
X-MS-Office365-Filtering-Correlation-Id: a91283bd-b1e0-4361-3620-08df24ba7795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|4143699003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1oRmPBk5hPYxH8xETMS+70KmLmsxuiBYB82GWCLVGDAmbIvfkpRw7GEZrW8XqXgByTjZro1d7+8KszfDF4ya1o2cEXrA+mG9RPKJ3AU89zTSZ92ZC+6t+wCqo/YnJ4Oi/jOrOlDNKRZUm5gVj6Nv+VJ7u6MSDYqTHpVDDmxklhyPQAJx3N1sZ7U7nlFOO2pGrjpnQ67Y2p1E4jBEBkL5nb6W1ReQTo7ddnm5zwH2XXucGhh4iEW0KCcjsv53DBn4wc/O4/vpzlogd/HVnZ7adxLpXbbs4SmZ2pI2njx6Hd7IWS3sFpA2O5QmGU33S3j1qbXyb77jGZm+l/+At2ULwAOz1GUKWK6fXMMh1EPvXGE2icQwbxIz/heKaVXZEqvfeLZFfDFWq9CqkoZT0sRVK2HMCeak6HrYiVczz6D25vUg36DhWJ6loPZPGUAZtrysBzKPhDIF8zAt2ifKHyvsmEpuGgZFtTzpn0LFaOSiAkMncs3fADPJA9urTl36hnYWeCdTjvGxYcW5GU54GpUhOSH9it8I087jJQNoWVnGz+ohZHGwp+/+H6HyoI612hTU4HsHMKCli/V6QX2/dsjfCvYqzJDg0PuxREgf1fU9ArWB56RC59IsfFFjDkHMjHzI+FL1mMv793GT0ekzabHvvwpfCQYH9yPmA5AxmQMi4fCmfeKEYAXgghVwI/Jj4G8eAZpUE+5X2/1wcxjT78vPEQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	89uerwcTIOH8oiiVppNeHxagbckpqviJeUBK+JTdotaB7rBc3KYmiK3bGdCmDhaeJIRaO9A8WUd+cFvktO9diCSq/EsCJh+X3pgu67oJ3A05M3E1H2BL8KQaCuJPV3PJxjQ/0WDbQEJhJL4GuYB1/lDnnqALstiKiQqKB5pqgv4+hbGMKXSe6yqBqjKwlXmT7AKlJQIz0VjM4g81lELltj6UUVVCYoP3hZehUGLScW2DKKjG0cWnoDzPekdscdUjifm4lFgXkjwHMqDJxdSwZNlhWN/QvKquHUU2dXP7V5e4FuarI1Y2otcMlD+iXKeMzJP7YwaS0MtxW78lwEOjuUBWEH5WykvjbXuXxH4FjFc1Kt3F2tovHkAC4mmjH4bgWp43u7e4YWCS5qJrjUKzpEqdZbaDEsrzwZpInrBKMr8ZrnXiN6E4WzXCk3sG1PeM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 21:32:19.6813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a91283bd-b1e0-4361-3620-08df24ba7795
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN5PEPF0004698A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218

On Mon, Sep 21, 2026 at 12:48:31AM +0000, Samiullah Khawaja wrote:
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index a33b32708afa..a4ddc29ec5ae 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -98,6 +98,9 @@ struct io_pagetable {
>  	/* IOVA that cannot be allocated, struct iopt_reserved */
>  	struct rb_root_cached reserved_itree;
>  	u8 disable_large_pages;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	u32 nr_preserved_domains;
> +#endif

In iommufd, "num_" is used more often than "nr_".

>  	unsigned long iova_alignment;
>  };
>  
> @@ -398,6 +401,7 @@ struct iommufd_hwpt_paging {
>  	bool enforce_cache_coherency : 1;
>  	bool nest_parent : 1;
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool liveupdate_preserved;
>  	u64 liveupdate_token;
>  #endif
>  	/* Head at iommufd_ioas::hwpt_list */

> +static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
> +{
> +	return iopt->nr_preserved_domains > 0;
> +}

It's used in io_pagetable file only. I'd move it out of the header:

static inline bool iopt_liveupdate_immutable(const struct io_pagetable *iopt)
{
	bool immutable = false;

	lockdep_assert_held(&iopt->domains_rwsem);

#ifdef CONFIG_IOMMU_LIVEUPDATE
	/* iopt becomes immutable once liveupdate preservation starts */
	immutable = iopt->num_preserved_domains;
#endif
	return immutable;
}

> diff --git a/drivers/iommu/iommufd/liveupdate.c b/drivers/iommu/iommufd/liveupdate.c
> +static bool ioas_set_immutable(struct iommufd_ioas *ioas, bool set)
> +{
> +	bool was_immutable;
> +
> +	down_write(&ioas->iopt.domains_rwsem);
> +	was_immutable = ioas->iopt.nr_preserved_domains > 0;
> +	if (set)
> +		ioas->iopt.nr_preserved_domains++;
> +	else if (!WARN_ON(!was_immutable))
> +		ioas->iopt.nr_preserved_domains--;
> +
> +	up_write(&ioas->iopt.domains_rwsem);
> +
> +	return was_immutable;
> +}

Since it has to handle refcount, an unset doesn't really unset the
flag, which is confusing.

Maybe just:
  iopt_inc_num_preserved_domains
  iopt_dec_num_preserved_domains

> +static int check_iopt_pages_preserved(struct liveupdate_session *s,
> +				      struct iommufd_hwpt_paging *hwpt)

static int iopt_validate_preserved_memory(struct io_pagetable *iopt,
					  struct liveupdate_session *s)

> +{
> +	u32 req_seals = F_SEAL_SEAL | F_SEAL_GROW | F_SEAL_SHRINK;
> +	struct iopt_area *area;
> +	int ret = 0;
> +
> +	down_read(&hwpt->ioas->iopt.iova_rwsem);
> +	for (area = iopt_area_iter_first(&hwpt->ioas->iopt, 0, ULONG_MAX); area;
> +	     area = iopt_area_iter_next(area, 0, ULONG_MAX)) {
> +		struct iopt_pages *pages = area->pages;

Move req_seals inside the for loop.

> +static int iommufd_liveupdate_preserve(struct liveupdate_file_op_args *args)
[...]
> +	iommufd_ser = mem;
> +	iommufd_ser->nr_hwpts = nr_hwpts;
> +
> +	/* Preserve HWPTs */
> +	i = 0;
> +	xa_lock(&ictx->objects);
> +	xa_for_each_marked(&ictx->objects, index, obj, IOMMUFD_OBJ_LIVEUPDATE_MARK) {
[...]
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	/* Store the actual number of HWPTs that are preserved */
> +	iommufd_ser->nr_hwpts = i;

iommufd_ser->nr_hwpts is set twice. First one seems redundant.

> +++ b/include/linux/kho/abi/iommufd.h
> +/**
> + * struct iommu_hwpt_ser - IOMMUFD HWPT serialized state
> + * @domain_data: Physical address of the serialized state of associated domain

Then, it could be domain_ser_phys?

> + * @token: User provided token
> + * @reclaimed: Whether the HWPT is reclaimed

Once the hwpt is reclaimed, could we clear domain_data to indicate
"it is reclaimed" instead of a separate field?

Nicolin
