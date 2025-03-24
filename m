Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3E263F38
	for <iommu@lists.linux.dev>; Mon, 24 Mar 2025 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835360; cv=fail; b=N/VAEMAZG6ocJfYiy/xO4bBU0cyucdax9LZTpXnLPFZ5vLlhQ1WlHJC3jPKMnAvYPyh7TBJdxRDKF/xUyQnA0rLxjWmm3pydVQkNVP5xf/ln1EFGzLStKcZjm3XJ6FylcSzT1GVhLRkYEpY7kg4mCzfvkU9sT8aaRR7glQTBg1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835360; c=relaxed/simple;
	bh=XcXL9+HPq6psH7z9yI5S6utKfcdy6p6NEB28edFpKIU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQ5Esi2vzykWFE2aPXjTVuKtTQSm45Kmm8FhcluEe9yLpaEgEoiVTI7s6z4Z8djsC1JhyUWb4TVIDtC0uX6qJxQWBOK5YQzDswOoTLmJI3IN/57QDXTlogXCODusVf1QZ7xjzifHDKEtHKL7PwIbUdE8jXCy9nnPzR/es1AtxkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o44wxi8w; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o44wxi8w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKOUDxcxt4zB5sxeCOZEiMht0m+pRwBTEXdJJ+VeJB/VizxjlePIFZoBYapLKFvcTYADggCqmmffiShIyPHyzFw30xd24KWlOGfqG8Kx2DfLnXrRdBnaEYR92tGZy7vfsA3iFVBYXN2DnBj8YNOi98HT7yEWhkxCKOSyiX2tVyD3fpxwia//l+PkQQy0AFC+YKvUEnU6c2HD8sus92KnHYVFuWsNwsuhlb+n6GiIqOcyCgbVSlKr+H2Ox1jSVtM0qN4o4Y5V6byyJpReO40p3OzXgU9SoxCNo+uosAwZ2MOPRL4Eam538s+OchhXhF+lM5gfLGrBhX5zEVDR3kaUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RD8OCyuo2IfhufN/0WYez2LQ8LNp8oHHFeezgpKotyg=;
 b=WalURjekN1NwRCpASgGHS6n5wrW5cQVc8fMsCxpB50kSGgmOJLCXiZOfqrryar+6HuMMio4zrsVp5XGLnklWNfKsbgR+Ga+TRE1xk97IYMvj0f+Czfu7/GEPbswliXQRG4O8ZFVsiauPdxnntT7Ked41rg9aw/K3DWo5XOVqleI1xY2QIYIkYtC1zpcpQBRfLNQ8HQDxLmi1pf+2LHPSrxY0BphKzv9OrLNA++2MPbs2VHzRnFGNNPtM8JmpMk4p5pM5t0iOKMLXM3mOC3tgZsHG6W5wcEcggq9fWZZMWx5gBCK73kTA6rp6S5AqRf9V0F0Prd8JvjnBk8BFDruicw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RD8OCyuo2IfhufN/0WYez2LQ8LNp8oHHFeezgpKotyg=;
 b=o44wxi8wWDTuAyfJx/yyjlGAY+ZDa7u/PWFN+uEYIJPWmGRwa1hJKaLQKQoYqBIFPrUI5YXJo5/XRuhENBFQhnu7u6G+puqJwcXmTazEkDH9p/rL7H0TKkui/Y7d7HfIb5O5WmBOooHj+OZZMlL2C3olF3Jm17u9fVSRvapzSrJ9bX6m4OEhyJ8XkS94iZlIbUE84oigbJvfwE89FTsGrHMFsaTYXJtvCEZXilLt+qe1JNYJwJkCRURjLoyPzuMVJURoN3zEEKE6klW488J/NjDCjALmXkRHqk6YefUvREsYbaduGC5QD8yWr44j7mVi5+C/FrcwkdvgbuGzdrt/nQ==
