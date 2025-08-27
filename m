Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4602D0606
	for <iommu@lists.linux.dev>; Wed, 27 Aug 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309699; cv=fail; b=MT8lZIYg5XfPvfwcHj9sibAZ/FwSeHPYK582p8tKy4WkYlOJXeouzqrJb98uhkavAqxV7RRUiM4mda4wGsbAHbbyVhHtK29tnYxm46Qv2pMihaRdfGitx5Ukpwm620tR81/BVk6yj/+pFDf6TMeHMeEF2wiMFbs2y0jlXJoiCrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309699; c=relaxed/simple;
	bh=1AjXDw8T+aPk03l/FyqthVhjjXDvdsMNCGWOK1Dwc+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CrNUlmgLICkPd9dtyEnRb4frHF2c96i0F3/KMWxBPobTyAFMKV2o1plDtkBjbAQV6dhKeRX3f/9VdONZQyW1lWSAfCeEfk040xHBI7iXcogyvqBpyeBqGucMjMnz+e1YdbNoLdA3P7kDgoD55neI3K+luFUV5xACxw2E4A9zZBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eusybuf9; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eusybuf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0sQ7z/uItOuruNcqhplMtYfkwdEV1ORglHHTLvuTKsWD1luxWxmUCSu9KS035C7x4Nr/nUZkdBmpJVQdZn45fwRvRKzAIjEIe0YznnFExRA4TQH66B6oNcsmrX6KBqRa3r5PtQRhLg+MqXwklwlDpiX2IZ2gO6rgHdE2WR0/zWKpckFVGM2Ne5TCzrCYH9Duydsn3atxca03f9mC1XKR4kZKKDi3lkMf/gZTuSA765qtu9xwDIin7TeJr8twkZDoxw8dWTVDF6MdM4M2p5TZpoEgomzelWyGDa0+PMWSF7PPHELwaYTcr/9k4AwynbDzt4YxufDw7sDqkjb2rdwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uBBx67Ny/1cPxVytTAVANzJOBLPvwr38LhI3EwLOFM=;
 b=Nq+ZxZ7aYw0LMegII8rkkNCnv9AEC+erKag2KlJZ0QimKfPoFqN7bpWagHHXdiaQQFbSeYMMtU7c9znaIlhb4PYE4M5TQjZP7hwPx9zqNzsYvew2LyUdq+thpqoatFgMJF6qTFNJbP6lhzt6aNKS9VFOUeUG40m+i9brIuccJ2NFTdSzO3OinboeQtGdSxHrtSmDIHIpqeAVGRh6uiwa3VME2ltkJYlBUDRx81Skc5ZNfU9saV4iqMko8qEXvpfmdCN59n7Ragj1QLnK3pA+vhH5l+r25+HQDm181G4r3w+JwPoqVOhiu5Uod+C+Q+G437tIga+PvxBKiXW8NCC0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uBBx67Ny/1cPxVytTAVANzJOBLPvwr38LhI3EwLOFM=;
 b=Eusybuf9l3CK0kJHa6yJLztZFhffL+f5zDq4O1ykdbfM7yWHdLbpBg8zi3xQoDTH3TZyna5bQov4Fqgx90HPqpP0QQiXGgLPwueOvi79pg//DMuTmhcPRUPPbX21VjVEfATv2rtTD+rQt7LqGPGdZQHRBPG5SJahG+BLJyMhrR6+ncdZk6B8J0E58ZHpnKcmm0quI4LEPqZc4x2I3uLzor4Q8v3unYvafbdsNAWCClvai5H1n4k5Pb0lvYc2IuejoHS8QQJ7USsANUpbW47A1lI+CN2WqF+kMPdSHEwjD+Y5B/e4HXs/gKv9SkN6Xii3v14xpLJuOS3WHtjeDzBMAA==
