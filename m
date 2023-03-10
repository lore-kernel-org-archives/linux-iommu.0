Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821A57E6
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 01:00:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtFYQtDrXlv42fdCIxocUkSrqprTB6A/6qcCyKzke8kpK98EUirW9+PJ8fSXBd8BSo/cXtE91cqB747BWY4BW7qVrGKnl3O7f1DJqnUr2ClqZpDgRx7iaikuJ4PmoulBAIwCh7A5MW03Rkk9zG6fc8ykWjGKjGSSZdUpaYPxciXeyhLj4XIQVvRBCo539YprNVhl3CmsJrcc7nost4mud1VmSY0DbW7OsUO/9EW0rPh4wDm+jpW5qlvy8fED1jqKgUbs6F5dYRlrp9O0/hHvgoLiqXj88cyvczoUibHhFzCpo3U7+e42r0/C0Igv9+HNBxHGckLly7XZODc+aCHRtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciqxAzyqUXtuwb5/tCDdNiYIx1qinCH/bywEy9OjsG4=;
 b=ZbTA4fhjAurMt8KdKMBbFGgoNz9xHh/plS9k1/uogrjO0Vk+7OxgnG4y7dBdCaptyp2gSfj2liNTGzoNPSaMvhxswr5GOBhRZGRF0lW9PmGSf37yLWRVBFouWz6jfZBhXvYaadTTe28e6IKv/3BGl4Ukr2PIuoAENlYF6HA9d2cHUvRh6ZLZpbPw2DwB8ARbkOQcqhenwGlMgqH4EF3TNLJ6qzsVf0MaorWJmV4QoZUUxdE+s6eA4fmzQYsEKO16ewbA13I5oGxdS/J0Yj2iLV91oEzu6YLhcGoliGHEW4byAknkK3w5WoCoKKNfZWkbGu74jmMia91XKropk1uy2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciqxAzyqUXtuwb5/tCDdNiYIx1qinCH/bywEy9OjsG4=;
 b=THKwGAGZGLLwEd82ksh+i/lXDgk39UzDna2zbozs9oTo4m3KjEOrfx6tOzruH7dTTN+rMcW6krjTMbiPc+pS8P54UNFwtGm+xbR3n8GvBKfZrQjQMskUAV+y46QWDITqvCRw1EkyjK2rtbQKXSHeoEEqHnW0KLQhsJIXR0MZ7l8R8r4zqkPavIMHVTo7SQKzauPG4U2PvAHD3+FVVy3+Q3/NEcY/O4YTTay6vFBqfv8r8Aig2Qizr4y3dCaKyIcvWGr9TLs3U5rFR9HpxFsZaf6Nd4sC+FyeOcIUBKTOS0AcIq4lin1/hgEuhscVNPpw4KmMuOo7Rx8GtpPZp+NUjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 01:00:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 01:00:34 +0000
