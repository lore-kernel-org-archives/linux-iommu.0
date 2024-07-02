Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33B1E4AB
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944423; cv=fail; b=cExnS2cnRcPhaSgQoUq2cdBo73FGvsoYhn9/PTwXzEF9KXD8AxqU4N4eO04TKfmy39qY10V110THY6xlm2iyN4h7KQOnyv7BdJzqHs5qGmcqwEymcEi69AghRtcWNEydAlNsCvRPO20gpsN8IBSgpuVjk+LoLtF+rHfDTntn0KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944423; c=relaxed/simple;
	bh=knu5tF3OLy0i8HDpZrQDoEaSI/6UtNPPkarML6jGqSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0ls9ODaAx6To9u2MEr74D+ofMC4TrdT3l5Q0VDRsaJPtgNymXOkxUpEEzy4JqOu7qA4mQLWxisBoJQd5LO2JYYK9QbSW7bSYnFxH6N1bV6ItzBlGXaysXlQAlEWio/UPHdViwMTZHuZHRWUUV9MGBkqZSQJSwDLWOhKCHRheOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WByVkMQD; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WByVkMQD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4ggzqlnK/qAzTx227E8/GjhHN+n9iWjFTIEeCaY5A2T9IDa8t+bpLeGaVwS6xozFSV9C3KEb6ckVDu65RiCqBmcRFedPz6pFzv7obNAhK0dxBlfzMqCh7MxL2Yi3NxngEk3NjrE2QAuITNhhEKq2sr7g4o+z0YPL15NSFTY7qkcAbuYfrC9/0+H4NNLvEzWSO6oz2L5yNAHtwYsDy2Ljz6ESYJ9FQ4seC2tGwxtrpgHeGBPY5hg86FxAQdzg1F92y0EYD96ooQITirNNVlGF6TsK91q/Aa0hd5e3DH0/4HuPOEHjmKQq4HULYHonhv/WN9A5djatkZ+Mh8FXc3ZiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghA9hfT2GgZrLWkF4+gDcny5/8iN74Z8Qm8Djtn5wbM=;
 b=WjI0RORCUEZVX0DhBcLqc9rzeq2c2Aa6b0ccmaSuDlTApaog/xrRxybIPKBVXpmFYt9ORJBXjEo4uGcbXdU8jyf1tEbdbQiM5fQ+qWppv+MTURB7zM/hOeUbphhvT2gUEYlxGXYThEoJvM28xt+awli+o5ymSj5YMH25sDhPVXpOtiPuuukmANBWNqcPLtjSH/xh8hU3yNmgrTqdKuyqIdUR1uJTIdznXRUXqdta7bJI+nWZb1sXFy257KdjBhxgwA+YGWRqbL5WT8GGOL40oyKQXah/lJjCWN7sBG3grivX/d6uKUiexrPVn2pl61YQZZEnmvhnhKqTQNqhqjWexA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghA9hfT2GgZrLWkF4+gDcny5/8iN74Z8Qm8Djtn5wbM=;
 b=WByVkMQDOpuj+cM9UudmtAkGH9NwMAKUA3Q1D18bBeMZZ159zdoQFgsuSCN6S8J0CI/EX9pw1coy0cg/NqRfiIgJ0IVAltSdAMYX61Q2L8hwJp59lKTMgobekZUPQVbcypHa8yOVVVsGhTnoTrthnUFfeqkXuah4kUiu5iCg0vurYiFqQYWvrCw1To25rzRKR0KPaJuWnsATH6N59LcsHZg5l+XVu31wOJ/GE9IbUF+6LMfK1KU+myNfKrJ62/OwYS9wsWeFpCIOR5V9QWIufUKp0k5iP3SYS7pPys1B5NI5RqPPyZ/r9wmjqXs4v8e6tdL9htV1i0EieCr/TZWtrg==
