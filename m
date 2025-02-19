Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BB20FA85
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739985379; cv=fail; b=JDOCijcgvG3i0QZ3EFQ946pwRjOZvawAc1CZfZJw3/9mGI8OGkg9ruq5PJ1efGrkZSshmFefBdBNsAGiCQ/eSRphrPLYrvXHq+Du/rkgh//pqdPvuS2P7ejRa4OTfl/sfKN3nVfSecPU+cDrdSLZtKeQN6XphOjdRkIROQ4EE+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739985379; c=relaxed/simple;
	bh=dxvN9FFLSS4ZiOTwBBCj0RviqiaHmP8CT2xLyTxWi20=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOf0kjoVF7Fci1evFd16MbhQ7g2XaglkIWOGIr+0vTMJHYYS3onB8Jbnr/b7MSluCZbn7XZS+N9klpluXaDtIAiIQVMe5cYrwxeRawWOl4gMNnzJLkTRzsfJ6m/elUicbT5PBNwUFUXIvLnjlIuu4Ay3IVsDfXaFO3sz6AvlVJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YMZc0sK0; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YMZc0sK0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRHSni2QXNitfvk/XZLaeu7ykSXZQbGJzrPUlQwFBHuHKWtwyux0ZCOXRnliFAmSN2/MVt3ZSX+fc3a5JjAlSEGY3cFfgAxCpm0ui8YU6feHWduicZytSUBiiI7ohlbIzR377e3M8gHINOEGZe1x6p/MZXIAyFudwj/KQZgiqMw6OJM47TZCN3hA7Y0LDwAiadOS5ymQDGYGzqxVxg9HYxzT73ivXN87hzmdv6TxupDxBYSezPmosWx1YMKRplBHj0yXtSLLqxNTwqghRLvYr9JUXRMgmuTMK4khXsslIF/ha1I95xUK0YWpdoMThUuBc2ll8sZOdgGPHoTraFRG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv/2IfbZgt99pqAJOxTUv/GOKvSwT6vFsO4z9IoC8oc=;
 b=GOJkC9OX2bz3FMXT+KrWhSsG96u0DLr/RhHAg4P7JdpNGTgIww2eofezCHUs2c7pYb6kHyinpWibeh163bLDMXyC4AYHenyM0PbmY0u28yfdsQlyrbR2MLTwpY8UADYhK63n+sCtAb3XRIb3fWZeAbWuel2Kp0sHw6OuGjgg5++d8i9PEOqCY8qNyFN+VttOR+0qrD+Hhck0+W5JiduhNh+bVCs+c5hFhcUHYU0bv8vu91cMDaO3WeeEi25PV6OwQESPMiZBjEBKf4FuRfCV/J1Exwon6VxF3tmh31Fw9Ok6wn6nj4RG5lSrfzZRf/kg8JXbgF4dhrPi4M4PLRjyhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv/2IfbZgt99pqAJOxTUv/GOKvSwT6vFsO4z9IoC8oc=;
 b=YMZc0sK06fc2NW1uorDpBvlRGA8hIBauMVm6JYm7W24RKf5EqToFk8oySFh76BaQG9nEdqcsA/CUXpV3vdRavZreip7Ykr4vrvHeGZ4mVoaAryIcsrns5df0Ux7tKhvtRWKGgxJlTh9kbqDpg9r5KTfrCLU9wL4haoLviDFWGRPXpJfS7zDeTrh7k1VatDJ3eYQwltGsY2ljqC7Ae/VqZJBjSyPNBv0Bcry0uo8i8AF/weHlRuziTpCO9kRP9hiIZ9B82kOqmYxiXGyX+BRQHr1gVt5aGaJe1faVznd6j9bXDqhCpKeTf2ea+vnJfeS7ay8/2P8AXmq8fFd5TOvdmw==
