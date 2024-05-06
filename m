Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2040.outbound.protection.outlook.com [40.107.101.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9802D051
	for <iommu@lists.linux.dev>; Mon,  6 May 2024 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714967562; cv=fail; b=TLaaWY3eYywPgb/3xFOxo9YVaOmiXCfncunFiRNiGE7KIDDld5jIR0DcuVI0f97/LyzwzZgf/gpxMRCkGVBeGyWsM5/btnxSgV+ZAW2mZwb5jaT5Hg3uf/jt//CGwUBP3ktuQMdUXHxE0+yj1UqvyYjYcyfWnxpIPsSgmRJYKCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714967562; c=relaxed/simple;
	bh=QL9co092w9BkhGI67gTOjFQh8HmjSNK/xPIBk2ioviM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCMN2A3hv2GQslkhmVe5gWzt/Pqd10dvwb/0Ti29gdRp60Gr6XoOTQzF6qDWOyqhS/+UlKAzTf9aT2rc102vzU8OYVvqUPXRFexT6isnAjX6Jl9zAVuZ7MLDq1hCafyurHrpnhNUD3wptesoP7LNa/2oGjas43Y/XpVMHJWHWLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ly0nX7IL; arc=fail smtp.client-ip=40.107.101.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ly0nX7IL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfILj7SeulbZjU6lISzRqeTgu56JIs1pdEcMX0cHocKDYwhNimfIDHrhp3h/enKCUyvr1acEgQKZWA22vNRhs74p1CCSVlq1kj3O3yhgxF2y5ssY3idkAbw7U+rbkx2FNKyNZivfOJkF05zGVax92BITbnrrSIWHDpumuXZspRbnkSx+XWTCFXRhhh4vsa4kS/76SgJzONTPjLI584IzWwwcOpC1jKVUh3gxzAM9DD91Ff4AQHJgO3KJhfY/kvIxJvjRMrDi8x/l548fI7/AyQEn3EO47HRrdPFkCDCl7TqnQcEce9rBX2nvENpMSY9NWZfUoqyCQ0p4/Rh1jsuanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knks23Lp/tDDa7Uj/vKhQYcc1tX3DtIu8FzVg/6RctQ=;
 b=jPRrqL275HITedvGK/GPzVs8+I0LTzeBU/XOI0Mbb3c7WrB3N3AJ9WBUpvxPil5c4ElZ/WEWt/C04iYI5z0MrZpZ3BU3jkpd81szAFXaPj7Q2mOc62NG5AIGQTWjlvjEWFQD1SwVOskSOXVBWThdyDDDYVDHrVHXokI7F20YN6fqDWflVPtMlrkxtvUzk8fXYegFw9m7GKEkDpDgJGe5P2l7ClyOpjcImc8F+mFk6zazlpag4/rpxHOgrziNr0C84moj3YOwogOWH/3o8QPMmG8Ht3oW38PwfL7qHecymGMyJp/K5B9niOeRvOkEwAQk8Syc04N6CRGXIHc+D4RByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knks23Lp/tDDa7Uj/vKhQYcc1tX3DtIu8FzVg/6RctQ=;
 b=Ly0nX7ILGVLj9AaZH6qcSKfvVxz99LhmRaEev2iPICp2OAiF6WCf01A8mZcudvZmHLvXdAnXhE3LnGPcjEzyf6BmsmhgqJFsvR9W8wnme9Auqb+G+Ox4bre85NE0OESJ03VqD4YvEKu0keoYiSFu8ZFfLfNCbjS0XOphXmisYnRPGHccps9JV5Xo15Tx85QJw6q4NZTc5dohiFbg8bSSnT753PYxQo+etenOn15qDRldDNXV9nd12OJCZdnkbRRTJ4eZgEFtQ/c2I5qIxRBFh9Apixb9QJoyUexCkhQJn7IexsS7Sutf9iQ+akfnc02HG/MO998hgEczVEBMQ4VzwA==
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by CH3PR12MB9022.namprd12.prod.outlook.com (2603:10b6:610:171::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.40; Mon, 6 May
 2024 03:52:37 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::37) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 03:52:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 6 May 2024 03:52:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 5 May 2024
 20:52:34 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 5 May 2024 20:52:34 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 5 May 2024 20:52:33 -0700
Date: Sun, 5 May 2024 20:52:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZjhUAF07Co25F/qe@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <4ee1f867e838b90a21de16b12cf2e39ba699eab4.1714451595.git.nicolinc@nvidia.com>
 <20240430170655.GU941030@nvidia.com>
 <ZjE/ZKX7okSkztpR@Asurada-Nvidia>
 <20240501001758.GZ941030@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MZU88YI6+CvwWO17"
Content-Disposition: inline
In-Reply-To: <20240501001758.GZ941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CH3PR12MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 471830c9-959a-4734-9e7e-08dc6d7ff840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gT8KKXZbtRc1LOfSE1TJy2DoXWl8l84cFCJRzEYyVhnBVIqTk5bIzqfIObTB?=
 =?us-ascii?Q?m39+65xRZh0zb/UuhxpSq3VIbv2qmUw3lVcoFSA0nhCEqb/6KGGksyngMb1s?=
 =?us-ascii?Q?62XaLWLK2B0hY/1ygTFCRHuhOB5xda2EmERD4KGCUTYdOGG6aTfPyD73Ot9t?=
 =?us-ascii?Q?B53kD2JMaetZKeBJ0R+y9cV9Eal5p4KLzcyrAeIXHjvq3LySngwSH7TIvm6B?=
 =?us-ascii?Q?5olWYQCLADFbuInjVSe/D+G3wExfDRVxCe+7oCvQo+SppGfUTFGLz7ulvKFd?=
 =?us-ascii?Q?CKC5lZTOcwcepwcsDdKrTIx0Y+qoGs20Ks+W5tyyQ4bmHP4aZ+E6mHe4DUM9?=
 =?us-ascii?Q?k4cPjyPTSSqwOaxrYaIc6RodNijzFITx4aI0+ywPkduaHpitbVux184ymfEv?=
 =?us-ascii?Q?VQEgZb4/2HmAAPk09WUzCFSqIopzn6jH6ckNU06cdHwX2NRNr7RuhNJ7u3W2?=
 =?us-ascii?Q?aYDiu9XwaS7S0vQazy7vc8k89sPW1yzzh0iMBB8y7IZzzlZPQj4CUudgvKBh?=
 =?us-ascii?Q?NlG+a1eoUjoV1fWQeghxNIO+Si742cWNVByc99xIpPAFuFdRPRsvfPJ+pHbo?=
 =?us-ascii?Q?OM2wSIu5UNXVJTLA6TGR7Oq8xl3WOui4ynid3SoSKE2W7tVtt/V7geEsOrpi?=
 =?us-ascii?Q?lE3zEepQ5ExlHSLyNIKT9qIkTnjWSaHtlxHaBvWBmw6pLYfbwz0jI7vI7Tzh?=
 =?us-ascii?Q?wJThMeoMH/GGAQwI745NkbTu7YobOE9eRWYqbIfO/kD6WKC85SoK4ZHmwTXc?=
 =?us-ascii?Q?JuX6lcuz4thEzMGPvMOjO2pSoqeWb1fn02gUXSvbUfH+oip7FEEu2hDr8K8t?=
 =?us-ascii?Q?hJfXqWQShjCgdBlkpwVpR8Pj+TcVaVVHXEpYz2N8Bz3FfMzF/afo63kVTX+t?=
 =?us-ascii?Q?DFDqTj3C3NoyOfyudB8JpualPGE1aRlKUNdPgLDadI8OezPODJx7Y2d6ROI+?=
 =?us-ascii?Q?zkFahNfE3JTMd/6FCog5TzNMrNPyq+11HHFkXXkkr41fCFGrMGZMNJo63wte?=
 =?us-ascii?Q?fStsgI4M3xVMAw2K1OXtBzMI7zSpUN63fxOOP0R2If/yRy8wnp95WjmeQlrc?=
 =?us-ascii?Q?yboyvt2YoWhy3nrVoPzVSk8h+MjOMAX0/CqKBpcKartyHVJja8FMzThcS8K1?=
 =?us-ascii?Q?UagmokrQYZhIjX+ELzmH1A2Zb17xbmYdQh0TaNvzsiGc2k+/Sx/GqDXBnLct?=
 =?us-ascii?Q?1cNUG8X2B+Yodw06NBV7zx17ls6XNZG+766YjuV+YmqfLPrTDLE+jQu+Pwye?=
 =?us-ascii?Q?WVGQ7/DxzGEdlihPB6cpBVKU5Uv8ucoofUiB2LJo74hbjT0UgqUKO+RPNsN9?=
 =?us-ascii?Q?tGv1G1Ca3IVdS8KgjFbrA9NdyMRHAClLtqx+vcAZAPhjDXJ7gmrSrBECvDpp?=
 =?us-ascii?Q?TL/Li17XpbgsKYqi6c3U57D8OVLl?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 03:52:37.1463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471830c9-959a-4734-9e7e-08dc6d7ff840
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9022

--MZU88YI6+CvwWO17
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 30, 2024 at 09:17:58PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 11:58:44AM -0700, Nicolin Chen wrote:
> > Otherwise, there has to be a get_suported_cmdq callback so batch
> > or its callers can avoid adding unsupported commands at the first
> > place.
> 
> If you really feel strongly the invalidation could be split into
> S1/S2/S1_VM groupings that align with the feature bits and that could
> be passed down from one step above. But I don't think the complexity
> is really needed. It is better to deal with it through the feature
> mechanism.

Hmm, I tried following your design by passing in a CMD_TYPE_xxx
to the tegra241_cmdqv_get_cmdq(), but I found a little painful
to accommodate these two cases:
1. TLBI_NH_ASID is issued via arm_smmu_cmdq_issue_cmdlist(), so
   we should not mark it as CMD_TYPE_ALL. Yet, this function is
   used by other commands too. So, either we pass in a type from
   higher callers, or simply check the opcode in that function.
2. It is a bit tricky to define, from SMMU's P.O.V, a good TYPE
   subset for VCMDQ, since guest-owned VCMDQ does not support
   TLBI_NSNH_ALL.

So, it feels to me that checking against the opcode is still a
straightforward solution. And what I ended up with is somewhat
similar to this v6, yet this time it only checks at batch init
call as your design does.

How do you think of this?

Thanks
Nicolin


--MZU88YI6+CvwWO17
Content-Type: text/plain; charset="us-ascii"; name="cmdq_limit_mine.patch"
Content-Disposition: attachment; filename="cmdq_limit_mine.patch"
Content-Description: cmdq_limit_mine.patch

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5775a7bfa874..b1334121f5c4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -332,10 +332,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *
+arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	if (arm_smmu_has_tegra241_cmdqv(smmu))
-		return tegra241_cmdqv_get_cmdq(smmu);
+		return tegra241_cmdqv_get_cmdq(smmu, opcode);
 
 	return &smmu->cmdq;
 }