Received: from SJ0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::16)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 15:48:13 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::24) by SJ0P220CA0025.outlook.office365.com
 (2603:10b6:a03:41b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Wed,
 27 Aug 2025 15:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 15:48:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 08:47:52 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 08:47:51 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 27 Aug 2025 08:47:50 -0700
Date: Wed, 27 Aug 2025 08:47:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH v2] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <aK8opOZJGg7PI9Vb@Asurada-Nvidia>
References: <20250827142250.5594-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827142250.5594-1-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 91a0bc60-93b6-41ad-3ec3-08dde581218f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzdzbldoNEFIUFcxWWU0eHNzeVU5M0VrZm42MzhJM2c0NW5qaDVjanNQeXR5?=
 =?utf-8?B?cVUreEJCaGlNMzVpWDlnQjBVUzM1VllncjJsS2tZMXFtc29UQnNwZlUzK1BD?=
 =?utf-8?B?OTkxbTRsbDBWVTFLNm1RTWc3Tm1nMlM1SW1ZbEdJZW1iNlZ0dWpETDlDTDNR?=
 =?utf-8?B?NUhnWUlNTjBDRjVSRFBmc0Z4UEUvYWtTcTNRV20zU014M3dsVTVaMk1oKyt0?=
 =?utf-8?B?VG9IdDBqL3RYUUgwQVlhTGZjZ3h3QStwbVJBOEN0d0d2NVdNRHFFRnZ0VC9z?=
 =?utf-8?B?WFpLZjNSb3hsMHI3ZHRxTG0yeHU2NG5mUGl2TStRSUFOUXAyTzE3ZTJ6aDV1?=
 =?utf-8?B?YlJYU0NaMmIzaHMxanhRMXFibW1tTExDbXozbHhkVERjUmtqcTU2bC9YRTZ6?=
 =?utf-8?B?UE1oV1ROdDc0ZWsyTXF3K0R1RkVPMEZJZmM0dUdSOXVrbUUyOFEyM0JBWUli?=
 =?utf-8?B?bFJhdUF4WndNYUFNMlVkOEZoUlNDaXhmdEdtcFZ1Rzk5cVArTEdtbVExZTda?=
 =?utf-8?B?SE1QOVpxOFVBeit1L3d5VDBvc016OXl6SDlDUGtLcklsVzBPVTNVcHhtM1p5?=
 =?utf-8?B?NkRHSGFaKzhGME9iZVUyZHJxamp4cnJlbGt0YkZkUGU3QXF2QVMveHFxcjJF?=
 =?utf-8?B?eVBOaWFPcjR1RWZLckNlL0hvMWh2UStQUG1PUHRuL1l2Qmt0czVzbjc0dWcr?=
 =?utf-8?B?cngxdGE5eklHTmllZjgvQ2hXc1JocVNIWm9URmdER2ZWUVY5Nlo0SjVRSXUy?=
 =?utf-8?B?bWR0cFhtZVJTMWpwQ1NyUTJrSnZRckRucGxnZmZCaHZXQ3dMNDdxRWRodURV?=
 =?utf-8?B?VXhJTWdWS1ZTK3A0ajM0em5scE40MmpmMy9RWnNzTnVxOU9tSEZCbStyaEJJ?=
 =?utf-8?B?dFpENGtEdTAralRudjdIOGRjRVhJVFNsaWNWVy9NYzloVTM0b0RRc3hOMHVt?=
 =?utf-8?B?L0RXOFZFMXh0Q0FrcWlqbGdUbzB2NHplMjJxVml1bi9QWDV0L0M2OG1Nd2lP?=
 =?utf-8?B?UVF6U2JSMzhVbnExeWltYkg5VEFvYnluVEV2aU9GOUxkbi9VZzM3enBhMko0?=
 =?utf-8?B?SzVKSjVHSkg4SW5yUlJqd3FBa1E4cklyK052S2ViNDYrVEVVS0p1Y3hhZVhz?=
 =?utf-8?B?WU1ibjZVbXQvdG1vblZQbi82TGNpR2IxQUpTcGJjUk5JbDIwWUpLSEx6QU5I?=
 =?utf-8?B?Rks0Q3VtR2dvd1ZveWtMQjdsQ2JsQ1prY0oySWY3V282c1RVK0JTd1RWQ3Ur?=
 =?utf-8?B?Sm45QzhYejZTVkpIZkE3azg3ekRYNExLaW1ZTzNueC9wYVE3L29ybXBuazBy?=
 =?utf-8?B?b1ZUc0dtTHpQdW1FY1NYYWlIbU92QlpXQ2pYdDhkWHhrNGtIUFl4UnFOcmha?=
 =?utf-8?B?WkxqK2s3RDgxWnhJd1BMeVZ0M2d3MndIWjJ3ckVScU9UcEhyazRTaWlpZ3BN?=
 =?utf-8?B?dmoyYjJlMExaRmd0M0Z3dURyMEFHTHZ4WjdDai90eTQwSHh0OUxpc203bW10?=
 =?utf-8?B?KzkvbmtQRmo4MFpaYzhNYXVVMU02cjNEeS8yeDZabkFjRmdmVEJUTzZXdFBk?=
 =?utf-8?B?ZFlRa0JZMmw0bUFvempNR0I5cW5EUlBuSkFUVXR2dWdwSnl5ajI3ZDlvYnhr?=
 =?utf-8?B?MmRuTmJYTUpZMXNFZ3piaG9xbXZ4QzFjL0RYZ2tLa3dHanRsRXBYV1hHcjI1?=
 =?utf-8?B?bE1VMlNwUUE2OGJJQjVKczRNb21RY1p0RVYrVGFCaDRHQSs5UTdWS1VjSTNu?=
 =?utf-8?B?b0tFTnIwUkQwMkdBVWhqUDFQdDdBQ1lac0NrSlcvZkVWT2JtNHpIOGovQ0s1?=
 =?utf-8?B?YzZQa1ZnMkJZU0VnaGYvdWpTUzlOM05YTGV1aDdyQ3RERVZNcjRnYzNvRW1S?=
 =?utf-8?B?L3NWRFNCQXdQRlVxMDlkNFcvYTdjU0RjSnJmNTNMWHlvcVhCV0FKZm5Hdk5Q?=
 =?utf-8?B?SzlYQ1d4K25tTWp3cnFKbWVVTWsyOUd4SUo5VmpqT3dGb09PUnJ3UWRtbERF?=
 =?utf-8?B?NjNBWDlTejZzdHM3QmNQcmRGWjQvVG9qNTUwNnIzQlovcDFTM1RaWTRIS3NV?=
 =?utf-8?B?T1ZFT1N6UURTTzIwR0JJaGtBNWNtS09ZQ1VRUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:48:13.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a0bc60-93b6-41ad-3ec3-08dde581218f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774

