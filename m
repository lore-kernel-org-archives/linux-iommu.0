Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B5399CE9
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310952; cv=fail; b=Z10QPkJ4abwyDGSPsRXE0GNMMy/Dz/5zI5fnQeitTMjv2Xp19foDJ8kX5nIiGKjz6fBlnN2VgtctzhFn7hY9o4GDVCeMFp7NJ5cXLd0xpHilz36wxLu1jF2B4QXziNlrE6pS8ac07jv6SGufDdjyxS2xO1qEFfF3X3q7Hz86kDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310952; c=relaxed/simple;
	bh=xFQnKw63ChVOpCkpqkpb1e0yXyaKt3DOMdTjmoWi53w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6iOtZumEFmZBGCT9Q0UXPlspqTm5V2vttw2jEMnERMT8X6PRS1UU1p0TtwhEJzHlH5MSXzsTI4X5asOz56EsGmQeC8CKeJ0OMIk7/aNX+EOuxJovjqgKg+00gZAeEoVkf5XrFHXFkg33bL7rJxzFrIIi9YwPzM71szxIbi7/i0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gWkCJLiv; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gWkCJLiv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdIU0NemxS7pxistCZHkMEDgvQLHmryFFBOn6b/LT9N72GdjA029PlLOfhFzKytvGvBmPDjtvZ+WbKjUeyI5TZmi144CU+VPYO1DJb5/RbIvet6R8rXzvO68FF9WmOp1HVLe2qai/T0M9A/vlFeS/F+r4grrnwBy2upmPsLEIM2JjLQDRZV9aHs8GOy239M61Z7ey4tgSDnfBUCTgqY4MpXVlUA5RosKOy37pQuiXi4i+AiB612YYOPiTFRewkn2fQv97fipWtQDoFHGLgsf5CbSWEeNs6k8u2wwnqxscuxMhqXkHPjFI3xViejEcRc1isEXS32IomYQ4R1tkqhgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku/LApgaR/nfFXgkmtmdfuvWgOaL8+Tqey9W6gHGJNM=;
 b=iJzrH/poGUL46mMVn41FbTLocx+0iOXet2TxnHqGWG5xJwdPeFdhuaJoNZH1hFIIDiva0PPoqe2evIkNSm3nVZcJ6gtE2l5CdL66KX71UZxLlfiyPANGT/UMn4u2BIPC5+9ZsQ59og8gGuqb5qFfz+iOuhG72J78j4NYzTBO0E4GWDvSNLjkYJZCNxFifJbvGQmLgHVksn67Mh0KUjpgl9jS0FIwiPw7pFgJllmmEl9OtM2W/nsJ4dz66o2YriBegmdsdUHA9OKAWkONIjyIKEKmqiKAnGH1SI8byZBhvfuEReOxHsh03y6z29hfR+FPebu87ZTlUYB+EbYshgp8uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku/LApgaR/nfFXgkmtmdfuvWgOaL8+Tqey9W6gHGJNM=;
 b=gWkCJLivHxRrUyG4oLe/yFXIFdqyogz5jO1L7VYM0b47By7D+kcrH2ZO4Kzuf5HhCtAcYVpB0+wRl4b/X/Cwn0WB4MJqjaOvX7ehcKN28lbnsCJRDX56PvvWkF84tRjRgoEopdYo5fgyFKm4zHyj7oBCiB6V0cMrUTeyZqAgEVHXoNCf0l3Cqrr7DyQ9ZstjOpGOtiJZQnEwABY61R+GFmZYmzId7C21yEc3e9qYprfLXki48JMSPGByRuCa9UShGhdUdcCRH/ZU2Wa0wrgq7gt3fKGJVnlRtvF69eS8rOXryzidUKCWKJYo59uVCvLenTD1RS05opavrA6aieKm0g==
Received: from SJ0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:a03:39f::24)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Mon, 1 Jun 2026
 10:49:05 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::11) by SJ0PR03CA0229.outlook.office365.com
 (2603:10b6:a03:39f::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 10:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 10:49:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 03:48:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 03:48:51 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Jun 2026 03:48:51 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v3 3/3] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
