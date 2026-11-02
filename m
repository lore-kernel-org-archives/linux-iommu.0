Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.193.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793596816;
	b=Tu2VUOitYC84MzhjGlC/bZB7xzYXw1fVq3IEOAXMNEV45kCSUoXCNiJTz1U+YJxNL2ib
	 mS9wfiqHFy9ipM7QjD1tXRHjIGIaVdtj74ZunSkQpHQ3V1FduJu1UP+KU//WjHhA2D9hO
	 WY2fNh7ThkfeZyLJ3dWxYP3fsAN4xjQTz0BHEt2xQeP2UtQouIVVhPIBuLuyeOgE7f37j
	 QCxvd8KT2/b+xjjrJwIbaAQnPuJpISPiB9m7WhVW1wIgbdp49n+z/o63O+OmoltLDqM1o
	 t7eTuL+SO4OGywEA9vwXluVWcsN0ju1Qr41/BORAd2xr0kyizpqk57PyIhT/MxchwJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596816;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=tpIiKmsOV007MhkPKdBl56suEMYx7+y9S703AI919fo=;
	b=2cyJ2rDREAlHmCnamqejRMnAuZGP4MAUxF2KE2+G4fh7D0HRVCewtgeyGjMwsRJ+X6xp
	 3q3ikQ/KNkMY1dHHWXs+jG4oSxNlswSjKycOqsYUM0TNgKcIQTXFJEkWSCcCIiYZaPTCa
	 /wcS32B8oHVKHJ+cwWSj0Yi1UH0pQnQBFRyYkXaeFWGB40l5KIjI4ezD5vhz6K5YYrkSB
	 FApwdCPPi4uvv6t5sPSLVbiaV8E3rcFMj7qljJF5efDCW2IE4n3FJV+xoh9x3c4pxid59
	 1swi5s4Rel1Zde+b94b0ruxXJYnqC2LsWhUxRnqLiJmWirQjniC6uYgPy1iP43oKaiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WH6qNqXO;
	arc=fail smtp.remote-ip=52.101.193.71
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEA60A261A
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6BEA60A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=WH6qNqXO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY+GP+1qlyWAVwTGw9sitTuco5sYLU/7D/ZyzyKhfegEIp0Aq0qkCvWMvIrjzq6WUxyMdMIrknV8akbSBgEDpzEySTlWCY6F9CgZ3yEApXkW3ZxxPlItBnnutlIa2cmqhGtniwGwGD7D2YANqqHrZhNnnq16l+BUdCMTa+aOUhEmwnVz+TaJoDw5fqe3u++FL+RvgWG9G/JibIhK0NDAaKoWdemi1YRt0wSYSgrqLUWePrruHx5KfSmgfI1VH4JmOZfMm2MHzijp9OLWHzSA3QyOgucgrLNPS6tpv229ryIiqtRvHQO5g8O0w5QbfIARRgZoj3J00fAmez7axsFYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpIiKmsOV007MhkPKdBl56suEMYx7+y9S703AI919fo=;
 b=syNxIe9lh8KU3qM1tMFLBVbYNnGIygHKSQGfU+hstbRSMTvmLpLVmH8s3XRqBjjP/WVZSVfTe63A5LkQJk14w+7TzSoF3svf+jwl6ByIVn4pIT5qmSKobdjtUETb8cH253EBTySbYKebHFjh9abek7wLAavOp7805SRo6yeNkhihBiPKivrUhjEDo9QMcKe72YYT+p81QLUKiUrjHBvwHmDXSbxZHUqopeNqtJ0lgmS4hV9TkjLv8GVTrsSJLOPN/uwnlUxTCPHYJCd+Jfz6btkyTTfNZOJMqRxsPMycAoi9pWzBk4frNBubHhaKP7K1KeEybahfUNz8pimKgWW74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpIiKmsOV007MhkPKdBl56suEMYx7+y9S703AI919fo=;
 b=WH6qNqXOFBUdZNMCJ6zz9iGh/wuQAysT9d79K6vdklPFj2Sq+p/ETpeKAGZGedJl/8hibINzNaiqKLAIbs62pTPk3uqLiCQ46eZmh0cZXQAzT7FJLIfBiLWCHeVUJ6NxMEzOz5L5iNW5zDU8e1heWGuOO2pdMsAC/b4zKpNeN5vl5kCWWPbyOpZ053PSSvbTx19G7So83vW3ShZ/TEoHC/SALpv63ihV7K8CVRGPdlf2Zh50JnaF7NUKYYU1meGvpBE7zFSEguFQS4CUF2X3OUl+Igu3rikTEYzlcsjOU5QPEG+KYholTcWD4W6TsLrGpXCtefMMMNZSmD57tZJbCQ==
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by CH2PR12MB9493.namprd12.prod.outlook.com (2603:10b6:610:27c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:54 +0000
Received: from BY1PEPF00026964.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::78) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 05:19:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026964.mail.protection.outlook.com (10.167.244.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:40 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:40 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 09/12] iommu/arm-smmu-v3-kexec: Implement is_attach_deferred()
Date: Sun, 1 Nov 2026 21:19:17 -0800
Message-ID: <8de1e1f52a03059f2e1123d259467eac23e9740e.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026964:EE_|CH2PR12MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 6347916d-267d-40d9-fb03-08df38a0ed85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261021135927099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	r7kbOPtEFPtQKEM6w+TpmvJh98XsjzBKn6oWtsB2RA8YcvU/5MW3RbZau+rdD/13xf/b4OlmkLyLWdIqHlameMeZEcOt8fdmtdMt6+iS1YmoBCTx9rVH7EYEpIyLNPWJFOXBPJD6t2X8fQ8VCPxpxZF06I29kxxCFj3bx/Rpzj2xK8eyepXc6s0D9GmHrVLKdDCHQLYyghY8I3rGadTQoNanvJ47fZdrdzWXrNEvpkzXpkYrT1TGVYkJVReCZZXZFSbjfaoXwGbbuQp7dEjRmbJBtdXcLB9gmjncBde2QILsqK7M0SVGzmnvDR5ZUdoXAWT27TTElyqwW2BQXy7ZQmzlXB4dJhUMYJltKil+zspTP+faHqb1Cj27/8NOnhicfaCKy8AiypG/+n1YdGPQyGJz5ZQe+Ql+vpEx7ucyYLQEbVieKAyoDMmg5+XJSLu22kWxHO0mE4x/RQPHYqb18Fjx9fa4n9pc8Ya7+fn9znvYiUP40CCK/u6dY16Z4hIt5Q9apfXzcC2I1RMT+2LF51xV4Glk4HzU8MBC++4cUFzFJ+e+r5rz+WOgy2WsFcvPYO/eMzMX4VCTIKHXY2yXPUohbkbn1pDZb2FgzbpJhE5lKYoZj8MbjbfmhQGd87K3J6mkdJjEyQY/VGc09TSaBK9Y7VIi2nepOxM77dRexRxF/vIQ4aYCwxc9k2Lqq6miJfUAg40oO9eO+uQOHaRLLg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261021135927099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	G2VDYMvRXrzqyRu+cP82C4KSWi3CEwwMmZjjJn4/Ad3brNu2QoZtj/WjphGR+WnFNTP8nry9SBJGeHue3CyKILKLtzJ+1xgGsbNlQApgHH7VUFb7end9sclAiXgDbgymqMnJ6QuvI4oS7Y2Lm8jpEAT5gbxdiOv4DcaESWexyDOZ0bEyNZr3W1+jzUdP9rNAlTLFij7d1syJ4fF4wMRv7g3u0yVh9FgwTRt1z9kCkDKwfitIB05jzJtD34Y6IYJh9VzOXfBF7B3vWoWGah9wYnX88OIOwFfRkfd2wTnvBtDLx5pg4SWVIF5Scf/SLnmdQLUhS7NUEJ4KTjiFofFzTniW7y1Bl28y2I36zTQilpH+pzOBXm8dC2tGG/1lxDeCR7u7v0OsJIsNEi23RgLnPRGnE6vULZGLgb4sT9tRm/IMzC7yAhLtT4Q/cM5zReDQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:54.0186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6347916d-267d-40d9-fb03-08df38a0ed85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026964.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9493

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
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 23 +++++++++++++++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 19 ++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 25 ++++++++-----------
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2bc774cfdf77b..5b2f6caf16c3d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1289,6 +1289,22 @@ int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
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
@@ -1327,6 +1343,7 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu);
 int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
+bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1340,6 +1357,12 @@ arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu, u32 sid,
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
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 0786a7dfff411..2ab913f033515 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -686,4 +686,23 @@ int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
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
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 458f4720856e7..d45ce33334ce2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3135,21 +3135,6 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
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
@@ -4591,6 +4576,15 @@ static int arm_smmu_def_domain_type(struct device *dev)
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
@@ -4599,6 +4593,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

