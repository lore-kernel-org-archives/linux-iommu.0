Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336291FECAE
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984004; cv=fail; b=glwg0Q5l5L6O4+Bgw6fsBx/zY2IXROTglhze/Su4Q+dgQtm7uMh8FUfQ1x+a5MdBiUEkjPfl5o5tguS3P4HIBjJv+dfa5Wdou9Z5orDz2tb6++5HZ0uuvoLsnUdwbgTgGSlmB6W9k7NVXzCWJLQ4uje0PpB0kthEJb4ua8Vkj5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984004; c=relaxed/simple;
	bh=6Atq2QtIDn5Pfq10zOp7kaa5vplrHJ5EQCIIh8icIaU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/avkv5Px+a5ZFzglqUCCE3Ub7C1kI0ZiROA4/0rM+/9Wj+pK7JZWw12JgCmS7PeTip8H/jEOUfaJQd3x8u6bHOs3X4k6Z49q4REDVYsxU9t5Ifsk95MAJkbwSkB+Rmc8zUwwcMtZ8UF7gVqqJ7XC8nyr65NFgKWLtq2ei8/UEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJ8TeRrr; arc=fail smtp.client-ip=40.107.243.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJ8TeRrr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgeYD+k+8p96Ngz4yLkCpDtvm0Y3FQqV+5zMM0UgugCj3vkg+d0WAQX27Vc9YejlqJ/wAbB0LD/fXW6vCBID1Hnjki2XP8014ejtOYkUeCEixoEBwn5cJEtK5NMNZ1LGfYL1atdb4N5k7AL7sOdNgxi1bcBZ/yX4evHULoEOffeLp/8WhRFYr+EzyvTVqLB8ngzpVJxxDnYVx8/f3CrpVNyORJkSey5v/rLj+rCNyjqY0PtEyW8W0/X3Y1GtWC/jUcZl38kDgUVmLawdUukhueWyHR+F0cKNpT0/bbFflNty1BzC+Mipy2KC7vTPn2Tvmm0iIlOH7VQ/EcYu1xwI3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WkYUWIBYFSDHJj5dqlKxFnITsnCILZtLLbUVMMImyJg=;
 b=w/qhY49QQiq9H2n+Q7h6k4ezAZlhLwNJ+9QJlHLLXvXSQqXMYqrQVLMdkEpUueh9PGtCzfNxCUV9wrpjQkK4VRAc3tD7iiqTuqCjxM1yU2XoKNXIp08lBCWaOkhNXqNkGn57ZRWCBg9Epknsku9HgvVDDYJUSMGkmWPTX/JR5Z1Je7cPU7PWvr7Frf4b80ilKXWl0qXq3lBGMpVVtl3cayN2HGAwHAUSatisRto6oxextVQbOAePqburMqy2VeAp8cXO+eTKva6P1B3r+gdEP1nrnjxqiHLetT7BvN3knG8SRAs0rVD+KjFUWyatQXfeY/nNSYlOi0lVFux6wpY1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WkYUWIBYFSDHJj5dqlKxFnITsnCILZtLLbUVMMImyJg=;
 b=LJ8TeRrremhiUy0jpjagGBiXIaE39spKq2g6fYekemRvrXqGn0JtLK+iFAz8+B73pG7/Ef7rOy0i12n/+dYkJos6kk+fgsLm0nJGqz59iSq4TYkQKEakJvV64lW3t0nUJwVa5jhcL4SV6NYYzPaHmzz2Ns0PrObPT1MIV71oWbPNLzEqo0oF2pro2XUPnYWrSBDIlri024XbbmuCH7oF8tm7XSoewyVM6N30z71XyKZkfjuPEpgu7vIGbqJP3+BTZmvqb9R8gMle2lB1nU5LR/3hUkM5Sb/fKEUC22PLeTHx9Sl4Uk9LnahDK4yPBrZDYzFJoxsBy0hiZtx+KWs+gg==
