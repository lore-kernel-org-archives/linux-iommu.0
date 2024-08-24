Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7143D7A
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458294; cv=fail; b=t+BcAjXLO5XTdbN1s0dg6nSv3GYvTK/c4z8HXR7bV5p2xeLNseylqOQE2wTugKdv4Ke7IR5dBrQqtxE4cyOmvh1rflNOmi/WkKDfY1zdFM33/BtOzue47ftDCGqIPWP/8EV0/ZB2cLQcyxfUyz2VgsDv7QxMSpfc35PHWy+knFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458294; c=relaxed/simple;
	bh=owVFkl4F7tgVgzMA8Fe3kl7FrX3cBFMrqFrrXjJlpME=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opJROlISxkYQV5KdcP4CT04PcXI930pBJcYxXvke6x/3RuTDJlEaMmc1GC0MmaDO+gKBYz0PfwZ9aU54+ykFJB/GAFBwfs+oovYT4isCEb8nilAM+R/hU9AaoYkIVswostiNg/Z0Eq2Oolq6X1njyf3WoI4qL/9WWTP12Ex+NQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GbKFUSOP; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GbKFUSOP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5ummoEmtBE+Wm7hG9PB2lkef1Ykg3JkZr34bIeW3dJKSs7/U5aJtDAZHUjsbrvcsbU9ycqmQKc8lUR4QRN8ZwilMIqBwqWwCPbh2cHgCyz0Ru0N8P2VJZ85bs9H481hh1SqmDlkK9rd5+ARC1UEz1BUchc1Tl7obsXmenbT8cGsBanmITRmWfHfyxG8yDWuceCH5FpPNxFIg4zUuWeYJGfT4f1s1wqHUXWbXIFvlyKx2rchm0sKtWtJ1HNiJBVZa8POrth28ruhr9aGPzzRUeDfO2E57UumTQzvofUWKAt/Wbmxyz0sqNsegxe1nG1WHouHANqtYyl1UQODHQB7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqrB+4albjZIkXZvsDgrGK7nJo3lVGHWAgsqG+QGfQ0=;
 b=wVeSo4l194cLK5qsoOeEDdy/hfmqzBz1QUsepmNWbHAk6NrQUfh87jVrisCDjkm0FLp48uXC6DFL7043CRBOjzpkoD3hwwmZFkbpnvl6b8NphJftT++zWz1cPtbbjAk0RQ6FATILBBZwbfy92m/pOaCNJPXgF45CYBGfrtlznAdffnrBXQ9uI4qolIJhZZJgbeQD8mzNw2+GejeGhBKCpxx8+RqE1sXiiqnO7m9Ms1SWOUDBI98PPIaLeDI1wH5paaM4tCjSNqMA4AgkDurquFGoThI20HSf9GAkaYyA9OeATEOBiKPVonq7xrpm0iYrH7O3SdwSnq1TYeoEIZ6LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqrB+4albjZIkXZvsDgrGK7nJo3lVGHWAgsqG+QGfQ0=;
 b=GbKFUSOPqTM/9LGGd2YHdTux2fiAXGDXmtufUd0wQ9KxmU8eF3BDKgInNGGapyUMlyUgeZnpeTaroKItiwUxTM3IsaDcLYq+bnkyRcug0lT9ajcG47SxkWI4i4LaRq1zyuKkQu8RLw+i2/B5jFY5xj7QV+gV/nh6n8z0R+lnESVIHserMv/qk0DE8mwIvgkujXywWTbIdFZr6lSLfD7qrV6ODmxP2PH63SuellF7Lv2x2N0Lc1TnpedYWsJCY14IHtKXSVqmEIWO2hxaC+hh8ohJvaYksJFlpm19nToQcghVFWaN/FOPp37CepSB3WVwIOziWkWwgU4yvygxkbXppg==
