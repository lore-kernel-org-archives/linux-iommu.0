Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBDF8175F
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829689; cv=fail; b=FtzGpr77q0k+jPaEzwogYcxG4Hww7PkSHwt8YFF5hX1KZxZTaPT7waj1C8UNXxym3El4bvikR2b/pYi8TaWzDpLkz/5d56fqMWHA4emU7jQkNXSZ1DWOlJS3CEpryFSXTZhxMBvqbzdkMcb6JnQf1BPnVOUd2ZmS5N2Pwyj3Zks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829689; c=relaxed/simple;
	bh=iBD22BiUqiAK6hGYJ581lZod8dlDS1FCuNxz3sCkD4c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWACGioGMY2/OdmpUBBqYpRdqd2TYXGdqzJCyFh81HHRYkA05UQ8f19DtbsFv2hCMNcm1CeswvRSPGkvKqk+LCmIgoH6HVZKfHg+HP/+zUOJLkGB8vhVmro/GovGbRkF6bsJc2ywZo7DpC5WzZuamsD7bL53Z3JyH7gCLx+KYqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O92ERK7X; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O92ERK7X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7e4utxlba6zeRyKbFrVO4MIA4hbU0iUIxuB7kkO32ljb+AYAtuF3PytZZXG3sgcnqsZ9PKdxUFcWr4tdYR4dgylSRPJdP6H6SdJt5alDvcB+MciFtGMucBO3/yImJQqoJJde0GZ22oG6Tn/O4QVIv/w4npwKHFKl+CdqpR39edpFVaICTfSCV4aSKCs5cyKZX46VQgjP/TL029uLYreuqpqkjpbcIAYQNkG5seZ5gTRVod19ociZSfb8IxnFYbmNLeqQGlKiBOdWYAy6muibbDUafUOW8NFhUKk7eAFzlkmJ23mTPSLDpg5IlzCpiitJBO2ObaOFqGIRl6oXnim6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjp2neAZJ3uUHtvmxTy6k3y/hMkXontRvKAQyHh4TRw=;
 b=T0FU56t32kWkIvJNwjG390uhxdjrDs0MC9n7IyUpuwdP0NprTdYGIC94tV4e0QWFo0as6NE8vNF1Xnw/5sEy5EAmHh0A8ngvphN+YBFfWQWw3vlhaxUU5Nj9aFIp5NNCHmMc2xgm8et6LeretB4IWHja2q5YJcYW7/6F8we+ZKNsD3QqeZx/LHih8rx8w+VWN+jmrZaWu1mRLrEMNHscdBe6WHp5yejgLmijU9ghMdaLbUezTEWVN6f6j2a41GFAKHtSjNe4mqQ9FIwd8QBNMt35QgpVXXzUtuv7NnWJr8rk4LsA3jgqKfGB2xp575AgJTeTebIYUpwOwO0EGS5YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjp2neAZJ3uUHtvmxTy6k3y/hMkXontRvKAQyHh4TRw=;
 b=O92ERK7XT3GC4VKIYlAsVWbvogm4ZX5HLYqF41PWJ0hbZTC8b72Q+qWsJh46hY9UXfnD3p/9p9mpo4hdMk6zTEWfZ+B5Hsn/FuXZR+v6YbgOas8vxekM4i6pdpNnLfXJ4VcjN6UT9MiKryMZOq/I/OqaCkdwz0gccaXArC4oGxBp7gw11CIrwdcwRMJ2FXk+BkDov5JZxH5+oifu1IoKxCO7Vcz11FxZ0oILcV5RZPQwQGM6RTOdgMhc/gR5a4BiHJYFxMGrtpNksFeqBVRPrfr3aXc9N38Y+7IHhc3TdD0utL1rN5sDf8ub7S99Rx9HDvXH1JCo52RbTjTeYiGBZg==
