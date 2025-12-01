Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94D433344A
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606778; cv=fail; b=cw53oH6ymjiJtQokNZ38jTomn39FHGVIw7ug3rENnBRwb9VeTHYjTBr9epeDKF64AF1adUb0x99/0ZQ4KWCbUJAwRZOWgAFRo0d3zAT+fdX/lg3j0wfzVUNN0boRGg9vd0ggonfnVCn2l9BCMkpH5HMVq1x1nVGfK/l/xmjRKM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606778; c=relaxed/simple;
	bh=WfZ3Y+BFzUWWTJ9QCJ1o6x+K0L6meK5L3L92oXnzrXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o44mOxewVlS+6N3er4Gm+YepcBfPXU/2ZsTPDw7HLUm29YiwRhQWFwH7cyv68dfIRKTPe5HVlSgXbWJmAQN4y1PeyR+lrhPYhk4iVFgG1fkf6pcaNeGmvi457n6HjJTSamWqnmNnEuQZ6qc6fM384DIXf8Hcw9Fdw4UwfyQdXVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lVmD9u0K; arc=fail smtp.client-ip=52.101.61.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lVmD9u0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FlMk5fHmoh5ZtX4gz7LBO/y5DdaNCu5Va3X03WVSOKj+cyfmE06fylWyDFZOuoZB+Afk6LCHRUckPwpej/Y4SYrUm5nr8grEEwtKNZNMYcuNPvaJEjQLtOsI6BZIJlF8glQ/EGF+pW0zf4bzV0YCpLUfWLh2oYVDg9swYW4qKEuhq0RJGoGk/hq4RXZV3cTXmxihQfLzfUm/Uw21RBnnBYurfTHAxred/lqERiGcmZXbm3vJtFrfnY2eJY6Uuj4rHGgOpk9a5xQL7Znmadhw1YIcK+Kzs7SekANfnnxf3I3XrV9GeU2QAVbD19ybypVgvm6c+/Lgcdbwkb3OleiE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9CKgb9Pr//apsapGIl8r1+CHvUqUXzCKoBTfPVjNVU=;
 b=Mrg0Ap1uGP7AUY0XV1sV/7tftn7bQ8U5+yWX2S4vSZ1o3lrgSLyy0fapfM1d+4P5co5fGQs5rGFpiJ/2hFqceLWUemktngKRiNtb9oHv4ZuW0qAlwBzpp9frRTtXV0cmLJc/kpZuBWiRINhOwCGDnNxjRHIbqqyqxlg3rAPMm5A0QKRUAS5N0vlxkJi3c2at02lesD0GmsxYA/mTo/Ap1ZWi3nIus0hnnoLUVp2EFZcUrOG+oYqNkGCPYRvY3/+C3DAoaBnKM1ESKEFr77h+gdN7wDtu3aaJLhLrf0/OhkPT2NvjHFTVEJ3hrugj5ksea0xO0GjfANRmihzq1R0zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9CKgb9Pr//apsapGIl8r1+CHvUqUXzCKoBTfPVjNVU=;
 b=lVmD9u0K2P01ptNNi9xJhjXoLorI5VV4EaGzR4mYwwsKCNqGdLqbsiZzAQUHyUb4ZNOblfdnOQtAljJoQrTwO46MHdYkYZ/kWfWORnVSj+0eqRAzqlSUM/VoXCwX/XRFn0q/06q7i7XTmNACArWjLXykfbTYkP+/c68OUKqdx/NQG22WLvnWcsvc2A6eTABSNGBFUZso+qXEB4FT/WDaDDi422Tq++XtmJ22Hm1M0QcsSZXm7Ybzgd9Sazc/k+jCxNPZpqWrhmBBcOhorjHrLr1P7njiLB608jTb6UuFE+ZS5nvaf1RVGoVnVgMIjBE+t8bvIn8DVbD8Fbvtr+cMRg==
Received: from BL1P223CA0035.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::19)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:32:49 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::6e) by BL1P223CA0035.outlook.office365.com
 (2603:10b6:208:5b6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:32:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 08:32:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Dec 2025 08:32:26 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Dec 2025 08:32:26 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V3 3/3] arm64: dts: nvidia: Add nodes for CMDQV
