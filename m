Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F0331211
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606776; cv=fail; b=RwNWBm8mR+QbOW5QxofFsIFBXj648VkOCgibUWzHGjo7/a5aEj+t39tENrA6LR0P19dytKT2v7b62ndRS6KBy1kIyemKqFXwMeaC+aMmA1aBUvFDIWyQxI7yWllQHJ/c/hI4RT44BZj+zjt3swLQn8rEh/GPrw2fEV07NI71ngI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606776; c=relaxed/simple;
	bh=HlOk3ZXs1hs5Z/6n3Ea8YdtG6snVYBsUY66lIJxshPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZvM6+/+ipNPSZ+xM5sa4sEyJLgBg7ANTz8yyuD8rtMsersu7D5ERs7Nd+n+tcfTE1ksgIsDpXdWhcFEiM6hj4VpS7JJ7HUCOxC+LqmrjCvhJAxjJlxLYoUksdzvBAbdWCrDvcSJntQ6u1663bw8dzJPvbq9UbvzhoLsDrMcAdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icfkIs9U; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icfkIs9U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfTBA/8O43sD788VEsNNf/5UQ9fb+lPh15I+0MNTt8fsSr6oxwJJaXyjluG1ruAMq3rBTrD8HDusmIFUfwiFHJr5faJvkhU8BFeVWZOCV+d0OzASYRIepdUKbv6TFvG+2C4i121lDzt1mx3sN0i1FgryKNQxovL2sL7oBBTNQAk+3eokJLNXDOgpSZ1qYlH+SXr03f4YLt1gHNEJ+6mjpOm5cDcQ9V7FBBGNNidAcnl/gMFxpFO/9/EVSGPW0u/CA6ctRkNrT011z7czRR/6MD1p6L/Rc3PWW1XsXTZqSFuK7xO20YBMXy7VIv+SfVE1b+OxhH7N5AbNasZRNgWKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jZcJtlcbMeBnrPRxBqYFMfNtB/bpuGMT0T+HiFeh3c=;
 b=uGi72NXWBy2VBvAe1Vgc7eX6cdFkOVFkzJ+aM2FAr9aO3UJh3RKzjCHXIc+YLgDxFmVoVFCLOYw2PuY0GZBffAZnX40pviAKnqN14CNarjJAT9rFZ6mrLr8nHmdhiWwGPABYD1+f7ZLBg+Xaf86JA289Jg8xc+Y/bi5zu2hMSVKDSGRs7MmuFXBoTx8ga4aT5Q/b5Ljd2ZRbEr8srQgM4knYvD022XiwrZ8dCPSmV05f9VfgmwnuRDdy4JbEhEMJSMyDtfDT2EJxv8EkspjjupLKCw4c34yhhRzLBQqCVSfZqjvysIgHaSECldBEQj8Te4of7o095e6zMH0B8tJC7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jZcJtlcbMeBnrPRxBqYFMfNtB/bpuGMT0T+HiFeh3c=;
 b=icfkIs9UrpwpCSAnPaVqM9YuFOVrmZgPvrcwQ6usSDBm01vBa3V3CRkWAugn/XhDB7P1a0LSDmmTAecwSBA8Bj2bxW9HGEjxrPn6QFA0OPr6Ac6teSLK2RxptmrbNLGHBdL4j2F6GZjFE4sGx6ID0Jv/eVkSMSEqXaBe/NuITsMjbulP51BxzUdYHOKG8Xui/dFBfHTxvKxr/iViyDmacs53RPclSsLOJrhFhrxbf2lAikR7THzJF5TWr3FE4+TJvaronmRMbZkZUBDAvu72BNbDAcatrkJCpORDBWrmcHM6oYsERKtbhFyhKP05VjXF3HhFVEnB66zR/f6rjPvjbg==
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:32:48 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::2e) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:32:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 08:32:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Dec 2025 08:32:24 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Dec 2025 08:32:24 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V3 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Mon, 1 Dec 2025 16:32:18 +0000
Message-ID: <20251201163219.3237266-3-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: 61551213-d5f9-4f24-a1d1-08de30f74312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pKOXXqtwYgqCLDUjCieCv/n7grQaKmPzcTOtPs+UQ7N0n4EPDxvM2/6d2UKE?=
 =?us-ascii?Q?/w7LEdOApQuBzXZxokZbQIUZsc04G7vUzDxbGn8S52AyrU+Rej8yu9ZDNRR5?=
 =?us-ascii?Q?rAfThewg+daPf5nCpmBW3vFJgG+gAuvKFgtl5ir5w9cx3+SrC3RrDz29xPjJ?=
 =?us-ascii?Q?k6ZMHXq/qJ9IX4hPih3zxAfEAZX1qS3n3NlKhC9uPU11yAH0fhMJW5Y3/g9e?=
 =?us-ascii?Q?aO900eZmKJ5bAGX+kiT7jRiKbREoE55aBCAXnxtHXpfAKGwQqce8rdvIGSy9?=
 =?us-ascii?Q?p6zvjGewWrifehYAQ0z5sbVl89Z6ihod63l8uYQ5epRWoqQu8IKynRZKmfdp?=
 =?us-ascii?Q?tIF8oN91v1zAMD/xfwo/Bvch0dDMmnjPW35izzGGsQiUeSG6g8VLPk7caGq+?=
 =?us-ascii?Q?4hrgLKzwEQY2ATFzeWJNRsng1ruVNQ/0fOCKepgZCNqaiW6qMxKb6SJCnz7o?=
 =?us-ascii?Q?TM2V0fCNAKhb6QLu5wIBlKbFm7Ce7EGBQ24sE578jgGAPb2o6NmHANU7kmdx?=
 =?us-ascii?Q?njVWkGnerAUXb9S0mUOiN2TLUA9E1SCH5TUTbZaEK+nyrsuhAN300nCb6GNh?=
 =?us-ascii?Q?vdC4+fI0izwDvh1ekYQVlQ5r56ROzD2eFG2tVmiKVqRmYHjFs3DMRl2CKmPC?=
 =?us-ascii?Q?cX/PxqY86mSXPWMTAasjjzQDHtMpKiEgzVFMZDIt90xMqcGz2VJ94fVqkHaS?=
 =?us-ascii?Q?hbs9LKyebydyXmZWfwqvMonFgWqinIC6Kt5CC9MM9suo54XYcM4sfBYnlBZW?=
 =?us-ascii?Q?dBa2tgv1+ncrvMzL3385XRuCAxCqlut1LY61PUmIvhIqdK1mkrYzc/7yEsHX?=
 =?us-ascii?Q?F5YkYH04nK8u6YHeywMNm26IAa3NtiTG9BTwqh8l1ncZMVJ1vGfkA3w1G5q4?=
 =?us-ascii?Q?VxRCl3lmyWhUGeGevcXdDWzZJ1Z+vQt0kPdOm7d/R+L/3UhExhaja8JEpKFn?=
 =?us-ascii?Q?/3kQ/W0eYZvhQlVZiu2yxXWcklOELybyCuuxZkZicb9127YrP6gPDzi5N1zh?=
 =?us-ascii?Q?xyN6KGl3TGCG1p6G4im7IS2+aD/LhWefWv3SSn0cxFpjERCVDEih94cSAQi1?=
 =?us-ascii?Q?iVJzV6qGxMXA0bOTbvdbzvAjWS3Skw8zsVP3Fgqcuu9eQ+9T/9YVg1lhKY9+?=
 =?us-ascii?Q?pjaLwE8TExP6FREdMPtERzCoilUX6LF3QgjaRa9JRJqnYDuSFbtQuzC29bjb?=
 =?us-ascii?Q?em2y4dH+yo3r55J9IjymQRC2vUwdiH0N0sVC4v0korQ8QOQoA/vnpQOsCqus?=
 =?us-ascii?Q?0ZQmQKqvoF+p63jHRi/tTJZBmuOHi/kjukBqditPhE/3EY7Yqj+p1Y5jdPpo?=
 =?us-ascii?Q?4yjFe9eJBshvVYp/bqDWwLGxDLjzr/bwGFGfYe/th3gjPN1cKzBMDVNH98ty?=
 =?us-ascii?Q?J5X0qjf2qkORWF9Vc/b9zKb2Ak7F8UDTrdixSHc1ufOhkEj02+IMxX4Vj9Np?=
 =?us-ascii?Q?b/ViQygzyhMM6v6QGMu0UNjQWwvYma1ryvnqrP4DWYXDvh/+81jm71/+kGi0?=
 =?us-ascii?Q?/dUhnmmEqm0IzCpmZUkAH5GSXo8+pNcPizA86vyqIVBqb1u29bYNz8AQsfcA?=
 =?us-ascii?Q?kF49E0Y+IMedFkXpBGc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:32:47.1794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61551213-d5f9-4f24-a1d1-08de30f74312
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Add a new device tree binding document for nvidia,tegra264-cmdqv.

Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
property. This property is a phandle to the CMDQV device node, allowing
the SMMU driver to associate with its corresponding CMDQV instance.
Restrict this property usage to Nvidia Tegra264 only.

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

