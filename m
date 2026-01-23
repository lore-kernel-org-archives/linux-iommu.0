Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E78C2DAFA4
	for <iommu@lists.linux.dev>; Fri, 23 Jan 2026 00:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769128664; cv=fail; b=MNhvvEJK8USZ1A1PTu9s6LxSF5nrnB0lhXR483rCMN/pwFxAP/wwUtFr7/k1PWnlo/9/Y5q9Xj4t9ZhvuD4I1hH7yEldEjuTsVxMnt46R4Ze+u1ELRFPEINisV25Ee9RECZ5Bqe15ys2c7O7HLWd4QKnT0xNwyq9IJEM7oCuIWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769128664; c=relaxed/simple;
	bh=ZLg0+JKe6aoXtAhZIM1xgENhdN+L6QXSWN53rWZhHF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9EktiMpBqjFZeoI57cWlV94s24ZSgl2GLYLgfqg/TlKLRdi1Ra8uv6MX28eYUYNmOWE57pAVFcB+yY2nN6SBUKcD0ycJs7VTLiM6bhfnMG1oLHKP3Fjdn6/WjmdtUcpE7nRZDk+75E+p6dYJN+zsCIqU9+/TRQNrlaLacfl9/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CDwMuHGv; arc=fail smtp.client-ip=40.93.198.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CDwMuHGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4N7h7W8GBxgnS38ML/0W+fyp/2qPCoCRLZjyAuHdPkjJfeZporKUvXTsRQvfyPFbfBQuE4uZ/G1gPmi3IdFNfzUmmLunHIjhr91jxloteYX084UTdOYSkiOrj4CxcbgfKR5vd4euzRdLl28XywgGWhV0ALRC+pDFiKmUSfh5HnQE+visXbay0JQej4U7ddOx7BcBVg3hQsHfxdu4+NI5hukuGdXtbsEyZfW5ng03Q+tNQEQiJm2lvyH025Ln7UMf0Cp80pxDFGn/YzMJroMgzu7Gp8cty8sJaLDbmGzwm7izsKVtXKduLYyxMhYrRRgBTsHTjMZRZLvBNS1ueqXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJr4DZErmdg6a2Ll52qwg2P6M/LqSV0j4wmv9C+CG7Y=;
 b=PgZwa/uK8Pewb0t+/Zf5Nch/pcs2zEzf8NuhJaz8rmknrw1qJZsosSyurMOvDWsuj6+DgwY4gst6JxMunG8rPXgDOI/L4S8Li5qLr5C3vdSJOm7x0xm4WFURvJAZb1CQckEtCcU2ZGSV5rWG9zOtDm/eknw3L1reou1W8rCEXBhw0TbNdkSjqJhQiA5Zg5Hw6jes2yGlPvLPeUdn1nMlWHYnH8+vrgJhhDXVLr9XS/NBjP+KTNhVKuRq+8TYD9BiUE93Tjds3cnOp57qKuhkZ52wtE8CHkX9gSTHjGEjRVzunWlI93lbEKsEKdVgSymp24TXapDMo+OIgnavstLfDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJr4DZErmdg6a2Ll52qwg2P6M/LqSV0j4wmv9C+CG7Y=;
 b=CDwMuHGvIvM/V5Fd75RzTj8tCx2eXsAPlHO5VSjtudh5DtM6XaVYFWqeJHtGqH8aFaWqnaszeqPVyZuTb3WXKbko4AWTWD81dnJy6GsWePVDjmLpTlr6bA3M2xY/yeZgtNTx09lGeCl0TOfMWS4N//5idwrQn5MKeBiMuleB7J9XRRubEmCabJB+upA1qVmW9OHyWK67LguIkEC0Di19yI4GwkbuAIgcm4EfIjyk3eQgF1w6o0wahWowM8TzX7FjOQ3cc2zFBzi+CUuTBg7eNNmFMQQXfsjLaFGbs7uDDY2EIhB/PI8QBLd7DeeIEswVLJHU5N0mF/Hl6TZ15lpoHQ==
