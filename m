Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0F2F28EF
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055050; cv=fail; b=pZ+9PI4WtWpq8Bs8jkWJPGSjxJ2KbNvJ8Ay0Ghz00qWpX7HhSadg0Uap3Vd1RGs5yeKMwDT2I9GT3qvP1R53PYDOcTfulD8tjQWZ/IxD+EOWr3HIajTjpHIQkijXblFmjPK1F9zUfpoVuCN3OSJ3IwfIoag0RumCbgJEKXZXYZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055050; c=relaxed/simple;
	bh=TNEabo9eBLwJpVU9br2V+C+6ChPphNHATiCxP527MsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2JJWUSbAI+/SfoNpVsJHZWSHbHA8QdhMMGN/D9Tqx8gv0Zia3pIkTExff3X/c0H/l/aXe58HZjFxF0c+006PKsZLayMDJijzm5WWF6oV6MWbPYeOGyVmzz+Bvg6oZdr8Oi16Jsvz8DO9QpYimiiKtChLDAYkuWCMohykssxe7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mc30t7uk; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mc30t7uk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkaR+gnVQzO6x7zIuThnfmuhVfZ8Rkiiq7nmKVBSvvgE+JSFkufSFCkWB8SZQgXbkvt+W7XqiqLJ/9QUmUlQAPe2wPeQ3R1x3/q7Zc+Y7vS3jiqj+73erJEs++FYi9njxROukF/tEN4talSz2KIj9GdK6A6MKdLSLgvFl81VOHE63t2ZSrUUCeY/oV+pvZ//x48y7Jw7Sw9s+vha/EU5dKaT+ZG7oyEiNqDupWihTtxw8R7Na5gZKILMHt2gCmXIISfID3fTxgGllUspAfB+Ci7FFQTx897RHAcJbvXclFII/3XgNS7iXMujRyu68m18IWb4L+p56PIX60eqLjZAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCDN9jcA+IKwFxXNTOgfZ8iwWM544e/3Qs/XYCvjDPU=;
 b=D9RbYPBeZ3NPZ07pjrdLYF/cC9+CG8vQmY9OYSJH3h7Ta06a/pF/V8OuuQdwgrZee7MUImN+65NdCLwct86ds9lnlA5FoSLI34RyhjypC8ltWsq+5HnIqsXiBnr/7RG0tOOA1V5dyna6S6h8cKFiFzobGndNLwcI25/CBwvQ20+oUYdmEMVn+Ihzu4SgTdi5zrQvQhSMsuugSJHev19FPciDVP7cD925GTSe3xtjvFLGpAVBhE64NUOeX5yEqszZ6D5jPg2YDl3GMPh6J90e94GjjQxGWXV6k3tZkNERchfPAJSIBpk0Bm0qTW5F0GJG+39Qjh2u/0BSBCJZL0CGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCDN9jcA+IKwFxXNTOgfZ8iwWM544e/3Qs/XYCvjDPU=;
 b=mc30t7ukEhM0IskQzo4LgejemBiF91x5ug3zeCL5CcKh4Ovih57bvZxtt1+6bKwqxb3o/MDnO/0nGHmcLMTo/6GG6pMnBvYRqY1Mt5WkTG9+9e09VVIBqls9lAWppbpmlqmpv/S7krIt5pfSVvFhLPG51ASip4XmcygMnBTKKRo8SKPqNJeYr6HUabTVXD5cK5t9nuLmi6VChhytRW33dSRPyvuuPWLb7dJX/dZcmCAVX9vxwKiG+elkDxGNnd+dNBU7H8K6R56wx6VZ4Fj5HmTAt21DSlBA3idJU9CadhFIkKVI580kKbZMWGgspkKEqZ5JKAt+O/Ix9flZVGMzfw==
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:17:22 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::86) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 07:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 07:17:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:17:13 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 23:17:12 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 24 Nov 2025 23:17:12 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 3/3] arm64: dts: nvidia: Add nodes for CMDQV
Date: Tue, 25 Nov 2025 07:16:59 +0000
Message-ID: <20251125071659.3048659-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251125071659.3048659-1-amhetre@nvidia.com>
References: <20251125071659.3048659-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: eeb6afa2-25eb-4f90-6e73-08de2bf2ad43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hI7gB9/EqwKV9AAavFiaz4xW3+iNWgOOZSjVTff596IGsh/Xjs3rIwzcst/a?=
 =?us-ascii?Q?BEVPkViu8qtDE+09Zpw/FXz/3tb7VACsZRBFTCF+AMfURRgbqSdbNYpGQvDl?=
 =?us-ascii?Q?/4llM/RJyi/SFrE0KxeHXPcZAOOOqv0hpa+LUvOC1l9+d2gYaWyB8ZIfn+uf?=
 =?us-ascii?Q?XOVIz82HjNuCaGfr9rCEdZzhr1kI7lYucBoR0pLcmNRKhKvUTGwU5WBItC9n?=
 =?us-ascii?Q?zB+lwFI/E6UrDVRbIYWQ3ChiUwqGG/WaSADM8qqMa6fyWxBi9Sru4CzledyI?=
 =?us-ascii?Q?mCAmxaBNCFQrxplIq2z/YnHXefHMKCjRbwgw8k8wlGNh+Rh67rhb6CDR2m67?=
 =?us-ascii?Q?4FIu0HNicP+1U4v5Om42CMhnAi8jPskQ9raI1y7M0XuT2rrLY4nEBW/73iHP?=
 =?us-ascii?Q?47BDZSLx+Q4NzZClyDZ7wX39Hqy4Th+voPcEsRhtIiXW7jhC0kssX5XMb5tA?=
 =?us-ascii?Q?hqV145mtNtVCXTArsJGxWGFEQ8xZzpC6Uof8sjNPGg9EvKP1Gg7/Mk5BN9sE?=
 =?us-ascii?Q?+Gl5t4XBFTnagD0XRSxyJr6Og9dZQJG5sDcVhaxJtmOt2YpAhRDG7XH+GKBL?=
 =?us-ascii?Q?9eNJm9pP/vxwoJ++ehLv1/Z0Eg7GjkMLpviyvHSJDZZxaklEY1vDlsjt2I7N?=
 =?us-ascii?Q?wthfuM3t0xFkAaSBhUCdMszNXB5jM0UtWwjqIH63Eb1WahuWc1klyBodnBc6?=
 =?us-ascii?Q?OXnk4hcq8jnvIH6/ZqjG5WTBAciTiQ2kpkmrFDjrIeSNhGNwDe6iY7Lj/7k2?=
 =?us-ascii?Q?7Iynxk4hdGb1dVRA3Kdbbh7idKksMABp/g9lKfkXx7UVNi8msdSZLfP09Mj2?=
 =?us-ascii?Q?kNso17OxmSq+kC7k/S5mvt0iQAp5yHjvSSCYpr+Uk8rRGxMjp64hrtdVy+IA?=
 =?us-ascii?Q?K4kVrl2ZPCwrH0OTFoWvcsTOxzeR0UgVdO/Y4J6nVvhDoBe/9isomY9K13eD?=
 =?us-ascii?Q?GSf9erJ2Lw0H/4A5VOYRnC9GZ7NaloGWX9RxhCIfdJelgtcq/KAKyTZhNByJ?=
 =?us-ascii?Q?djPduFCAbACLScRApJJoHXdS+iU+R11dmDY2RqR4zLrkwMZGFqbNqquzhlQl?=
 =?us-ascii?Q?2fivntafK+wZzWuZ+bfYeh+FzyijBAew0ns5IKnTNlZcLIFpdlyywfLyDWlF?=
 =?us-ascii?Q?b5X2aXRqNcpBAVnQL+F9e3s6qVZOqv4qB6cl5mjB8HcbAkuuOD+w1H1CMq/c?=
 =?us-ascii?Q?EbFs8xia2eo+fSjACtQcoBDRd/Obv6M72dGAi9/M2muHgcchfeAWskbBRXkT?=
 =?us-ascii?Q?1E+/FwkkOV8fn1wfPMg/wVjsnMeyxBkjNVWdTA6zPWDkAgNaR1YTGE6uFDtA?=
 =?us-ascii?Q?/QQrO+8n9DjiZuP4oONtLop4X5Oj3mZGWdPgD1rBm457F61R/fCHWLT1ReJA?=
 =?us-ascii?Q?I7x6ID1k0bgnG+5sFkklIIfqyPV9yhq4Oz+yikN7cOjxn3wZ5VyL1whhywxp?=
 =?us-ascii?Q?iv/TZ1VCvjpGRzD+kEGGtQa7X0rLvI1K1yDNrsqtbW7qTuzwEZAFDgo4F37I?=
 =?us-ascii?Q?o48wKSOdAwTqU7qUphUNmdw56D3uihGpW/snawVZjknepUgrP/mtAtZ+DFUj?=
 =?us-ascii?Q?rLCe11aAn2Bc6m/pygI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:17:21.9918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb6afa2-25eb-4f90-6e73-08de2bf2ad43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

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
index f137565da804..d8287b95221e 100644
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
@@ -3370,10 +3370,11 @@ smmu1: iommu@5000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv1>;
 		};
 
 		smmu2: iommu@6000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0x6000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 1 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 2 IRQ_TYPE_EDGE_RISING>;
@@ -3382,6 +3383,23 @@ smmu2: iommu@6000000 {
 
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
@@ -3446,10 +3464,11 @@ smmu0: iommu@a000000 {
 
 			#iommu-cells = <1>;
 			dma-coherent;
+			nvidia,cmdqv = <&cmdqv0>;
 		};
 
 		smmu4: iommu@b000000 {
-			compatible = "arm,smmu-v3";
+			compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
 			reg = <0x00 0xb000000 0x0 0x200000>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 31 IRQ_TYPE_EDGE_RISING>;
@@ -3458,6 +3477,23 @@ smmu4: iommu@b000000 {
 
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

