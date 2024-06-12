Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4D2F3B
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218231; cv=fail; b=Ll3+CCEUKNKunUT0iwjW2sD5xSxrUz/vYRQU8MUZA1/d+TELfBvRh9YpY1ZL/5BJXBPtsyFbJri6WseOSJNjLANfNgWhmy56s6Nj4AuoNtgFAK6z/vKsvSEapyZ1jm8he80pEUcLP6dzooi8/D9EmwmaHVmtDVUiHqGaAkWDzbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218231; c=relaxed/simple;
	bh=MlLoC0TfpfWGVXkfu0VdYdXLhEuDtvG2Zi/icBBGdWg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVNkJuUFSXRu3Dn/vo+wFRnMChbpEc+rvVe/MVFxl8dmN11sCNqM4NcBx2BsWwDLQ9NHAZsKzJ3tvaE9SgQ+eJtouqKw1xEd6yFEC6mLXSnY7GbgdKw+AWlx3aoRsJAv+P7UyFjkyzool9iXltCPA6U8v0QOZrdG8sNwTYYepOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FO0yEkUc; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FO0yEkUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkzWdeAattO/mjopMOtK2DshZWkFeBshrOFMiiinmC6YywbQ8qxMmwKS5o6uKTgTu/ReNPU09H9g5KiqBMuWtXk7PLnLURmWHoRgLzV2GzVtkP6IGfJfTWGzcBGF+kzQHltb/sGZ2QW6OEjGod3+rIkkYT9IZ5B1lWa5qmnbiCaeW8HCJo3GV6lZSAsHBSJ0nZ+vo5Ayr3r5RLjH7O55LUfG9NicqtSKGBszQRBlNCUjH5KUOm6yavxUYXs2NyaS+ZdHQR9xxi0sMYUkkAIzzYh+OaEaytsHgR9SUhljXMcVRsliPfB/8EP2/aHOrAFhJOO2MeSS2RACnTrzpcO97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kydp9l523dMWtxJIBrjgLTEhKxJHmdFsfcxzO9NCOfg=;
 b=ICedr66F7tFZ3b+6YpCW1KlF5Bsa6jgQ4zStTyJ0jgshri9gJMYxQrPpzSY+QJpG4JxUU4MnxidU/j7AjtQ4C1dsmx6M/GGfKcbGD9KZOWA7wTWgETEedez5xcB3t4wS2caV6KqJiNGLdNszUooVCEB1mmdVzl4ucGj7K0QeuaUU7zO7DXw8Jm42VqzXx4Tmf3UKPEb+JvaTI6g1ZAJimcHLxJ8O9wUUpwNFNxEVv6kMsJd4nvFFd1I9riJKJcfnB0GPRm9XxGbtOwcraVxjFhYaSL5CCjYYwcO6XNKpG5muIhiy5A+c8sPpkK4oirwwlvAsZAk2DXCzHLgYk/znhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kydp9l523dMWtxJIBrjgLTEhKxJHmdFsfcxzO9NCOfg=;
 b=FO0yEkUcCKmYu7V/uP2xiYRx67B9VcDrNdyS+3XGeptf69tEWrDCwFCpWBGdPFIHqJD0KrOtlYvo34z5paVs/dzbh/7AWf64ovdtKnhm3eY1XbZ1FAeLRm/zPiElW61CCw7znKq4SZzVshr0WIOwMC8FN7f+aVvzZZUabwfi3Bx0peJiorwY6/AyGASvioFRtlVmmWbUbR9S9sC/qrIZKbAyyeO1uomQPs2iz8ZRgJaejSP3IhyHhFztbNyb+Fr/1f6MtyxHwsEhEswkNqznCAYgAPmEkFHnwQYaG24TLcq7VS6ejmhJltrGgZHr/Io+a5H7Q021paS6nGtCP7s6iQ==
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.21; Wed, 12 Jun 2024 18:50:26 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::7a) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20 via Frontend
 Transport; Wed, 12 Jun 2024 18:50:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 18:50:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 11:50:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 11:50:11 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 11:50:10 -0700
