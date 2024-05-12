Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F71F3D68
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547413; cv=fail; b=cFlFnaQMnt7ZPHqDDCjxQTy3dRggL9rAjSuAps1zPissLOqtIwJeq2dNZuzRrQORs/he0XZUoskuTPx7wTtxeofv1Gxpjrow/RUCBLguSLx9MXPiFqMwvm/0+lqoJJr00l3gH/xtqMdmqtNJTCD2Cye2Sn5mofmGZQ4igDuieBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547413; c=relaxed/simple;
	bh=m0SJCm5mgIfVMNQG50AMrHv8GI6ZeQramc3WcVsD8ZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+ttJg53IPmoPqiIt5Md+eFakeLJcY3Uj0QsAnsSVBShscJjLYGi051QuLvZpV76xUW1mQN3wt6WtMhcGdIVVaYjs1mcqzfqJSvKlceoOT5vGVEJzw7JP4fwmI7BnOWuHVKrWIzitl0cvDsI/p5DG6QYcofa6EArjWZANCMDG2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sj46oIxO; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sj46oIxO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfat5JQ9skC0yMteCbQ53NCVU8mNKlXkIAd61GgYfV0rRoCLegBvQ5tPG+4QArU4Tp2Aq5ogzWQGpH6PWvHgsUVbD9AH664W7SsEn+l82PFeVgwMMsPm6SlOyHlFg6C+vf0LFeNW+BP3tLWkJOoHGe6jVzWYjWQrlTtuPc0rXeea31by3CH/zW8yerx06wifJ+/7BfkIijVesEx4O2L1GSibbEL0XkV05RsIFRajrDSW0TE8kLQ9uecjc9jIRU84mRhskBvV4Jn7776Jm3fQtBPBrifz6e8OkQtb+djY2KQsX5h1tqX19pTXiYi2ALmPU/NkE9s6U3NLK8JjIFQ6zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/K1edEBhguOAXCRdt8a0QIokcOYUXiuU7wQAIiRpf0=;
 b=hQ45FTxim61VRmebwv0oHe7YdU2+eUupTPITyycG+ZqU0YpT0//TEzZ0njMCWEtf4CVgjfJH7i/G2Oa+eAuRMZ/gKCSvtZJ7cmDzRL3z0sEF8JMyyLfet8/7+8TTjkMeSpwUnkyNW35B0StQv4Vm7Z0j1jk7c/M8/E9PPAnQAMA0PhPrk2ST8hTF7Y5RWvxxqBZwM6RM10hmEJBU7p8fjNIt9tqSdvpEGVGTx11OJCWqCOv6XbtasjCUefKG2J1c5YPKJmRaw6xDozzqG3fw1Cm1AXNvEtY6NsNhYRO8wr0jO3nbyQNsnbrm2RlUroSvYmV/0bT6lFWFL4zJnYoJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/K1edEBhguOAXCRdt8a0QIokcOYUXiuU7wQAIiRpf0=;
 b=Sj46oIxOCVsZ98hBHcNTNjHyvmm6+c01OoMu38Rwl9QVy11Lq+U/r1yZDC6GYoHKTTwxjex5a8rloKGHyXthLwbP/oCN8+pdk5wX1D5sqVODS7zFxYQ/ZGzm2M5RFfByq0SNlv03NyFXsxjMV5p8tiyLyjuLaPKPsPzT9Di3e+IAWPXdz1IZA8+8cNoMvjI0hhnw3gnpoesrSUQc48ScX5geXt6glyC+FOAwUxG6EL5M63mzOJnUqj9iEcY/vFfYOreYcU2ojfNckearGUJvSj/OlACIt3NZsYcVeqDZJ9JgUgXXYHM+qzl7TVkHw+s+sEDWwZ4o6XGiQ7CmSxMmRg==
Received: from SA1P222CA0152.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::20)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 20:56:46 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::77) by SA1P222CA0152.outlook.office365.com
 (2603:10b6:806:3c3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Sun, 12 May 2024 20:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 20:56:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 13:56:45 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 13:56:45 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 13:56:42 -0700
Date: Sun, 12 May 2024 13:56:40 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 3/6] iommu/arm-smmu-v3: Enforce
 arm_smmu_cmdq_build_sync_cmd
