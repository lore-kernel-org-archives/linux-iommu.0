Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8E8155398
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731011128; cv=fail; b=QJdVhnrrM/Caqg1KSsm3GxBKW9h5FA2m9RnjLDcn8GK8u82Do2fMtuJUTDqSSOvXfW6Nrj1mTPdsLkwRHB1PBao/EC5wfaCBEuXi2GW8NRKZmUMeq2X1sdEgZAC9VJsiHGRDQSB4fLeM4Piv/VxnUAUHBgUa1gq2iMaeJ/IIQa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731011128; c=relaxed/simple;
	bh=hPxD3BIBy4OMJ6nvzvNaxqtjsWncuytrqMw6JQejqds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EHmixbimV/F9Fd3szQDz1P06vn4Xqzd+lEaBpDreFrVeWbBkL9JNJ1tkRLnyfJDvwCtLYxWo1KeGOXeDHa8ZnLvv/z9fv06L8Bum1k1ihn8EEoizsheiwjK0clsuukeyHoCaEWz7Q2QS6ZwZYZOgzwZoxOniUokcF9teTFVQycE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R+g1iKzs; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R+g1iKzs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKSkeNK9ceB2x8K6vcuWCAd9lSlQUJRT5I2TfOPUo8PVVtpeUDt2xWe3CRSJ/ZESUmg72iLwPLhTqrKAiCoXLLP9GsTFJ86Tm+HRT7C4U4WAzzA8ZrTuQYbP7gkMxcCDB7XlckJYAgLbBIc4soD8IX364lx9iQn4SCX8acypgZkIVraDKDDAOJW7uDbJiJFLgfFRDpPBhsqkxRFJVSCKB4jpfuLrSa/r2jJF0/Xym0XK6QLIY/g6P5hJf5R1cZV3J7kLMy/NWxiV4TdHK1MoAPoJW1Y6gPox7hkqywHRmaTgiLA5KpVrHNE7sU3/f52IFXxAdOn8oNawYjIdWhxkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YigEqUPdDTgnflaBqfm6aSWrUz+/dCGHZjT6Xm++kz4=;
 b=YPh9LaapAiG0cVJW8pKA5bN2F99dEWgVg1w4HS0NLusidZpfEzGt3rmA3P+P7dP81ldvgpWJRErDLkIfFULVpIXzm3riAUgok1ckdw+3Y6BZrstg9C5ZoVGkYWQqT6gewRE1kFXdpMX3aOqeeUK1aouVAVA0yIXrnVOcSoCOOiqgW7yla1dqxoiODJZB+DexTIoM3V2Rel8VndWsTtQHB9HMd123sUcgRuXdhY0zC1Bvherh6v0UDDRKOYO1WHXicOoS8JJMndxOQCDs963ZhEaEkGdm4Ad4e4F6YTe3/ihXYIVoJ1Dwlygxxl1P83Zz+9iPZ6HzVfpWylJ4MycoFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YigEqUPdDTgnflaBqfm6aSWrUz+/dCGHZjT6Xm++kz4=;
 b=R+g1iKzstglsWNBOSxh7sPXAykGqNu7TWpqCg1YobDQUD16AQDMpdBK0Icf8GOSYfmZtITMd248aaisn0N2nPDxfYUk/NZVjgBCo4GtuM9zdfs9TKCN4Li/M/E4s/1WOvsad7YkERHCwl/9oEYGmmVRNQ036eJNYD2hk83fmR95djtch8R9BDtAAnHa6/f/Mx7jV6p3Ai6odyLShWAkF/DYbx5/g1Thcm9sWYovW1ib869YjvQbPiZExZK5cTo0qgBxyBDKqOI2XUxOmrdkulIVdslHy8aaruO+5T83EfnqOYEbF0/DRXM5lCIY+3FukJO9qfvVfeca1vs6AG/sGfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 20:25:24 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 20:25:24 +0000