Date: Mon, 1 Jun 2026 10:48:45 +0000
Message-ID: <20260601104845.995005-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260601104845.995005-1-amhetre@nvidia.com>
References: <20260601104845.995005-1-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ba1784-c6ad-48bd-97c4-08debfcb6670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|56012099006|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	/t/gmrucF4rUxfPTqI4PqrcQmiTBNKVm+LEy8JJfz6RTlwOALkquJ/VCUQb3JGo6qZyidPc8nb4Hw+WntQXNr6IYuKqaEuu5Sohv0eO/u2kpLHCGg0xQCGU6v/8Eyib2pMUAJju6B0SxrORQEQf72BcbhYHM8m8W8PMw8GzkoMKB8PW4KcHlA1i/4F+Q3c/rc6E4010Ow+TMTeKltUkKA+mP3efPDhsvN9HLT8Sh4yN8MpSCNTRj2y5pTCr/2M76sS8iOLDtnGeRcOLiksv3K9WgVcl6P7qkauC9sdJ5uhdyxyTP1mNc23kJep9iHzxccrgseWzlNRVfmmgD4HBa3wJYa+iVPAwhro58bQnHDFJYeC3PhE2GDqf/t3NvvTrGwCUylJ6Z8AYQvUXE+oxi39t757bok3lo3d92Hx++lWBRtVccXy44ZAMcKLT2gU+j/0QeknGwS0Ne1LS66YuTVQasgKd2hHMsLTWY10+snJFEczJd4XEvioW3XzKzgEjbVH3S2PaGH/e4Y2QPZRp+JnH/TsE70Ozd0SUANv9ToRtuBJvopGsM3x5NKG0Equcih0NaAHSFQNuXda8ft4gEGmXB/8PXAR2UPIw3p+acwehCMYYWZn6hJR1E8zGi1woXD5QMtEkuJwYEjhg6wxQpq+5mzY8GEiWORyaARM9IJmwShkHlYnq57AMSi3LHc+H+oaaGqOj2kTJx97cAF3eKdrWXnVGJ/KuTlevjes0Ft8E=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QvI5uEeW7ZA9Y+kjsTvbAS46FIaKT/k2XwS12TEVvY/6HqDYK/30fN06hVCR6EHPJCupMNklDMFAcDaJjOqzV/b6PV03oofOnlUf8+9Lpn4a8WGHboHCAF8n0+Ivldj1CFk1pbkSRTbmm+Jz4Ob0+AF9xeepIA+0bQTlNWebEwUCfBKF/qSQunIWPv/ZWokMmSfvzddDXg7wu+bWFg4yWROL4fbZYdCFPMGw8nY1KXmbFpAo0oHDtwho9YHgocgwqO0BujzmJh6+0L+hFsi9/ynUEsndZ1KQ4BFdeV6dg4rTlu39O6zpYh83SclyrbIzeF1TLfE04NWeCkTJ0/gQJlXB8szjZ0hhzESZH2hPcCuhpaUouz+6hi1AA3kKNPmiv+Qcov6Csh93JuEDrZjrEjU/aUXLVlGa/0bA9HPXzp7JmFTUhfvH8E0p5WSohqmB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:49:05.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ba1784-c6ad-48bd-97c4-08debfcb6670
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296

Apply the workaround for Tegra264 erratum ARM_SMMU_OPT_TLBI_TWICE by
issuing every CFGI/TLBI cmdlist twice on affected SMMU instances, with
CMD_SYNC after each. The erratum requires this exact sequencing:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that, on
affected SMMUs and when @sync is true, re-issues the same cmdlist a
second time when arm_smmu_cmd_needs_tlbi_twice() is true.

For the in-tree batching path, register the Tegra264 condition with
arm_smmu_cmdq_batch_force_sync() so that a full batch carrying
CFGI/TLBI commands flushes with sync=true.

For iommufd VSMMU path add an arm_vsmmu_can_batch_cmd() predicate that
splits the iommufd batch at cmd which doesn't need doubling.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 23 +++++++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 36 ++++++++++++++++---
 2 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..78c96a2b652b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,6 +350,26 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
+/*
+ * On Tegra264, arm_smmu_cmdq_issue_cmdlist() doubles every CFGI/TLBI
+ * submission (see ARM_SMMU_OPT_TLBI_TWICE). The doubling decision is
+ * taken once per cmdlist based on the first command, so a single
+ * batch must not mix commands that need doubling with commands that
+ * do not. Split the iommufd batch whenever the next user command
+ * crosses that boundary.
+ */
+static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
+				    struct arm_vsmmu_invalidation_cmd *last,
+				    struct arm_vsmmu_invalidation_cmd *next)
+{
+	struct arm_smmu_cmd next_cmd = {
+		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
+	};
+
+	return arm_smmu_cmd_needs_tlbi_twice(smmu, &last->cmd) ==
+	       arm_smmu_cmd_needs_tlbi_twice(smmu, &next_cmd);
+}
+
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
@@ -382,7 +402,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
 		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
+		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 08684bd40a6d..f38c21b56f28 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -698,10 +698,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				struct arm_smmu_cmdq *cmdq,
-				struct arm_smmu_cmd *cmds, int n,
-				bool sync)
+static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
+					 struct arm_smmu_cmd *cmds, int n,
+					 bool sync)
 {
 	struct arm_smmu_cmd cmd_sync;
 	u32 prod;
@@ -820,6 +820,26 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq,
+				struct arm_smmu_cmd *cmds, int n,
+				bool sync)
+{
+	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	/*
+	 * On Tegra264 (see ARM_SMMU_OPT_TLBI_TWICE) re-issue the same
+	 * cmdlist with another CMD_SYNC to satisfy the erratum.
+	 * Callers must ensure the batch carries a uniform opcode class
+	 * so that checking the first command is enough; the iommufd
+	 * VSMMU path enforces this with arm_vsmmu_can_batch_cmd().
+	 */
+	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -863,6 +883,14 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/*
+	 * Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE). The batch holds
+	 * a uniform opcode class, so checking the first command is enough.
+	 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES &&
+	    arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds->cmds[0]))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1

