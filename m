Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D22C859
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734669378; cv=fail; b=jyzfFD9Rt0AZcqzzHvyO15e5uFGih+eylnBUnjRBgRwO8miP4N2E86fapkGZaQOWUU/7TVgidt1OoQKMooPbkA+dSMvKqYK3skczgjC5T4sqZWsUX4yqqSw2wJKaZmgbcTuMT2W8rl1E2YwlHMk02C0Bu69JucfawyILpChGlK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734669378; c=relaxed/simple;
	bh=QeJBpVQKwEzwKbz8/X7Kj9EHdiu/XhZothzayoHWUv8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/IFkvUHM/POhjuiUnidlxF57RgRkFz/CN89fFg91sFm/4qD+kI8FoBKRhu8jn+VMDtC+ABa1GJ2K942gx9hvjrSqAHecbAv6Enu+idxAD6M0dQ8r9Ju7TRl5bbsAyb+axgLXUFv7rZJe65aih1NPfS0d2p4nNQy6aQOA4qPOqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pbike4jE; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pbike4jE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwXMzR8QjHfDIeez+9iJhOH0FSOl9lozC13ars754yYYyRirti5Jz/r9dTMNn+tQlRqhGhVLZhBfSs1M9iMJblMjgM0Y9zPUCPUv5xddyB2SPcce4O0RUIXnbTWbfQ3JcGmY/6ivz5UHEPN5/cVHN2VZVyUR2o7JX4JttT9174AHw6Xy4O4ER2axuPiNARXQMTZQhr33gJ/xPjTwJ/eFEyG9I6QcPPcpavdmuaBj4HOFGjkCQiFyuVfG4Jf9O+Y+hy7iZ1zdroWisSZ7tF+kVgN2npng1lS4MHu+/3+e6yD7COAS9uEeOycj5AsPwxXQNbG69rL95zW7ALdtMKCQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noZTNcHaegJFhZgNBXg0UxEWGo8MQJnwHXsNC5Tqr3M=;
 b=GHWEPKMCdWBxcMwjbJpwnSsZCORJDOUS65CRz1WyNVvZKuj5fMFop3dsB4QAxCZ9ItKB8jhRDw9/mCtS4wjvwW/DfgLwNBGWSWOeKXoetY3ZO4OJ6UTvJdYap6jDLK9B5AcuItfDdUMW99gb8B7ELctXYqjNCkccZsPmhiyJhInqZTSH7P7t6hnDsQxWSILzp750gn0NLA2PC1BT4bzLTfmryA5z5l+bypbFOLoG2tYxrehLMdnz4vUETxkeUreqygiZ3HDMeb+LUWOuooEN7SZLH913EId51qWJ+uwWoJAJocKm2C6xWD4ywO5kLZtHbtd2D7h8ozYQUN9TkCm3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noZTNcHaegJFhZgNBXg0UxEWGo8MQJnwHXsNC5Tqr3M=;
 b=pbike4jEShKrcWmiEWLQM63AmoHeM/aySOJYANEYM0xwszKjOrY9SjABXQG7Ofy03WmGpPZ4VCf9U9s5OFhcJdojdpFvhFkD62TZOwI1f52X+VPDZ8/i5DOIf+NyH+SB925ml+Ei0+l8m7J5DCNXO2fuOqd0iSbgWHH3wMUwFU0GzgZX1MjPNPe9gdVR2uYuvqhzrc82s8hyUhEx6Et3lNihAGbfsxyulytSq3Gnvv+VDVIgDiXgt7aDT7u9jN4rCFlCIIuzwog8idqCE5cCbIs9ASWr40EY3M1GkYLk3QDfPJxhAeEyUoQIUkA+WkRRqhM4VBLFNqc/ZF7awweN0g==
Received: from BYAPR08CA0047.namprd08.prod.outlook.com (2603:10b6:a03:117::24)
 by SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 04:36:10 +0000
