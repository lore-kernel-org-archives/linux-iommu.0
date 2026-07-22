Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012039.outbound.protection.outlook.com [40.107.200.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DC48A2D8
	for <iommu@lists.linux.dev>; Wed, 22 Jul 2026 10:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715659; cv=fail; b=q4ZW+r1W+DqSrbFTMsIDX3hLN+N6Zvmshk0cX1ag41sq5XXzs9MesRJxoVWMqhAc2vsuNaWA348mnRflJFHedDBPqXQ2opV/kCj777zu/PwW9ptV4Jhf8KRS2RwDVXc1gUQCzop6sNQHbIzTo4LciwAhP/5BtX8NVw6ZunKvvfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715659; c=relaxed/simple;
	bh=F8VD1ioprhOpNMFJ/vuBi+t6zXfUrh0xvYfBLWbRPg8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4Y5JnZJIY4dog78gC5kXWGITsSYiRuZGXPxJXDA8TZWqUkulD23uJ2gYbj2CXUrOY2sFwaj92HqD8JUPVaqbiKgU3EuSixkxUoRtoCmh3KB19nalgi0vYQqzfaE541BGKsSXzLpjPBjGUAs9Qo7jrso7IUUf7NOoYnFpLJrFmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E57iDbA4; arc=fail smtp.client-ip=40.107.200.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E57iDbA4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZi2rutvC9KdB18QdP8NAjfMek/m7x3WSs+Sj9jO4uRsL99DG18hAEvyBIiFFNg1CPTFGkduI+3oIQ/yXvUMCWIGQ412SV7lwa2NAaE4Bh/SIN70fSGVMVvhXz7ATFlE1CtDpCPha71sPW0Hkel2yp79sWK9h9bYMhNwQBtgrP79eg+Kks8eiY72MUHlyM6dytRpSijcg/q5XD3bHbZdyHjjd7voWt1RlhYUnHh3nG1uyNwmPyzrnZlHu+5pkQHPAEMj3SSZbi84snLD14wL7Kv4mV4iRFNOV1/KxpNLeu79IJZDhlvoOKdAof+jyT+95cjX3L1ulPjFWRmFnJlObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EdSnhKnPHtaYZplucRJxtljkfqj5PWJhMvK/7p5w04=;
 b=GQDhll5nICI/yoc/893cpA9oWKr8x4yOh0tpHpyjmTr4PAxJiOjvFj1rkfTFZfPS1VV155DlWhYgUWhzAbEpMOY0EVb27xr3kWS4cn1x7qksSal795oCtDH2l7CtkVOtJZPe8XsuS/0AF73Vj2/FTcLYoz0kj9TNpidk9Km7fhlKSEZ2sWuVSBzPHK3/dMgVc46rPqv7TsbeojfO3hQZP51zg8vcc/v/XoN+ADwXqarVm/8Ubuq4YtSbTqf5mRsAMyO/v7L1P87UI4dDZiq90aAEvLM9j10xPc035zkAJZ/cpYm8AffKq6Sq1S2JvXtWGsvQ8vH4x0rd7+J8H8eHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EdSnhKnPHtaYZplucRJxtljkfqj5PWJhMvK/7p5w04=;
 b=E57iDbA4nzNEWSduHUrz+KH8P/SKMRWvBKsx0W0Xn9HQCi2mkfxRcmX/zSUz9S4RbYfB0qyM5nMSkoAnABqasXdRxd8nmmWdYHyj1mvsIayJOVc5XFm46IrkvAQAQkJ7MbHhvV1ktPwfdeP67nn3EqOrVCCtX5o8IO9bdzZ8T+2WyPRZYS8swNYzTPgPMZy9XdMqen/KCvC/tt5MIV2or4LBh6FEjQGK/loBargOzD2ciIekxDJ4M5A4J34jb7ICIDJdnFxlapZVFIEuEMhe44CJ7uz2yuCQfhGDiExcCSVCf9013ttXDxFCHv3Bvzv1ADj/GAuxWwykNIH/i/+SyQ==
Received: from CH0P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::10)
 by CH8PR12MB9791.namprd12.prod.outlook.com (2603:10b6:610:254::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 10:20:50 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::83) by CH0P223CA0020.outlook.office365.com
 (2603:10b6:610:116::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 10:20:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 10:20:50 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 22 Jul
 2026 03:20:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Jul
 2026 03:20:36 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Wed, 22 Jul 2026 03:20:36 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v8 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat workaround infrastructure
Date: Wed, 22 Jul 2026 10:20:32 +0000
Message-ID: <20260722102033.1122277-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722102033.1122277-1-amhetre@nvidia.com>
References: <20260722102033.1122277-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|CH8PR12MB9791:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a5fad2-02b2-4aec-3855-08dee7dae743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|22082099003|18002099003|3023799007|10067099003|11063799006|5023799004|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y6PMB8axBfL3oO+fL84kweGmcKMja+4evEWRdchF5poaNiwYGdO62mAVBz5dj1zbwAGDBscUxOHRtcgVcwD/uUcr1U3sG4fe1CR5IuHCyEeiHqaRHDGkEz1tJhHRPjAxuVGZ9f13mrT+i9cTqwQpX2zp48fOF1Vm1Knhbtfxq4gOXoMshRuUyJXmrgfAqwbaLEPA6Dqrl6uRByDGbPcDFKFyBc2Ql1HZ/13a6mKhUl/BMTsawsbFaLtvbOSuHXgfQaMAkOJsccE7tYca+/qGk2T3O8xz36J0Kwn1jCA+t2SlF8iYPN1ef7BV9AjtKzyJE85QEuZbwCTJxo1Pk0lPBG6LomHSCrGLM3ysRlUCovUE7ORUtWTkIL2ndOyh6tW1pCFKvlhxu7aWCySYrq/Mim1gemKVPn4d/CWMP7j4+RTAL/sDk/cZ1cI32RRLfD1/w/stYLioUqF5GYHbx1AlkNIuQihQnQnkJkdMOfBu4t/2Ong/RihoTNGXhGM0VGupsGstN4F1z2OhP6ajlWibV8Lf4t1hiNn8MlDuBN0b0sXukIWsoQBafPhtRvhRVT/MkXH5eQ2P0Z913eVjebIyDHlkxv3LayicvxyYMSRSaJvIcDYI6nTut7EC5h1CyMFY5xRNvLl+MvqpL1GMawnEgfA0an6Y57F5WboCuT5gBWbjO1LXYIjT4OFsirKNmkDt04D7OtliBVIQlw2wbXMLmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SzLGOhbRCLnLR3BY8ZfITvC4N7+Ts4cfBLusPLWicKYOqxhZdxJjbjSncLitsL7ZEy7h38yIAJ8Jgs3IkWNOIKRezmIQ414ujIQwrBPkfJWLXGW2UiL8+JU+JDZfTVAE59eqbs42mK2+V5rjZ84UBbY2GwgxWo9Nm5/9d4Pxsygudj+3ifSxVZpabOUgU+e+qrxKJIFt3XYh80mp3eT62EHWCxAkAXdgaIcluD36v/Vsi0WfjZ+BDV86MX+uVvAq0bGAk/8+8r4xDDkernISqNdX//mvrQJ9kCD7SJEmGTStuLggh0oYw1M1+I97+OyBuZqX4WLoLRV5HI+aQ6mu1SDCTwbHbWKn72kOBywSLxTYqvh162wswGBPmCfNzO8VZKtCT86xEYoNPpfZrScWRQjI/rU4QJXj10ntvsDwr/i9OAh37iUOQqSz25GzDCXt
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 10:20:50.0075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a5fad2-02b2-4aec-3855-08dee7dae743
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9791

Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
twice, with the second issue executing only after the first issue's
CMD_SYNC has completed:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must never be doubled.

Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
subsequent changes wiring the workaround into the CMDQ submission path
can share a single predicate.

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper of the original
name that re-issues the same cmdlist a second time when the predicate
fires. Host-internal callers go through the wrapper and get the repeat;
register the new condition with arm_smmu_cmdq_batch_force_sync() too.

The iommufd user-invalidation path (arm_vsmmu_cache_invalidate()) keeps
issuing user commands exactly once by calling the raw
__arm_smmu_cmdq_issue_cmdlist(). The erratum is reported to user space
in a subsequent change so an affected guest doubles its own CFGI/TLBI,
doubling them again on the host would be wrong.

No callers enable the static key yet, so there is no functional change.
A subsequent change will enable the key on affected instances.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  4 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 57 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 85ebfdb3d2a7..032d0c272f3f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -400,8 +400,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
-		ret = arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
-						  cur - last, true);
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, &smmu->cmdq, &last->cmd,
+						    cur - last, true);
 		if (ret) {
 			cur--;
 			goto out;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dd7475c50afc..f0f8b2daf8d5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -18,6 +18,7 @@
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
 #include <linux/iopoll.h>
+#include <linux/jump_label.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
@@ -42,6 +43,14 @@ MODULE_PARM_DESC(disable_msipolling,
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
+/*
+ * Repeat every {CFGI,TLBI};CMD_SYNC command sequence so that the second
+ * issue executes only after the first issue's CMD_SYNC has completed.
+ * Does not apply to ATC_INV. The key is global and is enabled from DT
+ * probe on affected hardware (currently Tegra264 only).
+ */
+static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
+
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -698,10 +707,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
  *   insert their own list of commands then all of the commands from one
  *   CPU will appear before any of the commands from the other CPU.
  */
-int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
-				struct arm_smmu_cmdq *cmdq,
-				struct arm_smmu_cmd *cmds, int n,
-				bool sync)
+int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				  struct arm_smmu_cmdq *cmdq,
+				  struct arm_smmu_cmd *cmds, int n,
+				  bool sync)
 {
 	struct arm_smmu_cmd cmd_sync;
 	u32 prod;
@@ -820,6 +829,38 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
+bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd)
+{
+	u8 opcode;
+
+	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
+		return false;
+
+	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
+	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
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
+	 * A bare CMD_SYNC can be issued with n == 0 (e.g. an empty
+	 * batch_submit()), in which case there is no cmds[0] to inspect
+	 * and nothing to repeat.
+	 */
+	if (!n || ret || !sync)
+		return ret;
+
+	if (arm_smmu_erratum_cmd_needs_repeating(&cmds[0]))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -860,6 +901,14 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/*
+	 * See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key. Batches
+	 * never mix CFGI/TLBI with others, so checking cmds[0] alone is enough.
+	 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES &&
+	    arm_smmu_erratum_cmd_needs_repeating(&cmds->cmds[0]))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..9508bf50d14c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1207,10 +1207,15 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
+int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				  struct arm_smmu_cmdq *cmdq,
+				  struct arm_smmu_cmd *cmds, int n,
+				  bool sync);
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
+bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1

