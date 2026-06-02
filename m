Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838530E821
	for <iommu@lists.linux.dev>; Tue,  2 Jun 2026 20:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430939; cv=fail; b=VdYi79s15aoIbufSE/7LLa4IZ+2Sxp6GQroXHhB5WHCguLucifogsLDGGj87n6M1hpIZdyWtDME5ZiL/o1o2gRYxntCFxdYNIP4DsJqRDdg4pqZbfWRl+LrvUNoL+fyqcQ+ppdRxLUGhk71gY69aJgn5dnZt3iwFkwWFedSVGf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430939; c=relaxed/simple;
	bh=GJwtI2rGZ1Y3zneRsm+dkrrB4z6Qzeha2GWWUBNJKmU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iw4o4Iy7TbofParkn6r9blu0pIbCq2A20f1/LEQWxTff7r6ELz1845YvMRqvUZEHXLCOWsvDqwfwf+YNZ4XonPX8qXYt2oZUZVBmL1UihnTCwAKMXF7yeRdwNkZlMkDH7/7JRjFFzLwyW9VBflLy0ezvx4ALceVezBm9/73MkHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOREbIX4; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOREbIX4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Um/3YL4faBCTPcwx5vn1sMwGAYvqDwyePrnjJLstU1LZ6dQ8O9FxgBS1xsdOPp5Uq1H+B5eMEUNEwU5Xyc0tnWTQx0mglpTX65NEpc5xysxyX4BZVazP2EChkuFQx3d/kfmn5KxUkqWKZE2Kgvm1EMBYLorp2rqsr0xTMhzXUhPoIM8Te0SgFcL52SPuykQzdssCIAuaf+iDTEgOWKBdawbt4on5B6+ePW/Fvs3nGOmoxVhVl00cVui79Ao3gH/bpM3tmwF9IK5c4KdLmf5VJPUMsg5sGjfRoQ0TPl+/1CgE3WY9HgvDxd02DblcxS+bkxbj7BsIxwKCbUP6b2M0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQ4yPCWJPSqlf2QBh6VwmQTglCZncATRGx8sl2eUSRs=;
 b=V7QtfpntsK5Yf3HIJmScYWIRovlRLj/io6b7nIqL2MP+RovqFfPl47OABZcPVOzFFPNQQQ6bWKN0p2JX8dI9E2560Mok+rFbQRtw6dJMn6un1PyltpcW6qXzSnc5ychcD8gxwl452/GbaUPU4tdTa6dpuTCbaverlDwJI9DrpQZgaBeCgIOL1ReZAFxbsG1xwsvMx3aLerLPGxH7NvEka97SKZSocC+pbhIL+hwVnmRCwawa65AjKarPltSHMkACesuKL19PRSDj4F+dz3q1wXW1zQo1Hh0Ob2j4VcDWdZHxOwLxrWdj6wts41C1VtGYexJGeqEZHq0H8ZfolFOOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ4yPCWJPSqlf2QBh6VwmQTglCZncATRGx8sl2eUSRs=;
 b=kOREbIX47+lFPcaGkdDc8/CQqGwB/vTk5Orwe4do2cmM7b9ndPVETZSbStrWrRspgPA6Rr7x5vI0yVbTfzG+P7cKqEuorCaIAY/3Nj9KyprK5+9XC+Cu/2l3q/PMYcBhUbfTWC9u8m8T90JQscsuMbaAHf0CzjOG+DJIJb65gi+jKwicK/UFX6OlOzzR0Kv7u+QE7qUUEyYbkawTs+bmc6+D8B3Jr7uHwbna5foWlKJf2LfZh4gUTAZ3SQ0kojplZmqW1Lo84cPi6LB4KLb1UM5qnqZC4XMI3DT1XsekPfR10JcZG8ibKbFtrsxONIBBDqpogJQMD46PzrRsIORnMw==
