Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D659C10940
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 17:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eTYdRg+1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2N3s+xt66XP0ckOseXTfQsqR4vMI5QEYMLZEP7bw28iKfUmtGdFZYPl1dM9yAa/2pZqIP1JgSTnDRKUXYC2ignSNV++0dwaNorAtS04AjOzf6HeWG0DRKZ/3GXJP95B2A+9QuXfWhod2fNXSUQs2irUueU7z0V2yIDe9SrHaPxr+PQYKEVMdDfUiv8Mx/AamyAAe3JmL5LIYxMWXclQKGkD+zVugCSZNUy73o06Dhu4ienlTJbZkUgBNnDv9Brjs4eGp+v9Fp/exyuu812c4WYfvJUIkaY2eiB9lOPWw4addU5+ouxHlcblQ/xeCIBCbXmD0XlU+H+407M0NpsKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdDqadP3Wt0yrCsNwVXl0Nj6ZCRFS4klcqTr8VyqU9k=;
 b=FS8+UECUBS2po0sVpC87yAz3RXCLvsnIov/2gdFA6XjUiSuN7l98tFQbSfpyWhkeFtHjCBoWGkLQB7jecwao3gYuh3ILQjJynqv4yNQe6Rwxi7FnMrxoKu9wQYgKPbWOOGU9KYnI3+cEVxrIq35NRbzdR8oi7sP/7JjtZPPcLSrvOKL3/Og8osll0CkiE4ipLs1TUYlFJ9C7bY0JenGmlGSoFkgp3WeTa45oN6X0QJuAHRG3UkOrKO1x1GUy6htqVma+zNxG3Nh9fCn5oUGzwn39hsZ9VXvpG9StnuwfwgSEc/U8YSYLwWYKpMoyUGI52djOt+OS9cAc1c0bHwrqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdDqadP3Wt0yrCsNwVXl0Nj6ZCRFS4klcqTr8VyqU9k=;
 b=eTYdRg+1pROUxUphWRL1xv20x3Ue0h3tbUShoVDOPiZh40GsvHFbCiRYPnvZi72N3ylkbf81vMATyThJGFqEp36BnhEjV7fKuZ0CVGkvFRKL5k4EcYoAYK9eBf3+y7JcA10WscfUBiZddn4bL03/rfZ9D4bTlbLAbppa9PQLtpCNa/42zyz/dj3xuqDF590lCmYb2ixpwh/8udyZUGU/zFrmkFQ5I39PoLz1e7j5CeH8YeyZT3e0igWiCQWJp27rL3vPluH4ikojwdZBK4XSMzE00YjuK3yCo4mUWXpm5VRJJZlE9vR8qL5pGjFYhb8+l0HSfmU9sjNyjMsqk+RW8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 17:57:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 17:57:24 +0000
Date: Sun, 5 Nov 2023 13:57:23 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 11/13] iommu/amd/pgtbl_v2: Invalidate updated page
 ranges only
