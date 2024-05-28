Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9492513DDAC
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883818; cv=fail; b=cSJs8BXFuLDhNqkorf/hzxCi6G+8L22s9/evzASBrX4L+4BWCZU/HyUem3YDoZYpRZRHE4Ph3Kz5PnxTPcg+VU/DW/Iiw/DZWQLkk7Aw5i6ZJqFalEgiDazlyDm5uxMZ6ttPZqLlUrb4H6Mpn3PvHdSb4JgrflWye63BYbLJnPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883818; c=relaxed/simple;
	bh=j7zLu51Bi3My/lW7ixAslYS283ezX7O1uMigEMhIoQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vh4lp3m64L2TIlgPc3E7u8981hMG1z87oRTLP7Lgg4+VbjSZVkAlfKi2jJn+MP7h0JQ48s5bOr5IzWRv2Rf2OpRz6KOOmyO/FYWrRK47np43S+c164T/wvOFW7bm0GSzXfCTOxXQdh7ofHT4cCjEHFJbFmR6krZ6Rs+h/NkKr+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s1/rXYqw; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s1/rXYqw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bw+7R48Vg82Z1YOt3JoZHFNj12ayEO2+6oygBzPuUBEqVJ+9lyLgxmP6LZWSrWK7mBGuxCTgRJfnRBHI/+q38lYms46l1JWpLePEdrmjZLdbKGS2PczRbkNtnhcMCMyf2lYBy9LYLlNlonz7Z8KWgr0KxiDE9mMxfzNHs30kY+dheOm+eUxkMnShbAkCkazGLpBQcd6pE3Wvb/zlzGXoqR507BvXywSB2M327jynRAFJMGywHZP0URhVNRskkOh7OFm/yR7Q/xD+QtPeIgOV1IsOapzHOGeLRzkEnl52Px0rdz643YlU6lsxJ7iE2KXpusZsaWD/Kb1aH4RYt5jlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+gvdd86SeOaYluILpdZyWJHC5WX5UbNjcCy1TAzYcU=;
 b=eognuQyXW6gvxcPJqtNYmo/0sv+b5v7VC/xh8WbPwu0okm1a+pFyR6d1gk/Cd8Jky/Cl82BL48gXei6s15a1qpthV1JRWXkQFcWD9qYSn0DLymsR7Ll78ywflpjadMahzSsSWLEdSfcshlKjsOm6TO1aTGIZeKUhgQ4eCLPnJ0D413lTpyvRf4NUuHhssPn+3qC4tvY9U71e5hWVlHyBl5XELTZGJEjwplZYUmCZnZoqI69AIKr/6W3wvr810ozDQ7p9BBlwNFKJzKw8NFZO3aAdkeDXiOw8s8Jw4NewnEmmm5q8HaLDAbcHnBvbjgLcDoyy5na2XqO6QioeTulEGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+gvdd86SeOaYluILpdZyWJHC5WX5UbNjcCy1TAzYcU=;
 b=s1/rXYqwRYF9kLXygoLNIhqi2FTG28ThnDhOtPjN72yukn1rCYejpTpIw6O3IpkHWCqAKyRzzTDIoUqEsJCH7R2ZUbAf8MT4sDjJvd/JhfRfzfjeM3kB78+LWkJfDmpZScdQ50ofZFACqsNffN3iDcLRH7uOjRNdqEptQW0nUD2ozukeeIZVnQsleQbYAh1ULF8RzKdGOwYJDkh6MqbLfb3TWKFxjxDSdHUtZQCbpYylxVifK6glFQ1/ccjAm83+DjTC8T1cuKaHc9C5CU6vSBObLf3njzXop/fbIGAH2W1B8Wcvz3kW3SIUJVSn5G3o8E/Z3hiCi37TvjztQ+4udw==
