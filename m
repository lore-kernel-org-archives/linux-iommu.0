Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEC13E5ED0
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063752; cv=fail; b=q+o1jcSRy2Mouu2gT0WeA4KSupovZT/eSwIXY/K16rqS2nE37MEa6lSpHMZUsI9W5lbIQh8jtAgcXkuludy7/W/7L64i0I1RFk4q1AYVnGWTqBh0MiMp2nZsNQMUTgV5u9aISKzF2TZBNIkwMn5L6z0IcBwK+yDWPDS9fHyW0Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063752; c=relaxed/simple;
	bh=1BMEUfEUtRwiY0UKEuwyxww5wZjYh4hQxRct2D3xAnA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnfDK1yaPx1io1YDXPJvHITnGBAydPDsLOgAf1JvL5u5UYv5nC+oK7IfErLoBqJh+6VVm/U0meVy0r2LB1UYrg3fvSJJO/SAcVuFwSFBgWzPZA64jz1NC7O5Aa4lYP90ou6moMzuqs4mC1ZR4Dxpar76NM+Ibf18yflcqgAcksU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XurRQhjQ; arc=fail smtp.client-ip=52.101.48.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XurRQhjQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaLABZ61sWwuyEZTMnVR8+aXLaFrvn+LU3lUjpVUYJAQrA5s+KKdUCslPVbYBkCPID5LAGOKW5fFrQVXfrgWLSfkebgrxmGhIinsi8Xwfzxa/rbFW5hnnPalLZHQN1rV6afZL86WpY3S041NO4BoI+ywAMDi6j4kT/Ut/Jhl6Y1Q80dV17PyOAWsOSy2FroXzFmu/BPbp9y/Fkg1WHKbDwwCTMxbdo4JflX92H0O7SSbqA03W8vLrE61vynm9VjjoMuZRaHj1xyU4FOUKePK8hM7XJlkgY44UPI9MeLnW3ibZxZJ7HgYBVU+wv/W9tnCjqIkgHi9a5nznYjEU4df6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ihMHP1kiSQo7PDS0ImGe3qoqy0nxILnU9Qm29gSEZE=;
 b=QJFhOtAGHeWocdukt0P+Sjue6oizT7chhMtxCO7wKJafIEqzS1pEiahFOcTWbdHXGmK0ki/Cmbv7w3jln8DvP6QW/8CxrOuLvrKvDdZ+r8D7lr1FWv0zXI4zeE008Ha3uNF0eiqyll4/chHyYexZ166tMdxscn6QTqa3nUnQZzqEKKkHv+nV21iwlul+qEjFWTkCmN27xrlIAXtFvPNP30vtlCK1RX07fWKrC0hJr/iGTt8ioA78K7f2f4inpxw/YxPV4Li6LllECU+1+8+TqvkKFM6nRmVd9PInmgGLPAykab+7nvVr/Rydn07CvKSkZG9DqbJ+jYfdf2dym3s8xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ihMHP1kiSQo7PDS0ImGe3qoqy0nxILnU9Qm29gSEZE=;
 b=XurRQhjQcAQ59jaGLIUNClf2OmCq/4PN1kFXhD8rqJx4hLFcqNLN1z3HHypHUc5GIW9CTU+J/Pub9051Q/5pnYQqTJp5pfNlvPJerFH96EB3koMLEMWvqAiZ4hHYmeHo5GSm0HMMFuQF2mQAlRp3/eRHm8deN+CW/MHj1ZZDEB1ghtlBqD9kJS2Dg6g351WdFCqVNM6kO1S/oqmlSYaTl9aF72s4NyGZQoygdPvo7G7U/fuN3dQQjwAc37Om9gej5fpCv0rU/KDXgV+DMnEg39yAX3y6kpEF4pK344zpP5t1NG4x57UObg/5ZzGpXPGdq2KC+BrwBs4xgQ20pheL5Q==
Received: from BY3PR04CA0016.namprd04.prod.outlook.com (2603:10b6:a03:217::21)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 14:09:05 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::4a) by BY3PR04CA0016.outlook.office365.com
 (2603:10b6:a03:217::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 14:09:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 14:09:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:37 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 29 May 2026 07:08:37 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264
Date: Fri, 29 May 2026 14:08:30 +0000
Message-ID: <20260529140830.629738-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529140830.629738-1-amhetre@nvidia.com>
References: <20260529140830.629738-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: e5cae11b-971e-47dd-b30a-08debd8bd687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CF+avVXLuCRdbmnT7EP53xa9B369WrWsTdV0LKxInBarQuVfNuoYirXBGJJKWV+dPvgnEID7J1YfwsbgFWqiMS2DozyPdjOsghivPc3V2VgqN9b/ViC70HQwF1qmIkbh1m3G340SV1qjMS1H0rjC3MHt8MOL9QxR47N72lqsaSnpF7Ghn2Gc4HJhC9kl9jsweStj/+KcI95Vb71R8gkUB/7OIo8OZ0ZBSD+ATRTpLHD7hofZ68pme25AQ5RUYRbDa2gYfJXb7pEZU6i8WA0n9fbuBq9Noa1h2tBP7d5ZfO05RCOi+m5spubUnxQlOJwtpetFxdhZitCR7stEuba13v1xxnamcuLrFywQmjXOp82x1jtgEwuEbBlleQgEhAyZqJqfdgNYEYTsVxcfRFA16G9LLvM8JF45jXGRmHsSe4nPA5ds0bCKvUrNrwvxTyvnPY4MBzqG9EmrzNU6SmNZHd8AQwzxr3yOhZvaXhdwByZwiCNeJs8/CCgcf3MfkVm67dHREQMCZV0G7Expubajdgi0wAdjavAz80w/x5Zw1PW1GNCa5FF42L09+nGFwIwu7odp9BRc1nCT0vYklvFyEm9YwKuovOUcSUFs3GQMbkAKxW/9KZnEzDwKfTRK3xIYGtlexkuIUtUDFEJOIuJXKm+IxN7L/s63BYUzMc/IqvwKNWc8LS0NLdqIUfyIEXmSog3AoaqUz00pwk1fZNHe3+0iUhUHWSBHPa/tj95qbEc=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/SYYuNSX/Z2VozLNOGsQN1MK7mkq9Rw1xZpiZVii1RZe+o5ts6hmZMEIrL14dl9agrkIbC9Vrd0C6z8Zyz7Adghe2zVl+JtUoFI8jtWws1dzii/JKBv6VJCgS64xUOtu6tbo0ORoJfyEmuC9380vvtLp/BhOXv0ESnzQGUEkBY4iqfMKDf8i8rU9sAAD/XKXm55xz3xcC0GyqxEwMjSQOC2CUMuN+XBl1ajsN8SL2KPg/NBBHTzARkw6EpDpXcr0GNNHPAWBrbckorSKGxIawsncU1yzb8HgER328ncLgtd5Yfmt99keQYN7tYHmIZdeNXkUQt4cP6Arl5iMgtMbXtgi35lorv0g6CSSI9zqfxKE0vtLkfuPntV+3JLLfIIeQRY6JS3XRQYdq83/1Y+T+0Da0r8Rqdv/VZ1YqzkSwLslMrK64+eePCKKp29xoJK9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 14:09:02.9564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5cae11b-971e-47dd-b30a-08debd8bd687
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