Received: from SJ0PR03CA0196.namprd03.prod.outlook.com (2603:10b6:a03:2ef::21)
 by LV2PR12MB6016.namprd12.prod.outlook.com (2603:10b6:408:14e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 18:20:18 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b6) by SJ0PR03CA0196.outlook.office365.com
 (2603:10b6:a03:2ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32 via Frontend
 Transport; Tue, 2 Jul 2024 18:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Tue, 2 Jul 2024 18:20:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 11:19:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Jul 2024
 11:19:58 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 2 Jul 2024 11:19:57 -0700
Date: Tue, 2 Jul 2024 11:19:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <ZoREzIAqzyamQBWL@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240702174307.GB4740@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|LV2PR12MB6016:EE_
X-MS-Office365-Filtering-Correlation-Id: aacfebf3-fed4-4671-1707-08dc9ac3a064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qu62bWmkV62F+TK72P4IWmeqOCFbMq3cuo01VOlTEc1zcizqjz47trAN1zzm?=
 =?us-ascii?Q?VvpSv2ivdSpu9Vn/MOHX7eiaV210tFv1RXX4YxOqktxldElKzm75USoaW09b?=
 =?us-ascii?Q?jXmuTNV5g6SBddHUzn7eJuziYwoSz6GXsEdYEjBWrwPxzupoCz5WXbaaDZPV?=
 =?us-ascii?Q?/5w2OruDj3j9+dbf/5ZbW61pOZQktqoXJ2Zu3juMdgMryeDk/o4Qun+E1D3u?=
 =?us-ascii?Q?hmOaCjUF6nLE9LEeuvLtKetBHEhUjDULwxNd6lJD/hrWCxLhJGLIGGQZx3ah?=
 =?us-ascii?Q?Gc5BmFuJsz4sXx691JNWWz73A8yZ4NqfYTeleq5olOF+bbmDtMt/kOeXsIdR?=
 =?us-ascii?Q?qT2KQy+01AumbfyLi9Mn5shTW+BqG8/CtuEVaGLN9YaKFgAwsF3w1QOK2jaZ?=
 =?us-ascii?Q?k0vaejKQBPRPJLT7VPc4yPLYjZKe95piVdsTW1AcB/TiOwVpHqoP3A1p//o7?=
 =?us-ascii?Q?06sG27seMTm19J/lqCmz3yKqwmqU6t+gIDRQA+iggWtB8O//m3nVkSUoVG67?=
 =?us-ascii?Q?q1BTm+BDrSg4F9CciKtUAFITQuD2qaypluaMVB1Q0LwH8D8du/CyZsn3VQXM?=
 =?us-ascii?Q?cHis8QJbqS91EFH2CstZN6V0/C70/+3Uu37b7NxAREsva4PbQqsyNYq8SiR3?=
 =?us-ascii?Q?Ngu9aCZ5xBfzIyuaEBDcy7ViY2mr9xBccQJimj85HW4acgJyFYxsKmoi4mcX?=
 =?us-ascii?Q?miCMBjNbra7KxSPKpJbCWhFWFO47Jh7tilbnr03/kAZLA6x+TCIW9DtTE5Bb?=
 =?us-ascii?Q?NZMu/KlP2u06NUtolChoSQUesiSTqEW00wcwNsIBMdKhAAWtP5T3ZqI0I2WU?=
 =?us-ascii?Q?PwdN5vq3YvEDer9G/ZzyQKBdAq2B83YU5tNcF14HUOd297NGpMi5pLMTPFgq?=
 =?us-ascii?Q?HDjUDVWEUz9FbVDUBjnmZ9tl2IQYTMNr5D28rNzvagpmAMJ37t45SXvugdRy?=
 =?us-ascii?Q?ZQLJxtUBXWZiv8fd0rLgsrL2F75a4zLPzQTO2FoM89GwxKBT4NdnPtvZ5Zkt?=
 =?us-ascii?Q?BRM2LKtO9oAioGOSOG0QueW9o3hyUPLnZNPJNyXiHNfGQ8uVw5L+/3a68eGI?=
 =?us-ascii?Q?qlBBG37Oqhnb46/qfasH6npqSrRlfGiRLq8lHiHUh7H3BcZBeFo90vwQJxNA?=
 =?us-ascii?Q?jqtpz5Qz6wJCAWJBvcviF12+9WLgWEVNTpLgSl10i8UHo8r8V+9s1A0MoX5q?=
 =?us-ascii?Q?H198JdH3ZYNZ3ZkU0cx7BoedV4nMOgpe2BeWH4jpRTc7SC3YYtiDST/5KucA?=
 =?us-ascii?Q?mF/L9FYMcz8JxfsNC1p1JZk7Nn11i4UwdzT9/zV23I0Xdtu+45CtKJeOF+j3?=
 =?us-ascii?Q?liEACfxp4YncJCR901Q/QidaKnse+xZptMW1Vzp2vDKcsQyMbNZeA/mI4Sum?=
 =?us-ascii?Q?nOhWcs97RVbQrOgwzB4tZY7dvWWTYXnSCyR2M8qllFy56yOWmRzHXKk/i20H?=
 =?us-ascii?Q?oPnzWeqh5lGQ5Sxwzk5RMAGl+LVqnuT9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 18:20:17.9825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aacfebf3-fed4-4671-1707-08dc9ac3a064
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6016

Hi Will,

On Tue, Jul 02, 2024 at 06:43:07PM +0100, Will Deacon wrote:
> On Wed, Jun 12, 2024 at 02:45:31PM -0700, Nicolin Chen wrote:
> > The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
> > CS field of CMD_SYNC. Add a quirk flag to accommodate that.
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index c864c634cd23..ba0e24d5ffbf 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> >                FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> >                FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> >
> > +     if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
> > +             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > +             return;
> > +     }
> > +
> >       if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> >               cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> >               return;
> > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> >                                        struct arm_smmu_cmdq *cmdq,
> >                                        struct arm_smmu_ll_queue *llq)
> >  {
> > -     if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > +     if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > +         !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
> >               return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> >
> >       return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > index 180c0b1e0658..01227c0de290 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> > @@ -543,6 +543,9 @@ struct arm_smmu_queue {
> >
> >       u32 __iomem                     *prod_reg;
> >       u32 __iomem                     *cons_reg;
> > +
> > +#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY BIT(0)  /* CMD_SYNC CS field supports CS_NONE only */
> > +     u32                             quirks;
> 
> Please can you use the existing smmu->options field instead of adding
> another place to track quirks? Or do you need this only for some of the
> queues for a given SMMU device?

VCMDQs are extension of a regular SMMU (with its own CMDQ). So,
SMMU CMDQ still supports SIG_IRQ for the CS field, while VCMDQs
could only support SIG_NONE. In another word, this quirk is not
per SMMU but per Queue.

I can highlight this in the commit message, if that would make
it clear.

Thanks
Nicolin