Date: Thu, 9 Mar 2023 21:00:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@infradead.org>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] ARM/dma-mapping: Add arm_iommu_release_device()
Message-ID: <ZAqBL8sI69X3hytv@nvidia.com>
References: <20230306025804.13912-1-baolu.lu@linux.intel.com>
 <20230306025804.13912-2-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306025804.13912-2-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BY3PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:217::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: 947fb212-8914-4500-8c5b-08db2102dab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zHLBocJlP+StWcEL2bojHaJjlruukPviW68xyFVvD4et3W6YCUGeBQLp2fn4FIcAnRdNHq+3jSM4HEf40U+PFuKVf2VPtc5G+LfZ2uS2og8WV7z9huOxs2sM4o3c1KLe5uAetwrwNwbpXFc93zEtoL4bVGacHr3BVmPsEXTjWWq0YBc/zgyH9JkYf2LHzLxhMFge4baGvprHZbwDS2xBvhD0wgfm0y1gHEMwBKdM+gMGkHVLEXpLQ88/nhTYhQknBx1uNRSkxGVgHV+fk21LT1l6RYR+tHFFGoRvZUjMQMydkM6iAFRKG5dG4cYv4n4+jV1R4t8+NtNNXcnHZA8EBBZEAxelpfqRIl9Q7RQF59p6wSD+Jke4NWHZOKzviwY+ROHabPj4CB4TtQhvdlgBAhXcqoYo/27VyhWDOkVQNJQukVtIIc6O4fZiy0ATYtcesh1b+AliU9C8CKeQUopBPdAmKZ/Vl5YDljMsI9UosuWUwagV5njYXYtTo3/ouLKL9Z78Rf7WaA28lu0GwznqouziPP+F+L28qDlMrDXnz92Dsz9kODxRH9poJLFcQGZux1ojxBQdFgixaltICOfvv8AwS7bAchWcjTLKEgUv6pENsxrYKTx0EO95fU2fgK/dsPcn2BHbzv/qUlGmCJK98Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199018)(186003)(38100700002)(2906002)(26005)(2616005)(4744005)(6506007)(6512007)(5660300002)(6666004)(8936002)(41300700001)(66476007)(6486002)(66946007)(86362001)(66556008)(8676002)(4326008)(6916009)(478600001)(316002)(83380400001)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?teUdw7JC0eAyY8gAx89K5FY2/AOmp+fWFnWbUYaB3whrKFQCxLev6xGlkYMU?=
 =?us-ascii?Q?6TJsr0r5JazifmaQ9M6ploV4euWoGVlFGtsEbOwrceWkGCHO90psLKYWw09L?=
 =?us-ascii?Q?u2QNYaxDIq72tlbiC2RpK9CHSDZoedT0JaYmsNpgaAA8Z9rI3d2fHCh/Rg81?=
 =?us-ascii?Q?jA8IfsXPOyNC+wzz21NWD/dmn7IAHugx47zZPEQj6beAsGJG5MwCCh0MQ4mA?=
 =?us-ascii?Q?RfGHVgsWmkGs1kCIHxiBoQgL063fW0fvqJVD7dsvARMyi8U37NzxEFny1p+M?=
 =?us-ascii?Q?ceCFniWWPq37VZNFfZJ6/9IL7CRQ2XP52UcZqqANwUZaQtXAFeD99eJNoBTq?=
 =?us-ascii?Q?ecmUPiS946kyjn3q3gb1O/nAtnCZxxFnjrCmgVTCzmlfP9NBIcnXG25bpa/i?=
 =?us-ascii?Q?gZyoQomQa07V612oQcqHwbv+uaf/ubDqK7lYTZt230fSJgh50gs0Q3EHf1WC?=
 =?us-ascii?Q?BKnNptf/X6MNlX6AOMj3YFRrEZle5DYO9xM7aS196+5/g3AfMrcgHG8jl1j3?=
 =?us-ascii?Q?Uc6jNqLk3EL0C6DYUWu6bV6PePfJy4wsa4qysjWdUfOJ287plv3RqKBtDfSp?=
 =?us-ascii?Q?hyHF86HA+4L2GgZwkm1pHHPnmzMkG0Za5NkbvuTmQw3X2M+81a/5Cin9GFg/?=
 =?us-ascii?Q?7BHj2hysP0Ye6lWznWUT/NZ21fwjP28jPcmjfz5UY7b4GFsHQHR3lhyz/ZoJ?=
 =?us-ascii?Q?3GzqFrtalUISR8DB2bV7lFxHwXL1vsPUCCejos7cOq/WyS9u3IK/b1veiY+K?=
 =?us-ascii?Q?0S3tvkI3FmMkEF1O47gGkEyA2oOfJGwcPd7+mI8qAa693d2Us9kJfBL1yZm/?=
 =?us-ascii?Q?rqfJM3DE/Q9J+vkmnVx3F/f8H0X7QpZqINAyfNi1QouPBWgkQXj9T2yXvP+P?=
 =?us-ascii?Q?XwpQXT1/o3fAnVctnXDIfwVl+lwrGqRL4kIdW1Qtw3t3scrHa6rVKIX/zafV?=
 =?us-ascii?Q?bOxtSY2fT9O21DGTnKl7YBcqEBC/IWPhBQd+tuAllHfixwybqlbPtcJrgP+w?=
 =?us-ascii?Q?w/ulY/uZjONB7+qoB2FL1+v+47wOTCkYQyiMnEZJQmDrxRoqxracZF7ef3uE?=
 =?us-ascii?Q?eUSKkmWovJ7/kJyBJ2LYVSVHs7gPgquLnA3fMpOq1jTHqHcTjD3at8KQufdk?=
 =?us-ascii?Q?M/c3qJuSDV4o5cteptB0kNSKn20+CEUPpIJe+YZD+NkKshgfSP93Rj1PhNK+?=
 =?us-ascii?Q?QXyfP5hjo3SuuspCq4Jc/DDIhRW48WNuWrPIPOtbiMQ5emL2uRyARuqcSZ8p?=
 =?us-ascii?Q?fQ1CMUXQTPQUNSFbnk9QwY3TT/+hElgydxPU7x8HBl8oD51OvAoCe8yiDWxv?=
 =?us-ascii?Q?8ZAY0eN/lnYoJIo2SiMfTwoYHyOY196s0hW3iI36XCejePe7bSogHyyEYbW9?=
 =?us-ascii?Q?JL/5PkFjie/jJ39jwKVjWLDKi7PyXcIcYjvd3shTtp3Upy4LF0HSfJN7fyP+?=
 =?us-ascii?Q?fkZPI6OD+wsyxRwBCJZ5a2RlFi8BS7LYxMVDJodSr4NRHvgiGRHzgiNAE5z/?=
 =?us-ascii?Q?/y6m1XBPKfGtNMqdYy5c5g9PJ0k+FVRWm1MVllQcVKW6B+ZQlWuZL9ygmFq+?=
 =?us-ascii?Q?ctmeAN/SbzifHypQbVef6O9OyYsFwklzpT/dIsPD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947fb212-8914-4500-8c5b-08db2102dab4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 01:00:34.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZCR7F77RDkHIGQA0G71wFi4rXm9pg3On9f5eNeCTBYXZ11kt4VFVPKZPJ+f0jZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364

On Mon, Mar 06, 2023 at 10:57:59AM +0800, Lu Baolu wrote:
> It is like arm_iommu_detach_device() except it handles the special case
> of being called under an iommu driver's release operation. In this case
> the driver must have already detached the device from any attached
> domain before calling this function.
> 
> Replace arm_iommu_detach_device() with arm_iommu_release_device() in the
> release path of the ipmmu-vmsa driver.
> 
> The bonus is that it also removes a obstacle of arm_iommu_detach_device()
> re-entering the iommu core during release_device. With this removed, the
> iommu core code could be simplified a lot.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  arch/arm/include/asm/dma-iommu.h |  1 +
>  arch/arm/mm/dma-mapping.c        | 25 +++++++++++++++++++++++++
>  drivers/iommu/ipmmu-vmsa.c       | 15 +++++++++++++--
>  3 files changed, 39 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
