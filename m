Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5681AC6
	for <iommu@lists.linux.dev>; Sun, 28 Jul 2024 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722206726; cv=fail; b=g7swH3+OE/o2dvVNECZ53ccbltlCgP8ZaOIH+HudR6ij1g5QWhtWQLEtVimGPuJFBYa93J+5q4Vq2TkhpABtmArQ9CZ3CyyooowsHOTiSkaCdWeHMMHdhgfaQkPpsFdNEeaKP4V84eMpTjW43sZVB2jJwqUpm/TEGMMkCNqn7Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722206726; c=relaxed/simple;
	bh=Gfiuhf1x10vOfLqQFYGDJDpyMwXhX8B1cl0yt6Di5JM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpFgO44NKhW0eGdlGeyPBNYnPF2nzAoCs9eHNFqtYLnx8Jyau2dupDpnFfsd2K1n/YKZBQSgmC/HXM/xtvjPXbMaktNptK6ZvfaLweumJ/Vh+cojTW7PWAhVYrKqlSMODKQ2oUZN2rMCOmqXqL1nfk8pbUhgVHTsncUIn8/SCVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jG5eTec7; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jG5eTec7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PVCtArZ+4ogPJSx6EcmjmFagevdZWoihZFedPMkQspGILol+za7xoE5m/3rjBOvhwwq1DAfTBIGPW84sPL8b0IXc27qIXWJck8+FanJTTlbmuvu3g1CN43LXVnCgoYIpiHk8KuBrvhCEborIclugA8RnMyNkN86/Vv03Q0i4LC6LhvUfoKIxA8n2nzy8ClIuGDPNNQ1CSe372ble5xShf6O3cftsN98f5xmOiHSkB14N5Nwuyihrmp4yRA3HAE4hQuMRpbcvdjEOojkBy3HmdETeh38GpMmROXiqgQ9OIxZmluiN2dKv2ywMu+zwOh47JwcmohaGqU13FEAkTdiAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNhySSY7sJdkTbpwdHnepRwQDVNL5WJN/z17jFv9MUw=;
 b=QvxhknOcJB1+xIyfwdOrIFzVKTvLNUKkIglO6fRWmn6uIoipF/RwY3Tpxg7S+XU01wGAml4jGSj5vVnwmmtB+E91Tpo8q4hL5m+bz4s+4qzMNDxJ4vkhzFAkStyvzC8+8LVQLbE3nERqp3CvUAKHcZKqrr8SjSLjluLYaNdd819pVG7q9COrqPmFLzHLRhv5n43yKd+IcdtlROQa22ca4mBD1D4AfxP5ZN5mkeqVJK9d7dvB2c/s+eHgKh1ArPJ+hTjAtk6irzkSgC6/10WEalgOYedNkZmc1y70o8w+2kIZf9kkQVOJKqQ4IEhxxSR5H8wPuhsDy9cJiwPLu4MzXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNhySSY7sJdkTbpwdHnepRwQDVNL5WJN/z17jFv9MUw=;
 b=jG5eTec7NaUPf9r/G4ZnxAiaoTUmE+zsavMW1Q5yWWic715H6CE3Skv1WfHJzsLkbCcO712BY1hl6FjOV4c9Hd56WAE7na0I3xKD1tJigjq525md66bS6789tpThIDz5lKI/1Mf9i8Y5NVs/EBVJi59JBPZKiP4kC5eS/kCf7iK6fI/p5A53b4KN7Jh2fL+YoxpUtaNaMRt/FZkkg4lUXuJxSbPURRFu4+ObBN0ao7OGoHeQ0GsKKrvoA875pmsxxoaEUqBhssY66KVybvkRTVxR1JZ/3CXFDI355vTwFZvntZy7mRC0Zx8Y0X3kdRvjyJ8iqFWsjGs9R2Gg7DbJyw==
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Sun, 28 Jul
 2024 22:45:21 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::19) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Sun, 28 Jul 2024 22:45:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Sun, 28 Jul 2024 22:45:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 28 Jul
 2024 15:45:11 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Jul 2024 15:45:10 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v10 9/9] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Sun, 28 Jul 2024 15:44:54 -0700