Received: from SJ0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:a03:33b::20)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 00:37:34 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a5) by SJ0PR05CA0015.outlook.office365.com
 (2603:10b6:a03:33b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 00:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 00:37:34 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 16:37:17 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 16:37:17 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 16:37:16 -0800
Date: Thu, 22 Jan 2026 16:37:14 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Fix type of type parameter to
 amd_iommufd_hw_info()
Message-ID: <aXLCuqqg1tfBuJbb@Asurada-Nvidia>
References: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260122-amd-iommufd-fix-wifpts-v1-1-8ee604527875@kernel.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: e16aa130-4a49-4128-d6aa-08de5a1799d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4kKl1YKv8RUb1IXstQUcop6MHUPCBUeVfDf+ULi8VCN6ablQlv8bYkZ20HQz?=
 =?us-ascii?Q?qgT7Zl41b+CSacJQz0Z/2SeiRoeYzOBq7oOY4Cr7NvhFy+1wwGISQ9wGpR9y?=
 =?us-ascii?Q?xG7l26detXHiMzvkBQwXKWiERPo/LqOs95lCljnCIFSIr0bYA5cePS6zb4XQ?=
 =?us-ascii?Q?ZmL68VLNeDbxIRDBHvmIRWhL53yT1VCLqGDLkQXDTf3d2YeBL+Jc6eSZk8b8?=
 =?us-ascii?Q?iRjvxyMlIBTf3dhB6sghxAPPEqU10iMg42ef6HZGMoBwqbXneIliutb0q0FN?=
 =?us-ascii?Q?qR8BRZNpsIJxtRskZ9biJPPDpkvgHXNpCZxz46hXrrYozCetQ3BVARH8pKkM?=
 =?us-ascii?Q?ntMJ4E1F2jJntUEqe9sWc3ucf6auKfrnrDM+VwFQx//gpXjg6mVv5XY/cuTy?=
 =?us-ascii?Q?GnuRn8z6o+y2MqLSjXbA2qRG5lfyBkf5xATCcSHKvKSSzImvxfAfjhn6Qoyw?=
 =?us-ascii?Q?VUct92NiL7KMc93pktG1j4I5jvNwJW2njuc1pAjqZX3TmxRZQU6rRVGgR3y9?=
 =?us-ascii?Q?oRYX6eloRLq4Ho7zwGad9066dCgGxRuWw2hn4vLoWkE7T0tBnjeuo7++N+uW?=
 =?us-ascii?Q?/gVDvv60mr5PgR2tuxkWdZhHFHXXntPVcbuMSnYCmiDVniPxAUkAdVIwOc36?=
 =?us-ascii?Q?icUU8WjqqYz2KwNaUa/vE5h9WRGflrGStf3OFvulPSHFaJECxkal2hB/LcMr?=
 =?us-ascii?Q?2y3K7W/y+szfRbkcEsJLIkMK81iOAovKG1XGgVXEtECNnivQ+1rmrX3K1KJW?=
 =?us-ascii?Q?YE7GBj4t+0VDnums5lZEbhu4sMoVyjZbkJR3aU5BYkosPkDPHDZVhTET8fLN?=
 =?us-ascii?Q?0PJc81gcbiNKiwuTelqhXB5a6a5PRL48mKfGNH0a66+SXAnQAZ0peizuYwLm?=
 =?us-ascii?Q?lZV12YpGK9zl1K6Aq+CsbrXYRMo2etlJaKLjnE6lOxn/61oZL2Q63dKPeMB2?=
 =?us-ascii?Q?s9CfeiJkTdhT+BYfPRnNkhglUKS33Mj8Sp7SJN6rzbSom6p7iNYDLgNJVPpe?=
 =?us-ascii?Q?PMeSPBOcpt3/C4MoRpvusvgLDE7+aqy9Z9R/5ghQ4mcYTuRZPU2Bfxj8SuJa?=
 =?us-ascii?Q?Ey+xeqRLPG8m3oLKGKRrO2d3y/yBet4wbjkEGI74zl/Xgh2IlwWrSkilHyti?=
 =?us-ascii?Q?j7D1JGELHTYJQHQmD8faX/aSsR/wXpJ7qqLk365Tn4MdBs8iwZ8nQblQwPjY?=
 =?us-ascii?Q?Xj4AKslFg7ldbFkA/N5Fm9cAxUck1IT5BHGOyeVH206zVf15cMQKoajZgNoT?=
 =?us-ascii?Q?sKz+Dm7/Fs9PL3C8DgITbP76vr4MpnaGILeR/S7roiMhHp+0RM2pH0oMTy1u?=
 =?us-ascii?Q?uRH/TpbMee+mCMfbNjHUekm2czcRUv1btGck2UJ3XCCOgtU+3zOYrsBW0l9g?=
 =?us-ascii?Q?kAfLS9AgBpWlEywGLuMVfTg4VAYyKi+eWM01oet1Vmx8/saGFD513C//f3GF?=
 =?us-ascii?Q?HPOE5EetZtCJj9Wqr974agKj0pfyEeRLU9Hzv87XVwOu6Zn5BNhOWr1FzrJM?=
 =?us-ascii?Q?prpco21L1ZPwD5WCZuo+/jbNcUYJPwbO1ku4qsS8XzsZBNno39uUkjvn8IYs?=
 =?us-ascii?Q?49SbnYeL5B/xQW0nTSPwODz8B9hdcBTvOdV5Ci/72CZGNpOgyjF2OQeXgIMB?=
 =?us-ascii?Q?FrJuCptIyccPpMJqqQ74V9ZYL7JeRV6dasgfVWKT8oax8kIeNUdPIQR8Uz8u?=
 =?us-ascii?Q?v7zRGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 00:37:34.4170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16aa130-4a49-4128-d6aa-08de5a1799d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

On Thu, Jan 22, 2026 at 02:42:38PM -0700, Nathan Chancellor wrote:
> When building with -Wincompatible-function-pointer-types-strict, a
> warning designed to catch kernel control flow integrity (kCFI) issues at
> build time, there is an instance around amd_iommufd_hw_info():
> 
>   drivers/iommu/amd/iommu.c:3141:13: error: incompatible function pointer types initializing 'void *(*)(struct device *, u32 *, enum iommu_hw_info_type *)' (aka 'void *(*)(struct device *, unsigned int *, enum iommu_hw_info_type *)') with an expression of type 'void *(struct device *, u32 *, u32 *)' (aka 'void *(struct device *, unsigned int *, unsigned int *)') [-Werror,-Wincompatible-function-pointer-types-strict]
>    3141 |         .hw_info = amd_iommufd_hw_info,
>         |                    ^~~~~~~~~~~~~~~~~~~
> 
> While 'u32 *' and 'enum iommu_hw_info_type *' are ABI compatible, hence
> no regular warning from -Wincompatible-function-pointer-types, the
> mismatch will trigger a kCFI violation when amd_iommufd_hw_info() is
> called indirectly.
> 
> Update the type parameter of amd_iommufd_hw_info() to be
> 'enum iommu_hw_info_type *' to match the prototype in
> 'struct iommu_ops', clearing up the warning and kCFI violation.
> 
> Fixes: 7d8b06ecc45b ("iommu/amd: Add support for hw_info for iommu capability query")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
