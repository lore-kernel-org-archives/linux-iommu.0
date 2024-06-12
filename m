Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06912C47D
	for <iommu@lists.linux.dev>; Wed, 12 Jun 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718228766; cv=fail; b=frTi+8uYoc7yagCPB38ZkZ3tycd/E4F1wPEuaUAIlhzBKQpXQgvkc/FMNf+u+vrWY1C1bxmTFCk8ZF6yiLmDXKX5vU87aXyNjWkbLgyYXvj50e9X99pmFl7b35Kt6tccHIAnI7TFMG9XKQpicCa1OYB0YMC3fakKjAZ0GJIk9r8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718228766; c=relaxed/simple;
	bh=zH+0LerWmhxj5KAmQnAGF4aHo0ory/DRk1NtSIncoUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV1VfiED4wNVXqAGWJ+zZNxzAq4b7L94eEBcDPCaYieJDAcTibjtHHBjNyP6jZwYfITjacpnoQn1s+Wo/cplNn9MSPTYyrSZByfNGGQ76Qu4D4SZh1IwnytXq0BMulQRDAqStMe+ZZObrHymAKB+YouBycJYTcGhIGCD0Xl+R+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y3OqxrSI; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y3OqxrSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVuXDluK6zq+r1NhWUZpPiG804rEDFscQfAtEwxtXPcqLcZVwzlp6wwFB5h5ORxMtpPPso83RdEWEtx2gW8qz2gx4qID12eqAIAG3lV4PgspWvBu7lSjhdkj290K5zbygwBtajuyUsviwl+DoTJLRRfh2emc+xwr9K0tUUTfBm4bEAebvIMHJWXmchYxELBAOr2LnhIRiKwvgnV0vosHqm2GYeg4jF7SHLk/oAmN4oxxzk2C+2CHH//1rCrTLnMGnh71S3iCjMBbwl/na//tvCrGJNIAjapXkUVpeqK6mKr8zRx0omA+BN6rznkhKE0KdYkFBbFZaANRFgJCNZCDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ/jZKGH8OfzuU1jiiOHWK1nOqg28FjiaqvHR59WHB4=;
 b=OQpqvrS7J3NmlamtEPgpS0e/p/bRA3d+Srm7YXb2yr7NO64GkK81MWbf/pgGJ0s0WjLQGtCEaj2ZeP/bFOPgqXji7Sx3XufwR3eRXqGcaupkYG79wsWFCGQVNEy7f9wd5v1OSaaTlgaDpeY7Y/EiTVJwv1ZHognl3YNjy8N2ZwE9LjWEyydxqQIYw5bnexXZ2wg1PgMzl0CkbJMx2ohIC8tmgYaYFGT8b+aMm1+31SUIn+TSumSB5DV3QbMBYKlfoWTJCifWYkV8lJE4ljTA9ZNPs7EIiYJXR3QQUIf2giSSHeoe3AbRC3QM6ltHaxWJWX0I7oCp6cQh6zSBbHZboQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ/jZKGH8OfzuU1jiiOHWK1nOqg28FjiaqvHR59WHB4=;
 b=Y3OqxrSINmGb3749OEXfqPDz/VFrLmrTxSO7gR7VvkJ0Fw86Lr7tEBwdqRxlgX0Xz47EjkyPUV49Ldch4XPAGjOQnixA/ljkF0HztswKAvFAB0YQsXHgNGnieIGB0QZOC9gRK2tw5R8nbcgadgrYzLc+YsJkKsLp2dCjhor2AXGgDBXc0zcHBWh7fuSqpe3kKspB+zMt4841+5FTyG81uw3rxzg2Ma4X4iZHpIKkFkbmctUlKdENZq+gbkeL9brXw3ZurSWratL3ylDZbLn+J9xHs1kteBkcKmYkmMLH8ptcWQj6+BB1xNGcj86N0kpPCae+0jXp2LXQe/O1RVTe5g==
