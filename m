Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B081E877
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547686; cv=fail; b=snlXewSVLpo0fPY8RsqrTnInhbmXab/tUXTAWWHlf7yb/KL3b/RptQYU1ZABbQ0IgSoQmby44S5FtgAkuokxolR6aKlQumEQy6Fw8WYcXi8BqErcH7pMcw9b/NfqGnk1j3RUeE8or2mjbdDNHZs+fsj10xVMuBpvUS6/JEzp5w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547686; c=relaxed/simple;
	bh=TbYiDJw+G+cpt1OfsgNvd8mITawC4DKcp9COU9NThVo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9FuOKN3cDc8MRj5v3Pmm+K7/RNkpfTZaMNDT0iHfu1N7LaFFwdwUQgBjF8spLXDNkeBB+eq/bC07EjFYvVT2tmAGi1uAmosWpE5yBw0C4VPPGlIQTdMRxv/XwGmNfQdYOM7FSRTkLqKMXW541HdB3fzHkynRxk0JTuhpatd8VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TvPXbEGD; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TvPXbEGD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/y4UBxC8qBDK7940Sa26LVpgl4QQ4BN6CP1PWLoshLNiwB/NAT4YS29ZsuKRjyQF/8bOMBxbR+zTmpGDfMoh3BCP9JjAvLyjpA8f7cEswftskNQrEzlsN5cAUMHS4vAucoz7bHt6M7AYl4EDgc59nmttwVGvMZeGlGEBW6BfWl5x3yRIikdrbE8uX+TtpgsW1LKoRVvpRtxbdnaYmpkX2m3PjZJg4SN3lPWHcaH7ZNPgOeS7MMlNI0b9cOr6wsInTbD8sjf17clLuexF008Dx9KB9LIR9vdwkrL6w0s3r4VjL2I/XjDqqnwfdYWs1NvMuaxg/kI9GYo+mdt+4rPAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3HUe2wIc8l0986Jk1fmLjaeSPYLdkcSwp1U90DXovE=;
 b=OdfYy2klyWTbnSGlw5JNPIrW1Mvc1bF01uNEIDtpssv4fxX4XPTt45NVvyZcU7i3Xt12w1b7iSl+R8tC0cozEsRpn+alDY2lsbaYk1ll5d1tgM1l3409EEei8tQ3aVpcDwp2IyA4nnzXc81mVqz+uAJ4ztcXVASJzQnbgWyO7VWnQj2v0hB1phAXl38M4uyoIC/mtXZQn5ECjoxfxzuvYXMbHE3wJaGJzCxFQy6Ieslg4KvsUFeHXrTq0LcA8GlgOMdGp2yIBaTg3eW7TmhdoviHz6NTuI6pQijG8bSynyw36DFDir+WNLRSaDO84N2HqklwYq4sBhFS52CcDhLGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3HUe2wIc8l0986Jk1fmLjaeSPYLdkcSwp1U90DXovE=;
 b=TvPXbEGDEVIfrcK2kTzCevDnvPGi73mX61ayNkQ42HFypUsnLpl6cDc/lo8LLt5M/Oj1SPUV+BjLxu9wisc/aLPG2Yjjok8+X9lbn8RDEixZVkBGFjzIBdUOAH+75s+P9ANns/BXFDO/+vcWS0qj58LrNhqOTWt4WaYXeqC+Zg+KOvhH2wYsZKRaENFwJ4kuwjydWDOxDuOmBtojngi7R57FL1YDv4b3JkbBoHxxeoIxfItG9gzvlnIMRb6hB3wcnfMsKA6RV2PjOzq56Tl2LrFWw1SIPa8/lRRJG3krY05pQMyL0lsYjOeGeQB7kZL0RDaD/rx3Sef7Rzvd48RXHA==
