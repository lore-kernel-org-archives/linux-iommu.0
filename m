Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116026B775;
	Tue,  1 Jul 2025 15:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751385524; cv=fail; b=aDGuKl88M8bpGTmRqTqnLp3NcEYlCYxmwOkboWWM7fNZy06CakVC9fbixzK/ZV5sFOjv8tevQXGS4y3bVi/XgIFupTTpuGcVSaDSjabmfdpjDxZsBT6vY3TREgdQmW6U43B3RrQSEnP3ON9+975Stmrqls7H6sNWCFdcAE7AGvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751385524; c=relaxed/simple;
	bh=u9RPd/dJlUSH4tQHtMpAGm5a28cq1ZtHk02w3uT+A54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roNjZY8IoJdxj/+Ecy0ln3CGe4Ys2kF9vDz8RtusnNohfGa4VrdbWQOlhvS7Mffv8pFCYdglR2i7NtMlrixKnyKE0XYi9afSCVsopSOz8OXrSPu8Z4KegLrPVxpbx6C57EnDvQDufYyITxXMscIh1UUnSLopOwDeiscAV4QOt8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ELiyKiP0; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ELiyKiP0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcbFFcuC6OzNbtJYuRibnTTYByWneS+geXap9HwT6+ZM7jSLdiAkFdxiebcnyPBQkpVMXa7fJ8PMRQdv1U1r2k8p7LuPU/ew7VCCMxBW1c7zXM7pJJj93o5sIr8Cu2xTsTEJ0VgxNsF2ExM1am2uKIDidwDzvvt394X0x73+XqYS+b6wpmbHM9KWAnD8BjD56cPVhcx59L4Lf8fcQ0MgMqSDiEUDbnE4aP+twDEw9CM48wLCcUqBG0ka9T3mibFh0X3ms8Fr3XT4i5sM3JcjAgAHTIvcQA2n/z1DZ/WdcPO0/p9nC8ajHavRtYpu/fhPFb0mUZX7xce+akHH+BMZmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBx+E7bmd+xXi/LhfBvDE+2XnYAIQEm91hUQviAxHf4=;
 b=Lz0C8VH+Ku52UlzFBGH+L2a0Tyo7hgq/l48C8/cJPnNN08+yyW2AbHDLbeTtxDPgN98IUUiC5yHB8imn+XG1E1aqOlEJalMp4DXARcPiZoYLGrks2217LJ6JHUykuyQHy6hFexHe2N/COUTEBJuaTp7YLj6+xK2e9FteR5osGTtXaAP07wKIJolfugpIKU3Z9k4h51VkRaXiSiAh+Rr4zSnaIu++VGP9OXqGdkdpPpLqmOmta3EOUocydhQbDx+zj8z270QUku37nWI9+L0jxc9xHGVa81+UOIFN/8I6npZzO3CRR9c2H9AppYk0o38qHEQuhE+zSL3GhWu6g2gs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yBx+E7bmd+xXi/LhfBvDE+2XnYAIQEm91hUQviAxHf4=;
 b=ELiyKiP0QBfeUO72HBCQoVH2pvvm41pZLjZ9CZHykbrhWxwYRYkdiNXwyz/pHGKsVJ+KLDVBXcSV+zs+lXvPyOJEissBNBOFyD9MHzWmG3E4ofrajQ+XB1rOyJP0Wl2sYwFDTlPyL0qLsEfEIXsVuPm12Odj+NxbNxLFXoMl1X96nh3P6DPGA76eDs/Y8W7pk4JSy97Z5C4a/VvGZqJO1ClRUa+S7pUy7bR0N5fz2xV7snLPTqgcrYzXUomlGS6MmuHIqmhRiUMhSiQfknPxKqmNtg3mFGdy9hkw2C0DMOPJR2k4Z1JIy3niE8eoMtfp8owEizbO5WRCU6x9K2JqRg==
