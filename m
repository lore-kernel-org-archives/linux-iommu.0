Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BAF372EE2
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025756; cv=fail; b=YmKbAWQoBq32EutCuAbWega0M6/CoL1WrNbsfx12NKmrO4S7utjLwEVCBNb4ZcdbXcFmRhMP8/V7Txsu6LpBS/2YuB1V5Z28B6IbQA6zu9JJNItnQ6QoM3Zgzdzk/noICocr1GIQUo7LLXwk0KTqqfjMOPgZBnaO0vvYLG+PwLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025756; c=relaxed/simple;
	bh=nYGniC0gufGsxTy9Gn8NKYP2c1pMCOHBPzsuHJd8NjE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkpTa1TZ8gVE4awcq/qqkE0lr6hBG8jnH3YkRpl6Ku79bg221EVriQMe8nKLcSa/vSg5QveZlW2r1GZ4/PG+gZeRma5JoD960ZuOwfZoxFN820fcupLmUg87kQlwo0JiF8xPEBPkmyXm51dsjdJPIaYqYxCm9BwR4nBW8QbRmoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kOIlxWiA; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kOIlxWiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4FPQHbESXaBEbda2yK2C4hei4e70hXsiybYDjXqf4+VO1suCHHFQnAcknUj49U+1P33/YbvaR6nyW/T1ZMv0H6UYSr5mbRJA/27+ONce+RgX80Xv8pgju8rFTMoKvi4yjHGbu0tjOd1FvEkmfOy/56Ws+tjDQgCc1tOOVrukq2mXgxw+QhNztwfNfedCpP2KSaphdxQUZKq4rboVTidhXhNqHOGqlDWBdTduewfqTLtFGkZm0Tf1y4NAvVEzo4XYXYIcgJB2K9hznZAV8DYDDCioUopeoFY5eqrDiOqgbKlALGH75RK+8WA3nAykJYJGhHBnZZhQ0OcSxUv3BcohQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03usR5QMf81ekoOBtnrxUk18UARaH4GaVizQs42tV0Q=;
 b=fOyzTuEDHaxIVK83GMkmKeVltJl+eMpr016wSRkpjNYYSvz+QJF4KDSW3AObq/ldROpg6fpO/AORKhfcuboSzB0H5NV/esM0iV+scg8zgom1EYWHADv+zjhUD86r3BcB5OjJ6cxuKY4kFkduaFOm4r7q5aoIz0e/DGVpLBR5bjDU/JJARiVrQudWaAYX3utF4cALAdvALxSUcgG1eEekmWAt3fTaiG4R9CQBUWHOmA05b9FUXONjIGuAGZt5duhuCLgErkYAJku2ad/LkXFrbG/bl6dv8nd2HrASwq1frM2US8yeFc2j+gB0NajQvP7b5HU2b1s9/XjHQjh0zGtpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03usR5QMf81ekoOBtnrxUk18UARaH4GaVizQs42tV0Q=;
 b=kOIlxWiAyLN5E5OCyskNyqJAHbkiQ05mBwh1cySb26Y0nBtPWAqqJySfeenfn90FwAQoxVMa089j9/m05Iu24UFiH8KFSmsOj+ZozmOK+wdOEvisQD6pmHZcw+1hktmw5si2gHrTUARsisxB9jlnNRxx+OWV0WfdjCO8PPDGG3trH6kMp2lxLLJgw65aN+A7dxWU/oJL8SolG2vRs3L3wq3hbamalyELwRVzU2YDN2g8DLUxUAlVI+qWy88YU+JX8N+pSRaOtlQzYfhyV8QYC/q3LppKqcMWeE0bqKTqu2O0HoYGyWRLcTCn8VoyfdpkssXLLhTPBWHcQFJubyL/aw==
