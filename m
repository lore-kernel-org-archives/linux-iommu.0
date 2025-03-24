Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1A1EE7C4
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 22:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855885; cv=fail; b=YzKZ+XyR6GexVyFPrk6oYBj3eZY6SCQTC1H6/Mvio8ge1PGnXOXiCc0C4v7F2q7+5dSoTfXvT7fLF+b5z24dof9cb79rNcZ6njdmL2m1fHStixjSvU6r21n+Ce8MmVQ9M9a0b3raP9D01YJgRBjFUGMzivxfOWxsOmRLQz5D+jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855885; c=relaxed/simple;
	bh=ixoxxIQTf58ToORWzdeiMswxwkYw6YliUldt0zbGGKc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSmXNqzYVgBfg7+OWl3gmqqYQaETwR0chVHE7ekzV+BERgHZg1u72Kd62C85N4JLn8N+ApmUr4Bph65YJF0n5RIS/5fIzMKVquVkKobRC7b5X7pv+2iyUnWbO3aU/yLjViEgcvAPhQAcw+N98OMHO+mQGvhWu/4gZKyTe9Ruf7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hI1IXzfP; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hI1IXzfP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs/Riqx7EMV8LU6ZIRD9Fea7WEJloX4ib9izLZNg4DLyilYwR79VFda3L6m6JCNIR4uXjGLX69KSykTS6Kd/JcEvqQROvLoO4/gHX437+gDHWs6muNlmHdMDgQMsZ8EyqUmCowA0dYw3O9qtdqhVOJO0JBRip3cbSp6/C5bw423Tbpc/ywztKO3Mn03legoFWNb0Ztjv7ADRBOkkphDsR5A0OvjIjWICTmrIw3YcGU7QSdsmDt86ChgNpZ+ocoE6hbR3VsXuHQ+Ev8h3Mt2cZNlm4VZe8Tq4Futi+/97CPavMuXCIejLIuFa9PNqJz4ozxRPxZFCRLBMauRXL8zUiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR4aYkqmybzQo8xcJQ5GzhLIuPkp23J5mewZMfnIgcQ=;
 b=EIzkmvchMHnf+U9h3j5pLUp2MOGAJc2Dt/m/15qgDAPH8WtSTKUDrEpyeL4xdPaOEOocJzi4zm3I3g0psOOExyjsMbD9iclNl6sFSZLSgk6ZwPmaPGboXrkhyY4iwfPLvlWgHcxJcCq/dEem/pcO36IxKOYKhStnclSsAGpcXAm0P4/7Evfq7V9yAW4vB9QrBjVmOwxr44v5ukC/5oBjx4ElQIIUnWYziCtt95Qs1sPX7HY7qiqbzuQEYKfWx6OY5towlavH2eCgJVbLZ4LBIhbaLJP4D0iUo1h6As+0bk/QHFCAACQXxyAgA2oLcHR3b5dh3md8CxB7v/36JpikaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR4aYkqmybzQo8xcJQ5GzhLIuPkp23J5mewZMfnIgcQ=;
 b=hI1IXzfPF2zaFmGBAeYzHRvVnwa649O+tuD1Eaxvuwq1k4+8N5ABOkjiKdSuBRH8lhnGrRJKUmDOWICzf/RbiEmH7IN4C4PDDxQYiiIH5Y+qKaFtRweraduHELs3FU1PDuCSMKC2CkrTMCjbmQER1S3bC0OwhkG8abOP3gA9mXVwAkAouDIk/6vLfJy8mHV140O4xMYiMhHHikwlPKXBVY+3HxPYCxvVI7ik6DyLfBk9vkBbQGSAO0LeaLArrXhLQS2CORgI4jNVg8c8lTBrrmvNUAHeZ1baKsrMyCM4iPIBW+HVBjjWrdkDneKnk8d+2/P12ZCdMF8AcSC3JElfsA==