On Wed, Aug 27, 2025 at 02:22:50PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

With some nits:

> diff --git a/drivers/iommu/amd/iommufd.h b/drivers/iommu/amd/iommufd.h
> new file mode 100644
> index 000000000000..7c30dcc66a59
> --- /dev/null
> +++ b/drivers/iommu/amd/iommufd.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef AMD_IOMMUFD_H
> +#define AMD_IOMMUFD_H
> +
> +extern void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);

No need of "extern"?

> +/**
> + * struct iommu_hw_info_amd - AMD IOMMU device info
> + *
> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR) reported by hardware
> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2) reported by hardware
> + *
> + * Please See description of these registers in the following sections of
> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
> + * (https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf)

The link gives me:

404: Page Not Found
Sorry, we couldn’t find that page.

:-/

>  /**
>   * enum iommu_hw_info_type - IOMMU Hardware Info Types
>   * @IOMMU_HW_INFO_TYPE_NONE: Output by the drivers that do not report hardware
> @@ -629,6 +647,7 @@ enum iommu_hw_info_type {
>  	IOMMU_HW_INFO_TYPE_INTEL_VTD = 1,
>  	IOMMU_HW_INFO_TYPE_ARM_SMMUV3 = 2,
>  	IOMMU_HW_INFO_TYPE_TEGRA241_CMDQV = 3,
> +	IOMMU_HW_INFO_TYPE_AMD = 4,

Missing an update in the kdoc above.

Nicolin
