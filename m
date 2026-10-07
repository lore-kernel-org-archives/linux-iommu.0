Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013057.outbound.protection.outlook.com [40.93.196.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDC29E116
	for <iommu@lists.linux.dev>; Wed,  7 Oct 2026 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791343320; cv=fail; b=BpDiDwWB2WKu7Zs91uMgMisI3o6fRaPSGBGvdDo20lYV7x1Dqou0bBcspDyLALEOiO/NMtruaDSWmlK37pL4uUFQ67CD0Vi6M23oBPxOKA6i8EeeyvIQxTOVN2BSiLx3r8u3/voqxlGLTLqlfta8YQOjgEMb3SHUb4sPRhZcXiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791343320; c=relaxed/simple;
	bh=ugmG69s4TiOixWLBqoNznYp8xmZ+AYxGl1Awto3prwc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWEDNnNsDule4NQBtVbSFfg5wa3421VWQqziw9+/BhMyKT2i5i+umt4RP03tZ987UfjJbWqMBqlJmdgASeDGnx/Rg/Uu2/UZHY9YHRZokNhffC8Kw9CAoJwIe8BMYbZzAy0WN2aVHLAlBkBDMQoXFE+NoEzX/nURGUpMCU1Mugo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXPRydu+; arc=fail smtp.client-ip=40.93.196.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXPRydu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkE011y7pZ+mdp/2MgjMeiICnmNfvIAciPpmP/swzmeSiP9vw0yp/lLIMJkn5sodo4C2OHDbz0GadGvybLjmqIL802IGAxhV8SfJzDg6ExNuGNAkNnFdF7iWomINqADSrF9ogRiQzrLzvOFr2Kntbu0b55jNqkLhqqSs1WHMvNxebeJkhwOJ3LnddtoHIsxwRXKdBjVNeUqDqxwUy1B7EJpO6XNFVxFAGGNuUHkAOW84Zy43Z/m6vOXlakFFobEzpnu5CS/gjEbN5feZ0Zyt3fa+VMcw/T52rmhyL1o8EjBSMfwm9y2rYhkXBwmTz9f5urG1dMEJkOTjRxd6jn6cCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g59TwQb3PxeQeDQNGUf5CMg8aZP9bPVjtYUibPZIk14=;
 b=wbuWKiMGMmQ00f2805AYOpmEDOIgOz707k4xpNX4S+p3bpGsnW77Z4dpieeP0Ml96dESTXPC2Nnx5FE1qzjxFMNXFt+S150/AiK7ydXnxVnKRHnhr1xqHy+42zS0fOUiPT/SYTtGRviNeIslOeG0AAtuedabe75odSMY73jsAOZOWF/WNqS66vbDDcWcvZAu4a6eSde/anp6CNKeYupZW7z/Iyalr8oEZ4RY+91IeldllZWbgDJo1k9LzXSbSjr8oEysNefYwDPAbR+BLfbULAjFMx/lU1xBYBF0MRzmxjCiPYGT4N1c/Ji3XTx5svSKnTOv5oqLZ2IhL/tMDWt2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g59TwQb3PxeQeDQNGUf5CMg8aZP9bPVjtYUibPZIk14=;
 b=MXPRydu+IB++6Kd4LeHdj9syFELXGsvsepajAnFh1DL68A6jrlmnMDpiKt5geZfjgXU06xWeyaa5yuCiKCMYBupZpDObHzR39Gxkso1SO5wxkIuiXPDS1LlfaLqDmlU5J9FtXmlF6b8CCV7X2GxKfM/1HPGzgkLt9rTylUaJXxLe4tKre3tVWMkLXQ5hvkMpXTy3zRywJ1GB9wGHk6/t/5+8A+hURdPGWIj7oXod486fO85OOyhSzJoa309lvwM5BapfN3MC/Re3xop5JLU8I67c4R//vxjnTYTX0YjqJRIpdYt7eBcPQAAV50r9fdIrie+Qf3KaSeeQEakjGswxOA==
Received: from BN0PR04CA0055.namprd04.prod.outlook.com (2603:10b6:408:e8::30)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 7 Oct
 2026 03:21:52 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::6b) by BN0PR04CA0055.outlook.office365.com
 (2603:10b6:408:e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 03:21:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 03:21:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 20:21:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 20:21:21 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 6 Oct 2026 20:21:19 -0700
Date: Tue, 6 Oct 2026 20:21:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Pratyush Yadav
	<pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, "David
 Matlack" <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <asW6q0UPBX+Y/YL0@nvidia.com>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260921004834.2601285-7-skhawaja@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 42440dbd-035b-41fd-331c-08df2422217e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|23010399003|36860700016|1800799024|10067099003|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eQH5HTjcJR0aiqo50W3I4wQ8q88vzDt2jO11af0mjicBEcO3sxkLm0RsuNmBjkgJ/Chb39Oo0PqcGG5bzYbM5WhMRIB2JIIiQohfF6c27pFYO4UKMZade/lKu1IruTYZOIOKcimLeEiZMOM3KlMtmxoxGXCqwIp4h+sjxBiz+M8xNZHSu3D+Zp50OQghfZjAGHImpnydNQ7YJ2WPob4EqJz/LkVH3lc9zkvHnJStGbRKqgJb6pz9MS9+tco9Mj5H/kzUsR3FHb+n++gZJdwt0OXj3+pXsEjeb/BBPCaOQTpUTVJMJE6MfdPSqDrx4wLf/cViGBVScaB9/zXj3uGpjlUe2JNUzpSfKxNsg+ZDOFg5qYsM+LAhlAIKAPVez3+UJ6OVXEV13EjuIP8jCofcG4Kn0G+U1ogX3gX6/qwkK0XnSTO4VbjiJs3M48tbFNYEqhktkUSSPP9G6nFoagMnXbwAE6jfIRkZtbYKPg5wqWUBRMfx4rMmlGtyqrpjoxYOjCzETVLuXbcUIxpQ1s/6njCNJPUeNhPpYWpF7Lu544U3GLR2xPfj5bKKaoVPTk6Cb/b54bqYm3Tazb9XJqW01l2AOYTgJ1UB026t6xbd4NjuKzhrgk82+qMaBQWXyxJHiDqZyb8fQb+DVLhK0lwZDwIfnn92hnryy0bpg84AOqKTMA9MWzf6FHVhLDlecHDBUZ8j4YIMgXPmUEi5x4Lxgg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(23010399003)(36860700016)(1800799024)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JP2J4kPpdAT1uKn4+XWtnqM7qgY/Uv/RMaErd+eDlWIsC4dxUxaCY2AGI3KXd9r2Ij2EnAhRzhc+pmKQXNpzbXmZKr5Syik9ZJTa9WTPlSGQbm0y6EI0VtkRtQF4ufuaJB/2Jb0NzlJ7vHZe55B3Vo9tMevBAvq1S83AzWLFiYPBr+O/aoUX2Sisr8yuDgpnnnbXlX7qC+KU8t35VtS17gLLxcjDdlc0Scn3TzAnuQXVd4YPMPFUYKA/vufKf9nUemL2lL020QM1vrsnwPIEFA3R+Xn9/B4yDKfvJWP4wTT8Y0Yq5KPCqzY0+pa4I2UynYxOoezPDxuqPTmhcd88WA8cNCU/YSg0SY9Vv6hXFS/ZDL/xFfwb99F6SSbnMkpH8EcuClTHQ7RSmbiiQCS4d0rTEeqRZQrpGz5UrR5BCX4UUTu3p2tvgHECBg4i6aS8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 03:21:51.7250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42440dbd-035b-41fd-331c-08df2422217e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

On Mon, Sep 21, 2026 at 12:48:22AM +0000, Samiullah Khawaja wrote:
> @@ -827,6 +838,8 @@ struct iommu_domain_ops {
>   * @singleton_group: Used internally for drivers that have only one group
>   * @max_pasids: number of supported PASIDs
>   * @ready: set once iommu_device_register() has completed successfully
> + * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
> + * liveupdate.
>   */
>  struct iommu_device {
>  	struct list_head list;
> @@ -836,6 +849,10 @@ struct iommu_device {
>  	struct iommu_group *singleton_group;
>  	u32 max_pasids;
>  	bool ready;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_hw_ser *outgoing_preserved_state;
> +#endif

It'd be nicer to align the naming.

There are:
	struct iommu_hw_ser *outgoing_preserved_state;
	..
	struct iommu_device_ser *device_ser;
	..
	struct iommu_domain_ser *preserved_state

Maybe use "_ser" for all?

>  
>  /**
> @@ -890,6 +907,9 @@ struct dev_iommu {
>  	u32				pci_32bit_workaround:1;
>  	u32				require_direct:1;
>  	u32				shadow_on_flush:1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_device_ser		*device_ser;
> +#endif

Missing its kdoc update.


> @@ -1206,6 +1226,28 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>  
>  void dev_iommu_priv_set(struct device *dev, void *priv);
>  
> +/**
> + * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
> + * @dev: Attached device
> + * @iommu: IOMMU instance
> + * @arg: Private argument passed to iterator
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +typedef int (*iommu_dev_iter_fn)(struct device *dev,
> +				 struct iommu_device *iommu, void *arg);
> +
> +/**
> + * struct iommu_dev_iter - Iterator for devices attached to an IOMMU
> + */
> +struct iommu_dev_iter {
> +	struct iommu_device *iommu;
> +	iommu_dev_iter_fn fn;
> +	void *arg;
> +};
> +
> +int iommu_for_each_dev(struct iommu_dev_iter *iter);

It isn't very necessarily to expose iommu_dev_iter.

iommu_for_each_dev could be simpler:

int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn,
		       void *arg);

Also, arg seems unused?

Nicolin