Received: from CH2PR19CA0005.namprd19.prod.outlook.com (2603:10b6:610:4d::15)
 by SA5PPFE91247D15.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 22:37:57 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::f8) by CH2PR19CA0005.outlook.office365.com
 (2603:10b6:610:4d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 22:37:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 22:37:57 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 15:37:47 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 15:37:46 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 15:37:37 -0700
Date: Mon, 24 Mar 2025 15:37:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Arnd Bergmann <arnd@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iommufd_driver: make IOMMUFD_DRIVER_CORE a 'bool'
 symbol
Message-ID: <Z+HeqSkEZek2JpT1@nvidia.com>
References: <20250324210329.2809869-1-arnd@kernel.org>
 <20250324210329.2809869-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324210329.2809869-2-arnd@kernel.org>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA5PPFE91247D15:EE_
X-MS-Office365-Filtering-Correlation-Id: 90702d1d-485c-400b-88b4-08dd6b248676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K1Ots43qC4XdF3qmmSmngo8yIvegPsrgZa9Be6hFX31UZQZn5gFKOiA1ApkH?=
 =?us-ascii?Q?8ym8hEfZk1Ov0aRmIf9X+YP0zvebvctMPydGKSEaAgn/hC8D7dAjcaaYxFn0?=
 =?us-ascii?Q?HORjjXs4ou7tDDIllVBStHDpbhryDa6VF2LCJLwMWaLgMTcR0ImIc7mUUD6y?=
 =?us-ascii?Q?+nwAqidsiLwhZEg0u0BtcF9GKD1hZu4KIhT+0CaztqNuTR8gNWiJ7drHJVfd?=
 =?us-ascii?Q?ii+mRRDNwRuZH+h8aYbHoSnZaoaY+oi2FdtlN+lBQf1Uj49EVHUJQ7og+uCe?=
 =?us-ascii?Q?X8KpFbvW93ep1A+Wnminzn5QSX12Y7Fft8gsbAr87dR63aAEeqcqiZFglyFc?=
 =?us-ascii?Q?3LIAkY7JBeaVVv4BXAJGLt4EN3LSs4q1L25MtFqMqkVQok+w5itUsNGWAf04?=
 =?us-ascii?Q?Gunk/W2cIwZBvSh5Oy7FY3a3smHEwoRwmnrYbclIGrMpNJpxrQwM+Uy9lOe5?=
 =?us-ascii?Q?d4DCwsG4jn7f31POjh3KQs7Y6SXNkVd0lC5Ynb1EGjyENnta/u25Vi/nnnDt?=
 =?us-ascii?Q?Q+GsjDr3hhmiufTFjAxyI+p074P9jz17EX6Nt8lQ9mDcfix/bN1itwYixVb6?=
 =?us-ascii?Q?aENCNqAmy9CC4XT3HFEyPB22tAIkv0mnOeN6/ofG+d6Gr8jOv8xcNEs5C/8x?=
 =?us-ascii?Q?Z+n1+1bOppYjZwmJBmEZQmE1j5ml6OD5oC59jhiH1nacY1oyQLZA9P2T21fV?=
 =?us-ascii?Q?8St+dIc9JILkawlPWemyu469WGJssAgyiaAtT27CS02foyzApBHvFuVBJc+B?=
 =?us-ascii?Q?L5QVUHb+xvWZnXnUDvtBaV7TspkIX4TaRqYnwfHqPYtxEU254/i0RFjxvTZe?=
 =?us-ascii?Q?q48TM1zjjcEynpIHihpKIYtelVhBVW2amU+bGdlwki1tgP8fbHFBFbnGSMks?=
 =?us-ascii?Q?Sdkfu82hTBLTYrOpce/AkVYc5nULHc0EasiUTdmtYvEQhU9fUhSmnkePIjB0?=
 =?us-ascii?Q?2DT07YbGPaxTg+77ll7fXMtoZPvQfhbJ6Z4gil2LJk5ux0W8Um7usAdDa/CF?=
 =?us-ascii?Q?Wy7AnR0sAyab3PH1gGJSSOZYS6Om/HAsAKIv2M0aaGwiH8JwORZCgaaL9Nrh?=
 =?us-ascii?Q?k/0SV2nPow8f5mdRktx7nAoAORSzmcMy0ToW25jDvG9wKVjdt8eRmydwj+8j?=
 =?us-ascii?Q?lqEJtcMRXLy1pbEOUSo8+dZ3O9A7GWVAVe8W/z+cOtlZSvkl/ITfHSMI20ep?=
 =?us-ascii?Q?lmMcsL1yI46KlkpK5JVUsKhoMBVo6+wkkF6jqfa1mN084CBUsRHqlfYGmcyo?=
 =?us-ascii?Q?ACl9nwfVCW5RxZWXKQCGYC7JkJcoiKoukdexDhw24RHvZRGm5zwFh/130Wu6?=
 =?us-ascii?Q?SVdzDj90tgQR3IBwYvXhy/tDrVnVC1kzIE2NfsqdEBdhQvxw/yYGB1UV0DMS?=
 =?us-ascii?Q?lfYMsLpxTlmNxajNxw8C373snX854g9Wv/WJaJ+plVXSj390BhNQloBcKyAv?=
 =?us-ascii?Q?l3z9/yGHO5hWRsB//sXfVdyFz8/zrnplN1y3acrDV/xmShkQCWSsdr/N0b+f?=
 =?us-ascii?Q?qQOHZX3qVaFwMYY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 22:37:57.3982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90702d1d-485c-400b-88b4-08dd6b248676
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE91247D15

On Mon, Mar 24, 2025 at 10:03:23PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Calling iommufd_sw_msi() from iommu_dma_prepare_msi() in the iommu core
> code is no longer possible if the driver core is in a loadable module
> because it is now a direct call rather than a function pointer:
> 
> arm-linux-gnueabi-ld: drivers/iommu/iommu.o: in function `iommu_dma_prepare_msi':
> iommu.c:(.text+0x4fb4): undefined reference to `iommufd_sw_msi'
> 
> This effectively makes the iommu driver core part of the iommu subsystem
> itself, so disallow building it as a loadable module.
> 
> Fixes: e009e088d88e ("iommu: Drop sw_msi from iommu_domain")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iommu/iommufd/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> index 0a07f9449fd9..2beeb4f60ee5 100644
> --- a/drivers/iommu/iommufd/Kconfig
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config IOMMUFD_DRIVER_CORE
> -	tristate
> +	bool

Hmm, looks like giving up this "tristate" is the only option as
IOMMU_API is now accessing iommufd_sw_msi() that itself and two
functions are kind of too big to be placed in a header.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
