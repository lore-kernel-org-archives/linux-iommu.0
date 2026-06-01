Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB2639D3EB
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310949; cv=fail; b=iMJ+5tUXyr0ShKXZRAu4wSBSQqhTbs3/M0sSU/rooCaUDKihNt4dR5UzR1aGSLjrMfTnyP6wjoZz7bSZ3zvLFRzopQ6FG0hECRTgeBqIRgLwWaZ2oCOEKMIeMYUPE17AGsS7omDN1ch/ZtxHhKdIkbb/7n+jJR+grCllpb9yXxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310949; c=relaxed/simple;
	bh=JaimlWCZDdSPtK3RrneI/scJFX53i8GexVisGQFvF40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZsdSR/7ZQavXDbaYw6SjOhP5am+kgXBdipn2DhzdYMqDSxjlpuNAudtzNsMMi/fSoTIJhXz4612viP+VF7azfL0Pwm87RYOQ1a2FE6D65YKVH14hHZ/KbFrqT5ks3L6IzWGSBQNUi6F00uSYnKXlhp09TYQkjjKrhUHzBqdEdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=co8zWOvF; arc=fail smtp.client-ip=40.107.209.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="co8zWOvF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loE82eYlhd7YOHw+6U1iLpfaRNspu3aEpwT7ynwjo6Qe8XS+TjFnYUKxrCyWj/Y74kJ+BoGHzDFtk0afQmiZKZmwkapKH+9kHHL51yk7I/k/BJbwvvsee/SXfFiTU+0wKpFZjgTKBHW9J1PE7Zsri5s1OCF+xqw7RxEJZtXk5Qcbrk84oFAm8h9kUETZ2paqJJF71dMcl83q6JpH8wQ9dcSME0X3igiXC3Ks7s7uMT03PCAQygcg62CNvB3r5bjC3juSh0pVoWMOHy2b1cfhEIHCLmeIlUJ3QBPcMhE3im934SKgO/u4ct84FITA2j1o1yShcpkzKH1y+2xsQsKOUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WD1yM/FIo8z/7WhAfIKqkpwMYGm2knHjw9kMoSt+p7w=;
 b=JHnJGSQb4cEs+kVytqt8KP/AhJbkEUA5yCEVvS3Fp56Uy8DeEqMncyLqnRrY1poRDDEhFas8Lmnb5kdDteCebCliAl04k7YHGcafVvQpSJ7BldYymMXqeUfY6rxoZxhJC27c9ObxKENghnfE9JU+AeuKzuvMtWoJF5x0yNhceEjIrOvfwvSbyG1o83iUPCVeYjFRAhDH7FFMjKXVVZ4cRFWyeTKC1FM46Owb3sYEYNv1wSwncKUsP1RTdhtnIrxkNj6qePxC9JSvN3/nN13ADPRvB0bUDlqqnaqOhBkPK/0bU7hYHMWguwr8g4cMNP6hRtb9JSHrH7flMZCoAFXumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD1yM/FIo8z/7WhAfIKqkpwMYGm2knHjw9kMoSt+p7w=;
 b=co8zWOvFyrNhEEig/cWOioeGBCvKSEjz4Lt0HffBbMylBLSwTqzneZ3a/kYRjsWpennFDGgZyef7Z4514ZX1TUHLoxlYbuDbeZJ5Af+hBb7UdTVpXrXw5gPYUesiZiJckPvSDLNIoAi3/EQRIyO6vAPlfbHVANIVoWQK/Aw9ZmWDkTM1XpwvMmEMR0s5/PW+fwihkvA+QYwkb1bpJs1uRAXlXnLvGzIobzu1iAYkw9+7NBrcoo8YZNw6Q4Cb8LeptDBwF4qaaikdo6UPslwJIl5KbJJYPaA0lx9T+zVdcXUy/rXAeKg10u8xZZR60Hx/MUA1NVcxdDNokD3Z6JxFoA==
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:49:02 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:39f:cafe::6a) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 10:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 10:49:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 03:48:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Jun 2026 03:48:49 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Jun 2026 03:48:49 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v3 2/3] iommu/arm-smmu-v3: Detect Tegra264 erratum
Date: Mon, 1 Jun 2026 10:48:44 +0000
Message-ID: <20260601104845.995005-3-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: efd1d449-a5ec-4fd6-4aca-08debfcb64cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|18002099003|22082099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	OJWDPK+5pZ4slhQsV0wLBRdpk7J2QGlHZi/7ObTvPP0Zoq7HKHmtE7fS92qmkAKrM5rMmyKKdVhKmmXLAdW7Px0fe7Pk6zrnkZ3uE5Rx4/m6sYDbrTvfrMsjE1G8ghoNl/7n+RoytU4Aie6m/SvDAwmmOVwOXHJG96skc9hsDrj6XRZEnttYhESEsYt6nIhr3JdA0Gy+Es7DR7wIo47rWzvGABUdla2DnZbXoGW6IlEQG6T5MJXk9Lvby5YI88IhRlYQdRtmVPKbNyLifOB/VAXQJM8JA4QIV0/veBAVKwDPRMHeu819jKnYaEiJN6GNcItnmgsG7KXj2HirA0oNmdmC9ePHsybQyDbtLajURC35iLSaVK8gKnmQt74gvmmM40QqvoZnHV0Pg4qcC8ZX+eTMA2oFcD5c6qoxOTWi45AZJQgmNN53H14aZK3ej8L4xz4khg2uC1R7pj3v8jxfcT2uF/ILqWveer0RWaS+TQ99Pf6m2PN10f6jXP2NfHXxTHTx4qzEu8ou4gJ9QfVeO1dalG9bQf3XYXrBpq7zlZclcAGLrrrhjJorAq4fJ9O5q0Ysr5FgQP0orOvW8qLM1+ghr/kG85SmTuiJ5B0JMh5oXbRMD5H3HqAYXMJKij6EodFsOUwpj2uNGkzPeFkMixGkhzlcbtn/d8afgETSXac1FzYYy5EYjVrl3wIAslKhBliL4nOz2YqZ1wlhQ9MXX657BRD7cYOC3S1AauR/9hk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dDkENlnqyqsA3ivoo84kMNVKPkd4LJkkd2M3AntraZG+C1YAna95mIyif9I3qCGlwV1dQ3z8LpKNw+/rQxgUMeIJypSnqPoo9mfuF//LMgJDMr+zk2DxmKFlXE4qaMfesUFj+gHN1GlpRlXHjt/IVdrhTR/zml6vn/piHeBOeKpHdgW3yg2ah+eicvFGfMdMpCTVGzueQPuQJRByZQbA8Anw16lJhucJ+VZ0T+02WugqE/Or3zFbwNnGYqbuwAkEbFSUxK7vSLIO0c8kumovGjf2X2vjtyKN3ra0BweoksO3cbzMKicBdotGWyU7cz/VP+OmZCAGKy5dc189LIEN3XBLZCMS2WXRBXl/vVfk931a6M7oVytasJ8A3cacHK7UZy6wSEZiGmZ5BnaV7CrlOLtduqRLUR0QoZtTjvKBRtasv4Swo7oXO9lttr3PrQgh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:49:02.3349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd1d449-a5ec-4fd6-4aca-08debfcb64cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324

