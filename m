Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D26548E0
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723769769; cv=fail; b=gFd/KbiLhqY3jwZoQnCT5JWl+P2sgxio/kBa2s4qMj8q3ps2F9BFk/mLHjE368e8yBco9hsB3JD7eDyZXZWQLqmj9LBHN0n4CvWD6+IHAUiXmt5idhtolYZxvUZQeNI+Q+H8bu2kGNiITJjBl8S8nhGaA8v1LrEOi0FjHifO6YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723769769; c=relaxed/simple;
	bh=QzRSWXcei7PiMzXbC72EKGJjRTgoDnO77HO4qTgTj/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6RidiXtZ6Dyzi4e4TaOpWB5rKCSTEIVVV3tlkWcQP36SNSYtc9DdjxmvqXWJlSSs29eBHJzByeHqFf0w//4TaTKnHYK5pEt3bjwRhvKxgY7S4rhWk0P1U8jGOXcpLLQLXDKIL/cJqmTqDGBr56jVi6/v9mhvAoGKKpR029Ap6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZKsz6k4; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZKsz6k4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le3VadtdgIkc5eOI2uEhMZvGDVzE/KYnGXeXJzfJaVGKjBG6kqF6u7wR3vHuDZnYzzMwmrVAi5rZoK3nTSVn6TpTYoLS9CVNo9ElSDhg4A5a9bBLhBxum78rLS50HwgTnvaii6CdjWSk5pWGjbknDo3JaFp9jfYr4LvmoZEZPjpW+YYlJwsf7tHG8g+c/m5uRAFrpeb272cBegwGFnInExcEhtHmVzF3XlQGjC+KGGf9eyD2i06H9BIlmiizQLa3a7UGDTc/AHMItOHzJM1icbbhYwNIiat7itgOQIHFMG90G7M/xbKV7ThIaLvpt/7JeDUnHM5gofpKPdZ0KKW72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDlpfknHdGQ5QNcfuK8DRpI1Lqe7iWKdW8TgwwHURdE=;
 b=r+KNqOXnTrED6HiB5Pe11MOtuCKhrm3f2gHf2B86mPyblL1zn+f04sr68fZyO0wBqcIuV+whJfkXTzY/IW3yP/LI/eUPACpk2Qmzy+IP4+Db9HM9Xjaqm0WCy4A6osORyMivaMW8yV+PnmSAN32z7eE/EgIos0h2ZhoScem7A5kC1npdhjgPvOA/kTEsC2RRafxGdcFdUKNtrOWaHFnqYv62HoNijGuwh2HwHTw74eU+V9JU4oFOjF/7YFDhfSAj26aBVj2RftBX4WrNUy/F16Pn7DBzOV6mwCYLecKMEYcPY72dkrzjTgIxYHUmNF/VRTdd79Y6rkGp8aL9MuzafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDlpfknHdGQ5QNcfuK8DRpI1Lqe7iWKdW8TgwwHURdE=;
 b=WZKsz6k4zeldrGqjJWgttP4avP5TnPsGE+oZ03h0mHyxGZ09xfBnZVfFykLIsh6OVL3101k+Ig3wriFtxa1GHMLjYUA3Jo1eJI5y1WVIjXx+xp+Z4WXqQS4FsvFzNfJz+Fv+CiAEpg7H7IjktAifHqFsAkEvQXDS3Ug/sVdPxlabFGF3Wk1GmBywCib0gLt7zX35m3sXLYcojXUAFzY8deYDAVgyyWQa0ug24DVqjIgnaBbobqHsLLy4O+nqnmrYdN5fIMYMP6Bf0kUpNuC7lXJ0PEXOZt7BeWgcyJTFb36fu1ld3MPNbb+YiNIOXRSvYbf0yz5MAxWGeGsXS63pAg==
Received: from BN9PR03CA0115.namprd03.prod.outlook.com (2603:10b6:408:fd::30)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 00:56:02 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::91) by BN9PR03CA0115.outlook.office365.com
 (2603:10b6:408:fd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Fri, 16 Aug 2024 00:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 00:56:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 17:55:44 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 15 Aug 2024 17:55:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v12 06/10] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY
