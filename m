Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826F522686F
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755222; cv=fail; b=d8BGAAC1aYss7dlsGJOvs3RJIVQKjqyi/YZatuKCOrLVCa/TZ3UjC5Fl5LGTr8wO6t5FKRZwZRaDPuaxe1PaaAVAgEG4fJvEIfTZO7Eoaxl6B0NmlwrF/hpYeygXT443Dspi/o1pskz4xRKIZBwGMhznkLKfrz3wSnzBaUiBk/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755222; c=relaxed/simple;
	bh=dOmMvACEEOZDrcS25tCD3TtJMwlNqOYo81zB893oCss=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euZd9Yv5Yknb76Pf1kXSsCJo/NCyGVnw3qWk6xIBp7mvo8o91D7xoq4WRrSKrSFeUi64Tyz6alVdzpE1GdhoPNZT/huZVRGKlPbuT5FsXBKAeMwikg88mGbRjWCpYUtRoEQMU6elTJFw4/UF9Cok/60MQZT40RgNH8o/0SFANos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OAm2GROz; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OAm2GROz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHmqEaPbWwTbkGPFpqFIjh5r3g2CXRYzP154PlHfRC03wrmg8DXDLt5kCkIHiaUOh4BC7mF9fgDcxw2mxCgfds0oh1zbTD1NrSCig6aWNJdAwa9thVx8edEPgXsa8yrPNTsgBQGW2LpGNMlYge9zBrwR5z6P+Lve3T0/Ny6dCLH2erX0rzDazsyKRTCN3bjyaYoQgwRAgiwwJzrwEeCui8L5hzFONJwQj6eJ2dsoFARattM8vEFnSYXapryfrRblp8IPc23EK3f/BuOozgQwbrddqw0F9o1QR1z4TwVUpyX6EAZA2RdTZRkZZ8p+ZB2PDibAZOHvwAU9fAqgyEqlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfIGvPHdIbXBmRuX6zn4IhgLkVox69vTnuKbpAJGfGM=;
 b=V25LHcuBQAKeVjamgGSk+tZTxeY2xpTFWnEeRvEsQ6mY9xEe7V54u+J3AaGwvAY4bknoKBiWOMCnFR5aiqmypfotBosU6qZZGtyi8hphaymNwfj8G17cm2Q4cQMHEc0cOrqFE8ZiTi8Sy9QIuyzQz7DLxDxCBVnA5WjXOsBHKgE7XR6lHQhVQY2K5VNyigHTmexLc7Qrr1/RKzoetV21+sKK+FYc0lC9l2zrvJ0WrqQaUNP5GBAq1PXgAr+0lY1E+Ns1eL02AC7PW9v7sqmpyL6ATHFncs7lKvdsjZZ2IJPjB+OYbWiBjlkfcgwk4OsWyp5/eYVpq7YyaF2nz0KE8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfIGvPHdIbXBmRuX6zn4IhgLkVox69vTnuKbpAJGfGM=;
 b=OAm2GROzbT9a1Rd8Q+TY5QQTcaOSJWEOX+OG+eTbQcE4OeUvok9s0CDP94HDTIrpVY+XOTHEEMX1yfG8dCsvM6tYGDleTh+S2AknLTVBO0xdrLYFcXE4VMIlypdX1d5L1BkiiANC9sbB7j7ZmakbPXdEeFUFmFQPkVsyLOIfr/Mo9nFVseKF2ooVmmsQU5XGr7gd4xrUnn19eoQv4geeu2tbVJD5VFbtDqjG6WUqlySLgEAnWdTOP3pykBZKVPJO23s7Cv6+kziLInCqcWT9vsJjX5py59/grbGfL1Rmv2FRtmInjmjFHmeW6DFtlz9SlUsYFzDNG17wKU5hG2NwRg==
