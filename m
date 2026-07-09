Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5859405862
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591006; cv=fail; b=QBhwm1nYN3JptUYEYtNcv1eHQZYSFuFnGoPzs1uDDetK3cFVtTHNDCfOKtB1HnlmSb1ktxGNVP7kLXLbkPXARHm8Go0S4d554L9njH4GcpCT2rL77SxZCWhkj8QGNvz4J0KK9MgSMAaf67TBXS3Ar5ySAyGzHYSAVpa4V2MoSO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591006; c=relaxed/simple;
	bh=XORG1Ahi+/+S8NrrT4sZPy4kOT1pYfqk2tQaa7S58xo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bb8hcN20gBvc/E0hMSIjWjePHh/bzzFNoJ9cPI8qpaVwEOqMB2T9mFR3fQTb8bRYSGBCfnXAoSJgMRew0RdZLSnYKo0F4KziMFHVV2DxmJvPi/j0wiyRLS3ktildYhd0PHS4hq9fhdgK3kRAY4H10lzzPELlnT1d3z9LeRkOnh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SznpWFRt; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SznpWFRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyouX8SHf6CDp3TO+L1XcWVUJY6pbMJRVRH0mEThxtMoKqz/Cu4EU3ztCkfdmBS6rHtzGj0n5pUJeeYMe8EM//oAYbmkxnDNGL6zhkrxD2/qFPgteP8ydVzmGVoGGGtCDd7gUZGh/p8+11zP5WSpLtLEEmpAK/IdaHc5AoBPSnzJiWBzesA1GUIXaNHgGOQG0ZSgJOiqHNyaFQiaG3aNey5vWv9By7rcu2Biv301KL83QUAkXhSNQqF+i0uqgpAnTtLcZ3qXr4nGaLah1SAvIasCTKHZsRrcPkOOsRc8Hs2etgV219JElJpTLkzESvvTwOcCcvE5Mg8/ptzdgHFigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxNl/YpjQzE28XRe1VJFiceLK+5qz97YUCg8myzkJQk=;
 b=SyDgsvZKJarChYnc+PXt4mFF6Yc4iOHuDSd6FqzBIntbv0cQJpHrrzfMcN4m3rF7xsJUlIKCCaQaNRpvRD+B9jyr2+LINVxVe0saI4HuvUEHECd50GH+UKjsdfeIlYKmJdWVer5T/GOmupGToIdCaE5FbbjHwpQ3Z81A8bfCsj0kpzK71GKvnaG6le52g0/m4H5VIKwrL62MIcSUFuy5gzUE/FFOt653D/D9W9d+FC1d02IlreszZXvsMH4go4hx+z/7w5FTGn0s061rUZkAe+PugjIzg5IU8VLkZ0fETsnOKe0MIMjXEuWfVcqevDB7uuvduA2twfMmhd5tGHQRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VxNl/YpjQzE28XRe1VJFiceLK+5qz97YUCg8myzkJQk=;
 b=SznpWFRt23uA3Ad3qRIIvqBvxnrdcAzmI1tUnazNvgoPq5m1ACSPhL9LTbbQ6OX0P3BMhWUXPv5Cajw7LrPsFIosP6Hore+183AcO/VnSLeYn3U76OJuwBlF39n32+7l5TtCSSt+dJKcDUWr0iru/RRgDVgLdo441p+JsbCeG3NXyv/ZzIXIeGQVHC2wUvyEjzPDe3n5FXEkkN3Gl0UpiAwLzrT9iMKwO4Xf/fbIa0PA0ZKiMuiofuBzbVNFaWcLjzxMu1aeAYnyqS/abuM6RCCD2n3+sbnVZ8IvOl70r0rZCTRZDgzfbZCQwBbgApNManMIj2arc9doLaF9Oau+3g==
