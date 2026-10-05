Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011029.outbound.protection.outlook.com [52.101.57.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609A37F333
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 08:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187476; cv=fail; b=PNNn4qd0xjN1v5Ga49TzQoaQxssAJRlo8gamAqE33psMV3k2QH3icNOrVhopZKKQKAlk3Hvk8ZTJLf6JW70aF7fjXRj5fcchEMb5PiYVHWmo317iUWz0fAEwtCdHEpsEhwovgXdVdQEPEPxD3n61sHEi07c20XqQuK+DoxsJdbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187476; c=relaxed/simple;
	bh=zrX/LrXH9AN1O8cl5R8FjwejKseBrNn37CbUokDDZnQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLHcxcDChPNRvkG1YCKkungAmkZ+z/9wBNRvvtf2s74VoDNEZApthQlirwNdW7J/6jTXuEcstl4RhbXWZiSkqtcUrDdTkKeLQZQMTzjDB+2bTHJbMTYKNZ/Nht3SHTCFAp3Zg1339SRM8eqVwbFsfqJ+gENrPfiCutuAU2N9jlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VJvcVdZo; arc=fail smtp.client-ip=52.101.57.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VJvcVdZo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rycMyIwcJhwr1i9tKpigTT+gF30xGLNiu3akbNPLPk235reH/gm6gCW/f2EHSqq1lnFEolOR3yd6QbiPSadTM0X6lA/oSJNg8QTBoSL0rMY7q9sOM1auL8xy0mo7wmNWP5DLNTJW5+NBfL0UeRYvjdlhq8HK9pfLYLL3Ue5BkAcddGmZbjzJj6PGDetXTYoA5bmD/h+QfufewsjvxweVxcO8H01kaGkr4uZMTl+E8tezBcL/h2NeXOQrrAkPXnHhrid5NoY/lvR2X8yBldVxRr3GuTfRIOAxgkE7Tnt+9VfNPwfl6nYnzRVHaCpLxW+FraTPNteJiDTJ18thkU+gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQz8/7jYTlHKAWffAYjvWg0CyoS3MV+rOVYD4VncWd4=;
 b=Z1mFDoLZyzJGDMIBFjAAF8nCBiYuHUoBUWPavhzjFEAj1otT7N0r1twJzr91AecGgLPsiBv5zPHC+ONvoAPzeQZHe8w1fzpIEwViDQnBt+Q1mESs+jFIZEtji67FOiGQRhDuYS8LDpNb/gzd+VMJh+QRzi2XpqkNIy8cZHnIa76pxdWW8Nastmsr7nWmLuZ0SGz26Rpbvo/lch/OwdzH13xfBQli4D1sUQQmxLTiynZ0sxAQYEgq/KkqmEfIDn/UYi9eTzsxaQWFzL0QH0NqqQiwtbpqMWvH+oe2qnfmpPX5Rt1EYGWr2v97Vv2uHSscx8q+GGevVCLqH7k1CXVBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQz8/7jYTlHKAWffAYjvWg0CyoS3MV+rOVYD4VncWd4=;
 b=VJvcVdZokBpWrqB7Z/y6JOfZcFmkn9T736pJGqoAzubCA5Kw3Kez2SHzJbj7UHBiYcgJpVIp8m36+zJ9iy9L/NH5aI/CSgl5sdlaVum3XevvFyWXUutYseSg7KvejrO6DCjpnDtiVhwCH8tUHeeLkgeKEBTegwT1RCHLReklFWR3jbnoI8tFNHrJ6ZbTRS0vFroQ43tIF9UFXtMtIEQz8j0T++eUY1JpMNoRcTid0Fl+aEmw8WrR7LVd9LXCqYwgUYDmFlArG5u0RwT0whj8Ke+Fcdud+jhPZVCz5S+JeXFMaha4ozzZToaXdcAbuDLRXnpIxeycL27iNT7tP+KKBg==
Received: from BN9PR03CA0402.namprd03.prod.outlook.com (2603:10b6:408:111::17)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 08:04:27 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::8c) by BN9PR03CA0402.outlook.office365.com
 (2603:10b6:408:111::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 08:04:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 08:04:26 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:04:05 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:04:04 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 01:04:03 -0700
Date: Mon, 5 Oct 2026 01:04:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Jason Gunthorpe <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: Re: [PATCH v10 06/13] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <asNZ8HnRQnzIO9nZ@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <d661395d986d3aa78af200f55e43740996ee8a0f.1788130528.git.nicolinc@nvidia.com>
 <asJTsw-oWDlSqNa3@willie-the-truck>
 <20261004163501.GB4064@nvidia.com>
 <asK+GIWzXjwN3EaB@nvidia.com>
 <asNE8YMbOUq0sncP@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asNE8YMbOUq0sncP@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: e3797b03-080d-487f-1971-08df22b74693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7416014|23010399003|56012099006|10067099003|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	C6pa6KPUQqUy43BmWx15JrTYI5NFUvW94ESBwApvapnUIqLCRwAgvxlyQ73ci7JXJQLUAWsm5dIbY9UtrwnRMW6DWyS4ZB4yravaXUsD43zV+qLZfB4Za5Ho5ZMFwQXWwLR4zEkQGU1DonCoYSrmAG1g+NB++E+UBfc4fErrc7w6grbAeM9w7jTXbde5F3j4mkI933WRTIRhks2sUpYiDqaHJ4OAD2+ebRooddimkv89Gjup4Bbt7WYtwr0DTw/5/VJASItpcqw5wKIG/iSs7wF5Dqtec0neDrJRMYaieJExGKEUOrasC47uuUJn2rvtr3YjeCVfORpxgfSEAVZ8cR0l/3+Rmd1UKYB3710LJZBTqGi0nyCzcVYyNmZDAu5hOgU0aL3MOeiFXMcTmmsGvI29spB5aGEGJ+K1FrhlbTXsf0ZNLm57CPC0+ryrg+aoHo0fJQcF4rLtEX1CyE1bmQ0wwMuIApRb1Cn3WlzPyvMryhZ7GlKFfBpkK8axdNYN9ogd4uNrhrhVECb6ztiSjoVcNC1ohn4K+YYOQFxSGDXN/ZM/AfHMsazEktIBYCFbT1sSGP1jn3svMveIyBFCYnICK3A1s9Wa4PZBq/NGSgzliA9i6ujnD9IeBhQ5umIxyzmE/zRaPkm+GrYOFxMCWUIQhwE+XURhJoLeOujifNDGy8uNSFmgrd4PWi3+LWR0Q0IiMg0VjDDAKpUhDCGYjg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7416014)(23010399003)(56012099006)(10067099003)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jWXtnhrMv18w7uCYpPbDVe883/Ida1DCb9BIen+GUV5U9A54bh7xp8YsWWDiZ2WhBKBL6PoYfatwQlWdoxIIFPCeHx0w71ZfU+jpQcrrPBw+5Fmg55K5Rsr8ey/N1DpPCWxhLuRAgHx7p3zIrKejvtEm5iVph5gUWUCTYavDJSvn/o4u5C+leL7xqLVmTcn2tUs2ZuZHxCRbW0+VHbHfff0+d3TLfEcL7rALjFtWdq6UrEVb/j2ENrTyepzC+XaYI3IxgkW1jdnzAw5O/5P1o61juTRYYEHoOWIHQfpOivTfNmJQs8qGYKJgV0uHAL7wV1uYVsJya2Bh/my6N2kI6xQMSCLX42AkP/PAWtLaVDHWYYrGb2tfsk++8uOiwrGtc0AcQ5pHE0PzGqeQdQ7FW7CQvexSj+SPEbJWA2QREQIyA26wO7nnzIv7mz5cmvNo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 08:04:26.6434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3797b03-080d-487f-1971-08df22b74693
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