Received: from BYAPR04CA0036.namprd04.prod.outlook.com (2603:10b6:a03:40::49)
 by PH7PR12MB6468.namprd12.prod.outlook.com (2603:10b6:510:1f4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Tue, 1 Jul
 2025 15:58:39 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::b3) by BYAPR04CA0036.outlook.office365.com
 (2603:10b6:a03:40::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Tue,
 1 Jul 2025 15:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 15:58:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Jul 2025
 08:58:21 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 1 Jul
 2025 08:58:20 -0700
Date: Tue, 1 Jul 2025 18:58:10 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Ben Copeland <ben.copeland@linaro.org>,
	<linux-kernel@vger.kernel.org>, <lkft-triage@lists.linaro.org>,
	<regressions@lists.linux.dev>, <linux-nvme@lists.infradead.org>, "Dan
 Carpenter" <dan.carpenter@linaro.org>, <axboe@kernel.dk>, <sagi@grimberg.me>,
	<iommu@lists.linux.dev>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion
 after 06cae0e3f61c
Message-ID: <20250701155810.GE6278@unreal>
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de>
 <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250701132936.GA18807@lst.de>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|PH7PR12MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8dcf32-8b62-4c5a-415f-08ddb8b823d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+0w7qzYCFJBAJz6hmjTzbnxu6yEGtc3YeH48TloZJ0476Ytdd+gca69xJLs?=
 =?us-ascii?Q?TFNXpKoNb5cqXmmj5lRQmOYl9ARcelpPJmUUrx/YVJEfLiotGaW53M+OajK1?=
 =?us-ascii?Q?EmITYjh+zOmCpEb8NXdlU2W097AvNh10ePG/ezOm0EzkXeUpNUmoSenKuyKd?=
 =?us-ascii?Q?dtc+bPOT4UeiFz6YRhTu3L0lbeGrshpbeW9T3UR9v3wwAQeclEVJu5VBAvtM?=
 =?us-ascii?Q?hQ9WXUdXDPUEM6Mhp2RLxzNiQCi1BWZimULMxyoEDmhhAeHsby2k/hxOknby?=
 =?us-ascii?Q?SNjR8qRbdwvJnsVaGKXT5HemkjOgQEu7XyfaOcJNTg0+twBQOErIcPKOmpJE?=
 =?us-ascii?Q?TORyJHQr4zPtWiit3iO5iMiulaFjT7ausRsB/Jq0iJHvr4NurFrjieoapEF5?=
 =?us-ascii?Q?PbTPMjxVm7S9WjQ0/0K8jqW5ffGqw7/nYtDaUiAs4qDdussyQHWZzO1ja6c/?=
 =?us-ascii?Q?x39iHT/gJKGQdmJM59bA4vXfhGF+4F+2zcOdu8Adp9di8/zTG75hqzPOaKWe?=
 =?us-ascii?Q?lqomQ52F5wcYk8n+ewBwdwo3R0OLve9jZhby3tu5Q63E+IArYXvrtyalok3S?=
 =?us-ascii?Q?QByqvOK8LulJmfeLHquuCT+qLDDQW8C1UGuOpD0XGAXIxNVNbk8bC+Jr1alF?=
 =?us-ascii?Q?8K38cZp6qmIamwvlkgo0Tf0fI9EjJanY5SAO+O9FlnAJPWPFfJ+BCrFBPZVK?=
 =?us-ascii?Q?aPSGId9aWKV1Q4pi3INtdGahHWu7Ih9uyxxcQIhKZ6Aj/sST4jgl7kvmIdQY?=
 =?us-ascii?Q?WgX/iAIPwBR/4ZvmdGEmR4xbX4G1X19uc+LVwN7GmltRPe+PwxFUOtjkFqzS?=
 =?us-ascii?Q?/Hre/INQ+by/VtvCLMdpWCju6TkzuPRHwiYRipXtgouImR2oUlIMCeDLnzzB?=
 =?us-ascii?Q?ENmyr7F5mSanYE0a+DjqhUGh/yPBzWGypJRFlVaoe4aaTNWCwqdRXB4QdfLT?=
 =?us-ascii?Q?wUQjaliqUORIzO9avsj37xom94gZRnz5USTR6vA6JMgsQMLawHcsXWnr2OQ6?=
 =?us-ascii?Q?gDlRQ51hr/dRYk+xpcyiX6Licn+a7dOclCYkwGGOwLJn0L0aLeqqClGsZWrn?=
 =?us-ascii?Q?v5ltdw9RcDLLvSl7B7AS+vSpes0G90ShfJILqeFNKg0oQQXKPZx45OOy2dG4?=
 =?us-ascii?Q?NSFo33fxJRFfrtGNAXTyL98nmwHKuTC8dwpeZBgBzDHNvONEbpSSa91H832X?=
 =?us-ascii?Q?3RVsIj23IZhxCFHhznEScOn992lHhLfJvfYQ9DUT8TRK2JrfdRGCzr7fHeP4?=
 =?us-ascii?Q?Yx493BLtpc37APjqm1HDlGStBvEDrDFk9Z3nZhWIA1gusjaft/Shm0mWT4oI?=
 =?us-ascii?Q?oJbQvEF8dPKH6XAwB68aKzJt05nLap9F9/5TRMcFIqLIbx08NtqoEXPPClLO?=
 =?us-ascii?Q?ZFqzkKmTKahrhcO/819QnqrJ65Ce7FWteMGkUVftgMW25Da1D/AMebCgyVTF?=
 =?us-ascii?Q?zCXojeZeUvzouP0zWnjOB3pv9Jk/LjMBBdWurcG5vfeDfDezRbf1YPXPrWKP?=
 =?us-ascii?Q?Yc2VKAU+ilCETO33DcvEpq5joSLGEuljFcs0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:58:37.0604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8dcf32-8b62-4c5a-415f-08ddb8b823d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6468

On Tue, Jul 01, 2025 at 03:29:36PM +0200, Christoph Hellwig wrote:
> On Mon, Jun 30, 2025 at 02:25:23PM -0600, Keith Busch wrote:
> > I think the PRP handling is broken. At the very least, handling the last
> > element is wrong if it appears at the end of the list, so I think we
> > need something like this:
> 
> Yeah.
> 
> > But even that, the PRP setup doesn't match the teardown. We're calling
> > dma_map_page() on each PRP even if consecutive PRP's came from the same
> > dma mapping segment. So even if it had been coalesced, but if the device
> > doesn't support SGLs, then it would use the prp unmap path.
> 
> Yes, that's broken, and I remember fixing it before.  A little digging
> shows that my fixes disappeared between the oct 30 version of Leon's
> dma-split branch and the latest one somewhere.

Oct, 30 belongs to RFC/first version of patches.

Thanks
