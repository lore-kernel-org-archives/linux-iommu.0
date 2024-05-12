Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F15337D
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551778; cv=fail; b=QGJU+6TNAvk0C2KCP0Rd2J3u9/8F7f36fJSoHGNDl4JL6YUlJd/gc4mYKhjqK/Y7eAKqJHAQpxrEnfOveqzxoW33ifgvpGsijs1Yr3CSOB2Qw1uRPDwAmBBv4QN3xCqamr7Ilvqpc6TB9l4LKLsx6+yLRJ5UZ7SD0BGsaVEaz6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551778; c=relaxed/simple;
	bh=JniRnOaQtfAIZx5RzCiSQa/aBK5Soe2sYPkLPQBGv1Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQgXbyVwVuVZVUHvQgjQH0dE2aJwQy7nD8xKfRC1628Q0laIynkWkDWPoJCztUB3KH9JsfmgvwYy/eyTQ/Hi+gruAJsHhf8djC7qXM1mMCmrsl6MT+5ryjnAtBRzL7vq2KLk7AmkmxX9E9SwNQKp7CG8orlSF5wCLUYcxMgA+gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g9/A4dPI; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g9/A4dPI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csa1e5YYdvw2yXMoostOnjwtug8+IKI02eaAKGa8DdtZm+DvJQRxtCYeIRB7XVHhf7Vj0eevhXdlyxaNU2038vhoLV2nTLmLLwhvh3NJaoAVZYMHlvwqByc6pcWQ9ckb1Wffta1YJCoTU5rOVXxvVWK6oKFF8w+y76DsnIZ7g5FZ/uB+j6EQa5wMM62XvcV9CBKUZOByjyKyyORbw8+SY9f2C2HKQpwsllJJ7wdpz4/VhDByiEE+a6mExQzr2QgYLV4EjqCib8lEuMEADlh8qCRMoBIpu/8GHao1lQWUqI9zlp1EPkyJF9sERjiJi/+C7D+3UVpTUazfEAdiJmaaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IIWzQo0+TrhcddSbSOgYe6FQOKtjB4jDvUekdcGdsDM=;
 b=XzuWRN8QixXZZMe27NC6ZbvFsgd19DWAAbmJhuV5DxH+h6xPWbkc2Xf9pg+9l5hZuOw75U7kqBQQnb9yRLuGpCXpMkHEdLlQ0qJkVAEgNWM2Gl1hpHmtqSUygQJwhIUV3cQyyc8KF5Tr4kp7laYyPMdtBTCI90S9Qqag4ooQamN7HneKpTXghVbJrzyHU+Q7M2S4r3S7jbV8OtLJ+zetJRIqAELjbCJ57Xt0AWcmKNFwa0QG8hKge/SK6xIv5dBAlHQCZTTdh2GjwA8ndaAHD2rpS0SX1toB06De9OoyEVMuqtP2ldbVWZEIr9ho9bmkfXUvwIdD7FKwXQk6lC2hwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIWzQo0+TrhcddSbSOgYe6FQOKtjB4jDvUekdcGdsDM=;
 b=g9/A4dPIj97zGNV3VRcjtvYl7x2WjOz44R67GRX9A69l8FDS7C1/2jZWPcZhJg3Q5um5MB6p/9Li7uiOhmwpoHe6JwcH9OSjL4/pmbyVcB2IPHgY3juaj1dtNNDWeRJOT3y8213R6tiOb7GXuw0cSDJzCDEUmxnzfJGZ/8BhN5YebVThyDNpXv3N6TFn92vPgFsCWxPyRqfylaW7GdvpZNBusHXp1SXXaojS9PRDC6K27gr9/zzdH9HTEQgbs4dzkDNW/p7h8sREo0eVWctHQJRjTUvfr/IBWvh5q02OLBJX1Y+JUWZgbv4S9feCZzzBxTqfdAQ8F3+G0ukEz2Qp1Q==
