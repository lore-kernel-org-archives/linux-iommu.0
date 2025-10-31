Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C132FD1B0
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 06:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892227; cv=fail; b=HIyE0L2SkwHOUzlx5duWAGzObm6zAQfQ06O0IXDszJP3mnjgA431uqRKJwUUqSvAqh3PkLdMVCPFHarohyWJ47Lg1qyYVn/7sCnbOsQDF8txmwBBxAefXzJGURXKda4+Wq20L0xMk1Z5wpn8UR0FA4fGNdz4uW2pKqH3fOXpJ3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892227; c=relaxed/simple;
	bh=SIrZC3EdhWDC5P23eiIc12Fn9xp6f/UcG7tsJUr6A1Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfP654L08vvR3XFCGzEpbQpQ/W1vWGRPa78G7gIKQ0N7lIoptrNMVM3osslihJxcfkgsVdKhZRtkCeHUdjtHrrJdY7RmcN3UscGuhAE3kSY2LCi6e018nrCqcALBT93OJH2vuT4Am7w+eY1ihdd9cjBh08rNXSR5NkEV43/0J+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fZaVpm9W; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fZaVpm9W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJC+TecQ455CyfEyjQqjxpSRU3PfGoWjGJehjlAPTONRQ/kKkb7jUYUb1hltln2yxxRDubEVP46SuJcjDznVUjcYIM97Jca45pCiHWowTtXa1sSOucAF96WhFWrKA23LFOPyB+B50Z/fjoqNpGsLTLA+lvr22Dp5j4r5+3FITNXxCE15Q89TtS1V0GmgwRNMGK8IsvWoyekFwTu/c6558dxdqVL+d7ekDraScN9cxGZk+x0Mlrt207F2a4VkERkvS2yGT9BtxBM3wmuL2wx7O2zMednTgXzIcRPvf77BewT7L694s2FhuGr9WNlqY7Xbco25Inrxm1d+mQC8hyytwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woad9F3kNbMCyJ1Xi82xrvKESKMTX5VuL3O1Jz4AvKk=;
 b=GyEIiHmy6qSXDlfnKcOgY6YZI2cO9bt8EOAACwcLUIt5sntZaNx9FeQCrWw/NsFdoPciCAQwPcIhjyrdpTlsWW1wi5ksAM2HHgiB7E7BtuCH4lSzggkYb76kWbay7EJWkHcY9PjwZBezqKSzqs1a79tPBI36NPIMuvk4hDicOc9ttu+2tvMjkyUi9jL/FOFMt4XwTEYgMcHlHBtM9nhs9Dg2bZXaUb3JpyEsUdz9x3LVjfWS0Wq5iCM2LgGHLthXSnD5uah65R4kMDsv2DRL9x6ldHMioqJgQqsN7kVgJm89Sf7KPDt/7FMwLa7VInNNzuh3B+ziZ0Ng2r+E+TscYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woad9F3kNbMCyJ1Xi82xrvKESKMTX5VuL3O1Jz4AvKk=;
 b=fZaVpm9WNCl1e5L5WOaVz1LMnxJv1P3wbZs1s/dzFNEHCdnbskRJsxkQc/Z1RUfqtXEiQkQJhyiQpvmOXcAF0cE23cDsWjGMw/89QtU/RjWdyQM4YAfHV/seFF3yzOfJM6hc81gDt54t0/0Oa/Jr9Ema9jo9TdQlFTqTPc726ncqVTtMa0vPcLhLJi7nfqY2EMYhsNthup68Jl5d72QLej1c6XSGgTw5Zl85ZNVEzfjpQ6VWBHI+xQ8p6RlsHXG2ETwxxf/vh4TBMM1ZocCRtllG4Ar5wYo5qNWoQ8jUdEHhN2ILl9L621/hGll6+aN1MboRHnmTFd5DOC4N7FnVWg==
