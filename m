Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013003.outbound.protection.outlook.com [40.107.201.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C4363C41
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283398; cv=fail; b=fJyf/oUATdijktGWX/yV5OTHbmKGX7lrFR/V0s0kgDPfM78Y8sQurKAQ6wuFN8p1VtEiwWsC48BMhFxX0P7faSBRowoLCaR05OX83ie6jTvumnxYoOrLyZSIc302o2OoHO+u61ntmyGNI5tZQFwrfDCafttSOhttXKHCVBUqFiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283398; c=relaxed/simple;
	bh=OSn/Ssb5s31Pv1CwrsuoEDsHM+O6W0WVKt5lMj9CJf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l/ulj82CqoD+xYlDrhykrwBU3GPe8bCg5iEDO2pGZf+1pha5svYq77lS9mKk5ftwAftiNrcJYaPt9AUTuqOJjH4L9mUvCe+yc9Qv0NjBhUYC5Y9+zXiVPolPRWMrdpvRtpq7djdXzHvpkAX4fMG28Eeniqtouu7CVsEvCorE+Ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NQAu+3tG; arc=fail smtp.client-ip=40.107.201.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQAu+3tG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPIxsmeqBRJUoeb7ZJsZxFFMDKj1BdabscbcQvqa4rYPljmxI7/akuQZpoW5ek+UUdGR5BiZs1hiXapumSieraa83jPMtSViJ3fQWrBdhYDJ1eEMhHajQ/JBj+3tnmX3RX8Xeb8vMdTpM1/1qnM3e7s4xjwtOCpmBi5dhRj1UiJJd+C7FiI/+Q6rJ/m/0mcEXrtc4ZScA138t1YKrcjhn6zACqc3kcgHinLe9WIwalb3iAeeWZrDcKQOpT77LZxF3Ww2aJnSOLmBWnAiMzh37iTccIgZK/1CrTIXbfOHsavtpSxUphP/BOE2EPOH4z8DtQXAA2Fn4WaD0Zoca9kOlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zKb8HIHKomQNp5r9LcD44rm4A+Iaf/7LA0/rxGGiyg=;
 b=DBXyXozagcwxEWAozk2LxCxI2En948FKFWs1nnXSbC9PAWWZUS/FT+kP2PAohisbrxgq3FGke0onkrznTm/KLbTcBXXlcRGLOLpN1etfbOz62i8x0sIJw1DazXa3KSYiteYXAzAd+Q53WXQisoLbP9D7a/e7Al10IMqiXtLJXlHhnCnPfBxZ7c51GozhauMtUgzfPzRvJEShQoY0fsq2oytSdRyhWEQBfgRaU4DaRfGXJsHPvje+dUohQwY5iYSyaDpVXw0G/l77XrAB9lOSYusz9rM6ETdxfhcKKG6lcEGmB2vKP6tBwR98Q9ceXD3KFXHmqT602A7l20Zw3nwz6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zKb8HIHKomQNp5r9LcD44rm4A+Iaf/7LA0/rxGGiyg=;
 b=NQAu+3tGi6vDJb07BNRCkta5o41iqJ2aL2AaiJG26zHtxDQ73XXdAit27rDKmL2B3QzBPojJ1lNjdYe55091uZtewkR3fQArgrZshKvPBV0LVPABE/SzxQKCuhvN/njWbzljcsjMjXiq7X1IQbHxHKKWBlMikXAMJwJ8oc9+wbD1hxURAGnTgdxhDbDuW/d8i+MnS/+Q5Xo/KlHvPIJkKvLexnImX9btNgJrxx2lf4PV2hOsmLa4HvBtaOcT4Lx8XYPS2KSJq/f6VtWybyOxllAAhj2gdZkBuCjArPdg+3ELpYZYfi/6uvSTQUyKpt7yOB1zYTX64QwrL/7/0DUxbQ==
Received: from DM6PR11CA0072.namprd11.prod.outlook.com (2603:10b6:5:14c::49)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 13 Jan
 2026 05:49:52 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::8d) by DM6PR11CA0072.outlook.office365.com
 (2603:10b6:5:14c::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 05:49:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 05:49:52 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:49:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 21:49:39 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 12 Jan 2026 21:49:38 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V8 2/4] iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
