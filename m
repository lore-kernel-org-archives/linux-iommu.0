Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F922AF16
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095378; cv=fail; b=hUXgwyXSGx1+9nuSzqizJdws4zAZfiiO01/XgAtW3WrvrKZ1g67vb4MkgpVXZOp/Uv84WOHhM5WH4K9CsTCzfBNnnjdMPH3De5qaXdS3ImgeidvQqD0rQ9oeCoD/k/pF2kac8itlP6Jo9b16T0g8BBXufm3RxxuVTd2cyVZ1/fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095378; c=relaxed/simple;
	bh=SaVzp49Q+c7L4/3O41xLxkc0JgFSWLgxoVM7ngRjn7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IG95WsNmEArKxwf4gX9JUERm0KxH8EZGbJ06GZ3DePu+QBT7HZhQyTEm2vHXRAV/62+lyya12Ugijb09rFACDRCpvoAjoybyVGtXt3GT02EQk4m51uL61Uwztli8ghMOWX57bKU5nt3T2bSRX7x2Uk7kNC69GKMvLF1cISnQ4jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nkNUPdQu; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nkNUPdQu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWXuafJ31RlcJb0QFLsaUZKJ0UWRQO/oHnhnguHpv2TOGam7UUmLkwXZDFdk7m5aw2g67N0tjb+iCwzM83rFQTlyXYLUFJIjGbBvzSLPqHjZXQX3Ng4rHCbHvfmpIxpqwHJa2GwGcB/lUjhwWzDmkugQBr7v8p/plzxuBhSwDXYbNYu/D6osjtS+F9m2D14HZKIRR4R6tOmJjhMj/JNoMGAtxmHoumJUSwFzEZt0Plftkn1Xul4kFUKrlbiVillrG9M0zM7GGRYPJWEhoUidFzYb7YpXX7qZwRPd8WTMn42TasIxeH5GRLQ+r9r3y542mlNIiOUN8/Ifj0JjaeSA6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjC0cWi73bZDruLx37fmdKsSw6gakMYPLjlLmiD2lFc=;
 b=o7mjhJb2IIi2zg5xd78C+fVbnN6VyquBa1ZMbZlWuG+U6khWXE/mEGGGoWSYzefw6Cf7Lr1suHSYhALTXHag7MhUq08O6IylGstTN5FXHiJivqLzCILKdaPJ4JH0lzJZU9k3q1aOohmpacAoHYL09C6MEnAUVInnAoHhM7/r9tKaN4MJrgV0Bf6UBxtXcNAkDtA82h8bc0TBIxnu/wYt3uZnk8/pHJGvbyrK0CLY0NwVAPy9wiysYfNR9Dm+xFANI04Mmuo4mAVhEiI1HNKV5aC4FisWEc88tSBPHoJ0r71Rg9FxLtG9wTjgzIAlRPXQNL2m4sB6V3QA7SO2ubtOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjC0cWi73bZDruLx37fmdKsSw6gakMYPLjlLmiD2lFc=;
 b=nkNUPdQuTmIszy/bGDWpmvzOPtwomd4rx61rRxpZd2sbYzxFGv6nBf4lbqQ1bpMUVkAikdvdW20jadFyv/7Ua9D/H+DonpYFX99yJeTmRBR0U4dIVnP1dAL69cJHChxfAO36kU5myMdBGjOfXRyONnVn31eY+44OQygypvnuE/Ouc0Wge1xYQUnufAcGXZ2ogPDF6THC+7gBiNmwwFNb9P5Wpe+rWPavNNf5qKzUZB0U0dG6IjFVKY+vm9gyy5ZcMZdBFHAcrmbQDfLIZ6DIpVhtfTsCYOSXtdxsb6bf/Wr1tbDBxShU8QiXHvvqFhWaEySKCNMCEntjew2N2P8Hlg==
Received: from DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) by
 SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.25; Tue, 4 Mar 2025 13:36:12 +0000
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Tue, 4 Mar
 2025 13:36:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 13:36:11 +0000
Date: Tue, 4 Mar 2025 09:36:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, iommu@lists.linux.dev,
	robin.murphy@arm.com, nicolinc@nvidia.com, will@kernel.org,
	joro@8bytes.org, vasant.hegde@amd.com
Subject: Re: [PATCH] iommufd: Disallow allocating nested parent domain with
 fault ID
