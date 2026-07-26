Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0CB31986C
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 08:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053958; cv=fail; b=fzeWjUCecNkJX8evDv9zF7Zepr9foVw1Eiz8uJUr/W2+Kn/AT+vQMCox4D2TmNFYwDjmTrJ2FWyq53kpJ0QxEBeKoeMNwtneWseiNDKGXDbII7q0OUExfwSaU6YPhDHEgeQjNZnJMzpV3X8bB2CvMYd1Mx8NsdXZscE/bR9ubK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053958; c=relaxed/simple;
	bh=//FC5HbGhPuqB530eBxaKZsz7iFfK3NifsvhFWUNWjI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y383WSSaPmbdjPiflLP7UazL4M8O/QlDR0NWcyUqoIY7ew61ecDVwug8mF7oG/FVg7O/rk+PRHJwWaSl0e4SwzeDM+hOLGqrjKqw+njS78LzkCUoBahAKwATnLqIZ5n9T8bagrYej7vlzgi11bgf+4uugNgCF0g+7Sd6zhtGxsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FgpIpUp5; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FgpIpUp5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyqG8Y26HxgMaDw36vSJOi6WFXYPG/wUz1/lcMaOUl8qoVAO4hRbZ5TgJ7kPbEggJQCvneVHMLRm9G47OKxIrlTwxV2BtK7NACgHojhwaQz2u9hAKSYN9kOj2rPt59DfUsvjM9XVdhtiQcBJeJIo6Nc38DL6HYH82ux9HEkF18061YpcrL6XQmFf0dueOl7jd4BkLLR12jZoLXVXHKLWsOdIwO8s26S9A0qkkRTqVUM5gd1lhm278ycE1u13/9k/ZV3NWNHBuNXqURawt+xjrxCL5TXfPKWJrbscWihOSvd16flkzAZPVMzTKv90O3n44y0EhbYWNEtMVjFRbJC2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NekZw9ioXsD7v4Lg5wllIP6+7++FdhAikO4iFDFEyO8=;
 b=wSHHJrvuoCapc1i9O9aX353DykHe6b0wTuuPzHTwPd1gQz670ikexmuV02ge1EP0zcECgkU07uNXY/49ZLxvckMeJvpuXDkmRKw12JzkIm+vcTAw0Tc8kb6AIE8TycgLjalQ2+1L99R6QY67jRpxHDj2BKeRdYGalWo4PkSeY7Ij7PoFoIN6bDWjAh7rmMdLm0Qx0810JZ1/xlHEmarsxX8CXADhf+rWei9G120X2n6w32OHD6WqOKiyvAAQ6KKw+IUlEySJ52kot3Zf5m9qm8tizgl7/h7sxZ/DnVUkzVtuX7X/ozr4Dq12D1/y0zDXI7jOPapgJ+rkAajG9U5rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NekZw9ioXsD7v4Lg5wllIP6+7++FdhAikO4iFDFEyO8=;
 b=FgpIpUp51hL3WBzSLhU8uWJ9gw5QqR3Pit6XoOjRqdVU62LMFtFmrgyy7SvToJ2B3I/bCmUkUlcucOnZhXDUVglA+gwcYkPETLTIAWyKeI4GqCsrrvNLSQAPo9MNZayw685KAYQhoHh14x745Vh5gM6iDrB7L31ojiCgZAQb+Iua5lHqmrgOkMwEo68LrS9a9E1SyvfFYqtVa5FguutjY75TKR9fUcIxDlZS+ngxOaKYfGrSYV0oGfr7Y1m/eUo0umkfusgSMKmwyo9LxysMruzPwqVP/cpSpWYXAbhBgRb3GoZ09FTSN4R8THoaw3Fssw5P+5CPgxNRST1XF+GBfQ==
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sun, 26 Jul
 2026 08:19:11 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::64) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Sun,
 26 Jul 2026 08:19:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Sun, 26 Jul 2026 08:19:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 26 Jul
 2026 01:19:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 01:19:07 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 26 Jul 2026 01:19:07 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v9 2/4] iommu/arm-smmu-v3: Add CFGI/TLBI-repeat workaround
