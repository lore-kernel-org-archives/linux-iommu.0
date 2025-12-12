Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE32F6921
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519709; cv=fail; b=cVYMffEUA/lAOH2F8OO7osXP2IS+9fS8HGMO7Qqw70I02yerV1kRhXNXJFG+VjU2X/h7Y8/i/lZLKehiUtbkqnETQPgFtzzKJRu10FxywHMrb75BoBBJCTuxPnhFXNAteM99DDdcywEGRNBpUidLQbpMKZpOQ/SsdqwBX8vUMrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519709; c=relaxed/simple;
	bh=mySVPBxEVT9zPWTS/gxmd+V75XGfQq2Pe2MufrRpQMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGjVfmTV3XNsMQG8mcHjN2wkOrhWEi5TEw6G30wjV1TFUCCnIQUBLupX1zx3vYtMxl7cqWfYg2fHkIfkX2Ne3D+RNPrTyCagIyd/rxXcrixFyBlWFlXVr117INzjUs1zJ7+I5iVlKF/RwnL0uDZu+fxW+FfrPU4IsINHRZxmvEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hnqvnOrg; arc=fail smtp.client-ip=52.101.43.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hnqvnOrg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SuhPXyFmtFbmnjRfqXS0bOIrsNqylBqvUEGziOWxq+1jAV/5q18zm3PLuwPRT1lWueF9Dsi6vSjWj7TYdrfMH95slxPcGjiamBFaR7xujW9OTsL3vTua3ZKSDpBNOwy4/Dkmw4aK9vmbYqxwKquVuCfqy/5c8cjvQcXutNOoVOP8+7eCQF2yXxBpcwwtB5pSvPdO4RYKK/FiZijVUU8p4bIIvekpau+Vv7LKzLK0WtMAZj4ATXd3WeXe8BhbOyXAz6+z+HNxCKE+XzN1q0uIgeW+ebc8YBD0ItTKCnBE2JBeqVJjGZE8tiqaG+eLC+XhuGQUKaCoXs1EBRbowRIacg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5C7BbNbxkCycrp6WS3b6f8CAENtqWpmuc1Dj+Qmq5A=;
 b=HPDCNJ5619SOs8trSPlkIpAVGcc0GCl3fy0I4XtswL6j5ykcefXT2d4Z9bIfKpBZdaBbCrw81c0v1vMUcaPjFnk8QgKExu04SOZPwUTD+moVy+VKLESFYW8/8kkupjHhGkyHwvKed1TPg5Dnp1NEeYdf2tNaGnRjlsSKsVxVzl1dGq6Zro/4p9/V7Mk8YPdp6lIR1SilBwnN17Mr+XcYonE+lSRu7NzW4xGhtnv4VWndDvcouIvU4mVImdYwHbxnrhsGcuflQS2ZVDOxwk5Qb+BnRykY/0GrCenNKRXgjr7MwIk2iggFZu1XaXI3wSl7LOiEJYznD+MBuHPxtOmcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5C7BbNbxkCycrp6WS3b6f8CAENtqWpmuc1Dj+Qmq5A=;
 b=hnqvnOrgUNCCfIxLEAUvLBap0X2gY6ZM4Sl/I9BAIIMd8E9kk0KfNE+wH+SgdjfnfmdPWUctgq6X6PayjlxBGWchXmCh97Pnj1epqaoPM8JLOricbhJ4OT+zfTixFEAkT7LRykYtjITE0JAsgS8dCCTVdcBRPFJ3DAEwN4pk5j+Vzu1PtEenXwSjdJsdlo18/9vG8vSMNjF2PRl6P+1XJmdvCiVr6fZ1OAVgKhnloIxP//S9T2qJgdXZR+cJZrJU3mHeqB2JScAAbbfDX1cVKPmZ2W3DfKzBBmNIiVIgqF7zhykEIOtpC9BsXLXHRiY5VbzyQUXq0qnEXwTaLurihQ==
Received: from BYAPR06CA0014.namprd06.prod.outlook.com (2603:10b6:a03:d4::27)
 by IA1PR12MB6577.namprd12.prod.outlook.com (2603:10b6:208:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 06:08:23 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ad) by BYAPR06CA0014.outlook.office365.com
 (2603:10b6:a03:d4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 06:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 06:08:22 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:08 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:07 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 11 Dec 2025 22:08:07 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V6 4/4] arm64: dts: nvidia: Add nodes for CMDQV