Date: Thu, 7 Nov 2024 16:25:22 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH V3 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Message-ID: <20241107202522.GF539304@nvidia.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
 <1728321203-189608-4-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728321203-189608-4-git-send-email-steven.sistare@oracle.com>
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bcf09e-58b2-48c3-e8e4-08dcff6a4f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7LYcOiG22WxmrBpUlCmTScTN6FS8pAYTwtMA2cTsZ5DKDypYfRxZUDfFLk2a?=
 =?us-ascii?Q?UYR0DWdkNFoeclNPf6YjnQgodzjs3pcquuyRxKleIbIj3qF+rfY7lueF267Z?=
 =?us-ascii?Q?JTfdqUXwXiVkODgAGrZsUJqUHDFKJH5tHsr9wZ9Ig7wwtYjHInn1oqKzCZQm?=
 =?us-ascii?Q?OGBqY0+G58qmddFBUi1eqz34ygZbkkLfYXDS64lFmqOw8z5o54vBQ9dW+Kmg?=
 =?us-ascii?Q?NvJYU7xAo4TDquREMOw/1hb8Ji+XsqW6qVt1r+poy1VOtamPYDhRHfRJfLEW?=
 =?us-ascii?Q?OOKnkmX24t1CsneOSm750GjBv7KzgEdQhDjFYuz17W+bEhayAiArA5+9VjiL?=
 =?us-ascii?Q?Xz8st7gr3P6uG0HcgC5IgE1QNGZrCYLhst0J5qJCqgMmnzzwDkbwI8dg2/G5?=
 =?us-ascii?Q?lK1cSqCrC8Xujx4HUAg5p1VkLi1iY6HFoSvEkqef+geIOUl8pqgijuNTlsS/?=
 =?us-ascii?Q?Z6YvsyLxCqs3FxY4sc7iSM5s9elcavtuVYNOFLyT4y8yd+p7bvWqnnTSqiJK?=
 =?us-ascii?Q?QhFOgl7XEwWjBED3KeI0rGk4UPyUQl9aJgsulLqOqauuCCld0jzJ0CleHt36?=
 =?us-ascii?Q?jrH+TN7n2Ls04GqclFoRNkiPwjMOpdfCoGGrZXqUqMR0EwKcXd6e915iLRr2?=
 =?us-ascii?Q?h1kwx8OlAcesb+9eBNAScqUk0C+GEo8bf7jZY4tF64gLhH53RPg7rHT7tHeF?=
 =?us-ascii?Q?7fu0LXvxPK9iYkwtfiRA4cFF+VV8xcWmvt5vYVZPEDcaBoT3N/7Tn56HZHxB?=
 =?us-ascii?Q?iuxRD/dBeCqNs3aSXSbyKH4iE7etRWoUATdEi7C/r4arCXf050FKOHJXQSgZ?=
 =?us-ascii?Q?JMmnEg0KGdLjT2nAVIwez3d6KOfc0A+p1F0DyU++cctR5Lw120jzcqJCxLa5?=
 =?us-ascii?Q?ZVrJu4arLSBZFIQ4klVCNyu/e0BYVPEqizcTI3WdLeg3od6IfSOresWJET/S?=
 =?us-ascii?Q?3ZfE0KWSxrOV9h+tA+T6SZYYkI4+GjAmgyaxCGQSavAJb7S6ucfoc/6JpRZi?=
 =?us-ascii?Q?BXKdF3ZEuyBOCkou2hWy4ZnnL8whm344AuhYwVbr+k2j3RNU3iC47l6CL/k3?=
 =?us-ascii?Q?UbD/D6xEiR+CsJTbgrBDrDADg4HNyxxDBroK/OBZ7Ajz6DHIOkjkmBnr63EO?=
 =?us-ascii?Q?I7q5MtLVnHhpfoetDiOeNDfh9VH03dZA69Vqoft24j/DZr3qNxjdygIZsnzO?=
 =?us-ascii?Q?hm0QPZl0BA4d1bZw2A9pg/VQ8TgBm9BJraz4S+bRg1pbT6HSXFXdGxCj9ukP?=
 =?us-ascii?Q?nOncsmnUJr0gGyrZpC4LnZ1X0TxG4Mvg66dLapB+b9sr4AsZPf02a/LRfZJe?=
 =?us-ascii?Q?yGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdxyIHzCdU8WoLtyW0bHhOo4fCkNa0nFhVwsuutGqcOOaSnd/e5jYP6FDfw8?=
 =?us-ascii?Q?oMeFBE36s9k7jb8TZRvd6lGKnvf5csOQqBsz1n76N+a/vdhh6aXMMruY49wn?=
 =?us-ascii?Q?fzq1muYpQLlUQ2yEkig3FW1oKBB/+WsoQ2eXBrxppYdxOLQVQUJV4wCkldfx?=
 =?us-ascii?Q?pz/xdVNVPpW1t8San7VMi26RpKBtwmTZJVdc2u+XAYaFirkKGzYXjhMPV1sL?=
 =?us-ascii?Q?HauRorScbjahkIvXoKzb7ZQQWiyA86vVmVoHWuJJ9z5eNnMUCBloNzqZ+NTx?=
 =?us-ascii?Q?ztL4tsX0yLo2Urub1xFdmreYG8yAHlLw4H4shsPHucBt3bLU3IHaKKhrYf1r?=
 =?us-ascii?Q?sJeK9kajnyaNsm4siuQ0Tvi1XYDgx3dmayIazXrEAvnVKAhlcYqrLnEm0nFV?=
 =?us-ascii?Q?6+vZYgrZKrFb95tyYbht3qmoMz3z8yCc1PmMCsOrbrWneUCFHmNvOVdCW/eY?=
 =?us-ascii?Q?PkcQSYjPtwoFmTA2cWHT6E0zkx1ffvnU5xyj9Rp6CC1VyU792oPeh9wDbe9u?=
 =?us-ascii?Q?QhPrdQJ0vn4N9Oyr//7stFI3m4v7gFvphi2s1mR3d+37V9KUaaMLoGgxPQO6?=
 =?us-ascii?Q?m9xAM0nY6nf1c4Ns0K7dcM+0emxyVm7dm8Ins/RyDrpDR5+7Ee9d5NvSpzin?=
 =?us-ascii?Q?OgyGx85os57TCGYux5delJkK42mx+WcU5vpnbvL41HHpFhBN3BNVGL/7WZ04?=
 =?us-ascii?Q?3NDIrKJbe4ThDBisCNjPMQCRJWE1VIS/qU+0MagHrZcO1cfCup3cbhD1Cg5q?=
 =?us-ascii?Q?x01PXCNVBw9pE0eRCDZqbIBAJ/J4zOMWiBUVGJjqnJyw8FSSNyGGYnAT+Wfg?=
 =?us-ascii?Q?I6ZfWFx10H5cRIJAI/4l0X7b5OQ4RP1bQjBXltXsBkaIPhQHJQErJ+TPgFAc?=
 =?us-ascii?Q?OiO++sol+aMHey+A2ABh8NNwy0zih7Kpd/LpzAr1/+HxFK/v+pSQnlOXBkYC?=
 =?us-ascii?Q?XLtcuPZwn6SVOrrBnyEnoqcDj5EAjbjDng92KXbG82wqS9j/Way5pUYCbpo8?=
 =?us-ascii?Q?9YkHcGqVD5cKYtsxGZOt8WxzD5S1GnmrAbbGPWuZQ/U0U/U6Y08Fcjvl9lga?=
 =?us-ascii?Q?zNGAlVz6dDb2Vkkzt+Mbtgu4q7aqRq0YQF+3C9pYiJ+DIbSYiRIdhzSup3Rc?=
 =?us-ascii?Q?f7wIJ2g6uFjXEAuDwLxGmxTd+plr2r2VLUaccPTgRb2lQdFHcRRksuyddclv?=
 =?us-ascii?Q?KwzIDfYZbANSHVvVhdbyQ3bGgYSSyTdAtoZLXEHaGzINCoAZEGmMt3LC9T9s?=
 =?us-ascii?Q?TUtxGKkkI+WJGlAUjDNnV61w8qBo+Dp3RaD29on0P2SXH0vFYnQPKlHxiETt?=
 =?us-ascii?Q?F7Aqj8aGTdUd9AQ/dEBPDqp70DozVcg9VtDOlOc6pPPtDAJSUxAO+mLEUcwi?=
 =?us-ascii?Q?4zFGMmtUIq5MJZOw9lezeH4frfm4D1EboXmEBx4n613lQnFCYqTGsstxNflu?=
 =?us-ascii?Q?xpVMpHAYrHWR5rU+XTxkBXYysm+x5UgvQiLnETwwyKK2capIYB0YfRCIDats?=
 =?us-ascii?Q?lB+UpxbXegByNxBcr4u9WULLY2EOlIBoZBEeOpNH3K8bDm7EhH2vfJXKqsTJ?=
 =?us-ascii?Q?A8pcnGvAAyWCy4/E+2QoUSyHmCn0UAI+tJ/Tb7Gr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bcf09e-58b2-48c3-e8e4-08dcff6a4f31
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 20:25:24.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BvpFjBezC14yvLD9+iCFW6x2lXwQstjBo8CAUU+WqOtHhPEtXtEpV8ZP4v4mny9L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

On Mon, Oct 07, 2024 at 10:13:22AM -0700, Steve Sistare wrote:
> Add an ioctl that updates all DMA mappings to reflect the current process,
> Change the mm and transfer locked memory accounting from old to current mm.
> This will be used for live update, allowing an old process to hand the
> iommufd device descriptor to a new process.  The new process calls the
> ioctl.
> 
> IOMMU_IOAS_CHANGE_PROCESS only supports DMA mappings created with
> IOMMU_IOAS_MAP_FILE, because the kernel metadata for such mappings does
> not depend on the userland VA of the pages (which is different in the new
> process).
> IOMMU_IOAS_CHANGE_PROCESS fails if other types of mappings are present.
> 
> This is a revised version of code originally provided by Jason.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  drivers/iommu/iommufd/io_pagetable.h    |   1 +
>  drivers/iommu/iommufd/ioas.c            | 142 ++++++++++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |   1 +
>  drivers/iommu/iommufd/main.c            |   2 +
>  include/uapi/linux/iommufd.h            |  23 ++++++
>  5 files changed, 169 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