Received: from DM6PR06CA0020.namprd06.prod.outlook.com (2603:10b6:5:120::33)
 by SA3PR12MB9177.namprd12.prod.outlook.com (2603:10b6:806:39d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 08:10:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:120:cafe::2f) by DM6PR06CA0020.outlook.office365.com
 (2603:10b6:5:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 08:10:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 08:10:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:10:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:10:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:10:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Tue, 28 May 2024 01:09:54 -0700
Message-ID: <e457356368fe1bb11a797be91475cbb27765f2b5.1716883239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716883239.git.nicolinc@nvidia.com>
References: <cover.1716883239.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|SA3PR12MB9177:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c9ef2eb-f344-4cbb-f7de-08dc7eed99f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SXPjs47Rf6RlsmUxBrpWtMwHvQ1sCLkB9dkdRMlkAZde8eWFBsYlOjuNFNlx?=
 =?us-ascii?Q?2flVZeEy2PKg1oJGzXTEJy7+ka1wqfLOIht+bexSM+mylEcRK/2DjXIs0kI4?=
 =?us-ascii?Q?Kyzuiaf/yOUZaurhH/YX2N5JOvp/KIQuWh/P3hP9LJ+EVVQD++HjAx0uoIgm?=
 =?us-ascii?Q?tLvtbbgY+rlLE0zb3Bekbpj3idu8T1c2Jx2MmRpVfHNmiFYCPPmH2al4nV6c?=
 =?us-ascii?Q?EpBcZwsQKX/7XU6X6M0wojyekBbptPXO+unbb5bQaVDGLUt4cCnVQ7Bw4xn0?=
 =?us-ascii?Q?+odjcCHswFC9JdMqi8G+doNRH8s0haS+k3MaZr6B7Vpu7YZI+T4C7KzMvw/o?=
 =?us-ascii?Q?L7J5d+w7JlcoFxgFKPcYYb/E90G7xuA3JVJl0LsINfSzj34s9L9FBDvdn3wI?=
 =?us-ascii?Q?TActZ7+r2q/16eSFjKqg3fJ4qsAc09gSgBYkWgcfTiciZLEVRYSiu3GWoHRd?=
 =?us-ascii?Q?+O6MBSZelibin6Rqy1CmGXtTz6lBS3An14Ozw8ltdd58POPlm7vLIiCGBZjx?=
 =?us-ascii?Q?Ae6pTr7KRzo64H4+r6mzV0NxNVKscaxrYP6BlTZHx+PAjBq5alKGAT067Q+Y?=
 =?us-ascii?Q?CDHFrgL4bqhifexgnstRjXwWmZbo8zAkYHmRiCdds80Mxl9Y8nq1972qtK4r?=
 =?us-ascii?Q?91uNkc0WKOvlO9ZDgXtTaA2he2eaQekmZn4eS8FK8EU47BQNbkMY3ehqMpO5?=
 =?us-ascii?Q?TtkfIN37kvDsi7ReCkbfrnycZuCnBB0HL5ZBzrqLVmzGjtDH4QXMZxkzBmsk?=
 =?us-ascii?Q?LVvTQ/wakPdWaMYgcPtZvzICFK9z/D94qLRukwwAkNsXz9s96LQlx1BCho2H?=
 =?us-ascii?Q?TwffxWMG7yfK3TQH8efQ2xs5+PojZNv/tA/6ghMP04BTcdKp139BrDNJMuH7?=
 =?us-ascii?Q?JKQVRiCQC2WOhBZIcTiRQ4dIMCMh57oxNf8tRXr/E5hR6AAEO5EwWg6gkzTH?=
 =?us-ascii?Q?W/knd7dUt59ljtVNfvHQ5lAGjjFGoGFu8We8PiB4r7n0zwcV3UxwKw0p3ExK?=
 =?us-ascii?Q?bGi3BocMUB5e/aIfgX2HhlS/WCGAfey2ViGbP1owhANvZTnL4EZLgAGlOSuG?=
 =?us-ascii?Q?qf39bzKnhSmDmaLfMkkSLjT3mU7iIXWrnDCsmpa/sthQNsxeTuvkVz6xiSon?=
 =?us-ascii?Q?ZJbuKavX3DIuMyiqHcgaSGPmP4iSBFqEoQT90QgjdDkoNxvy3r8zAdBqnSrs?=
 =?us-ascii?Q?TiJBkl06dT8vsXB1zBGmLsUVhv+z4B5MzgfEPQASAyHm3EeWcBItU1Lkvyez?=
 =?us-ascii?Q?Le6p4ck6lj60gmmZ9I6mevl2eNBjU691UvhTnozXsW3mYaRqTdw79mSl3z1w?=
 =?us-ascii?Q?Zgd+BxGhcbSuq0m+4q3XBL1QcLjl24lau1iajfFeEyJrBooe47mTKvENsTov?=
 =?us-ascii?Q?8tq/mXeEjj9MjgMuAOKf9X/mKgTt?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:13.4187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9ef2eb-f344-4cbb-f7de-08dc7eed99f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9177

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 31 +++++++++++-----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 36 ++++++++++++++++++-
 3 files changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 430e84fe3679..3e2eb88535de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -332,10 +332,22 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
 	return 0;
 }
 