Received: from SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 16:53:18 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::ba) by SA9P223CA0008.outlook.office365.com
 (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.20 via Frontend Transport; Wed,
 19 Feb 2025 16:53:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 16:53:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 08:53:06 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 08:53:05 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Feb 2025 08:53:05 -0800
Date: Wed, 19 Feb 2025 08:53:04 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <kevin.tian@intel.com>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <robin.murphy@arm.com>,
	<will@kernel.org>
Subject: Re: [PATCH 2/5] iommu: Drop iommu_group_replace_domain()
Message-ID: <Z7YMcISryMeilVpw@Asurada-Nvidia>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-3-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250212060540.261436-3-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c7a713-90bd-4a0b-dfb0-08dd5105e8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RiH3c2XqhNJvHHUPEzk3ZdkDLLzqIYGN3fvVIEyGa7TiTtQyll2J3sdRKKvn?=
 =?us-ascii?Q?u9W8+SRkolr3mKu3+FOpelMVAWaKFTtUx19lGztCqW3uRIN4w5OyjozFGAEV?=
 =?us-ascii?Q?PoyFWiJt6Hn5egXDi2pv8MyIYJ3VSRiG4Rs5OJysIw6Ju38eQw/MmeXcjYUw?=
 =?us-ascii?Q?lmqd1g+JPFmDLbChuK9sqxOsMF0NDUT5YGH3O3UruXGKH05QkpFXdAP3uaFX?=
 =?us-ascii?Q?IRiUuZ7G8b9ZRFEZ8YjcR5EWGC/KUKIKzp7yvabrcl8VkofZV5QCxESKAScK?=
 =?us-ascii?Q?eHL4TLTKalGIyLU9Fmh5QdMKaNEwOpp7jgQOlCpnpsDetXrWMGhnrLaR41/s?=
 =?us-ascii?Q?7Qe16C14rcvosTtknKtW1A4f1zSajRPIGuHfLeDmjDNMHa0nuktn5bavwqaf?=
 =?us-ascii?Q?z+Y1fBz3OMw6gIOOV4Ex37zd4Kz+5LtMpSH0e0Y2YL3PSoazzBBkl8XzaSlM?=
 =?us-ascii?Q?HHPlZKEnKxa5Z5jf7tXfGELgGwlP5CUoHSScid3IcCCI4L+OdcT9n1pbSQaT?=
 =?us-ascii?Q?av4DObhStBgXRZPvh/f7Jq4UtMTAdwU+iBewcJUodPrzSEd72l00B2dEOdwe?=
 =?us-ascii?Q?Vzmk/h1qcl3z5KGKfttNmtGBaVEgEbQg6DuGjeFqR82y3nYB2nLPGy/pU2Gr?=
 =?us-ascii?Q?PHFYiMXGj+6JPB0foXqyrWsqPlRrx6TrMdUFMTBVV/TnLahhaFmSkH0jtMgC?=
 =?us-ascii?Q?746YgXi5tVzp5V0EJT2r099nmLLvoLFaf6JImsnezLTiwEzJmCRx8kz+Cqnj?=
 =?us-ascii?Q?soZd3jVNLyoQKOwABd7+bpJcVRawF0RNjDLxPNlhO6R1ubhowUn+05DJXdta?=
 =?us-ascii?Q?wQoawXOq9WlVvqFXqLLQkZ2Rn6qRYJAD0OpwRUL/Zwj0wVkP42Ke6D1OM4Ww?=
 =?us-ascii?Q?AWlJm7QW62rmZZ0EhiaAIe/Esnx9IFNAT6hEJLpaaRM1bnK+zVpM6t9S+2rn?=
 =?us-ascii?Q?JFmrCVS/miPqdFTM7mPwjuaVEpl1FrfSKtrlidUcjeMvJLcNSM0Lr967CMBp?=
 =?us-ascii?Q?sASctpGUDmby+Jy67dUy1u5V7xzZX8ZPfd4V/61MCUWc2RloVva8vWaZ9XiG?=
 =?us-ascii?Q?WJpkYyHSquKNfYZf1FO8UowbHAO8j0Vgxo60b2rmKfOsTSqWGhqRF3bIxCYH?=
 =?us-ascii?Q?vU7jXLZRiai8P3wgRBFyY77QWcYkpcvibZrqaRnieU2B9bbrWSFpdPhuJPhc?=
 =?us-ascii?Q?KmMvSxYI+iBpYJdDDt7r3ip8mAUIaBXSnEW/DhIxFhG72JN5oo0gs/Bm1f0V?=
 =?us-ascii?Q?o4pXk3n/MnJn8cJy4ENVnpYLTu7BRHnVcYWmIwLhFO49Fix0qEnVPEyB5C4E?=
 =?us-ascii?Q?jP5eXA3JRSG0HkBYUnVfgf/TIkLa39XMDLu1L9LLd5WnEllkIhX0cOq7E56A?=
 =?us-ascii?Q?cUqtfmzrQAdBCSyRBYMeAWoU/tJPFl43xSEbYlVWrhSRC7Pb/DNuMP6OGUDy?=
 =?us-ascii?Q?gbnsP7iRsLkG3u3kI6LY2JleB3RXLUokchrQVPqkTO4I3+GW5QhUjTkgRFZ4?=
 =?us-ascii?Q?8LNmlx4b604vlik=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:53:17.9414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c7a713-90bd-4a0b-dfb0-08dd5105e8ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711

On Tue, Feb 11, 2025 at 10:05:37PM -0800, Yi Liu wrote:
> iommufd does not use it now, so drop it.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommu.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)

Should we drop it in the following header too?
  drivers/iommu/iommu-priv.h

Otherwise,
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