On Mon, Oct 05, 2026 at 07:34:25AM +0100, Will Deacon wrote:
> On Sun, Oct 04, 2026 at 01:59:04PM -0700, Nicolin Chen wrote:
> > On Sun, Oct 04, 2026 at 01:35:01PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Oct 04, 2026 at 02:25:07PM +0100, Will Deacon wrote:
> > > > > + *  - A structural inconsistency at adoption time tosses the entire adoption and
> > > > > + *    makes the SMMU fall back to a full reset blocking in-flight DMAs.
> > > > > + *  - L2 stream tables are adopted lazily at master-inserting time, to bound the
> > > > > + *    peak memory use against a corrupted L1 table; any lazy L2 adoption failure
> > > > > + *    rejects that device alone, as its blast radius is bounded to the bus.
> > > > > + *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
> > > > > + *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
> > > > > + *    the real hardware. Callers of these functions are responsible for gating
> > > > > + *    ARM_SMMU_FEAT_COHERENCY once during the probe.
> > > > 
> > > > This is an artificial restriction and not one that I'm wild about for kdump:
> > > > we should be able to support this for non-coherent SMMUs as well. Is there
> > > > anything more to it than using MEMREMAP_WC in that case?
> > >  
> > > I've forgotten why it ended up like this, it was some complication
> > > that seemed hard.. MEMREMAP_WC is not the same attribute dma coherent
> > > would have used, I'm not sure we have the right stuff to be able to
> > > flush any write combining buffer? I'm nervous about that at least.
> > > 
> > > Remember this is not just reading it but it has to operate like this
> > > after the fact. In handover you wanted to use the dma cohernent
> > > preservation.
> > > 
> > > So, I think this restriction is mostly a lack of the right MEMREMAP
> > > flag? It is not insovlable just work outside the scope of this series.
> > 
> > I agree that it's safer to defer that to a followup series. It
> > also needs someone who has a non-coherent HW for a full test.
> > 
> > On the other hand, this series is tested by folks from multiple
> > organizations, so it's really a needed and verified one.
> 
> I wasn't disputing that, though. I'm saying that it's half finished
> without the non-coherent part, so I'd like to understand what's needed
> to add that. Can you please explain what is needed beyond using
> MEMREMAP_WC? That maps to Normal-NC on arm64, just like the DMA API does.

I am not aware of anything beyond MEMREMAP_WC.

It should likely need a helper to select flag:
  ARM_SMMU_FEAT_COHERENCY ? MEMREMAP_WB : MEMREMAP_WC
and a verification on a non-coherent SMMU.

Thanks
Nicolin
