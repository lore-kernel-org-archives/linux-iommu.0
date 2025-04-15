Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A134C231A32
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743175; cv=fail; b=okwiFcWeL4Aw6/xw9oyTEtDEfXXVJfxjcWIQi+31As6NNdajvSTsz6szNwY20rg/eUX6TbAJLRnua14ft+g8diDz0lfxX26eS8/d+S7bkBQIFoWuwi5WA7WOhxkxX112RKUY6j8YLasImvhWA+TVcgIFvqhG/qaniaOSm54UNI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743175; c=relaxed/simple;
	bh=uWCqhyOyPcwaUjbjfSkpSnaLAC3agPJ1R3p0J2WzO70=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urMrjP8nTHVOvow+Z+TV3kg/F/k+Hrs2mcHOH/QKFJ4BpC3omf1ur0sk2nHn6L4O72S41GGFFAc4u6SFbHUfxqemcbAyHc85K1PveFNrCR6XfLCDKmufDtwh2R/lIQ5BywRdO7t5JJ3XT6IO2Lw4pqt0M2TetN1XKtwdUjSsHho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J5G+Pd3n; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J5G+Pd3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqLs5Bf2UTKQsTE9dodsNH5W0c3Aw3U4v1EpvuQVzOcgoJKPnU0OU7JCgLCR6ONFtgAuIpoq3UrkFuSHUOWeUMXXv7YYoNSrOVycmZIIiCNuCoBtiwiaRP8MrMNa88w2+KTSrxnJHWPPYgHVEUdBmYOVz3NpdJHI4BNGSMg8ZNTeMZzaGe/alJiXJN4rn1mtr1VtCzFV4sEi3DWsWRFCRGRzY3LPkbPdCqltd+iOAel/YUuI087ogMtI/E/heimvgPsb+mLZTdZfEVothuEd/o1Zj/TUI/nZQgmOLewZdJ9s9zaacJ4SaFTyICeIVp9aBHwm3pHpmnzmQVJHhjEd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6AgN0kQGzAWb5qOKdrafS50wAAOEzdiMsH56Sri9jI=;
 b=SOMrjrCSiMjta+1MXJ/m1SD81H+RPu43C/KsrLFEtSchSrQG/Dur3JYU5SdMTOt3CPDOEz9p/3GTdQKCiG36vW2Lz18WrQYeoETSxTjWqSaMQkZ80P/BqqF9+2ii57oQ6yXGlrptgls4uti65cubxS+FVsq0zEMgFzCSua0HiD1yeki9M3Biecv7CxX+sVvsHTeTCcjqtbg/jdQ1tKLQbQ6E4L5a/7GMQONSdEm8dwLPFjJ6rN4wvds2x1MmWe5Zs/6qP++g7iainCoVou4Hg4FnqNxn/I3TX5XdEPdZYEa7yBDQqEFVF7PoTdAmIvTCmRp42qz18+hVHt7ufBPN9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6AgN0kQGzAWb5qOKdrafS50wAAOEzdiMsH56Sri9jI=;
 b=J5G+Pd3nLW41n/ap+4L7fp44cXTdI08wI0EgmNRPqJnD+h2YrMtNuaty5dZYskBgHtdNFLcbwpI7bMn4sFPh2gCCrodT5O7XwDuPCgVDKTgTA+S+I/aZlesuC3N/6Gl0t93I4qXzjt3yRWvEoYjUH3OB5t+YhXvca30wRIhf9Y6/dgbqWpkr122YOEBHM3ZaBuJPEoPEPixoFeLy+XLnNCFlnIBnGSx8bYy5Sx/F2KLPNQGbn0xTcKdC6QdpXY1t9zR9xzkp4wgzLjUQSwOKIKZY/Jn0bedEgkeFVLzNATNBLaOon+/mEB/deEbeUEaUOWjsRTSTWn3klCZ1v8TLmw==