Received: from CY5PR18CA0042.namprd18.prod.outlook.com (2603:10b6:930:13::32)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Sat, 24 Aug
 2024 00:11:29 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:13:cafe::9) by CY5PR18CA0042.outlook.office365.com
 (2603:10b6:930:13::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:28 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:11:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 Aug 2024 17:11:17 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:11:16 -0700
Date: Fri, 23 Aug 2024 17:11:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 8/9] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZsklI7GPHaXWLNU/@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <849c17b97ae0a38db1cee949db2488e4045666df.1722993435.git.nicolinc@nvidia.com>
 <20240816141926.GA24676@willie-the-truck>
 <Zr+PMiRKCYPgkB+1@Asurada-Nvidia>
 <20240823153817.GA525@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823153817.GA525@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: bfbf5008-1dbc-4622-4dd1-08dcc3d14d0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XzIbNKRUX7/Y3xJGx6fpk9uuiCeXaz6kGz1hZDHH2OvsTYSKw3fW9XjqgKMp?=
 =?us-ascii?Q?eM+F0nfM7NfZHbZwS6Ftayl3IAabbGeCGnSXy0W+m2pXwpZKnMDfZj6kfaRg?=
 =?us-ascii?Q?Bato7olO9wdcDQAebTHNcrxyW9nL45NCf1wls1Opah9rxTjG4b39ouAIM0uz?=
 =?us-ascii?Q?c+lumc9urCLg5+22ndKUd5g496bGXQB9ndwM0IbvGiaA36mdhBlNoI/CiAz8?=
 =?us-ascii?Q?xYl7zRUwwusVzamo+QV51GL17Msrb3XIQPMd6u+QnZCRCD0ISTE0Jy1TwZXN?=
 =?us-ascii?Q?TjuEj2Faf1vRn1T+qy0RSHf2R+tfCp4f1IYQX7HMye7ixNiMxiDwZYlfrYvN?=
 =?us-ascii?Q?WPF+FwkHcomOQ1UFxq2wN8KQDqE0ywreKVmj6jDQmDv7571U3+fRCM/7gyv8?=
 =?us-ascii?Q?4esLwevDfzxycOE7ZS0MX3XW+kDM4rJIc3RlmSHsOXTnEuJQ7KQN6+49qhsl?=
 =?us-ascii?Q?oJ+wI4Rhu/5g5vclH+FrYCCyTI9eI1yao8NUtKFCSvF4wbb4mF+b3K0gYz1z?=
 =?us-ascii?Q?CAxCbIUEnAqKAucWmjouczGetC43PYaN5IlYrN2A37XgFytC2y/k+HKFftmm?=
 =?us-ascii?Q?xgYyAiKGTlY2z6Q7Wl7wVoKmQwdQOLeU7g8jMUQerc7toLxDDTJopK4EF9K0?=
 =?us-ascii?Q?mUblVswXgU5dm5E5KrRNWzA2CbagHgRSs00kDUAzcxSaOWwbW98A+88BiP0w?=
 =?us-ascii?Q?57kSUgtyvJ+sjuVF+XGjSZHKkRFR3UpiNyJdsEV3+b978HWfBiV1iwavAvi2?=
 =?us-ascii?Q?9nEAYfYa6nwDlW2hv3hFJerELd+JVow/9YWc/gTeK7hTxa+WLEmeFIbsENJn?=
 =?us-ascii?Q?VzXJ6ehi1zCgCv8rJGDxgihzkmHVtHPxo/zmLeFK2DJYwuu1Pfcg62O6OBr+?=
 =?us-ascii?Q?L6/x0M6AR4R1XDGN0H4NJvP7dVcxeoqCfATaOCm1u5MXtg7qQhZusjPXd2Yt?=
 =?us-ascii?Q?ElUCDn6ejMg2Qdu7XbkhLxAc/6EfV/51O8HfWL+vAKwAs9ZG8cTB3svxeR6k?=
 =?us-ascii?Q?1wnWkrU4t0LQqfwtAgXksIrLHDKtZcldKZ7Vr0kzlKAh7U8Y99pp7rD3IzGv?=
 =?us-ascii?Q?2ZUgvM3iwBshKJ9rbgdm3UEtHnd1nWveyCGYzpVD0jVtXmolXzNGXlm1S59H?=
 =?us-ascii?Q?gqIeX5aUCaYuH3oGkY6VbX8jsx3sECVJUtkWzkc8rjVzI2zsqAlQwiEJW6/R?=
 =?us-ascii?Q?bQrMNrS+fcd4cn1Z9r/wYgCLqUs4G7/rmSyBXZ7N8Qo4Kh212DTNjVZb5jac?=
 =?us-ascii?Q?EqaAAXXTs5slD/BvyfJTeve97BQg204SGmRjyupRphDvoiwCoryl/XKaOuA7?=
 =?us-ascii?Q?F+0kSdAlrfX+rV1AiRNu49L2GcLJRUspH3HVeA6iqJIEY6R1nFyJB7c5SoBv?=
 =?us-ascii?Q?SpBNA5tHbvtR2R/dAqyJGAQMoCVeFPRBGWL+rD4e/O5htlabmHwinHlrAvyx?=
 =?us-ascii?Q?PK4cUWcA6q4P+sau5yknP/s1Yjy72Vnf?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:28.7038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfbf5008-1dbc-4622-4dd1-08dcc3d14d0e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402

On Fri, Aug 23, 2024 at 04:38:17PM +0100, Will Deacon wrote:
> On Fri, Aug 16, 2024 at 10:41:06AM -0700, Nicolin Chen wrote:
> > On Fri, Aug 16, 2024 at 03:19:26PM +0100, Will Deacon wrote:
> >
> > > [...]
> > >
> > > > +struct arm_smmu_device *
> > > > +tegra241_cmdqv_acpi_dsdt_probe(struct arm_smmu_device *smmu,
> > > > +                            struct acpi_iort_node *node)
> > > > +{
> > > > +     struct resource *res;
> > > > +     int irq;
> > > > +
> > > > +     /* Keep the pointer smmu intact if !res */
> > > > +     res = tegra241_cmdqv_find_acpi_resource(smmu, node, &irq);
> > > > +     if (!res)
> > > > +             return smmu;
> > >
> > > Given that this probing code will end up running on non-tegra hardware
> > > when CONFIG_TEGRA241_CMDQV is enabled, please can you move the common
> > > part into the main driver?
> >
> > You mean moving the tegra241_cmdqv_acpi_dsdt_probe() into the main
> > driver? I think this v11 puts a function call int he header already.
> 
> Right. I basically want it so that !tegra folks don't have to open
> the tegra-specific file to look at the code running on their SoC.
> 
> We should also running that code at all on implementations which _do_
> advertise a distinct model number in IORT.

Done. I did my best to incorporate that and sent v13. Please check.

Thanks
Nicolin
