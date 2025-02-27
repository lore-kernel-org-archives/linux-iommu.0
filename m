Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803AEC133
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 00:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740614743; cv=fail; b=StYyq8Fi6j8LZv+/IsHclJzOqtKPtL89bfsOmz0BCobN3ywmPxC8TFJJrGH+V605OJHBMU/mZ2slLQLOxhEyg4/ATtgz1YjNVsnXVQH+izQewoElGI0g4C22x4MhdqDdH86LpcyNyn0vhw/DxiJCJaue3IBNMmuUWHuKIaB8SP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740614743; c=relaxed/simple;
	bh=IcIByW10C7liohwSVPdnteqFRC6dGeSPxXSUbUqA8wc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjF4v5X9zoCULpbufNHokNK41PBTU8BDX0uROB2QoprqTS+YxEWlvoIbca61hyOGzTQ2Grr7Xt+waMRNrM5bVd9BHVxAqXL7Pa8m9HumPZrmaX5NQ+hVvD8RBdjLo/90zfhcQSc4cxVJDFmV4xZ5hQOmS3hcLKVEInu7Bb5Drdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fJEd41f6; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fJEd41f6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hc0kag+TmWaG0DSAYC9hLNkYM5e4iV+ZyODUSRZBXLR/oVUg1UyVZLEbucQjP3W29r6nKCvOurJzJSNgANE7J9Dwe/zOhRMvbUI3m4c7qfe3ARIk0P692uwpUYWQFKXteAoQ0HSOfgVkqZnQte0FtjCV2rjwySBa1UcjEVZl2z4Yab6ccwFRcSxf/zT+JVdP0R6Vyra6plMC7nkmVkAZz04IJnV4fxrdcqOogBtzovbbEj6VW00zE/ncmR+J+IRmchcOu3h9RMloLSkVYD8KeBmwXodhkGBTiiAKhMmKqKgVPPqQVvAMfYsfBWjn8TaTPFbYhGmmzm6nMTJMQqaOqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dD3NxPVhu/B1stwV6bnyLIfBEwl4yyFGaVoPhPRLkQ=;
 b=JDhSC9D+bYQ9t/MBad852NKhs5T2Q1o6O+1qYFECJL5z+1J/QLmP+suqG7HAUUO4a7E+k8o0grjOEIy0aZbMmByDXkTsuCL64n9zj4Mrb6poIglk4YcCctPbW5ke6kUgblCExEEV7yQcKHLc1mK0LkMt3NVJLHSSDsrFyhhhdx+TFQ0hLTzuOHLWnY/CetP3kqKKFPqLhdzE4V7ZPfAFApVkJxe0WvTb0ljgdsCc+FkjHwwyvktdrK0ShEvDb5VDMOu4k12Ulk74RoKpHNb1EQnaCcjn3DTG4KU0EGSirw69BpQUEdc+ZHicdt2FAgaTtp9XX+O6pOxaatJEN2IqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dD3NxPVhu/B1stwV6bnyLIfBEwl4yyFGaVoPhPRLkQ=;
 b=fJEd41f6300gmN3HeoPYayrzIO9aeUyXqCBlUJfTgbUBp8MwQf3Krfqg5L7rOReB/CYO3WZ1n5WVb/V6hkmVXOsfUlpurqGWbHmsJc7QEPNWvl23C1LcRtaEBzUX2kjG+7DxnEEh64HHLKdacO2PjN69ZtlA3utO6jSx1a4yea/KEAGsDk+ftepVG48wEcQORTzTpIyDeBlwEcxGKqH4pZt4vYvvK9kJe0Y4R+uYqM/ScgMra7YEuWjBCbX20ZFeZ/D5+u8K8k/Ff9Lr6gqLcdD0M8vTGgU9eOt/QhAMk342b1coml4IGLGrwax0Vg82iewVYIIg7a9YMDlw9oWOcQ==
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 00:05:36 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::23) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.19 via Frontend Transport; Thu,
 27 Feb 2025 00:05:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 00:05:35 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 16:05:22 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 16:05:22 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 16:05:21 -0800
