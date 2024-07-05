Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8481B7E9
	for <iommu@lists.linux.dev>; Fri,  5 Jul 2024 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203060; cv=fail; b=VQ30bQ4qOZFtzxe7bdsVMnmyPNjs60tzhuIv0ceBcWekeRtJERuCb/q2kmnYYvMYNrhB1YIClWue04OQh5NkZDVLFKNnX71hy+8Tx+7loFoj/u3nSLgoreKF0FVg0WTq/v4g9vQgFqWtrvTOS9hKMdaq3Zk/KqG9i7TL9mwMo6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203060; c=relaxed/simple;
	bh=70g09wwe0C3pEtTy/qRBrWP61upGMY1vECA7OB+gucM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cF2K4XHBiZ5+dkJkeg/mVyXBfncv8dtJ3SDOmU3Yr73bvBpPll22fGKT1H+X28vvRH9/3Fs2mRsKonapIiM2roW23ZtEHETULUblsh+rGOvSYCN72NrmFjV+7kO7EwvZG4xxhzFKYSTqqROdjqEHgQhcEHUGMlYzoXU11j1mRI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t93MMji8; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t93MMji8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im6veGwxj0p8w2s7hvK/oN20HA7QEMxy1+CmicwHPyUlZiVk+kLbZg8IpCK/dKsiEvfWcnz5ofepIiSfm820q4asgLkhD8kfpl41ozEQ2tNYK5hTh7MR9JboAyvC6POJP5nfDhS1SgTXfs/rvd1nx3FpTIGavnmMSoApK5kTE7yff8ZxMJ25XHQka9i29jpIkqrTF52Mt4f4QqWwt/G8+wjE1D8WCUXZdZ0MZ0mdyvQkqqA8VWeg06cLncZJKjE4J34Byy5nLoMSA+3h5uxECgz+qje0TYm8SzTJLeUJ8q8sRMu+2YCgLIWrfOO1/PsFFUihcAJ/8v1lB+3Bswgdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VZYVj/5FSftlKOXQU844A3FlU+cZVwklUZOuXvN/5w=;
 b=irgdmIgQbWc5fu5NXNSaU1fS3+eHZ3pgqY/tf+umGViyeKPCYCO+3QxYa83hmvWx2Fv5eiJDlf68FjKMi0iprP/zk+9D4Z1ZLpGBl5UCBv05owN+tn5dD6U6ygRYG08d8Njyy6/RZERe9oZelnt+dfwg+h7IjploiwVtn10G68MuBY5ZLH9tR+InPbJlMFg0w++ALp6iRsrmCsqz0XzEwcJetxbPHqLPGLLQv5oiUbODBnCSH/gYBlzeVk52foqcvjtPN5wvBwmpAPi4GiCbnOWN+a/4o8qw3uuHku2zkechqs/fkzIFC0rDIXcZHyPEmqOl8Um7LTKOuTG5kMW3TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VZYVj/5FSftlKOXQU844A3FlU+cZVwklUZOuXvN/5w=;
 b=t93MMji8G7skEIqyVph2WM/GCpJt3Oi5SyDf7NGluq1a8d9XWhB/X/zKSu/DcDamxSEw7w1BpMwSKwb6RrWCixDFeNgpgtKjkQHmtRKzOEGeH28tjP3LqdEOkjJqPiwPv5/3cjrXOBpoL3JhqxYhVOFD9mWeA2d9O5xIjeU/ALNRlRIMNNvzZZAK3vZHUwP0O8WjiPCevBlPU8shT5W7JsYW3YuTpl6dxFOIXieVEPNjhnYbFSDnRtgmtDLHp978gk7VSSFdCDDuCWCREXhwOJpMuVFg5e7JHWQH6mM5Y5mnY9ymf6ku05AoqpNo/MjXu6TbF3k2gS6xxH5LPhckOQ==
