Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDA0126BF1
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 21:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852344; cv=fail; b=TnsK2LgBIrTh4c5Mp1VkmrbDpQMe+5wOaRvZL2BpNVIWl2LpxnGv2RqaU9hTDuF/xST38ruc0G04lVmrj+EjUr6fzWyVoJIxiSUucheX5H5xeKN127dnljv9leMRdrG51ufpUypkJJc5ECD22A8S7azDHAOfP7F8/Ad/bc9jUYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852344; c=relaxed/simple;
	bh=2EXPxSH21qb821cpcXOLeNTTeXlqIhFa9Cy/BqkUzOA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQy/T3/QAMh9eewiRki4/IgXbVbg/BWsk/B799Q2j8D0SJhz9UBLacPddOhXHQdDMyr0EZI1D/1hHYPBwvDIkL4varK4yMNOkQQUkEoELjBNYAZE7opaoIgYjMjB4wYFjgBv7DdivdayoGPscJ7zTIa0kMavoxEnEj7PqKmtdnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fa/kOYFK; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fa/kOYFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uUpBpmX0HxNV0rW0iGDQOp931ZWtZ0JMkHCtGFwj2W/CzIbxfUt/ugGClphxyhEoTsw2qgO6Pj6MC3yGFeDl9eDHVD2VxXTO/M8qmQ2oe4MZl709XYSx1/kP59h3cLhDHsxWxmDzaVsqb1MdR51uQxQSfVY6esGN3hU4WZ576E3lVNghxnQ+ykGdu2EvzK4MvJxf3SHoB4kekGohcVHaoXeDkNpqm/urzjldZoilBTJnL1LngwsVqxRB1PzsJU/Alx/hKifOOD8pbb1j8hBMkWpows9wU+9MSOWiLp+ejybGPom8MsmqqQrOL8YTqtDCqFpNteJLZJ1FABK4auTFSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np7Y+Yw7sWVjteo4nnAawY9csHMMEbzq+zjSZtZ5Xhs=;
 b=q1nWLNfdC6FxIeqtVSw6r/Ty3BKY5TPGVTAdUsd1lI4dtwqdDWSwWovGQNDuyAdTxjnSUIPRUZnmSJZPiR0EK2hf34upbT0oLJjFEWrhf9/lopRhOdjOlzkcb+H6hOcS271NBxbCDRvvImaEpRkEgTvRW59Y1QdZl8Op+TatULmdhv6NNyghuAs5DYg1infsaJtO9Z0SvHYQ5xCNPRmX2MatOQ/Z3sIQLcSLn1sVmCUSy/3YaBW/GA4LtetdCNxUK+ED1x3thhxgRHiHNjEmjc5YrytvAKfrvNDyHbQV7g/lUYS3AiU9xOmRKJVKguAoe9zOtNVP3zLcFkfyEg9ZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np7Y+Yw7sWVjteo4nnAawY9csHMMEbzq+zjSZtZ5Xhs=;
 b=Fa/kOYFK8eTb94Mh6PFXgtB9EdQ+Rlrg397TeVGpDsoxr3Aa42LzwZgSW3G73YZzMtxWeA8GtMQ/wJ6yT0mxDn4DFqX9QTSjSV5wl5tKuQTxqdKnCYwaDulflqhnqntD+s6Gbb4UzD/m1IQG3pnK6xTRsVW3CbZvFUB4zho5pIMuDQ1ZCmwAZhk6Bzmh19epAdpZkDoN0dn+lawHBFD50MZ24/hKeBuE38ijQeB8EkuGITjdzzZ5E6ycYzsxvjWdJLYx+3ZKLP7xAOLXTGOyed7GHcdj8z5q5Lr5UtrlCmo6qJiSwYhcwGQQaxuoqkOGk1sG9Bv5aD+hAKvLnEPbrw==