-static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
+static struct arm_smmu_cmdq *
+arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
 {
+	/*
+	 * TEGRA241 CMDQV has two modes to execute commands: host and guest.
+	 * The host mode supports all the opcodes, while the guest mode only
+	 * supports a few invalidation ones (check tegra241_vintf_support_cmd)
+	 * and also a CMD_SYNC added by arm_smmu_cmdq_issue_cmdlist(..., true).
+	 *
+	 * Here pass in the representing opcode for either a single command or
+	 * an arm_smmu_cmdq_batch, assuming that this SMMU driver will only add
+	 * same type of commands into a batch as it does today or it will only
+	 * mix supported invalidation commands in a batch.
+	 */
 	if (arm_smmu_has_tegra241_cmdqv(smmu))
-		return tegra241_cmdqv_get_cmdq(smmu);
+		return tegra241_cmdqv_get_cmdq(smmu, opcode);
 
 	return &smmu->cmdq;
 }
@@ -871,7 +883,7 @@ static int __arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
 	}
 
 	return arm_smmu_cmdq_issue_cmdlist(
-		smmu, arm_smmu_get_cmdq(smmu), cmd, 1, sync);
+		smmu, arm_smmu_get_cmdq(smmu, ent->opcode), cmd, 1, sync);
 }
 
 static int arm_smmu_cmdq_issue_cmd(struct arm_smmu_device *smmu,
@@ -887,10 +899,11 @@ static int arm_smmu_cmdq_issue_cmd_with_sync(struct arm_smmu_device *smmu,
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
@@ -1169,7 +1182,7 @@ static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 		},
 	};
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.cfgi.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
@@ -2014,7 +2027,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 
 	arm_smmu_atc_inv_to_cmd(IOMMU_NO_PASID, 0, 0, &cmd);
 
-	arm_smmu_cmdq_batch_init(master->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(master->smmu, &cmds, cmd.opcode);
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
 		arm_smmu_cmdq_batch_add(master->smmu, &cmds, &cmd);
@@ -2054,7 +2067,7 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu_domain->smmu, &cmds, CMDQ_OP_ATC_INV);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
 	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
@@ -2131,7 +2144,7 @@ static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
 			num_pages++;
 	}
 
-	arm_smmu_cmdq_batch_init(smmu, &cmds);
+	arm_smmu_cmdq_batch_init(smmu, &cmds, cmd->opcode);
 
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
index bec4275c18ca..fe7285e3a1c9 100644
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
@@ -290,7 +292,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 /* Command Queue Selecting Function */
 
-struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
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
+struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu,
+					      u8 opcode)
 {
 	struct tegra241_cmdqv *cmdqv = smmu->tegra241_cmdqv;
 	struct tegra241_vintf *vintf = cmdqv->vintfs[0];
@@ -304,6 +324,10 @@ struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return &smmu->cmdq;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return &smmu->cmdq;
+
 	/*
 	 * Select a LVCMDQ to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -393,12 +417,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
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