Received: from BYAPR03CA0020.namprd03.prod.outlook.com (2603:10b6:a02:a8::33)
 by IA1PR12MB6236.namprd12.prod.outlook.com (2603:10b6:208:3e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 18:10:53 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::9e) by BYAPR03CA0020.outlook.office365.com
 (2603:10b6:a02:a8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33 via Frontend
 Transport; Fri, 5 Jul 2024 18:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 18:10:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 11:10:45 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 5 Jul 2024 11:10:44 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 5 Jul 2024 11:10:44 -0700
Date: Fri, 5 Jul 2024 11:10:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v9 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for
 CONFIG_TEGRA241_CMDQV
Message-ID: <Zog3IgdmYRU7VbJB@Asurada-Nvidia>
References: <cover.1718228494.git.nicolinc@nvidia.com>
 <d20dc9939523fac490bc02e57d7836f680916a36.1718228494.git.nicolinc@nvidia.com>
 <20240702174307.GB4740@willie-the-truck>
 <ZoREzIAqzyamQBWL@Asurada-Nvidia>
 <20240702184942.GD5167@willie-the-truck>
 <ZoRZP4k1A3G7nH9q@Asurada-Nvidia>
 <ZoReq/kNi368x79q@Asurada-Nvidia>
 <20240705152721.GA9485@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="N5fDIjKzM8ewn58/"
Content-Disposition: inline
In-Reply-To: <20240705152721.GA9485@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|IA1PR12MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d917e45-6e4b-4ae4-8c6e-08dc9d1dceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qkRrjPUXmm1BSvqYt3jwwefAFTtCCSOrGLnhwijc7GtatYOKSDfHCJJ7Q6Z?=
 =?us-ascii?Q?dnhySovwutayrBmPazRmLpMWuKlmAkfG6rehVnEpNb47g4pB2CSMhQ1gVw78?=
 =?us-ascii?Q?lgRf4D8QY9g+Qtt6gCNYPGVt2Bc3ei9KaTGQx6iWKZDX5bX7xfpq1ufE3P58?=
 =?us-ascii?Q?LQmSpuGl1J4jKDiD+nH37ENdhCZOfFDbMV1za39X31c+ZaU0LpGPZvD6WGJL?=
 =?us-ascii?Q?hucTutkjewdq6RGmfLBj7ahuC2VzrsMrKCKUf7qJXKi1cl9SBU4/bKQpuNKS?=
 =?us-ascii?Q?kPC57tqpFO2gREcdxd8juSIu4/SklY6atJnipgT9mrVb1RZ9kmTtuFN5Bcpl?=
 =?us-ascii?Q?6C8eisqYkFpjumg0fV2uGJ0qM2P/R0oLVwdQwREoYtRlTNf4SXm7VfU2tWsf?=
 =?us-ascii?Q?XUENRte1tuJtGG/H51jGP0liK40/sWdyBeTaIIVsbQEu1f0KPc2v1bQIr4xC?=
 =?us-ascii?Q?LxdUOUl8XTOX2Cj2BJ6YH8n6t0LbOE+MF0ZXPzH0cfLrooFOp4U2WOFgdCfE?=
 =?us-ascii?Q?TJa0PAjLNKoD8hqKhzOLayC26n5FGcMQ3szWPVm75e8hvoMUCIckhQLxfyxb?=
 =?us-ascii?Q?N7/KY6uBRASlg+Y59lfeXqcqx4JGT7sWuLvgOJyyaQGQ0hfk0QAahQEBOJjD?=
 =?us-ascii?Q?/6J3tkgw2tdURmU4rHr3Z5yKUWUTq14ONNnnKcwbEbv+moSv5a2jBWjZ1J7Y?=
 =?us-ascii?Q?SCIahb6e/4bvnorU0pcXh+SC8q5ZFCZIHMoNCE9wDp3IuNCjxbESrU06FqMj?=
 =?us-ascii?Q?bFWvPtmPnjs6Y+YXZy63JoPe/ORwVEIy5C3/IQiP+AmZpF0S9QTl81hFLEbf?=
 =?us-ascii?Q?So2TenA1j1FMjQmTDsbBQxN/CxFupDZIsK0Et4/d/6tewbci1mwEaa9ChsJL?=
 =?us-ascii?Q?cpYp5FGg8uFa71aLO1PkxSygFPlQQaeLI1ZJs0MnDHsgdwRkhM3cgnsB173b?=
 =?us-ascii?Q?nBPQgo92/d4Cr2XqsDjf12zypJROybWpMG4nF19cDx2QKloZLiR7KolrgupO?=
 =?us-ascii?Q?wpuqh2l/sR807VDEjadaX0KhGP9VRK62z2OKSfAvVwNhySY9nAH9dW+RC98o?=
 =?us-ascii?Q?MlfRB+kHG32E3oN/d5P96ywWRzXlrRcMCatnMCWvxnFEHozuOyfctCj2eC3w?=
 =?us-ascii?Q?6RMrnaISKxDZS+Z3AWXG2QHBmn5Y12+uODkFwEaEH/Rhx5mB8usk//TyLgcD?=
 =?us-ascii?Q?cJCEH6ms1UBuwL1axPiWzOMZFiCLaaIwCjqFnTmk90cgfBsUHVnNAVqBuUWC?=
 =?us-ascii?Q?Ux9qWQUbpH7O233nm0fE8uHw67Bcfp6KkTFG0E/uDQD7TUquCgAZGnYvP72v?=
 =?us-ascii?Q?ghultpQ0HSRrwW6kxXTSkkTw7Lk4Sy9wA+h1pnUzZptcQzvPPgpPUkcf7HVx?=
 =?us-ascii?Q?asH2V8Z2Kh1gTCYSLGhzAKoeQ1VGhId8pTAzAVwtJIojrDi0VC9VYAR3Cqhd?=
 =?us-ascii?Q?GIYWZSjNiSFKCzWiIRfJzmgKCtxYQz3e?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 18:10:52.6351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d917e45-6e4b-4ae4-8c6e-08dc9d1dceaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6236

--N5fDIjKzM8ewn58/
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi Will,

On Fri, Jul 05, 2024 at 04:27:21PM +0100, Will Deacon wrote:
> On Tue, Jul 02, 2024 at 01:10:19PM -0700, Nicolin Chen wrote:
> > On Tue, Jul 02, 2024 at 12:47:14PM -0700, Nicolin Chen wrote:
> > > @@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> > >             FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
> > >             FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
> > >
> > > +   if (cmdq->type == TEGRA241_VCMDQ) {
> > > +           cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
> > > +           return;
> > > +   }
> > > +
> > >     if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
> > >             cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
> > >             return;
> > > @@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
> > >                                     struct arm_smmu_cmdq *cmdq,
> > >                                     struct arm_smmu_ll_queue *llq)
> > >  {
> > > -   if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
> > > +   if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
> > > +       cmdq->type != TEGRA241_VCMDQ) {
> > >             return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
> > >
> > > --------------------------------------------------------------
> > >
> > > Would you prefer this one? I feel CMDQ_QUIRK_SYNC_CS_NONE_ONLY
> > > is more general looking though..
> >
> > And we would need some additional lines of comments for the two
> > pieces above, explaining why TEGRA241_VCMDQ type needs the first
> > one while bypasses the second one. Again, it feels even worse :(
> 
> I hacked the code around a bit this afternoon. Please can you see if:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-nicolin/grace-vcmdq-wip
> 
> does roughly what you need?

I appreciate the patch. Yet, we cannot use IORT's model field.
This would need to go through IORT documentation, for A. And B,
we had a very long discussion with ARM (Robin was there) years
ago, and concluded that this CMDQV would not be a model in IORT
but a DSDT node as an extension. So, this is firm...

With that, we cannot avoid an unconditional hard-coding tegra
function call even if we switch to an impl design:

+static int acpi_smmu_impl_init(u32 model, struct arm_smmu_device *smmu)
+{
+	/*
+	 * unconditional go through ACPI table to detect if there is a tegra241
+	 * implementation that extends SMMU with a CMDQV. The probe() will fill
+	 * the smmu->impl pointer upon success. Otherwise, fall back to regular
+	 * SMMU CMDQ.
+	 */
+	tegra241_impl_acpi_probe(smmu);
+	return 0;
+}

As for arm_smmu_cmdq_needs_busy_polling, it doesn't really look
very optimal to me. But if you insist on having an smmu option,
we still have to take in the PATCH-3 in this series, enforcing
an arm_smmu_cmdq_build_sync_cmd() call in the IRQ handler too.
So, it would eventually look like [attachment].

Thanks!
Nicolin

--N5fDIjKzM8ewn58/
Content-Type: text/plain; charset="us-ascii"; name="tmp.patch"
Content-Disposition: attachment; filename="tmp.patch"
Content-Description: tmp.patch

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3e2eb88535de..e57ea8d39c98 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -352,15 +352,26 @@ arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 	return &smmu->cmdq;
 }
 
+static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq)
+{
+	if (cmdq == &smmu->cmdq)
+		return false;
+
+	return smmu->options & ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
-					 struct arm_smmu_queue *q, u32 prod)
+					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
+	struct arm_smmu_queue *q = &cmdq->q;
+
 	cmd[1] = 0;
 	cmd[0] = FIELD_PREP(CMDQ_0_OP, CMDQ_OP_CMD_SYNC) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
