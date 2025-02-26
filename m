Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4552702A9
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 23:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611504; cv=fail; b=hEZzIY5QxbMmhjtAHivVBDH+yvHEIVva5OCatnUaGglPK8NjidOCGrx4oMsYqJ9rUygdf+HPpZbA6USIBoLCm+qXUq04iGMzR1JUb8fDkTn+MVaph6sNf2fXLKxJDXrypWpD3v/5bvJCAN+5zY1GSTs8vKdrKDQfIWghm5ehGXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611504; c=relaxed/simple;
	bh=cmS96nKwJ18WWZk7Olgl/wEXtrt1PL1LEDFhiCWbqR8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhyvM7Ar/I3IIb7r2GT2vw69Z4ojw3mRWzjeiEhywn6hoBB3AsTFX6+ghjTDLhKq0p59tWZXYyQLCEh/6ePB6yWITqMaSSbZQYWLStRpa9bTHY0KqQLwwuFevXDqAhuyqWHoRymRfbDMZQnS/t81/p3hSNoZZwoIX9qUpUeTHRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EefySHLv; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EefySHLv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWxlGkCqrjnJB7mG+FKOhxRjwnKoSFAiNzO3QDnghR/lMKWEDkRak1mwfsmrLEx4pUfp+6JyDXdF8WKYZxHP48KSCfHOZ3JMignf82oL/+EU4xwjwYay9B6D0Mcv2NcBXKjmzKwko5oa1lsudhgskegtMTq93dD+bralGlpdA96FZ+Kt4kbA/sW1AmJCIeLsgZrMjeKe9Z7g5Ib7kQt1UK163oHpUxBzNbB1P3j+ClGTTr8du+D9X1c84ohoo047bryJSv7LeR4PeXsj99ylI9ioJKx9SXc5mZlseBQJB74cbmOIeQ88/p55cab52k59FZWHaZ0JnaG3pJMH1HyB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz6H3Y+c+n59PUJ03FQkpQlweWObzM18YekV6ZLOTkA=;
 b=DGWZoRMVU4JoYVKerX2ANydHxFCr4D9PLM11cokjJLITrfCkJ5RWX3oArc/gOhjHt/16y0JHzQnxId9gNsqkh37i4mxRmSuOygkAKhcunKK7uN3Spf5ZgFv+3QvvmvOXnqNFOoNC6DrQafhC1mn6gO2vrYIH5K/NJnv04YVXfFN+fFAfWdyJv2elvq2XT2hrc4XpgPTs91+KwsoKbJfSRMega9MByuhI+sTene4OXk2gKqibRSxlTYoJjjrqxL57eNxS3Z8iTRjt+EeoajMQIhWawTsfpytUPUUHvKhYKiPdrrmUnDAU9bGXCMew1EBJtRWpV6mee8KgUhnGB0kF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz6H3Y+c+n59PUJ03FQkpQlweWObzM18YekV6ZLOTkA=;
 b=EefySHLvvC6g5G215T7wjE04ucxDLL2GJ+ZpijIcLmJ1pKzzMjMOJKEvOY4/vcYgeFUezskq/tcGHXKzOMTIfx/Fnq+laOgUmw44HHZVwMguUnWsrjGUWM7VcvQPDP0i2TzGq+4iHqR1j0tgQJSo6v0pxsxo8cFzpDy9Atn2z4tqGy1ZvB2B4EPQ1mfVx1en7dFPrW2T5OMRWfZHhFpIEq1Kl0s3xf+UubJlD4No9yHnlr37J//8Hm6eX7rQzGHH5S6pbFJQ/1P5q+cRPQaiHMPfDShCiVVEotIHUZf4VXGlZTlEnxCmMGcj7i0Zo7sNNoQm6mm6GTqANtXyyWeg2A==
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.20; Wed, 26 Feb 2025 23:11:37 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::d6) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.19 via Frontend Transport; Wed,
 26 Feb 2025 23:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 23:11:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 15:11:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 15:11:22 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 15:11:22 -0800
