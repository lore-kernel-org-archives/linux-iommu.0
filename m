Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFB0363C64
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283403; cv=fail; b=J7oC6cvDvmNLuIG9puvvpSfFbv/JeGLQE8D7RFy8YM9bJUQu8WdLFRkef8WhprJhDO/lgZxsFvQzZrnl9hFRkslovluUhqnvcI89NxdFtQiH1n0tiPod1eAVIllYc8hq3sKt9rWTt5/cUuG+SBSKLDJQ80zc+eECJjo0WVMjjjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283403; c=relaxed/simple;
	bh=PdgNySensvmR2B/xwWqWfBhlcpOtg+SA+32ZmTh5TRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAGvmmtnZz28pqH9ZL0PfRQ8/2hpARFywnlueGOYwW3TVuGcLABA60G0yNgjhtMOhrQ4VEW7SwZ4B6hjLZh1A+juj6RcAcJdhcrwEurvO2V8SZ7E1Oz7Bs+MmWpezRURvwRnNYYd9dclufwdTZc9HRSfSeV+6ozJY0vcfa1NgB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mHx+6PpV; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mHx+6PpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPr6Q/02AmAx2nBuJPIDPeWX8+mCOimS7G1U8CmZJCsCz2j+jyma/VRHbR8zilIJoN7JjOmFuVyi3ZF5AeYoM9+4SWB427UrFqygt06H4X8bwJT7jDqOOjEU6m4FNJETQDHum0rqCR6ppdp8qGJr+5m0d0HAWIZSIrVCoOaoZABCGP+J3+uszYkR3DKJrjV1mqm4pbt0w8jARS3NfMEhPLW1/5TZ+hBT2e5hi+7vYltVLykYwjKTwWapvMzmBEXoGzbK+65/vcK6jBTkVaAAY6WyHG8L1HGEYjF+TR2AJDLSjPbxu5xcC+qfCTnRzOBLviGURHuXtIvIPBY0n8kRpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgIPS4hZLBSORntU0BGu4wXtXHJ/JnExk+2gwIUfHG8=;
 b=tk71O++4owGPBrts4hxGMyuzaY5UmK5c7Jjs/3G5jLEwq33KRVamxlSYpUyn6u+Ry3wtAgo+tLRO3p5V4+K+KQX1H8yNUPq/jAvUkIYeA1NYoyVpbWWBHeKvVufbig2LXlvF6TnQNUaTh8za/rAYTo+pRKU3XLscF8+lIGI9cTn7V9W7vVVSCZbOINOmdXx/JhmboE8omSEQU8qjF8cU0wN/O1cWVmaRxSTeqt/Znu57PGVFnzLGnMdnv7a6dOD3IBlG04jTefOVwDAxo8pNJ0vn/wUpllVhD35GnMsEoHYfN0Q8sY5J6wYJzYoG3MLLGq0Idu8r8m8iZXUlghkhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgIPS4hZLBSORntU0BGu4wXtXHJ/JnExk+2gwIUfHG8=;
 b=mHx+6PpV7+568byKbl/B57hvSXckHFTANaVmL4jO5svnRJhZlSrfvRShkKkjiUdRSbPMntb6+f/JlOE6G3CqwHVzOApRYHUd0DLv4pYLr8kvtc5RxpXIUvdJjLDTugrsS9+1XFxzjLhgMczeqMzj6ehx94WBesGVjDiUzCDnv9xHbjZmdqE/zOyrMndA3Q5nG6zcIDE0uczecw8E9gOjtn4hSHjX9KQftp9N4Pv/5jcg/bPS+UNF79PyXkcf6wwc3ixOCKXOolUCY1zRBZc0XnsgVVS949lqsXIJVsJ+jOCxy75sYj4yKaWU5A811jV+GcTk5YU48HHcQ4DlCPXC7A==
Received: from BL1PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:256::8)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 05:49:58 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::19) by BL1PR13CA0003.outlook.office365.com
 (2603:10b6:208:256::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 05:49:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 13 Jan 2026 05:49:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:49:40 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 21:49:39 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 12 Jan 2026 21:49:39 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V8 4/4] arm64: dts: nvidia: Add nodes for CMDQV
