Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2671C2338
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723832155; cv=fail; b=WH0Lfr+5RjZOL3inz7FJImXEG3I2GWqaiMm4n1LDCjLDiDP+XPtHo6b4tpmU38q9TMRcLs2YrsUQrd0kadcQJcNwaEo3VUCfzs2KAfO0/Po+cJq/IyMXBHVjDSGG81d2elTkTWIHeBTO+bpMdIa1QZOZa0gVjjNLiOK7AKs7Qso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723832155; c=relaxed/simple;
	bh=nCha+yEtvSsHSvHJIdMdq6j4aU7mkwQHMLrVnhtfXkU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be91zMze/ZDcVLzkOcGobsM1u1h9aSEuMRbhSE6sZZTzOfVEOVx14sKmtOWdS7s1GyGlZgOB32FwdWUUjVPjow/D5Ngh6A3GmTDKh7w2rSewXttEV7s6uu8DCDE5cnxIATEY0oR5wR/I0AwN9xl86FL1yAUDnlBNVqDUJvyXdXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YFOaKbqd; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YFOaKbqd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdLBkaKGm6prpr0VTgt1Ld5kN9nuyDXA16cSR6HT76LXtcLirxZTGuqV1OvOmIyTW7RI6cCUBrUEQJJkTmtkyjjIQ6r9G0veotclddzPvx9tLb8DSd93LK3vCv1eIT+Ib3bjkq35H/3zik7rAptea/0/DZ2SqbkSy8JhFixdj3hE0b/CHzcoSkNdWpS0WnS/EoDJGL8sNg++NM9UUiz+E3AZDWXNvKCiNQb6tEZIxeUYjxZ220pgaYpojmf6eLUj3Xaqft+Owk9zNkvmcKqq4KUxfoG+qhXzmrV3T1zNqMTPDU1Hjv/ZaAHkdqahQAReTbbU04Mreoxt5Uv7kFEX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBBFdNcoaThaSVRn01Ez4JInw2KWWyI7jAru1xrdyrE=;
 b=UQnJNgAsoSSGrjNlsH0NTsbO2xgNVINzTGY12P1qzKQc1yEpfFrdDLJJ1yjl17I6Weq3pMGe1/FJb8LsdreuEiFk+IEMCn8gYQzXbC1n/tDVsgCTxjpzgRdipqJheXOsxLIxe+hMnNd3b+nbdEwfSzajZyp3uFv9dLtkl1UDjCNXGb9MHVt5Mtobyh+60CbEGHYB2Ow+mfSKKjZJmMZM4nMsy3znsmhDjL7fmt/jv6W0H+wAvkTZdaJBTAM1wvX5hDCSVfegnE8fm72h6RDVfXLFSKXy6jDoyp5TBYnZ4WdGgRdxGUSBpLsd0+fd+/ticCRALaMfeoLDcdE41ADRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mBBFdNcoaThaSVRn01Ez4JInw2KWWyI7jAru1xrdyrE=;
 b=YFOaKbqd18JV1+Ct1utlvLNmbEO5xv2s3SNhUpFMLT/CUK/kVWnd9ImfbTEuSH2ulF7He21Am2THkngsiVrMFURjyUe1rFBeNtxLVD2rnssFS1g07a/J+zK/sZhJQTeoNeBlZ+aoOm57Cpfn9Q2rjBzWa+S3GRCtMcnB6eRgccP3uROSM2U0Wfj5cGlQwryya90nKKVX8Hvp1F+wVSeihtHEZE8V5/tA+cACsG+Mu5YCZEtIEDHtnyhUsdXIOw/LsEwUqCtBaFCGl3PFAnhM0U6G9zpGQfbO0d7of+fOBmKDzj41I7jDwONNXMuakQeQ+IU0EDguxkz4IDIevmeHAg==