Received: from PH7P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::15)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 10:42:17 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::85) by PH7P221CA0019.outlook.office365.com
 (2603:10b6:510:32a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 10:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:42:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 03:42:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 03:42:04 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 14 Jul 2026 03:42:04 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v7 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat workaround infrastructure
Date: Tue, 14 Jul 2026 10:42:01 +0000
Message-ID: <20260714104202.1664187-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714104202.1664187-1-amhetre@nvidia.com>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edc7cb6-32f6-4346-c1f7-08dee194930a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|7416014|376014|5023799004|11063799006|56012099006|3023799007|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	CSAPTqHjNm2HU1cYxCI7gPiyRjNhav46zVjztmXZrERNow0KykuKu4IjTTHk166lzTGwR2eoZmExcuMXRvjDSWTa/3/GrkCztcTIJM4c1e4KpR63Pw20yJ9chxE0cjr40MQNI+mgy6gypxDfAa8nRk66f0fi3OAuIgrcF8Ms+gxzYA5OkNlX17w/hgVQwX4b+NEG8A29qwR17A2Zv4Fw66n2YmUa38ZAJt4h5ww78LmYuyoM/Ss8G0L0k56837zzMUi2yMwMCHm/cM3H50N67YYuGDN7Fmv1GJ4yMUInJ+NlGkcdH8wbNQdjUDWd4Z9enjtGI9c7gcdyxzt+NBcQM21+2DhKlMYULjf9/FRcBEGd1O3AIBXqi86cL/25h2stE94+yY5G4GQiOnQ2kLwOmHhqwrHts4m5BItmBu/hxexpMxSIA4EY12PRsE6jm58cjT2uKIpHS55byLb8jIjLCwa+GJlvNkq80mFKMbLMK0Z+RFLc6W5OJeRjlXxwK5N0aJkEX3Kz6WUlkqG0i1dNIq2upEmFRWln0wQ86E8ToosAOTIkdvQikka92HhbvdtmhaiUYMnLqtdm9clKuWoYY8DOj9JKxBwAJC8lYjr5elX0Xf1TfI8NaViTmlQcTMHUjaAUECh1ofh0huVv6K/mL/3G913ARnFK+al1VLa6IFZ3O5nV7ktwag26Xhxer6S+hnn9VWru3pHOtvb4EdAZTQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(7416014)(376014)(5023799004)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dfXwvtz0rb1WpC1yZeh0PvrrMDbkxg7MAsWRg5khpMLa5+/c6/Cf+38ZE3OOlq2f/UhAUp171j/GGM3GdmEsKYSEOT7kh/EPmhRhZkdq4Yf/j6hb8HyGe3N92XI1s8fX/CaKH18MzJkmnj8LNUu7Cl5NFU4zm+DkSEUKVOCg3dO04TVUR+T1ZL6aCjJjva8YClYY8nOk3t8q/GAf0kEt6fF5bvLNJNuSJ3BATzYcX2sXAyQgbOo3xIYX5Iw0ewIB9bcbO7ed9GlKebarvPvroxUBh+Z2JhbBhTNjaNYc1K6T73PdB2ljpRFKmMbCo8YXEqXv+14FOpFQVbW1XeXEb62krV+eVLAoGIdQ5zsmdxpFXjthuxT8/W4wZT8EMJ/4nZMcA3uckpPhwAwEXzjnoX9EaCC4N6srUfEsK4HaIx6YoZe5XJnu7PippVnNDdH3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:42:17.0274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edc7cb6-32f6-4346-c1f7-08dee194930a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196

Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
twice, with the second issue executing only after the first issue's
CMD_SYNC has completed:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must never be doubled.

Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
subsequent changes wiring the workaround into the CMDQ submission and
iommufd batching paths can share a single predicate.

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
the same cmdlist a second time when the predicate fires. Register the
new condition with arm_smmu_cmdq_batch_force_sync() and add
arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
repeating" transition.

No callers enable the static key yet, so there is no functional change.
A subsequent change will enable the key on affected instances.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 14 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 57 +++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  1 +
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..143f0d015aeb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,6 +350,17 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
+static bool arm_vsmmu_can_batch_cmd(struct arm_vsmmu_invalidation_cmd *last,
+				    struct arm_vsmmu_invalidation_cmd *next)
+{
+	struct arm_smmu_cmd next_cmd = {
+		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
+	};
+
+	return arm_smmu_erratum_cmd_needs_repeating(&last->cmd) ==
+	       arm_smmu_erratum_cmd_needs_repeating(&next_cmd);
+}
+
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
@@ -382,7 +393,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
 		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
+		    arm_vsmmu_can_batch_cmd(last, cur))
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dd7475c50afc..9c49e6412053 100644
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
+static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+					 struct arm_smmu_cmdq *cmdq,
+					 struct arm_smmu_cmd *cmds, int n,
+					 bool sync)
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
index c909c9a88538..e175dedf7c77 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1211,6 +1211,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
+bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1

