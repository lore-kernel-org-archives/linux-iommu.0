Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D21D9D70
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 13:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455015; cv=fail; b=mmSTjHLop81CxSua1pjlLONqrL9Ifa1/FmK7poZUddvMenkp/HNp3twIoPAIFXFqMlKHkzKNntYfAwzEWAjgIfa68GP06jJbMHs3M1KnC/ItzWKEE8jUdZ35zN70LKXW3WF4xnNOXKzpwkqrr8tB5yHSQ6Ahw6hLIZ/XWzg9vhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455015; c=relaxed/simple;
	bh=TdFEgs4Y/VRZCu2mLPwHD7Q7NYNh+Nr00M+gnq2ILNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNQnty+BqXdWq+wbwMfQOZJIvSvRpf6sYshEFvqDwrI9rAzdtmC1U4f3G0v7PMav88JDUQodpxv9F2n++/gVsw5rzuP/gmRUInrnHp7nvBLXxfEvwj/WumesIcJBb6APK9IKqd0Q7fwxnUcgTHWs7eddLk4lbKK8jw+MJ2FTXjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7EdWwtU; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7EdWwtU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0OcaqgTZxvQ1gzaET6Xs9SJxbNLoPhBgJcpCEScRsWyCympQRgLXYbHpI5piSMtZwag0WUY3L4YKr/hSgtfJ5Omw4Ec7H6Iwq/yS06yFAs3Mse9Dmf4daQCICejDbDkdDKoZ45fUrDpXT9lySkDRJC44chWjwio+Hbit1kPWqQsjAEzQAE6fiMrK9EuOTKxC1TZdKDDlWcso5TPCMEzbCYe+1+qOCx1LgPzDRNPV2ybVM29CAWg5OaVcp555RdF0bmnPGzEIRKOBNKNvzBYcQoA/V3GNv9Lyhq0oX0f4REceI9iH44E70MXFjwV8Eyxhln3qDx53WwlLg6iTb7QFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wJ6DxW2dZAGuYlD0kOET2GtM8T8yaYdBk9tSD1dT1nY=;
 b=mz6gPbnKBbj3B4N62aLvMiOWWPtQom0+kyMW0q6lPwN9s+d21KRvg4FWDt7emvHbH1V5WNmbdK2RS87YKZK/No73nCvbHS65QS/Bm0ZMpfjTEtgLxB5uxhk1EOcZxbOSxqovM2b4xbRJonDxBWzAO9LXBokGC+HD3TsgAxBuJxd1+W0eM9ETJSFcC79WAi/9qLbqIZzV5cHrtf8eGBOdOeKYZM0ha9I2rNy6/pCK6E9gSJQjTXWwjZqSzzQc5GgXha/lU2f/0I7uq6ITkViZZ/fURIp8nrxAwJ+sVWjKdJN3DMTBnIQReaSIb5pJY2FfniyvnTJGkM9eTaYArf5o9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJ6DxW2dZAGuYlD0kOET2GtM8T8yaYdBk9tSD1dT1nY=;
 b=k7EdWwtUL/UNHMwN0vHDs24rwIu5ZicfKHgPkorT/RNqzWRzq0B1hPg4UAUvjCMrmxE5H95pEr9EY2PA77VDbFqMTampVwQce+U0x8yGYvl2RW74HTWNL6efbno0Ksc5M6DghA35BnPqgO0fA1UYT6SWIOWevfzY3rp17vvodvLyPhum0AqPZHz+bTzHj4UuMa4jFzjpPk2NrQBq29fXAvqwtANXN5V6OwK86XdiE2uvs1xvZ0QeAOAhYkHj7UyrfgRULkKNpBBMln4s3QwjUdeOOGpsfpLeQTHPVm+PFhijne4+E+CrotakiVdJDmPyuldxpz6h0SZIbMT2wtnhBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by CH3PR12MB8536.namprd12.prod.outlook.com (2603:10b6:610:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 13:03:30 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 13:03:30 +0000
Date: Wed, 4 Sep 2024 10:03:29 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Vasant Hegde <vasant.hegde@amd.com>, linux-doc@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH] iommu/amd: Add parameter to limit V1 page-sizes to 4 KiB
Message-ID: <20240904130329.GC3915968@nvidia.com>
References: <20240904125946.4677-1-joro@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904125946.4677-1-joro@8bytes.org>
X-ClientProxiedBy: BN9P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::22) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|CH3PR12MB8536:EE_
X-MS-Office365-Filtering-Correlation-Id: ad28a319-777f-4ccd-4fd8-08dccce1f932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xp4iL/yCcjxqftPw4VVNahAfBlMds7ENrhDuiWCy0SQUVceK0MDSVVYkY4h6?=
 =?us-ascii?Q?oqaa1hvJTEVLqsQh0fljR1wg7SSFRQKG7qy/QG6TA9EsbMVbQPSmqpYGOjgF?=
 =?us-ascii?Q?BweSOLAMMXRd+1ig229XITsyWRqEMP374BxUHamYWhALN7dCPeMRhdm29fMS?=
 =?us-ascii?Q?+7LuGTv2SA2UaXQwFxXySqATwHVyS+zjq45NZ6w8rfKuy8uUIsb4gtqG9sea?=
 =?us-ascii?Q?TyitAku2ZFPlIafYSSSA74KTsiqrj8uuOZbRsLxp1O+dsPHQQeToJp/MEmNj?=
 =?us-ascii?Q?nY4EU3h2dCRzNyqXeNNIXAJAmJEQiaHCfreovJI8wiNFMuh4tog/Wh7/If7j?=
 =?us-ascii?Q?KYPGo1b3uR7+2WXgM+1vyBA8aLYtyGKjgP2WAzVMsq+bnE98qoKqFD3+Hcp/?=
 =?us-ascii?Q?74QrFMnStLTBUn16l/+WlI7tMU7PFoPtlPXDSds3OeTaO/xyg8cJvbLpi/RI?=
 =?us-ascii?Q?LuVElSM0fxWUXAY4/tM6Az2XCe6nxhecC148kTzFESXaa1+oFGOnBYYoR941?=
 =?us-ascii?Q?Fnxn2/S4nm4jprjknHCrvq3SZM1W79826S4BFaaNjzmDW4FOyRii6CBpUfEn?=
 =?us-ascii?Q?+QU1zgHgjdDXkl9hhzCfilv3jT14Yz3zUF/d+lhclp4gSEdrj6UZV3w8aQIb?=
 =?us-ascii?Q?N6BEvvUEwzylVAV5NOONaosd0SqvOIKaL4l7fPCjr+PRPKsajNps7f+BAvBa?=
 =?us-ascii?Q?oU84E7iM3eCKk2p8gnv6t5Y7L94tWEPEmnG85e6+Y/tfVtNU7FdWSYdRyKmc?=
 =?us-ascii?Q?hIGLTWPMIHH6EzeGSyvkSLu8TLR4BKn1iM3DPz1kiGnkGz0dJNeQWiW6pTPb?=
 =?us-ascii?Q?T3cBkyVOGPJ07F7/a7H6VuqN8IT1FY9jrt6jjmPZqo+pSOzy03fs3/Za4mx4?=
 =?us-ascii?Q?e5IrZv0V3HtffIEZNoRPzc84dzNSY7wNlnIJfNO4r+enYW8TVF5VHF58xZ0i?=
 =?us-ascii?Q?uXWH40BTKIpykDFlx8CfOEwX3DkQkzu72gQgKhinie354bj5yGHwaMsl6SD/?=
 =?us-ascii?Q?4haiPwOlxDPWmGdcHjWqgPn7a6KLXm1tPVm37lZwY8yGokgjjPse6S3tQHFv?=
 =?us-ascii?Q?k5Q7CYlt2ov1Jxg3aUXBwwjCgBefqG2nhusPYAHotvt/Uui9aYzSp8vDiW6s?=
 =?us-ascii?Q?jp+iy8DKKHnJzabpc0u/bWifSluyxaSBHvyEYIiqTToNj2yCV0ZjWXRNdqzu?=
 =?us-ascii?Q?y6YKst6lnt56OkX2GnUhAoyZ2asVSMFUHvTyL1rYbSLgS745n2qEwNMqkrk+?=
 =?us-ascii?Q?xuDNg84ZF9bZM4G1WtbUwZAr9wf5/lraRgr7LNi//PySbKrWQoNXJP52aqOn?=
 =?us-ascii?Q?WHOm8EKUCiyzO9QrmMHH6Kw1UDxUshmAH/V2FQ1VKm1syw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l1DeD0mSakeIq1lN9QirXA5DGvE/2Ur449kjboxOyHSJ5FxU1d3o5l86PrK1?=
 =?us-ascii?Q?ntG3ai9bJqMEalXrqAhhfDCeerPFXPfNt7wom+kgXx4NC8QHCc5S+3R1RSa/?=
 =?us-ascii?Q?nkLsX3LbqvnqpvG0SrZMlHT7NxZhHKGQGnQ7ipRfY1Ru1Y7o9PtnJpppkmTa?=
 =?us-ascii?Q?r9/BdyA2cwsrZwiJ3pO6gGIYJ6mkG3SnWYWmtoekudu++6XVOe5pi1SeHgUr?=
 =?us-ascii?Q?/vzEtOYoZaEkccseSpuCbECzeIHBrHwtuecnuPtV9a0Kk8APQBfjvsegFeK6?=
 =?us-ascii?Q?zv49r+2FdWUB1A/bEVqBZ92hJb7dExLWb447ttjIek6yE8h/Q6c2rx4U4Klv?=
 =?us-ascii?Q?zteoaqQqTdnIp+EXDzKMSB1V+vEAY3L40lA4fSbfRIzKGwGiGfmlQECyp0zC?=
 =?us-ascii?Q?NSGj37MzYLOLYuYR/WoKRQft3djg5FrcysAaxC+Db7HM4A4Czy01Nio7V0Aw?=
 =?us-ascii?Q?pU8K72t4LuV053SmHuuNmb62PUPw5GstfrQYK06I60tUf385WBqRnnYqkAJw?=
 =?us-ascii?Q?RmF+0WqUFYGnrHmXPY34fCTNsGCCkl56BAOfLZ55UgJkp80SOrexdOjcpLXc?=
 =?us-ascii?Q?CyLi8lWw9TB4rPHFYNMzhlGjt2nQ4Yi+f8N47+Sd8Tx5jn1oD2/zchXvyfmU?=
 =?us-ascii?Q?N1dsTwxXnLS0qMMS4jeK8lPmaRp5gwe/iGBIhATcSn0YhdqUcH87ukvmalNA?=
 =?us-ascii?Q?eCLVHAn6cmxsLeZEBnZG2GRC6bj12kWb5U85d36t8G2RXJ2RMuf2rjLtyHFU?=
 =?us-ascii?Q?XBP8uLjTDggGF+A8H8oJZNSlPoXiK5qZ13Lfds0UzyciYS6/sKFngq9Gakvf?=
 =?us-ascii?Q?HLodNiq0ZSgqFx8LaiWTdH/Xx23Bt3oD61FfJlHzIIu8aW3Vh8aG4S6ucMAW?=
 =?us-ascii?Q?TNo8BMB/JKtGxilHoHmLM0mGrgdJNBkAeGP+2oVs8XNd3HTmP6hHTglQghGF?=
 =?us-ascii?Q?MVGrqKuuCHpk3b4o5XU1J+sEzE4UKCtMb/aFM372UI7r4egIQX8SpHMzaCMr?=
 =?us-ascii?Q?kQCB29ntQ2poEFxXGsZ4cNkTWP9WX64UclqjH9XS/sbXCx3cHiPdVQT3OE9+?=
 =?us-ascii?Q?HRi+OC6JbIz9BMEKe6UpN8dwwdhsGdBw888o1El+YiyqcYZDnQ307qtGevSX?=
 =?us-ascii?Q?XZAFY3+2Urt2PuQqYfbxZMbr4Z01ExAUTJFaNK0YViRS2M9WAXXDv+1Z5AIl?=
 =?us-ascii?Q?VbZyLE0cC2ZY2WIjA25s8nwC8g3DWsCZZZbFzKEp3bp4j2C4nA5frGDF5eHj?=
 =?us-ascii?Q?vF+QJR8Hs3OlcuIkOnQ7fkJYHH8vkuc1z1R8C11FfteWPan+twS7PoLZhIjU?=
 =?us-ascii?Q?PYrEeTLGljKKM2cs6WCND4S/RWjxzas0WLU48OYuXrzpZdDiUwMecaXpT70H?=
 =?us-ascii?Q?jUe1NSynvfEQ7WGeyfCgVs1FElTJWTk466S5QRrsg17bAu6cEzd5LD2cAz6x?=
 =?us-ascii?Q?XiCXDAD6frH9x5GWt0Uwyo7veWrAC3HOj1FypNklpYyP+DO41Yb9KsTUL028?=
 =?us-ascii?Q?2+NduZsBdXVvxW+xsbJ2U7gH1wF5GinpYoBHXJxEBNqA8vb2jVmvDk5/5rjr?=
 =?us-ascii?Q?UPhZM/FPfhFea36giUvsUKu1RxphzNcuVa2TI5JG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28a319-777f-4ccd-4fd8-08dccce1f932
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 13:03:30.1395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zd5o9EJjvnvWN/pjAFK8DQy6Ac0ivGjrsvIYZt9ecD7i98jBHn5jL18mVq+MMapi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8536