Received: from SJ0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:a03:2c0::17)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 09:56:39 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::3a) by SJ0PR13CA0012.outlook.office365.com
 (2603:10b6:a03:2c0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Thu, 9
 Jul 2026 09:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:56:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 02:56:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 02:56:18 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 9 Jul 2026 02:56:18 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>
CC: <linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>,
	"Nicolin Chen" <nicolinc@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat workaround infrastructure
Date: Thu, 9 Jul 2026 09:56:08 +0000
Message-ID: <20260709095613.831769-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260709095613.831769-1-amhetre@nvidia.com>
References: <20260709095613.831769-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdddcc6-408c-42ea-9661-08dedda05ecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|11063799006|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EoLFlOt3YYC/ZwUm43QqD3tSFSKhFuJ/UKYK69Z2QU4hHOXBuwaeYAvSq/928OuOwFpwmgFLpdNkB8A7dIaEjN8LZTREh5kz+BMafZyAPrF8BaB3EhuCCVhbmN6+YpqEBANrQqO1t9EZ5jszquWj3PA1g4C+Pvp1uN+af7zBh5u7Zp9ctaeTh+Y7i3L25fAcguayALkiVqFmtWOymiTsae095+yOjHHmSa7p0qGzKhnzaQ6OeJ5t4yXQAOPTtvzulrRxld78vKLB6UwCjEGkw7LpzX175J/SbACQECULLa4GWSwrDl9d/NaPhSBc/G7yH7196PqHpTZJPmp3oN9wQ4XuOCHnx0kWo4Z9VnyspODA4fq1uN5yMEhCSDSxq2wEn/JQBtUpl24WtQKugrSd7jKuAeuOM2VaJzWz/L7LLU6hXBeHk34kFAuvpt0kIjJsTcfmOBpyR4Vo1IXHHFi4GHaRQfBhCM3XvZhqwyC3xV9ofQ9YTw82exRekFQL+LG2Ky8NYJooqxiwk4yAegDNLBOKCWxmQyRPlv8r/HjoGTh7Pyv+RgnIQuYEiT04FZaHo2rg3N1ap8aeq1qx5QK1JEPh+7yuiKU6OEFgIU1TV4ssjCBUZuDwEO1RbrMUDpqoB5nqVv9NQj6hDnk+3Pp3LOrrJTAb2RzwEyHsvkAPJDYd+Tslic2d79BjplTfEs5akw3ZpCSOAXn0vvJ0ySY88g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M+e54/PiZYuWEZY+dXzqHAdCQgKcstdgGIbc9DIuX8gB1CapU6Oh+ycJ890ioAqem/ceWNvav2KPmziyQDg93BNaTIGyCCFMllBVVOhTe/cWEpv8wsTzv7iVDsjuH+0wlJz6tZG/m8vpoxJVU3JIU5p+0jcU+HX8Gj0lVaa7tmi2H5THGUHYv3kpak35eRZW0SKs/nbxV3Pn8GvzznBEi8MVbwL5M5uJO+pHxhrTDtxiG6DV4gHgoDllX2yNq34kp5mGSS2xkcN7Epr3Boph4qiyWYRCMu5lP2lL/c+L9op2kis9qE5WXEE19tDOds8eYzC0ED44SymvNgOciOCOFCWLCdod4sAGmySc7GUP4aeWhJAXdiEMWiwgSnppMKQQBiHSNZ3B5ZeppeF8Ds7LKuKV0KudZHYjeC26m15X076XCe1FkldLy/bKyTc/1emj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:56:38.7468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdddcc6-408c-42ea-9661-08dedda05ecd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292

Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
twice, with the second issue executing only after the first issue's
CMD_SYNC has completed:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must never be doubled.

Add arm_smmu_erratum_repeat_tlbi_cfgi_key static key and an
arm_smmu_erratum_cmd_needs_repeating() helper in arm-smmu-v3.h that
gates on the static key first and then range-checks the opcode
(CFGI_STE .. ATC_INV), so subsequent changes wiring the workaround
into the CMDQ submission and iommufd batching paths can share a
single predicate.

Rename the existing arm_smmu_cmdq_issue_cmdlist() to
__arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
the same cmdlist a second time when the predicate fires. Register the
new condition with arm_smmu_cmdq_batch_force_sync() and add
arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
repeating" transition.

No callers enable the static key yet, so this patch introduces no
functional change. A subsequent change hooks the DT probe to enable
the key on affected instances.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 36 ++++++++++++++++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 15 ++++++++
 3 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de344..11d22acae613 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,6 +350,18 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
+static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
+				    struct arm_vsmmu_invalidation_cmd *last,
+				    struct arm_vsmmu_invalidation_cmd *next)
+{
+	struct arm_smmu_cmd next_cmd = {
+		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
+	};
+
+	return arm_smmu_erratum_cmd_needs_repeating(smmu, &last->cmd) ==
+	       arm_smmu_erratum_cmd_needs_repeating(smmu, &next_cmd);
+}
+
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
@@ -382,7 +394,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
 		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
+		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 76efe479e80f..15b9d0170520 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -41,6 +41,7 @@ MODULE_PARM_DESC(disable_msipolling,
 
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
+DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
 
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
@@ -698,10 +699,10 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq,
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
@@ -820,6 +821,28 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
+	 * arm_smmu_cmdq_batch_add_cmd_p() can flush its current batch
+	 * with sync=true and n=0 (bare SYNC) when the next command is
+	 * not supported by the batch's pre-selected cmdq, so the
+	 * repeat path must not inspect cmds[0].
+	 */
+	if (!n || ret || !sync)
+		return ret;
+
+	if (arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds[0]))
+		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
+
+	return ret;
+}
+
 static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
 				     struct arm_smmu_cmd *cmd, bool sync)
 {
@@ -860,6 +883,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
 	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
 		return true;
 
+	/* See arm_smmu_erratum_cmd_needs_repeating() */
+	if (cmds->num == CMDQ_BATCH_ENTRIES &&
+	    arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds->cmds[0]))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..31121d7c7841 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
+#include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
@@ -1211,6 +1212,20 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
+DECLARE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
+
+static inline bool
+arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_device *smmu,
+				     struct arm_smmu_cmd *cmd)
+{
+	u8 opcode;
+
+	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
+		return false;
+
+	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
+	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
+}
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.50.1