Date: Tue, 13 Jan 2026 05:49:33 +0000
Message-ID: <20260113054935.1945785-3-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260113054935.1945785-1-amhetre@nvidia.com>
References: <20260113054935.1945785-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c778492-5dc4-430f-9547-08de52679234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DoeeorB6W6WaATn6zbMh+c/l64bj8g9QqyiSsKPEoN1QSMNTxKUY+eALIDQ9?=
 =?us-ascii?Q?EULEFY5LX6KAxtFsO/DFqIS+KCOlE8ix9yt5AH3PibLwsLlINyvMEmDzIN8x?=
 =?us-ascii?Q?rHgd+MZLUMHiZVtBe34vgtFE/MjX7jboN8D3XWGGgbdF71evsaDPdrUrxWiC?=
 =?us-ascii?Q?u48491cZfVlVV5HdOJqYeMwD4taB4TcWd5a0j2XDiC6WE+RHrwv9ReoHKq/H?=
 =?us-ascii?Q?sGGG5o2mUeEsTLqDFAA0dNinWBte3+gBRLBOdm4QcEfQufwHFXyUDYadXMx7?=
 =?us-ascii?Q?chF2HIr7XJyAOsefD1X7/OOxh9e2bFgpKrRb29b6btT6/vIDgrdbbHWPT7ey?=
 =?us-ascii?Q?JG1fWfn/q4uGrFy6o6osYyrjcAtQ6ARYW6AQSyluOhtW8OUk/WC7c4jETRXI?=
 =?us-ascii?Q?9K7Q77QhiLjulridmQU19xoCqAn1XNATsBJfusKRJzLfPn0wFaQ/Y4eMtzox?=
 =?us-ascii?Q?yXp8BwP3AuXKH/rnwKzF1aBUOBjdG4vh8+eNLGlirWrFM8WfTUBvBkCl255t?=
 =?us-ascii?Q?dYtYH0oUL/YncIgapD1QA9QjBuD4xKCK5wwm39xlRxvDGZ9FLqyEBcMS6VSI?=
 =?us-ascii?Q?SXQ2WkUtbVhKlTHwYCNhw0SY29fXcMnhPMYR+6SUC/LhppR/kCopFfC49Kd0?=
 =?us-ascii?Q?i+XzQHisPLMmMeat7sXwnZgNLLwIrU+JuU3mZCR0u7933lamujzZU8F4FVlV?=
 =?us-ascii?Q?E1cObPrxXQO3TLqj8Yw7xVYboTSOSMfygjZT00E7q0nB509qEMl6mbTQrNJZ?=
 =?us-ascii?Q?yCUvTK/IbJ78T78VQLFbAVskEN0UQ5nJ0mF1YRD3G5g4tYeWomYE25jgZd9D?=
 =?us-ascii?Q?GBdAOBJzdtFwM3KE+OOZYs12XYrWf3Pc3bzLyuALndWHUo1E7RfgRY44PujK?=
 =?us-ascii?Q?fzpTKBFEAi1PxOGJ2Qd7ShWrZUzCp6uwilYOFISyoMmThI8yw0TNOcZZ1g5H?=
 =?us-ascii?Q?JzHQOOCt1BrW7+su+sWKP3rw+IxCBvHwLuU6d2cZU2kd+qcYwNPFAziW+Rar?=
 =?us-ascii?Q?igLxWor0iQest28WPNNGgYJLs8qP9m+HqacEE2cs3IRwkqM4HXoiwIk78ye3?=
 =?us-ascii?Q?eNSb3JxnwdpdfzHqjTYdCbFRgTD0txjpfXBp9p1WG0Z2GmSX4KmoLX0gtR1x?=
 =?us-ascii?Q?6yjLhUJuMMlw25hKAd6jJcx4cABY/RD5uCmg/HqH1ZvTnpBugfsoOzWgz5m2?=
 =?us-ascii?Q?N0riZlqLgGRw1ZxpbEx2mXut9eqaCxEVIEzk5AT1md4Qg0QMYZuIQUxJDp8b?=
 =?us-ascii?Q?HuBGdtI5n3SpCYWonu501/G/NH2xTn8wsbIhw88UclM4cHgsmjA0v4/J9WhV?=
 =?us-ascii?Q?Vx6uFa+BU7fDDk44S4R9vq3Ugvvji6lmrnu23PsErm3dvZ2eJ528TfQLPD7j?=
 =?us-ascii?Q?/sdlZ0QtVMprJrCUTxFoW7Vwt3Y19IYoFm4RLt6ur/cM3CNO/2afBE0WtwQx?=
 =?us-ascii?Q?B4d4BCZ75R7JLPjTz+pG/239UphMuEs/WUWk84LkJfL1dT0fHWQLooZaEhcG?=
 =?us-ascii?Q?/EJJq0S4FeQGA98z6kVoiXdwZvKAmqqnI6ChvZsmQiP+cNoemj57Zqp0tp5q?=
 =?us-ascii?Q?rnhgT6BtEFTpGTKYa1M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:49:52.0170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c778492-5dc4-430f-9547-08de52679234
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

Add device tree support to the CMDQV driver to enable usage on Tegra264
SoCs. The implementation parses the nvidia,cmdqv phandle from the SMMU
device tree node to associate each SMMU with its corresponding CMDQV
instance based on compatible string.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 32 +++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index dad3c0cb800b..8653c52977d7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4530,6 +4530,35 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	return 0;
 }
 
+#ifdef CONFIG_TEGRA241_CMDQV
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+
+	np = of_parse_phandle(smmu_node, "nvidia,cmdqv", 0);
+	if (!np)
+		return;
+
+	/* Tegra241 CMDQV driver is responsible for put_device() */
+	pdev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (!pdev)
+		return;
+
+	smmu->impl_dev = &pdev->dev;
+	smmu->options |= ARM_SMMU_OPT_TEGRA241_CMDQV;
+	dev_dbg(smmu->dev, "found companion CMDQV device: %s\n",
+		dev_name(smmu->impl_dev));
+}
+#else
+static void tegra_cmdqv_dt_probe(struct device_node *smmu_node,
+				 struct arm_smmu_device *smmu)
+{
+}
+#endif
+
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_TEGRA241_CMDQV
 static void acpi_smmu_dsdt_probe_tegra241_cmdqv(struct acpi_iort_node *node,
@@ -4635,6 +4664,9 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+
 	return ret;
 }
 
-- 
2.25.1

