Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011034.outbound.protection.outlook.com [52.101.62.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1A2E8B87
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055046; cv=fail; b=Slv8qoFPAHXiLt5NWUniw2Nq1R8T3umAQlIwTu0o5Y+dtG+akC84KaTnA0DnsRy+OVDGPp1Dv7yHDLJgwGTqLmekBsB7RmPERpJTaDIBFMFGSZRCy7+1qPaZHdVzO4bIs1X4ttjlZcbmrKggy/cLxBoD29xeFhoqU9T0WZJay6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055046; c=relaxed/simple;
	bh=HlOk3ZXs1hs5Z/6n3Ea8YdtG6snVYBsUY66lIJxshPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gb7XK2dvmwOUGwEdtDH+ElmNcal/rpIGsL9z1YzYmL7D7lF0pw4cWAQUTTyOWKucrk0JlFOdj30eEUuhqk3Sd2gshM/sqgov+aBJJH0nWB7uW8g6TSdKjrH8rWFkugJ1nuw4V73LNbZJfDKhD8L3e5x9iP41wc0rO2OXpV3TI+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MEFU+Qis; arc=fail smtp.client-ip=52.101.62.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MEFU+Qis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXyrqttzjL3K1OKSC6wC5jzfoUNOYLLmnLriBLgmbxVtI/jWvANnmWVH08upUuQSaqoZ35HfefiPexq8dauXA84v5HxqFnIRHczTJaVLtIU+kGdJX8jKTaE2d/FPfj0SOMG6ZhtT6ZgAv1Q96tdEbni/x3q2sN3kJGVid7lphs2ecTWs/hLdG/dt+CwVt09gMoqooaeDaMMIbPs7za0uqpkJ5Lt6ncRgQUDfoFbcNvKEXlu554iku0HZbQBp3kzcs/YSuQvV8l3iTzA8KQ0IWpjr2lu/X3HlVZX0xKFwkXURZBTHDj6Jc/yb2sYBaSiwp8oPAJoAbtKsOs/0AQw97w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jZcJtlcbMeBnrPRxBqYFMfNtB/bpuGMT0T+HiFeh3c=;
 b=mcUcrr9zTXaBhCLiYhQezpPk0uATU9uk9WJlhIycSb01tzoV/xS8dXlQ0VBKVLLIi82sz6etb7Lhb+AdR1EOvuuu3OxH0L+AwDbmZHoX+yEZbNIZ8j/UDTxRgB9PZ18yNyNS6bGPXnph0SttzP3dlWEF8cf3OkLHjX3OVXT3BwmiBoWBUpmwOBNsgMVx1trBMFTf1pzlAjOhnDrpepHSLqDQWIETkJSfe4Jyn2o1uBkAP50Y5VTyMWHs/2BO1JqZFKltKwRYh6EeRLrr2eY8LcOPccFM+1uL+2kgom+uIHyUbjxPJ92PZJ+3I72dRvnzRpnystvlP4C90uiOxzQHlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jZcJtlcbMeBnrPRxBqYFMfNtB/bpuGMT0T+HiFeh3c=;
 b=MEFU+Qist+a1QV4we3gA7Lq8i6gx2Vnnl7LR97ZPxgNZhrLA5uKnF/OVFxAvOyneMmpTa0jJvF4VvHcFpXkFJu+rTHaaN2vxh6H0Kesqsh4eC4k23fV0pt1I81imRGWZ8UghA18SYXuoxplZidMA5AHb8G0pzx0+UaBD28sQxf/S/QCKFgYEHiq+eLW6q5BKmQSon61LgvVbshOL/Q5l8ZfOg9bIMiWd5mk9SZXHRfxaEUicp/I4Ty4Ar3zNKNi2Ds5MBBhlDMn7bzuwB7mseQ5PI9hCObe5nl0I5XR5RYiVwAR9g6cLR+Lt+Mkf/SKRALjdOigvHV8peQSjzBDE0g==
Received: from BN9PR03CA0573.namprd03.prod.outlook.com (2603:10b6:408:10d::8)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 25 Nov
 2025 07:17:20 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::72) by BN9PR03CA0573.outlook.office365.com
 (2603:10b6:408:10d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 07:17:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 07:17:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:17:11 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 23:17:11 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 24 Nov 2025 23:17:10 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Tue, 25 Nov 2025 07:16:58 +0000
Message-ID: <20251125071659.3048659-3-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: f6bdcc3b-92e7-4172-c992-08de2bf2abad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hm0vh2Jya20YjBOoyQyaKo2RVMNtR7L+e7/4HVP9M4eYqXg91UpKEbs4orjh?=
 =?us-ascii?Q?K97u2Iicu9MYaiTnwUrDwdymFBhjPPPIuCC25TknBn2iFOlsJAWpF7IZ4EA4?=
 =?us-ascii?Q?OEKxZg65V6ynzBlgIjg3DntVBnzWPQkA9t7NpXkWBZizlNiVeaZPDxkuNHWw?=
 =?us-ascii?Q?HOKhhS6GVd5KdRNRtLlLNum4/YaGbKReyM0LmFlR6eGiHIst2wiOJ3IkuBq1?=
 =?us-ascii?Q?6usiL0xoW7dTH2MYT5StJJW/BOmDluOCvLbKdgfEJG96uqdnGHVvgXQ3TRls?=
 =?us-ascii?Q?d0SVXbtGNFHnehgPYMbhPPa5BuSDNabtPlVbNQNlpgzdNfWYPouCpL4LDoEV?=
 =?us-ascii?Q?QgzmfqqmFsK8jQaCY5vHuHnlMjrYBTCXb3TMONF/4pqXg7cHqm4CxO0FX6XU?=
 =?us-ascii?Q?LcwgGkz/CDLQFvvVtF/x8utPsGiiD6F8+cz4SAvBJQUCUcCwBDwtZoW6bhAT?=
 =?us-ascii?Q?q7NngqBVv9PMemZWJPuH8mQi06olIipOWloFxM39H8HjfKGg8Z6lFb751jLp?=
 =?us-ascii?Q?70UbNYo5qYiXune9ZVHZNilIcWdzS4BgpdvQe1Il4t0mXAJl1cFzBeO6XlJU?=
 =?us-ascii?Q?PHR5BuTpWe5XOTXa6wbNc6IgbmY56KLwd7YUadFYhs/PHxa3F5Pe7fCam8xq?=
 =?us-ascii?Q?O5s2HyypdrhqjeUssTjVlFdN67K6+PKP8DxBPhD0FhEFdzsnR0C+mLqYNTvY?=
 =?us-ascii?Q?RkYLQZhqLF1qr5e8fdF3UtnyFAP6MiJz+YLflRL/c6GL3feBK90zlNXVxb62?=
 =?us-ascii?Q?u5HzyAGp6U42XnqkTbNXEMCs0j3uwk5VqeZqmjA54MUHig/sfBHj8mIhxoYy?=
 =?us-ascii?Q?+fmVXRfRm4JjeORCVRNwgQ62jmHswPFFett7FcjZpRyWaShI7K5tCsl18471?=
 =?us-ascii?Q?a+6UlRRtnE/KYO/XpaTs5QJrCsMWhw4rtiMlRrLWqr+gVOgwlKW58AJLdGut?=
 =?us-ascii?Q?L+DTshp/fcf4By2J7XXw7fEiMvtsNXPBeAPqkH2EKblE9taWSlZKOdo1LrFI?=
 =?us-ascii?Q?D0QwmFAinq6pl3dVUJAzyyqhtQAkbQjP7qqSLcOXxh26BF9CgEgy6frSSNYT?=
 =?us-ascii?Q?1y7mlZ3/9bE+8cV0fjnS/3nMBPqHWxN0GQBJ5Xze6syDHQdocBljmQ2M0jVF?=
 =?us-ascii?Q?tjulit9c+wI7/w34gT407nsL1+v0Jz5ByrZkIzhGe4kaOzQrGxURJQG+jkQ0?=
 =?us-ascii?Q?FTKRltOqSARy/nzkPJKNWSCMOvLV1kUU+huA1Ec5EyIChZc+Cwu4Ge3FVktP?=
 =?us-ascii?Q?OgpOlt4r4F90fpWfyG3mJ8MLiqBPRCdaFPlcWQHMJkk4SF6K09UorUEv10uD?=
 =?us-ascii?Q?bQITIKy0spKD7fKkUCTGqe3sKQthjaTBudKH/ld4ImXDqG+rNGd/+zfS7//H?=
 =?us-ascii?Q?wMQ0mrYK5zqaulD3lZA6+Dtgbtd5ZmxL2zeSMQ51cKJlw5rGLjGDYPIetkdw?=
 =?us-ascii?Q?nu7dWdiFw65xuYFNDn7Uk4d3W/tAs+5PH+VVBkNBvSczqYMQEWjjaiUdFBZP?=
 =?us-ascii?Q?/sarydjAuBtbdxlhKOwtmoVBDdqmlHaoj8Djmt3k92etHgfxKg61wHdg1UV5?=
 =?us-ascii?Q?cbw8oW3rLoZ3JRDi5g8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:17:19.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bdcc3b-92e7-4172-c992-08de2bf2abad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383

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

