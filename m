Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011038.outbound.protection.outlook.com [52.101.52.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4D2FF164
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 06:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781328; cv=fail; b=a179QZGrk3Gem+Y9LGGy8mg/BSqORKaBKCsc+my2+SQ3gm7ZIJK8hwFpLy1pDZu6+v0y2X0tctgGsEX+6Uf0+xVqg3fkgYzcWYQqCMpQ+fahDcgkgfpUZa73vm6nCgfS0SWN4PWfOq0ag85Mfoomw6lKIkuFEwmQXZD4m4zwlU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781328; c=relaxed/simple;
	bh=l+B8Hlnikxp52P2wk3/eqv0Biw1KlliOMzKDfTQ/+UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niAlCOLf5iJFRPtPLuoTRw4EV6d8UuybRYJjoXvPCtKvzdpiEKE2zwzxS5J/Miej2jUgvWpr8MQq6X9V0JpXcL78iAzDt9vLd9AElEe9X0IPLrjWJ1gEuH4JasF5Ruqb8Re/SjEoUlBdCH2BkuO7CYzdEtyTsqygZJhJXILbILA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IXYDfDi0; arc=fail smtp.client-ip=52.101.52.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IXYDfDi0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ji6VPxAPpZSXFyET57pEV31yB8i2yoIJpVQddhZSVVjMbHJxWHWhQJkNuYBWDoFfdjJuO8VEeD7hz5cUx0TGHvA+Mnk9FM0/hgxlO1NhJu3MEoTgk9+faMpRsJdgTYwTlSDrYTl8bXhXsbZ9j8oaq/OmJHNBpP4PL/LW9NjWlJYy1VaAkK1KcilBvOpMIzDiaaPfbkc6Fu12XHyNVTHHMv/6NpGwQdmbGQSRd0Eqg8paA5PfPAzn8F+jFP7ZNZN11A8K/mMOSPovsHpvNKYiaNSZ/sEKuDiDn49cvbVFHjm8/IJoOOplOzuGiimI/I5JOCL/CQ1z+hViHP1ljGebkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=Mb/urfcwf+s/GyD+6qEB1oSqkkrM8CG83Tfg0AOB9S5AJDX+USFIMbWqtdgRS7rkaR+M8Vw+a4RNtMjQixxoZHuZ8hu1e10dzJHV3ciCxsKRsuT2n1G/VYnKOiWfTWgT+STtPwlxy1a5UWkJ6bbaWV865Ib8lFAp2J2Jjr9gjyUOSviyd0dK7Bm1BC4ESP1m2t4TUq/0kOmKIhbUK3FcSnwKuZiAJ3oHAWS7RU3PoanZvmyjCqRDLkgnqT3SuUM6Fe4YNpDYxZESToetEgDfuCrkzs2h8Y22Ne3Flnxr+NN/OymePsRvF8QXtT13QTbxjX7W/yk3NfaftxZrgSUUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=IXYDfDi0EJZDgtdsjL7Sz2fGgShove34c30BuMnNfNtB6UYnKVah4e1RMDtKjABDrf3YwYxQwNkhHr/uxSuZci5gngXli2AA1vTvAO8FL+kx0IFK9pIdMTSiDYsv8mtTGd2nfyzp+Gx/L36MOUpKdD1EZY0Icf8k9iEnnfTaB0gxJhrrHzq5C6Z7iNDfwjJWh6frbDjqIgIkyrEMQ7/8BLCx0dMqJbrkY9hJkUZSKGCX4ZfaSMoNEVC7rEst37D9K42LM3N07+S8DLS19l2T6xoEWRNSAwAxhHKVucRtYv+xZQ6nR5q+zZvDcTsCkpheH+k771Mr65i/P+b901MzPw==
Received: from PH8PR02CA0006.namprd02.prod.outlook.com (2603:10b6:510:2d0::23)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:48:42 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::92) by PH8PR02CA0006.outlook.office365.com
 (2603:10b6:510:2d0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 06:48:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 06:48:41 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:27 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:26 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sun, 14 Dec 2025 22:48:25 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V7 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Mon, 15 Dec 2025 06:48:18 +0000
Message-ID: <20251215064819.3345361-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251215064819.3345361-1-amhetre@nvidia.com>
References: <20251215064819.3345361-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d314d04-cb85-4187-0522-08de3ba5fc06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?agRhe6PYGdDBgLwbN2+yiCIb9cgSY71VqWos8D02x1kO98BNo6wjnrxQG/bO?=
 =?us-ascii?Q?qL5gMQ/3kOyxk4Jaf5mmlvVXCuogDgHIgQxPdMTxaVdgVcdro7gL/H023YLj?=
 =?us-ascii?Q?9/76GZN/s6muOxy8M3fxcimAp2X7vqP2iUOD9CLK2Qpl0jKsSQLJOq2P1X9/?=
 =?us-ascii?Q?aslWVvCK82BfPhYGe8qggrVflygm+7pkf2MVwEfGdAv+yTld0SoHPMP2vAuS?=
 =?us-ascii?Q?3ryusVoD92wZkzKOBXDm0A5odLWnJ7aGv63nR0ZWArKOt/qbZKvD/xumHQDt?=
 =?us-ascii?Q?49X1gTZwsC23cSPezryZlESG9ebc7fCEOsH1kTJoshISjKfxtaSVLPRIPrFe?=
 =?us-ascii?Q?v0YlCkfHp6SWpfpqBZ6NePGQn9yDU9PVQdNMbF8LI0SrEJhkHBvjp/cUapM5?=
 =?us-ascii?Q?c+HwDGw2/3B1lXxsEhyWT+F1bp3TYZehmvAj4ZB1H6VtzNGqJeEn6h/VylrS?=
 =?us-ascii?Q?s1SNHIETSCJtftYMbOrm/fCNRLA6CwA5yLrS/EX4Oy2B8kK0pkcFOccl/AHK?=
 =?us-ascii?Q?k4+l3ke2pu6nq4dVSGoYN/9AmGCfdO7GIL8VEXdBjY7H/gxgDivcIg4FzStO?=
 =?us-ascii?Q?ftP3rA0OqDcl63Ls2Y0ZowWCLKvLXq5/GUx9Oqar0XUo/MlrSes9kjXcVq2V?=
 =?us-ascii?Q?UbBIbFFcGTaI1Tc0Ni7n5UUbYIzgRatdNk9c9DUZAJ5L8pjqZiQ5F8vqJyI9?=
 =?us-ascii?Q?GQH5vMqglPJyv7XxnoFCWQFVt4xHVLGM8ROXUaFY6OAIydFWsbQ6Ht1rp4dG?=
 =?us-ascii?Q?mn9u38Sv8bsb/ekPTkrPCKL9LaBFRRbeE+of4zJ44fTLT/Bi3xXv8vf/12V3?=
 =?us-ascii?Q?2P7e38QXl/VWEVKGS+J0WBbL1FMpbdmjADXLgs74MeKpy1cfrnzVDrTiTGEk?=
 =?us-ascii?Q?1PDazuXjxy8+X1H+YQMKiyAxI7CUKd76EsIfY+PlUESrYRMYenbxWTPOb5GJ?=
 =?us-ascii?Q?UYndhguhu7dKWVSVtMpF5Sn2NbXrvfHyG2knHx/aGRitHt1AH+5MC28RdULP?=
 =?us-ascii?Q?FDrn6RPD2H7m6NtpFgxGZZ1bKGBzUz5RklUXhCPBhIQGeSunxJIfT672v7kD?=
 =?us-ascii?Q?HSebBMBR2x6q2zJrEJo2WLf/O7cM08zgJpwALayAZyWXGBwgUfHkMyzwhOuF?=
 =?us-ascii?Q?brJBe1IA0+zf76a3lT2TN3+AV1QdGqnj71x+DdL2H0Rov695cT62klYYKmLx?=
 =?us-ascii?Q?k3jSYeVKFa7BAhK7Piygg4iaQlzR1Ygv3VwvY9WBZhXo1PBmYoQpLtl1zRFo?=
 =?us-ascii?Q?6rCNROLNWSjInPx7HEhrJ3ojS2zleFVJAJHrpoOD230b7e01ehNjFR98fejZ?=
 =?us-ascii?Q?LEYF1BpMLAlfaVH5vqHVKbyY0HqYo0UqZNiYYAHU+yeQ+JZhoGr5JJ4v7X/f?=
 =?us-ascii?Q?NzXWfKbXNwNUoCxULk1mga0HluOC4D5AGIyjxBGVpx5SbA0nf4GsmxdPdsPH?=
 =?us-ascii?Q?gvBQ92iqiSay2Z/tkaYP4JwNXG7SpSjM0F1STukJsJpzJTGdhzLnaKN9G5HF?=
 =?us-ascii?Q?tYtJtEKJoWzCvT91rBVExwS1c2790m2YTaNL8SwZz9cIKGo6C8lVLR3foAOp?=
 =?us-ascii?Q?jkjZwNRHxwtjgkD3R2c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:48:41.5579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d314d04-cb85-4187-0522-08de3ba5fc06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Add a new device tree binding document for nvidia,tegra264-cmdqv.

Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
property. This property is a phandle to the CMDQV device node, allowing
the SMMU driver to associate with its corresponding CMDQV instance.
Restrict this property usage to Nvidia Tegra264 only.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++++++++-
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..1c03482e4c61 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -20,7 +20,12 @@ properties:
   $nodename:
     pattern: "^iommu@[0-9a-f]*"
   compatible:
-    const: arm,smmu-v3
+    oneOf:
+      - const: arm,smmu-v3
+      - items:
+          - enum:
+              - nvidia,tegra264-smmu
+          - const: arm,smmu-v3
 
   reg:
     maxItems: 1
@@ -58,6 +63,15 @@ properties:
 
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
@@ -69,6 +83,17 @@ properties:
       register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
       doesn't support SMMU page1 register space.
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: nvidia,tegra264-smmu
+    then:
+      properties:
+        nvidia,cmdqv: false
+
 required:
   - compatible
   - reg
@@ -82,7 +107,7 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     iommu@2b400000 {
-            compatible = "arm,smmu-v3";
+            compatible = "nvidia,tegra264-smmu", "arm,smmu-v3";
             reg = <0x2b400000 0x20000>;
             interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
                          <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
@@ -92,4 +117,5 @@ examples:
             dma-coherent;
             #iommu-cells = <1>;
             msi-parent = <&its 0xff0000>;
+            nvidia,cmdqv = <&cmdqv>;
     };
diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
new file mode 100644
index 000000000000..3f5006a59805
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/nvidia,tegra264-cmdqv.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra264 CMDQV
+
+description:
+  The CMDQ-Virtualization hardware block is part of the SMMUv3 implementation
+  on Tegra264 SoCs. It assists in virtualizing the command queue for the SMMU.
+
+maintainers:
+  - Nicolin Chen <nicolinc@nvidia.com>
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
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cmdqv@5200000 {
+            compatible = "nvidia,tegra264-cmdqv";
+            reg = <0x5200000 0x830000>;
+            interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.25.1