Date: Wed, 26 Feb 2025 15:11:21 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
Message-ID: <Z7+fmawdDhATfOX0@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-3-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: c0498919-9829-4f79-5971-08dd56baeb4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JuoLEsP5RTPTk0n9fmFpXkVyxEPCjHLGwAtha0h+Oo5pJEBj3qftP3lI2wQ0?=
 =?us-ascii?Q?T4M3hJ5DPYwpaicxDfWCtDjanJPeAqdOsYH7+5VV80C2v6topll6dOFsr3p/?=
 =?us-ascii?Q?5GNMfr97Kz5fGOLJDnCsgSHc/ss8jvsxn3Ao2/pdz1GZNpkEQdQcXmuuzqdw?=
 =?us-ascii?Q?+Qa6zY7WmeWePe1eBPtd3iUreykjNSaBhmaCgZUXadTarvr5hmpMFn7NnqcH?=
 =?us-ascii?Q?2LR84o/JyTamsPXZc+ScceEB1QJAl0V6U6c2FnWbs0tdqgRremO8nT2exFxw?=
 =?us-ascii?Q?FyAb263V1XBSEw6+dD++gxHjS7eBG1aq69hpHD6NISvi2g2z0Se7puRCLJbZ?=
 =?us-ascii?Q?HcxMdRsSleZmBncOt9lSr0P73FeXaZCCZqHIEdHOT8+BNrSipviBugmRyCLC?=
 =?us-ascii?Q?xgB36O3EVh6HB9zTYDj/7aygKJOj8wbf3fSMmFaRBnM/0pB0PpaZSfqieey6?=
 =?us-ascii?Q?T+2EOd71GRwBftCgUaktuOYUj4G0K1qHHURjpJJ8MCZsUjIV5Tu/Kl8n5dqE?=
 =?us-ascii?Q?AJ61YqXbup/EfNMQZoCyf7hKcXiQWHUegwttbnTWeDE1exptZTQsgGjQjrJr?=
 =?us-ascii?Q?JcUY98qvFBobyoqIIU0c8nRl+hHKfU3/Wd1DfaLZQpeOIqc+AIxsHv3k6slN?=
 =?us-ascii?Q?qzb7kpAsQYIkeCM2XiweCuA58JAtyWf4s8AWt9SpSVamz47Q6Qmfpmyg0xF8?=
 =?us-ascii?Q?Vt5l88b25+y/col8a7g9FWLcY8lJu+GffeWDi1j2Eo05NZ3aFjKmTsX0Q2MY?=
 =?us-ascii?Q?6E7Pb9ZEvZNFpyRB52oKwg9i7511rW+3ixWjAJ0rzxOKhH/vcEUYjaa9LGPY?=
 =?us-ascii?Q?Y58qMGj5+DnCXDS3gj2Cc5p5MYP95DOTp/iH0GbmLCNutmKBbjsBBsSm6Ont?=
 =?us-ascii?Q?uzeT8y27AZSZ/I5dUqzt5cuXQCjgleCvIeegiUMGV3IY8S2uzpj3dvTaA8Hq?=
 =?us-ascii?Q?Qv5DNzd+Y5dI0BXjZmYrxMwadqGK3kmp++Q03Xv7owC5HBSAMnJ0tEIqW9VX?=
 =?us-ascii?Q?tBnRv5XySvT8y1zlPOBt0JiOh5UuVrVtyalTbmIiWr6zz4M7w19BcUWE4dIS?=
 =?us-ascii?Q?RaN/wK0Th4BV0jFw6XUFwQ9szGWImhCP+YOg8uPidfeb2VWbSWcC82leOi0N?=
 =?us-ascii?Q?/HuEakuDFi1nc8rbnwjf09oGVCsQuJJFyJaYEULhKQIHQJKqwQ7O7Y5c88D3?=
 =?us-ascii?Q?okPiT/xwV8bZyE/IiSiZGSYU/AsA0sneDww+d08ysWPz7pWoIUYpABHqaCk7?=
 =?us-ascii?Q?fMG1ElXqYTqhwM8Kp8tn1GlOxhksUwyNFkUtZ8pEVRqwF2oGH5QWSv0XMYPx?=
 =?us-ascii?Q?XDWAqYxLQbwEB1S4ut1/H9qHWdGWVlXq/U0r1M+TRpx/xW/WWZoPSQISicCF?=
 =?us-ascii?Q?cBwx+cHMIQDw7c61GUT/wFSXcngm2QYpruSmXmEk6V7n9u/Z2+/NolmB1Pke?=
 =?us-ascii?Q?bRK6EDG9Gsc9jZvWmYwwk+2D8sUyTLo7MrwcvVUi1dELc5tbnKOwtjZx93hs?=
 =?us-ascii?Q?X/EE/q1IBA0D5OQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 23:11:36.6758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0498919-9829-4f79-5971-08dd56baeb4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

On Wed, Feb 26, 2025 at 03:40:22AM -0800, Yi Liu wrote:
> Provide a high-level API to allow replacements of one domain with
> another for specific pasid of a device. This is similar to
> iommu_group_replace_domain_handle() and it is expected to be used
> only by IOMMUFD.
  
> +static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
> +{
> +	struct iommu_domain *domain;
> +
> +	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_HANDLE) {
> +		struct iommu_attach_handle *handle;
> +
> +		handle = xa_untag_pointer(entry);
> +		domain = handle->domain;
> +	} else {
> +		domain = xa_untag_pointer(entry);
> +	}
> +
> +	return domain;
> +}
> +

Might be a bit compact with

static inline struct iommu_domain *pasid_array_entry_to_domain(void *entry)
{
	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
		return xa_untag_pointer(entry);
	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
}

> +/**
> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
> + *                                     is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. The @pasid should have been
> + * attached. Otherwise, this fails.
> + * The pasid will keep the old configuration if replacement failed.
> + * Return 0 on success, or an error.
> + */
> +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid,
> +				      struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_attach_handle *entry;
> +	struct iommu_domain *curr_domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	entry = iommu_make_pasid_array_entry(domain, handle);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			  XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(curr)) {
> +		ret = xa_err(curr);
> +		goto out_unlock;
> +	}
> +
> +	/* Not a replace case */
> +	if (!curr) {

Mind elaborating this?

> +		xa_release(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	curr_domain = pasid_array_entry_to_domain(curr);
> +	ret = 0;

Can we set the ret = 0 at the top?

Thanks
Nicolin
