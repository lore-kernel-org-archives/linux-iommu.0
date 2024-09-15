Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12961EEF9
	for <iommu@lists.linux.dev>; Sun, 15 Sep 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433476; cv=fail; b=DbQTUpfLlxyT8HruFk0BglbFBH8M/YAxNUqaj/+Z+j0xxTZIwhZiI44SiYPaCzESOSErzbr+AHtIrmzXEXVaILFegUnx9zz4LrOqdSPhF1k8KJCYn21Km9yPWvsdYKo3vhvWAbPf1NYTaE1P2Rv6zSuWSSB76y/f5yRLziy99j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433476; c=relaxed/simple;
	bh=DfQr6WCTX/gznee+ARXHwFSmAxqD06AgvbgdDolxTU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ix4f7A9FOUUyu10bh7D7I+QCX+bdYVTYS4xD14y6xqnNvqtK/JoG2isbvXBnU2vFtAZoPoR65nWNkoxAUY0QhAjjQRDWzF6o184aW195r2K8SDOungMufL4RYpa/wfiPeR8FApPFcjp47sbMyHEBeFW1nolLgaAEXNFqBTdfJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HCMu1dJ5; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HCMu1dJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HgVipvkq30v/LRafwMXkWd7WkJ97Q/Db5e4oJfKOfqmJ99LtBXKVtYN3KKYIrP9linNmWPbyVDH912Fcw0DBo/aNpf2ZVvzMqQ9YVlYQDQNk34ykZVsFVjm+4PQz6u0csB9HQEVqF0nXm6aax+8Lol7xTtc4w/DInfjZoyg0ogvnwkxwsDZnHM9tVlnH3cMZkaS7Pv4iCugo40gEiSm7q7XLUt/q26/WYiZPX62GtIYp2CGJV9cZDQOnhGbe3Dt+rXLj7a8GUy3SZq6fBP1a869amJFEdeZ9K+P9MIafIyWslzva/XNPTIXoqyOY/KvpsIpqZnNC8cpnFRs/4o0smw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGjCfDLh2euBXueUeTtlfc+KLDemq2ekfPa0cwsgFR8=;
 b=ySzU1hwuwd9OkMgOHLHSwbhWEzHDg2c9uyT7P8THsRnl1StDR2ncqVLcW5f9wb3fVGhSNkJITI9qHpqORc8cb1BRzCpl6efwpnSccmOdDQAEBtCPr0NCI14MvwRHXA/y6wpGlNWwcTX6D/+dC8TnuFZmCADVKBykqoyAliNnINaghZgMb30w6yr7lr1jx7mb6AmE0PCrg20GHitle0vKdAafmq1o7T1eluzP0XyyV34Plk4f7fVm9IdroetHeAc593k0XPoJ7QEPkl5OIcnNqeXNorQsxsePMfgHm2ONj6s9oPbqozBuuorvTSSWyDv2oPbOYaJ/Hvy5yYc+LbyDPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGjCfDLh2euBXueUeTtlfc+KLDemq2ekfPa0cwsgFR8=;
 b=HCMu1dJ5hBJrqh1oj2zsufYOGueO2P7cAeNTxxniWMUTzpIKh0/lRe9RW4jJ1dJccfBTRAjkC9GedHUWQfbE2abYgkTCrIDAGRj2CYB6tHS6eBCiJE4Qt187uIERXKLKDFUmJOCYW24e5qevq+sT5yIlXnKgUTnW5zKDqt07eEAy1WlZV29KQEmicdN6+hRCJoejbov8Cvx3AxqGcLy3ZcFu/8o7HcFFM4pZsat8tvyLN1EshJMXSwQXDTUQgPlkpWjVzpDNkhWzE7oCjjTSgPGM14WuqsYFnW4pbPg7k9SkKNyBL5Nth6euSYWuDzxD0PCGeP048AYj/esZR9WQkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 20:51:09 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 20:51:09 +0000
