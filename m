Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDC53DD520
	for <iommu@lists.linux.dev>; Sun,  4 Oct 2026 20:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791145276; cv=fail; b=pwCMvpch7+cVmUwNnBxDNdeypqV67MHqPg35YYmwnMKtkY28RxAxwX8RO9Ryanqc5IghgOKgMdrRtKUMEuCIgEw/5+5bhKx3V95xWvel5cF99o0oxnZbAcax/EfgaijzJuxYUKhn8SbVN8+ksAgkXVpDr614nA4BqJ7OKANwh0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791145276; c=relaxed/simple;
	bh=FC/2ZXJAHKCmN3C1sif+P9jUbr03r+gc9Z9e4x8J1Xo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBJ0J5UyKkpbIG2UTQR7OM7bqUrz2fG+dPfHk/Acm5SGQCYQoQg/U90CJE5IztqRxNcXtH9KJUb7r05TUBDZAU/XDYN1vIVzGYktKttjWkq2raiKWEaA8kIbe5tbWvM0R6Qg6QdBMvq1Lg2qtMEuJeqgnjYnIrSvOoAQKj0PGro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UU+CFVso; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UU+CFVso"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZP7RUSazbUCYQc8vlpeeeUeb+JmiWZavI9Ir+czWNn3MazRuB0rHUdxtWSkXbnNhBnrJDSkGXsd5grxQ2HflYRPKBstEILYp47AY6k2Cdr4oXOTbg6m35dAqVLX4duZWiJ6ptBOPVLbbuiJFi5yFQ1FrNrTFGw6p3sSL3pgpuJCg2imWNbsehTZ+LnKfNuQtGhwzgo1X98WFWXpkLfPGGgG56Xah/2hU6gaMjbr3JKQpdoELje7u/ycKTbXSCEslCU7t4ag6oN0QWXB8Avu6Q5CVwO/54tn7HlG1+m29XPZCuhhVU549ZCYTX5UycIsCDbA66ulqfrsI66X/+B1ZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gnvjIoBpiVa0v/G9CktuetqHt5VDy4vQhVI5IaYGwlk=;
 b=dfCJ5o14OP6p6GG20rsFO1kGy+JUeWU3PzNddBWLFDAgAmUCgPNB93+mIdIkCwUQO6+a7Z/vUb5A0ROtUPJeCr8bCuE0EHD4hrR8OEjJYfELbY8x4LlY0XK0oaG/36x5X6QSOGDG8WLeNeOphbToxAZgehoz9+IGHB4RFlkoQ/fBszlsSJvkDK/9yaT2NJbkseGF7j882Zwe/fsY5cBQ3FOZNm6t/zl5F46rn4fBTHVcDYTqqwTnveL8yTDjm0ZJMFVBTUgLnq/21xh5N+0oIBsSBoBuBaAkyTlv8DsRYuArH1eOVRaMtr2oxv/pLuxrD5phTqaXHSlIt6OOOK0Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnvjIoBpiVa0v/G9CktuetqHt5VDy4vQhVI5IaYGwlk=;
 b=UU+CFVsokl+HIlN/l0Hz5DC7h92/0/sPS6hsyV7l/0++9FhfJJTV6VwrNTWiUDOPAPJgUCRiMrPvArU/ZfDu8HwjBdZtbNulIXFrftrbX+JpBWWcZVOZrTnuMhQKWH4GLgUhHnnuVBZwuxu8fKEV9ekAvIMx07j0e8tyoFAjzlHRylFaofAuYp4QgpNAFUOZ0rII+sj6gREFL96MgBKytrzEa0ZaCc+FjGZQGvF2l+IWvb1wl4OKybmfNlrKNz3aYHJiagPBuycxPXawoPHLZwCbSLCsLpZLJhmd5/qe41E24rTvu/VbjJzJ6Hzz/6lCYlswl1YTQIMsxlcoZOMxlQ==
