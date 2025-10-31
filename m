Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B46303A18
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 06:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892230; cv=fail; b=jjctJ1i3hRLI5V9dNZEnOAka6y5rLP5XzJtstylBRIMlCojpFi4Rgb7q3woE1TEr3TpeE7t6L6kpsbgCwz1i+oSR5EXxl7u+xu7donPASTmfFUYOWfyzx6aSFvob9BeqrYJd5WUsUcEbIudN0P2Pq/HR8aiSqx/VAy0/dCl1RBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892230; c=relaxed/simple;
	bh=SSbDvBBW6ZXisNzTWWLKQS48Hep8okVDgeN4fnJuY6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8PdAGTW35uVD9+BRM2HJobjKX14lAM89TlINgnG9kkguMAyqNoAAHx+/RnB5Ba00anMFbKahTcMyYj11imBrHq0M8q5eQJzgO9G5wLJiTDJknMneOCVozgBVfdeA16ekVrUW4eUzmSlcGOnORjI7uKC9bmYLTo/RiHH3Tavrv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEwsMkRZ; arc=fail smtp.client-ip=52.101.52.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEwsMkRZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ksv8qvreiZCOBXdPu00ECosl00mYhnPLtdFa2HCV4R5QV0jxGHppBLXPiXGMhbrjhFT/eCKCbjUUD6e6r+VSyYb52rqmxDQjjx7hGtGv8MDYm70fnn9QEjMmKHOdEE4otCpbCINNIFlZ8Rjom3/d2LrXbTkIXuqX8ec+tlFDvcKcJqqXQy5qZcRM+vQynkwGkzehsENnxMiW+YjYYu1XkxJ8blAGZFzpnDPEmiyuiChsE2HOHGtJyxtzhe1r+qXC93W4mauog+izA42zeNafK/c6jQkTvAQwGH8QrnHRHmTJOqBdLAqD776M88fhExJSNsb2A56JjKn9V0dF5VJGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYvj0ypeNxcEODqdKVzZAsLDj14ePhydmCi7JCF5YvY=;
 b=XWKcwlz5913hwy1aO/Vu5eI+fdZPoLYBtfk9o1XOh0vy2DmqScrsyU288dHH+L7n/cU+8qAq5sO4VVLGtYYsLzF4pEzL9QYa/T7AuLJmig5V3GLyKo7q9i9qij+PCdineKQn8uOztazGi+zpPOBWTynwEfnMBAqdy121OvaHgYAAJDhbsmULvKDYXSphWNjZSMcAYl5OcHdHf2jX184K8Nf8DV+odMkCRm04A219JvmQfkctKxmqKuB0uaXBdvROqlf8LDM8EcPFcQ09I1Ogx/wvjyr+jKyThCpVld0TWA5XKKNeq3SVlxEiyWOpJnVHhLBX724fgozStbu41BkNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYvj0ypeNxcEODqdKVzZAsLDj14ePhydmCi7JCF5YvY=;
 b=oEwsMkRZE7bNBbHNGsKSyEV6tQBR9T11PFfMyKx1bjILvGv904UoYGrvOVrPsZe0V23p2NO0L0E2OjdbRzKmhw1Y6q6SRwIy3caSagZgelm8Ssa02V5Xgu4fXLEg0KyZJm22HuKXnl92agreglZnPFmH2wG2+7bXswpOzNJuUyyPc9qxT9vdFEe3FvBesTrenH0bZwA3geUP5hO+C7StgV3cI9oc8RiWn7etDq6kzqmO1SQIUU2p0rkhs1UvzOgbwN+1ZdzHbQsJ3D1euooVABHXI9zDY4XFGXEUGj3OCA3HW/dbRpj2cwe7o01K/G+P3b9HZRu2hsQ6waHb0DD4sg==