Date: Sun, 15 Sep 2024 17:51:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V1 4/9] iommufd: pfn reader for file mappings
Message-ID: <ZudIu+nvmY1N0CKR@nvidia.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
 <1726319158-283074-5-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726319158-283074-5-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::30) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 33092fa9-e9b7-49c1-4ab4-08dcd5c82056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VGTAH+NFXGBt4EzkXF9G57dJ+FW0qxh6ponKzUze824qUMImvBtCsK8gkDmT?=
 =?us-ascii?Q?7IW2QD8gO2eBAi6tI/+mEUfwc6AKtbBYV30urLKBk+AIQZ2tDDEElx+WMmVE?=
 =?us-ascii?Q?TtoUEiSKzMkk3nMMK7vLCQHC8F7cA/qrkZM+7taXQaI7lvCiy3K0Oh4RolfM?=
 =?us-ascii?Q?+a6vqk8KXFBpm0aD54Hn6URuFIc3xrk57sZSxZTi/ZlSZIE8pzY7gztFIX01?=
 =?us-ascii?Q?AYB2vI3EJ9123VHBggPKKYUGBkxmZ8JDdivzqrCCFMJvPFGSxz5QkWkV9oXa?=
 =?us-ascii?Q?6LNeZaaFo8zbjd6Cmd7xVVHptNL+v7UccB8MeNseMdGIzvgUiHAhCeuQCQ0K?=
 =?us-ascii?Q?I0nKs2tC41MeE2jFLe2fg8E2E8XuYp/Ut21V+KhFdb9wCqoy/c2DpNPjmXTa?=
 =?us-ascii?Q?nYWi3+rdrAWOcFc/VH+pOLtzW/xRSENMEg+j2srNwUR90HEdYp4JPeRdwIUS?=
 =?us-ascii?Q?UNGCcuR4S/aA1LLzwVudxEBH6o6skzk4i/NEnP6dNcpALp3VUU/tJqDJLwIK?=
 =?us-ascii?Q?ZFfhxq0C0+XPEZFg/KFC3ilqKkbOqTzwb5hGVjjuxRdHjRzs6vxxkzjSFp/o?=
 =?us-ascii?Q?JVvt4q1oVf0M6EXZp5Cj+/PDAFk384nqKFyKjA7W0tGCbqw9pH0dKB/fb2DU?=
 =?us-ascii?Q?TyXD56CC8+M+55NRL/jBE2XVCPcNifEa8AsHoJhEY548+4MlKpN49Xun/pyw?=
 =?us-ascii?Q?luM46XzRHnAo71URh98+Lyzl5GFIJXowEyLJveg5Nu4QPvlYbfxPsfpXwCqb?=
 =?us-ascii?Q?ZaNTiEWrrO8sc233CpmXePahSCgyCOr/robwWdLEUq9aT3Krst11XeTZLs+n?=
 =?us-ascii?Q?PXDnEZFGIJzAF2J1/K7yPFGopCtxfFAEQFt7Q7GmWbLbFTUQ3ct34NNag+QQ?=
 =?us-ascii?Q?SOZj465kTZQzAtNwkwtGrkt2UcdIB3NYCGOrWSuQ5hzoiG1KGDKCMW7Zk0AI?=
 =?us-ascii?Q?+2S9JcrYt0DhH707JG2g5XBXXbkolFTIdl8fWzup2IY7MsZg2t2bpNhAtjFA?=
 =?us-ascii?Q?Gycm715t0sbdECa1jxnNU1B6tjqrP4BGhOk2EMs0ywcpBBF1DzUILMOmv7l2?=
 =?us-ascii?Q?eKxD7h4LuoPILoC9W5WsZGm44hOj9/GI70cJPn+C4JDWg/zYjfQOJa7caYx1?=
 =?us-ascii?Q?zTGN4Mzw372mcZ2INaEaKTyIbIfE66+aIw3bEnkKCbzIWV8ZHm+ImJKPptRG?=
 =?us-ascii?Q?f1xumEXgwjRmq+VW3os2PZAqVv/6dZa9YnLQlQjP1taqQQ8m/Lx4reOjzf60?=
 =?us-ascii?Q?gmjXwTI3vTjnxpCDMHJw/xRa26fHuSQsh5GEql4gz7xco5WrjcKhk7V7pNlY?=
 =?us-ascii?Q?A5s9Gs9iHA94fP4Vk6ZpdsusefFRl02XGdqsZRUOFL4cIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iNdGIjzqPgxFQn3NBVAQGYvtgwCCvqn2ScL0LH1tqfL0bs+azn8PsiWtM2hV?=
 =?us-ascii?Q?Fct1/aUY1z7cHVFS3aSypORLjOPScJqv9zbsB8SQb40CaYZVKKJJyUCX+tDH?=
 =?us-ascii?Q?wexVz9cmOfrhWKwIHvGPM1VwqnMF/i1XvhMpQaITPCHJxbbu0BZk9Y6BzwkA?=
 =?us-ascii?Q?wBYW3GScAV3Rwl6DigaPoFzXSPfKGyPGpwRZ4udBM4SvNn/KgzEYQpx+pzrT?=
 =?us-ascii?Q?mqXYILewP9DCR4wyJHx0AESPBo7z0YQw2O7kKFu/rxD515rlXlb1ihvNZlnA?=
 =?us-ascii?Q?STcJ7MPwNJIAeevxNW4o79F4kFmsTD9ETkvYBUFDzc7DRy/KiOkgfJHi5JLm?=
 =?us-ascii?Q?Qc124mmmFAnxqIycPVdkABmRR6djm8ct6nTAp3FAtjBduT4xmlYAiSn7Aqua?=
 =?us-ascii?Q?9tgztEWG9nMAbPH/hePEam8smNY8o/lmfJOWJ84yDfiICJdcOP3f2WzyTczs?=
 =?us-ascii?Q?4eSJrHbo8OjGZ9lv6vWjilPaI9IMgWir5NaiXHvCaAKr6yWKvMDXtGFFlNC7?=
 =?us-ascii?Q?40BF2lBeQgU0/hy9rrzTb14IxK8w0MdBCGnRNSpd0fsg7PDo30TqVowl7b57?=
 =?us-ascii?Q?mcgqwnOWPzebiOvMdABGC/pd9q7CoEEIa0irh/jUg+p2E7EhEGViqqi5Coxq?=
 =?us-ascii?Q?ZeCC2Euk6OQNwDXJZ3qmiVd/WFE4Sx0gAYhm86zYnIVK+CZidws3T52DYz2y?=
 =?us-ascii?Q?GTsico+vRuHydSMXEwdz53HaL2dzFQVIJ6K9zi4CKlNGyJ95BoWUxVqneecX?=
 =?us-ascii?Q?9RbGmArYMtBHOzXXkaxxDfuZOU/vqXwnWtQNkQseL2wXgAHxUUVTfERFCV2M?=
 =?us-ascii?Q?lunjzEdN8yV9pK4pc3DXs2V62aNGxVdKEDfxx1HIbkiW/vSeNY8eKuY7Rszh?=
 =?us-ascii?Q?1FaxYVwW8q909E70/7OAcd/KoP9ZkR73tm3srUIWK7ZTKRuW+A2ZYlXvn282?=
 =?us-ascii?Q?Vdnf4jH/q8tsZ3WLnpCLAfG3pIvOnkcKNHEcpPm+X/SStmXuEh2nI7O3eHft?=
 =?us-ascii?Q?Nt6tIIldROrsHPAUjQ6dDtB/H6gP2fHAtceWRwkKyyJLBSK2VwF2fO8sFXI7?=
 =?us-ascii?Q?7H6ZOw/ciByCwhtIyZuiDoWHA9lpl4+P1GhdpDHRWnmfdANPMaNs3vLxn8Mh?=
 =?us-ascii?Q?soL29ncgmNrPEF0BUuKXOYk+2kk1OpMjOv44CY1r9QEZkX3e7BFhiuxjjhcg?=
 =?us-ascii?Q?Qyghc33DJJ3yq+nv/3wAzxYhZa+Zo6OFbhT+scuAbpMcXOSFYrr1fS5tuItm?=
 =?us-ascii?Q?KyliFgUzUPpbuiOfKWwzAnk/o9N6Nz6BPRmEIlZ/Q3CNMS8QPx6A0Y7BXIeR?=
 =?us-ascii?Q?OjKLcyfQuWYcFU8MW0o3/qJGmDY3IijUQH5oq7t/78Q7lZGBJzf0hWtW8Y+F?=
 =?us-ascii?Q?B6pMxQnBHivzxU0VgmxYAIbzcQZ+3khJ1IPZ5kqZni2XTH+wiXx9K3/CpOrM?=
 =?us-ascii?Q?I1CAvLvGtYAIF+O3mLQe5+YmhJQQeN6JKyh1bQMjnri5lUgTpilPowJhfUCE?=
 =?us-ascii?Q?cdLi0oVGnLtwKNOF+Fa+bNaaKmHhUTO1rq2/MLnguWRMNgV74Yul5BUzNMMS?=
 =?us-ascii?Q?lqv4YpwVK54s3H+AhDO5McQJUuPzojCSnuLoiCgG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33092fa9-e9b7-49c1-4ab4-08dcd5c82056
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 20:51:09.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldrdb1gfxqdOrNkQItmCIAE0SP2u1aZtaDCRoOS1Sg85+pOlfLguQhajpyFCKI9E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