Date: Thu, 15 Aug 2024 17:55:27 -0700
Message-ID: <727ac09c5f660b113b95fe9951b77b2755ce33d9.1723754745.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c4292f-20e8-4f9d-62b0-08dcbd8e335f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wnfj6ZzILzS4ZDwNH8kFzy+gn1i0kcBjnxxuI3QjRaKwGrZPvHl++/zi1gD2?=
 =?us-ascii?Q?oVt48Omzw2BHqcvRxX5atgwFwUSc1SZVxE5spCeh5lCCubT4QJmLczZPDqfc?=
 =?us-ascii?Q?PbeHi/aeoF+W/QGR0L27MKhOGIrIhx81GPmSe8vHT2nyikRQJDctK0Eha4i9?=
 =?us-ascii?Q?7xTGyYTm2zmjdtxKE6l9gaGCOWpK0ZEtfoB/3tZxs6zY+V6ZG+41UfOrH2KI?=
 =?us-ascii?Q?jueWUS+sX2+8DRv0xw8xIRIAhil4DvP/IALPuxSIQYJhxeI1LGyBPE/wCtMh?=
 =?us-ascii?Q?nxzdYP9jQ6XmUIjyKp6iSW6YHtfIAE4WO7WgR94jKa1W9SMZx80weOFu4qA2?=
 =?us-ascii?Q?+jjR6HYNsyEoahy6Uwt6rkm2FB70TrtJ22PeEtPhvU+vCdEJYkdGmTAh+q1t?=
 =?us-ascii?Q?5m3AIyy8eGZWq8wq4mhHfgyE9vejfbo3ESCsIvGHiTDe70RG1ObakI08/Wfi?=
 =?us-ascii?Q?TD6ZU+URnYkzpsJaL4cmtZ3TN6qNlNlfiKiA5tQbpG0eKyQXS+L3vXztgTCb?=
 =?us-ascii?Q?A4ngu/HRgPtW/h3saULg8OEHwn8xedk0atLZL9Wf4F8S0re1el7ibEv2QKqX?=
 =?us-ascii?Q?cvqWNSmiSdY3F3ZsG3O56W/JqViiAlIOn5PvHMrKS3oT3MZ32hMSR5RWhkaP?=
 =?us-ascii?Q?tPHRsb6Xxhpn9goKosJLCB0eZZ7BnUhrsZvc9SrnIJn7R2bR6KYCMGK1lYip?=
 =?us-ascii?Q?8VSAg2wHz2wCfNkPekfCmW4+ZRSCsD4jl77RyolJ/cgr3vpLRZ/O1rkxL4MS?=
 =?us-ascii?Q?TJGWFMvqx+M/1DZoZpeM/kB/z2FFW/SKPyJar7VllXUEhYo1EAnzF06aoyKn?=
 =?us-ascii?Q?cNOLORMTNBAOSzux8YMxTebOEELjxsHpctpCK+GzrAuLouFcyFiK+oE3GFyB?=
 =?us-ascii?Q?2dhTm535yfx9+r4RFLe37HYDbtxd1AxhbTjWAYebG/YWdM5t/ERW46esTgzi?=
 =?us-ascii?Q?e5d/p8cKKRD49fhD55RMY00O8B9wVQB1JKRmP1i5z8FDb9GastendZhxEGbb?=
 =?us-ascii?Q?k+wTIW6e6xtT+9FjguiSxzC6gE6wgGQS+ZyNe2CayVaV3zOuVwQHm29sa8G5?=
 =?us-ascii?Q?yqr1nqZodLd4uqZJkuOhGIuP+lDi1Iw8BiAIo6NyKJ3o+J0Rg2rBgj9KW5+Z?=
 =?us-ascii?Q?tYHljx0hWWHU6P6sF5fqitKFCggX320g0l0r5lNha2wA42Y2Iv5LewVoWgPs?=
 =?us-ascii?Q?bmZPNvXFFNPr15x8zUNT46u1qYnjaSJ1cdj31Mpq86+R5yBpsi1Sczc0v1kn?=
 =?us-ascii?Q?bptPxD6FbqRSs/uPi/gGqFyNZzCePaeD30mOfxXmM+CWwF+sAGhvZObWUadU?=
 =?us-ascii?Q?8GRJMyIGGvBu5kMJsvdknhrbsOx0KM0nsdIPffK4CAwjR61N8HGSxRz0nlE/?=
 =?us-ascii?Q?QIL89AXccHPromo+xab4kQIjfwGME+qzRqrCk+KvVu30ALK6WZKshCLTSUae?=
 =?us-ascii?Q?RQVWjmJeoLbHLQxGYUCpN1Qw1O3gpo6p?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 00:56:02.2631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c4292f-20e8-4f9d-62b0-08dcbd8e335f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a new SMMU option to accommodate that.

Suggested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 17 ++++++++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  9 +++++----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index df1149095860..e764236a9216 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -341,6 +341,15 @@ static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
 	return &smmu->cmdq;
 }
 
+static bool arm_smmu_cmdq_needs_busy_polling(struct arm_smmu_device *smmu,
+					     struct arm_smmu_cmdq *cmdq)
+{
+	if (cmdq == &smmu->cmdq)
+		return false;
+
+	return smmu->options & ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY;
+}
+
 static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq, u32 prod)
 {
@@ -351,6 +360,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (arm_smmu_cmdq_needs_busy_polling(smmu, cmdq)) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -697,7 +711,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !arm_smmu_cmdq_needs_busy_polling(smmu, cmdq))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6c5dc2f10a33..71818f586036 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -658,10 +658,11 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_HD		(1 << 22)
 	u32				features;
 
-#define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
-#define ARM_SMMU_OPT_PAGE0_REGS_ONLY	(1 << 1)
-#define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
-#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
+#define ARM_SMMU_OPT_SKIP_PREFETCH			(1 << 0)
+#define ARM_SMMU_OPT_PAGE0_REGS_ONLY			(1 << 1)
+#define ARM_SMMU_OPT_MSIPOLL				(1 << 2)
+#define ARM_SMMU_OPT_CMDQ_FORCE_SYNC			(1 << 3)
+#define ARM_SMMU_OPT_SECONDARY_CMDQ_CS_NONE_ONLY	(1 << 4)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.43.0