Received: from CY5PR17CA0032.namprd17.prod.outlook.com (2603:10b6:930:12::28)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 20:08:50 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:930:12:cafe::29) by CY5PR17CA0032.outlook.office365.com
 (2603:10b6:930:12::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:08:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:08:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 13:08:28 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 2 Jun 2026 13:08:28 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Jun 2026 13:08:27 -0700
Date: Tue, 2 Jun 2026 13:08:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Ashish Mhetre <amhetre@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iommu/arm-smmu-v3: Factor out CMDQ batch
 force-sync conditions
Message-ID: <ah84OmisAm8805FT@Asurada-Nvidia>
References: <20260601104845.995005-1-amhetre@nvidia.com>
 <20260601104845.995005-2-amhetre@nvidia.com>
 <ah81HhVW7_h9xyDM@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ah81HhVW7_h9xyDM@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cb20eb-8eaf-4a29-68e6-08dec0e2c2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	PQJzXfpb8SG3q8VkRZZdBPCobKHjcwDlWTS+wUyO9Il5+MAbuVfJXyseY5fBeKVxci0JSJkrwMmAeTD/bWcIfQJpXxAocCKaN9ptBYFDsYLKLaMe7aSMMufDswdMDx+ZwkJleQSHTuK6rA2FTa9LBZk2kZHgRwmD7MarY5ogrfAC9ksn8PWChysJ0wb0NcB4ms/rPHq9YrEOVB3SeniPZQElAV4YngaE6qem/8Fni8gcSB5bN9vdjArzlQR3n1Edx1rBI1YsrAeTUJ7gQL8RfpWJYgOBcM8jaYaQQYKTTO7FuirpyQ2d4YcRuQXl3+WlGYsQbwasMbRUGrkTR6xsdNuVAzBoieENX1PrrJvZ6Me/KZeZq84e0A5p17vIPpu0OoSf4AI3S1dmv+QtreatD6UJroPP5lOZeHw3Rl3qqzpSC7ZHDrnHxPrVyY/Lh1taEn7FZ5PB8m1UC/dmmVr1Z8un9T5rVJyuI7mdOzVDtIdgubaR1cMoyJWGG+Uoqg4U1eg/GdRvQJUx0YKf9z3rQkqWEcqR24BQo4oJeZXCKo19UG76DvpHep3JicZL+4ZWuV/DVnMvu2i6VKwGuvu/XBPkzM+t8/dMjrVhQ6Po0NwC5QdhnC360XnSByP3YwUUUOjs+XuNnguuBJ9AEpjmHgjb6gUAbvbhpOq00DT8tmASTZOq7f3uaaoswfl4V9o2G/TuFbfmi8RF+jIJRg2vFGPCUbFBZdfwDD/JXHxqE64=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	12/JF6ehxvEA7Wlt4eeIV9GZxGdwMosZZwqEVTGLKdR+EKVawrxmcScVL0KcM4G4N+xts2zf4jpqpZLCrArjzHxnift+mP2MrESdHgKvlhNuvGmoGDEBVG1UFM+CCK5//vVyNaeVwPxFKchOpfqbLCSse18fMo/sqfFs9BOZ6kGqOTBQ1kkenrj0akCiMfdYyFmI44uDEgr+kQbi7HGw15LhYVgD4VqWXq/1WwkQcP2lA5eljkbJcUzvZLq78shxijIIDP9J0MIkID+X3vOdqWsfHWIB/tFs2JZXVxzxYrtlluH4LVNnqrxHvyaI3rAaKeWZB1qB2ZM/MjIGQspvzJW3M/BCiHueq0sZzmAtwurO9qqmFmeqoib+D7bP31tJD+KcUo5PeKMPL02RagqtgGL43bXtWQCN1VfLsnhpeirKD02a9Bh8+zrPj0awrWc+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:08:49.7273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cb20eb-8eaf-4a29-68e6-08dec0e2c2eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

On Tue, Jun 02, 2026 at 08:55:10PM +0100, Will Deacon wrote:
> On Mon, Jun 01, 2026 at 10:48:43AM +0000, Ashish Mhetre wrote:
> > From: Nicolin Chen <nicolinc@nvidia.com>
> > 
> > arm_smmu_cmdq_batch_add_cmd_p() carries two distinct reasons for
> > flushing the current batch with a CMD_SYNC before appending the
> > new command:
> > 
> >   - The batch's pre-assigned cmdq does not support the new command.
> >   - The Arm erratum 2812531 workaround (ARM_SMMU_OPT_CMDQ_FORCE_SYNC)
> >     forces a SYNC at one entry before the batch is full.
> > 
> > Lift those checks into a new arm_smmu_cmdq_batch_force_sync() helper
> > so that adding another force-sync condition becomes a one-line
> > addition. No functional change.
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 9be589d14a3b..4d29bd343460 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -847,16 +847,30 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
> >  	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
> >  }
> >  
> > +static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
> > +					   struct arm_smmu_cmdq_batch *cmds,
> > +					   struct arm_smmu_cmd *cmd)
> > +{
> > +	if (!cmds->num)
> > +		return false;
> 
> This check seems new?

You are right. Maybe the commit message should have mentioned that
there is a slight behavior change to the unsupported_cmd path:

 - Before: if cmds->num = 0 && unsupported_cmd, it would issue an
           empty batch (one CMD_SYNC)
 - After : if cmds->num = 0, no issue on the empty batch

With that, I think it's good to have?

Thanks
Nicolin
