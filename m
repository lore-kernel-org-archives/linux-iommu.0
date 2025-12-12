Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013044.outbound.protection.outlook.com [40.93.201.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0192D47E0
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519709; cv=fail; b=o7UMPXK/b1GtBGdBvsA3zhUGqymDMrv9CP5iPybKm5aMuK4pmC3GgAIAnMHoExjRdDNF1RnlHkjDpSaEtjT625xzPX1cvtNw7cxP0SCbOBaAToCMUI4TEfBcwxFWrW0vLkqDtCnHzGZiRgNoBIuXslNUcMGBD9TQQfb+N6B4V7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519709; c=relaxed/simple;
	bh=l+B8Hlnikxp52P2wk3/eqv0Biw1KlliOMzKDfTQ/+UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NE02xhTJLp5zw1MfbzvR1enA7i4xphS98uhxMv4337pFVeK86rI69yndiiwYVY10eq7X59v+ff1KkGjZUfRkEyWT/nt8qs2nrPJr6HbOHPaC6nDdrf6LyBFHcHJYil8O9f00Zp7ct4jttfpABABlXNjCcRqBZQ7l3IDlZqDI+WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E08UN8x3; arc=fail smtp.client-ip=40.93.201.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E08UN8x3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REx5/G1suxtmvOu/0wkqAgsYW+N1DrNIToOhC0A45CDSwGvTwB2urRz7XCU+EXP74W8gQwPJflplh/8FW+lOQo2Hj1wz7kV2LUEczIX05YPDgVzAjbmLXhSWMgdqrIEiMKO0r63EGT3uXHkP4+WITrY2Sq4+sICUuru5jGmpcALNXXlTN+aP0WDMiHdYq4QSS61ul53wdmThiu9znjKnBhV0+FFpJuxcmG+jPV7fQ7DU6IBgvUB30b/i15Qe1IhPo0RrwZjLtbucoRhknWYa+ejjVC3GqR9srvqaQrYQ5u3hiycVvuBY05dCMWFBl2GGq7L16AEtxu1zTkwIz0BRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=GTXX7ThN0TtxqgCHme+uBlVdDaOKKw7yEoriExRtI002xJoKvcTtS9mFJgjqCSQX4h4SE+AA8eJ0w0idIcXZGgL8F0N/tRDLMe3CshOYSAu8DQ++3Xf6nA4wpgVkiCXw66ReYEYGXt0dOzp7zpvWSe78aloo0UjyYP72yRe04sCxSMjgMqrEOi4wVTbyB5d7wBsUiazIGVFxHPS1KWsXucU5wZ6+nawyWwdFYQoe92VP92qxK4cNbPpfw244Dk+A5s2ms6azL9rZczvtPan0CXNsEDHUhkwSkDTYuk7DW5H8N1qmfYlqTcr/qcDABEqXBiShsZbsGaBpqJyk0W9kGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiy3wPTUxyVsZfG0Q3ol68oZmfM61ZDburHz9Hhdze0=;
 b=E08UN8x3AuUepF+sCgboMsEQcIlJLBLRdTwKENwvhTeKplaHq2L0yeFTdNs4yoeOMGWiFmOUXJnzu2SDjq/9Vvwe+zqciFBk2ZaqAMKfUu1stBcAHATyhK3kiidr8TUGpB2wxWS3ZC6rRy/PsSKBiKRyiDFbgsylaTEXicJgOVrjAlpLkeZLWpR8krCfLqztwrJ9KSxGlUSJTOBWuymAoFnsQP9Sy1YnfSi7yUco4rdFfqkbFjaDrEnZMoKfWPM0QlD6tmWrafvVGsqfM1lBFbQq/6T5zxG+OOEqshsDja8dFnOH3q43B0Joa/tC/py4kIr0M46kTlW+QcwtN39UCw==
Received: from SJ0PR03CA0235.namprd03.prod.outlook.com (2603:10b6:a03:39f::30)
 by SA3PR12MB7806.namprd12.prod.outlook.com (2603:10b6:806:31d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 06:08:19 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::5f) by SJ0PR03CA0235.outlook.office365.com
 (2603:10b6:a03:39f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.16 via Frontend Transport; Fri,
 12 Dec 2025 06:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 12 Dec 2025 06:08:19 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:07 -0800
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
Subject: [PATCH V6 3/4] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
Date: Fri, 12 Dec 2025 06:08:02 +0000
Message-ID: <20251212060803.1712637-4-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA3PR12MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a856c81-4c94-42a4-cb13-08de3944d921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z0PMqrvcMPaQFTV3Wyj2aQK7vhs/WH3Re6V+/H1nnFCthFKpITeQncfMN4nM?=
 =?us-ascii?Q?YBO8UNYYgjIQpr3/Op/FEtTwlZbKbLuVKGV4JXoQrHnEbM1FvyGFcIKhHMKF?=
 =?us-ascii?Q?n0GsKBRxCnCftqg8apsEx7HER9DcRsIGZNAz1LQxt00rETisiMCWNHuBqomN?=
 =?us-ascii?Q?d+7er5x0/8nnpJ6p2QDt8ed5Ts64FqQqto5ZpTTMNdusqvLYuV7eJC+JSNne?=
 =?us-ascii?Q?YNc2ec5jJSbZmISVhfecUGYmPw3SOL7GCLX7+P7G9c1xVuYeNq9EHS4ZyPtj?=
 =?us-ascii?Q?RSggfCpQUEY6zWPgZ1W0W8YFZpWDvkqXJWiCdjK7GK8tLwXCAfWQ1J2eTDaM?=
 =?us-ascii?Q?a4Kkp1bZqr/Igg9LxggA6DB7LtD588etHjhR+ALYhxfMP3L/cyrJ6viYJWfX?=
 =?us-ascii?Q?JymGIxHY9usmLHh3kjGi51BzwBVzcF0oCKDgkx9PRnIhSCl6t7WxPQ1hU0RJ?=
 =?us-ascii?Q?m+d9MplCPAApxENQs/BdafQLk/lwoL1GHd71OyfF77ojtUATHDzV+H/0Iwl7?=
 =?us-ascii?Q?P8pPWF6FJaXXHLb/6hIajke62co9FjEHfaT3MBqn9trvYFd0luXc4PwKZ0WW?=
 =?us-ascii?Q?PEWQWLv1UnemAhp35aVuCdbUl0WjXEwrxGUO455iPmzSLvhNs9vpHwDBt9xT?=
 =?us-ascii?Q?FMAhgxLbEMNsB3fVKnvvQ0vgdaqc1WtxKowE6aXKAxwxo6FNj0RgmkdSaPtX?=
 =?us-ascii?Q?ivXl1t2DMjzAcJVVjVTV0x32nSJ1x+1NbnZ+XohL2TbNNnCGa4CP48nHLUiX?=
 =?us-ascii?Q?wiUvEZFeWEG4IlRSgIILy/XX/kvbvH2xD/FF0JWN+hfEX88QyUQUBDezj/5d?=
 =?us-ascii?Q?YHkVauKC7z8s5VYRlMDAXhwBucKtcWKF1dVlSsMph1QfYZp1yNveTGUYvtxz?=
 =?us-ascii?Q?VpMXzVMWEWzaRFG+g4F2IlqpJZzIOeWfr4Gh6hGvM8cfU6XjinbxQeaXmYvH?=
 =?us-ascii?Q?Mp3U0L2OF3OTx5fgYNnSLPRK52kTEJfy0lR67eKDJXxfvRFiGY/2eeVrPx+0?=
 =?us-ascii?Q?IVEVq2rrnAMUaQKU806IVITdPspqoNcIGTkpN9qO47OgwTRTN0VqEZCjwdPG?=
 =?us-ascii?Q?LGUV1p+YKyQ9KIG5hsF9MMIllgvtSr/dz1fPK5UDAFUIueQ8UGgGwB2cLIhI?=
 =?us-ascii?Q?Ck+JxTOIwHVYfeO8wokDU4cF2hf0xtxc+CHp5bNAzwISnAR/hBx7zVEJiSra?=
 =?us-ascii?Q?w3QbAiVRtGeiv1lySccalm/8abzFIP6xhF6Q6GNfN4E8hhFUwztS/BNfV4wj?=
 =?us-ascii?Q?72aNnwOJdGEBZloUHX3hpYsJr+lCCaG5gQmZC3/Q+b4a6kMX6MfedAcj9h2g?=
 =?us-ascii?Q?24HmW/9XmQx651ryBafzmq/y7yZC9xK0E6AeY5Pktwtp1MmGSnNXpy1tn7jb?=
 =?us-ascii?Q?P4jPhsk2IxNmnLZgwF2NyaJHP1aL580iggypN18//fsrVqebH2UOE5CFluBC?=
 =?us-ascii?Q?hsTEa6MrFBv0FjR3K0s5KcCwGQKYyzyu2fLqPXfBVvLjhLJ5GBE8F8nqmlIC?=
 =?us-ascii?Q?6cOuaMUPebgcDQ4nMjie8U9pqk/QMqHJ/oEDfS/1ZYsFxXJLItuzVfq0gSMY?=
 =?us-ascii?Q?75As/bwaPIPnXeCO4T8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:08:19.6171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a856c81-4c94-42a4-cb13-08de3944d921
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7806

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

