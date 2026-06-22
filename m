Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4E35F5ED
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782111278; cv=fail; b=Lqba9wvO2LOmTTF3KfRg4AWSiy6WbdewheGbLyP3xmqa29VeVcxHar7+ac86bmmHAFEsEi925sC+DReZ4gRbxcCFu+S9Hch9dksKuNO0CujtaKxIM3bbfuHhvBuE+GxrmudawpIpo7Dn2T+m/YgoHb5thvjunBRIzSvXiqCNB9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782111278; c=relaxed/simple;
	bh=e/FTIpf5qnyDo9XuUKQ1AwBzyAnuAEhk70EznK6AJfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZpOGfTHGL/7svL4SxrtQ0/ouLSobkXUpwQze9cXIIyCDLz6M0OzTvffazF0O5hYsH4HKWlW0Gr9JkfepvSSaspkyVilTM8VJHq3IruzzKktqHlUl84X9XdwNmTCyUfl84D63Y9sQ5nS5/9L+LzcOHtKoI87dN5d2tCvh2EcmBW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c4O2oFtw; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c4O2oFtw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Big6ykyyZTygnulTWFwy51mPxSUqtSRGLu7gSdvJ7Vqzl2AsKoHmUWCSjTJ9MeKzsdd4xpzzhp+rWgwBmVls6QNUGTXZhKR2Q79+1AQsPIvchdndzeVhI8eZv3jfcuBCV20OXnAu39f15WQO3Vc2MOnjxS5k8QaD3gaC+JHzdexnSDH95HFxA3Fiok6hI/avDUqjwqbTAdCdiL9x8oii5fs0rqz4ZzCsH9sWI56g50MX8ofw3OTBAJpLt7XEDOZ3MGr5PQ63Ll21mrX70mxUlQOszwRG5u9Ch/RL/zm971WXtnazpsNdJbwiEiU2VLi2aKS3rpjFELmWCEqrbhlIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGY5I4Yc1KkozFndrOHUtzWZTziM2+pqLOQa66QkBuQ=;
 b=jke5Is2qS4nE4akqJd64tPIOs6InSFdq5DvoTVj/hqGU53X05ezH46WYbVTk/Aev2haXQlF6ByJM7QKpjP7wI2FPaFPg0ZUBUdiXBPfqP5aWOzFBXQ2HdZyYkyjT6y4BkzCqDBgzf0uje5E5QTo00ZwZbYB5sdHSWt99Q822JwsJZdEyjMFtNMxDZ2JBFcAf/kQ230opmTyXAhoDVCwuehvjqb3qJIpiVbvVdGo4y9irMsxY3Q+F0F8aK1vJSl+IjkaImqYOsqSmSCZr9T9/PqMXQR0tx46OccQDMBk7nQ4FUhxS3VuJAWFar/EZDbRbpRn70kEhFlumq4ad6z9Nzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGY5I4Yc1KkozFndrOHUtzWZTziM2+pqLOQa66QkBuQ=;
 b=c4O2oFtwnEpCXe+Mzgsdsr+nCjT676XIu1H1TUx+RJWgz9an/cQR9MVOWbDQ/twIf4xM/qCTAZkNc+AIGyJtk/RlYTIFq5Uvp2ePrR8+ScxB/ml4Qklo/Jyz8qCVsw4U3hZQ8jyDac96T2T3khyYt69jxEfRnHT/O6mkr4GsV6wAi0+DZIpFNvqhUpS6+Ea5pSokPqsISSMhZhEpJ4nK9ZcRujIy+esq1ObKlpRqScFEdTAO2jYexWjxFPHlmGLzrVL05P/VWOhK8dOpt45Qs5edIj3+QbEO/IXHhz9XfbMy8+mzpCJgHW9Tvunne7aE3LrWRueE3k43cVuNBhQFFA==
