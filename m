Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02218002A
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769782; cv=fail; b=T4Qock9I5WVB+QRFV3fE2HNCKZaGnI0/IC5SrItQD5/e0EJpr9W+gyh4rpwWTC8fJH8Z12Zq2fELMFy1eVv4unyasHZTtnNb2FbqWp2vgNwI94qN3TqMwYZvD79Mis5s8ix/K5vptPL3zyae1kIEsTR1fOrLAf9UlLbP/GCyw2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769782; c=relaxed/simple;
	bh=C4zfJaHsDR2a47HvJRPSjblY3jI0p+AInwccslKXTuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7Oplc+xoFi9vmFqOgtDnhNVzIeqpythLWqGYlWUtXg64k1N+HxfVf8vOBofkJVLJBLvHzrUEjHs5hO9Ff8ag8VLKC6/0CfDS/ew4Oto2BxG4uUdFp7U4iZM/I//vzQfWHU9YqLXKD7QS7/D0eXHdmowkTFAJKJ6CmiC169hn2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q/BmUYn0; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q/BmUYn0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZPqWs4yNoUgYoDf7Ilf7+jdpHeXkYAOyk0npMuU8R2jx46zTvKGt3OEbUMP4YwR8OH6O7hjLgA2BypjC1cEwMVdTMC1OFfQer13zXp+asoenDeLndl3xoP1jPcVYyEwZy2zYRVCgPZbydTJsjXvcqD3bzbiqM8sQrlfWkQKPRzi2pkFCfJ468fFcx+eW9CQM5TIoxI4fc1HcD/qRQP2+mRJF0o5SU7xVWnaoUx0/F8B812scO945g8bUZfFW4k+fCVP8IfnVodA97f5kzxjG5tiuwT6mxBwhlPcKRGI6UnV5hN9TvcKWgLrWSxuIgqIoEwyDtLjO16sv5KpnUigZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKHdSPYJZz+LAyeERSlbqncNDWrZ/2NZQACTV/S+UbA=;
 b=d17o3YPCn5NuAUzf3bJdSfsG9iXwUD0zZ7LfVyp5EU8uQcTPNiLU9hJcQeXsPTg7JQzOwWyrbkHkMiWiL+qEkJBTWjxkdq8VMlzkmFkoRdkOhz7CQ+cq14taHxShRt0DhLvjtSjKPYHbadopEBSSBSPklTc6Ck4C/1trG5pwrCfMvzQMcIlKN3p10qQAadcUwbrvolS9fHEPtzym73C5Jc1s4Ap0lvaEI6xw/02GpOBIu91XrWolA+kMEBDywXtRimsCdAeZqG2/sVJenSbqmlEv/ZaIqnXU+KepaaV9qQFJLCqqAnYSWrHRfYLIIJy0cXio1t/Q9A2wSv6/jROfug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKHdSPYJZz+LAyeERSlbqncNDWrZ/2NZQACTV/S+UbA=;
 b=q/BmUYn0eEL2ub7cV9kdciMd2Y5st5w8tIL8gazG2+JPmqyJrHxqXftyCNUhk30H6zEzLlh18FMc1YpoGIkWfnWuQ9PR/OI3OGmdzzlfVVQPGOh0j5leFApP9QmsgXujq6byC9NSGqvqtpMJX/uy6wLiSFjZeBcv2tBkbJ9na7PP3f5/A7YuqPD+TUwx3QsJ00jrnIhDRuz146HeS2qcZiJ5uurDBBZSlwpAEg4NOUjNZ9QMio0WTtRmneEm+rr+K/I5Kw75g7qjrr10TI1vDWEGq57kTKu4/SP3U6qvWI9Slnp5SQUVPhE+6R1vmhKfXbhIfNUp7SvEm7m8HpzIjg==
Received: from BN8PR04CA0031.namprd04.prod.outlook.com (2603:10b6:408:70::44)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 00:56:06 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:70:cafe::72) by BN8PR04CA0031.outlook.office365.com
 (2603:10b6:408:70::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Fri, 16 Aug 2024 00:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.4 via Frontend Transport; Fri, 16 Aug 2024 00:56:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:48 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 10/10] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Thu, 15 Aug 2024 17:55:31 -0700