Received: from BN0PR04CA0134.namprd04.prod.outlook.com (2603:10b6:408:ed::19)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 06:30:25 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::fe) by BN0PR04CA0134.outlook.office365.com
 (2603:10b6:408:ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 06:30:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 06:30:24 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 23:30:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:30:05 -0700
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
Subject: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Fri, 31 Oct 2025 06:29:58 +0000
Message-ID: <20251031062959.1521704-3-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: b612642d-25ec-4447-fb4b-08de1846f96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BpIayLrNrgqJ3w2hBnpZDBXdV2/YPjsjIR1VG2ITlE68BpOM+yXGn+L0C982?=
 =?us-ascii?Q?FTRMPEltioZrcnnEsy6CDJhbR6z/vZJDR7jNTSbZb+WnD2AqTneTrfD1Nnvl?=
 =?us-ascii?Q?mGLAKPs8hnoQGG93Zn36+f8ysw1o6inYks2oMqt0+VLEfxjgUFGSqwFu8CeH?=
 =?us-ascii?Q?Y/O2kFFSbpiINyv/z2wa4FR/KAaPUrEieq/J3umRTVakQtQW0KiD4P0r5xcj?=
 =?us-ascii?Q?QpWJdbjrYHqlP5BrZ78ViRNzdW4PPcZsp5Sb99DWn+fMbq0viWlgAiTLZU/+?=
 =?us-ascii?Q?5UMpNweJoJP6UBigGFEqVS053RVgpRO7V7wUGhjeloo6f18l+Xywugm9pD0k?=
 =?us-ascii?Q?4H3JN+RdnSP7ATZzY1Tgms1zK6yspgVCGGVUvGFMvK9XPOSoxlUUxykkCQDZ?=
 =?us-ascii?Q?qtZH9jIK98ElVJhqocHPytZ6dzzpdDHg8Yj/dUIZEnj0soYYVvl+FXlehDOW?=
 =?us-ascii?Q?DkPD/0pd0Ie1thpniJyLFVpUy7fo1Qf1cE/AiGkRbi9kxJORPmHFDCk+tHYM?=
 =?us-ascii?Q?mhe4o+CbfDWnXcjSYSriMC21Y5r5XgQvEEW4zpcnJefWgKWURUh2axBA9qgy?=
 =?us-ascii?Q?iAKwMZpexcgKO7SEaSHURc/zOMSQRfbENBImfMcR/Zl+MuGfXDLUUfkLED5i?=
 =?us-ascii?Q?WVh4jyrTSwPbqKOgShXnFEbYm6BDVnowBFEb3jXIZsC1AmSmT6bOMDb4b2RE?=
 =?us-ascii?Q?0hk8o2GzkplMpo5V25JuBmNv8Wl6lEiZGyzRWtxlr41WeMVzg2mbxWASYIUo?=
 =?us-ascii?Q?wJYuevU4AM/CZcqcxexedez95B8bkAccYS++AdF/FrfoNhixrct3dsvnBQ4b?=
 =?us-ascii?Q?U2rSVcHpwxCZ0Iyf6BB/O1fwNl86rWtNZtf8yVVh0xX7UA0TvlfM8RpWZjre?=
 =?us-ascii?Q?azGhNsyTIjoSeSNEQF/6t+OBO3xAPkGo/XVBhC041XW0z4qbH+QSZjHRAnBY?=
 =?us-ascii?Q?MGjksCp+O7yA+uU7PJSzCIe3bPH0vKr9kCzrjqKt4yyE+m4dVVyyRvmbQh8C?=
 =?us-ascii?Q?/d8BmGjXxzb9QjyUQg5Va3/LcXDdIB34RUitdePoc0JV4XPr7xVlUsL3jVRt?=
 =?us-ascii?Q?iY1ed8JoOlixQbVBdQv42eExg7pfnAAlOxONCW/s/70poOFi54lIwCYkcWMr?=
 =?us-ascii?Q?D/CvJAgcw7YEV3/MOVehm72zbNu+ryUvIyjEPlhLnR2ZtkXaqiC4DP5BbV1F?=
 =?us-ascii?Q?lRqnbMLH68RlHsGM0JMp2OzWm7fldiwtvEXfFvMvN+r/kWM7iICJCjNTIxwL?=
 =?us-ascii?Q?Txqv3Ei0RS7b7YveAcdCWPDIjD8pchfCaXSS1Aadht8wGBFdRf+tAuKDn42q?=
 =?us-ascii?Q?V512rHE6AHeddcunW8V5YU+F0gpe4YjNGQE52a3NH05JzPwi+8PQBeD2u0sN?=
 =?us-ascii?Q?wYrnj4fIH0RYe5DLIJlKo6y64vgx3vUogBFyb5n+RykdpHCGgbA9K26zE/ob?=
 =?us-ascii?Q?Kl+v/yNWtVDyP9pDHkOGgQBqF95bgMTeM66UJ94aZyzzQr2s48zhW5s7AfLE?=
 =?us-ascii?Q?NKeg3TcR70UIrs/5bL3wFWy9qas4nlpVY7IsTqR8eryMvebgIn2Enl3oOByP?=
 =?us-ascii?Q?eAI/VeAbRle6kSjWNZ+QdYY/vnyFELk9+/9uplPy?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 06:30:24.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b612642d-25ec-4447-fb4b-08de1846f96a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Add a new device tree binding document for nvidia,tegra264-cmdqv.

Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
property. This property is a phandle to the CMDQV device node, allowing
the SMMU driver to associate with its corresponding CMDQV instance.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 +++++++++++++++++++
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..edc0c20a0c80 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -58,6 +58,15 @@ properties:
 
   msi-parent: true
 
+  nvidia,cmdqv:
+    description: |
+      A phandle to its pairing CMDQV extension for an implementation on NVIDIA
+      Tegra SoC.
+
+      If this property is absent, CMDQ-Virtualization won't be used and SMMU
+      will only use its own CMDQ.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
   hisilicon,broken-prefetch-cmd:
     type: boolean
     description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
@@ -92,4 +101,5 @@ examples:
             dma-coherent;
             #iommu-cells = <1>;
             msi-parent = <&its 0xff0000>;
+            nvidia,cmdqv = <&cmdqv>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
new file mode 100644
index 000000000000..f22c370278a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra264 CMDQV
+description: |
+  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
+  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
+
+maintainers:
+  - NVIDIA Corporation <linux-tegra@nvidia.com>
+
+properties:
+  compatible:
+    const: nvidia,tegra264-cmdqv
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: cmdqv
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cmdqv: cmdqv@8105200000 {
+        compatible = "nvidia,tegra264-cmdqv";
+        reg = <0x81 0x05200000 0x0 0x00830000>;
+        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "cmdqv";
+    };
-- 
2.25.1