Tegra264 SMMU is affected by erratum where a TLB entry can survive an
invalidation that races with concurrent traffic targeting the same
entry. The hardware-recommended software workaround is to issue every
CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue
is guaranteed to evict the entry. ATC_INV is not affected and must not
be doubled.

The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it
cannot be detected from hardware ID. Tegra264 boots from device tree
only and has no ACPI/IORT support, so detection is through device
tree only.

Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
the existing "nvidia,tegra264-smmu" compatible. Also add a
static-inline arm_smmu_cmd_needs_tlbi_twice() classifier in
arm-smmu-v3.h so that subsequent changes wiring the workaround into the
CMDQ submission and iommufd batching paths can share a single
predicate.

No callers consume the option yet; a subsequent change will wire the
workaround into the CMDQ issue paths.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  4 ++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 40 +++++++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d29bd343460..08684bd40a6d 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5243,8 +5243,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08a..106034c348a1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+/*
+ * Tegra264 erratum: a TLB entry can survive an invalidation that races
+ * with concurrent traffic targeting the same entry. The software
+ * workaround is to issue every CFGI/TLBI command twice, each followed
+ * by CMD_SYNC. The second issue is guaranteed to evict the entry.
+ * ATC_INV commands are not affected and must not be doubled.
+ */
+#define ARM_SMMU_OPT_TLBI_TWICE		(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
@@ -1211,6 +1219,38 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
 
+/*
+ * Returns true if @cmd is one of the CFGI_* or TLBI_* commands covered
+ * by the Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE) on an affected
+ * SMMU instance.
+ */
+static inline bool arm_smmu_cmd_needs_tlbi_twice(struct arm_smmu_device *smmu,
+						 struct arm_smmu_cmd *cmd)
+{
+	if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
+		return false;
+
+	switch (FIELD_GET(CMDQ_0_OP, cmd->data[0])) {
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
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
-- 
2.50.1

