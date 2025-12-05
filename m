Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD252FFFAB
	for <iommu@lists.linux.dev>; Fri,  5 Dec 2025 06:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764917958; cv=fail; b=HTPwvJLEyfPeY4Kl4p/RYmL/iYjqfDZYfBwElWT6mm/mXtVJP0PEXT4hIodesd5DsDPQJvcZmnOwF2BWpDSJHHOWYVyROOvNWBANjq7mdAfTcj4nsALO3IiYrJVL9cGRDKz+74fOgx8OXGS6gK7hHzioQ5/sSJetH3nj6T7jaj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764917958; c=relaxed/simple;
	bh=l+B8Hlnikxp52P2wk3/eqv0Biw1KlliOMzKDfTQ/+UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFGQ4ZLhlWzTSpWSiy/QRNn75g6mWwKHwSp/KS+OlIrs6i7syzDJkjxYoJqRRaQvcna+CxruNP3eqlyfpFRaFKJc1xNoAqnQkyzkrucJtGvVh/+/m+vMdWa6iei0Ei+W9EaObNoOgEnRy3uIoVq1Xt93G7sxeHGfNnozSxq3xWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I/8x+sVN reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I/8x+sVN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQvpNBns54tp/im6kAQfW1iUE8RKQgbXStrRuf1wQc2FxmXYvK9h0DInjDvuVxn8O5dE52aPwVnmOG4yRFMkIMdtHU8zV7DbMNOvETICAszVI5HqdLtgqyEl9vpzlSEpOJ/RcMx/AsVwCkLIBoq7zWpMHxI/3r5ZJ6sdum0za4ab0kd8NVVGps2aIgUyCzfU2Vnhsjgr9U2cItxlerXpmX8GW3lVZnBmFOKAmvaMFLtlr+RKdDgPYcaff0TL72Mrmw/2FyECvVOjSLRgVslAZM74i8K48CSq4KrHi3dlP0pKgCi0bmKxhJR6yLIYkJgAUxmwFhevLisV+Vcttd/IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=ZyHnfAPRGlpgv2pqS9O/X7KGH+gnZzlgnrADLGBU+hv9ZIAJ9TBCPiJKc+zyL8r8hX6hBh4KHiHoG2vJe1bDPsPpRFHM72VDf/Mq9hG0Dn24sNYNrt26iHYJq4b7bUNqLJvmtyH0TRprkWVOUi56p6YdIejaGgZE8WIRcE2thfEMrldZZIlgV1XyQwFfgQ5ZjW/1sKYQU2noUlq9vKqjPSEhdKsBU2tjwYnzHqxxKcidY5fyPlimrXSyN3HEaQKryq5KRemXjoj9u1cwVao8va2UAV8OngNEtRz2lkzivTSMn52ruJszpbmaPiVgSQyRjiAOIVVjDutZELUOcELh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=I/8x+sVN8uUvKQUnC+Sne21hffgz0Cc4/QnvTwNP20fRgs4jhVGTc2vdylWNKLB1IRf0mxQoQXptsX7jsaX7iTEf04L/PS3dmLyb1eHth/Jdk5M2sEkyLUzuz6zbkZb6YgCPEkwb7ojQaVMBauRz3c8tEFJuTzODMtC1jUbbekSsJaiG4H0ysS0mqYPK8A3Lhe+QJ7U2N4C0gvpcRIG7Gp+CoMlnkvFW0ahljW6dlIkO4rbPf7kIDEISDbl9GA/yoEMKEQ6dUlGa0c8qPlhdx2Hye+M2VZ2ocIZuFAgNW/UXb7U+0P7E8h5inJROc+kM+ULXSPyb6JoiJ+L+iBl8ng==