Date: Wed, 12 Jun 2024 11:50:09 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v8 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <Zmnt4RL+RcDiwurc@Asurada-Nvidia>
References: <cover.1716883239.git.nicolinc@nvidia.com>
 <e7dab374702aaac8dc81b95ddf89c94befe409dd.1716883239.git.nicolinc@nvidia.com>
 <20240612122925.GA19897@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612122925.GA19897@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 943b6236-81a6-49bd-cc62-08dc8b1085ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DY8CZ9IEe0vtaSeayl9F1nTjyExS54k7hAzC1CCiHeMXMSROwpiVI3Oln9HD?=
 =?us-ascii?Q?LEtaw+IdD9K+e8LtLdw44pV86ZMVUwDSkI+uOPubbiuxAs3NPCYJZ5dPisF3?=
 =?us-ascii?Q?rWuQs1ef9vRs2QfgLWo/aqS0OXWtNwJ9fHiXZQ+OQOaAnisl3XGeAIFDnelF?=
 =?us-ascii?Q?5pDACcwtb4NthWI3Q4w/CXO072tLoLpmlF2rtFgGy74El+/Q9p8ZdrAjNSr+?=
 =?us-ascii?Q?p2RElmxGphYh+zU/bwvA+UhCWfTJZe2Ikabr9EsCtJI7amiC/N0Hyt/MkMVU?=
 =?us-ascii?Q?rtCfiPPPZ2T6iYY0JnBhxTmCl+KVtfDXZsLOZjh24bqWP0+OqKH7xIvzdfBH?=
 =?us-ascii?Q?vE1fbPJ+A8Jcq1tJwN7zDTsVVHyDMCq4evolPb0ByUt2n3CgiEudJODCa1dV?=
 =?us-ascii?Q?9Wxo+x7msC5HxY9bXqGXZXd4OwY8bntmOWhcPw+eTxaWXwe/pJRO0cNEysvI?=
 =?us-ascii?Q?SGSWQDEWOM9dZzTzekaJJhdGO+iWbWl2pgxSKDQl+EdTbIWPuiMXJYUid8Pq?=
 =?us-ascii?Q?LtaW5HHHr7UCiIWdHN0CYNAESwSpE1JDLObGSIpmhQt+1qYM8zrREfXomExK?=
 =?us-ascii?Q?wXmAsVym5cZcfQ5rem5A3MZ1TiO87r9gDzyePD5ZbksaEIIeqmrcAzUheUaX?=
 =?us-ascii?Q?eZk42ErXZ3fW4Jb8ax7f1hTvP8T/viCYQ24SA6ZJVjMEYtarRmoiHHRhoGGr?=
 =?us-ascii?Q?aYm5EtnUAYj2USb1aT5Mnp34cjWB11uSfRrw9eKetXSOXEcPI5REUPczFb5l?=
 =?us-ascii?Q?uYnu+jQuI1drKsQbOXJUvR+X31u0tfPA9U9O/PZHhPLK+My8GZx6Q49iSXR8?=
 =?us-ascii?Q?lXJyQoPBFXxstJBjDEEFD3uxdVvc5HchUDjvOytereS/SnOCDm/cddzSLzpv?=
 =?us-ascii?Q?R/v/ubQR5BW0s06yabVRBLbAf0S/OxjpTcUj2gNH0nHCRG7fiQWWnwC7nv3R?=
 =?us-ascii?Q?Zzdv0uuGu4Qr44Mr/fq15dTes3/u2gSL+awFjMWbX51c0m+ciASyyiFU72js?=
 =?us-ascii?Q?d4GMlz7tuVT4m+XccPsdhpO3oEhE+37Im1Mvy/nC/Z9qPyx5toywJTxX58Do?=
 =?us-ascii?Q?UKdoLl0WIc4DuIziKaLo8mzzWdLQoxhEg1I/g8vBtyDaXx7bxZIWnxCwMN+h?=
 =?us-ascii?Q?7I1048Yy1U11bGenvZ8tLqjJUcvv6SCx6gel3jQWPHtrsAaSFjH3I/IfJYw5?=
 =?us-ascii?Q?Su5U4PplkiE1+oLBK5S6yGeCOI9wNW/wzTh/Aau9Hx+jY3m0HpU+ziETDg/F?=
 =?us-ascii?Q?6rQYH7zramWyJDClx5Zh8Aj9IKBKFjF79fSaZFt4g+sIXtp1BqcmNHwL8fbK?=
 =?us-ascii?Q?ck0r5biOD8mI8JagZNL4/o6pIwgKA/V5wZGOqqYa3rFWaSqJhyYhYDKuxmPb?=
 =?us-ascii?Q?kF+8nAb3QoHXCNtOs52/YWzhWAeFe8LOEe+D4zttEaxfM/NInA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 18:50:26.1274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943b6236-81a6-49bd-cc62-08dc8b1085ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376

On Wed, Jun 12, 2024 at 09:29:25AM -0300, Jason Gunthorpe wrote:
> On Tue, May 28, 2024 at 01:09:53AM -0700, Nicolin Chen wrote:
> 
> > +/* MMIO helpers */
> > +#define REG_CMDQV(_cmdqv, _regname) \
> > +	((_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> > +#define REG_VINTF(_vintf, _regname) \
> > +	((_vintf)->base + TEGRA241_VINTF_##_regname)
> > +#define REG_VCMDQ_PAGE0(_vcmdq, _regname) \
> > +	((_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> > +#define REG_VCMDQ_PAGE1(_vcmdq, _regname) \
> > +	((_vcmdq)->page1 + TEGRA241_VCMDQ_##_regname)
> 
> This looks OK now
> 
> I didn't see any thing else really important in this patch
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > +static inline int cmdqv_write_config(struct tegra241_cmdqv *cmdqv, u32 regval)
> > +{
> > +	return tegra241_cmdqv_write_config(cmdqv,
> > +					   cmdqv->base + TEGRA241_CMDQV_CONFIG,
> > +					   cmdqv->base + TEGRA241_CMDQV_STATUS,
> > +					   regval, "CMDQV: ", NULL);
> 
> However it would be good to go and fix these case to use the REG_xx
> macros, I noticed several.

Will respin a v9. Thanks!

Nicolin
