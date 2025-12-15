Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE3270ED2
	for <iommu@lists.linux.dev>; Mon, 15 Dec 2025 06:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765781326; cv=fail; b=a7r32R3uVWmq7/lPWdrtPOvtTDpV8TnEn2IpYAMWfImQGu5f3VgXJxf9PAEE+i47Dq79UARM9UzZWGFvA+R08zFHPxX8JeAxMVS9IaUSPisxtTAIQmTyF1t6joglLiizUZcqSDtRCu00fKM9e36lt3A2IVz8TcKq8lc4POQiMLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765781326; c=relaxed/simple;
	bh=pxNKRsg2/+fO+cFtxcwkrqvsySzMgZiciou3zmx+SKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xi+8QDW2YYsPm803464GRDLIp2RZ9JwJP/X3X3c3i/9wdAZDma9SqTHVJb5I3r1SJtU+loosa3OBoc8a3gU8D8JyqEzwS8VSwAMrVvv4DxjMS0lQ72XjaRqCCxiRhhKhJRCH5HnkDLKpZ1Uri4fXTFCecmC5MXirfr60NeCYwqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q4appRo9; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q4appRo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L570mu6Z9mgNeXvEwNzRMfBcKOVU6YQZT0ooqVo2tAyAPGdbSxzASa8RwdzkaXl28FztK9rjJHWgE/HP6szsnSG4+cwtaf5LW60h3yE8RR5Y8eOIhaz6KLYG4wDTtQxV5Xw2S2SFI50rve1PAnDTUsAVMg3XEFM6HkW8pwRYCbf/2Rj5hky/XgL4X4EuvAA7OmXUa3Xfzvlc3YDURDwvYu9mcTO5bIrFcOpt82UX9XMzX4P7KVQP+iCep3kojTu4xMD3npKVihYq8a+4cI9v6tZNONL6+HtlQe5YqsDviBTRJPVbFQ0N0Dg+jdUd9zGcec0OcdEm+HpI4nesRKLopQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBGiHtHdTxUSK9bgrAYUr+Vy8j9DJBivzTETRgDWQYA=;
 b=dk1aRJRJ4x2VIpRmQ1ldzG9yuuzG+8NvDOb93C6rHfJAhVIMdeJB/YCm/WOocYnY2IAsef39w9bthhrJkn8xXhxZhzEC89J25e7ALLqbCqrxT4S1hhRMkwXky3+7Bt8z52SEHF5lNu/jbdhNgjUzKM+1KXVgPqrkk9YG8M4W2cVOFNXkzG6/5kaDNwrUjNE7wZNTXQuOoE+oYYbHwQXse4dsPShtHnz1R1JUQwBqCYtXmDx8hYSudbZPYgSUyVgXd1ivcfxkpdsgeWH9IB8ZVAFsn8bQOQ6EwD2+PDVp2KEl3ckghQ3ppMxvUvrYg1+c6fAr6JmL5clwrRB4xLWbRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBGiHtHdTxUSK9bgrAYUr+Vy8j9DJBivzTETRgDWQYA=;
 b=q4appRo9WEO8Zoy2F0GHmbTmRa5gAk5vIsc9nT0dmAdlX4H/yc7tgkCSy6ynIUpwvbnxZC1PkU6F5SzkSn1OVUBLllFSRKPc4t1LSTZg4rE7G7OFmJ7d5F/ef1CAsjnnO/nO6+m4cKo8upeww9Qdi7FIUYrXe3IkwrMCz8gYM89rzMlhE6tHNvr5u5a2eOW8Vl7VE6yH4Sv3kSpQaeERo1lAuMuQGw/LGWLG1fgYCX2kUvRBpU7msQAwbG92T/CTr9+N0nI3+aN85B8MDRMy/kFWvENhiyoVLdwlLTGLd/TfBhRcNvgEgAZERhegBdHE3DaZgg0rV3DHBGbe9i7yeg==
Received: from PH7PR03CA0018.namprd03.prod.outlook.com (2603:10b6:510:339::15)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 06:48:38 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:339:cafe::25) by PH7PR03CA0018.outlook.office365.com
 (2603:10b6:510:339::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 06:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 06:48:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 14 Dec
 2025 22:48:22 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Sun, 14 Dec 2025 22:48:21 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V7 0/4] Add device tree support for NVIDIA Tegra CMDQV
