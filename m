Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074D53B6BFE
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779963410; cv=fail; b=R2eU0s2/Y9L7fdKZNcnRKR7ewjs9jyKBPdhs+NZVfIXvsQbszPcemQ02i2cQMEKTM9Xq5ZUWWPq3Aar5Mj0jM1jZLTgJQzFNdVM8Sh+/KWiqZL/T+KCG2AcD5e144x2NLuygNUKk3mGQ5E6XGu1avOtSaFGO/OuVZ/0WioWLbqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779963410; c=relaxed/simple;
	bh=i8bxfVGd/a3ABl2jx745yPc8BJpN9IgPo1wrz90gK4w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUGo9BVnmcxDVngBezCzygTjC+wQ64xZpOQqKo6H18IN/S2OscguAL1FuZrIMBdldBuAIJyl4WpY4O//EoiwknfON+HFX6rj4ofTv4qDHEp1aF4Xis8z4j0sydL+tkhHCz8vqx4+cMmN3pqZGCtjwRFBLDOu3fd+ZlwMqclK26k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9F1mHzX; arc=fail smtp.client-ip=40.93.194.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9F1mHzX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wADQMWBAzyR5DcMQlEs9FK1sb5Dd28ZdI9mWbfOvXihTEr5qbWcsoHxESgPgoKcD8DDoaSSeFk0LB9WyzSM6nx/VfiUYl2y+UeQsugoSe7vqLPyC6qFGiB2RdXSnjLPiHr7eT02aSKaUcxxiq+27Ez/u3bpWiwnLlbYwXxVQZhmMzAWCd7o/2z7QcFW20SzwmVRfjs7RfG73tLX7dgU7aoyM0F8CMXlaI3rmPs5DMm/7ZyqyPaORD9l+S8FKAwnN3d8AnxmR4VRtC8CRtP7F00WjLfV3SHUL5WlB2/LlMmYgmiaiICnSSAz8Jj0zxo4AeU0aelKvFoTBvlXQNoxlpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F10gfXGSXfjZKkyWRmeC2yp/+83dUTEt7fVfCGOsUhs=;
 b=D8wROHBeS/tI8HsHS9FtVG/Unifas7nE21TfdPtaPCE95I2uPkp2yPNO9NXi0WoauJVU6rMTooFKaNX/xcfXOiOvTkpgJNahvYOnNMLoEjYsXum3tzicG/fVLzBods1/z8EMkaGlQ98/xFamFSkk144CaHbUECBpyQj8++ehLJYKmKnP2IodxVZW1IgaH4+TJauIK00MXktQaJQhQTJxM+SQg8PXXNTgNacXo0iPZDTs+w3sirAj6dv7ssG7Qlq+qC1+PQscn55//M6QZ9vHOgFYlNeRviM7za9bq+3xyhoRvKZCG6rfCzn9JfNN19tT30wafuApZTJ698eWw6y5XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F10gfXGSXfjZKkyWRmeC2yp/+83dUTEt7fVfCGOsUhs=;
 b=b9F1mHzX/n4MUfDRG5BFxexnY3s/LgTQCx71vUxkvOKyZEWfhBrnKmZEwRurxQxXGyJlrSOYr+wkIxeARBW7yO5leHaHs/2+XzoMCZMmtDsbwqiNHqh8Hw4WYnKk+sUJaq7bxQnPgT3YCrKKS3ybHQj8GKJRgcNgXgFtaTlw0xqzfjhQRKXCPPDsFJWnNidmO8ShGd3nvk3o+Mi6phCA7wUwTKNq+zdUOMLU8ZOoC7bZlReIg/aZUwgsO/Zfxwi0U7QLuDbE2I0t3jHWEAWoc5v8oElsnvW+HZipMvKFImeeRFc2DJzUjPDEiMmdidgxtGvpgry5HHTzRZhD9ge67w==
Received: from SJ0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:a03:33e::29)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 10:16:44 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::ad) by SJ0PR03CA0054.outlook.office365.com
 (2603:10b6:a03:33e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 10:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 10:16:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 03:16:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 28 May 2026 03:16:32 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 28 May 2026 03:16:32 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 2/2] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
