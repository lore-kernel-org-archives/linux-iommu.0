Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9B366DC4
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283402; cv=fail; b=Qa3wuMrm8n3p0w3R/hskg35MVHR47JPMIrf2PV9okD6QxBqPDcI79eGQX5janlIg1NQ45WMJEeXOhC3hoRRg+gdDFtZYC/LnDdKeXCMF2vfW6Sv57KEl2GqvILedypZtLdWwlxSAlrVaur3qV4amwoIlH90ptnkRTKLBPrpUSMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283402; c=relaxed/simple;
	bh=VW66JSdW16jkRXlLvYPWtIHoJ0kygY56YwOZDXjAyT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fKCCTq43Pg5CiObCcJ9DOqtXw+Im7H8vC6lwL+Br/lARqRkNZ3t0sU0mPVMbh6VsdhZGOkdw4rRZF3C4kRYkGb3lq+rJMTfn2/P1z6fBjbGgb30Ia2xpWjzKul9zh1+2uiqnoULvrZWCf8yQAXd3VlOk4vu76aGz/6gnED3VaZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V9MuKB58; arc=fail smtp.client-ip=40.107.208.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V9MuKB58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJf49FxKOnZowS1MUfZfW7j3UaGBRGbNuNwXrKwKi5i/x45RciMMDGXF8QC7n4akYrR4GGv5dnUaSCOh2kvcG8kyOUgLOk3G1KnrBXeFgxU3D6C03THQGSnfwhJjcQObY9DFyiGCcbNH7yIusoCly6bQCgD4sVnykJt43GPeRlUIiSTWJw4KWYfLN8reRmJ9Ib6YOLEZOFylhLk33DJHvjU9r8ZmFqrjwL380CR2u9trhsgq/MycRcf8vxjz0JM6Yfwko7gf01U6AXnOlxeKoqoLh/yq5HzGEsi8Ww8ZfjvzrOroSxW7JXecz+kAFlLLtw/qNtDnmH2Y2feLBRS9Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+yqIqrVuR+oUevABVOKrb9ss0xGvB5ijCu7MI7fnfs=;
 b=qkmIeyRZFPCXsuzmUtab8EO8tT1QTMqTPoJhXesmBeubb1GcH3PVvbJWscih6Jmp/n92bUBBSplPhcwKvLXF1GaG7uJKaPMHa78CDIjgh96mYlK4Y+5+HmRebwGHi6o8NNVcjE9QmXp5Mqykya3TzUh61b1y3AZ7GcExw8GW5oVHqMsrTPFxfk6GLtDMywI1Ej+x3Oji8EGVsg1vUIWJn97L8q4n27FUuhATFLZEHbWVIgtTpN30yuQd5CwmLFg0GfFah4EOukJ+WcPXKM+r/pFW568GZLJqpDI+1P0Ccfp9o1K2IsNgOwagTxXnYP+JeBOeF3lJZ8lo4krNzLJTCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+yqIqrVuR+oUevABVOKrb9ss0xGvB5ijCu7MI7fnfs=;
 b=V9MuKB58I2beLddVG97gitiGq6rSdEVWh3L8BfyBBgYm7vcWZ7m36cAlhUf61sKxLvMz6xGcmDNjt7mJtc4AUGp3w/NQt0HyG02J97hoRlXZGdjjx2vWOYNLMo8tRZuVRJCFc5D3btas4ybO13W9oD52Yrx9y6JDCyNUHEgcDyaGAI0kGmLJu2w0xbBpGCqBHxCRfBV5ter52fqJgYkD07GECllmEZpPt0Uo4KsWupvVNb+10HApFWh+DnQKhMgAuLKNWcAsgK9f3VM3GuBivXtyc0fPBHAdmezviyIcGS3EgdVB9lI51iFULdT72gZ7hCwVqsWU8/JVVqERIa+EZg==