Date: Mon, 15 Dec 2025 06:48:15 +0000
Message-ID: <20251215064819.3345361-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 71955fd7-78a3-4bff-eb81-08de3ba5f99a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JfoPainlOER7B33OHIGzL4WUPZ9b6GWs/42gWiQSFzVxwpo7JvcA6K2IVP6/?=
 =?us-ascii?Q?D+jaEzZ/vcgNaSmHmOaU+3fHF2woecVg18GnUFWcDeF2h8an9BmkacEyAVrd?=
 =?us-ascii?Q?Tcxutq+8c7oQzxLy64MIFkrT7ArLcu9EvBsnZe8KfQh06q7iYm+HiOvOIhbM?=
 =?us-ascii?Q?aq8514vuBsVWhb/KAAKhjzuLjDxnARB9fFHiNLdu9qaWpI4J588x3drWF6VT?=
 =?us-ascii?Q?uFpNYx1CerrlM0CyY1JPtSm4ShWtj0fCqMDc7gxGk5FU1VWWafVpGx0erFKF?=
 =?us-ascii?Q?Grh45hZwY5+Kz6/Xdq+GgGMbK1SbnvXG/RA6dAsstXZi250EFT1u0Gb5c/2T?=
 =?us-ascii?Q?xsjiQvhiCpU8UyfYnsRNXCpQDBAC9XIxNfJb91b8UP67EQrFM8Re6mbtm1Ia?=
 =?us-ascii?Q?KeCrSGknQobuSlzK6f3VGhXYfVFVZzshPBO/fO7oax5Rv43J6sVl3c6QfxKl?=
 =?us-ascii?Q?TKlYm3iQfpXByqEL2WAE981Ic5SJ0klIUBx5ljolXJKSPANeGsaOh8Nw1joh?=
 =?us-ascii?Q?O952H8hHaWnmGxC3oOX/ahsX52b0zKV1BP55L4UtWWbC+hnPWSSt6G28aIi/?=
 =?us-ascii?Q?TjKMQgKxfiOOCn8PPkI/gqtcA/BiR0+QqJp1LswgScAl/0bZJaylAdpU3GL8?=
 =?us-ascii?Q?S3KD4Cc8CBLlWd6da8fKyNXErXHdNpuh0Kt4xTN3MFcX0z6fNyv0WrVWCdHe?=
 =?us-ascii?Q?kTYKNO8p/MTOSesa9gq4eC6AOcZMtwRFMPSc349Z3tMQ4vkQ0oxxteIGW0Ig?=
 =?us-ascii?Q?8YKA1gGFXFaTtXZK6BA2WkB+T2rLZ3X/ZGUcp+Xi9d0zf9aVI0Yk2S9QTlsN?=
 =?us-ascii?Q?G2KkYjCS06HSPomeAaoEDbXA7pYt/M3XR1sCVcsWrb8upi01uEkOzbN8wros?=
 =?us-ascii?Q?aH8RXgd6a7TAruIAL5DMAIaHPRszlKo9VNTFK/zqeM3pb0r5QnWknt2IRiPT?=
 =?us-ascii?Q?IXinqdSGYI9lnhHPkn37//ow9FMu2GiatBafMKi/HCMysxqwwq20Q6ESWice?=
 =?us-ascii?Q?VqTJG5xS21YLHKlgzAT921qoA0KBEE4hnVRv/qDz3fQF8P7qJA1whk7KPhlk?=
 =?us-ascii?Q?C+U6hpRT0Fvy4MqsGDkVFOUGHy+SWOLaxt5RskkwpsSnc6ef5AX1ZN4ZRZ3c?=
 =?us-ascii?Q?k15O9zzfF/ZVJzT747OkxQJrhTGbIMEp3NnfmQz3YoC2M95/neeMOqSCJnd3?=
 =?us-ascii?Q?NuxkRPnjqu6FR5o0UZR7hUU8WlbAoN/K6vuFI8RYYkeIUIAZ6Z31gF4Bugq/?=
 =?us-ascii?Q?0Bw4yj+3l34WgC33RZRJldsxkUG9H7MHoC2rwdYrbDLeMSEglfeoky5ekk7B?=
 =?us-ascii?Q?u5bE2yqQcE/mbgZYJmspGM+xSEPwuuCw3IxOjVyRn67kU4L+hdepSBs2NDYs?=
 =?us-ascii?Q?HwQZDn7rGMgQJ9HrW0QEWkiUx4QT5p+1/hJlAzW5UCcPOzlEk+bJIYHWCXrK?=
 =?us-ascii?Q?BosL87tEOdwe6VVRj7jRry5JiesV2isl4lUlUPfc7Mn+9tkzenJo/o/0k1Be?=
 =?us-ascii?Q?kyqMAg2JfXtFTYh4HPhE3ZpI4eWOIH3c7yiTy5VJHZo/TwKdoU7JrVHRZTzR?=
 =?us-ascii?Q?T/w+/6Y6twlXQWrZCt4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 06:48:37.5193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71955fd7-78a3-4bff-eb81-08de3ba5f99a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566

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

 .../bindings/iommu/arm,smmu-v3.yaml           | 30 ++++++-
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 ++++++++++
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 ++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 50 +++++++++--
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 35 +++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
 7 files changed, 169 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