Date: Thu, 28 May 2026 10:16:17 +0000
Message-ID: <20260528101617.4068249-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260528101617.4068249-1-amhetre@nvidia.com>
References: <20260528101617.4068249-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: f277ebb5-8c21-4882-9fa8-08debca237cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JGyA0AosYjNNi/YZNJ7eTTwjU7PnbT/oFvM2hyf4qTwZFVNlUShWBxr0Hgef+gRJNhTEfhFzY7kdV/y1jAPTWTg1dEpYivtMUwHPB66DHTfow9CWzIVQOtZr9A1/Ky9smCgA/XDQtLZ43FSEq8l+hM3im34hUSZwxALaIsvNfsMlRJoHJnVoJzJP+URDE9umIZ5tU12y3PkNTDzx3v7U899vlFZXAm75QKMKZY2pnKWQt8Pg+z0SMD0jd9+ZQlQXs5PsaPXLviUsbm0Avjqocyhe4NJ/L0BYqJSEIDN1CR7qUX7cuqV+VuQViEClIuE4e0mckH6Dzjf+XLcB5yP3GKIG6r4YeOGuNceDCJ7XTF27OChVeJSNaglS/tUlRIUomBzXxLI030Y8zpBUoxVcFCrUA7qMpvECLeMgC2sOhASgZQMux0Xgyvsfh+OFGKe7nFbSHQjvha+x91GzxZ3lUm2C52IrIO54qE4HSmi696CBfco2LuZieOpPIBlRiPBt5vm5wnX0TebPfsoSJrIYw+Ncur8FJTy9zLoTxRYQxOQ+jokraxXOx/s1OhWof36k9muHd3A1yZ/imlwySHFIlFheNXp0qNFys+9MB1UXBhhzZZNztflqBXlFpirYmjcpm52ZjOTMDt7l4/fj01yRH0D7BUXQlx1LbxPEMWlQBJWeaCQo6IquBQ7yuSzMh5NXp/uv4vVEFRQz0BhUvntPIFChkZ3Tq5o9BjsZkqNoxhI=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jHe7ffkAkyrFvurxF4lHiVl1BlrBgv23PTxPOijLDecC5VXVhWQSR1+0Ci703tNVDdP8gQ1yjuNWtdFaJ2QnOJjl9kR3nIg0Tsp01I8PCzJJEFjuXObUdrYbUouPyV4atKPPu3VAQXyBE115YO/EjH0e/3vykf0ISAd/5E+wgXiv4sizHZZ8zvmnqlDFgRCsKCfjsgicCmK/IaiCsj6brahBs9LmKugla3x4s3yPF0SKOdBFJRa779zONogPTJx+oYLScgo/naEGZylBGCql+ZaWn/ZEKF5t1ipcm41ZDl1zrPiX3DCwBuvv5FieVLDNa4Uf/Kx8EOKbZNOKgUypFPoTOoqCA3UzcbBXdkzPVB3cFzSAn4fasnwl8mIqB/vDKXy0Qg5ojuDNnQ1hwrfHsvqLpoQKtyqjTMG2HSltzyMD+c0hdoCOdF+dsauZdjpV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 10:16:43.9083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f277ebb5-8c21-4882-9fa8-08debca237cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227

Apply the workaround for Tegra264 erratum by issuing every CFGI/TLBI
command twice on affected SMMU instances, with CMD_SYNC after each.
The erratum requires this exact sequencing:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

To get this sequence with minimal surgery, hook the workaround into
arm_smmu_cmdq_issue_cmdlist(). Rename the original function to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that, on
affected SMMUs and when @sync is true, re-issues the same cmdlist a
second time.

A new arm_smmu_cmd_needs_tlbi_twice() helper classifies which opcodes
need the doubling: CFGI_* and TLBI_*.

For batches that exceed CMDQ_BATCH_ENTRIES commands,
arm_smmu_cmdq_batch_add_cmd_p() normally flushes the full buffer with
sync=false, deferring the SYNC to the eventual batch_submit(). On
affected SMMUs this would leave the first chunk's commands issued
only once, since the WAR hook in arm_smmu_cmdq_issue_cmdlist() only
fires on synced submissions. Force a SYNC on the capacity rollover
when the buffer carries CFGI/TLBI commands so every flushed chunk is
correctly doubled.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 66 +++++++++++++++++++--
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 88296c0a5337..38d45f175a2c 100644
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
@@ -820,6 +820,52 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+/*
+ * Returns true if @opcode is a CFGI_* or TLBI_* command, i.e. one of the
+ * invalidations covered by Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE).
+ */
+static bool arm_smmu_cmd_needs_tlbi_twice(u8 opcode)
+{
+	switch (opcode) {
+	case CMDQ_OP_CFGI_STE:
+	case CMDQ_OP_CFGI_ALL:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_VAA:
+	case CMDQ_OP_TLBI_EL2_ALL:
+	case CMDQ_OP_TLBI_EL2_ASID:
+	case CMDQ_OP_TLBI_EL2_VA:
+	case CMDQ_OP_TLBI_S12_VMALL:
+	case CMDQ_OP_TLBI_S2_IPA:
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		return true;
+	default:
+		return false;
+	}
+}
+
+int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				struct arm_smmu_cmdq *cmdq,
+				struct arm_smmu_cmd *cmds, int n,
+				bool sync)
+{
+	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	/*
+	 * The driver's batch invariants keep a single submission's
+	 * opcode class uniform, so checking the first command is enough.
+	 */
+	if (!ret && sync && (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
+	    arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
+						    cmds[0].data[0])))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -863,8 +909,18 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
+		/*
+		 * Force a SYNC only when the batch carries commands that
+		 * have to be doubled (see ARM_SMMU_OPT_TLBI_TWICE).
+		 * The batch holds a uniform opcode class, so checking
+		 * the first command is sufficient.
+		 */
+		bool need_sync = (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
+				 arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
+									 cmds->cmds[0].data[0]));
+
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, false);
+					    cmds->num, need_sync);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
-- 
2.50.1