Received: from PH8PR20CA0001.namprd20.prod.outlook.com (2603:10b6:510:23c::15)
 by DS0PR12MB8528.namprd12.prod.outlook.com (2603:10b6:8:160::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 17:16:13 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:510:23c:cafe::d4) by PH8PR20CA0001.outlook.office365.com
 (2603:10b6:510:23c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 17:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 17:16:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 09:15:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 09:15:57 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 09:15:57 -0800
Date: Wed, 19 Feb 2025 09:15:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
Subject: Re: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Message-ID: <Z7YRy+mM54cg8CXV@Asurada-Nvidia>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-4-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-4-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DS0PR12MB8528:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d190b9-d56e-471b-10f9-08dd51091cd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vGVW+XRX5wveFfxVEUhWMIcslvCZgTUaGMpb/yWjqWgOITp0LWBhiGFwbq+R?=
 =?us-ascii?Q?thIP+syJ0jDfej7gcrpS8fiJG4IaiJEbEwAWiJPAA1Tja6xOxJ+JFb70553Y?=
 =?us-ascii?Q?R6MC4eXsWmzZGZa9wMWfNhK71e8/BFJ+PLdJ4WyqQEuz7I0gzNCgaFmhF/XX?=
 =?us-ascii?Q?NclKXdCdgrbcbdzDn0lrvh47lv3ApBsDb2eN3R8RQjAPy6Z6j415GBRlqT9n?=
 =?us-ascii?Q?0SnZAmj4l8wAYTC9G25Mizs/gKS4oh/8NnqrzhQnQdV8gmiqEklxlB2L6ht+?=
 =?us-ascii?Q?Ui21V+1lrMhB/Ofwe7v0krEM9qZCRoQcXJNv3n7M/7IStiiXOdBgkDjE5hcc?=
 =?us-ascii?Q?F3pGj0YDQFx4ha80Ae+9uOqmQppSaJJPYvrFn36DOAcTVij0P9AEyWWX6xT0?=
 =?us-ascii?Q?t3D1MS0Wd98LQ+cJUNRlwki6ZiByA4a/TNiCBkKDKItEGB06WuLdADqmoIGp?=
 =?us-ascii?Q?naP8xUR6jGQZG6rr2+WCNrnybNv65ZFOjENZm1FInaqLfGmVibHGn9Z7zXrM?=
 =?us-ascii?Q?K7x7OXXMd3V4BsAt8V/GA/Gzg6RJGeLMM2Dysf8WIRVi2S/3PfQGd1rgOW34?=
 =?us-ascii?Q?o8bWPFyezIWAfgEelxJnH5S74PpjXLT1t4XVd9V9tZnP4h0JKNBtILSXphKU?=
 =?us-ascii?Q?9bnEQ+1ek+YgiKY+NhjAft3/u6KlLCR9Ep6T5n42fVelnUF95EGw+fCI185Y?=
 =?us-ascii?Q?EqnxBevZQy8j6g8BYY/wn2rtteVTnEaDrv4BGoHQm9Y5h8WvHlOZ9vuX7hM+?=
 =?us-ascii?Q?YSkoY0Ww7njHu/PiOKtZ+iri+Cs3E7Of/zy12pBNSsMEWkk7Zc7Xk4FsYKEk?=
 =?us-ascii?Q?tGpyfPd14/h50w35Xdq8f+xC5T1UN7wktdXzR6jSE3SSQoMLpxdxDuunfVcq?=
 =?us-ascii?Q?btfGBHLVetS91s3uGeokVIiReATYFLDGNda02t+hv2/2hJbQ1ljOn8VZC0W/?=
 =?us-ascii?Q?W44jnRV5NCJkPb1gX5mnEHHG4Df+MSItLXqHVcYVzheAKX+KgbZarPoaW0l2?=
 =?us-ascii?Q?X7U/GoebTNMOBrc9QGkDtgNHaxQob7P3WVG0l1qVwI2aAQWE9euZDwEJV38h?=
 =?us-ascii?Q?aoiVY08L3ov0d8VQ5Yhlq4+LxPmBiMzHlirDv1bv7l2xsJ+Mi7KjzqdcGZEn?=
 =?us-ascii?Q?MayDu+7VadGSagMhwRZPI+yyw+icPEPFCvtjoW3I1ULxIYgAPD1wGIlf4+E1?=
 =?us-ascii?Q?Gq5PNH1N74V88vKtEbID9CqEAR1JNMjTR9o5ykmsDwKnVhBzzWP4mrYCMTcf?=
 =?us-ascii?Q?E18s/LDushlwTcb+afOGlqrYqrAsrCYWbJEFUOcP/FQMd5HoFWxdqwMxCnOC?=
 =?us-ascii?Q?K+nkKDM2qJ17ugszrPu7ggzGo6vZ/w2Yxg0jE9oy7iojlDfchfqR4g4gGqHf?=
 =?us-ascii?Q?9xCJ1hnYJ1WacOKLNF/Ay0qbxwboevAZg6pVeLG6j9E+tq9KGs4XXbHC2eIS?=
 =?us-ascii?Q?zMWaV4jSi/iMimE5ko5ti/eslaQaIBi8cHesIvECyRemBtw1DcUNfwoKr/Ty?=
 =?us-ascii?Q?aziQKRfmdtdBbQc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 17:16:13.5246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d190b9-d56e-471b-10f9-08dd51091cd1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8528

On Tue, Feb 11, 2025 at 10:05:38PM -0800, Yi Liu wrote:
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not previously.
> 
> To be complete, let the iommu_attach_device_pasid() store the domain
> to group->pasid_array if no valid handle. The other users of the
> group->pasid_array should be updated to be consistent. e.g. the
> iommu_attach_group_handle() and iommu_replace_group_handle().
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

A nit:

> @@ -3483,15 +3501,17 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
>  			      struct iommu_group *group,
>  			      struct iommu_attach_handle *handle)
>  {
> +	void *pasid_entry;
>  	int ret;
>  
>  	if (!handle)
>  		return -EINVAL;
>  
> -	handle->domain = domain;
> +	pasid_entry = iommu_make_pasid_entry(domain, handle);
>  
>  	mutex_lock(&group->mutex);
> -	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +	ret = xa_insert(&group->pasid_array,
> +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
[..]
> @@ -3561,7 +3581,8 @@ int iommu_replace_group_handle(struct iommu_group *group,
>  	if (ret)
>  		goto err_release;
>  
> -	curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
> +	curr = xa_store(&group->pasid_array,
> +			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);

It's actually an entry for the group->pasid_array.

So, perhaps:
 - s/iommu_make_pasid_entry/iommu_make_pasid_array_entry/
 - s/pasid_entry/entry/

This feels a bit clearer and can avoid the two line breaks above.

Thanks
Nic
