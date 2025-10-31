Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D772F60A3
	for <iommu@lists.linux.dev>; Fri, 31 Oct 2025 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892225; cv=fail; b=ZEXIdNQ5P6eW44CaafFhdXKrJnFBPwVVwEAeDLs30kNY0ELS7QMKvMfXRFnpJ8Z4oNC52TMunR3TTHL4EfkylV0d7M2mLno7rAeUHtfe+SvpyYQksBEbzC76IJ/CZvG68mRSzoT2o85+NvwXhHLn5gFVb8tqACOGmwlFRqBqg4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892225; c=relaxed/simple;
	bh=5RuBHKs6FvHKQRndN7Wr6K7ZCCbLFQ5R9Vr2dOoko+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kVjn9bePZ26dB8sba341L2tag4YKcy93ZfKqHIMd0D3cYZ9LQ/F6kdzfo9knSe4YPX2gwFsudCwbhzm0B/9jrnGtA5O5znpB9GachjT3VRsncaI/S8qYB4ghZQwkc/ws2KA/MJpXcL2VtcbxTAuCmcpDqPPjjbkE9q9BzXC0uag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9Uk+fRr; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9Uk+fRr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mbgl4cmJFLMvpKPckxCq4QmE5a4ftd8pO+aUW8C6MUjXrWn1uQka8TqWd0W0u6K3qyYZOkp5jCRxgLmQX8m5rIBob+DaC2qJdB4f9OFAJKoKMtWaINU3zcRWbH4FtblU6KVIFcI4SS9Xofo7zcjb4pq433VSt58V30dFO8uDQ75E7eTxRh2oNT/3iJ8iujl5vYUpoZzgkeKOQALl5PrzAQoTzDM+wP6mzhNYg7t/sGOdpzQwwLh6YlsIiH61ZrC3LzdbmiaDoRWyVR0JHRppo1DTdcgtA4UwKKIj13eqatyFby0QqSmNBfAisxaSydiU3ol1R5FPFP7OoPdLoKYaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KE4b/d/v4lDqhc0it4uwu/ZqJj98Li0/9IFAXqIZV+c=;
 b=nlzfvwln1+inyzaUm0SVJBOcaJli3lINPOR5jmg9e0fud0wl+sc/Wn+ZR3j0FqTbshg57aP3PTOhEe8l/u/4zxmCUlOb1Nbzsg7TByf745kWjnfHloGUOZY3A7Xte5qIx2Zmu4BnGkXb+0NHDi/80E0/JbhW2TYpm3HQFh0+PLYoo33ismulZA5pROA4yFJSjBKT78b/ToQjQcHxdTrbpvVAylTIA0JyVs81nbeEmNaiLWZ2WsTgg6GHeH6dmi4Yegwj1WHH+QVIIjXdvmf1XiTkDk2fkAXr4HW2GLMYlZf6DbCrBTf4VAw9KbIKEEXr2Z0LxKgSwcBaoXtzqtXE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KE4b/d/v4lDqhc0it4uwu/ZqJj98Li0/9IFAXqIZV+c=;
 b=e9Uk+fRry2y74XiS/ae+FDnmt2DmjQPwSb9UUIh1R9zOLNw5GR9TKvnz8o0TRkOXu7p27UQBoKWn7eqvxm4fgiLhafvRArNZsqFfYsGpNdtSNM3rRn9SyQx8q7DElfE2SyVmYWIxPdDHWRtntpfQ3OqoSy/oRY0t3I7fGPjXO3nJe1Q+Wb5rVwmnbr0pArI4KseChFLgubyao/vKWvzOwREO25XKcsWOutTJQQ8PPVGH8gF24uF2K8NNsolk3P44BfN2A57zI58HZW0i6fpc1pJiRD6UV/EYrkjTuy0n2nWoOkoWej1J/rr0JI1rwBzL4qAle54kUM5mgTdzLckQng==