Message-ID: <46a0367c5e23938386b22c0fbb0f80b511ae44c9.1723754745.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1723754745.git.nicolinc@nvidia.com>
References: <cover.1723754745.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d28822d-f030-45a1-c3ce-08dcbd8e356c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUD0a0p1wK0tG8b86pLH3TdWvI9Sx//oi7eZ9hKKCf+oydLXyu3fFTuSyxT8?=
 =?us-ascii?Q?Y4+mMpDQhPdUFIt89hZnYGco0y+5HQcz0fDfb3GJQi2sXA6wjXc+skRMiaK8?=
 =?us-ascii?Q?8D8kWJ3pjPXnBu0Npy53aTRx0pXOEvUoeaBqV+5MUihlq+mZ444or9/nYsjH?=
 =?us-ascii?Q?ykru9xweFOyvqWUtO6Yy3MmXjxQrWxVoUpH4sBP+yi50FjlrGAK8wUkfTu8f?=
 =?us-ascii?Q?eCPIv9ZVtA2S+ROM41zjPARXo/TLs2hZYVA6Znl0BeCP5gUiT3BKcLUUJUW1?=
 =?us-ascii?Q?kwKskuRjAXgefxvbMKZjsN2moCP38K/v8dIc3XMgjTPWRcNqC7veRJ8B5e1P?=
 =?us-ascii?Q?s8UOxiZ5cJV+FptfR9hT/nuBeeiRgMWXXLjEqqyzqBjD48hn16//jODYLGmd?=
 =?us-ascii?Q?kpc4ynNARSRFtRc9h+V43j2BFzUhPHXGVqQjS80IrE7k2hzpuxEkZcij5VX3?=
 =?us-ascii?Q?ngcyEKAXvJ+jtojVBZFUF+rud+TAcoO9DDZkP7nZ4FZ4sO/w1GA0b3Eo1tJQ?=
 =?us-ascii?Q?yzJUVyuRkQc/4RGQo7Hfe/vwfHhtjXU6dOJ2hz4jeKvmhcgXw6tOdg+NMuTF?=
 =?us-ascii?Q?qBIjzNzJoew/h71CmxIYS+WSyDYFP0uorDhBEnPZLpmGPSSzki4o3utPDPfN?=
 =?us-ascii?Q?yXXGxwl2d+CgtG10OnrgOUAPVIyp8ny83YJWcEcb8rKtpju9K5jCURHnPDnr?=
 =?us-ascii?Q?9e/bj5usUxmtkDTV5XEh2mAHsdcFXy2BY4emt2lim0eT73c/39QQ2PAzQplW?=
 =?us-ascii?Q?njRlWdTDwe2hB56CXAt4M4P9mfdjCBPvHyQpo4Ioeo3vGDcH6PN0eWGFFkGz?=
 =?us-ascii?Q?wn1Vt836EuVSkSCwk6Mqnf+r4yDAv6+ZdWfbG85wyGpOszEScZkRBO0l7MaI?=
 =?us-ascii?Q?YFliDR0YUriqEUqNZkLJV2n/NeeSrbTNyp8ll47vW1n6/MjZGxKkb3Km+hX5?=
 =?us-ascii?Q?KkclKa0Y0M9H+h5PqiWh6SiImTkKvYQh1SXjGjYHtra0G/wRXA1c07FT+x3H?=
 =?us-ascii?Q?lytH2gAAx/2lMVMrVNMo3qadB+zMQtLJRaTF/272yTbkLDg+uT0uIWeY+w2Y?=
 =?us-ascii?Q?HzsJYSC0x1ME3di+VSEe9UgQBxkG3IAiuoZwCTM2nlvE/IYDMccxVxJJCK84?=
 =?us-ascii?Q?Rvn/QZrU33L1bRpUSaUFDrS2sAvkCDxdtaQocpO5BwzZplnTGRRy7auEnUOm?=
 =?us-ascii?Q?3zLxzepCoBoRZVh1MK9N4wVQs5ECb8SQlvZqwr1KZRqYOayYVn1I832mEj+d?=
 =?us-ascii?Q?mZlDZZ1zyTY5V+nXIHOPfXHPhw7hQgjzeju+5YgK0CRNolqWybbSbUmUxFUr?=
 =?us-ascii?Q?FzIjKfodYHzOal0ZeEvPpegQ0YR8Uge3JZKmkK/FQVFInizFLBlgtxaT3G6x?=
 =?us-ascii?Q?7/FwMuvjZCviiHUygPTulJjj4RayB75oEY3n0kx8ofeeYiI7cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:56:05.7062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d28822d-f030-45a1-c3ce-08dcbd8e356c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