Message-ID: <20231105175723.GK223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-12-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-12-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: 67bf6d1d-6154-4104-b0f2-08dbde28aa5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	t9D7dGMkNwlpNpT5dsoK6O2YSZSvLsWLrnWeL3OKzLszs8zbkNyZGv98G77vz/XnwfJx6K6Tnx8i+swR0euomGJpXk+VfUpqegT9WxWJUkxsZWmNm55s8hsWDEjkh5nYEFznv6kTEM5kOiGpcgP/CTJ+8X7Ck2nfZdY2ncYLjrSrCxAxIyHztpiPf8GeSdz7VzWhOZnCYi3YbaPjFQ551jS1fU8womRndyORrBpph6NRIdUT8v20HE1d7qLmrPCVUpONJSrcls0yt0F1u8aVlzEEvbyOIh/IMQqhBdX7iJSKOXHAMI9BTPYUn/LmwvRzHJnGEBz2DV/Fq0I4uzz5P3W1BuO9zwEJliu5EgvQnXxHtM+FVDdH8TnMyZg/sAd6sEvfVMLChNwzdic02mXAQh8nGYGYuWxrQmdzl1YUco4S6ljewZcTe7GKydOWr+FhAdxSRIs6BeuQdKIpZRfjZyhQXuBWXpQmgQPAnwve0VJqPAefcYoa2sz76RfdHO44w6TB2h/SJ6HT1ZUPucLk04SmIFw4aJQRL1LSukTx4FGv+eEweiRBk3h9O7y24Jc1DoumMpZfyazongaU+UEgzvvl8uHfs7tIXJSNmHP43ig=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(2906002)(83380400001)(86362001)(36756003)(33656002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(1076003)(15650500001)(5660300002)(2616005)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAZ6vKoFq+eCCq/zoiiMfZ3vQXwN+wSLkgHV7LCDnGmtGHaev8m4E+6u7JOy?=
 =?us-ascii?Q?yZ8fKQnhaDY12vkdpQR8WvyKYaXrlqseDYu5H8jbKFrLB8aItLHRoLQx5XJ6?=
 =?us-ascii?Q?6EEM5F7V38+5KoR5VX2Ms53gqHqCIMGK97rhNf3n6RpGgNe4bzlb3p3Aj/yU?=
 =?us-ascii?Q?zwOqAMxWFh5IIrBxGym4U/ap5aa3Amk0pydxbLF/cYqO3hywOWYjj+tzglTA?=
 =?us-ascii?Q?nZFmYe3y128/xCKbq41HHxeywThGq6O37NijGRFu8LYydwG1X2ZVtKYQH1wz?=
 =?us-ascii?Q?/vL9c6AANO1zgGuds2SnZY1NYB8QhXhT4p6/ISbgx37fFZ58y6XdLlQM7qbB?=
 =?us-ascii?Q?BUSauQUMOJRK1xF7i9VslfY+aJqjeSkSvPpOqsZjJn2sQ+Hg/caXf5T+D6B8?=
 =?us-ascii?Q?SPQdzGxI7EW+PM7uUtSQieiqooXJydCVeHNUBi52CNUYKTTeIDQ/8kzzGNSa?=
 =?us-ascii?Q?kgx3x26ZjylBIaAPJpnNX8Zh+k1sfkv76WVYbkDO9DgbHm0pTBrTXM0lDv30?=
 =?us-ascii?Q?0pSY5mXrF2+kUUPk4xYgAr8n1J5VcCuhuNj1SixUcMaIbS551xBgqbpXwypT?=
 =?us-ascii?Q?HeklbfsuVJ0JGo5LprQu7xL73YxiFnz1VteeIfwuL6GTZCdGQAToLyEz/sPe?=
 =?us-ascii?Q?6QpJUyG4PUZGMOeAOZaTb+fCkNRA3JerY/5x6skxxGE5yZO48491X0D8nxju?=
 =?us-ascii?Q?896XiPMh6FWRSvGxOnIg8vJ86UgDU3Tu1G2C0put/n7YQyQOb6U/M/rvNhQ6?=
 =?us-ascii?Q?qVQcuc9l6XB+bCIXZMcwdHiiDEykoIbmi+5c7mpD2p98Gci8QNZSEzzgGgfr?=
 =?us-ascii?Q?7W6cg4U0ASeHFRl4IphrkgLaR2pEdMxiHbVdks8zaGBbVk3WyqcOHh/R6EW0?=
 =?us-ascii?Q?1M+SJRQ4buBDhvWUo8q7s/+M62FgmcTxW2IQSMzAH8rGHnuuL3BGTRggUkxg?=
 =?us-ascii?Q?XnCYF78sSoa7opZr4lZHEmJefi0daN1xSUsv3fEEibNl/qB0Sorc5gvn0i7p?=
 =?us-ascii?Q?Ya12zn7ZvRnnjfraa71KF65AXZTOx0I1gYHm4GdMYv3KQkVJPpS6C63sPdDt?=
 =?us-ascii?Q?94/zvuI6fXU/XFzSlIlJb0xP5xj4hodqfD5gNcQMsheZqxPrBj5Dv2motDPc?=
 =?us-ascii?Q?btt80+cVABBkT/vHWRT9RwDAn9vdS+/JY+uMwv4ZoQ25/RpqRpco3WFX4SDp?=
 =?us-ascii?Q?ZvqkxjMZ3c0ndYwFjJCSs5U+2GCxT8G8LuCxgRPZRzjqXAL/uOJvpl2U/Hiz?=
 =?us-ascii?Q?61AEOy3fibTSsR210KZM9efUarkrAqGHTnSEh9zWkL3s7oQf4dFZ7XLsTPVS?=
 =?us-ascii?Q?rFpPiSR9iwrBw2RP22SWh2niDb41zSJ7YnlO3MxXNZ/lTl1s5cB/KphIPABl?=
 =?us-ascii?Q?LwicQMrRroAEr3+cyhyYCwWLdMJ/ks+3U2l2vLNcmwlIeuaT0+zVUfT7h7+R?=
 =?us-ascii?Q?RhKewayjb2pItcn4O204QS/vcWg6vo+6T5rJA+F/ePnMBKDpgp3jgS6HujAP?=
 =?us-ascii?Q?beGnuuY2y+gNkUYS0BdvcXcUwgp0TFGukypod0yNQBZsf0ZO0eHEwGvZl293?=
 =?us-ascii?Q?HVDYn5s+i6WEdYsSEgA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bf6d1d-6154-4104-b0f2-08dbde28aa5e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 17:57:24.2829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+Ij4anWW5jk2QtyByTydB7eShlrhsMZcXw9yMt++BfUkULQwspw4sW1dwHwXMf7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On Fri, Oct 06, 2023 at 10:16:22AM +0000, Vasant Hegde wrote:
> amd_iommu_domain_flush_pages() uses protection domain page table mode
> to detect/get default PASID. Hence we can use this function to
> invalidate v2 page table as well.
> 
> Also in __set_gcr3()/__clear_gcr3() path call domain_flush_pages()
> directly. So that we can remove __amd_iommu_flush_tlb() and related
> functions. This works fine as we have GCR3 table per domain.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/io_pgtable_v2.c | 10 ++--------
>  drivers/iommu/amd/iommu.c         |  6 ++++--
>  2 files changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
> index f818a7e254d4..6d69ba60744f 100644
> --- a/drivers/iommu/amd/io_pgtable_v2.c
> +++ b/drivers/iommu/amd/io_pgtable_v2.c
> @@ -244,7 +244,6 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  	unsigned long mapped_size = 0;
>  	unsigned long o_iova = iova;
>  	size_t size = pgcount << __ffs(pgsize);
> -	int count = 0;
>  	int ret = 0;
>  	bool updated = false;
>  
> @@ -265,19 +264,14 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  
>  		*pte = set_pte_attr(paddr, map_size, prot);
>  
> -		count++;
>  		iova += map_size;
>  		paddr += map_size;
>  		mapped_size += map_size;
>  	}
>  
>  out:
> -	if (updated) {
> -		if (count > 1)
> -			amd_iommu_flush_tlb(&pdom->domain, 0);
> -		else
> -			amd_iommu_flush_page(&pdom->domain, 0, o_iova);
> -	}
> +	if (updated)
> +		amd_iommu_domain_flush_pages(pdom, o_iova, size);
>  
>  	if (mapped)
>  		*mapped += mapped_size;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 8da445e51251..764a5656b56b 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2698,7 +2698,8 @@ static int __set_gcr3(struct protection_domain *domain, u32 pasid,
>  
>  	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
>  
> -	return __amd_iommu_flush_tlb(domain, pasid);
> +	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
> +	return 0;
>  }
>  
>  static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
> @@ -2714,7 +2715,8 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
>  
>  	*pte = 0;
>  
> -	return __amd_iommu_flush_tlb(domain, pasid);
> +	domain_flush_pages(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
> +	return 0;
>  }

You should make the other "flush all" wrapper accept a PASID and call
it here as well instead of open coding it, or do away with the flush
all wraper completely.

Jason
