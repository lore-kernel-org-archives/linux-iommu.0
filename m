Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4DD36402C
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 05:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283398; cv=fail; b=Wp7BzLXvJXnR22NdFy4xqiYBBf6KVMx8nW8QK2rdwN9+I36sO2YXT/9XeXv7wao5iJDGVSRRwtQCvMP9xaUs+UAr35VIdxdkCyvyQeKwzCGchJwL4xmrmcZbtKk/B+XizJWA4hLtpr8JABv1yLJ10IuqL0O+xObjaywD4+UPYc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283398; c=relaxed/simple;
	bh=FaFI+zST2HFjFnNamkhSaZIjoweS4HsGqUzXCmNwvWA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tDZpl5LLGrPc2T2o9L2z4Za611eVHYWtjNAgcC3JmncKjFQqzLTrUTlca3e82/m+ij6RYtrpGgMlVAJ4lX/iTV9ZIYqL6pTkCbHsjncOXelrVnitDXcfzpfDgtufreKgqKbSQRDfEGIhhwZ9gSOy7N2vp855+X4uvTHJSntLaeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aS7yR0PZ; arc=fail smtp.client-ip=52.101.85.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aS7yR0PZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IodJgDKHn2LZ6VWC6C92dR1lofufMHHJ0N/Hk6vXRaNY8dACVHf4UNmybeeGJd5K8TYCEt7sAIjTo4OV5G6nb17DdDgPphrfpV8tj++CRWhrE7/cmozcSEDM61UsFs0OYjJiaf3mwG1g5bZcnRlep2VVn93k25O7pDehHfyymYqJ/l1WTnG6dFC6J0RLoxgSTH8JSdlj2v2sD7DSQIUCoZSIK+8TbMwmvnH8F/zBIuU5AYtcpbAKAzRpjEO1WZr2SSLgkZ0O0lpyVNRswY4+aZvu1GWX07SuZxAQUJZSoq21R+U35PDkX6eofcuBEHoa4ts+CYvfE7QRqUzJQSDrgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg/3Cpjt4ek9cwMLQP+EW3qLqhsqvDCEbggNWjehvro=;
 b=Oq6L+yN2WX2rzILvqXo3cKzMunE9IyyZhQux5LxId+B6iP+9RW2f705fBi5ESPhQmeypmKVqWByR22h5/1+yb31lrRcwF5X89jEnfo3rsruZJPZ8z4Uyd8Nd0TGFUX4IaCdJ+Ws9D3l5lFPaOpRWZyzpIhqmZzDi7VGOreYCJS8qBDD/3Z9OJcuFXA7nq2z/sjUCnx/NmOs/+6k6xkntf99XBlXYcvOxr54Y8m57aelxQxHbsYheG+zydzz0aIDWE4krqBNzcgaCtmFK+/Oe0LmUGWwsKRbukecx8/XmGb6tAbmFDc9ombY1GitUMdHgwkaFTShNewt2QccnBuQg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg/3Cpjt4ek9cwMLQP+EW3qLqhsqvDCEbggNWjehvro=;
 b=aS7yR0PZcjIfS0PHWfv9GqsVXrAhpKHLk+a2mDXdtCQXt0QINsf7Y9iYJRsyyWg+W4TiNosOr505dqAWKv9r7vMHtYKG+ClTtHIi/yU3fCzXovyByfZJ92jAqa8BnnbSdt131ydVcSm+AhBIcywdNMO/UzSXfG86+PDtNvlLL+LAILlUJoCg5aeQcmqbpEyR56xiErCSywV7iakkmFWA8CoMTM4tP8h/NjVB9i4Bi9UdFCp/bCiMISuvVubnzmkUHp7YGtV69Wcqcd4NKr/XbpMDfTgkitmvYWYtyzAU5NnARo3sZTtc3T3WPZdnafts8lSlQGnhanhnx0BYucxjXg==
Received: from PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::16)
 by MN0PR12MB5833.namprd12.prod.outlook.com (2603:10b6:208:378::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 05:49:51 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::3a) by PH0P220CA0011.outlook.office365.com
 (2603:10b6:510:d3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 05:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 05:49:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 21:49:38 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 12 Jan 2026 21:49:38 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 12 Jan 2026 21:49:38 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V8 0/4] Add device tree support for NVIDIA Tegra CMDQV