-	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
 		return;
 	}
@@ -380,7 +391,7 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 }
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-			      struct arm_smmu_queue *q)
+			      struct arm_smmu_cmdq *cmdq)
 {
 	static const char * const cerror_str[] = {
 		[CMDQ_ERR_CERROR_NONE_IDX]	= "No error",
@@ -388,6 +399,7 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		[CMDQ_ERR_CERROR_ABT_IDX]	= "Abort on command fetch",
 		[CMDQ_ERR_CERROR_ATC_INV_IDX]	= "ATC invalidate timeout",
 	};
+	struct arm_smmu_queue *q = &cmdq->q;
 
 	int i;
 	u64 cmd[CMDQ_ENT_DWORDS];
@@ -426,14 +438,14 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 		dev_err(smmu->dev, "\t0x%016llx\n", (unsigned long long)cmd[i]);
 
 	/* Convert the erroneous command into a CMD_SYNC */
-	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
+	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, cmdq, cons);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
 
 static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
 {
-	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq.q);
+	__arm_smmu_cmdq_skip_err(smmu, &smmu->cmdq);
 }
 
 /*
@@ -711,7 +723,7 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_ll_queue *llq)
 {
 	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
-	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
+	    !arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
@@ -797,7 +809,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
-		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, &cmdq->q, prod);
+		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, cmdq, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
 
 		/*
@@ -3985,6 +3997,8 @@ static int arm_smmu_device_acpi_probe(struct platform_device *pdev,
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
 	smmu->tegra241_cmdqv = tegra241_cmdqv_acpi_probe(smmu, node);
+	if (smmu->tegra241_cmdqv)
+		smmu->options |= ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY;
 
 	return 0;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2c1fe7e129cd..0962aa839080 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -654,10 +654,11 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_ATTR_TYPES_OVR	(1 << 20)
 	u32				features;
 
-#define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-#define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
-#define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
-#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
+#define ARM_SMMU_OPT_SKIP_PREFETCH			(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY			(1 << 1)
+#define ARM_SMMU_OPT_MSIPOLL				(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC			(1 << 3)
+#define ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY	(1 << 4)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -805,7 +806,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size);
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
-			      struct arm_smmu_queue *q);
+			      struct arm_smmu_cmdq *cmdq);
 int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 			    struct arm_smmu_queue *q, void __iomem *page,
 			    unsigned long prod_off, unsigned long cons_off,
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index bb696c66e56d..4b1de8517bec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -266,7 +266,7 @@ static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 			u32 gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
 
 			__arm_smmu_cmdq_skip_err(vintf->cmdqv->smmu,
-						 &vcmdq->cmdq.q);
+						 &vcmdq->cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 			map &= ~BIT_ULL(lidx);
 		}

--N5fDIjKzM8ewn58/--