Received: from SJ0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:33a::28)
 by CY5PR12MB6180.namprd12.prod.outlook.com (2603:10b6:930:23::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 06:59:08 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::de) by SJ0PR03CA0023.outlook.office365.com
 (2603:10b6:a03:33a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 5 Dec 2025 06:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 06:59:08 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 4 Dec
 2025 22:58:56 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 4 Dec 2025 22:58:56 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V4 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Fri, 5 Dec 2025 06:58:49 +0000
Message-ID: <20251205065850.3841834-3-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|CY5PR12MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: f08af4d6-743c-40c1-55c2-08de33cbc944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/iM2URo2wI8LPKPAcAw9EgiBGyw3HSEKdQaLn8oIsdEJvUujYfr4D0sbGVuA?=
 =?us-ascii?Q?k7h0LXvMFMYHEYp3T8kVbbM/fUxD7Hs+g4u7YLTt8AIDGe84QvayLtw8pRmC?=
 =?us-ascii?Q?PpYeEa45FWV90h4GT2mkR/1Ug5IZ8AZUbBTfAPS7/BwUQow05t4ApBHXE5f4?=
 =?us-ascii?Q?dvAwe1Z17pSVnHkkczMPchTw0BNIlPalrmDU5LFBprw8gJpqsJ8mhvCMtb5t?=
 =?us-ascii?Q?+fOpV28Mv4ibUWuhcJx3a7kBAxgyNuJXlf4GCSeFJOV3PCe22aIgt64FRzlU?=
 =?us-ascii?Q?IUhkF+obTQJN2svjaPezC0EKCkj9R/DbzGSSvbDabOKmvxxeWlMcRCrqfZQa?=
 =?us-ascii?Q?BOLvME6uG4ozyQRnTBMlyCptBWz+rnloAhveprTRkpVXcV+lfcyfcLMvfUlj?=
 =?us-ascii?Q?lbkoWa+gENodaSazv5uILISAh1yJYfeFlaiOxypCo5g2PZ1jRoY4+YIOWVvA?=
 =?us-ascii?Q?L37c7FPcm6EgOKbZi9RYQ5Mv+rK7S6qlfM/3Ea6LExbfv+kKgipcefzvKrbx?=
 =?us-ascii?Q?MXE3iN385tz2fxpfHpBUC2A/SbmQJ84TnKZY3DtM6Gv4d6xPSHAm/9X5LRHI?=
 =?us-ascii?Q?OFMyX84rSWvxxnDTAjQnijhPFwVPVhuzt0AUZylBbFg1FjMVktZYNsabeJT9?=
 =?us-ascii?Q?ARt35UWkV1uebNTC6l5mV+OBQWyB/6PLKtbGR2lquQ7KNocsMSkntpFfHDnc?=
 =?us-ascii?Q?g12uDGdmf8AXhwf/rsOZKrKBi23CYB6W59pU03rRxbWzcN8uIf8cPrxSQenx?=
 =?us-ascii?Q?+W9kCfiX6eaRnKfSZXehh4ZaromByOn0lmCHolKMD0ahE0wDd2X54ULQrcgq?=
 =?us-ascii?Q?u4wWBHmPLgZQLmqKCT71f9823F9Fs53Us6M6XaMjaK8qJNdpWWsfqnPS4W1Z?=
 =?us-ascii?Q?9l3mnV5PY0KiI5OEP+TvZHKQ5NkgXa9WS3NMs4+NfbSM1HLp2WT//BRJc2HI?=
 =?us-ascii?Q?Cgy295lX+npIL9rn8gEjCdVt2IuNWr3ksHJzM9EHCx+i1Soh1oLcE7Zc7KgY?=
 =?us-ascii?Q?LhizzR8qE0SoGY9ffkCJLaKF6SS/EfMWbhbqEnOZ2XEhmVbjbbrcX8ZVXklq?=
 =?us-ascii?Q?etsWFDONOh8iqVYFh5xiRtaTVk8Qz00L9rhZYRmaDfc16PWxEOdofpA8K4fP?=
 =?us-ascii?Q?IrHMczaEO2DSRZ6W43XxPn2lJLhYscA045/fgGcXkJEf0Xw/ajbXzg+TNMUq?=
 =?us-ascii?Q?Pe3APNgAMoh3GiQOSlrwuJ9mnC1kLAIY2NMji1oeHTN61iB+4lFL8yoc3XrG?=
 =?us-ascii?Q?V6n/H10MDoTo4Z42ew2TcKpYvCu7c9ioa6AsHyhyFWt3IHP9BQzOed9h6KeF?=
 =?us-ascii?Q?nNRBz5YyMEwwd4z+NqRU2wSPRN919Pyi4RhyyreqjKgbH0H3yjAQXlT3DJan?=
 =?us-ascii?Q?XVAeOdyfauwU2Ae+EaxI6O1J6cT8huQUwUsxTMe/9OVVESiHm/19iEVyChUg?=
 =?us-ascii?Q?z4UJVV1IlNY+ZqVponFhPzPjw88rb2CUtkTLxE6Jl4EHuC5oK5gc1jcZCOhX?=
 =?us-ascii?Q?NfJbqlVTqif0wi2iDDAJBwGhHJL1S5ONvFWlOj+PNsu6xG4sicwu4N+LWgRH?=
 =?us-ascii?Q?EHMhyhgsNFDB+GY+0xI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 06:59:08.0931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f08af4d6-743c-40c1-55c2-08de33cbc944
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6180

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