Message-ID: <ZkEtCNrJHTTAJ2Mf@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <52845c9fdfdd7f38a694e7727f3eabbd10e9f8ee.1715147377.git.nicolinc@nvidia.com>
 <ZkDiv10JYCjNblv/@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDiv10JYCjNblv/@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|SA1PR12MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 639649b3-89eb-40e8-8e60-08dc72c60912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gSi1sr1Sl2nEt//zZz6oCmfelJOquZ03P3mQg4AXNG2djIypYN9kcvfIx8rz?=
 =?us-ascii?Q?Uzzf3KFIyps6f+qs5GZ/2Z/aBINzv271xSEMpxDNDVpcni0lweJKeeKhPiDL?=
 =?us-ascii?Q?i18LivZErkcYauk5YTs8yWaQsI60p90DQ4oooWhtuasGJ9IOHyw/XawEtcaK?=
 =?us-ascii?Q?OujIr2yYRdwi5AW7q0ZZcK/+PNN9AakLPPCFB6JD0B4CvLc6u8yD2PgUfd7j?=
 =?us-ascii?Q?55ZhlhPWqMA+J8Oez3cprXyz8N7QCrOkhXUJ2dUpD/UOxfA9pvdo5Q/dMM6j?=
 =?us-ascii?Q?GdpsZEzbFbYR9ITkpu7Gc1qT96oeDN42nsLJVieA3Dbu46d8tOHG8b85fimb?=
 =?us-ascii?Q?KcVlmEf2/hEE/ShTTV/7nLxIza7ZbyaaFNDHhrNQSgR9Kyt/t5btqkTA1CYv?=
 =?us-ascii?Q?sX3vIuTTgrPBKqJXxizlj4Rzv8ifwnQhzbYEVCTUdEWh9zeXdd1Xe+isvGd3?=
 =?us-ascii?Q?Oqp0SDvZcFMS6goi92mU1W4XqrWVY7+wPqT+LZZqw3XxqgG8nPl+MBKc78Zy?=
 =?us-ascii?Q?UcSj4Y24WNn35wyYDtBz5jE9pd3LLEt2Sep1O36jGygLtYpib6bN0MBQ13Nz?=
 =?us-ascii?Q?TLbgT71VT2/J+IsJa1ogs+EeDDc3PM7cwgnsBILzFviGTC6gx07eij9d22dB?=
 =?us-ascii?Q?tKGh+7hwlWT77axVL1zaMKVqTXI5N5ChSa5V5/zg78lLHLUDc1P2Asgl2K/S?=
 =?us-ascii?Q?5NTyTjnvI7taEtE+V1Z9i0rXMFOQK0g+AwgGoW7lwjOFto6Ye2QLQk6qSxEV?=
 =?us-ascii?Q?0634clmrVey0J8GImer8zNhj8Ts/M64lhw2gfUt1aZutN042+kwshOTa153S?=
 =?us-ascii?Q?D3ccaN/uo2QZZ/cOlyxIqF3iDctPX5PWOX8fOJWsgumfSCFNsoNNiYmAzeI/?=
 =?us-ascii?Q?MOqg3MfYPFJpF/Kx3IpLgHmWS/6UfrBYTkLJeHfldIcJcvCzFl7nbmX9Te8F?=
 =?us-ascii?Q?WdDJ9YiiQwQDechH/YyMZtKJzm9HrRJjLXYpZMDJoQs2l3mx8SCrLokdTL5Q?=
 =?us-ascii?Q?7t8hjVoM0T3sFY6KzNPmGmzdBuGzrn3cEG+FVJTUl3z8Qk7xscRvNc8uBdDd?=
 =?us-ascii?Q?OhN5mBs0Xo31Ucb9l+ECBx0gWNww2Uxq1qMO+a7OgeHCYGpPX6wsY78qd4PZ?=
 =?us-ascii?Q?DMQuxq10dt4HhUWy70w9dsG00XGax6zYhVxxJ4uTdCe3UqsVctgJMXboiJz6?=
 =?us-ascii?Q?d5iw+BOvUbSCcUSe4k+gj0sXAAvUeJ7UmKkQD2kuXwR2UVkXABWA4CgZc7LS?=
 =?us-ascii?Q?cIB6x495XkE7MaKu5laKPIEeyXDY9z906kIFse8nc/eOhU23VnjDpRO2SC/Z?=
 =?us-ascii?Q?EHPi6YoxX84Gm5JUn2TJK3stWzFnxZ7fZV8F+5YPQdbEhMINJxKRYLHI39aR?=
 =?us-ascii?Q?gO6pD1kyMwhIsw9nvWLg5HUdrU6f?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 20:56:45.9663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639649b3-89eb-40e8-8e60-08dc72c60912
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702

On Sun, May 12, 2024 at 12:39:43PM -0300, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 10:56:51PM -0700, Nicolin Chen wrote:
> > There is an existing arm_smmu_cmdq_build_sync_cmd() so the driver should
> > call it at all places other than going through arm_smmu_cmdq_build_cmd()
> > separately. This helps the following patch that adds a CS_NONE quirk for
> > tegra241-cmdqv driver.
> > 
> > Note that this changes the type of CMD_SYNC in __arm_smmu_cmdq_skip_err,
> > for ARM_SMMU_OPT_MSIPOLL=true cases, from previously a non-MSI one to an
> > MSI one that is proven to still work by a hacking test:
> >   nvme: Adding to iommu group 10
> >   nvme: --------hacking-----------
> >   arm-smmu-v3: unexpected global error reported (0x00000001),
> >                this could be serious
> >   arm-smmu-v3: CMDQ error (cons 0x01000022): Illegal command
> >   arm-smmu-v3: skipping command in error state:
> >   arm-smmu-v3:  0x0000000000000000
> >   arm-smmu-v3:  0x0000000000000000
> >   nvme: -------recovered----------
> >   nvme nvme0: 72/0/0 default/read/poll queues
> >    nvme0n1: p1 p2
> 
> Nice
>  
> > @@ -350,20 +340,23 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> >  static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
> >  					 struct arm_smmu_queue *q, u32 prod)
> >  {
> > -	struct arm_smmu_cmdq_ent ent = {
> > -		.opcode = CMDQ_OP_CMD_SYNC,
> > -	};
> > +	memset(cmd, 0, 1 << CMDQ_ENT_SZ_SHIFT);
> 
> The command would also benifit from its own type someday :\
> 
> Maybe this should just be cmd[1] = 0 ?

Yes. I will add that.

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks!
Nicolin