On Sat, Sep 14, 2024 at 06:05:53AM -0700, Steve Sistare wrote:
> Extend pfn_reader_user to pin file mappings, by calling memfd_pin_folios.
> Repin at small page granularity and unpack pages into upages[] to mesh
> with the existing code paths.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h |  5 ++++
>  drivers/iommu/iommufd/pages.c        | 58 ++++++++++++++++++++++++++++++++----
>  2 files changed, 57 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
> index 7c4a338..3a28f46 100644
> --- a/drivers/iommu/iommufd/io_pagetable.h
> +++ b/drivers/iommu/iommufd/io_pagetable.h
> @@ -177,6 +177,7 @@ enum {
>  
>  enum iopt_address_type {
>  	IOPT_ADDRESS_USER = 0,
> +	IOPT_ADDRESS_FILE = 1,
>  };
>  
>  /*
> @@ -202,6 +203,10 @@ struct iopt_pages {
>  	enum iopt_address_type type;
>  	union {
>  		void __user *uptr;		/* IOPT_ADDRESS_USER */
> +		struct {			/* IOPT_ADDRESS_FILE */
> +			struct file *file;
> +			unsigned long start;
> +		};
>  	};
>  	bool writable:1;
>  	u8 account_mode;
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 69822d4..065c28f 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -695,6 +695,7 @@ static unsigned long batch_rw(struct pfn_batch *batch, void *data,
>  struct pfn_reader_user {
>  	struct page **upages;
>  	size_t upages_len;
> +	struct file *file;
>  	unsigned long upages_start;
>  	unsigned long upages_end;
>  	unsigned int gup_flags;
> @@ -712,6 +713,7 @@ static void pfn_reader_user_init(struct pfn_reader_user *user,
>  	user->upages_start = 0;
>  	user->upages_end = 0;
>  	user->locked = -1;
> +	user->file = (pages->type == IOPT_ADDRESS_FILE) ? pages->file : NULL;
>  
>  	user->gup_flags = FOLL_LONGTERM;
>  	if (pages->writable)
> @@ -733,13 +735,54 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>  	user->upages = NULL;
>  }
>  
> +static long pin_memfd_pages(struct pfn_reader_user *user,
> +			    unsigned long start,
> +			    unsigned long npages)
> +{
> +	unsigned long end, nr, i, j, k, npin, nfolios, pgoff, max_folios;
> +	unsigned long npages_orig = npages;
> +	struct folio *folio;
> +	size_t size = npages * sizeof(folio);
> +	struct folio **folios = temp_kmalloc(&size, NULL, 0);
> +
> +	if (!folios)
> +		return -ENOMEM;
> +
> +	k = 0;
> +	max_folios = size / sizeof(folio);
> +	end = start + (npages << PAGE_SHIFT) - 1;
> +
> +	while (npages > 0) {
> +		nfolios = memfd_pin_folios(user->file, start, end,
> +					   folios, max_folios, &pgoff);
> +		if (nfolios <= 0)
> +			return nfolios;
> +
> +		pgoff >>= PAGE_SHIFT;
> +		for (i = 0; i < nfolios; i++) {
> +			folio = folios[i];
> +			nr = folio_nr_pages(folio);
> +			npin = min(nr - pgoff, npages);
> +			repin_folio_unhugely(folio, npin);
> +			for (j = pgoff; j < pgoff + npin; j++)
> +				user->upages[k++] = folio_page(folio, j);
> +			npages -= npin;
> +			start += npin << PAGE_SHIFT;
> +			pgoff = 0;

You should try harder to avoid this loop, the batch already can just
swallow a full folio, so this would be much better to copy more of the
code from it's caller and be more fully stand alone. Use only a temp
folio array and stick that directly into the batch full folio at a
time.

This above will be functionally the same, but alot slower..

Jason