Date: Tue, 13 Jan 2026 05:49:35 +0000
Message-ID: <20260113054935.1945785-5-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB999110:EE_
X-MS-Office365-Filtering-Correlation-Id: 65593912-aae4-4b53-4ec2-08de52679580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kRTVWBKo2i2qE0hAOk/3HG7cljpMFUhvNZRZ62likMPcw+aNsUxXF8jo2JG6?=
 =?us-ascii?Q?HE5UzuaVIJsdPVT0WCHy12Ai8Rm02c6jdWm0xitetV3t5Z/4C3fokFLkeA2X?=
 =?us-ascii?Q?MhZXvngB8LBjh+FSuZE86znx6W0QteDGCA0QVIPnme9UYtAcbiSurFzv4H8m?=
 =?us-ascii?Q?BZLVYH/qeFeYVevqvTgs6YZgUc8svSNbXaDvokWQRHLVCKMpTHSyyXa+uVZW?=
 =?us-ascii?Q?8ZkPLCIOURfEhsjRra8exkvi6meWpzWS5tM5KlyLdpT3uEiGzUEQ6NNDnKOM?=
 =?us-ascii?Q?At0xHoYUbochnq0nNpZEUNyzo89fMJhcdGQwLKyWRmWd4WTF6d48Uujf0Kys?=
 =?us-ascii?Q?/C70p5JMCGyrnGR8tqB/V8vl3a6tc87tWihYSZdzep22p/8lOFhHhpHf7XsZ?=
 =?us-ascii?Q?iVeIjKvVzyiGUzw8Pghw6eYsULP7oUN2yXwSsiqvkCqLFNVcKRuYJGjE3jdK?=
 =?us-ascii?Q?h5o0KQ/zTbI4wkButey11CE87VBMoa7i9nPc7SCt+K0XRUVwBndxIMQOj1Wd?=
 =?us-ascii?Q?5v9gkdMTatQSr+rTQnO9McyiqMyDRUZerAt0CEwU7mVbBOgQmY/ntHPPyEY8?=
 =?us-ascii?Q?TDJXaKQXU8amDs9m4gc+BwnnNdM09D4COSIb9Nexb3IT3rc83Q3pHBHFHlHY?=
 =?us-ascii?Q?TMHMVAi1EBysDyAJesKjFAOMSfFZmhuRmOYf36DGlZ2fEZdg3ll6HYS1TjFZ?=
 =?us-ascii?Q?eFQuuEu8zMKFhIqT1WvOInt1wzdSnTSUDVPVEkT1xdNAVKm/YPsX0pcQKy5S?=
 =?us-ascii?Q?dxF2T01qK+YY2SqDVKlOXnpFRDW1oJPOD2VxnYQmVBjvB1o1v9cSOd9VUayQ?=
 =?us-ascii?Q?74rHabTuAO0ABg5e088qQmzWebktFJpR12RdP8jOwg+gNAjB3WyEewd86e+C?=
 =?us-ascii?Q?FenlypG8Uuv/P0+SPrXz+Z4KPi9u77p10YNAJ/2RFu1iSlsHPFjV4rtLVO5H?=
 =?us-ascii?Q?blcTF3dbpElnQz1xSmYc8tPdMYSybPpGhFw+DIa/i9eSSZsKVUKN3CYExwIt?=
 =?us-ascii?Q?UxCjYex+O4o3LJUMr+xgOP9TYoJqRzocuBA1CNKQ3adGLmbO1pMC/+6Mmyy7?=
 =?us-ascii?Q?jNV/HPxpBKGEPA/O4WW8ipz91xBwe2Q22MPJs+mY9qOgBbmP4U5I2b9+Wtf+?=
 =?us-ascii?Q?rpduAmpM7ZRNGB0Kfq8P528Rz5Xh6wOO1i0ieaaeBwBzxWKXV7aDBtmT6En0?=
 =?us-ascii?Q?kOWeiamTKE01gdQdMrMGucgjChfll4LWVZluaZpeWP5D/frjRTP3KzKHEO/v?=
 =?us-ascii?Q?v2qPVGljOBTYBLePG2za7JPUncWRJ1eS7M+J+qJQYWsKG7+FWM3SVrl9Aurv?=
 =?us-ascii?Q?n8SiNgOe0KQ92bK6YAP4n9375ASQOCUg0Y08X4UUMXRuT5K4nEfOmJoYN2RF?=
 =?us-ascii?Q?sa9J5CzeY8wYXa8RNa7evjz+arflKeunQ6F4bHxQqm5zCwXgjSWFKxsG5j69?=
 =?us-ascii?Q?FB2U63d125p6xV3LbMjLh4g2uUebBzxIn/ITDaO26tI2Bgozzv2eQR7hQVRF?=
 =?us-ascii?Q?OIGknSsQHkZ8FvoWxkXQDkMV9bbCh/LdnM0OYfakFG5QtdOy8uliywocPgEm?=
 =?us-ascii?Q?+4n5KZedMHxdF5Bj49w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:49:57.4726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65593912-aae4-4b53-4ec2-08de52679580
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Update SMMU compatible strings to use nvidia,tegra264-smmu to enable
CMDQV support. Add device tree nodes for the CMDQV hardware and enable
them on the tegra264-p3834 platform where SMMUs are enabled. Each SMMU
instance is paired with its corresponding CMDQV instance via the
nvidia,cmdqv property.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Nicolin Chen <nicolinc@nvidia.com>
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