Date: Tue, 13 Jan 2026 05:49:31 +0000
Message-ID: <20260113054935.1945785-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|MN0PR12MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 3357a5cb-957e-4e07-758f-08de52679185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8tTDW9E0b7bHW9Idm/A4UQcgqKe9BAjUQlHc6zO0OAqmjUdLnw4FKiGUYJv?=
 =?us-ascii?Q?cheuojGHWkOn+JUHyT58rU9dAfI/VwtyD/i0G5iHB0ciw3NhYUEyxfmyBeT/?=
 =?us-ascii?Q?Ise3nR955PaMvHKDtC5JX+zcv+rRzhDoBy3BaXfDS+24fvfmxwoUW+8dZ8H9?=
 =?us-ascii?Q?XiOdnng3gLzCLW0UvT0ppcpYDqq+ODqR6nM06h8YVYsHu4B1n70hU528ldYq?=
 =?us-ascii?Q?zrf0MXqHINHHiztt9iBPr0NTp7krFp4IM/E3vTIf0tWLqgGvbZBtsq1X6ESI?=
 =?us-ascii?Q?o73vUhpRROL55Ux3cdNsw+LxAoufPFMv1bq/wbCpvC9Pi3sjIKbwWgl/uotF?=
 =?us-ascii?Q?T/wOCxGQszRyYzoy0C5LfP/9KllqGRf/sbGdeW9L1FJj5c34FM7t6ArKYpU6?=
 =?us-ascii?Q?FhrkPauMyy/HiAGRNwJvMOmX8CLHAOt5w85aZAMIv8hzCgsGMXaK8Jd1VjAF?=
 =?us-ascii?Q?vJqEL6eOZZ1hmKocinbmUHTnJj36tNm4O1nLMgJOSuZT5zN0ifM8S14JgUyE?=
 =?us-ascii?Q?mQPKIJgNBKXEvsM/TV4+R8rAonb2LUmim5udaK6HrFiM95l2VQeuZsC1L6NL?=
 =?us-ascii?Q?GQcTB3I8TPzBX9Mb9C02zH906oCIKSowye9cgy1NlfgIHWZBAQMV6jXiujg+?=
 =?us-ascii?Q?x8qB3TjgpHCSXtvO4aExxPCEwOGrtEMMtMtV1jDruioPCTinStOS6IBnMS2s?=
 =?us-ascii?Q?nW1wqGlgT8FxqsZn9BETXN6BuPzCqG2csvfSTRbPg1a+r+/giOc5T6Ymj3pt?=
 =?us-ascii?Q?NbV3OJX5dcpa7roROWHbeYmGLleNMOWZMaSiQkltL8b26P640dWNTRWU6cSq?=
 =?us-ascii?Q?3A7miOH2MZQmlYIl4KsxN9BVKiBxvaoaFFxOWkOEZdDePatfUv3qOBw9fzss?=
 =?us-ascii?Q?XRsogoulmqKPBhtq+9YA0QbN977uEOEGBptvErGkOu+O3qImFwGuGjhkUuBy?=
 =?us-ascii?Q?kSMSM9+UAO95NPWBGJUGQwqF5LGqSQJ1XeS4itpFv0eK2KQ7SBQjCC741pM9?=
 =?us-ascii?Q?hkZ8Xp1vVPp/b6di8moQmAnWLZHe66eW2MAkUeC0it9mllWOHQX3ME/TV9oD?=
 =?us-ascii?Q?n4uZSsp2ypd5IK30roaQBCUMnXBmXwvcBMraGR5KVPiRe2oTSsISeIuCK4Au?=
 =?us-ascii?Q?MEdsBRMbLPqRmHCCHWRgDbc+lEpyADrNJnWtO+8l0OdoBIsWrkGbXriOtlgw?=
 =?us-ascii?Q?NsTYGAoFmcm1PwyGmbV0lZlqk5whmhs7rQGo0jUMOc9dPRfqKeigLkAszp/9?=
 =?us-ascii?Q?P/uCg9L85mHd0tYpNyDp3r3L8bALq40yLK0wNuyJAGu5a+mok2pSorTEVpLT?=
 =?us-ascii?Q?qzl62QEmBHgxgC1SCcgPWBX71Agh1guccb6gqGumOoHQAYqfWVvtfvWUp40P?=
 =?us-ascii?Q?s9ILIp1I6M1f/RWvElcZBiFwmd9E7gsdKtn2w9fBKDHz8Pal7Hdtlfh/0kwj?=
 =?us-ascii?Q?MKHthtc1w6lEvwPApP03l/kYLedA89F5h+MsnUMBeL/WE7Kks7Kgw4BIdW7y?=
 =?us-ascii?Q?FCkU3khrS9zE2Y5yt87QmM2noFuos0TLQ1M/uT7pefyNHIlvD/LRQOn7y9Tt?=
 =?us-ascii?Q?484bjc97FGmKpSehEL4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 05:49:50.8783
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3357a5cb-957e-4e07-758f-08de52679185
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5833