Received: from PH8PR22CA0004.namprd22.prod.outlook.com (2603:10b6:510:2d1::19)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sun, 4 Oct
 2026 20:21:06 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::54) by PH8PR22CA0004.outlook.office365.com
 (2603:10b6:510:2d1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 20:21:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 20:21:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 13:20:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 4 Oct 2026 13:20:55 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 13:20:54 -0700
Date: Sun, 4 Oct 2026 13:20:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>
Subject: Re: [PATCH v10 03/13] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
Message-ID: <asK1JIsTay1yeBEU@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <b6493aeece86f44195e8afb6fb8b3497cc237dc2.1788130528.git.nicolinc@nvidia.com>
 <asJTer4cNh4DAQMY@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <asJTer4cNh4DAQMY@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f866ae4-3db0-41a3-8506-08df2255051f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|23010399003|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CVZqiiL7ZbkBezhDIyAqZK6qmyy2q4uldMa40UKX113CaEmWNEVT8mku2YGEo3G1/bPNonMF4ybZKSzFfWApx3MSeFa7AwVLzZRwHdLSDsNt5D65X+zS2MPfKLKK4QiPKkJV+VoAfaRRHE+svivKqg+WYDYtAlBBBaRKb4y6NABI0cwsOzY/voQxNBa54pYj7fh6hMB10S8NBQiRDxya1E9khYQC7xxMXcg6bCERJegJV+CmwG2csRo6IW3ofkOc3bOkdvOQZCeUibQrObqD2LRGChkIM8AdFhYGjZnYM13oO4kQ2eEGBKvhXD6wldYYpEvgsG6FBd9l5fVEKd//FTk84siD5gTrY8YV01DLVXFl7wGX0RfBJNLoozYLVhCUHSx9TUzIuZNvzRA4ECJ4DtPB6TGgFjbrdrBjzHjhLj/CtvRMgSCaHHDEBrnP+GZFPIfHHKUuk1TIzm5Ato4hRqX0foh/YHcEjbaUEdlWjUT9Sqpv4yiSHIbbA/WN5yzyUj/s7edKlQtblZdbuJJaBe8kYn8dXit4wbz77jR39gqpNFl0u54zh02FtprgBL50GF/qTMOuvg2W+1uUpMgxHf+pO9I/siS6HwVMy92beqCMkamz11lHNdYfJ304cY6qLksQK2MPhx5sXJQotc49dyyrMYdKYb+/ENBt9lafVuJoO/Kub0BhMOiH2jG+KwQ5/MFalnBBSwSR9UFlA4qIFw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5sTOE5zCtw2AXDvFX4TriSn+7bTaQgEjU4/RtMx8ME7OHL0wl/iSPp/QmPcFTxD3ntCpAQo1xgcaypSwGT8Vw4xBs2qj4UqduRRx/usDffvebLxD/gG6JHUqBJPqdH3FgcH7PLq5d0wUWjV6/ZSVFtOgJCZW1k42saFkHhtu4VJ5QqtuqtGbqTVPIdrMRJENknm4HQNjBRRGlbyBeNF4/cTqzqEaT1pMlrQsS4AWL+/0zb88GzgpBfWgP6DZmi2zjSyMS9nzoyDAff09dGSlVWyRXrVCLkPB9TFLjd+Z3v+ohLmuLV6URgzbsFETvSLEdvRsFSnnY3eL1YK8nw257Sh5RV4BTDZv5Fd1UdFMH8EGgX4Eg4AAiI7rMYVrpW/evGagDSH9qhLAh5q88E7+EGUsTdVw7HoLqDhbUdht8edtl+5x39kHvD32yRv0RY3Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 20:21:06.2010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f866ae4-3db0-41a3-8506-08df2255051f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970

On Sun, Oct 04, 2026 at 02:24:10PM +0100, Will Deacon wrote:
> On Sun, Aug 30, 2026 at 04:18:04PM -0700, Nicolin Chen wrote:
> > The driver programs and enables the event queue unconditionally, while the
> > PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
> > kdump kernel wants to leave both of the queues alone, which would take an
> > is_kdump_kernel() test at every one of those places.
> > 
> > Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
> > architecturally mandatory, and gate the queue's allocation, its interrupt
> > and its CR0 and IRQ_CTRL enables on it, so that a later change can turn the
> > queue off in a single place.
> > 
> > No functional change intended.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Assisted-by: Claude:claude-opus-5
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 79 +++++++++++++--------
> >  2 files changed, 52 insertions(+), 28 deletions(-)
> 
> Sashiko has comments about the event queue MSI configuration for this patch.
> Please can you have a look?

Sashiko raised those because it doesn't read subsequent patches.

And I left them as-is because I don't think they worth a change:

1. IRQ_CTRL_EVTQ_IRQEN is never enabled in the kdump mode, so that
   ARM_SMMU_EVTQ_IRQ_CFG0 line shouldn't matter.

2. arm_smmu_write_msi_msg() is never called in the kdump mode since
   devm_request_threaded_irq() is guarded with ARM_SMMU_FEAT_EVTQ.

Sashiko is only right about the small waste of the MSI vector since
it's unused. But, that nvec decrement trick only works for PRIQ, as
its MSI index is at top of the list:

   enum arm_smmu_msi_index {
	EVTQ_MSI_INDEX,
	GERROR_MSI_INDEX,
	PRIQ_MSI_INDEX,
	ARM_SMMU_MAX_MSIS, // "nvec--" shifts up this, skipping PRIQ
   };

On the other hand, EVTQ_MSI_INDEX is at 0. Skipping it would need to
shift the entire index list; struct arm_smmu_msi_cfg would not work
straightforwardly as today.

Nicolin