Date: Wed, 26 Feb 2025 16:05:20 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
Message-ID: <Z7+sQOLeSk5hEcr4@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-5-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f36898a-2d25-48c5-2032-08dd56c275ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tTLf2LbQGkf/lr2QZNgJTK9SBPCF2b2tq5VrJc36ZV++Qb56koR4mqRIhpNn?=
 =?us-ascii?Q?JlfhfrJJF38FGTYDlCa5dqUhdOKYrWfCrWIbVg4HMb92pmMcy6Gtawf837MN?=
 =?us-ascii?Q?w2lrSpXEtCtdENymiiuTMmY43HZ9BWEphCI7VrsZY4LVEckeJwEBFIY6AG5N?=
 =?us-ascii?Q?SNMxyNB4e2xs6Q5aIZ/a7J/rS8kZ0u5We19AAOo5BlFGcUNTwataWSLvbGfq?=
 =?us-ascii?Q?8aMHtBTeUlze/A/LO4BdyLDuZFDY3RAIzjvkYDWbXiVRBpNNUVD0uAqLbwzz?=
 =?us-ascii?Q?kfJcpk3tXI8pV8Ss0bsHnCzY1Hx7PrGCGJoi3XC/EUNGX9sRzveF5c7bCbZJ?=
 =?us-ascii?Q?eQd9g7dM1zinKK1UGqAgnqCq8cEtxefWq5aQWTeITPArRMCEDIYcTtAw41Ms?=
 =?us-ascii?Q?Meq3+kMC3lBzxjTuZpm3mR562v02Kqvya2xFjA/WkzgpUNCLOfgkBGmxAUmK?=
 =?us-ascii?Q?fWaCVveU33hO2nW465/roRhzLgPNCEzAGYgJG8ORmJYUU+jOoX4OjE4BKCSW?=
 =?us-ascii?Q?QKAUj4JZsTtdH8S0N3i7IYzT7axWOjADZnjYDgI/RXYTTjDIQ06qDBKF3AJt?=
 =?us-ascii?Q?hVLDWMupfIoz0D6y+UEh3WpA+ylh3Wrnj+OXZEFnv12s6x/1uMdfCt8wOuMd?=
 =?us-ascii?Q?xx0zOqYvsMjLsjMFvm1KyjZw41U/NiMejyLKn9Ey3WhluPvtjhx/heJ2ymhh?=
 =?us-ascii?Q?+UliKD3ZXtMwE7aZ0ro0VMBF6xiTUTGceVK7sEX5KlE+X1ozbgNqnPFJlCVM?=
 =?us-ascii?Q?flQjL30OMUusLCcspwV5kmrXbBer+CdPa1ALc4q7vm78pmEV6QmvincfEM3j?=
 =?us-ascii?Q?6dikjRq9YvPw5eVoV60wy8+1Tpcx31imu2NRNY/oHfdms7gomlJnJXzamuFy?=
 =?us-ascii?Q?mOArN1oe/qf5Ji/7Brm9C9ZSxdQ3g6+ZMkQBIKJaFRFwvQzMKScUACSRVI7c?=
 =?us-ascii?Q?Pz6KmYo0DiTXGmoGwdCvmzz+XxEKcFZvQPseRybJRHeLXEKZi3lAu+5bWFN/?=
 =?us-ascii?Q?LuXnh4ZjZLEXRu6btQM74gueFwZ1XvUeQ5ruLsuSA5I4cwcqKLAs4u742P/f?=
 =?us-ascii?Q?rGmt+W/rIpXmspeE/Hb/XzjtgpzMFxYmbXO2Fy/ebxvU5VP8U79C5pSiFfOt?=
 =?us-ascii?Q?NJAuJBUDCjphzttP/nPsy+UW8A7JLsgG6z/HD9tkD8ZtkseIjmlLbE5POK5P?=
 =?us-ascii?Q?jc0j4OuZ8jexxykO7+hMZHW7lSvjIs4Qgd7K87yjsJfuzIDOCykzCxlIlesG?=
 =?us-ascii?Q?agt73Qp2JI6MTdJOJRHacRc2U7bbF0APwciydiMQxlhfZ3EPrE2mYD6LuVs7?=
 =?us-ascii?Q?JUlJJnKQga+4T/5V34i/OXh3+UuL43OreX4J82fuS5TCsDyQoEVg6LjqYZNb?=
 =?us-ascii?Q?xZ0tJFJv3RPwcLyo/SF5iejlWPDsh1J/WSNYuEHUXSS6vpPGaaVOp/BeHQn8?=
 =?us-ascii?Q?OFnCo/Nj+BNa3n5Mz23x5AlwjGBangx03fZUop5j26NmydlWB3fC+aCwUDyl?=
 =?us-ascii?Q?KsTyRc8UMhjkIgs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 00:05:35.7281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f36898a-2d25-48c5-2032-08dd56c275ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047

On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:
> As the pasid is passed through the attach/replace/detach helpers, it is
> necessary to ensure only the non-pasid path adds reserved_iova.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 6ec7f6935115..72f6195e32f2 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -471,6 +471,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>  				ioasid_t pasid)
>  {
>  	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
> +	bool add_reserved = !!(hwpt_paging && pasid == IOMMU_NO_PASID);

"hwpt_paging && pasid == IOMMU_NO_PASID" is already good?

"attach_resv" sounds better to me.

> @@ -620,7 +622,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>  		goto err_unresv;
>  
>  	old_hwpt_paging = find_hwpt_paging(old_hwpt);
> -	if (old_hwpt_paging &&
> +	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
>  	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
>  		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);

I am a bit unclear about the use case with pasid and replace. If
we replace the old_hwpt_paging with pasid != IOMMU_NO_PASID, what
would happen those reserved iova on the old_hwpt_paging?

Or does that mean a device can multi-attach to one hwpt_paging via
different pasids so that only down the IOMMU_NO_PASID path would
it remove the reserved iova?

Thanks
Nicolin
