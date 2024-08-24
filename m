Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EF18C3E
	for <iommu@lists.linux.dev>; Sat, 24 Aug 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724458278; cv=fail; b=CKIYSlObSIIaNF6VIrdeo4PE5bD68PbwEiHbA3Ej/HkJYW0cAaK10Cp91YAG6MKnbblUOZ2LXzmV/vkRrG1CBy1w3Vv2J70IsBxdgt9f+ryDxI40vs800r34/myGnlkpeHWotdR+SmpwtMLBFIn96iL2iPETAdGBcAH6v5ME/VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724458278; c=relaxed/simple;
	bh=4DC4uj11Soy7leWJaUpC6bgguswwsoymoQFmCD5Zep0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nsMx6HyBFOmyLJFm+WisCmMffP024Ed9EllokmCq/+jPGf4shRBPDz9YBjgPfGvR6lGq6ikI15x6vz596QEF3pMOd4toWrgIHeeG9CSTM17UUdcq7g/pA0hbWzTv7X6102b6df5gFOG6cnkDsZXaiRSj7qBR2nzvnnZpFlkRmgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXggmO23; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXggmO23"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzL1dfRpQHjJTRg8NKpoMujQAjJCzQJvOXBw307cn5mIhQPmXhMowiODPqg4H8tG9kDewY/BmaA2e3IAPQqh0aM6UE+ZuJZmsNCK8qMO3U0Naq6d67z1yxdxLtHZm8aGGwD9zxxGsNJf4jq6Kkp7em84VivbNCEI0B8Xb71DYBeblsr+2BhWFqr+VW1ZfpZYJH5a4DEOvVG0FBzxDLwFTJVgBlj1pX/59zt64vWbGPSvajYIPH0E/kaRiH+/+9+XLbrjtTxiuMC41FY1HJrFHB5+t6YveOvmqiQ2wT6XTQNYn3xDh790Tngd5MUsYomREs1KKZm5KhuvZeVq7r9L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwBx4r2h/uES9cX/oczIVPnh/oby6SE6pHn4Cu15FUU=;
 b=wBDKOW63QK3KRZ8TSuOZxBRYZ2OproJZmFCVa8pO+YPRgsoI+sij5fX3EMoVdH4AYfOFtogDsUDvSf7Uvbdm3h8O/iRxyjpH5kGlwxuVGWpsMHtyxA0ek4/7Wi3liapnGTfjeGbXrj7BxwL8qSiWrfGYTJxrXcFkc/eODlB/e+ZbKag1dfz+YwYFh1aziOtU0c6VWFi3ZVx3WUK6eVn3hT2yI6mhRlLuvbWIsZhfhPK+4+m3eKsTCRY9zVjVbXZsKVB6aSJpZD54ZNWY5InjAy8+MW1ak1AuRLb9aDg+syFAHyrnKLITUfmHnkx1KDmIRyHIL8bqqz/7dpWbhsnTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwBx4r2h/uES9cX/oczIVPnh/oby6SE6pHn4Cu15FUU=;
 b=hXggmO23bt5KEMsXxrn+AwTKW3J8yVtF0xA8WR1QLTy3eKIABiIutOn8rrWfWH070xP/MH7UjpRhMt49MWKtiXslSVzJlyJW4NF4WtBRXfBvnCBkp1jVwqWQAzUy8cxdsF0CpZAQ0bRx7lUSp9aw3ZKm2sRyhXWmpcEpNx/awUAVbZmTacCiOzCRg9NLKsP2/pMrGclmy8esn7MLXJoAafb7mFM1Fb7tTM6aDBKpwpVcz5lh4LMnYxkx58IOXLhLCRFDTn+CgL5rWMNOzhEcowYE8fQ0yzToUTN/T1iCubC+sSOSaKxadOUe5aFBvRtnEi0XQhaiI3vDE3hZPPVDRQ==
Received: from BYAPR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:74::27)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Sat, 24 Aug
 2024 00:11:10 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:74:cafe::b8) by BYAPR05CA0050.outlook.office365.com
 (2603:10b6:a03:74::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Sat, 24 Aug 2024 00:11:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.11 via Frontend Transport; Sat, 24 Aug 2024 00:11:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:53 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 23 Aug
 2024 17:10:53 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 Aug 2024 17:10:52 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v13 05/10] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
