Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292998F77
	for <iommu@lists.linux.dev>; Sun,  5 Nov 2023 17:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VHqRx9Jv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gu0zwnZDNJPc88XvWYYNvn3ZyrGe/g+yYhbNY+ixWHBDmiXm8HAMEVaLJhSoJG7cjECLIhscWpgNo6/u+y8mozjNmQbUe6KF56p1zVuuBp6FXrjfTyzmIHVQaJbYGGkR2l+tWjBZeUf6QqnUYHq+AyvzTd+ezgZNZWXtA509c3/4f5eHpT3WdeS2my1E8Z9jdDDUqPkOHLqprWkMjMR6G8lSvN568kRl74bV3zAWbet+BxCnNunOCVYbXvBGxmOa4Ht2DSlv5zegFUOskt1p9tn+r+wEnWk2QgiTncIYAYtZO51hVsJDDIZdo20NN2tGIEaIzas7q8Mn06zPCd0tvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s75Z0DhWR3WnL0KeZ6bVSbdPZufwA9NOUwQDcGNnHks=;
 b=VXdoNy3WQfM5nUwZPaHEIAdmoPethNqakHCXFbboVqy6jAIbvSv+srF+h/e29cxsl6QGxdYEJZj0KXWdPF1kz5t/J++ClveSVY8SImr38o0mnB8GUdDkbp/4PHG1JzYSdn4VYgR0orcmwLgkX0FYrDke4wueUnXmkQrFobdyDlOLiBVJltHHpOse2TkhVk1ghvAzNfVlYulBRd6mdCMLWrpCUvlx1VNSjyxlyPuRToX69UKs4AU8uh0AsJrHB0QxNrTeDvYafChvsXmKQTL3OMVcsEILhewlzQL2PfiuRVRBWRTXfjoBxWLhUZGEDPu3sgfsEsphDH5anpV2Te/fcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s75Z0DhWR3WnL0KeZ6bVSbdPZufwA9NOUwQDcGNnHks=;
 b=VHqRx9JvH5UBEvF1PoZdeVLUNPZ8bXJQ/nsYx+hcwYTKflWwIVzVAZPJZhxxjNxfxvjYSDGZ/P1Hk0ArDpbE7WJO3iGHKfSS3910svC+hw8Q37A/KlVcOp9ynqAbfEIKD+f4apotb7p2tn0gonf8PsckBKpUYEgN1BoNHo0/XcCSHCG3cka2MBruoyLHU7H12Un3aAm1vvz88zaQAWK3zb5GcG5OeuxJ8Ys3Ukm/vYxWh7Q7Ss7Ec3LfxZmAAQmivqoGaoaPohHVqgvPGYDEU0gj4fFEuJ21qjZ6/s0iz761bSjhGApfCzWzvIbn/nXWMz6tqtQBwm17CGWQLyoinQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7219.namprd12.prod.outlook.com (2603:10b6:930:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 17:52:29 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::b53a:1092:9be2:cfb9%5]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 17:52:29 +0000