On Wed, Sep 04, 2024 at 02:59:46PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add the 'pgsize_4k' as a valid value to the amd_iommu= command line
> parameter to limit the page-sizes used for V1 page-tables for 4 KiB.
> This is needed to make some devices working when attached to an AMD
> SEV-SNP virtual machine.

Details?

> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  drivers/iommu/amd/amd_iommu.h                   | 1 +
>  drivers/iommu/amd/amd_iommu_types.h             | 4 ++++
>  drivers/iommu/amd/init.c                        | 5 +++++
>  drivers/iommu/amd/io_pgtable.c                  | 2 +-
>  5 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 09126bb8cc9f..3187976ae052 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -339,6 +339,8 @@
>  			pgtbl_v1     - Use v1 page table for DMA-API (Default).
>  			pgtbl_v2     - Use v2 page table for DMA-API.
>  			irtcachedis  - Disable Interrupt Remapping Table (IRT) caching.
> +			pgsize_4k    - Limit the available page-sizes for v1 page-tables
> +				       to 4 KiB.

Why is this a kernel command line? Surely it should be negotiated
automaticaly with capability registers or ACPI like everone else does
if there is something functionally wrong with the vIOMMU??

If we are doing this we also have a problem on mlx5 devices where
there are too many page sizes in the v1 table and it blows up the ATS
caching. It would be nice to widen this option to limit the page sizes
to other combinations (4k/2M/1G or something).

Jason