This series adds device tree support for the CMDQ-Virtualization (CMDQV)
hardware on NVIDIA Tegra264 SoCs.

CMDQV is a hardware block that works alongside the ARM SMMUv3 to assist in
virtualizing the command queue. It was previously only supported through
ACPI on Tegra241. This series extends the existing driver to support device
tree based initialization, which is required for Tegra264 platforms.

The series is structured as follows:

Patch 1: Decouple tegra241-cmdqv driver from ACPI by replacing all the
         ACPI functions with standard platform functions.

Patch 2: Extends the tegra241-cmdqv driver to support device tree probing
         alongside the existing ACPI support. The SMMU driver now parses
         the nvidia,cmdqv phandle to associate each SMMU with its
         corresponding CMDQV instance.

Patch 3: Adds device tree binding documentation for nvidia,tegra264-cmdqv
         and extends the arm,smmu-v3 binding with an optional nvidia,cmdqv
         property.

Patch 4: Adds CMDQV device nodes to the Tegra264 device tree and enables
         them on the tegra264-p3834 platform.

The implementation follows the existing ACPI probe path to minimize code
divergence and maintain consistency with Tegra241 support.

Changes in V8:
- Changed CMDQV device print from info to debug.
- Removed the CMDQV example for Nvidia from arm-smmu-v3 bindings yaml.

Changes in V7:
- Hold reference on platform device (impl_dev) and drop ref on ACPI
  device (adev).

Changes in V6:
- Added Nicolin's patch for decoupling tegra241-cmdqv from ACPI and
  rebased other patches on top of it.
- Removed put_device() from DT path as tegra241-cmdqv driver takes care
  of dropping reference in remove callback.

Changes in V5:
- Guard ACPI functions with CONFIG_ACPI to fix build without ACPI.

Changes in V4:
- Removed platform driver registration from tegra241-cmdqv.c to avoid
  duplicate module init/cleanup symbols
- Fixed the ordering of properties in CMDQV device tree nodes
- Added "Reviewed-by: Rob Herring" for binding documentation patch(2/3)
  carry-forwarding from V3.

Changes in V3:
- Remove the Kconfig dependency for CONFIG_TEGRA241_CMDQV
- Drop the reference on the platform device after getting it from
  of_find_device_by_node()
- Remove the unnecessary "nvidia,tegra264-smmu" compatible string from
  arm-smmu-v3 match table
- Order CMDQV nodes in device tree files according to its address

Changes in V2:
- Updated dependency for CONFIG_TEGRA241_CMDQV on OF || ACPI
- Changed maintainer to Nicolin Chen
- Removed interrupt-names property

Ashish Mhetre (3):
  iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
  dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
  arm64: dts: nvidia: Add nodes for CMDQV

Nicolin Chen (1):
  iommu/tegra241-cmdqv: Decouple driver from ACPI

 .../bindings/iommu/arm,smmu-v3.yaml           | 27 +++++-
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 ++++++++++
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 ++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++--
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 35 +++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
 7 files changed, 167 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