Received: from SJ1PEPF000023D2.namprd02.prod.outlook.com
 (2603:10b6:a03:117:cafe::b7) by BYAPR08CA0047.outlook.office365.com
 (2603:10b6:a03:117::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 04:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D2.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 04:36:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 20:35:58 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 20:35:58 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Thu, 19 Dec 2024 20:35:57 -0800
Date: Thu, 19 Dec 2024 20:35:55 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <eric.auger@redhat.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
Subject: Re: [PATCH v6 04/14] iommufd: Always pass iommu_attach_handle to
 iommu core
Message-ID: <Z2T0K5BXSCVgxwkA@Asurada-Nvidia>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-5-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241219132746.16193-5-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D2:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: d975d463-6837-40c1-96ee-08dd20afd3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXL2MPpkqBqvGX2fEStZeXCPeB/Dq2DY6BRr6q9dRoi3Ky8Cm9JuU6KVoiu+?=
 =?us-ascii?Q?F9mSsKbyy3oq2KgszCQYsBaiMrI92PwtAOJn6i8Oore3FN5Z8+5e90PIWVE8?=
 =?us-ascii?Q?gH1AIgWqYb9nTuIXxJWPQjm7q6eT9f8wsMmO2wf8w9uVuvF4mRTlwnX0LZeq?=
 =?us-ascii?Q?qJsi64ZvqPHVb5bmkwqhYqBz+NMSeJgvqDBUY+XgjIGdF+IcSidMpbG3aRf7?=
 =?us-ascii?Q?vlSvTUqsQog74zMLgu13PzxVO8Ms26yvDw1auKxL2K05/XP8yY2+/I7D6+i2?=
 =?us-ascii?Q?0C8GGymg6IwFFa1t0PzWijSCYahBzPJSH5oCHS4UBU2aDQ4xB6u8kFnvljbh?=
 =?us-ascii?Q?u2ETsiWCwHfrGRJAd/DjirZw506G+4GKVB5bdDVmEOa5vXXWFBOMU3J4iPwD?=
 =?us-ascii?Q?kgpEBEzx/RPGYZ8Kkd4qoSCJLpdoiYdi+UsqEgRExHt5CkHn9uoTAHX0vphg?=
 =?us-ascii?Q?oeLcpLAWBNs+eoX2QQGSzW342nsWCqnsCsc3R0Lps6Bx5MrhFuSL9CqQI6j7?=
 =?us-ascii?Q?CZ3Yu7xUCJJ31VzI/7yzalh+Sr9VfWGpaw84qu1HR3ZAoegKH16hYe7/mzlV?=
 =?us-ascii?Q?s6/xSuOmPxpoRnk2xfOILNBnYXQGUAt9pP2mQ2HfUtncRDJOX7Wv7/k4kGpM?=
 =?us-ascii?Q?4/C+gNdXDi97SA9cdOuFDtLao76blPzt/2oUHMUeCunaDw8GlnsKmk/WiWzi?=
 =?us-ascii?Q?zwrIV7RB6rbybhuXm5tXQhZ0B3LmnSjYLpvAnNcaxIMmSZWV/j8hqm6RRoVH?=
 =?us-ascii?Q?aOw7jyjcZ3/4ElCZRh7mYOC2WhT+3O9LUA9I+2LwtWSOCnggt7XwmsGyfoDb?=
 =?us-ascii?Q?Mkd9lEiPcYqfQKxQ/F/fFiLDAHKWid206dbY2Rz+SjdjehbLycqNXgZAvuT2?=
 =?us-ascii?Q?EZlTfrUFE4KRHj9wyYxSapDfZSOaCs73VnYmcDuffRXkhsjjq+6ECZ3uMr/F?=
 =?us-ascii?Q?gEgGRpHbhPN2Eb/JMCEP6PZmBhV9pp9pXsitWgKV4gaGCa4zKkvvca1Tg/lo?=
 =?us-ascii?Q?WAekYRJWJFKC5YCJYOIezNSJWjrHgbKnbLpiAnts/qCTLTIYIF78htZEeKj+?=
 =?us-ascii?Q?dGgKqXNN9m5NJ3oiT23UUlP3B3ert83qCs0dkcZ01Xa39vZ/4u5+kfH2nHZp?=
 =?us-ascii?Q?N1AMmyAfpl4CK5rAp7S9MIU4o2YN3fpOLpBxl+nMpbL61a9qWxZdx8U+sui8?=
 =?us-ascii?Q?7A0Zt7ZVMRE3JnM722HlzrActCZvnMWOmfVbK0udQShrw2yupZx0Ob9MkbPW?=
 =?us-ascii?Q?BGG6G20tRV3l7YdbUZOXjJhyxoKCX3GYRwE2wUwTGxHyXAfuQoWE4uL05xJy?=
 =?us-ascii?Q?G2DbuoirrRMUfVB0E7aALaoxNKMzx+L3rBG7Fz/YufVixW6aYDj+OBIFApMr?=
 =?us-ascii?Q?/OP7IG5w7bJb0+WXSMWDSBamzGZe1/dK721NX1pK4PJPWCCr01mYg4Egu3cd?=
 =?us-ascii?Q?StO9PknXLI7U971Xvv3Ss3Tpdt/OJj0+5AgONHErjSkt7ihO7l2Rbzi01XxT?=
 =?us-ascii?Q?SLHHJldFkCiw8oU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 04:36:10.2812
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d975d463-6837-40c1-96ee-08dd20afd3f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992

Hi Yi,

On Thu, Dec 19, 2024 at 05:27:36AM -0800, Yi Liu wrote:
> The iommu_attach_handle is optional in the RID attach/replace API and the
> PASID attach APIs. But it is a mandatory argument for the PASID replace API.
> Without it, the PASID replace path cannot get the old domain. Hence, the
> PASID path (attach/replace) requires the attach handle. As iommufd is the
> major user of the RID attach/replace with iommu_attach_handle, this also
> makes the iommufd always pass the attach handle for the RID path as well.
> This keeps the RID and PASID path much aligned.

> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index d5c83f10d83e..6cf9c1f10e85 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -493,28 +493,42 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
>  	if (hwpt->fault)
>  		return iommufd_fault_domain_attach_dev(hwpt, idev);
>  
> -	return iommu_attach_group(hwpt->domain, idev->igroup->group);
> +	return iommufd_dev_attach_handle(hwpt, idev);
>  }
>  
>  static inline void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
>  					      struct iommufd_device *idev)
>  {
> +	struct iommufd_attach_handle *handle;
> +
>  	if (hwpt->fault) {
>  		iommufd_fault_domain_detach_dev(hwpt, idev);
>  		return;
>  	}
>  
> -	iommu_detach_group(hwpt->domain, idev->igroup->group);
> +	handle = iommufd_device_get_attach_handle(idev);
> +	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
> +	kfree(handle);
>  }
>  
>  static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
>  					      struct iommufd_hw_pagetable *hwpt,
>  					      struct iommufd_hw_pagetable *old)
>  {
> +	struct iommufd_attach_handle *curr;
> +	int ret;
> +
>  	if (old->fault || hwpt->fault)
>  		return iommufd_fault_domain_replace_dev(idev, hwpt, old);
>  
> -	return iommu_group_replace_domain(idev->igroup->group, hwpt->domain);
> +	curr = iommufd_device_get_attach_handle(idev);
> +
> +	ret = iommufd_dev_replace_handle(idev, hwpt, old);
> +	if (ret)
> +		return ret;

These inline functions feel heavier after this rework..

I actually have the same patch for a different reason, yet haven't
sent yet:
https://github.com/nicolinc/iommufd/commits/wip/iommufd_msi_p1-v1
   iommu: Turn fault_data to iommufd private pointer
 =>iommufd: Make attach_handle generic

I think we can align with each other on these functions with one
common patch: my series requires the fault_data and attach_handle
are common to all HWPTs, v.s. exclusive to an hwpt->fault.

Thanks
Nicolin
