Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EBF358381
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131943; cv=fail; b=EH+PwgzS+8FaV5XM52Fmj6VcQx/p5ZX9P/3Yg/gwXZFzGQfzCfGFZPy/qEzXHhFySv+50m3Nc2s3wB8IsKlI14L5CKV7T4wTERqiVF8hSyHBoIfBEH5zbiwoqIEeogVt/u2be4b+bvxN1krPMfh7LR0CjVL+klLshFCGvZiLJ1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131943; c=relaxed/simple;
	bh=E+yEJx1I10kPZcPBrP40FlJfpsTPJBZqRmCSoQHw7k0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeAnofTnczTGWMrGDcD3OtJk6PZ7BKCv2s3KzZOUWo/stNbuf+C7eFtTbFiGvZfYCeXn1px4WpKQyd2xzorhKxQJApUG8x2T6gOinFHYPMM0KEbKI6gc0/l3/pp2xGSNmXuxooj1oq1WvWucZOt0vpCgvSIj7tHxPJsdlPRn7uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dshv9wCN; arc=fail smtp.client-ip=52.101.52.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dshv9wCN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7CRRdYeEyStW27UcRKqYeqfCRD2tBoOeq0+OVpOcTSVdZtsoAiTTJjiHcJLq22jyRg3cuGUx+mi2qMkrEGbp7s4CSApquh4IYya90vMYTKySML5Uy/GmMgFYzMo/eewI5I7oSViqVcccqtr17U5LNzIrekmJmJK7BIUzFpSBjFzv/zDzrkO/5a0367w8pQ3RGyoqebEd1wjSvy5awqFuhjCorZzlNFb5lb7Hm5wALdrazMxws0ZJ1TR/u64bSbYJrTrWu6/vH1riiJmfc+yZmSVJyDkp6Nwvd6X0N/Mf6q72n7O88RD0DGOM2PoMlicOw9u80LOJz3g9jZVW8Lm6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABl6m4aNwYTcwXdK5WM+NbfWoENJjyjVcoKJvEL4ZIM=;
 b=YwXSlKBHpbug7fkuNps4AQmrlpMY5mC0LGcJhFxWLzLoHxZhoIo8DaDCQqyM7gpcgmnhY9rtbZjU42JHbC4pIzTj8xXeEWDPi+oXJfWClMMHxz1fLdx3FePnOo7w3o96e0W9Mx19uCyKwzf1jQnuGGVNkSUctJ3ycVNT2vHHXDQoC80iqjPIlPtS6On4r1dpZxcUTMjnxRIhMoQhZH/8q13deyKp5SnQfO40gv31Nai0RlAtFz13KUF2mEQ7PCcEeqmJ7kbpk+x7yO/V9QJaNBZMbogwLM2Be0/6AK5gYcCE1T/V/fT9GHoM4m9ENtuwiPTRpJMreAgL+KmCgIFU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABl6m4aNwYTcwXdK5WM+NbfWoENJjyjVcoKJvEL4ZIM=;
 b=Dshv9wCNCr1g2WXzkZgYReGqNFrdy00ciRBap9mqzahEWh5m5ZDbezS20wDYVQMBs+Ty5hpn7MUmenAY9dIM+774WhyOcLzyJHVGesnwnzm62cJdBzthWbmT7q4mn66Gt0SZSPN4XNBhV3H5BIbwHFDrxHhPeLE2osF8BxXW+pKaG8sZW0D4ydBKkcLz6DsytFgQ2kbw/QAP6xQoZDVPz+8oHQFssV6ilaRlT3ezJ0AyiJOS+2+ux5I3M68vR/NvF5dKioSpEtj15czoLtAK2cGBa8lYgRU4zAiE//+/HFkrT2dYPH5+aKHiL1sHffKCrWWK0y4hKs4M1jaObenjHw==
Received: from DS7P220CA0093.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::17) by
 IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:49 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::41) by DS7P220CA0093.outlook.office365.com
 (2603:10b6:8:25a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 10/13] iommu/arm-smmu-v3-kdump: Implement is_attach_deferred()