Received: from BYAPR08CA0040.namprd08.prod.outlook.com (2603:10b6:a03:117::17)
 by SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 21:01:20 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::4e) by BYAPR08CA0040.outlook.office365.com
 (2603:10b6:a03:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 21:01:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 21:01:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 14:01:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 14:01:05 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 14:01:02 -0700
Date: Sun, 12 May 2024 14:00:59 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZkEuC+EN1BzGzSg6@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <9cf877a464c359b44e87b375bdf2962d2670f0e2.1715147377.git.nicolinc@nvidia.com>
 <ZkDmSe5XPTbMb+q2@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDmSe5XPTbMb+q2@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: d225ea60-cb5c-4b09-fb02-08dc72c6ac63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KjsME56UGY75jwfFRj7t0xATantJt4RMIqOECklzkm+Yy9BVxjf14yYY9bu6?=
 =?us-ascii?Q?RwNx+FTTxmPZuEtovg+9qFxpkJwA7pDir7Z5RSN2s/TOEWiRjMLbwga1YkUy?=
 =?us-ascii?Q?d6ypPbLzLimnvSyj4vCF+7WaqbKtAFBp8SMLAGYIhmOVUS5O4I4Sn3GwWSOX?=
 =?us-ascii?Q?O96jAkuXUtVNPLgwYZ4Jcgofj3rOF1H75eppP0oDw9Dz5stsPwWqRAfCYrxi?=
 =?us-ascii?Q?MCmDUEBrozXZzT4tuk7a51hS40tosGxKy5+bRnUwCdI67yP3H6SJWef/Vql9?=
 =?us-ascii?Q?h01kznOKU0Xj5mhnsxqUMtezFtl0XhbV7SFtwR18y9o4XYV0fbNciMTRNzq9?=
 =?us-ascii?Q?BvYhzsx5IjJ6s50kgGvRmcRum+YswvCwwb7/pg7RiFxl157Nj6NssQW0Vj3/?=
 =?us-ascii?Q?s+Ah1Y8/sPBSjVeWteRtiXeD5XijoExiVXojPVIOzE1XJ8xecKbDUCuUm9o+?=
 =?us-ascii?Q?l9ASwzw4M239MfupMYuOBDad8Gy4B7zp7GY8wRL9DGbDhl02dBjjdoBII0TH?=
 =?us-ascii?Q?/FpR3cSWh8tv9d14JeiAwduyikVUolo8cHPsaePybNrYi2gc3q3Uzyr8CcqQ?=
 =?us-ascii?Q?rGSQwB4owqK018i3UM6+5zRzQibPYNyRGe+YmadK/UEXAyqHvNlG839tS5q2?=
 =?us-ascii?Q?BLhXAMUwHc+69xYnvG83tmXNVt+OKSH4vc2PVWs/VpxqhPXWncAyM4XTzbBX?=
 =?us-ascii?Q?KYgSqMfTVWevt9+ogJZG+FYst5CxYj800n27QV92HO8EdF1d24NHLYAFndnl?=
 =?us-ascii?Q?vGt4iDCmXWIXYEK7bI4R5ZRo0oveJ1p4XJ2RvSwKywROt7pA2cgjVyNBFfEe?=
 =?us-ascii?Q?TzlnJ2udakADWZPtsH25i+557qQpDXYDVF7P3dN0i8mpJBYanJJtQOaeNXkK?=
 =?us-ascii?Q?GgxDPcx6KQH3pVM9kNsZduMqTozT3dzKqLlgdgvFfj3aLuvsMD9WsapLjYPL?=
 =?us-ascii?Q?jcCB2R3OvN8qSknEWf0vBb529LIq+Hotq1efRMS/IFgs64PBNI4YlIWHLUrm?=
 =?us-ascii?Q?BdzUi6+hMYPdvEGm4gQZY+2msj+Hl22BCWxh/tzE58XQEdszsOEfNQTxb3Kn?=
 =?us-ascii?Q?YEN5BXZgKTs+Aq9iOUmS6Kd/zF7ntBCcONQynK51+MfaPJAEroM9TOQltQqu?=
 =?us-ascii?Q?B4Nycepl6p/pgrQjCZRo0QStDRdq2/GsncREKOanhFXx1KHymOpemHgxadoe?=
 =?us-ascii?Q?jDXHWHmIcU0YPcszmmrbhsyes9jNInmjdbmFYujXspxt8AMgdhMkxHpV+OON?=
 =?us-ascii?Q?yH6cJIeQKTDF0/GixPspFRuzQsSSuX1B7yZCyQ4uc5lqJot3smamSW6PjXoU?=
 =?us-ascii?Q?XSO54lb6EfAjv/2jFT1uUe2F7MRoXlcuIOGWWjHQeFb3TKDLlQgE9bBn04MT?=
 =?us-ascii?Q?fqN3laY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 21:01:20.0779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d225ea60-cb5c-4b09-fb02-08dc72c6ac63
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On Sun, May 12, 2024 at 12:54:49PM -0300, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 10:56:53PM -0700, Nicolin Chen wrote:
> > +#define vcmdq_page1_readl(_vcmdq, reg) \
> > +	readl((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_readl_relaxed(_vcmdq, reg) \
> > +	readl_relaxed((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_readq_relaxed(_vcmdq, reg) \
> > +	readq_relaxed((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_writel(_vcmdq, val, reg) \
> > +	writel((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_writel_relaxed(_vcmdq, val, reg) \
> > +	writel_relaxed((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_writeq(_vcmdq, val, reg) \
> > +	writeq((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> > +#define vcmdq_page1_writeq_relaxed(_vcmdq, val, reg) \
> > +	writeq_relaxed((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> 
> These still need to be trimmed to only the ones being used. I still
> think it is a bad idea, maybe a middle ground is to wrapper the
> regsiter coding
> 
> writeq_relaxed(val, REG_CMDQ_PAGE1(vcmdq, XXX));
> 
> Is still short enough and safe enough without creating so much obfuscation..

I think that is a much better practice! Let me try with it.

Thanks!
Nicolin