Message-ID: <20250304133609.GI133783@nvidia.com>
References: <20250226104012.82079-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226104012.82079-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0119.namprd02.prod.outlook.com
 (2603:10b6:208:35::24) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	CH3PR12MB8659:EE_|DM4PR12MB5986:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: 14d5cdfe-c57f-44fd-df81-08dd5b2186b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1cAwKma6qzOus7YOuDaDP1QSsqXDCsgKQuUB/xZ58moN04OFb8Exg9MAq4Gl?=
 =?us-ascii?Q?KHo2VWxFnmPFy6ZKG61GD6TofAcE2xih5GKsvAQTUvEYYp4KhG36HioeZzct?=
 =?us-ascii?Q?t0kKvCM4gXNj0GSnbyVqG6ELHotjFNkNXezdgVLo9FaDKD6Eh2CX5iwiTKcI?=
 =?us-ascii?Q?1Lu5S0wW7UdsI3txVR2AcHdP6hEzpVvg6YWKoozVG+i5tSYHG6hxbc83lc9J?=
 =?us-ascii?Q?nYOENlFUErkQ8J3WKPCUx+RawNc/S2GTW7Ua17I149JSBNuV2zWD4m+TdHDH?=
 =?us-ascii?Q?Yu3tnfddkZ1XhpkPw3hPLbjOjSXyvrL2lwXBn23P5OSohA2tBvD3KxnaLRAU?=
 =?us-ascii?Q?yPRqVZD/TycGiUvE8hqEix7D953+74FkBmFlH0rnxSZa2tMd34j3XzyEicVv?=
 =?us-ascii?Q?AQoPZZWwEtTjr+J7pk8tebH6QFXGjMyr36gn6Oxr/AWOtz9aglJzWZogB4ik?=
 =?us-ascii?Q?EtyeHRxZcSIpeNUGnBBzGZo95vmpISxvnEcho8QhH+rU3xAlyR0Ryje5q3Iv?=
 =?us-ascii?Q?+/1/RuHUyEYfo93J/wiaT8cMQVFsCSKQiRWxiKG/KJtDgpf7KTaiU1o64/uj?=
 =?us-ascii?Q?PFKCQKH5J0GlSjvvkzC0lF6MiM1XRo1MtgXXwemeNRP7j4UaIrKoautOzxLN?=
 =?us-ascii?Q?fWyQ4onjJfPRPK2lNUrK10XTf9gMk2MSGTg3s7qrbLiVLwfd0drwUkO3NzUP?=
 =?us-ascii?Q?uf7bQGVHjOzXzt7czyTWtaC4CLL4BF4b2bAj/BuVdyn8aUldD8BK3fminSIX?=
 =?us-ascii?Q?CVVG4l90XryKLT1Ac6I9AK/M9yjklS3vV6YxU+2JKgNZnb1Pp2UpnUDO6bgO?=
 =?us-ascii?Q?YdYa0rkFDOW8FZriZDOuT3xkHZ/X35f6kvgDWbGs7y31F5TX6P1pf0FpLUd1?=
 =?us-ascii?Q?b6tXLixMbxl4PgbtMhcBkIOT+fl8ABErDt9JuBghmu9UJC0a0E/9FMngatWB?=
 =?us-ascii?Q?VTvpiDeDvt+dOd1fpiPPDmdTtLYuN683/PAq+F2JLirHvW4lo76igk9TiuU3?=
 =?us-ascii?Q?QvzD45Y26cDLL/uOh0rXUWy6aAMo1MHIo6qmU34uOcFxbYK6RqXOPCJFoZcU?=
 =?us-ascii?Q?gEQIn9qTKruNBnqBMQUkBh1ZfDnTy1sbqbIqy+ZXggchvyfV1u7z9ZOUlQKg?=
 =?us-ascii?Q?vxcAM7rQf9Z68k48cuemPOiJUl9IY8iaFdZ8VeIOxwMJHZ0euSUBD4HEVJYi?=
 =?us-ascii?Q?bdDm6bLRMFxKz0JHOUAhiZ8Bs1ryT20kuS8QIwYB0unZ7wSuyKIRvxbMipqd?=
 =?us-ascii?Q?OVVUL7Q2fzMkqdPGZyMYJqhUQXHQ2BC+4vmJGhO4Fc/PjdNCuRidjpy63s99?=
 =?us-ascii?Q?Ca0D7+GuBxGp+xQDvMxwNQaSFMYJVf2qlbJOawIOuekhoIUAi8DfIqbkHNif?=
 =?us-ascii?Q?Ukd7cjJUWu2Tn7kWvZ/O84Bn69vF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5986.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0ksRvhU6lLf/9KqFseeY2J29Xu3icAggY0SvsSuchNsYEZ5jXUsrocT/FwS?=
 =?us-ascii?Q?n0ZW5X30eD79xGAx3G2eomZ+BdfR5fTWbc2Q5OdzJ4dzImKr9Vgu6erILqjY?=
 =?us-ascii?Q?Dd9ZaumClk2w8+oSbP/MNqzp8XygfK760kprfFoaN/iph3nkr9spJiFzJB/S?=
 =?us-ascii?Q?XrHIXPnSIGynGLWjSHAM5TggUDq6js07BxL54Yni3IIY+chzUfmhUmOb4KGB?=
 =?us-ascii?Q?yvGCNo2V44+J+aBGUH/QAwwa19gbCukTb/y+OEm7EtD7vB2CaBKyaOdWUmal?=
 =?us-ascii?Q?fRCrCLKrONVaHi0Wtc8KDKdrtEP5GY0JGd8hQ69sjnoGiWPDRox8pOGMdEfe?=
 =?us-ascii?Q?ONsp0wcO+HpZ/uHuNLafLJjNGufF4JquV8f8EBUXcbCKqcJFxj3ZQXvEvSJ0?=
 =?us-ascii?Q?ZvcwsQqP5nO9sWysIRNXlh4Rxe2OWHKGASNnWPnZ/qRROKsi7Zcnf4KeTv10?=
 =?us-ascii?Q?w010JVl/GQDNaFzyPa2YRG33s5HEI0UCWtDfec/JNhLQ1seNKksB7uFjFoTp?=
 =?us-ascii?Q?eiH1xZxpjBa/Ac5Rm3EoVr8C43GumZTORRNdFSuswAFC5ljhJJ/AKKinwuAb?=
 =?us-ascii?Q?Vq15DvZEa4Ets7ji6kxcDpdAX5fV685uCac6p8aA+JaA1xkK2msfuq0nBrqZ?=
 =?us-ascii?Q?u3quNWbb3aPtW1+NJz0D9wp6IBG9OybYr9O/3T38mLcI2ilcGJIrY5v7La56?=
 =?us-ascii?Q?oM+jhTl92ulso4mVxcbNYt7t1hwIsXCmHMNBGYFA6xCsXCEqHyjLlLyMrbfJ?=
 =?us-ascii?Q?roHS86qW0iERcVfM/nf1DL+UL15p7WA35L+eXfgwKdZ9a0tYLlKEhCgt7S5q?=
 =?us-ascii?Q?UnIfegvBKDTBOVpZdRP7cmioE9mN4xZlVDbBizj+7qHmF3xbsVXwsJw6aE2/?=
 =?us-ascii?Q?FswWixptPIw7pZc1jQEVJd77nZUFCHvRIFlmnazWWX5PEklPh/X1+AfruHSp?=
 =?us-ascii?Q?nH142hXtb4uP4siDGLbD0mlr+ORKJXdVoc9xQidLW0M85xbpinxCDSo85Sfw?=
 =?us-ascii?Q?PJeep9NKpIA0HWWG2kI8Pry4eGU85L2Awk2HLF6JxhfCeOFxTPImwe9iIHAS?=
 =?us-ascii?Q?OkqP3Ul/NAwnKq15JoUvCtWT1p61doQq73hop7h/D9hEcZir8lSVgZ51CC+5?=
 =?us-ascii?Q?JAFMy5HoWX8jGaxnMabEhkLe7nMTVcACB8I5DcWLT4Kzmf/sZekZnObTTaGQ?=
 =?us-ascii?Q?wkafhG1lXEYlmUoeUWKdURh6f+VVS+hek/CobQn0DNKHWGP/O36tr+qtUbdC?=
 =?us-ascii?Q?2d3aVgwQIwaohu+hOO+VhSSlIepIO9jpGarQ21gEqP8vvFwo+aQKldgHEDYx?=
 =?us-ascii?Q?3lDvFW9Jm1xt1CxJUwUBzSGCuRYXpiijY5mIretuVYBBs7Nk2Puz19TnKV9i?=
 =?us-ascii?Q?KGsXwbkAdnXPuGiXeCIcrVq0X9Ghfv8BWWjrpx4SxKFVfGx3XBtmt59RktA/?=
 =?us-ascii?Q?LQke1l4rQx66YKkrW8FYeEItFcLtBAUiTRO3TKDCVHg3b+ygsshYfVMvKA80?=
 =?us-ascii?Q?c76jxEMll1UjoudKE/otulXzQXSNFNR7DQXc6b0JvS2ZVc7IJ7EZIRDTkv7w?=
 =?us-ascii?Q?Guj2mes0emIFPF7WIy8muB/rGrijT0UWmZ0xJAiX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d5cdfe-c57f-44fd-df81-08dd5b2186b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 13:36:11.1171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9uMtxT3RHdJMB58h3C7Pzze5mJM6kPQDMTxu6lL0xIijU+n3b9/VdT1oXR5ylnc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

On Wed, Feb 26, 2025 at 02:40:12AM -0800, Yi Liu wrote:
> Allocating a domain with a fault ID indicates that the domain is faultable.
> However, there is a gap for the nested parent domain to support PRI. Some
> hardware lacks the capability to distinguish whether PRI occurs at stage 1
> or stage 2. This limitation may require software-based page table walking
> to resolve. Since no in-tree IOMMU driver currently supports this
> functionality, it is disallowed. For more details, refer to the related
> discussion at [1].
> 
> [1] https://lore.kernel.org/linux-iommu/bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com/
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/hw_pagetable.c    | 3 +++
>  tools/testing/selftests/iommu/iommufd.c | 4 ++++
>  2 files changed, 7 insertions(+)

Applied

Thanks,
Jason
