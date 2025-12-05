Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158A2FF658
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917957; cv=fail; b=M5i5Kr6WzPaqtSCeiCMy9YUgA9eOCI5oJmozkHr/NVQdoGwioDdll4v8FFP8S5dCYUHSaZve4wF88BDtX18areWbbcGqB9u3HV2t1UJ+whot5xCzNgp7CqZOsKgEw8grIKvF4evGYWaFdWlxoGaNMZSjYpk/dOWNq/lP9vwSlNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917957; c=relaxed/simple;
	bh=mySVPBxEVT9zPWTS/gxmd+V75XGfQq2Pe2MufrRpQMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsjZlQJ+UPizJdE3s2DFOJebxPdxnPDawJ447BglLb+Fu9inon237Fat8Z9UEn7tODjDKYbUCLn0R6m32tf9ZpxfHyepl1GB/7GLe1GDAoGyZruQDvUMIzIDdu4BlcsPsVG914bvo5In+rYV1+3JVbpL5j882XGl/5KjWfn75KM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L6Hmd3zd; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L6Hmd3zd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBa5zvU2GBKgUvbUr7e2xEw24JJQ4wgHKEbO8X0JDZJD7PjJAF01FQGdLuc6jUuTfpd6hehvoCiMbZlBSrBAaQ8ffw0PsmMwwDnvWK73bhxzsALsIJ/L2LitvQTv+juIvFSW2zH9Z8r7J1IsJYJJOZNklcVI7RaPucmpq+HnrvyEMBFz9ato/0J8nBx8X9ZRnGCN/9ObJy2bS5H3/kXVlViZSteMbgtZlkUQMq91KjONgpqU7zcGNUavxFJ8f0/yqoITBuBlUYp2H55yBXI8BC7JV9v0d4vc4/XWQm9e5uXOPMGmNE5CmvTqkIJlhIgT4Jo+LGZENyqFuboXHGKCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5C7BbNbxkCycrp6WS3b6f8CAENtqWpmuc1Dj+Qmq5A=;
 b=F3I7CbyjiLw9C0HxHoD0jhQ6JzL4eDfLICPBGZ1IPWiicnAY1oO8Gt9YZp+19vvC6c5uDAkFo8lY4EZwFNdqQVxk38XNU2L4pRnnrBmn1CVwtet+EbzbSe18ZWCcDi3DKr+3KXP52LvRk/6NyMRp+RzVhtg0TM/0Wf2w23fXuaoMZe9kiMVxhpQH6YYHaqiMI5v0zCrZqDw7Burr0r60QZH3iML0kW5dn1azixGV8GTuhvehQgCGXbvGvmnYsdS9VLnJLZV6Q62hzXMpm0GfAK/4oCSYxBQOEm9eJV+GD2O8eUwtQRLjMtwjzdmlE0rY5PX49GEgls2nAyZhgGsErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5C7BbNbxkCycrp6WS3b6f8CAENtqWpmuc1Dj+Qmq5A=;
 b=L6Hmd3zdLBe8oKTAExrIb/PQBNR7d2AEuOz1TQaCso5tDkJcnxYdWvxxGSKN/fmVw72a/x5XFx/8sGPxyQeisOPTnimyiyMjZCPciaayFucXmabCyIL9hyBj08CMzxDJ/EL0ayG1QcHLmJCuVPy3/cBK+YG6h88CGD6eHjMaQvc/aJ9t+KLMtPI00q172NV3+nSHBIX/IPPRbong3FSR3h42dRqo1i3rGzYBgsRnR0kRzMrSftjrhAU/sefmiSKaQ/MuzT/YMYxI/Hx8syNPlD4oIpTH2ZOntzSBS7z2rapw67RmKR48feCO6Es7kzOQPR23qvNkd7Ms2/U8YXipWQ==