Message-ID: <36795f48022361769fc22f15309299f92a415c54.1722206275.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722206275.git.nicolinc@nvidia.com>
References: <cover.1722206275.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 796aa0ce-6b70-4cdc-b00d-08dcaf56f5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpNgy9O1Tb/uyCq1rhABmlBuCon1NhRXwGbLEyNLw3nJi5gYPwUXkB0RLSb2?=
 =?us-ascii?Q?YYqkMQo87vQ7JoW6JY2IQnvmBponC/4HRUNjASsnCbvXa0j3U5k2xJ/tpQTJ?=
 =?us-ascii?Q?pezg140WwCBjPLFF+TSQ6SUJhZb+U1kbxMDfnah07Xk2mA0LxwmjOZ4HaXjh?=
 =?us-ascii?Q?EiCN3ggDz0JFFHduJfW/Ce8dyiEjwqXShF5O+cPapi8Re61p5Jv+iH1aj3YN?=
 =?us-ascii?Q?oZxns86oYbk6MFWchEfMC89y31LepYg1FnsjpGaPchbFkWMjZM1uBIoHEo6I?=
 =?us-ascii?Q?7gFIjbjogCQA9XhfjOZK61ONzFQ09EzhRImF/20naWLmzwfqiwPWz8rSyV1w?=
 =?us-ascii?Q?bwfYMm4/YowgHunKuP30mo1KiG4UL6dwnTyMYHbO2Cblow+R/nPrMyzKf7O1?=
 =?us-ascii?Q?x006oBIgMEpEhQdtNOkLcjYFx1MLAJ1GiFS1AmR+Po7V/QyHppatTAq+52jO?=
 =?us-ascii?Q?aj7yZgH+ir8X1Uj+NTudlRO9wEZDT4H9qoqwh6Lx7QUxTjfCwudGS9y828sv?=
 =?us-ascii?Q?xWe3mmIaYyT8Z0yup2I/WyQf9AU9+klVZVcevUkEg7WlRIXa2QMtFh3NY7CQ?=
 =?us-ascii?Q?ZphWYel9F2lahCwA6VCR53IPg+U5rAWmQ9UisvZs+5E8zG05JkVJNTb0LAAF?=
 =?us-ascii?Q?7CIG9Xsf4oTBcdPJm1tIhT/mM0XIeu+sXkCBh8ubpoKAFG3Jk2CspH9LBGhg?=
 =?us-ascii?Q?ZweXczFDsrMgmgZl7Jw6zBotkOL7FXIA6DYHwzhT4EZjKQA64ThwUJ2rBfAI?=
 =?us-ascii?Q?302WtE1iEEFWhQ94A5Nf/oLk4vQoK1Ry0J34Dl9KeZs0vpBb/MjVcBUpuOV4?=
 =?us-ascii?Q?YodTOkb2i2oWdAOa0szCnAykoORvMEiU8lPaa84a9iS5PqdN1asttEn2NaQ1?=
 =?us-ascii?Q?pWx0eXFFiXclU9KaNyP0aOc7g2f/6Anjf5IbgcHTYDcbDjSfkzgOr+tK4qo7?=
 =?us-ascii?Q?J8rm9ogWtoj+x0jPd07hG9wyOQVbzh9JurTFJz5d5pR+Cga8STjo4LOmyIII?=
 =?us-ascii?Q?QsPqK6R4HJk4+w7GhDro+nUTgdIaTF0Khok6wPYNp8mukpvRXh5vOWzqRj1H?=
 =?us-ascii?Q?/2DcawUNNT1GDld1kzqppOwQoRWdJDhE9BT7ihKhoSC7fApIpORIK+VlaA5G?=
 =?us-ascii?Q?JREIY4vKMX215KuHSeGeieVc4Qh7HUg1GOikJawlU0zhnWB5MfFBHVMSWnub?=
 =?us-ascii?Q?RySJsV0c7G3aisO3C3cUTbXX0htZHbxB5zGkRmwtgLR8HhJMyYC7zbj5QXP/?=
 =?us-ascii?Q?+Bpvd6z8+mXFuSOTcYg6VtBbDrq+Lw92E9GeR8uB2uLtfRkkSZ4jtayr8Xz5?=
 =?us-ascii?Q?/V9wXAVGA67sAtBhTLz0HD3zlzae3qjtoL1AobiafG7cdn/D7OHCK6UrdKSb?=
 =?us-ascii?Q?pitkF7ajVcLVaxjD+x8LQPsQ1+uVTrRNvzIsfV64HXDY3Au/t24XBdU330X/?=
 =?us-ascii?Q?pBifkKdnl1XCKgP1li1xlYE8XnOeiodA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 22:45:20.1620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 796aa0ce-6b70-4cdc-b00d-08dcaf56f5a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

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
index 18d940c65e2ca..8ff8e264d5e7c 100644
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
 
 	if (smmu->impl && smmu->impl->get_secondary_cmdq)
-		cmdq = smmu->impl->get_secondary_cmdq(smmu);
+		cmdq = smmu->impl->get_secondary_cmdq(smmu, opcode);
 
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
index 367f5e160af4e..c7f34a5c31f3f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -633,7 +633,8 @@ struct arm_smmu_strtab_cfg {
 struct arm_smmu_impl {
 	int (*device_reset)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
-	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu);
+	struct arm_smmu_cmdq *(*get_secondary_cmdq)(struct arm_smmu_device *smmu,
+			       u8 opcode);
 };
 
 #ifdef CONFIG_TEGRA241_CMDQV
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 891302fb20901..13c57a5fb758c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -143,6 +143,7 @@ struct tegra241_vcmdq {
  * struct tegra241_vintf - Virtual Interface
  * @idx: Global index in the CMDQV
  * @enabled: Enable status
+ * @hyp_own: Owned by hypervisor (in-kernel)
  * @cmdqv: Parent CMDQV pointer
  * @lvcmdqs: List of logical VCMDQ pointers
  * @base: MMIO base address
@@ -151,6 +152,7 @@ struct tegra241_vintf {
 	u16 idx;
 
 	bool enabled;
+	bool hyp_own;
 
 	struct tegra241_cmdqv *cmdqv;
 	struct tegra241_vcmdq **lvcmdqs;
@@ -300,8 +302,25 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
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
@@ -316,6 +335,10 @@ tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
 	if (!READ_ONCE(vintf->enabled))
 		return NULL;
 
+	/* Unsupported CMD go for smmu->cmdq pathway */
+	if (!tegra241_vintf_support_cmd(vintf, opcode))
+		return NULL;
+
 	/*
 	 * Select a LVCMDQ to use. Here we use a temporal solution to
 	 * balance out traffic on cmdq issuing: each cmdq has its own
@@ -405,12 +428,22 @@ static int tegra241_vintf_hw_init(struct tegra241_vintf *vintf, bool hyp_own)
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

