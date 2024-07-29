Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0C83CC1
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283574; cv=fail; b=oYNdujIBSkoMescYXW654BTCUkbnloS19qjOgjaUnOK5+QajaqVD6OQd8tCRS8Bk2LWGdVUgefD2OWCpYP/XPJyfaU+tFKnYlsdj9Fnu7PnQfYRqOem/qiNlhou/KoryJnbAKVpwEZsu+tkylJie4lxZR0/tgsnycnIWqXERPQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283574; c=relaxed/simple;
	bh=uA2GXeUDNgHBdO0mBHs+MIf1d1wIGi5O+wTvhhygJ+o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0AJYoROtQYgywli3rLWjoYAaGkFXqEds3ranK60/xZNPAZz8pdEfc+jlaa6obNctp0KYfwqHC2zvtbaWnfTrB8yOM0c1FkqnUGLCLPfy8MznZncyiIcmnCbScUYpBAp0CEtrqqQzKIGbfdVIFg/uepd+gEL0HczRcabvZ2xWuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SW9jj+Cm; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SW9jj+Cm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBr48zE3y2r9Vj7NU8Upq3jLSXunJpf6ZQAXq1gIbJveQOnz7h+kb0JpJFjK48aP++g6KWOAe6aLPAQjtCLLwK+lhgcj97isgai9Fauv6hDImby65gV2yY88EldqytQYpwFjmV6+jmq/Bc5fjYx/CYeucwMcui1tgcF1yMSHk9ixzhI8pQFS8ndOTOamjv49wJdbDSY5jKSyh28LgPmbofGMMaHfpzBz5j3bLanLsgoBpMdFb8FdVyLhi2NdFliw2IipkR/oGnKNIOC8YqZj5AoMk3K6xaPq+rOKJ8te+DEjRe0qoiqbDCr1fXEbEivTrSjE3oP++kRmsfvss/d2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOL1Vkr7yTPVQukCxK8KVhwVCy4x0FrLz4I2tXYyWLA=;
 b=ygezlIYTEQsgNGgGj0Kc+CCQWNmVVMIQypV/hawhg++TD1ZOQ9/KTAH07v50CfyoE/NcHPpcH8OiHA9byNo2/vp7JuVPXnveGMsQLq7WmNuGfO9JuUlbTpgtinfQhM+6vTlatGcxrX8FeHrW7NgtCAqcTmuwQM1Fi9yJcVortE4jL5PvbDaXjkMEqE39bBcZsFm/I22MaRvXThtrQt3k3wKGrtDZpEZNPCmiwWXNCq1Re5nYEs6F/y7pNFxYdtEUJbcNcil8ZEqaA6wIGsAGujoJTfjJJIWtmVQWzvw8+WjivNVDJY+rNpm2u9b1u28xn75UEpZOHFiUofEUh69Gow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOL1Vkr7yTPVQukCxK8KVhwVCy4x0FrLz4I2tXYyWLA=;
 b=SW9jj+Cm/cwNI/AM2kfMe/3Co6qqB5z+8w6WRxh5BuKgmzXAK9jspi5sOQjJ+NIXjnPA0aAuv5wJfBaooRisGLR0PFJ+pOgBVLvLZGXWnBXCa53+6t6DcO2NvXnHhqjPPJynl8E/fZ3tX6zRRZunQnufGivM8JM2pYlszfh7POiHhUlxf1shV447bFkW0XVz9g9Dy6SsPhV6FOGs0An321J4FDhdJIcqT67mRIWYrfKIlLJXfrue4+9rm1qHekWK9vREncy1dbJd6YTBzP7kcnvEGCuQwURDorYqVREa2e8mLACHkqIoWMrQmN0u9lS5NawJKWNrEMr+4nsN5NyAxQ==