Received: from DM6PR07CA0045.namprd07.prod.outlook.com (2603:10b6:5:74::22) by
 LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 5 Dec
 2025 06:59:09 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:74:cafe::48) by DM6PR07CA0045.outlook.office365.com
 (2603:10b6:5:74::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.11 via Frontend Transport; Fri,
 5 Dec 2025 06:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 06:59:08 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:59 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:58 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 4 Dec 2025 22:58:58 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V4 3/3] arm64: dts: nvidia: Add nodes for CMDQV
Date: Fri, 5 Dec 2025 06:58:50 +0000
Message-ID: <20251205065850.3841834-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251205065850.3841834-1-amhetre@nvidia.com>
References: <20251205065850.3841834-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: fc696293-022d-4261-3617-08de33cbc9d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ChBeLkJHJdhwHYQG+jDso+sWiomXwqV94jTOh9Z0N6iwHKCJIz3TgrEW7uiv?=
 =?us-ascii?Q?rzYFGcHEapJWtBa635797U2615RGsKaO97ZGQk0xOxgxE91giU7FKkyghuuB?=
 =?us-ascii?Q?ph6uQadEmazROdbZW6jGcJguqigpmIeJRB++euN9JSJPrCrrJqd6B5UUNLL0?=
 =?us-ascii?Q?TWJC4HW/qJ2sV+d0wm7RhLethlfBSqwZUIZOUEhTcXraIx+5Vs97QFsH/mxK?=
 =?us-ascii?Q?UbxoF46gf5uxTF3z5nGlzcE0o1uZEtB2sSAB+UOjDTs/6uOTEMEvYvinY1mq?=
 =?us-ascii?Q?kJM70soqVtoKXlvjDiIgu/Aa38tKArPUAb5ZdvbgMzMsQb5An2cpf03b1P0K?=
 =?us-ascii?Q?fNpMS6Am1LSRcNd+T+F4OLH7ELlPQE+MOGAANj1cXr049arzGK63AE+ZsBWm?=
 =?us-ascii?Q?fgXev5x6H1ftEjGnKph3bxbSsiot2qkNIdlw3YcTT9ZmWyccnEJs5h1v6exg?=
 =?us-ascii?Q?6xeScyNN0dKiCrTi4hx+FURy7uQhQ/r9TEnBDW8V6meYZCU06NFqjAytORQy?=
 =?us-ascii?Q?VoQKbc2gTzaV0u6IwuybYmpdhFbh9WJILe8voxM/pAR48w5uvSD+dhWDyo40?=
 =?us-ascii?Q?DkGhsgcmDKdt8TZ/7XK71BqtgbK7t1elTnq2qj5QCvhLylNceWu90ykiwVgy?=
 =?us-ascii?Q?5Q+8cspAjkpxW/uz5MnsHudtvfevYvquehsl/oQTwN8W5ckxjY3VZcoJA3gj?=
 =?us-ascii?Q?p1CkACqKAEyedkcswpp3Xd0yOFfrlWn1DA0/FxpxVtqolI/ahMUHQexAXx7C?=
 =?us-ascii?Q?NFqfR50XcANy5xLEJgYbcnv/XrrnsCvz7PuMsBXBkmN/tmTgYYwhVX0kQGNC?=
 =?us-ascii?Q?6FO6ayWyEaUuOCvUr0N9Xm6u/ADBdBc2j7f1ZZRA47vNOyDVsigBl87Okd1b?=
 =?us-ascii?Q?7TU56UpUrdkN3BhHrueKQgM9enYzoMmCb/gDpK1Q1AwnnJHN6DtH7Qv8BZlk?=
 =?us-ascii?Q?n3fBFi06skJ+SNPzgReGBf85orcMS760dln/U2h0Rzm4IF99f7JlzQ7qVnbk?=
 =?us-ascii?Q?NfPL1kvnTqQdH6W+nRbdry0t/musl7evaqekVr/sPddGQAPnq1ayxhn5usYc?=
 =?us-ascii?Q?drwlHy2xQ/r61VRd+v68t/qn73XPNTuXES4gT3ONSqjwqZ0uOjHTB/ewUt3F?=
 =?us-ascii?Q?Hd5sBhlZIRua/ugfpvzk5PdcfUubAcTZ6+2dYPAmbybg55kt00Wxsi05Qkq5?=
 =?us-ascii?Q?VdeUTrC3Ht9USDjF1cLu39UG/Xl2zNsZBH3NCBOrDlQORaZ/Mo/esjltKCkw?=
 =?us-ascii?Q?ATBRiaeSfsh3lWaVgj/2+eN5dTYLdSiXZobJRLfoqWEuTA1NR2lm06bMnypi?=
 =?us-ascii?Q?vCCpCiDzvIQKsVujVkLgHezbzKuUBdQCGsrx185nUf2ujBh8sp937qgxEYjB?=
 =?us-ascii?Q?Fua9b7W0758Q0/hTEopDtpgFoIoPbMC95mAsIogdQEkTOnVY/xgNKfQ+jQo2?=
 =?us-ascii?Q?01BPBU63UBzY/qGLQYZNaGSdViiiYKIgl43wgZs893bBEMBJNhKd2x+5yhWn?=
 =?us-ascii?Q?udV5+KECi0fOfUBK7i3U8Vbizi5b7EBWXnObZnInubCxz56xtyg7CX2fU2yj?=
 =?us-ascii?Q?ZGudvaKz7/6i3w2vMHg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:59:08.9394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc696293-022d-4261-3617-08de33cbc9d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