Received: from PH7PR10CA0010.namprd10.prod.outlook.com (2603:10b6:510:23d::19)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 17:34:40 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::8d) by PH7PR10CA0010.outlook.office365.com
 (2603:10b6:510:23d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.25 via Frontend
 Transport; Fri, 16 Aug 2024 17:34:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 17:34:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:34:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 16 Aug
 2024 10:34:21 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 16 Aug 2024 10:34:20 -0700
Date: Fri, 16 Aug 2024 10:34:18 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v11 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <Zr+Nmq6LyrBTY6eR@Asurada-Nvidia>
References: <cover.1722993435.git.nicolinc@nvidia.com>
 <153fb887cf4bf6318c6f313a4be9b40a25a24e7d.1722993435.git.nicolinc@nvidia.com>
 <20240816132103.GA24411@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240816132103.GA24411@willie-the-truck>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbfdaf9-9a29-4dc2-a455-08dcbe19b541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WzhoJ961Wgnyem3g2EjVOZxv6uvbaN9mi+L8WGhAe4oUMtqpaCrBDGDor85y?=
 =?us-ascii?Q?i+TxvmHuq6yQeLQG++/tudF0aA7ECZ+LPh/Yg3PHkj0GA1eViOIXiJF/989n?=
 =?us-ascii?Q?K1q8xDOBYKBT3aa1QoiZe9WevugS6wYh//HHRbydio5wJszAq3yt17g3nd+e?=
 =?us-ascii?Q?6EqE+4BPZgt0xXKbagvKIQGtpPTg6eTTsPwYPILmsOCNNgIBO1/l18PPp/r8?=
 =?us-ascii?Q?5n8bx4CwjKIdoW7AP/tsCVO83hJwTv/YDi39LQyh4sxSeDw4/XKFeE0FtcSK?=
 =?us-ascii?Q?CD8bsUdtFAi2S1gYQgzGoblo0qVOlyVkgtX0x4vbHx+5W7bUdRphSv5kLe0r?=
 =?us-ascii?Q?iZrrnSTT/u4ITFCznu5oQBJwqHP3yWtajnQ/y1JYIkIugbP1yfBpuvvtH+rM?=
 =?us-ascii?Q?rNiE86B1wO/VhV6DJdKnVNhwf6jaOxUCmzQpevnrCsqfez8rFbpUCGzWG4mA?=
 =?us-ascii?Q?l2Gc7IU84avzcqVZni2rn9JEaQrjLwrRO/tD2NuGjoT3DHkciLYSTfhaQ17W?=
 =?us-ascii?Q?qQPN5rW0Uupyd+i671YNsz5qf/92nZGy0xxQLjOL0HaFdVH4AaqGdfvq4ZzP?=
 =?us-ascii?Q?skofFlzi7fdR5H+mQX6Z6qpAWfEps/KgDo7ciKzSkIwztQna3ARXG0W7khtQ?=
 =?us-ascii?Q?+tM32xiBQEQm89HYhKMOLLL03YYF0bUEe5mc9XwTQIO9Dj48Urdy4Ldx76lw?=
 =?us-ascii?Q?/zU4ov1GZzVCS63i6BPvrJQWIAXYzFNRlj75gsrLrw5YsTTDOg6KrE7IzpQw?=
 =?us-ascii?Q?PeG/LWqKsZChSOosYJpue3EzGM1ciz50SVzrgVAlItn1CvH4etLsAqZsLNye?=
 =?us-ascii?Q?Fe3EmPRwsr0IXNhC5acC2b4OMV9hEbOkcnQWg/OKX37h6v/gkhjHH3qp7LPa?=
 =?us-ascii?Q?zVLRlxvoNF1ml/47NMhBQFXqKYelV2yjNWM9/e97CdMg7XQchk46dALbDoI0?=
 =?us-ascii?Q?El3wTqaD54E3hXmk9RUbg/i7Yo3Yzbcw17I008fvRkqFIs7tcQzN4WGkeJEn?=
 =?us-ascii?Q?tdz6DLuvqkSRqR2lzlurXmQBZSZN7TYUW+fRbpTfdFLSb2vdqV6XeJn+tAgi?=
 =?us-ascii?Q?s51mbOPlKCxxYiN2Uzz94o2gc9MfxWK5/eB+iDH6SX+v7EWYp+Lbs7uFPEsn?=
 =?us-ascii?Q?ApewXZto5Oi20W5HKr9UvNnVcZwhTDT+qlahT6u30mMmr/ISn0sWB39jbX6U?=
 =?us-ascii?Q?olpm2hSaOXO1r1AupV6VIiriYypqgUQfqeqrIytdGvVuPJe5tWqVbAkbEfba?=
 =?us-ascii?Q?VcnAbJiJX1iOvqCLneknZ9WrTF9WHV7/9dEGnG6cOAX00DtofSI1U3RJsy0I?=
 =?us-ascii?Q?mqVpYj1+WwXcDxNVslKAxWOLyBwKnOb9y8lTHD5sgO8u0el2idPbCjX8m12e?=
 =?us-ascii?Q?1QCPJvvpx8cFmL+kJVkOEDkW8K2URPNEqrNvmFOs1Fi5sj+1bwliWCQSoyoR?=
 =?us-ascii?Q?Yu2AxRrVAnqYvBKwvqvVxSxktmusvbOL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 17:34:40.2330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbfdaf9-9a29-4dc2-a455-08dcbe19b541
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

On Fri, Aug 16, 2024 at 02:21:03PM +0100, Will Deacon wrote:

> >  static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
> > -                                  struct arm_smmu_cmdq_batch *cmds)
> > +                                  struct arm_smmu_cmdq_batch *cmds,
> > +                                  u8 opcode)
> >  {
> > +     WARN_ON_ONCE(!opcode);
> 
> This seems like a fairly arbitrary warning. Remove it?

OK.

> > +
> >       cmds->num = 0;
> > -     cmds->cmdq = arm_smmu_get_cmdq(smmu);
> > +     cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
> 
> If we stashed the opcode here, we could actually just enforce that all
> commands in the batch are the same type in arm_smmu_cmdq_batch_add().
> 
> Would that work better for you or not?

A guested-owned queue is okay to mix different command types:
	CMDQ_OP_TLBI_NH_ASID
	CMDQ_OP_TLBI_NH_VA
	CMDQ_OP_ATC_INV

So, limiting a batch to one single opcode isn't ideal. Instead,
if we really have to apply an enforcement to every batch_add(),
I think the cmdq structure would need a scan function pointer:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d0d7c75c030a..1a83ad5ebadc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -918,2 +918,10 @@ static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
 
+static bool arm_smmu_cmdq_supports_cmd(struct arm_smmu_cmdq *cmdq,
+				       struct arm_smmu_cmdq_ent *ent)
+{
+	if (!cmdq->supports_cmd)
+		return true;
+	return cmdq->supports_cmd(ent);
+}
+
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -924,4 +932,5 @@ static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 
-	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
-	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) {
+	if ((cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	     (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC)) ||
+	    !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd)) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e131d8170b90..c4872af6232c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -616,2 +616,3 @@ struct arm_smmu_cmdq {
 	atomic_t			lock;
+	bool                            (*supports_cmd)(struct arm_smmu_cmdq_ent *ent);
 };

That being said, the whole thing doesn't seem to have a lot value
at this moment, since the SMMU driver doesn't mix commands?

Thanks
Nicolin