Received: from DS7PR03CA0271.namprd03.prod.outlook.com (2603:10b6:5:3ad::6) by
 CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 16:55:55 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::e8) by DS7PR03CA0271.outlook.office365.com
 (2603:10b6:5:3ad::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.40 via Frontend Transport; Mon,
 24 Mar 2025 16:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 24 Mar 2025 16:55:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 09:55:48 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 24 Mar 2025 09:55:47 -0700
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 09:55:47 -0700
Date: Mon, 24 Mar 2025 09:55:46 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Nathan Chancellor <nathan@kernel.org>, <kevin.tian@intel.com>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <Z+GOkl21ZLtE3B/e@nvidia.com>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
 <20250324162558.GA198799@ax162>
 <Z+GK98/VSvYl518j@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z+GK98/VSvYl518j@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e213eed-756a-4505-57ac-08dd6af4bdfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G5yvqneJApnO/WGwY8JS4kHBrqjg0+WzSLIfmeLZGNi2Xne4YAyYojR9XJ/L?=
 =?us-ascii?Q?8RbL8/eYIl4r4TTHY0v52I1HOOxWnbRcNkPsqRSMRrzM97HumHx4J0Ubww3X?=
 =?us-ascii?Q?741NBvT7vnGJ3q2+tmCBcIVkGq9KqFhTmXtt6+0jOXHQnC9uVOZOzS2qSpDd?=
 =?us-ascii?Q?eskXIk92qzr9K23zqxOrmFkyiZJ4bosGmwbZtCi7wzB5aUwnYL1cBe0A7HWa?=
 =?us-ascii?Q?tGLT+ljjfKVItMgOc2avGCpjHWhM6iaDs2On/HMKEkV8NfH0gXOjyV+ghtU9?=
 =?us-ascii?Q?RnNTDuepp3s8I1/f80YIeBR85aDotOEADj82gY6O69egsYL3lY4Qapyqe5cl?=
 =?us-ascii?Q?kKUXdt1KVNYLk3fBlXE00uBTrBRIIglyMR6UDNLApQaC28dDNipbJNQLsvUU?=
 =?us-ascii?Q?UFHZNRxN3eYVHwrSGM/bExxnlGan+34mLSlhJvoZqd2maApXcOt+zJvyUN7e?=
 =?us-ascii?Q?9JQ7cyeU+S95xxesmeev21FfCBApLLxllUmEpbOpy/BlGE2IT7ecBIFtEHq+?=
 =?us-ascii?Q?MZCnP8VsQThHcmhQmUxlGd9nJ7kTRhtCK8BF4zljdK8io7L4mU9QrhfqhFl6?=
 =?us-ascii?Q?nIy2DAvHK1x4rF9nR7HkFZt2/qxTKl5xTYo8DJBmIaRZJrrtdz3uJ3m1cBy8?=
 =?us-ascii?Q?c+0XV5OzNWm8AgQoz3dhx8mQDunDWoD05z2DPAr/NE6urtJl+SNZWdhOfLLs?=
 =?us-ascii?Q?bjQZaRL5UrtR+M2LH2/xwBS9GDgjPbu0TclFZh1z0T3lrFXF16Nxd/+cph8+?=
 =?us-ascii?Q?oNDQd/eyn+FMLK8kQl1Zdm4WaeAIDPG/7FfLiONr4VFJlwZTEehc1wSSrW4L?=
 =?us-ascii?Q?uELP1nVRqyDKbBSQuhV8H/iJCCyza9PtrFpfTWCUFNiDmewVsvsKzVcDvHSA?=
 =?us-ascii?Q?grzh1kuuA+JcFEsFPpg0ZGyMXxiAC7F1KUCkVqsBO4mqLxOsYcl+JMAdx38B?=
 =?us-ascii?Q?zLMmeIUugJR7SpNbBP/oF0RaMM2A56yoIV8xbrFXkuw6FKHglAnxXxikCkKp?=
 =?us-ascii?Q?hNfTKPivaabKjuKWF4LJYTACV3pz7AvSTjEfrI90QniXELFYGD9HWRnJB4Dl?=
 =?us-ascii?Q?fVjVWZfnZGElcZI5POJhHiOCB0uj9lpsMYU7dTK+jt1oX1cMie5rRfp/cmaT?=
 =?us-ascii?Q?1AtNuW2a9PhiOuTJe5hpoE6EGpi9exqSEZPMba8LeRfgCOlQmF7paMqw0Oqz?=
 =?us-ascii?Q?LW8079KKD5KPuEHzIVmb6NDOfFys92TlLDIuFb1dfovFdxI5E44PtlEsuosm?=
 =?us-ascii?Q?xr7RVmOji3VxKsSXvL83weSKUC1xArJxwsvCM9GtmCfk6BV7W30gO16SDTdy?=
 =?us-ascii?Q?S8Eq0ib+N+frvqISMq3rreAKQnkqtKaRgn4QC92b56IKD0KRZp2oDzl9OPQA?=
 =?us-ascii?Q?rWEsYc7antfoGcnDUAO8llCvYjmRyymDdH3lU9V3gUpo8IAbRvHOrbHksl3y?=
 =?us-ascii?Q?DpRqjl8eCIqUL7UsdtPUBNr8bzY/coGf9nCwK7DwFEkL+RPBCgHO1vDSO+i2?=
 =?us-ascii?Q?/K+MUFK5T8kSN28=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:55:54.7446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e213eed-756a-4505-57ac-08dd6af4bdfd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

On Mon, Mar 24, 2025 at 01:40:23PM -0300, Jason Gunthorpe wrote:
> On Mon, Mar 24, 2025 at 09:25:58AM -0700, Nathan Chancellor wrote:
> 
> > I bisected a loss of networking on one of my machines to this change as
> > commit e009e088d88e ("iommu: Drop sw_msi from iommu_domain") in -next.
> 
> Okay wow, I will drop this series from the tree if I don't see a
> resolution in a few days. We can try again next cycle, thank you for
> testing and bisect!
> 
> > At this change, I see:
> > 
> >   [  +0.000000] Linux version 6.14.0-rc2-00033-ge009e088d88e (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:57:49 MST 2025
> >   ...
> >   [  +0.002355] fsl_mc_bus NXP0008:00: Adding to iommu group 0
> >   [  +0.000533] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
> >   [  +0.002565] fsl_mc_dprc dprc.1: DMA mask not set
> >   [  +0.019255] fsl_mc_dprc dprc.1: Adding to iommu group 1
> >   [  +0.046820] fsl_mc_dprc dprc.1: Failed to allocate IRQs
> 
> I guess it is tripping up going through iommu_dma_prepare_msi()
> somehow?
> 
> Maybe fsl bus is special and doesn't manage to set
> IOMMU_COOKIE_DMA_IOVA for some reason?
> 
> I wonder if this is not right:
> 
> +               default:
> +                       ret = -EOPNOTSUPP;
> +                       break;
> 
> And it should be just break instead (return 0) which is what was
> happening before?

Yea, I found the diff here too.

Nathan, would you please give it a try by removing this
	ret = -EOPNOTSUPP;
?

Thanks
Nicolin