Received: from BN0PR04CA0129.namprd04.prod.outlook.com (2603:10b6:408:ed::14)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 06:30:19 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::b4) by BN0PR04CA0129.outlook.office365.com
 (2603:10b6:408:ed::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 06:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 06:30:19 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 23:30:04 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 23:30:04 -0700
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 30 Oct 2025 23:30:03 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <jgg@ziepe.ca>,
	<nicolinc@nvidia.com>
CC: <linux-tegra@nvidia.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 0/3] Add device tree support for NVIDIA Tegra CMDQV
Date: Fri, 31 Oct 2025 06:29:56 +0000
Message-ID: <20251031062959.1521704-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 85979348-b2d4-4d58-c718-08de1846f669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1blrZ+wBdFVvQ+TEL79TwkZ1Y4PqqodA6Lti66iBX6+i/N52/aGyReo/+Ub+?=
 =?us-ascii?Q?8CQaA7NIhOE0YgkSliqTIZWcSTdtFtrRU80uKEgmh5RMOFru6ISRakM1m1ho?=
 =?us-ascii?Q?1GTVvc+kREhvwXvCNA/z0ruo2eh6kL5I4T1nqUe6yzX9fltutPgleSfYw3AV?=
 =?us-ascii?Q?W4hJKGnryaMsTFX0IYofL95DLth/xrRQzQFGYfOPWc6+xVUCC7tO6FCkeDBs?=
 =?us-ascii?Q?WfyugbGeoYGqsxZtGWJSpCVA3vVW6CNokVc2FC1EbLysuy02SEAFeut2VqrJ?=
 =?us-ascii?Q?+dm/CbPc5EPNZnurYo8kFIcshTcMf0fVTNg2WNA1flz8XD1HqfIkF5Fj9pm0?=
 =?us-ascii?Q?ssd7z9jAB/ftMR8wMSWLGYBdByvJtSOPvvVPc2UMeu/TnvVWy8rVV3YboSno?=
 =?us-ascii?Q?yflmCUuiddT6WAI9/Pj3gOXuAGim4Nd63sgP6GGV/t6o0BADvWUwxg0xu38F?=
 =?us-ascii?Q?jtI0iHPYjQ5MqtHC8lolCEqE9uOyYTu4uhGD8Rz+UYaRjwTkL3WutUCentB2?=
 =?us-ascii?Q?IGwx/e4NeGyBLR5KZqjQTLYLm5D85TXYvfVmgpFoZqJjuyNVMWeGe9tjIUqG?=
 =?us-ascii?Q?pjFN2JZ+bYMZxFwy3DD17YNJdRLaTfpdluT8Ztj6dHQxGY1txKqcsgVkiCUb?=
 =?us-ascii?Q?91GIZWXzyOFlgOppFqKRfv7oDHTC65XfKyUTCOVsOOr22X2fyTuflr+2RbFl?=
 =?us-ascii?Q?X515MitkCdyftI0ynvMdddp/jexhIwtppFTU1anfuE25rTsO+PMP8/09q2p5?=
 =?us-ascii?Q?IaJyDIOWy8OhVY0YteZ3+VbTO+DL29NHkTkfDt3WjpnW8NMTwkOJp/THsgmU?=
 =?us-ascii?Q?yoXr/adb1edtxL2Hc0xoOuAwoS6IhOSeiZZfCAAYrAuYQHqs+AQn6On3kkJM?=
 =?us-ascii?Q?sJFWyEbi8ekBGy85WnfG1HbZOg1IflQekBNXR5aYLXqty+jBdSWkZ39H/jVp?=
 =?us-ascii?Q?22ox/ilHqd5L4yu1hZf7ME+MvVIOeX+rIIRdXMMoD5MrmPgX9JNGBFfUmpAX?=
 =?us-ascii?Q?0utee4h7P3mQ80b/Z6NYCH/iuDhV3qGXPS+ySMHSI3gN7WX6R4O84SsSm3e3?=
 =?us-ascii?Q?tTAjlC590Pj+dToST1nSx4Hz8TVCocZei7JMF3oYGzobRSusFHHeNvbwsYUc?=
 =?us-ascii?Q?MuY6JvxCp04XWkhSV8u6OL0jg7O095t7orEXJ8/zqUaX83+DppRDQK698vg/?=
 =?us-ascii?Q?AcS8jMira7U1TLwU8a+IN6lC0icWOSxliMy0ivH+jiGVhNIwY57uzEu8gaAR?=
 =?us-ascii?Q?sTk4l/2dRJAhdyLQBTKEij0SXkmrI6RaeDVJdA6VQuesmbS3xDP7NYZjzwLp?=
 =?us-ascii?Q?G8ofWlgYvKtA2BakM40ngrEiyBcSyk6IYAiQQ+s3CtCnKoZvKFt7T+lBfSil?=
 =?us-ascii?Q?g3FGQDLc1qfxkJ38hfxpeTAUdJtQkJG6vJamOjNQtj/TSBVOZ2gbwcjbP91/?=
 =?us-ascii?Q?GlkybumUOaolsSLrE4Kr3TBc7FablwpbPET3EhJxmVpmUk7QLbbtjk42yCKx?=
 =?us-ascii?Q?MHewUDZWgISlrn+lV1p0R3ROR4dZhzipS/qRd2ir62MxTUXLqQltvy6/HtQO?=
 =?us-ascii?Q?dGeUSBqTu8bPmsGGHKRKH6J7Pl/uplDx1TTOpXTO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 06:30:19.2226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85979348-b2d4-4d58-c718-08de1846f669
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260

This series adds device tree support for the CMDQ-Virtualization (CMDQV)
hardware on NVIDIA Tegra264 SoCs.

CMDQV is a hardware block that works alongside the ARM SMMUv3 to assist in
virtualizing the command queue. It was previously only supported through
ACPI on Tegra241. This series extends the existing driver to support device
tree based initialization, which is required for Tegra264 platforms.

The series is structured as follows:

Patch 1: Extends the tegra241-cmdqv driver to support device tree probing
         alongside the existing ACPI support. The SMMU driver now parses
         the nvidia,cmdqv phandle to associate each SMMU with its
         corresponding CMDQV instance.

Patch 2: Adds device tree binding documentation for nvidia,tegra264-cmdqv
         and extends the arm,smmu-v3 binding with an optional nvidia,cmdqv
         property.

Patch 3: Adds CMDQV device nodes to the Tegra264 device tree and enables
         them on the tegra264-p3834 platform.

The implementation mirrors the existing ACPI probe path to minimize code
divergence and maintain consistency with Tegra241 support.

Ashish Mhetre (3):
  iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
  dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
  arm64: dts: nvidia: Add nodes for CMDQV

 .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 +++++++++++++++++
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++++++++++++
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 30 +++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 +++++++++++++++-
 7 files changed, 186 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