Received: from PH7PR13CA0005.namprd13.prod.outlook.com (2603:10b6:510:174::8)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:49:55 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:174:cafe::8f) by PH7PR13CA0005.outlook.office365.com
 (2603:10b6:510:174::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 05:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 05:49:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:49:39 -0800
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
Subject: [PATCH V8 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Tue, 13 Jan 2026 05:49:34 +0000
Message-ID: <20260113054935.1945785-4-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbb1341-4443-414a-fe66-08de526792a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k/7oG5C7QS4HdHUHhrzoFMglg9pRbgp0Nqj1JJlinQQuS4l3Z1RpYxU/HnJ0?=
 =?us-ascii?Q?fkT6VCm5UQepiR1Zd1QWMBR0v1ECwa0h9zjWcpf8m1il3EXc0j34QYJNc17x?=
 =?us-ascii?Q?/hyFxY0r3h4OPsHCYw1RPL6Ed4BG9NK4en8P5lrYH0Gnd5tu0qeDuE4CEwHX?=
 =?us-ascii?Q?h+RPmrIfAy/K/18ZfI/UARtI54xlq86NHKLleQYC7PJ9ufhOLbhY5XIq17ou?=
 =?us-ascii?Q?nNQehVrNlqh0D+Tq2/Rsojv6zGVkqYF7E7jbiKxOYl/juDNYkhJoxgf/wwY4?=
 =?us-ascii?Q?BkS1G31ykKMMXYecLu3w4ZhfBTaqHhhD6amqhIoGLQXoMUmzZ1nPYzyqrpUm?=
 =?us-ascii?Q?asAeNPdraGeRjcr+O0gpnERlClswYwRh8XAA+SOOkVasuYXpOnC00S8UMjdk?=
 =?us-ascii?Q?xHiZ+/P57r/+4w3FGhmL+wpi/Ko8Jf6IFofzDqKwyTZwmRSDEI6zR25v1VSh?=
 =?us-ascii?Q?17F/rJ4NpW8aS58seX5nWnPFNKJmr+JJtcOVdGuWW2G2QYGsrTAa77VsfRjZ?=
 =?us-ascii?Q?Stn2hbtScQo2JRL7TsBKr4qU3EFPw3qR4KHcS4U2BSg6IsVmqhcepKTK8J+3?=
 =?us-ascii?Q?fH57FZH/tPUOOWc3vnQ+eO7VggZAoTCqyFJyUJSVB/k5hlCtA3K52nJBxa4U?=
 =?us-ascii?Q?OwsCK/yq+kmkOfGTFXJ4NRCAXSUb55T5rmb11bL+SGTPtq0EgyRPuW2pNHD7?=
 =?us-ascii?Q?2tYYyCpLRwmFYHfzGvOknJDIq20STpa4zsiAC6iu7WkLdMfWAENS33VrvOZP?=
 =?us-ascii?Q?p8fjl06LxZMr1ajLkX09fJlRgsGqfSqoiJ4uXUo9w+5V1AaLbfjbVOOtGylx?=
 =?us-ascii?Q?DCstymVR7XMFlVRcgJ/m5vPslawubFqPURWOL/6iNMzf88OGS8YAFwcStH/1?=
 =?us-ascii?Q?ixV6qjcdU6fWYUR3NMX5nFqTlOoTsKfdjhSqMyjf1f0J5XcsKlDgWHt71SQK?=
 =?us-ascii?Q?ZM6yNvyrFPE4p/uOMEb3vHqk68F+Z0DJDL8TBl975PtUtkwcXAQExt/RpkHw?=
 =?us-ascii?Q?eDp/pSevZWR47Hfrr3LPZhe42ikH/Dd7P3xsgv3r6VMuuPSd2u7drq74Pz+g?=
 =?us-ascii?Q?UGSuxuLp/QNPNH5Iu8H41x+hBTubLpoP4HyMOl7KgTvj/AUlqSnwK3PNE6xv?=
 =?us-ascii?Q?ZLmT0p2aC7Blut13xSX3m4kgQp+6PUrTh/L/w+qeq2T/t2OPlqhIvMNtZwng?=
 =?us-ascii?Q?G2+JYA/bsOYeATRTKOzsODyGTqk74j7+kaUH9kGYWCdfwQOB2Fq8ujGeEnys?=
 =?us-ascii?Q?Kzck1lE7I8l3AmucHGNu1naJbThtn7nA1rlJ8TT6cIBY97EJoqZeNJcERzlW?=
 =?us-ascii?Q?typ5ypno2dJFt/W5EwAjvTR9bLgAhRDJjQdAQHJ2bR5R329uwG/QYLpJxZWu?=
 =?us-ascii?Q?8AIECRLKQSyBIDS1gFr2Gilir9WktldotSb2uDaiHwjhH0BRKt+CBfZA4XQX?=
 =?us-ascii?Q?4njcHi0tTepFF011MEj7aDNgrupx53OcTXPAunrYBKXaklg3MMGLpBOdShVy?=
 =?us-ascii?Q?I4yzxmRgaGLeulYVWkRrcJ6cZuHmGVCY7tP+gW6Sq0mcI+2GEFJU2NqWO9+w?=
 =?us-ascii?Q?G9zV77IF3UwW0AHjhds=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:49:52.7619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbb1341-4443-414a-fe66-08de526792a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

The Command Queue Virtualization (CMDQV) hardware is part of the
SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
virtualizing the command queue for the SMMU.

Add a new device tree binding document for nvidia,tegra264-cmdqv.

Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
property. This property is a phandle to the CMDQV device node, allowing
the SMMU driver to associate with its corresponding CMDQV instance.
Restrict this property usage to Nvidia Tegra264 only.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../bindings/iommu/arm,smmu-v3.yaml           | 27 +++++++++++-
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 +++++++++++++++++++
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index 75fcf4cb52d9..82957334bea2 100644
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