Received: from BYAPR07CA0078.namprd07.prod.outlook.com (2603:10b6:a03:12b::19)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 21:38:59 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::5a) by BYAPR07CA0078.outlook.office365.com
 (2603:10b6:a03:12b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 21:38:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 21:38:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 14:38:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 14:38:47 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 14:38:40 -0700
Date: Mon, 24 Mar 2025 14:38:33 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nathan Chancellor <nathan@kernel.org>
CC: <kevin.tian@intel.com>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<will@kernel.org>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+HQ2QkitMPVAtmc@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
 <Z+GOkl21ZLtE3B/e@nvidia.com>
 <20250324170743.GA1339275@ax162>
 <Z+G67avxHQt5L+62@nvidia.com>
 <20250324204352.GA2734321@ax162>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250324204352.GA2734321@ax162>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 1020caff-2ebe-406b-35eb-08dd6b1c49aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nnRZfI3N6xPCC9OZyjv3myCLp/7jswso32b2PZi137p6wRszqRgQ1FlmkxH6?=
 =?us-ascii?Q?kegtUVH/GqLGiQPPh5BCZPLo8+s0RstzVGq546u6KyS8zU0FCLp9UArQVdsO?=
 =?us-ascii?Q?1Ysl0L3lHFtwK116aPpg73yCZNZFd3mnhGzNpIHZnCSZ/+f4VgdN4Oh2h6LU?=
 =?us-ascii?Q?8Gct76QXt9QAVWZL16iPK+qO/6UVielLtcjRP9fTCrC3z/pGRrZuS4b7xaaz?=
 =?us-ascii?Q?hOV8zJ+7X2qWuJayyPEJ5f3uNNinJBdTX2dkXm17xmzCohteL+M1F4enzh88?=
 =?us-ascii?Q?695zref8EkVnanA9VbRrv4+QdvFJkWIeEaqXBGgTv9+4hFt1iRRAFXVe0c4h?=
 =?us-ascii?Q?JCAPp4fk9D0bYrY8sLf1TiDFShQfFuWp/6IpyLfQmm2cBKeJVZk1D8V20u0n?=
 =?us-ascii?Q?Cf0GU7qV+Bnn1D5FHBzNX6xZAqWQREYNsvPMkr3kmjKNKl9SYaLZmOQZdUKa?=
 =?us-ascii?Q?jphWKXfAQ8TzXPCMwx24mSB4i+JzKoho/Uw2eM6NwVHQtFe0CH8cmcH02nVN?=
 =?us-ascii?Q?+YMg3wV2ZTyFeNOaRPjUlTvsanDyii+Ae1Z8freOnlK6FJFZiYgTUL4dNp8B?=
 =?us-ascii?Q?t+qaC6sms5JOGGaFtgqosh6YBWGE+7Ddu6llhlv9Omj28iHZnH4n8RoWVZex?=
 =?us-ascii?Q?OKnSHnuvg9T4/ZdoPtUtc2QrA/NB8BFHjkCaiBRx6P3FlLpHnvN6KIxzFvgS?=
 =?us-ascii?Q?mv1+yjCSIB9XLcjgjCoSiovabRUIRz/BApsH84kl5ig3gtXRvAT2ol184+/E?=
 =?us-ascii?Q?lm9LKIFc7YQS9m6LyjaCBSDT+9LIntRpqHYs6bUgZZOwDrTTuR57YYEIKD5S?=
 =?us-ascii?Q?gtuR/iAh7DMyw4isRSO9a6NWq5TmxAxP69R+Z639Odn35jE1WhEenNcd6UJW?=
 =?us-ascii?Q?bCLynFstt9+ZLqnwNksIiWDbG6E7DuP7Vkefv386cEj/x3KYjfFUV6jHdNVe?=
 =?us-ascii?Q?IYBLtV25XxDMbJyzwxaA+ZrMkaDX1G6tLBMj0qqZ/P7PI//NrikTbGyDlcB3?=
 =?us-ascii?Q?SEsnSo6Bx7flxkaubBswfQweG8exuznjikFQRhfqXxK/3KP1ftTPgwkDMIBm?=
 =?us-ascii?Q?Uv9vLApgoGxT4sXqLKuPt27K5C4XK9nqcAIWoqdx7hoNzOXXLHjU3jAe6CjU?=
 =?us-ascii?Q?JAlI4ZoiUj+tnqoEtS/4mO/7TkrOIML4aJVisgwOJHTZ+qWfSnWmqlhVStE8?=
 =?us-ascii?Q?jJ0BtzNmaPjmaGlx5wVrTm/DeFFm2Y0U8NIJWIs97vCcS+TaRJo6W0XU1+0/?=
 =?us-ascii?Q?yCDG9aa5n21IuqC0KrWQwwPGatDh/kwn9NWvkt1yYpmgjgrUg3CcljO2c03q?=
 =?us-ascii?Q?R6ij0P3xdTH5pe+XQDeBeS+dsHi8k2iHnKch2o2b/CPoINZVn/mYcpz0OG7n?=
 =?us-ascii?Q?qFSNfW47wp/ir0fxeibbN02EbS8f/N1OrAKSNu+Vxf+ImlNTosNz/pwUa5Fm?=
 =?us-ascii?Q?BfNsYZ16n7O1YvmGbLTWKV1WKZJUBaAcG4ImW+jZlTdpf1wsO/dw3fRjOXBt?=
 =?us-ascii?Q?JHfUPdEjjve130Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 21:38:59.5313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1020caff-2ebe-406b-35eb-08dd6b1c49aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

On Mon, Mar 24, 2025 at 01:43:52PM -0700, Nathan Chancellor wrote:
> On Mon, Mar 24, 2025 at 05:05:01PM -0300, Jason Gunthorpe wrote:
> > On Mon, Mar 24, 2025 at 10:07:43AM -0700, Nathan Chancellor wrote:
> > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index 0f4cc15ded1c..2b81166350ae 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -3661,7 +3661,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> > >  			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
> > >  			break;
> > >  		default:
> > > -			ret = -EOPNOTSUPP;
> > >  			break;
> > >  		}
> > >  	}
> > 
> > Can we explain why this scenario has a 0 cookie_type?
> > 
> > Actually.. Is it just an identity domain? Nicolin did you test this on
> > your arm system with a device using identity (iommu=pt kernel param)?
> > I would expect identity to end up with a 0 cookie because we never
> > setup dma-iommu.c code on it.
> > 
> > Should we be testing for identity to return 0 instead?

My feeling is that we should just let all other cases return 0
like the previous function did, as this seems to be commonly on
the IRQ allocation path that shouldn't fail like this. E.g. if
we fail a blocked domain, would it retry switching domains?

> For the record, the particular system I noticed the issue on does need
> "iommu.passthrough=1" (which is the ARM equivalent to "iommu=pt" IIUC?)
> to boot due to a lack of firmware support for IORT RMR, so I think the
> answer to your first question is probably yes?

Yea, I confirmed that identity domain on ARM fails too. My bad
that I didn't catch this case.

Thanks
Nicolin