Date: Fri, 12 Dec 2025 06:08:03 +0000
Message-ID: <20251212060803.1712637-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251212060803.1712637-1-amhetre@nvidia.com>
References: <20251212060803.1712637-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c66b27b-f7d0-4671-b851-08de3944db05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zv0cOz4xopBRB8zGLCIiANBqx2ZvcAaXaZVJmZo9wo4HxId9Tf2neaxv5+nZ?=
 =?us-ascii?Q?l9pp0zuEStA5IO7TVxcb+RB8FfAaGPVGMXy9CYVZAxdsVTXLYBjKTfpwsTQF?=
 =?us-ascii?Q?doDDbss01Y0eI7yQdMAw1Y/wOMKaXzrfF82DV2HpSIdersffB46OaVuUZA78?=
 =?us-ascii?Q?wZflEyF2W4oguH2IaENJl/lHXPpMvemQCm1f9eJtIksjjfh45CZCE71OsPkD?=
 =?us-ascii?Q?Rdum6G0jsiJvm+iCOElPgxvxYRGYE9Uii2keLDBDXzBb15pcjVtSW400KLyL?=
 =?us-ascii?Q?afDsFANYeyurN82Wh1RX7yS5l2tZFzOyCbmOaHJ29PLlIchj4eJWwGmCCgKP?=
 =?us-ascii?Q?lxmD2t2dHCFExd6cixITx7wtLjAd2wOAZFs4r1RSVXRbdxGJvxCTPafFtn9W?=
 =?us-ascii?Q?l3LiXbqmDh4AX/N/HutVCIPGOAWnsREzzb0B18kkDSyr5J0AaztWZlrmeAkK?=
 =?us-ascii?Q?aLVuBi8jmrf+Zm5GmPL1XcHYuDlYzyJIVlnSKJTuolj8mw6ES5LYdwaiInQA?=
 =?us-ascii?Q?P6eIekxrOOUuY3Z60uo+Z62WkUn+qbE4yv3EO9oQO+ea9lFSe80kJz0njP18?=
 =?us-ascii?Q?jnmXyAtKoUi1Fozy1tKz874cjZj1JoNOKaTDc/RwGumF7ZJKP6orbY18YAyM?=
 =?us-ascii?Q?g2TEHT9PwnEZ0rIYHEGJqkxtli8bIOd/K17q3MRsPqUiA+D3GnV5f+eJ+agu?=
 =?us-ascii?Q?lqyDqK44Bj4QXyOpX3GF4Rp+8jaMgt8acU3yCluC7JoshYHGYdjzaaqak8bI?=
 =?us-ascii?Q?h0Q0yi0aYMUWxvrNn28t98zwSJkEstuHCiA9Lu8M658Zsys374Ubuy2v0aXp?=
 =?us-ascii?Q?DO7EseU5q7bDei+3NXB+csK5PrjZT+df3eTpzrSQyc4bLU0zlk5x9+4nmtPK?=
 =?us-ascii?Q?Lfirv+GgJzvrcPkLtSLapfsqlqU7ZATIAiFRl00UVTvdITvmcpFcDZLOTcQz?=
 =?us-ascii?Q?qXyZCYDFeEKRhL2ylj6ebAF0OurzsF2m9LKgmL8crImPc3arRXf097d9ME2X?=
 =?us-ascii?Q?vT6hdtryMwiu7JrgNH//FBXJllSEIPN90fIRMGpZ4U5wmBLsNbi2F0NthWRR?=
 =?us-ascii?Q?SQ2PtwWzy66nJUX/gOqkHzztfrxE1iYMN4hxTcXWVeoopFmAzHdF6sOfzNoT?=
 =?us-ascii?Q?13EPedAgqSHqTsJio8LYSIVID+QkHx61p1mS6joXe3kDAEtOMlYisHcmdYPy?=
 =?us-ascii?Q?FuP578AcbkphsGW9nCYjvZ4zoJpkXewAVmgUpYHL+wGA6UlOHR7rDjgK2ywq?=
 =?us-ascii?Q?ItxwSWcEVK+VcIDo2vUv8KoObqzqOkc7ctYIxiGXyUecRYV2uPrXKbevbN17?=
 =?us-ascii?Q?VI3R6MnnDrSbEi67vlfSzS5Ff9XoB7mTBeJPMO2cGSvGQb07IY79iEyesTOd?=
 =?us-ascii?Q?RMtY2BbfeSdjjo9CfAsoFd/ZFu4K0UKAxhHTMCg6jF/bi1lrWaKfi9Hk9boE?=
 =?us-ascii?Q?WvH9fwaipT+mkxu9V6MkVrmAgBBw8ph5AbI7IsBMrBHcytIYPzqtVmKx9taU?=
 =?us-ascii?Q?BkOO7yzvEpZBnHalfW59G44qvYV9KLSL2GitLL//PLGupmeYeJDWwpNcDBp7?=
 =?us-ascii?Q?lcUggDua+mUz2i0wC80=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:08:22.7013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c66b27b-f7d0-4671-b851-08de3944db05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6577

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

