Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A77318B47B
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970912; cv=fail; b=cvck1mCHgtHi9cL564buxJSAR4zkIFzb/scT+v+68DK7KueUmiMKTiR2cOIHDPX+VrrJvCx2vYnxsQNV1JVd5f7A0WvOyL4NOJGWS5A2mj+Gt6RDn9gwFKml3JrzTtcIA1ZFARhnuDSkEDlarf60H8LcvYTSyoZUk9TJgDmcVx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970912; c=relaxed/simple;
	bh=qH2++Y5iWr6WBO8eiH7lH1dDfKOQHDJ04qJuGDMZAWM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWQp1jVwXkwmbpfHV1n2B2GTWxcwlkDJVKOUc905oL0OqTjbnpvnFyP8oqjn9OMmEEAG4L0UOT/d8PdBbfgQqGopy/riumXpKbKFKa1fDN4+p5AKN20oLJpfb3XoWpJuxdicShfVij5WaEecZU3SFAiCpvDyqFv6uiuTb5WF4J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QW9/sl1B; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QW9/sl1B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVBSooiTImE+Pj+LVdTdeDhAaUn7Su0vtEEn5oOkfl3RT9Jd75eYzDhK4Z799Et4W2ubaYr3Ux4iTWC1VAKIyWOuyWsjp7EF0lMRDLva78yXoWofa03U8pKux2zZjNkstQwHWSKlBxy8SKeWglmCQYS3rzRJmNGm++e9F3N0pd4cNR8xDiExMrXTVK4XUbDui+ac2SZH3yKgWJlN1QVxCHHS7X8L00DlBIsqKJZNU29ryxmtGdfYrp5fs5qXr9REprioLrWhcXi/KXCs3cri/3vMmwYkEK3nxR+bVKZMGbRzQbfA/QqlVxEsZoKsgceh7z+Fha1xvkfWarJm+CfvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CthPPqkf9d+3+iICz9vGMxVa7KLjIhUyuJjs5Qtmv/c=;
 b=e3MxOpTGD4KGLgVSajoSk/FxZ5pBTaDkkCtvnjSNguyaLeG286uNYSHFEevajDxnJdkWFUz2Nz6GsSHDPvW3+WfnL7eHU5xjv2FOPDelkaOdHDxsfYXZI9bveOKGFX2WzeiU0KxDEC3MNNCYRWxA1QvPqeoHbwtVu5A4LukXZF6FaJKgWzT9HkxUVQybvY3MQwb8Bz1gRYgLBQzT9nca7EihqvGXpyq3cLcFxCe9beDGpOAxobpJwB8HJsCumeOSFQ0/hnjtSmfa+X9SyhPK5ECA/eaVVJpeTeTNF0JLK24w/tGWopqY5nHcUcQI0xI7oAGx/pWo1itHOkjtQ42+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CthPPqkf9d+3+iICz9vGMxVa7KLjIhUyuJjs5Qtmv/c=;
 b=QW9/sl1Bcd2aMzqRjy8X2pbnvxk6L2+9CD/g2HdbBWFY8FEAvSTmKbBDp6G/wYIbItkGx6+SkberzdLk9EBy/6xVOfWInCOevQ4lntMYyg8UYXsBCuAUSs4YYo9py1Ao/pCj3Em+R8gJ5Bf2tv5pwzWx91JWLEQs4VI2cifzPRlSmfStLk8Kg88sUAZAw8YdvAq/UWPfm/95EcOFrWluhNMyXaiZnSWKBxv1kLGMcBNvGwz/RS2Z/BqpRF8vH+KqPYEPy1xQaQ60rpKEMCm9VNuASe58/95YDXDL9D9WJxntRxiYe6y0gwcb2EZtZCgxKWX6Vh+dzbSs7BGsjFWCxA==
Received: from SA9P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::29)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 22:35:06 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::93) by SA9P221CA0024.outlook.office365.com
 (2603:10b6:806:25::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28 via Frontend
 Transport; Thu, 29 Aug 2024 22:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Thu, 29 Aug 2024 22:35:05 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:48 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 29 Aug
 2024 15:34:48 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 29 Aug 2024 15:34:47 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v14 05/10] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_TEGRA241_CMDQV