Received: from SA1P222CA0091.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::11)
 by MW4PR12MB7014.namprd12.prod.outlook.com (2603:10b6:303:218::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Wed, 12 Jun
 2024 21:46:00 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:35e:cafe::7e) by SA1P222CA0091.outlook.office365.com
 (2603:10b6:806:35e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:46:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 14:45:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 12 Jun 2024 14:45:46 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 12 Jun 2024 14:45:45 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>
CC: <joro@8bytes.org>, <jgg@nvidia.com>, <thierry.reding@gmail.com>,
	<vdumpa@nvidia.com>, <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v9 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned VINTF
Date: Wed, 12 Jun 2024 14:45:33 -0700
Message-ID: <1075717e8f4321b8fbeea0fb24d4151e39e8a900.1718228494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718228494.git.nicolinc@nvidia.com>
References: <cover.1718228494.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW4PR12MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c285cbc-8e98-40b0-b0b1-08dc8b290cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|36860700007|376008|1800799018|82310400020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CiRW+fqL0yAW41GsWW6YHvztbgSIgYo4k2H9jLDWxOZJU4XqTO0CS+IuJiLE?=
 =?us-ascii?Q?OV9Wuck/TBQv4iM3rHEIYpzOM/8LgeN6thxwr0hT0X/D8B3i4SEMKA9Bah2O?=
 =?us-ascii?Q?l+a5nCh+5AMIMzYfKiqHPknllPIxZ0ThRbIuDEa4LRaFawBm4D+StZDn1KfN?=
 =?us-ascii?Q?2ZTqWxHroClAXCnpPF5P2wBcoqyIky5T57PpF2YJTQog+n50j3IwNmxW9OWC?=
 =?us-ascii?Q?H5G+dI8OWowJA1HdCrZpKzzGkiNLO0xe9y0CpcfKkEeyLFGy2KE8fry3v0Dp?=
 =?us-ascii?Q?ad6eULvYyB39vJ26bxLCqDkqEEisqABU1EYQ1e0gCKW1pCWQiiiYU4sxXj15?=
 =?us-ascii?Q?pDejFq1VrhmTRJX2cUxOqf7+7N/yvHMK7bEQV0b8tNlDc5BwBFo4Z13ASGnW?=
 =?us-ascii?Q?z9K7Guywwm4m8iR24TnjvXpayuHrx1y1Psr6zMYQZrFpcMoC7Nc65EDIdnUL?=
 =?us-ascii?Q?pfk7H5oU50Q1RM/DY0hHmyUb57HXrH2hBSX98u8zSi3vz6ciTYv0w9YmOiGz?=
 =?us-ascii?Q?OHkLB6KWVkGW6j3vVW5cHEh1QsgLe76dpvrh2gahyOLoCygmufRiGUoGHoQw?=
 =?us-ascii?Q?BoYdxrPGC4W3LuIaN+4SKOFKs+oTREJbCPAe+HKfvSYrvbfWO+JYYD9+klI3?=
 =?us-ascii?Q?mZGgU3YIRjjlUsGVHEfjx92oaX5EA2X8+0A0odg6ZAYY3bxeWxfNV/Ulmj1t?=
 =?us-ascii?Q?o8fLYzkwgLePqw4qzJJGhqNOILKjDPdnqTQIYjRZEggiL2CK4WxkgJ5a0mMM?=
 =?us-ascii?Q?Q7zeAKQKMWUmXxKd3GSPbfqGCCOjcE2ecjmJrQe2gE9swLnBVtEDWOGldgWZ?=
 =?us-ascii?Q?X704SpncnN3vjoN/SvFaESOSPEyS5Gagq7Na4UGUGwji165/cbQXO6zFNlam?=
 =?us-ascii?Q?7a/ObKiCdpmsMWK5OJXTPNfdEgpfPd5HgV+ODBU8UTDajXnLGFB625OltxlE?=
 =?us-ascii?Q?AB88vKTjdEekBHQO31D2PX5j7SafFIzUounxcuBUaU0Nty4HaMwanjz62ydz?=
 =?us-ascii?Q?P1BkkXvV8Uv8R9hH3NsALl1DZ3oNJyjWnoX0WM1eSNwDNBRY+I3a5/AaXmh2?=
 =?us-ascii?Q?WChFMMUvWdZ0hYquRslQQZItKxYF6nMHMXrGiF23Q/89mYTFKYazx59rHbzS?=
 =?us-ascii?Q?WJnTj74uia0gWUpZ0XgHffbAyASPoYMN4NnHiDX9RRd/+Z0J7d34x8pgj7+v?=
 =?us-ascii?Q?yoE9IJsBRfLI6llGlcmIHdrQWuBsZUIFynA059Qzq0WFdQI722UonKjCovbt?=
 =?us-ascii?Q?n+dK7EIsHdWO2Hq/y6lH8Kxbebywzl6eTS1fG2IeHflrQRM8AjuWgXFbOxjQ?=
 =?us-ascii?Q?52CNORZwi+v8fdBur2z6gnbVRka0m7uSGKxzOu2rKAkuq4b+IYmK95M4fKk2?=
 =?us-ascii?Q?QtAuIjg3/UUSdKs6DROsOpyNmghORXyAj2r+o/MwT1TiVCfcOA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230034)(36860700007)(376008)(1800799018)(82310400020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:46:00.2422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c285cbc-8e98-40b0-b0b1-08dc8b290cca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7014

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
index 1a2680d31c3d..bb696c66e56d 100644
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