CMDQV support. Add device tree nodes for the CMDQV hardware and enable
them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
instance is paired with its corresponding CMDQV instance via the
nvidia,cmdqv property.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++++++++++--
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 06795c82427a..7e2c3e66c2ab 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -23,8 +23,16 @@ iommu@5000000 {
 			status = "okay";
 		};
 
+		cmdqv@5200000 {
+			status = "okay";
+		};
+
 		iommu@6000000 {
 			status = "okay";
 		};
+
+		cmdqv@6200000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index f137565da804..9eb7058e3149 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3361,7 +3361,7 @@ bus@8100000000 {
 			 <0x02 0x00000000 0xd0 0x00000000 0x08 0x80000000>; /* ECAM, prefetchable memory, I/O */
 
 		smmu1: iommu@5000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x5000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 12 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 13 IRQ_TYPE_EDGE_RISING>;
@@ -3370,10 +3370,18 @@ smmu1: iommu@5000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv1>;
+		};
+
+		cmdqv1: cmdqv@5200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			reg = <0x00 0x5200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		smmu2: iommu@6000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x6000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
@@ -3382,6 +3390,14 @@ smmu2: iommu@6000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv2>;
+		};
+
+		cmdqv2: cmdqv@6200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			reg = <0x00 0x6200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		mc: memory-controller@8020000 {
@@ -3437,7 +3453,7 @@ emc: external-memory-controller@8800000 {
 		};
 
 		smmu0: iommu@a000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0xa000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
@@ -3446,10 +3462,18 @@ smmu0: iommu@a000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv0>;
+		};
+
+		cmdqv0: cmdqv@a200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			reg = <0x00 0xa200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		smmu4: iommu@b000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0xb000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
@@ -3458,6 +3482,14 @@ smmu4: iommu@b000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv4>;
+		};
+
+		cmdqv4: cmdqv@b200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			reg = <0x00 0xb200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		i2c14: i2c@c410000 {
@@ -3690,7 +3722,7 @@ bus@8800000000 {
 		ranges = <0x00 0x00000000 0x88 0x00000000 0x01 0x00000000>;
 
 		smmu3: iommu@6000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x6000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>;
@@ -3699,6 +3731,14 @@ smmu3: iommu@6000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv3>;
+		};
+
+		cmdqv3: cmdqv@6200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			reg = <0x00 0x6200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 		};
 
 		hda@90b0000 {
-- 
2.25.1