Received: from CH2PR05CA0066.namprd05.prod.outlook.com (2603:10b6:610:38::43)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Mon, 22 Jun
 2026 06:54:32 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::53) by CH2PR05CA0066.outlook.office365.com
 (2603:10b6:610:38::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Mon,
 22 Jun 2026 06:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 06:54:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 21 Jun
 2026 23:54:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 21 Jun 2026 23:54:13 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 21 Jun 2026 23:54:13 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<jonathanh@nvidia.com>, <thierry.reding@kernel.org>, <nicolinc@nvidia.com>
CC: <iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 2/2] arm64: tegra: Fix CMDQV interrupt type on Tegra264
Date: Mon, 22 Jun 2026 06:54:10 +0000
Message-ID: <20260622065410.2780215-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260622065410.2780215-1-amhetre@nvidia.com>
References: <20260622065410.2780215-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bfcc9c6-fe01-4807-6585-08ded02b1c95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4gekeRyyfpp5bVJ4ldowNLSMRl3PP09QUGOe539yxq8XutnxAIbjSEL2VenSJVvt/wN/EayuHtmSP3w38WV+2QGOwJxl/WHAvtA5nwqBIYrNx5wmdyEs6bt/UE0qQcJdwfa4HAell4FfxAe92Zg48cNOxO/giCMiNfE2BjZaTIdqeMbZsZS5Aswg71C7WVo/JcG3m8goxFRSSsaIR83+J8Ezkz6rRHjW5semvOLPxDRAy7HPEqTi032qfDh68IUlWzcWzY9DhAixF8n9DAMRPhYG+SBP6EuxgEFQxCYetnupV3/1ieLN3+UNJkQiMb0hKg59ikDNDjDNvwK4ZlGt4cdomeHHmazizpLBLzv/W3eezF+mAHoHYZSfefGyunpJfsxvOu4RGr3yss1D15HKX18hXhZVSPdGCa/SVr+KBTYpt/RmfjUNTRRfDcP8PU4yXjfk5gvnPtj080QIuadXbwmePyQlI8GyrTUKYqW7BthzYsFOj3UU7lscy3Q+qi1EObQlcafegERDgl+nQcjJMpn81Aibpbd50qH+GNenvEiAXw7rh/FCT2r5zybrYtt8a3r3706Pqaibrpwi+kYFsru+o7971l8mvDKo8nYkXLG2yUmZ4qtONopasVzvZiY3yG8PJhGYTQQM9xQHJLhfytphcTy3zIhoZ4fe5b+DBeLtj1pgSS+Y1Zxl74r3DRfg/JYo5XO3m4ZicCzY6v1k6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wO0hofs3+VfNOjg1a2W8/T+fU7kOSzE+ndcAMzqqN9XquVGKD/HYFEmyc6zGdeWHFemEHbeUAs1KMPY23KOhAy0eD7iEabkTtfp0i1lz1iM1JDEXreDfZgHOwtiwHgyj+A1Uyy4FcqRRatr9b5Atj6/XHDnptbGVWbE1R01irUj4ofdZmzNc5vydNoQqkAbZCqOEIKeLJkpE2AOWP3X7twnuT+ii2nj5pnTk51yhXI29scSzzIGgL0QfXuEF0MjvMehNAfAgZZqBfOHZq3L+e0OqN/uSpoAsYlgVHGknejRh6TIuJii246bvf8rd5KSU+G1WXm/eSEFUMKmPIcLLy59scRLhBLA9NEj3XK5RZJmYlGNDS//nuC10c5WKXvdDtNNRTYboaWY8425wON8uDlQoOX6hJOi3+gmdfUWuLJcQbUwEV6+V2lz6KoW6Drjf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 06:54:31.3690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfcc9c6-fe01-4807-6585-08ded02b1c95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082

The CMDQV interrupts on Tegra264 are described as level-triggered, but
per the hardware interrupt documentation these interrupts are actually
edge-triggered.

Correct the interrupt type for all CMDQV nodes from IRQ_TYPE_LEVEL_HIGH
to IRQ_TYPE_EDGE_RISING.

Fixes: fe57d0ac4835 ("arm64: tegra: Add nodes for CMDQV")
Reported-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 2d8e7e37830f..ff9c0476e924 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3393,7 +3393,7 @@ smmu1: iommu@5000000 {
 		cmdqv1: cmdqv@5200000 {
 			compatible = "nvidia,tegra264-cmdqv";
 			reg = <0x00 0x5200000 0x0 0x830000>;
-			interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 19 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
@@ -3413,7 +3413,7 @@ smmu2: iommu@6000000 {
 		cmdqv2: cmdqv@6200000 {
 			compatible = "nvidia,tegra264-cmdqv";
 			reg = <0x00 0x6200000 0x0 0x830000>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
@@ -3486,7 +3486,7 @@ smmu0: iommu@a000000 {
 		cmdqv0: cmdqv@a200000 {
 			compatible = "nvidia,tegra264-cmdqv";
 			reg = <0x00 0xa200000 0x0 0x830000>;
-			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 28 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
@@ -3506,7 +3506,7 @@ smmu4: iommu@b000000 {
 		cmdqv4: cmdqv@b200000 {
 			compatible = "nvidia,tegra264-cmdqv";
 			reg = <0x00 0xb200000 0x0 0x830000>;
-			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 37 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
@@ -3831,7 +3831,7 @@ smmu3: iommu@6000000 {
 		cmdqv3: cmdqv@6200000 {
 			compatible = "nvidia,tegra264-cmdqv";
 			reg = <0x00 0x6200000 0x0 0x830000>;
-			interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
-- 
2.50.1