Date: Fri, 23 Aug 2024 17:10:39 -0700
Message-ID: <6584495a46d8c3e1b6b5e32831f4b6b884ca1a8d.1724453781.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724453781.git.nicolinc@nvidia.com>
References: <cover.1724453781.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 35d4036d-c031-4f20-56de-08dcc3d1419a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JXzHhMmtLIyG1XhVqyTVRdix5FHpokNgdIlRMpdBSB+YoBmKMtOtyGiSd9Dq?=
 =?us-ascii?Q?3JA4Q3tx8hYE6dD2Vp7kEOmxYI+dHB9iaZ7GsQZSwXNhexMbNk62SH4c6Age?=
 =?us-ascii?Q?jU9aMRidKMSROz7/lW/7Bmcx877eCYQJMOTVoXiTiPIrie/Q/OzwOW7mxXEb?=
 =?us-ascii?Q?k6ScF2zHUXN6DMwpBM+8HaK8D97v/biKcf4dPztQy67G9AbnBZgjAoiy/JTB?=
 =?us-ascii?Q?C9NmeEXkKwKKYzQ0B432wLPlSOFDSnflrpJnP3bIORQgr/VFIQfgKQucZU5e?=
 =?us-ascii?Q?QyNEwmvAHJG8UqZX7OMCn27iiXASlpnXGAcQyKHwoxXtKodJfi7WtIPHxyFK?=
 =?us-ascii?Q?FfEr64odsT2Gft7nmVYgMONpUf3Vjjlq4hfQlTeD1XSQnWVxf8Rbp8/cnH0l?=
 =?us-ascii?Q?Shz9ls0TwRpVE62BphNS/Tcwskwtfx/ey0mQT/xmnVWReQrKpCKTN7quGAF9?=
 =?us-ascii?Q?k+tWVaFpWTa6N4LNv+8L5wUuX2YQWFHDrDqlgznSQ5fapzteU2j+g20VlZQ7?=
 =?us-ascii?Q?dYSCa2SrL6X5KSxXCA1Bmpzz4u45adu0iSG9L6Lnxzn1YDoZ4hZE01IRyM0B?=
 =?us-ascii?Q?GUIYkihlWXXFkQ4AsyWEK9q075l56jy94NAQNShp1rP9zQCByovOYuohEX7x?=
 =?us-ascii?Q?gW6TfSJqGCZ1nIFeID4NscHYV5EQvviuTkeWBHo0HWmH9z7112gVLxNU4H/f?=
 =?us-ascii?Q?U5M/TOY9U74Zy4PgVCGLWOOwg444j7PWp0Ao5rCH1NJkJP6DEAcKJfGV3EkW?=
 =?us-ascii?Q?L+FlJikC13250tT1QHH+ijBO9tt1W7/fS7GZFJI4rmQ+9nHpHBMGcgvtFS8I?=
 =?us-ascii?Q?Bw6SLztpyB0AYAYkRMHcxTNcR0Log5qbfT8eVJ9Dm6bb6yyxMoOTw7LnK+kG?=
 =?us-ascii?Q?BV6WnvgyiMVO0S6idtWLo6OExh5RnKaiNFv653zCja0trVKUQT0cu5Ad257O?=
 =?us-ascii?Q?6PzP5GVfvaEUhLFc3ea4hcx794sHLFOm9xIySf9fQl6QU2AvgnjqFePlScGt?=
 =?us-ascii?Q?D1bTJf/XTc0zVZwVUNWkFQFSnqf6V65DGg2RiIyH4bwJmRyKZgKJJ+loY90K?=
 =?us-ascii?Q?MblDd+vA0O6pP2iQuTpDyTkxWiCRUSOWS6t0w3BKPGPG16mvigCKbeQZkCam?=
 =?us-ascii?Q?Ju3w5jDMWE8R7+izlKqzmKDaJ0ca/NzSDcjgZTjnpV1OcCMopNFfLRswmKte?=
 =?us-ascii?Q?4Qkpu1aZIGbXhzmXKrkckiHpsGRf9Tb6/aj44VqqLgsSi0wKUiZ/v0TEGUYc?=
 =?us-ascii?Q?BVzkcpZCLYmcI5kLjJReUKXcPuSmpHNveinukzod+iz0SKaIes0oDGfRc4QG?=
 =?us-ascii?Q?BuZKkvGk/RrThe8l3or6BnJ+fGUQ3pIMjTpx7O9Gg+YltzONLdlIJxlWtBWe?=
 =?us-ascii?Q?aM8oiZZsx7/UiabM39hoZCvfjLoJjnAeoEB1kMaoNvddhyJ7EyqhzKWsUPKp?=
 =?us-ascii?Q?JxuCHy0DruCOalW07MLxAV+8okiUXZ6c?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 00:11:09.4576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d4036d-c031-4f20-56de-08dcc3d1419a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a new SMMU option to accommodate that.

Suggested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 16 +++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 214b2bce28fa..afdb8a76a72a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -351,6 +351,15 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 	return &smmu->cmdq;
 }
 
+static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq)
+{
+	if (cmdq == &smmu->cmdq)
+		return false;
+
+	return smmu->options & ARM_SMMU_OPT_TEGRA241_CMDQV;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
@@ -369,6 +378,8 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 	}
 
 	arm_smmu_cmdq_build_cmd(cmd, &ent);
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
+		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
 }
 
 void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
@@ -423,6 +434,8 @@ void __arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu,
 
 	/* Convert the erroneous command into a CMD_SYNC */
 	arm_smmu_cmdq_build_cmd(cmd, &cmd_sync);
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
+		u64p_replace_bits(cmd, CMDQ_SYNC_0_CS_NONE, CMDQ_SYNC_0_CS);
 
 	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
 }
@@ -706,7 +719,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ce76357b6fc2..ebd9db4789ff 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -665,6 +665,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
+#define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.43.0