Date: Sun, 5 Nov 2023 13:52:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH v1 09/13] iommu/amd: Refactor domain flush global function
Message-ID: <20231105175228.GI223197@nvidia.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-10-vasant.hegde@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006101624.5912-10-vasant.hegde@amd.com>
X-ClientProxiedBy: BL1PR13CA0239.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7219:EE_
X-MS-Office365-Filtering-Correlation-Id: ddca71e7-57e9-4c5e-7a8a-08dbde27fa6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qD6QF6aTsmWbqjxr7EGZQx11GofHQgQwpwrnp3zwd67B7Woa4URjSE+z23//Ru0Fw5VOX7t9rbK48PZMZYFnQKHpz4nPLM7b9U16Ho8NEKKo4VnHqECgM4teQlIFFp9Z+SvRX7A+5CJOPsGY6kLzaBT80gaYrwMe5HR6PqPIVovlI+TIchG5pQetnP7CGuBTc0RYQpXrPtLGGGHQU6b1ObCCIuUcp7qafQtRL1JYRTtpDr9z/POou4+EvQysiNX1m3IPDexJhHnHMEdJ+JcaT2AAKRm8Q5BAMI0IYPleAuDt1BQmYqSi4OFTZVSKoRcBhOuExmO9oT/lShS/QUlXrmOUihvzsktnueS6tke7sCrw+faYe4dcQ2glNIj9BQYEw7jDuJV8LqaoNWLaPmay5/uuQo/hkwiRB8WGJ9oNrtRyTeHENSPOC87+f0wEwzFOTr1AwGb1W2zpuiC4qXSgNuysuzCk/8InIm8CaPZxTcxM6D69DsFvnrNRFQni7VMTMecI1S4Un+oeF5jhn65jzotA8mN6prUaF1D69qwJfXkCfZourpk22kEW6s2vEV6ymfIWSniv8nVvhjfP0E419GuOWcvKW8oFzd/p5LjwjuaiqfUs7ipahtE8+/ZluUU6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(26005)(2906002)(83380400001)(86362001)(36756003)(33656002)(41300700001)(38100700002)(8936002)(8676002)(4326008)(6506007)(6486002)(478600001)(316002)(66946007)(6916009)(66556008)(66476007)(1076003)(5660300002)(2616005)(6512007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3bVFuAKfHuPCn5TyDIufycoH03CS06e+1YHl0ye2YOyHlw9RI+h0EocI3rZ?=
 =?us-ascii?Q?uf0Ving/xpyW+oWApoitD8AQ4ofdher6b/aFiscyn1Mn/ezMoRduutjQEoZY?=
 =?us-ascii?Q?TVnuCUvjdelB2x8nhKOV7IajkKNSYOJYTZIWxhcW8JYxrmNMJ44GkSWfPbDG?=
 =?us-ascii?Q?kBvYMTklVtGKf3A6dCK+H8xe8Wh5X0Msoh4YedKCHl1Ith6q1nI/T8dqKj0r?=
 =?us-ascii?Q?AFUoEWIu8I5EEFhmrpLa6MalZGa9rHoSis30xZBbxOXqbXpuLckySushAnUC?=
 =?us-ascii?Q?axnyQ7ShMBaIxyf7OcNji6gDi6Xc0KBUzwCr3NQuL8iO2Ch5zZLs8uzmaruY?=
 =?us-ascii?Q?VX7gnOJCitIONDOPG3xSaiWzjUFPMCWIZnh7TwvKk5r9Yw2sITD0cMlQJKdD?=
 =?us-ascii?Q?MDlJ0MmH3rte5/BCErS0bScqOdwhoyMtUg+AsPhWWP+9ZqbNJWraKoOwRi1H?=
 =?us-ascii?Q?Il340kbRucxu3bDhSZa9hvxa3nh/yu27Z52C5d8CLShwBGIBPPI4jFabg/Jk?=
 =?us-ascii?Q?OgnSBIcOgtGEmsZLij5k58jafOZPhrpEofvzxWRwAGOzMTrjYM/luzxF0rOh?=
 =?us-ascii?Q?OoHeB78Ct01+2wPsQGJZ7hzNALi/jwyO4bjQHFiYq+GGTIDrUoiTLQDbvTRY?=
 =?us-ascii?Q?IlbPuuGUyXjrGt0L2tqsAtUVd3j6MFUpMj1xsbZZNy3iLxanWaiJ1MY/1Lwi?=
 =?us-ascii?Q?Fnb/ReX6HOTvurvVJ09SoyxJBR2o0Fbi6nI8ZH/XOK6/kETt69U+1fQ2zZIO?=
 =?us-ascii?Q?k2W3IZoEi1HgpnWcgPeVp5uP4NuUm9gsUMf3nvk/iOul7J+/fqh/4z+neYW2?=
 =?us-ascii?Q?G8EmMI5qwkz5x8sxLJ+97RN98KRJrw7xwQbz1a5kamHPzEwpe8m9OY0hwZG+?=
 =?us-ascii?Q?lbORH9pgophaJxRWBtZBmajzHF87ELtDo1pxd1uyty2j+OWJ9xrwDN+hMZL5?=
 =?us-ascii?Q?t3KfzbAIelN1i7mpUvOBtMOQ5hkyC08STsGc89cEUd4AvETgaSdvJSUl9nki?=
 =?us-ascii?Q?VTz7+y5blg9iOC4esUObHox5J9mkRRSI6jKbtLM89gx7ULkdyutCpXQKztsr?=
 =?us-ascii?Q?NWyvgCKBMHsL+dlcVI64dKFFCVzPLGPRwuQtyoQwdXa7ahqr/fvbXnmS2vwg?=
 =?us-ascii?Q?39Po4ZatC51Fc72mTyVjHsSqetjoy2GCSRjucFUqJCWEUBOb5juzIgnT/gzm?=
 =?us-ascii?Q?EXM0/roHk/4qnqZgsYUuUfBdi2F/qjicBBjzMJJTy3mCbqj8mwq8ndnCM0PI?=
 =?us-ascii?Q?Yd9DrCXAoinFZtZPmuNsuffkBEQ7Go0YcnuCUIqRZIOBJvL1/64t+o9xjtGS?=
 =?us-ascii?Q?KypTyzwerFA2qXXF+MC2XeHE3dGtD1VAfUcoVjQJdUlbowSCAoz2ehYnTcsq?=
 =?us-ascii?Q?DtjyR0DG1er1pkEDSGiwxTJ0RJ0F6nH9G0t1FI9XnlIb3jWkz+uBp2MWopII?=
 =?us-ascii?Q?KcP55/vTzaKuMKyFK5X6bdFzM2w77gMENZl6wsXw49fnLyyTKOdIrygGTbk3?=
 =?us-ascii?Q?1+YKkPisZskM67gGq6aEW0eSgGJ/YrKVDwtJGh1T9reDOmzBb98TZ7yG01ge?=
 =?us-ascii?Q?8kqgn017zbR4tKTIy8U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddca71e7-57e9-4c5e-7a8a-08dbde27fa6c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 17:52:29.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5FxJtypjAEZT1pSkZW1qhXTDJbwFhlnAJbh2KqpPFwHJiWrKLfyhysiUfJLj4bi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7219

On Fri, Oct 06, 2023 at 10:16:20AM +0000, Vasant Hegde wrote:

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 1f695dd50fec..c30b08e2a939 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1553,10 +1553,18 @@ static void domain_flush_pages(struct protection_domain *domain,
>  	amd_iommu_domain_flush_complete(domain);
>  }
>  
> +/* Flush range of IO/TLB for a given protection domain */
> +void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
> +				  u64 address, size_t size)
> +{
> +	return domain_flush_pages(pdom, address, size);
> +}

What is the point of having this maze of functions? Just rename
domain_flush_pages?

> @@ -1859,7 +1867,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
>  	device_flush_dte(dev_data);
>  
>  	/* Flush IOTLB and wait for the flushes to finish */
> -	amd_iommu_domain_flush_tlb_pde(domain);
> +	amd_iommu_domain_flush_all(domain);

This is weird.. The cache tag for a domain shouldn't necessarily be
flushed from the iotlb when a domain is removed from a dte, should it?

ATC and IOTLB flushing should be seperate. The IOTLB should be flushed
immediately before some event that causes the cache tag to become
invalid, eg returning the tag to an allocator.

It is a minor point, but it does make things more understandable if
stuff is done in the right places.

Jason