Received: from CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 18:15:49 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::f9) by CH2PR08CA0024.outlook.office365.com
 (2603:10b6:610:5a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 18:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 18:15:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 11:15:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 16 Aug 2024 11:15:31 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 11:15:31 -0700
Date: Fri, 16 Aug 2024 11:15:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <Zr+XQfzje2YWIOEo@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
 <20240816132103.GA24411@willie-the-truck>
 <Zr+Nmq6LyrBTY6eR@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zr+Nmq6LyrBTY6eR@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DS0PR12MB6415:EE_
X-MS-Office365-Filtering-Correlation-Id: a4665b36-2e0e-4404-cef1-08dcbe1f74b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eeF59Za3Uej4GZ4L37h/1c+5yir4rOhFesmzqYUQ3ntkHtVqdsWeEZmAVlya?=
 =?us-ascii?Q?jgv3wcTMq7kyQlpkpvGw7HVco7eMSAcxcan50xqYmX4KjZPVOIQGcqsMtH9x?=
 =?us-ascii?Q?LA2Oy0QY0wkjG/tvof2b85PcBac88GKhE4L9uE9Le1dCysrxU9wYeqPws3MM?=
 =?us-ascii?Q?TkamC6e6CCu0HRrB32ld6f2Uyb9AZSaVJhp3meCSbz7Mso4sDAzb718dLy5K?=
 =?us-ascii?Q?2aZDr2OnONU0kZArdHMsdkUI8rF0JGCkBmc3cnSPQvumyJKEX2kvcySFq1W7?=
 =?us-ascii?Q?8leUcyeB4zIk+p4n2p8EcInBbSug9X89SIAL/TcOSKY6OtO5hwr20S6Ud6Ma?=
 =?us-ascii?Q?gV6B3D4RlhGv2hwNbUedUp+vWoqNShsgppnByGxOW8qakKcYDOww6IaFhsa3?=
 =?us-ascii?Q?zNHCh943MbfYl89TsVRYWn2mBWTHPprRw1Lw9OJcaheD0tioozyQoU0C0HqU?=
 =?us-ascii?Q?+d+6p1sQGpeNVg+l65NqsdFK/zffZtK9n9cU+QHKLXPaCqUT3ls78cyq2MIN?=
 =?us-ascii?Q?vXixKwa/wPs/eVVovVDbvTkdUBhj/HGXpurd5lRIkmtn9XcerJZDzj3CGilG?=
 =?us-ascii?Q?4J+3KofgOAuGbPlHJ8uUnJVhHponW0f3T3J3liSDOaHwbnwFP7bFyEU72HOt?=
 =?us-ascii?Q?aXvWyZbvucSpMLSssjMwoyNxXzE6iil6fvGqQpud+H8/6EHG1pmZZrlZGmND?=
 =?us-ascii?Q?9cJbe4GzoHWahRENgAxckhGosq25ChGFGJA1H5jYivvmkAD6A8Wk/gbxcwqY?=
 =?us-ascii?Q?Z/LzzC1qjnheIoH2VnXUzEvmMaLqmdrrHX0rAe823QK/ffDhc4p8c83aXWpF?=
 =?us-ascii?Q?PuxOTwnqDSg2MmR82Zt7Py9Jc6l/w+B3KOhWX+AVlu97Q9ZTr7o/7RVO3sNv?=
 =?us-ascii?Q?brmguLxYIkifYoXAQUMnKle68lXbUo0gQnI7p0LSW0BGnw0kKXDvNYB8UBn8?=
 =?us-ascii?Q?rYfLyYYRgiT5POZy02ExN1+gbDrCFshKaiHQEN8MCSDC7nQ0MIvtTf7oY6nL?=
 =?us-ascii?Q?nFH3qaFOm8ZTR9L7ddZrbm4epz5KbPaZNcWN01U3P8tZuCOei2kZFdl4L3jC?=
 =?us-ascii?Q?v0TSFlQ9qb4a8oth8EtedMkslXtaSNc34zcy5omi8kU1qLN973FM/WQLRX57?=
 =?us-ascii?Q?6RMO86/7Fo47gSV415JzQx32HfWOsOx2BYcrudDJrx+kn6rPAaafPXnCo/VP?=
 =?us-ascii?Q?UtqZ6lu11eJI3tE6r/s4wgBV7LwWarAvKRuU90drECN2CPBwPjDmwRCVWXVM?=
 =?us-ascii?Q?Ni7cy9HU1hTHipsfXoSCOCP6AKN1h1+ruwdUC5hmTmLzNt9QcdZBmBEfIxRx?=
 =?us-ascii?Q?OuqOZA0dUuvW/49EJBOdUqoD269+XZD8KUgNUM1j5uyjfIiQCNKupU+pkaMc?=
 =?us-ascii?Q?3SuaC9MbmDAHXFRMG9i/5VDEStmVZzjrUqfGnWYTRaujsBtMThg1vQusx0vH?=
 =?us-ascii?Q?+Of/GuUDWXWMg+NtbY0tHGJCaVuhXXRy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:15:48.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4665b36-2e0e-4404-cef1-08dcbe1f74b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415

On Fri, Aug 16, 2024 at 10:34:24AM -0700, Nicolin Chen wrote:
> On Fri, Aug 16, 2024 at 02:21:03PM +0100, Will Deacon wrote:
> 
> > >  static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> > > -                                  struct arm_smmu_cmdq_batch *cmds)
> > > +                                  struct arm_smmu_cmdq_batch *cmds,
> > > +                                  u8 opcode)
> > >  {
> > > +     WARN_ON_ONCE(!opcode);
> > 
> > This seems like a fairly arbitrary warning. Remove it?
> 
> OK.
> 
> > > +
> > >       cmds->num = 0;
> > > -     cmds->cmdq = arm_smmu_get_cmdq(smmu);
> > > +     cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
> > 
> > If we stashed the opcode here, we could actually just enforce that all
> > commands in the batch are the same type in arm_smmu_cmdq_batch_add().
> > 
> > Would that work better for you or not?
> 
> A guested-owned queue is okay to mix different command types:
> 	CMDQ_OP_TLBI_NH_ASID
> 	CMDQ_OP_TLBI_NH_VA
> 	CMDQ_OP_ATC_INV
> 
> So, limiting a batch to one single opcode isn't ideal. Instead,
> if we really have to apply an enforcement to every batch_add(),
> I think the cmdq structure would need a scan function pointer:
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d0d7c75c030a..1a83ad5ebadc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -918,2 +918,10 @@ static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
>  
> +static bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
> +				       struct arm_smmu_cmdq_ent *ent)
> +{
> +	if (!cmdq->supports_cmd)
> +		return true;
> +	return cmdq->supports_cmd(ent);
> +}
> +
>  static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
> @@ -924,4 +932,5 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
>  
> -	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> -	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
> +	if ((cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
> +	     (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) ||
> +	    !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd)) {
>  		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,

We'd need re-init the batch after this too..

Nicolin

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index e131d8170b90..c4872af6232c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -616,2 +616,3 @@ struct arm_smmu_cmdq {
>  	atomic_t			lock;
> +	bool                            (*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
>  };
> 
> That being said, the whole thing doesn't seem to have a lot value
> at this moment, since the SMMU driver doesn't mix commands?
> 
> Thanks
> Nicolin