Date: Sun, 26 Jul 2026 08:19:02 +0000
Message-ID: <20260726081904.1408859-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726081904.1408859-1-amhetre@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 490ee32f-e449-42ab-1fe3-08deeaee9262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|5023799004|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RvatwHdg4whbSlAUPiWnTbOGm9+pSk7uZIalusXqO+hgX5vyNa1NZF+pLdNY/Z6qfN3yIMgWgEOaiC3dKheWiPqgsEvnQtCXqxl8gb+ISPKp1dU9k9kochvkgIDn8qU8zPeBGQT5IyHdIqMFhp/wGUAojevnTx2yT/8tiFN1zG+l+G/8XLa0fvtTFCDWh9SvvzXQzCMUDMbg4Ap0QtJjZuBuwFzBSHs2Pilt0px7dVCLJdqkcfm4H6uSJaCK0OXce6uPrVqjcFx5kN04/6Jr7PKlmUTJlSsUQ6Cz3pmalOPil9Gm9CNcoxwkKLtpEf65Dbp2+QWqRBzMZEWmPW5mO7u+8xfTzjb+oCic6HSS4I7ZvgupglxTtFzoMYst6WX79LBN14ZsQ3mfweLuVE2qOXknqnSSGWZCKNRQabkpe2iV3jDsPZuG5Z3g/65lyYJioGOiJFJooZKcBKImYv/U+eILh4FME9tPVNHLyTEHSRMAzQBJ6OD/xYvij2NsARz4y29adW8wSGwArdpIi42Y0cTDLwJAKPJENP++rn8twPiD4XedQ5uh9NLlNUHI1KLBBvmSL4qk6UMVJbPCyGmebSJzDmSLAdP1wwvBnuV7DDRH4N3Q0aReWPodnopnj1+O9ziRno1DOzK838zu2Rf+15y7c6oMUT09R/l87luUocQT7nMS+bygLwaNFlmN3Xmnw7slT5JY8x45GR15o4U8SQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(5023799004)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W5l2zl9OYIRZLO86A9lXaO2mh54OVKI9fteNJ2KuX5gNK20B8Eok+U0cVfOsZsWsrBqgNMAUq+GMdXsQ2/RUA+tVHicOFxBC322U84GZviNRNh3PHv0nMxu5vJC4TjXUdvOmbSfNA/MJiy6Dx3j8uQ6W+aO4NRH36IfZDjS59wW0gMYkwmjr0QMTYxPmN3v1wjaEJvb0yoVfFYRCZYTEy1imbtm8Y8JQ9SYo4WRfnK159OT3ZhxRJAlrs6oMZsiM/HioZVXkdwLh0H6foTDht+X0Pd8PX1OIxRn2XSEDIl85U3+AwO3qjtEbmjVzvGdWK5px/rbpluJjcnI/RQLheS8WZUfFQH/oE9lG7QGuBnuUb8a9X/cIPiByshd04pzTvusGKeP1Vvj4IXY3rIlg3a1gf3em+x/U03ddzBgOxjQrBzCn4aIUQas2bUtpVaJU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:19:11.1875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 490ee32f-e449-42ab-1fe3-08deeaee9262
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
twice, with the second issue executing only after the first issue's
CMD_SYNC has completed:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must never be doubled.

Add arm_smmu_erratum_repeat_tlbi_cfgi_key and a file-local
arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
key first and then range-checks the opcode (CFGI_STE .. ATC_INV).

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper of the original
name that re-issues the same cmdlist a second time when the predicate
fires. Register the new condition with
arm_smmu_cmdq_batch_force_sync() too.

No callers enable the static key yet, so there is no functional change.
A subsequent change will enable the key on affected instances.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f278c962a7a9..e2f1faaa0d6f 100644
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
 
+static bool arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_cmd *cmd)
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
index 1c4877ada1ee..3030f07a7c85 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1208,6 +1208,10 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target);
 
+int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
+				  struct arm_smmu_cmdq *cmdq,
+				  struct arm_smmu_cmd *cmds, int n,
+				  bool sync);
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
-- 
2.50.1