Received: from CH5PR04CA0021.namprd04.prod.outlook.com (2603:10b6:610:1f4::14)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Fri, 31 Oct
 2025 06:30:21 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e) by CH5PR04CA0021.outlook.office365.com
 (2603:10b6:610:1f4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 06:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 06:30:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:30:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:30:06 -0700
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 30 Oct 2025 23:30:05 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <jgg@ziepe.ca>,
	<nicolinc@nvidia.com>
CC: <linux-tegra@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 3/3] arm64: dts: nvidia: Add nodes for CMDQV
Date: Fri, 31 Oct 2025 06:29:59 +0000
Message-ID: <20251031062959.1521704-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251031062959.1521704-1-amhetre@nvidia.com>
References: <20251031062959.1521704-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cd8215-8bc4-4fee-c334-08de1846f75f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OIkKq4TnmCv65OlfaWGAc6PmGkrDXiFfw4wgc0OGbs9qUFYnyR8y7j/js9+N?=
 =?us-ascii?Q?GXP7VMhE9fx8Js0O3vrjHSwn0IijAyiLxFF6AShbgLnRGEj5KUa+sbBqBTmo?=
 =?us-ascii?Q?1ERAvL14gAKvmiRU099KCzpDlvD8cueH9v/4FlrBdi8VA/uKvbr/J3heT0PC?=
 =?us-ascii?Q?TQ/0ue7G8CmwcbBJw3r0EMEevX7BZnBFob0boXut2M6QLb9DPgMmOtWJC0xG?=
 =?us-ascii?Q?DUBtSe1WuSK2AsioIZUEU2UF9cQcmAcn7FmTzJx2Jm5oLYw0Lr+l887nFvYs?=
 =?us-ascii?Q?coHbqfmfK1O/vfl0KBUZ3EpZUsQFGuKcQUav2fucWHPO+fYecOglPjXkhryX?=
 =?us-ascii?Q?TG6owrxVOpe3BEETm6a23f/4ojcovVW2q4JSKV4xphd0ocLZWai7l393952O?=
 =?us-ascii?Q?SqGLwXp3eglxnQVbw0tMlAxs0Yoymk1SR8+vizPQ2ord3QH6Fy6oPY4IrvZg?=
 =?us-ascii?Q?g+Fb2/b8Qoml/Cz323I0hCexO4TckpTL+Ar+KzAYK4ytTHsVLCHpN0Aladhx?=
 =?us-ascii?Q?N5AmVdlLvMmq2mJ82hMzXRmUv6m8EMCl5kp5NT9aeC0uSJDksAQl76pd3OgB?=
 =?us-ascii?Q?liS9RRPk+GeVfG09JphZVrcoQhtKBXxg3G5WWXtMDsMBEynwPLv/CTn8Y2oC?=
 =?us-ascii?Q?NWZ4vMc13MA2q+oGKFUWh3bsbZvkra86JwHKiJtZXpq+zIcg+FwdifOyHzkn?=
 =?us-ascii?Q?mZczNF3RsSTJKl3qnt3+F/nVv5k8djuU2KiplKKbAN11MMIvVD8o13QIHs18?=
 =?us-ascii?Q?9D3rJqatN2mi0mtXfwFKs0xomOpkDh3DeDvwxHXiDyY9DIHQ0Sr+prC5JnSL?=
 =?us-ascii?Q?zXVr9mCJZfR1RHIzjuv9lnUeYeE/7A0nHozOjbW7ZVgzOiWJczEh8H75JX84?=
 =?us-ascii?Q?LvKohsm4LKgTpZi3gYnTIYoeiU3VTutix0m/JIqFAFMME03kOxmYCDW/p5Ah?=
 =?us-ascii?Q?idEYKA6N1gfC8pK3Q/s6pFhFG3uL2BPLC7cj5y30gX9b8mQ2dz00+vhK4+m6?=
 =?us-ascii?Q?0hg2/x18Mrd0Xw33RQyZ44aNhXNhiP4joF7GBa8VNC1LsMqaE3dmtVPA+cKq?=
 =?us-ascii?Q?AhDl/lOmfyE/+rM/E+db9Pe2b7U1oKPhRAiALNAzwHL1Q8GVz3n2FZnZLM5A?=
 =?us-ascii?Q?GDuMXxQpEra0ljb75xgV+aQC+8hnzwcRUHx/kZStVjLVh2qmmGVZjiaZ4W5m?=
 =?us-ascii?Q?op13LW5//Q40d70Rk76fqbVk30dj9bSyULffQMgeoGOyDBeLGu/iytuJ15yb?=
 =?us-ascii?Q?jjcpEerViBhSUMpNe7ajjHQihakXuW5Bdinvi1JwlEWBuXsKuEjqbyiAYIpe?=
 =?us-ascii?Q?AI8C9m+RwscjJ2TgJp8lYpQvisDwFAm4HdUqTNjngaFCrp8hGEtWXtaLQ9fD?=
 =?us-ascii?Q?dROaucojhemUe9s8XqXktIS30AxRTt9tbwGHkorYnqzKgAx5jOD8D4TCIzk2?=
 =?us-ascii?Q?PANMWSsRW6XJU65rhGoMPPmlEfaVv9FgF2DLWuQM1vSeBojEMxkqwZGDafw7?=
 =?us-ascii?Q?DSzq9kPSih7bdnifOQczeSs8infQ9MYHXAsGID1DfC6HfJ0Ui1ApzRTulz2o?=
 =?us-ascii?Q?78DI0TBgT7pn9N6Gq13btL6Dy2rdM0qCrdYji4Wq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 06:30:20.8490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cd8215-8bc4-4fee-c334-08de1846f75f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Add device tree nodes for the CMDQV hardware in the Tegra264 SoC
device tree and enable them on the tegra264-p3834 platform where
SMMUs are enabled. Each SMMU instance is paired with its corresponding
CMDQV instance via the nvidia,cmdqv property.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 06795c82427a..375d122b92fa 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -26,5 +26,13 @@ iommu@5000000 {
 		iommu@6000000 {
 			status = "okay";
 		};
+
+		cmdqv@5200000 {
+			status = "okay";
+		};
+
+		cmdqv@6200000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 872a69553e3c..609f6f5f7ef5 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -212,6 +212,7 @@ smmu1: iommu@5000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv1>;
 		};
 
 		smmu2: iommu@6000000 {
@@ -224,6 +225,25 @@ smmu2: iommu@6000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv2>;
+		};
+
+		cmdqv1: cmdqv@5200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0x5200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmdqv";
+		};
+
+		cmdqv2: cmdqv@6200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0x6200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmdqv";
 		};
 
 		mc: memory-controller@8020000 {
@@ -288,6 +308,7 @@ smmu0: iommu@a000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv0>;
 		};
 
 		smmu4: iommu@b000000 {
@@ -300,6 +321,25 @@ smmu4: iommu@b000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv4>;
+		};
+
+		cmdqv0: cmdqv@a200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0xa200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmdqv";
+		};
+
+		cmdqv4: cmdqv@b200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0xb200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmdqv";
 		};
 
 		i2c14: i2c@c410000 {
@@ -541,6 +581,16 @@ smmu3: iommu@6000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv3>;
+		};
+
+		cmdqv3: cmdqv@6200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0x6200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "cmdqv";
 		};
 	};
 
-- 
2.25.1