Date: Thu, 29 Aug 2024 15:34:34 -0700
Message-ID: <a3cb9bb2429fbae4a59f7ef517614d226763d717.1724970714.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724970714.git.nicolinc@nvidia.com>
References: <cover.1724970714.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|IA1PR12MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: a65eec80-4590-41b6-e10a-08dcc87ad48a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eHWmqBRSKKegDiSk43GTVHvonHghBZdpbhwc9rL0O1Ke2IF0p3iEi2VtKIDf?=
 =?us-ascii?Q?d+qXVDrhHbY8ZXf9Fl7hrm85g+uqIzrG+rNgFbvl3L6C/VKTtpn9gasuqGN7?=
 =?us-ascii?Q?Mj+KYM3V59PjiA6lrM7ufrtF3dyW3EAXfoybJv7sNmUE3m/0v5yn9AcdFi9D?=
 =?us-ascii?Q?NtZuytHb1+RAZGgvsB6m2M20B1zFgYCZT6KLLYYDth2divoYOltDQ9AtBKHg?=
 =?us-ascii?Q?6RLyXknTi3GW//igGq0nEo1KwT8b3lhFSZy7qQAMuUpbr4B8cGBmSxtoOx4O?=
 =?us-ascii?Q?ytoJV/feTjcse96XRY+MLGHXTwU2hLEgs+OvW9BFEyVgyOiFr867DQNOb/S4?=
 =?us-ascii?Q?lyHkjrXWaMiLfo5+I+TE2L4vNuc3W3zVy+dDsYy4kjdq2/rs+TtD0I04L1s1?=
 =?us-ascii?Q?Zl/uLHlRdIYfmzxiWXaFHReUA+x6pbMee3xRH+1DsGXJXwpCtbQ3gcLwNgl6?=
 =?us-ascii?Q?8LuB6kN+BGTlNLxiXUnAPm0YyqdeOQPFh8m3uXmQ58DgEqQv+J/69vgP/2XC?=
 =?us-ascii?Q?9ljVQ4nanAYON3l7JCQaUtOXIKVXI4MMRB1xxpE240j0K+cu5ZvcKune/jCX?=
 =?us-ascii?Q?VNgofnC3OJxtFp2CNalmhcNKxMPSNsMMg9FbwgP4gGJixqkZNkM/0ocZI+0B?=
 =?us-ascii?Q?HLY/j1mcq3eQnt7ZgbdmuIUObzMDtVFsiiaJbr0QShmHjEB6Pmm269ab3Dgs?=
 =?us-ascii?Q?25D+T0MYEmdBVygX0BZ/p01O1S4wo8Bea+bliS25kT2Z5yz0+3DQlyJqwF+j?=
 =?us-ascii?Q?nNBb3RE4QD2AcKnnm7hBBMOQjzjQcJ+Ic61IsLkb9QlKstrEY7XumbNqrBqy?=
 =?us-ascii?Q?IVim5zYhAocbvGXw8W/kEcPwzzarjY+300XgRkEP0CFA2PZ9eFdsfdE2PJwH?=
 =?us-ascii?Q?dAKUS08dIbMIFBxl1ZJV8MTH232zCv5dX0LPgjgA3fF/ZBF/Nn+cP+uHr+rA?=
 =?us-ascii?Q?hGr23oJm1ObpD4ZMm7kWgQtc+up5kWhRVdv71+sjVCPJ09yUH0SK4RM2D2E3?=
 =?us-ascii?Q?Iuw08l8AInwbUuqx/CPKk4/txWrhq9M2OeBb0k20VIE7eut886TZ/d1x9YqG?=
 =?us-ascii?Q?o5lhYrVBdhBJjYgiQcgV3gPN0RvHG6kpqX95U8nzEzqyIBw5qnVsgqloqQjG?=
 =?us-ascii?Q?rMmJLs87+YS442c5GR7P/aNbgGLRuc553fk+JfJTiQWKyoYbNWIYUczwlZBL?=
 =?us-ascii?Q?BRvqXVCtH5drT+1MXn8kzPjlvfeCZ9BekncNEnQn71r21wVYuFQW/ibgP5BG?=
 =?us-ascii?Q?iDlMmljxwFzy/MHEp/NaW4YMGjsRGKV3iODh4z2hD5NVP+1V+c6LIz0ZdX6M?=
 =?us-ascii?Q?3z3qknVXsT4uSOOD6wIaFM3j2E2cats+ZCeLtxEX092xHRlzN3c4i3poVfPb?=
 =?us-ascii?Q?/2pkmBV4YdciGYpFHLDjDV3zA3B3hLyUHcvDxrej9CzyJZxm+MSZ2kqCVtNm?=
 =?us-ascii?Q?hzGE4rIJsqgTR8hm5O7ruB5lzvR2vFhD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 22:35:05.5641
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65eec80-4590-41b6-e10a-08dcc87ad48a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736

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
index 061a61f4ff0a..816f5937345a 100644
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
index 50efc804f91c..21f034f0ff4c 100644
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

