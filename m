Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54423DC84C
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990353; cv=fail; b=gzKtrcPv826FYNy1zCNk2kd/jaCLiosINr85yoaz1a/KFNtEAnlx/R17FClVbfIrohgE/mFC9CqnG+rWkNMSUtnomf8HbluY+hZ4WCsJO/tt6DnKN5vsx3hBrM7AY++cx8/EKKbgoe1tosKGlgKgyGYmthONLlem9h7MdNScEgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990353; c=relaxed/simple;
	bh=2Vm/ml7bd1QW/nP8sYXRG6TbXY0yArCHnk/Ka1gaJ9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QPnMZVoMBN/4YegOLxMMpDG24p+i7EwICpnQmXp/7lO1XEmTQWdnXdsbVSvHkpTdUYpPY9QMqaEvpj+UNUKkw3rRL4FmLIxpkbXc4s6mB1HefCe5fDAl8b2ZDyvYsMLF/tD3xW8XTz32CUqMlnA0ii/cgY1ScfttJiDiFC0nNkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tZxXRCvx; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tZxXRCvx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIfs3wenOKaF8jUGJ9+KWQw07FIwkJQxiThES9gCo1aHnrYrD3uRSybpj/CSyRT1mDWZkvsWQM2rGRx+L3fvGSH/STiu/imxqvD8pDoyjQFBozp7DtUiZ1pp23Ysv33FcJXKfEPYvPj3WTJHubtBh8vne7rhiPyLe61E8QLCiTsTvwxnILvrn5Oo45rLUY08qJavXfMqpIud+3Kupws4YyWFKYs64ITlW2qd833mG8yJLs2g9mw2P9YL3kmSfJkAFvvndgTRt54r3aozLR2eSI5eqJfv46+CGgXqYhJi1TMuq+n1YwGvBuuHaTzHcKdm2+Xi3dZoW1gEDwedWFv0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19+vKjac78PiQVFTITr8mXZO4eaZtGjK32u1Hpqwbf0=;
 b=Po1tZSNQRjLskVNBFLbrdVG7lJd4RVSgnPfMOGOSCQjzOuahTTHycGnUvaNyRNm08iFQ0sunBnaHymCMPEeMV3taHEJn2EYO8LMKU+cQ0VkkADQgO2gzcsxGCTnY1ewIDmix/mXN4SzmST6pgok83/wC+JNTv9/OVm7ChZucmQr0z/VUb+NP6jWPRZcBLPc/TZHVBtySN6k97IaoJzrs3viyLv5srKWMyLWvnxN28QNvpRzaKtR4lLmo6EurbUMSbZgaBLvLVmzcXMpR89a3WLzXxs0XfoxptRkX12kN2tizomiicJrv8VuXyWymdO6V3rpLtFWzQCX1Tz08ImP4Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19+vKjac78PiQVFTITr8mXZO4eaZtGjK32u1Hpqwbf0=;
 b=tZxXRCvxA0WxofF43Qy/bJxWo/9XaCLDnxvGCH6+sSqmBdTTw3KQNEIQmRAPm9PpzBVTbmhE+2P3EcqGV07gsJGEwXeoePt/FMaQ/t+Cuh15Cu8ke7KNNNLaXkYxGo5vZ948ToYNQ3J5cMY/oI1yRC0zsYmGSHA39txAxiJOj1VgpWG3fEbQq90X4YYreLKc5Z9PC6JCefPacX/pSEcmI1OO5VUP9d2XJVS3dP3yBiIVINHBRJKQmrsnBw9WW4mv2oseDb4V+3rdEqy3SaVV0kdM5SnH/i4mj4cAERH+IL9mz6xeP/UhYo9MmF194LQ3lmMwbAJJMgRUycW1EMN7+w==