Received: from BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 18:52:49 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::97) by BLAPR03CA0112.outlook.office365.com
 (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.15 via Frontend Transport; Tue,
 15 Apr 2025 18:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 18:52:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 11:52:38 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 11:52:37 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Apr 2025 11:52:36 -0700
Date: Tue, 15 Apr 2025 11:52:35 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jsnitsel@redhat.com>, <kevin.tian@intel.com>, <praan@google.com>,
	<zhukeqian1@huawei.com>, <Jonathan.Cameron@huawei.com>,
	<jean-philippe@linaro.org>, <eric.auger@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix iommu_device_probe bug due to
 duplicated stream ids
Message-ID: <Z/6q8xiqAsyFhzlp@Asurada-Nvidia>
References: <20250412180658.439499-1-nicolinc@nvidia.com>
 <20250415132401.GC517881@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415132401.GC517881@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: a217ceb3-83c7-4ac4-428f-08dd7c4eb806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u7dgqfsVcORPe3ka4/xFISuKw5q30kM2Kl2XRBeXIjqt/4GkQex/m50eFvkh?=
 =?us-ascii?Q?qrXl7RVd3T6xBa/JbMb3oxvimAqRFghy0IrMcSVVUI7g7TuqJ9guu00XZZU2?=
 =?us-ascii?Q?ErRtADypeFXdTO6LbD/hLBKTpSMEdWcKo04lYjK2S5xEnK7nQ2OzGF9auBkg?=
 =?us-ascii?Q?+tl7qXk2lelszoaQVITepV6fKvssYROgYXN6K93qfmzlST0L+YspZxDBXuoA?=
 =?us-ascii?Q?eomR0y+WRBhel92MBS8jxCbH5fcCnvrWIYgMHkTgb2+PiTYB90ltDJjqnq/u?=
 =?us-ascii?Q?z2hslpRGKNiCARwejCcv4uTohHeOnlZEevAX2WXR+afHhO0URC73cpLL+kO7?=
 =?us-ascii?Q?cZyst6Ghjodop8vQi7TRjjseBMWNcdhxm5RqZQQ30jPVywFjmgbBbmcVFdYX?=
 =?us-ascii?Q?ZKMtiwFPdVt0RKG8x6341gtQAk4iXaqtQSI/gQ3zBk1gXwOGo2Y86zwfAEwh?=
 =?us-ascii?Q?Jy01FTohdd5uIAy1jtNGYNqkYTX57zVo2OUXj3aA5qDdUqixL+FNh1aigx9I?=
 =?us-ascii?Q?/gG10R4lLOgPzWFl1aTD0gHbEWfG/WoESvpPgYRKcLkVzDLtMXJ9QRMGa/dc?=
 =?us-ascii?Q?VbptdelgMwQuQecaM9YoaIjzpgNXPT670TFa27gwGGcDFZ1uHYMDHFoF1DMG?=
 =?us-ascii?Q?8ZY0+HmP6Kgg89ZNqgykNWqWvyxcqcslBlLzU8XIUCF5D3T2eJ+eC8GcIAcW?=
 =?us-ascii?Q?He0XfO31g8T5kDgJDocp26mSpEERMVZAx4O3Yl3Xh8Ld+wM5iONz6WAhOmks?=
 =?us-ascii?Q?cGN9RSZ6GeePVa8WbSeg95nf0OxZ+BVy6W7fKZo4p8+QqcFVroFV3NeLt4AD?=
 =?us-ascii?Q?EEcb3wmlKxZhkB8kQS58Z8FcNcoaoO6jd+Y7jHVkXG/8RBi4OeAb1VNGQROE?=
 =?us-ascii?Q?Jx2G+8DgVtKdcalbwQxkfTLz5I6rjIVvOlx0dpJhdamqalfbp8f0/iwZkNUu?=
 =?us-ascii?Q?PnUDPHCxVUYOjlqDyDEZnv20DrK9Ky0vNV3fJu5zQ+4phROUu9/hzbpyaeov?=
 =?us-ascii?Q?m/oRnQALY7WPU5f5cnk865ipAQa4mIXbQeyvuZ+M8oMrxEOwEOg5hhCgKawd?=
 =?us-ascii?Q?iuM1jv1v9wqHGX+7SzFeCa+dGIQ+ej6+7llGjaIVMjIWNQ1WR3fk3jcfJSR2?=
 =?us-ascii?Q?TxSWeJSD+0vKu8Xw9kxzQ7/ok2nwQUHSXNyxgR3S2slwn4Yao2HX8QB7tO8f?=
 =?us-ascii?Q?4vapM0ra/4kPTlLPdwRkSgzg6L3yXOv7I36Stk+AmijCxBZIcWQzYHS8gH04?=
 =?us-ascii?Q?IPVHDJzGaut3A8ymYdiDbCMYeEW7vSFTjRowN0rADIb+1mU6opJgtl07Re7Z?=
 =?us-ascii?Q?neo0OB83CHjR+7nY2oQFsgMrLeqnWw/uM4cb8FPtQmGEFNvQKXkb6XaX/E3S?=
 =?us-ascii?Q?omX26f4FDGgSf8NzAfqAwT9JG42u0HfStUuSWXna0Jln1/TlzPGpbTPrCtDN?=
 =?us-ascii?Q?rgStFcxhuVlo0OxUEz5+Ipxre4aRZMTwcH8tAT6S6Os8UMIhcMTtaB9Kv3hu?=
 =?us-ascii?Q?41Sgak1T8h1SKeNsF5+YJNtBqhIMoA/rJXWR?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 18:52:49.1471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a217ceb3-83c7-4ac4-428f-08dd7c4eb806
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

On Tue, Apr 15, 2025 at 10:24:01AM -0300, Jason Gunthorpe wrote:
> On Sat, Apr 12, 2025 at 11:06:58AM -0700, Nicolin Chen wrote:
> > ASPEED VGA card has two built-in devices:
> >  0008:06:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge (rev 06)
> >  0008:07:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED Graphics Family (rev 52)
> > 
> > Since SMMU driver had been already expecting a potential duplicated Stream
> > ID in arm_smmu_install_ste_for_dev(), change the arm_smmu_insert_master()
> > routine to ignore a duplicated ID from the fwspec->sids array as well.
> > 
> > Note: this has been failing the iommu_device_probe() since 2021, although a
> > recent iommu commit in v6.15-rc1 that moves iommu_device_probe() started to
> > fail the SMMU driver probe. Since nobody has cared about DMA Alias support,
> > leave that as it was but fix the fundamental iommu_device_probe() breakage.
> > 
> > Fixes: cdf315f907d4 ("iommu/arm-smmu-v3: Maintain a SID->device structure")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 19 +++++++++++++++----
> >  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> This should go to rc as it has become urgent with the probe
> reorder. Use [PATCH rc] to idicate this..

OK. Let me respin it for that highlight.

Thanks
Nicolin