Received: from PH8PR21CA0009.namprd21.prod.outlook.com (2603:10b6:510:2ce::26)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 22:13:36 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::d5) by PH8PR21CA0009.outlook.office365.com
 (2603:10b6:510:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Tue,
 15 Apr 2025 22:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 22:13:36 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 15 Apr
 2025 15:13:23 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 15 Apr
 2025 15:13:23 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 15 Apr 2025 15:13:22 -0700
Date: Tue, 15 Apr 2025 15:13:20 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <Z/7aAF1maOPr2Z1J@Asurada-Nvidia>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z_7DmadjRe3GaaN7@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_7DmadjRe3GaaN7@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7c635f-00bc-44cc-8a15-08dd7c6ac49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T7uKaGec1WN+yYDYd5k3nihvsWNlRLnAF09RzJVMsgD+6DMhgRYeuRmRQF9A?=
 =?us-ascii?Q?XDUN0pGULdtRoM/pSGuctZuk6UhGXyvK9dRRiqDIadgaUciA5FzmWPte6zxa?=
 =?us-ascii?Q?eapd3jhbZe9avzrhL45hXnbhBh4CmtH1RJh5eko/jU15VOPnNkZqloUvKsJ+?=
 =?us-ascii?Q?G9mqcqH2roeG7N1dhhlm7kDTaz1L4vdU2imRlmECSg7VHOFf4FbB7Q77NBUl?=
 =?us-ascii?Q?BLWgSozp16OP402a2Ilab87JQF6jhFqXel7Lnv+KUyZb26IslfCRG6bpX3NI?=
 =?us-ascii?Q?GJwKzIDNlVrCgW//WOol9gXF/72UTPGVX3MLiduArnvFTHf2v0VZKXvz7N/L?=
 =?us-ascii?Q?4inlHXk70nHoWSeqNlMJXXrmde37Od8AtkbC5sjmK6G9Pml28BBjWmNWV3hf?=
 =?us-ascii?Q?z3wKFD9FUl+KxGw6evfpnuOgIJ4Zc+QqEaxX9K74CGw+3MLEMbf08o2P1lHb?=
 =?us-ascii?Q?dfTsZ8JBChs6j79Y95XiLMGcmlLgaEvijE8Nka3poDkugFe4XVyJ5KFTImsI?=
 =?us-ascii?Q?boSkV2L0bZr0Hl0kbTielhMVwpBRUf0hU/B+FeUzq90UuLp4I70l6t5BMc4F?=
 =?us-ascii?Q?90hHA8/8hvq3QuUt2BfpVCLBWv0+8IAK5qU6NoP3KuVzZr/PdikG9MK0V4+1?=
 =?us-ascii?Q?G/xcGJHJPU3++heeRJdBY3/mzhOQqvqTxFCNXcCBqsZYgCKhqV7y+Lw2OQ0w?=
 =?us-ascii?Q?AzVN7F/IgflRk7TMIr9OkdqUKuP0l3IdLM1vWZvDL3a93GxtEk3lOQymhcHN?=
 =?us-ascii?Q?k/Hh5AQCeKyEif10dNVgbPh+/Ngbq440jTwJvexuuLvEecH2OcXCJZr26/Oj?=
 =?us-ascii?Q?pk4+Hi4jNvIA30FbAZcuq3t3Orrkt+6vlvbqBFiT4F4vRxw13Hlih/E51Q/z?=
 =?us-ascii?Q?LwnG0MNEYgw9ug6E5HhAMcGiDrT4VJJoK4z43W+vT4iy81xwuQ2/bsNl+rOR?=
 =?us-ascii?Q?UlnPlD1vfSBKaxNYRYrqgNrShx0BWfu/tOORfJgQ2/2tRbDFxFPvFfhYVSHM?=
 =?us-ascii?Q?qNsbMkBipMCT80rmW73y/Z9VvQcFzBxKK1rksqrH1b25QiYK+79zaeXoKIe5?=
 =?us-ascii?Q?8TXEhhytC0fXaknVi90hp4BrpstQ/hsFx81AYPoiATicz5iTnaLBgJrUFkp1?=
 =?us-ascii?Q?A81QbSUA4CQsnLsbgZRLzdVRJ+L40kqC/sD0qShAKGzBySnjoAN0hLs8dbnx?=
 =?us-ascii?Q?7e/ehgDiKebVNyAjwoZgkTDRQA0nE3AZmnLTxS/6INDnexGBA9PdpwF5lN1h?=
 =?us-ascii?Q?6+slhnaSKqEW38qQCwChVNNRWsKCXqmasubSqlhcAhd2ngmO+giuWSfgnDVK?=
 =?us-ascii?Q?bEqPgcQRhuuStTkwFPA2JHUEFy8fZygkfEcQ4Bg7mcNyQwk/42H5iCTVQYCd?=
 =?us-ascii?Q?3qP/1nVKPNHSrfw6deR/6TTiHtUhjAFRqVbBqHXB0SsOWvoKvEbYNYDr6TGJ?=
 =?us-ascii?Q?WlCN2kBKRx2VO4Vvy5s9fJvD1Z2X+2ZfQidfXe2AbplaDmdIRSbbGWjcJ0mU?=
 =?us-ascii?Q?2hVDHXSu60jH57fxfkoCwTm3WTrk4OIqJE1b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 22:13:36.2068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7c635f-00bc-44cc-8a15-08dd7c6ac49a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

On Tue, Apr 15, 2025 at 08:37:45PM +0000, Pranjal Shrivastava wrote:
> On Mon, Apr 14, 2025 at 10:57:32AM -0700, Nicolin Chen wrote:
> > On Wed, Mar 19, 2025 at 12:42:52AM +0000, Pranjal Shrivastava wrote:
> > > +static int __maybe_unused arm_smmu_runtime_suspend(struct device *dev)
> > > +{
> > > +	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
> > > +
> > > +	/* We might get the vcmdq */
> > > +	struct arm_smmu_cmdq_ent cmd = {
> > > +		.opcode	= smmu->features & ARM_SMMU_FEAT_E2H ?
> > > +			CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA,
> > > +	};
> > > +
> > > +	struct arm_smmu_cmdq *cmdq = arm_smmu_get_cmdq(smmu, &cmd);
> > > +	struct arm_smmu_ll_queue *llq = &cmdq->q.llq;
> > > +
> > > +	/*
> > > +	 * Since suspend is invoked when all clients have been
> > > +	 * we don't expect more commands to be added to the cmdq.
> > > +	 * Thus, wait for all existing commands to complete.
> > > +	 */
> > > +	arm_smmu_cmdq_shared_lock(cmdq);
> > > +	arm_smmu_cmdq_poll_until_empty(smmu, cmdq, llq);
> > > +	arm_smmu_cmdq_shared_unlock(cmdq);
> > 
> > Hmm, I just realized this: with an SMMU having multiple CMDQs
> > (currently with vCMDQs and potentially with ECMDQs), should we
> > make sure all cmdqs (not only the cmdq picked in this function
> > by the arm_smmu_get_cmdq call above) to be empty?
> > 
> > On a system with vCMDQs, there are currently one standard SMMU
> > CMDQ and two vCMDQs, i.e. totally 3 cmdqs that could be picked
> > in this context. Perhaps SMMU might need a list of cmdqs that
> > any new allocated cmdq must be added to, so we can iterate all
> > the cmdqs in the list?
> > 
> 
> Well.. I was thinking to only drain the cmdq if we have ats/pri enabled
> because the only case where we'd wanna drain the cmdq is when:
> 
> 1. There's a pending ATC invalidation
> 2. There's a pending CMD_RESUME / PRI_RESP
> 
> Since for any other invalidations, we'll clear the TLBs & config caches
> on resume. Does the same hold true for the commands supported by
> tegra-vcmdq?
> 
> Is there a spec I could read about tegra vCMDQ and the commands
> supported by it?

I don't have a link on hand. But the concept is very simple.

Think of vCMDQs as additional CPU cores to CPU0. They will be
able to execute the same ATC command as the main SMMU CMDQ.

But by doing arm_smmu_get_cmdq(), it would only get one of the
CMDQs, which can be a vcmdq (out of several) or the SMMU CMDQ.
And that specific CMDQ might not have a command pending, while
one of the other vcmdqs or the SMMU CMDQ is executing commands.

So, the point here is to iterate all the host-managed CMDQs to
wait for all of their completions of ATC/RESUME/PRI or etc.

We can do a list of cmdqs, and add each to the list in the
arm_smmu_init_one_queue(). Alternatively, we could add a new
impl op to defer to the vcmdq driver for a proper waiting,
if we do need to handle guest-owned cmdqs as well.

Thanks
Nicolin