add a new helper to scan the input cmd to make sure it is supported when
selecting a queue, though this assumes that SMMUv3 driver will only add
the same type of commands into an arm_smmu_cmdq_batch as it does today.

Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
guest kernel driver writing it or not, i.e. the hypervisor running in the
host OS should wire this bit to zero when trapping a write access to this
VINTF_CONFIG register from a guest kernel.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 22 +++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 35 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 839db3bdcfc9..4628fc456759 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -336,12 +336,13 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu,
+					       u8 opcode)
 {
 	struct arm_smmu_cmdq *cmdq = NULL;
 
 	if (smmu->impl_ops && smmu->impl_ops->get_secondary_cmdq)
-		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu);
+		cmdq = smmu->impl_ops->get_secondary_cmdq(smmu, opcode);
 
 	return cmdq ?: &smmu->cmdq;
 }
@@ -889,7 +890,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -905,10 +906,13 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
 }
 
 static void arm_smmu_cmdq_batch_init(struct arm_smmu_device *smmu,
-				     struct arm_smmu_cmdq_batch *cmds)
+				     struct arm_smmu_cmdq_batch *cmds,
+				     u8 opcode)
 {
+	WARN_ON_ONCE(!opcode);
+
 	cmds->num = 0;
-	cmds->cmdq = arm_smmu_get_cmdq(smmu);
+	cmds->cmdq = arm_smmu_get_cmdq(smmu, opcode);
 }
 
 static void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
@@ -1195,7 +1199,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, CMDQ_OP_CFGI_CD);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2046,7 +2050,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master,
 
 	arm_smmu_atc_inv_to_cmd(ssid, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, CMDQ_OP_ATC_INV);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2084,7 +2088,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, CMDQ_OP_ATC_INV);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master_domain, &smmu_domain->devices,
@@ -2166,7 +2170,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd->opcode);
 
 	while (iova < end) {
 		if (smmu->features & ARM_SMMU_FEAT_RANGE_INV) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 7f1bd95f3f25..30534839348b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -633,7 +633,8 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
-	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu,
+			       u8 opcode);
 };
 
 /* An SMMUv3 instance */
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 844c27cdc946..cfb9f2784f6a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -144,6 +144,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
@@ -152,6 +153,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
@@ -301,8 +303,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 /* Command Queue Function */
 
+static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
+{
+       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
+	if (READ_ONCE(vintf->hyp_own))
+		return true;
+
+	/* Guest-owned VINTF must check against the list of supported CMDs */
+	switch (opcode) {
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_ATC_INV:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static struct arm_smmu_cmdq *
-tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
+tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
 	struct tegra241_cmdqv *cmdqv =
 		container_of(smmu, struct tegra241_cmdqv, smmu);
@@ -317,6 +336,10 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return NULL;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return NULL;
+
 	/*
 	 * Select a LVCMDQ to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -406,12 +429,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
 	tegra241_vintf_hw_deinit(vintf);
 
 	/* Configure and enable VINTF */
+	/*
+	 * Note that HYP_OWN bit is wired to zero when running in guest kernel,
+	 * whether enabling it here or not, as !HYP_OWN cmdq HWs only support a
+	 * restricted set of supported commands.
+	 */
 	regval = FIELD_PREP(VINTF_HYP_OWN, hyp_own);
 	writel(regval, REG_VINTF(vintf, CONFIG));
 
 	ret = vintf_write_config(vintf, regval | VINTF_EN);
 	if (ret)
 		return ret;
+	/*
+	 * As being mentioned above, HYP_OWN bit is wired to zero for a guest
+	 * kernel, so read it back from HW to ensure that reflects in hyp_own
+	 */
+	vintf->hyp_own = !!(VINTF_HYP_OWN & readl(REG_VINTF(vintf, CONFIG)));
 
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++) {
 		if (vintf->lvcmdqs && vintf->lvcmdqs[lidx]) {
-- 
2.43.0