Date: Mon, 1 Dec 2025 16:32:19 +0000
Message-ID: <20251201163219.3237266-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251201163219.3237266-1-amhetre@nvidia.com>
References: <20251201163219.3237266-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 6905fd36-009d-4ae6-3009-08de30f7440d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hzq3AR/GgQwjq/yBWKv0pdCiLlmysBXf8pdX2u+dQHKTWTbGsNJAUFme7cLh?=
 =?us-ascii?Q?ae0qB85tphWME4fzQP9lDZAXCpUF4Omsf1wu90UL/dBNEogQV2Xd5nEzFsN+?=
 =?us-ascii?Q?4GgUDsa15chdD6Ns3o2ov4jV+RApmqqL/6wtdMv9KkGoQm7eSYZCRyprc0yJ?=
 =?us-ascii?Q?Pi8Kekeu95BpPmJhDLqCm/q1LqxUyMIxSzHGQ8CoWupqHwIS4VQ1DDcYKbxR?=
 =?us-ascii?Q?4icIo9Y4GVp664OeWk0idBdaeZ41sTanhZYrfAtFcBiGNouByZXHoZ+seGQz?=
 =?us-ascii?Q?qPGxD2ECnJx876HxWrkm1bqcUT/R6nsnUZrhrm4JaDHwXMn/KC5gm4rNyv+j?=
 =?us-ascii?Q?sCHDY7qzESLSm8rltNRZBiZwZdOQ2ktmUHcClVETJ+HxX6Zfy1RaQ/Rjc46Z?=
 =?us-ascii?Q?Q33RfoNwM6bmChuKlY3J2inLDUZ2Gi4gUYAaetMAR74yVsxsvLjxuDPpiUdh?=
 =?us-ascii?Q?fzOsSikj3/Dx+UUmMmFf1Bcd1W9gbI7nDA+ulxGw2BwHppm8NxPeg4JQHBTP?=
 =?us-ascii?Q?CN0SxhT2GDa7z/+HJFuXcCJ1HLrfEr7AoJv57BaFGlX7eUTeO6UWC/HiY57M?=
 =?us-ascii?Q?eMSUrM+Bg8csDKkEwbkXL1oGNB7SOkyyA5+WdwEoC1AHroVVC5fZiSB3lz/Q?=
 =?us-ascii?Q?g7OEEQpLhh/vy9aiE3Ds+w4nOL7ALmvLduV3o1ahUAWYRDgwahypxm6IqYLS?=
 =?us-ascii?Q?rpZi9+SjlD1tSmQPdq4CDTCksTUrUK+F1ZR6ZsHvkQDnB7kloI0Y1qgB6SaS?=
 =?us-ascii?Q?NnSorIMrEU5o0BPwlcoJLprToY5RiLZ9JGa5RQ0VXYzp8J8At+PVG4zI4/hw?=
 =?us-ascii?Q?LbjcRRw4+F2GP+GozW8fSucp3h7txEJlSreFWO8VNeQlIXZ1wCcJGgrRF+3m?=
 =?us-ascii?Q?iuPLM+72OmfK7vRN/pG637QuDB7EPFYowBBthHCpO0Yh0YcoXwaypp3+6CKD?=
 =?us-ascii?Q?w94jBI8KGwy5AOb8LwAgvQWBbZY9pVmi8wUuRhwaiRZBM9LXn67jmB5DpELY?=
 =?us-ascii?Q?wEacPlzzfTHybIeiYla2/8+KLeI8NowJNAfsBPyXPP5MpF3MTfyYmSxeRzLQ?=
 =?us-ascii?Q?M7IIlJCZ+xJdzdQ5aOMiSaQAkEM1d6/9NEmf3DB3jcILuBn/r0jifJ8bKrSU?=
 =?us-ascii?Q?pJn8WCvRHTa0AOM1blfWxgQQ8B5Edvwvp+mk45wWOvqE5poCeoGQrzsfk5Kb?=
 =?us-ascii?Q?5Opk21PpUsbBIgRGclV3FPHersJ5hfLPGHCkYPATSPoZJTHJnvd3PoINuKOb?=
 =?us-ascii?Q?MuTtE0vvetklk9sextSXhkzruEoU1P7DpovOl9QM+ndxE6L5XVWlyq36P8ge?=
 =?us-ascii?Q?JkM/bei/H5+dfdiCr+NIpBhkVW888VlppBWMcousHe6g0Kntuz3YBF4JlIrV?=
 =?us-ascii?Q?pmFi7TxWMNCaBQgx0DDYp/UEV3ITbwgnr8JAL8bpN0eVcYGHUyPz9b0ZiJW7?=
 =?us-ascii?Q?2HC2NcZ3GKNUgZ7eXVAfG4xV0P4wSHf4NV4UD2sxqrDpwNApC/MfZJ+tIct3?=
 =?us-ascii?Q?Oc9TDKCv5/ah5EGYQfrTe9qERIxyXvOughDoFIya5ZhKQ6sCiEA9vn43JDuK?=
 =?us-ascii?Q?nguja1hb4wcLUs1OaZY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:32:48.8201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6905fd36-009d-4ae6-3009-08de30f7440d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594

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
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
 2 files changed, 58 insertions(+), 5 deletions(-)

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
index f137565da804..5124715caeb3 100644
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
@@ -3370,10 +3370,19 @@ smmu1: iommu@5000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv1>;
+		};
+
+		cmdqv1: cmdqv@5200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0x5200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		smmu2: iommu@6000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x6000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
@@ -3382,6 +3391,15 @@ smmu2: iommu@6000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv2>;
+		};
+
+		cmdqv2: cmdqv@6200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0x6200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		mc: memory-controller@8020000 {
@@ -3437,7 +3455,7 @@ emc: external-memory-controller@8800000 {
 		};
 
 		smmu0: iommu@a000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0xa000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 22 IRQ_TYPE_EDGE_RISING>;
@@ -3446,10 +3464,19 @@ smmu0: iommu@a000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv0>;
+		};
+
+		cmdqv0: cmdqv@a200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0xa200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		smmu4: iommu@b000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0xb000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
@@ -3458,6 +3485,15 @@ smmu4: iommu@b000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv4>;
+		};
+
+		cmdqv4: cmdqv@b200000 {
+			compatible = "nvidia,tegra264-cmdqv";
+			status = "disabled";
+
+			reg = <0x00 0xb200000 0x0 0x830000>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		i2c14: i2c@c410000 {
@@ -3690,7 +3726,7 @@ bus@8800000000 {
 		ranges = <0x00 0x00000000 0x88 0x00000000 0x01 0x00000000>;
 
 		smmu3: iommu@6000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x6000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 226 IRQ_TYPE_EDGE_RISING>;
@@ -3699,6 +3735,15 @@ smmu3: iommu@6000000 {
 
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
 		};
 
 		hda@90b0000 {
-- 
2.25.1