Received: from MN2PR05CA0047.namprd05.prod.outlook.com (2603:10b6:208:236::16)
 by LV2PR12MB5966.namprd12.prod.outlook.com (2603:10b6:408:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 22:09:32 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::f3) by MN2PR05CA0047.outlook.office365.com
 (2603:10b6:208:236::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.22 via Frontend
 Transport; Sun, 12 May 2024 22:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.21 via Frontend Transport; Sun, 12 May 2024 22:09:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 May
 2024 15:09:31 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 15:09:30 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 May 2024 15:09:28 -0700
Date: Sun, 12 May 2024 15:09:25 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v7 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZkE+Fa4BS+LTxvgi@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
 <ZkDo9US02pD6vysO@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZkDo9US02pD6vysO@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|LV2PR12MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e391d4-219c-4a46-1569-08dc72d03391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k0mPt206xtCP/qRkGTcoOQJO9ilKSji882Q8SvDGt8MOhdZlfBcVyeba7Ebo?=
 =?us-ascii?Q?+vvMN3GVN4UBohpOtutwWkK00OqihrZ6Gu3SjbO+VI0TLWmsy/7JHjWU72wq?=
 =?us-ascii?Q?yoicb18uOtY50NvDFFM6HJsjcMNOns7VtwBApsBODfbMq2nRqUZlPtsoGT9M?=
 =?us-ascii?Q?NwWS2nBknn9ou9vp22CifDh14jtCWtB2WUOct0PGVTA6UhcvAO2OW5qnkb6c?=
 =?us-ascii?Q?a+mlUYFzi19Sd9zGkvaj0kMXNV20MXjdsw/2uh7NXvsfWFvE9jW22ci6DKkP?=
 =?us-ascii?Q?pKRk3U2jp/KwFBj3KWGcwzjPEtZtZB8PjCvGlrqkNLWoINeZt4NBoGO7SHPA?=
 =?us-ascii?Q?YO3vSP8oWWz5c4M4kZFUSSlYk6v6a6IWtUys3NEd93P6ob6v2yaUD8GLoI4R?=
 =?us-ascii?Q?2HjjlRWI7uYNWECHB/dodGG0v61vIf4ltDM/Gmp+edbZbKrH+f4brFhVlyKU?=
 =?us-ascii?Q?xJHP7k5hpepkla0iwyW8mS/l7PjwwLBjOyliZs2b9458fiW+P1Z1LLyUeaCb?=
 =?us-ascii?Q?CklcdUkK6QCtLE61zQE4m7+dJAqbzXFcgjkPaYxug/dJWZI3VwS/Qa0SCeS3?=
 =?us-ascii?Q?5AgfP4RUEV/kdzvMsoOXOCbBXBBATvro8OQ3BhHtyjgi0O8tpwmr/QvOL19w?=
 =?us-ascii?Q?gw4yU/VrTWn77TxnxDTpanomxGc8oMyZh0fz/LQMumgV81opTOlX0/mvB8s6?=
 =?us-ascii?Q?3be6bdmwEbLmyE2orGxvNIqQ8+m2fAJrU7VSRNNP/ksZfryadcJ8wAGht9MX?=
 =?us-ascii?Q?Z8AVUMHyUFAHom/Z2WZoMm7Azsc/hgKTRjwOntGQDbrUAaRNHf3sZox6rerZ?=
 =?us-ascii?Q?emDl4Ki8bLPLBWbhfKNqgPYuKdyWH0KPUcZRCBcv4kRBswV7gGpEGWKczUVz?=
 =?us-ascii?Q?UZHK00aj4VgRHeLTJhyG8KljJEfg2RkMv5WaOGVQY6nN4XNyJADEm1dvUHlr?=
 =?us-ascii?Q?qzB9PWbsR9o8A5caPEwRLIFwqYy3rpmRnZdWRJYwwdTzfcdNUNtVIcuDh8Co?=
 =?us-ascii?Q?y25frKkmLehdosUn9DEFfc+JpTtxK/Id4jNJkit9ZQTfIfEh4e6I0Uwlu1W/?=
 =?us-ascii?Q?DoUN/zt2ZwlqVIUaOmAvh8idPPQ4IXrBWkIc0KXEybQo8TCMgCep69S0TXll?=
 =?us-ascii?Q?fsK4Kmys13M92cSJ9S4aXhLIiGmMVGAbwff3EPI5eR+OVAhUZ/+k5vWP1CjA?=
 =?us-ascii?Q?J1YrKodurubvT+uQb53WBX3n9OQ0POTgGQ72rg1PsYZGbzS0NKLFKSo06o9Z?=
 =?us-ascii?Q?/3Wb+6wUFZGWJYHLTLUGNOi7+QBH2D/bDv3Cb2X0eAs5PFAJFO8eocpuE/NR?=
 =?us-ascii?Q?YLmwzz60YRgfUpkVBFSHEr0FfqjuvKZHQs6maUU5osF4RpIonJPqTMl3qYx2?=
 =?us-ascii?Q?MYCERNccS3rjzeIq1szQ4eklfMJ5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 22:09:32.1646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e391d4-219c-4a46-1569-08dc72d03391
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5966

On Sun, May 12, 2024 at 01:06:13PM -0300, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 10:56:54PM -0700, Nicolin Chen wrote:
> > When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
> > only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
> > add a new helper to scan the input cmd to make sure it is supported when
> > selecting a queue.
> > 
> > Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
> > guest kernel driver writing it or not, i.e. the hypervisor running in the
> > host OS should wire this bit to zero when trapping a write access to this
> > VINTF_CONFIG register from a guest kernel.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++-----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
> >  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 36 ++++++++++++++++++-
> >  3 files changed, 49 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index d1098991d64e..baf20e9976d3 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -332,10 +332,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
> >  	return 0;
> >  }
> >  
> > -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> > +static struct arm_smmu_cmdq *
> > +arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
> >  {
> >  	if (arm_smmu_has_tegra241_cmdqv(smmu))
> > -		return tegra241_cmdqv_get_cmdq(smmu);
> > +		return tegra241_cmdqv_get_cmdq(smmu, opcode);
> 
> It is worth a comment descrbing opcode here, I think.. At least the
> nesting invalidation will send mixed batches.

Right, this makes the "opcode" look bad, though we know that the
"opcode" in the nesting invalidation doesn't matter because VCMDQ
in that case supports all commands with HYP_OWN=1.

> opcode is sort of a handle for a group of related commands. But what
> is the group? Minimally it is opcode + SYNC, right?
>
>  The caller must only send opcode + SYNC commands to this queue.
>  The opcodes XX,YY,ZZ are interchangable and can be sent together.
> 
> ?

The "opcode" is intended to mean the opcode of a repeated commands
in an arm_smmu_cmdq_batch struct. And it is based on an assumption
that the driver doesn't and won't mix different commands into an
arm_smmu_cmdq_batch struct. Though it doesn't probably matter if a
batch mixes NH_ASID and ATC_INV..

A CMD_SYNC, on the other hand, is outside the batch struct. And
here is another assumption that CMD_SYNC is always supported by a
VCMDQ..

I could clarify the "opcode" here with these assumptions. Or maybe
we should think think of a better alternative?

> > -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> > +static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
> > +{
> > +       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
> > +	if (READ_ONCE(vintf->hyp_own))
> > +		return true;
> > +
> > +	/* Guest-owned VINTF must Check against the list of supported CMDs */
> > +	switch (opcode) {
> > +	case CMDQ_OP_TLBI_NH_ASID:
> > +	case CMDQ_OP_TLBI_NH_VA:
> > +	case CMDQ_OP_ATC_INV:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> 
> When I look at the nesting patch it also includes SYNC, NH_VAA, and
> NH_ALL. Are they supported here? VAA is not supported in the HW at all
> right? What about NH_ALL?

In a nesting case, the host-level VCMDQ runs those comands, i.e.
HYP_OWN=1 meaning no command limitation.

Thanks
Nicolin