Date: Sun, 30 Aug 2026 16:18:11 -0700
Message-ID: <095405a6db88c23b781bcd6c0478c207d216a8f4.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 23320edc-cc1b-451b-d59b-08df06ed0c4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|11063799006|10067099003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4vfSiYizLLsqtQ+Nuuw3GK7S5HW0TltPMISA1MFhjRvgSQz7AW9oJd/wkx6yF7fABPVePcOgpqTupNi09NSsSD9hf0gpnD+XXvAGC8ZZA4FSOfSD+6XWa6ScuIkkSABQ8zo4awAT8v79075GBqN7L0WYQGIM3zw9v7ZpFA+03CawS6XNZXJokBCzGfLGzQNbpi/N3/k3vxGu+fu6evzOplTJ1uajgHlSQadzVo28mV/gH9A8th5xa8hs7uGNqK/f/rc4bpKeNwLmcim6izHyBZHx8K7uIBEWbsTNrDoEzQtx20CMV6mAIiHsTz5SFOi1Bj42R8Iut0Vo6D0/+jK91NJJkq0PqCOCmOu7JuYJnmvV7ZBGBEwlKTmCN13hSXyf1rsZTx3EGjsK8bWkJTTOuY3qEcOMV1fZJzP+i0LTlJC4V8l/b7nreon35Tdyr/5+pTIyLYX8DukPNgmH+TRVGG4rCvjXPO1Cb894SGVuNY2/sZvTCmDdi2OaFMPfxVG5nF2ROqIa5OdLnsUwIizCQRhrCG621XirdmMgpUfd+IbfSqm8PGhvWBzi/VzcAwTzKaeLE2SqPKVhpgNvLYPrTAkzyfTQqhwWxDU71YYokfSaVJRJ/0lS3rF4tFDt1WJbyY/t6yus+MMD/cQ1W8X96JYEneBs2sHU0783AOe4xl9vv6FqJ8utF1lOXrINGdLPgPuo7qw18LWXAFcEx9gJRw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fp+COb34cCzyGjKcTSqFf1xsj01ynrUNIgqPJIqjlN4DQtCmkuzrAUaiDsF1eXASwfoD0eg4ljfEELbw+jwa0swykLfplmiGg+V5HfZwMkplq07IqKs1cNoH+YvUxTKQOqxP8XiLdH4mtN9EcnCbjv3FPlMNq3PQV6oJeTDZAGOM8ACdCyhXGC40szXLGptvArA6yu0d7cckFxav0GrVEI3PHG9tEiYpP30Sg6n6olr9/MT3OvLyZtlkX7jI/7bebRw8meujs89Ev3KrUivSFsXoEztHSyZq2KfmnZOLYazRvHV+Q2Q37I51jNK+sBvOiS3pEyKfybG/Sa0ib4CiDyihf/+jfw/e8JfAWfWPHpd2QTJBcQ9k2dO32Y8bB0EONtD4vse2hHNvgw8Cls95Nc0YD9JvVwcI7rMkUv7YexWNMthITMN7Bi55nIR4SJ2/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:49.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23320edc-cc1b-451b-d59b-08df06ed0c4c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Also, move arm_smmu_get_step_for_sid() to the header for the kdump function
to use.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 19 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++-----------
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 64927c54f8b6b..3f2ebdb99e8f7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1219,6 +1219,22 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				  struct arm_smmu_cmdq *cmdq,
 				  struct arm_smmu_cmd *cmds, int n,
 				  bool sync);
+
+static inline struct arm_smmu_ste *
+arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
+{
+	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+
+	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
+		/* Two-level walk */
+		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
+				->stes[arm_smmu_strtab_l2_idx(sid)];
+	} else {
+		/* Simple linear lookup */
+		return &cfg->linear.table[sid];
+	}
+}
+
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
@@ -1273,6 +1289,7 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1286,6 +1303,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
 {
 	return -EOPNOTSUPP;
 }
+
+static inline bool
+arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	return false;
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index 6740cc7e671cb..5bc938901b65d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -237,3 +237,22 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 	smmu->options &= ~ARM_SMMU_OPT_KDUMP_ADOPT;
 	return ret;
 }
+
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
+{
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_ste *ste =
+			arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
+		u64 ent0 = le64_to_cpu(ste->data[0]);
+
+		/* Defer only when there might be in-flight DMAs */
+		if ((ent0 & STRTAB_STE_0_V) &&
+		    FIELD_GET(STRTAB_STE_0_CFG, ent0) != STRTAB_STE_0_CFG_ABORT)
+			return true;
+	}
+
+	return false;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1d4fb6c4f0a91..ef1ef4d452949 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2965,21 +2965,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
-static struct arm_smmu_ste *
-arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
-{
-	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
-
-	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
-		/* Two-level walk */
-		return &cfg->l2.l2ptrs[arm_smmu_strtab_l1_idx(sid)]
-				->stes[arm_smmu_strtab_l2_idx(sid)];
-	} else {
-		/* Simple linear lookup */
-		return &cfg->linear.table[sid];
-	}
-}
-
 void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
 				  const struct arm_smmu_ste *target)
 {
@@ -4390,6 +4375,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
 	return 0;
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (master->smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return arm_smmu_kdump_is_attach_deferred(master);
+	return false;
+}
+
 static const struct iommu_ops arm_smmu_ops = {
 	.identity_domain	= &arm_smmu_identity_domain,
 	.blocked_domain		= &arm_smmu_blocked_domain,
@@ -4398,6 +4392,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