Received: from MW4PR03CA0350.namprd03.prod.outlook.com (2603:10b6:303:dc::25)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 07:32:25 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:dc:cafe::a2) by MW4PR03CA0350.outlook.office365.com
 (2603:10b6:303:dc::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:32:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 00:32:08 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 9 Jun 2026 00:32:08 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v4 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Date: Tue, 9 Jun 2026 07:32:03 +0000
Message-ID: <20260609073204.1760077-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260609073204.1760077-1-amhetre@nvidia.com>
References: <20260609073204.1760077-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 93fa9eed-09dd-49d8-9ddd-08dec5f940ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|6133799003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	fe2RQpATzvRKuIfKw4zYjZHoKrv9U3hjZX69TT7Rm2m5hCsy3Sxn1Lq0OEEn1K3qZ/5foTZVBfoB5eZ+DJtdMjSV/JBIq79TA4VfnnrMGGur8V5VUmzKxc7Nk0wjlHoqq05Tva3ljxnIgZvoWjBhQyuJDgWzv3mRUvviNtF9T5fKTIAUbaRTECAXLq0+SUC6Lr4H2pC6YDbRHcpw6APkIUtt9ZiGJEQuqxLLXF49pqOXTzgc2vDooUsPBcBJebJzeOncNuCyQzLLgf3aLQi2qHyB3LVIiCIx2kiZV5SLOUtgvFC4E0KyS6BVJgQdw7FgoCKhjTqnE82aGGvMtwJJbtVfkNOnQPxTJjxr1BVwW3Bbz0fSE5SCyot73GLHARlr6uJMFPxt3bxDo2L5HdmADNFdMY0o9GY/AUyXGjaNxwmyHk+62si840yyCMa++abW8fzbi+6FeNUu/N8+NOqPjHl4vR4VezbLCPGSbL6RIVBzZsgSdt4Z30cDqJUMuht9FVMZOL1MM1NlDTjPLouZGZoAg7UBikWD3GEB4MGwDyGl6bvOf7XEhLqxd228n5V6NqlJtkqEeq/zLFbsiu05Drc1pdlThbEl9gV+VXYtapQi7r7lixsHbxO5doiZ+a8OFqR7luia3uUC+PQJgK9a2mAMsb3lktzm3zW8uuk7bWJiDQ4W7ZxrfEF2D+9I8esiy8THkjgpko8znBon/72bX+pXNGXl46wJSP7LKiK+sPs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	T5ZH+cSho6hqwHcHAGw9TUGyEsXs73J+XnQb9iPj/J8145pi+fbUoigcQDxnO/AwPNwjQGe/waOXv095R2gHTZ6Eh3mHAqgTPmrPnVqAFRtjgSYKk6IQ/G5Gnl1aC12vFgFMx3fGKjO/HF8fF4wKG9ubNhGl4z3+Sj0ukEcws5cjDJrbWNFaojwH2oyBIfkkWR0znGxre9k8XD5aZ62EUqH+PpsNnJsKxDppXyUlajbKpU9qnhmb42Fxwj3F6sWDRclr5xu0qqY+3S+37vHTXfErLfIHk2mgO6JOW4B2WBK9h6pSdg6FePt4bAb5TJpXC65IQdX5DGUS9P02lRuyzv8rtKca2JMNzV7w1nlIsW1Hpio5nADvbQNe46Wetma7sJD+RUL6L3sycvRZa84acB1utWuLrv4ie5DSwbUh3LJwcGmayF/buf3PPQ4eG9Wu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:32:25.4992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93fa9eed-09dd-49d8-9ddd-08dec5f940ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896

Tegra264 SMMU is affected by an erratum where a TLB entry can survive
an invalidation that races with concurrent traffic targeting the same
entry. The hardware-recommended software workaround is to issue every
CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
is guaranteed to evict the entry. ATC_INV is not affected and must
not be doubled.

The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
cannot be detected from hardware registers. Tegra264 boots from device
tree only and has no ACPI/IORT support, so detection is through device
tree only.

Add the ARM_SMMU_OPT_REPEAT_TLBI_CFGI option and set it on instances
matching the existing "nvidia,tegra264-smmu" compatible. Also add a
matching arm_smmu_erratum_repeat_tlbi_cfgi_key static key that DT
probe enables, so the inline classifier compiles down to a single
test+branch on unaffected kernels. Add an
arm_smmu_erratum_cmd_needs_repeating() helper in arm-smmu-v3.h that
gates on the static key first and then range-checks the opcode
(CFGI_STE .. ATC_INV), so subsequent changes wiring the workaround
into the CMDQ submission and iommufd batching paths can share a
single predicate.

No callers consume the option yet. A subsequent change wires the
workaround into the CMDQ issue paths.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  7 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 24 +++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 76efe479e80f..599c835c50d8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -42,6 +42,8 @@ MODULE_PARM_DESC(disable_msipolling,
 static const struct iommu_ops arm_smmu_ops;
 static struct iommu_dirty_ops arm_smmu_dirty_ops;
 
+DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
+
 enum arm_smmu_msi_index {
 	EVTQ_MSI_INDEX,
 	GERROR_MSI_INDEX,
@@ -5303,8 +5305,11 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		smmu->options |= ARM_SMMU_OPT_REPEAT_TLBI_CFGI;
+		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c909c9a88538..c6ea3b8dc761 100644
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
@@ -928,6 +929,12 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+/*
+ * Repeat every {CFGI,TLBI};CMD_SYNC command sequence so that the second
+ * issue executes only after the first issue's CMD_SYNC has completed.
+ * Does not apply to ATC_INV.
+ */
+#define ARM_SMMU_OPT_REPEAT_TLBI_CFGI	(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1212,6 +1219,23 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
+	if (!(smmu->options & ARM_SMMU_OPT_REPEAT_TLBI_CFGI))
+		return false;
+
+	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
+	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.50.1