Received: from CH0PR04CA0107.namprd04.prod.outlook.com (2603:10b6:610:75::22)
 by SJ0PR12MB7460.namprd12.prod.outlook.com (2603:10b6:a03:48d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 20:06:08 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::db) by CH0PR04CA0107.outlook.office365.com
 (2603:10b6:610:75::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 20:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Mon, 29 Jul 2024 20:06:07 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 13:05:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 13:05:50 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 29 Jul 2024 13:05:50 -0700
Date: Mon, 29 Jul 2024 13:05:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <yi.l.liu@intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommufd: Enforce IOMMU_RESV_SW_MSI upon hwpt_paging
 allocation
Message-ID: <Zqf2HFUf/75hRcUU@Asurada-Nvidia>
References: <20240728235106.2435208-1-nicolinc@nvidia.com>
 <20240729182446.GH3371438@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240729182446.GH3371438@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SJ0PR12MB7460:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbc12cf-9ed6-498d-69a9-08dcb009e270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BUUwPpRFq6jXWUUDx9Zkl7f1aDulKIYDOaDJum/aJggwEXoY32nQEqxiocqP?=
 =?us-ascii?Q?Eh24HIalpHRzuIfGmMWx+tyu2+gkp7p2OyV9a8t6uzW57k/ihmCzq0e7fDIw?=
 =?us-ascii?Q?1fXMtOBJ7nEhq//KKDlPJofllHja/Ngc9Af8HTkIvfWjNemERZT6iQD8RoQy?=
 =?us-ascii?Q?oSSIQmrLfvVuFmQr/zgd2lJGUvF+ppt4sOBIcJFVDvDBVl9o/b5dN6I6RuYR?=
 =?us-ascii?Q?NS5voEfP0ChzQsaDrs0w6FMmwkOXZE+/JaW+gGUVNE5SbhnsEozNsjtpviUR?=
 =?us-ascii?Q?zYApAPc6JpiHK1V5FuuMUsOoXhtrEo1eirldTsrnB+h5/prbn44EmAt9wUEw?=
 =?us-ascii?Q?SmnEWbixuIDUDPnNeZNkv/lXRmDyreA1hwy4mcSuAWkskJf8x34xCkYWYIyR?=
 =?us-ascii?Q?Q9WdCeTU0/cMNtTw9xCvZ9XTz/jvubhxXLkh+6GJDm88NbGyzaIBMl13Gai7?=
 =?us-ascii?Q?bFWpsdDxPFzDDrnwXSROctCYYvxtRKrpSyVTXa1Q97jnNhrtqOg6t4NWxQxf?=
 =?us-ascii?Q?Jlk4mAi4m+rJCl7/7XDwgAFp/go/IaMMU/Q/bVG8g6a1bXTz1p6hpWKi9MHv?=
 =?us-ascii?Q?fmSPfu6FCsLLWT55nyI+pHFU34tbpHdD9dVlpJGS2QKlCxnUg+FP1okpmPKq?=
 =?us-ascii?Q?2M7m6JobXjCvMx3h2KpZiQuhiTkIJ1hVzKDXzSxV75fYy/qHdKX1i+tR1/w7?=
 =?us-ascii?Q?w6y58LvQiAfXqk23dBBurQlCu/D0EHgyzA7HQr/f61D18CCzhq1xMrElS1RT?=
 =?us-ascii?Q?th0W5jl5OLQ6v1PLXdfqNpNaw3all9bmdSKM8jpge+1wmSjbyrisgWWyOlCo?=
 =?us-ascii?Q?If0eQ23DwxwsT7gLu4OcCtq6C1W9WNlCeNjuTZG+/812TdESloBBVVkHlJxu?=
 =?us-ascii?Q?qiwScGYZmVE0YnaDwc7C3Y67WIoFb+c5cX74JATf/9Dl5sNCGsHwCLJKgFLc?=
 =?us-ascii?Q?hL2ZV/d0r7DkfEfmFTcRxCq04unFTL478mBKFSnsN5QiCogUo1n8VTJwovIo?=
 =?us-ascii?Q?Kbpy92Gw6uzeh7ZNbkZehP9xOyPTGLG9dL5tb1T9aQ84cVx8OUkeIuHLDKj3?=
 =?us-ascii?Q?07ZmCgJ/VSpQQhdo7bw13zItlq/6LdyPcnLtk3k8LAApt2ZNCzfygctUNl5z?=
 =?us-ascii?Q?AgeWL4SzMWV2kxWbNlV++kIlEcIb9v9LrXaAbej/oyrTDaDxGaYcS+XetY4W?=
 =?us-ascii?Q?RNLYzGjBNLHR5Q4EigaWN/1Z2I8daUNl+ld7ypye6/nlX7EUa65kvh9//azZ?=
 =?us-ascii?Q?RJUsfLnaMUpcEsDeIpPjPB0DEBybtZFwwHuliDHcYngQvdSislg7F2SnS8/h?=
 =?us-ascii?Q?egYX9TlL8Cy1RkBx1IZGOkLSzlygJFZWT8YBSgoxnLItB+JK6LPNfb+iRzOx?=
 =?us-ascii?Q?Mn4NbOUvlRQIqkro71Z0rFnaeuv1Co+jdH3tEz90/I1wsXsUj5MXuiEAfbqg?=
 =?us-ascii?Q?K04IbXMsa82LwOAvbBLG3onLxCvsFOIt?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 20:06:07.8417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbc12cf-9ed6-498d-69a9-08dcb009e270
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7460

On Mon, Jul 29, 2024 at 03:24:46PM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 28, 2024 at 04:51:06PM -0700, Nicolin Chen wrote:
> > IOMMU_RESV_SW_MSI is a unique region defined by an IOMMU driver. Though it
> > is eventually used by a device for address translation to an MSI location
> > (including nested cases), practically it is a universal region across all
> > domains allocated for the IOMMU that defines it.
> > 
> > Currently IOMMUFD core fetches and reserves the region during an attach to
> > an hwpt_paging. It works with a hwpt_paging-only case, but might not work
> > with a nested case where a device could directly attach to a hwpt_nested,
> > bypassing the hwpt_paging attachment.
> 
> Well, it does this because the attach is the only place where we have
> *all* the devices available.
> 
> Doing it doing allocation means you get only one device.
>
> So, I'd imagine more like we allocate the MSI region during allocation
> for the device specific during allocation
> 
> But continue to enforce that every attached device also has its MSI
> region allocated.. Which probably just means checking that the
> driver's reported MSI address is the same as the address during
> allocation?

The idea here is to treat IOMMU_RESV_SW_MSI as a per-IOMMU thing
v.s. a per-device thing, because it's defined by SW for an IOMMU
that doesn't have a HW MSI window. In another word, devices don't
really matter, so long as we know which IOMMU that can be decided
by any "one device".

This is based on an enforcement that there won't be a case mixing
IOMMU_RESV_SW_MSI and IOMMU_RESV_MSI on a single IOMMU instance.

> > @@ -364,7 +305,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
> >  	}
> >  
> >  	if (hwpt_is_paging(hwpt)) {
> > -		rc = iommufd_hwpt_paging_attach(to_hwpt_paging(hwpt), idev);
> > +		rc = iopt_table_enforce_dev_resv_regions(
> > +				&to_hwpt_paging(hwpt)->ioas->iopt, idev->dev);
> >  		if (rc)
> >  			goto err_unlock;
> 
> And this seems kind of weird, shouldn't any change the ioas regions
> happen when the domain is joined to the ioas with the MSI mapping, not
> during attach?? Like we don't want any change of the IOAS to blow away
> the MSI region.

Hmm, not quite getting this part..

This doesn't change the current attach flow except moving that
IOMMU_RESV_SW_MSI from iopt_table_enforce_dev_resv_regions() to
the allocation routine, since other types of reserved regions
are still per-device. The unwra of iommufd_hwpt_paging_attach()
is a cleanup since we moved iommu_get_msi_cookie() away too.

> This should probably get selftest coverage as well, it seems easy
> enough to add to the mock iommu driver?

OK. I will try adding one. I assume we only need a reserved MSI
region in mock device and another testing ioctl verifying if it
is reserved in ioas/iopt upon an allocation?

Thanks
Nicolin