@@ -871,7 +872,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -887,10 +888,11 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds)
+				     struct arm_smmu_cmdq_batch *cmds,
+				     u8 opcode)
 {
 	cmds->num = 0;
-	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+	cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1167,7 +1169,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2006,7 +2008,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2046,7 +2048,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, cmd.opcode);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
@@ -2123,7 +2125,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, cmd->opcode);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 604e26a292e7..2c1fe7e129cd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,7 +879,8 @@ struct tegra241_cmdqv *tegra241_cmdqv_acpi_probe(struct arm_smmu_device *smmu,
 						 struct acpi_iort_node *node);
 void tegra241_cmdqv_device_remove(struct arm_smmu_device *smmu);
 int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu);
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu);
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u8 opcode);
 #else /* CONFIG_TEGRA241_CMDQV */
 static inline bool arm_smmu_has_tegra241_cmdqv(struct arm_smmu_device *smmu)
 {
@@ -903,7 +904,7 @@ static inline int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 }
 
 static inline struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	return NULL;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index b59f4e31a116..22718835f4be 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -181,6 +181,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV HW
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: CMDQV HW pointer
  * @vcmdqs: List of VCMDQ pointers
  * @base: MMIO base address
@@ -189,6 +190,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **vcmdqs;
@@ -321,7 +323,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
+{
+       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
+       if (READ_ONCE(vintf->hyp_own))
+               return true;
+
+       /* Guest-owned VINTF must Check against the list of supported CMDs */
+       switch (opcode) {
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_ATC_INV:
+		return true;
+	default:
+		return false;
+       }
+}
+
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u8 opcode)
 {
 	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
 	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
@@ -335,6 +355,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return &smmu->cmdq;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a vcmdq to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -523,6 +547,11 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel
+	 * regardless of enabling it here, as !HYP_OWN cmdqs have a restricted
+	 * set of supported commands, by following the HW design.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, 1);
 	vintf_writel(vintf, regval, CONFIG);
 
@@ -530,6 +559,12 @@ int tegra241_cmdqv_device_reset(struct arm_smmu_device *smmu)
 	if (ret)
 		return ret;
 
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & vintf_readl(vintf, CONFIG));
+
 	for (lidx = 0; lidx < cmdqv->num_vcmdqs_per_vintf; lidx++) {
 		ret = tegra241_vcmdq_hw_init(vintf->vcmdqs[lidx]);
 		if (ret)

--MZU88YI6+CvwWO17--
