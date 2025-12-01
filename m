Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548E2F068F
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606768; cv=fail; b=ntfh7Y0y6nQ0a2Wp4Cs/F5kt2qN7Aj5CJ0zS3hQU2WQ877TCeZlHYnhOpveL6rg6Z7iqEonKchyouG1hjdOal7+7z1onNn6A0x4YwwjNGQ1V0xHnPW84lsxE0Epi3cRK9XCOVpAhCvx5x6OCDR1HE4nghhLr1gqhZUZuhKAkN+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606768; c=relaxed/simple;
	bh=nYHSNKIYmR4fY/XiI7+CiQyL0OEgqrapiqe+4UlQUJM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CyTadP24DyaYIiL6WSGqZZd69dfHujjPdI59pA1JJSy9QzIxk0DmwPmgNeUMOR45cIjL4LykE/XQHalvNwN3s+/4Z2z58L4j2p+cXJKfeTg8WtwlWnkMNfoJeygeCKafA8lkWbpleK6mfW3iK0Yhwosep1vx4d0Oey5hyPPwgSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDQcQXpn; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDQcQXpn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY9j+iIUb2iCF00puz2Nijy0jkRCTZYbiw/vzwhGQXyLRWAe0j8zRRBhDPl8h2YCg52VciSdBA1AruCIQOeaV2zZ14aOb7TALINNAhCAP7wOGmZKVhw8oIQDNCIUVyOcREFwc4hussJJPqEFG7NdNI42rQurV7jzQFSVfIgOup8VgXp/4rNRZfLwHVhX55mjymZVvwlHuWh7JTaFXXU1I2Gvw5cP/x587qv1ttBPk0gTRVrEM7yk8BKCbB4moA9E64KVlhuiJqYJ3qO9qxeZsW28eLGETN1WBXV2m2DZ/D1z3IXMiGuFPZaA75NA5o3UNZdnJUCbMkqNhPKtK2A1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXwUY/m3jSpB08dVhE9LLq8j4HXbjpRTm1pDFlKvUPg=;
 b=kN8jUfqV2IuEDNJBD0n9Z4P49Dg30epCuCjaj+MCF/PxaBHJcU1AFj7GpISHvIuQPLq9tfFkOw/6SMCpXocOcv0145OTVeXpfjlGam5NnqsJx/7QptkqUtDZ0NIjYVC8pJFRiI1ICjtYfAfi8ulhFVpFSrkcc6usEsGQCUa3XVDDWRG3xokVWNFJcmXc/78D9xD4CBVVXhMvDGUtoMAUosAzUkGUK8pd9ueMBbx+1yWHWr6WQLCFIdcRM1QQ7vJSt9WRAFOh7NhzCzZ74QVRcvVdrIDNh39fC7Ne64uuEkKTtJOxcKHLXaSrIIlgd9kAUJWTWaqZ+hqT6O26wi53+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXwUY/m3jSpB08dVhE9LLq8j4HXbjpRTm1pDFlKvUPg=;
 b=ZDQcQXpn38HVFiF7Cg4a4dcZzmqbNRXYlnfX3zmYR+EAVvRyIVdreVdmKSY9Wnqz1MryY/rAKkS0lI2B6TpQB7tFt6zUHj4EOOx5Ntbi5mHuSeWFUTwfthP3mJYE4mdJFNiJQoTWbYNhL89yNcEq70Ia1s75PmhaSnJYLfaAumhRmQH6y42FSVoevePykukwjpNIrGRlXJxhgyD2NTQc+NuQ8turl2SPgtLsvdwHS+Se2pVOPkIFc/1yj+auFdhe29Y5abLJ3RMdcUqgWze8blQ8IkVsBziw/JJsYAcGBF2x5/5QWE23HSTMtfwigQtftmgk00ZQD1+FC4tul1sDUw==
Received: from BN9P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::28)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:32:43 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::ec) by BN9P223CA0023.outlook.office365.com
 (2603:10b6:408:10b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:32:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 08:32:22 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 1 Dec 2025 08:32:22 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 1 Dec 2025 08:32:22 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V3 0/3] Add device tree support for NVIDIA Tegra CMDQV
Date: Mon, 1 Dec 2025 16:32:16 +0000
Message-ID: <20251201163219.3237266-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 79f11884-4ea0-4fe1-2509-08de30f74070
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GaVMFJW4Z/MjYIiyga/KHkjJAgRfUQK00Nifti5EDtUOrhcUhO6QOVKmm8pr?=
 =?us-ascii?Q?Pw9OoGT2OMLvrSnewXFRw9D9HATzrtos+9yzKN2jHNOBHs3rWBHOR+f8RgCC?=
 =?us-ascii?Q?VBHzDpGC4efiaa0M6yoKuq+2+F+6j63amoTHcabmmwDBC8V2obWjvsCm1ka9?=
 =?us-ascii?Q?j1Q5MNNu+0lF2zm55EbteunNcoLjZddL3b1LNOMAuQtpd8EKPU5uk/XRaxFK?=
 =?us-ascii?Q?Nhmu5IAwZSuRg3PupJk/GGP4BObImMnMya19m1vKcUi4AeytfpgK4hqftJUR?=
 =?us-ascii?Q?l5Ibfi0c88SylzLRBFzSmCNwrNFX44zuu3GaM9riAzcMXtKwW5vt/0BQ5vb7?=
 =?us-ascii?Q?B7KBM2ma9WaIdAbleWaAYTfq/tkguq0HNojtLaASoSvZUUwLoz+GOY0/Bp/n?=
 =?us-ascii?Q?M/JsGG2VzRd0Vb0pQoeKtYcwWTXw42t/6tUX1kdtXdBsuj+40cpzi9d7NqK7?=
 =?us-ascii?Q?pfF6WryXL7+vpySKWwx2mtfF0yeNJmomYBZZucKGT1A2YNTrBMcB+lBKea3P?=
 =?us-ascii?Q?OiAf7qIIMfVgZN97a+tuff5xnu9JrwzhbJb+YmQrovXbUECzm8Z1sYW5PwkD?=
 =?us-ascii?Q?rTpnMgmZtQqZeqK4koHk9ABE5RC29zmnt07KbpmE2QCKUkA48jD73o1h/z2H?=
 =?us-ascii?Q?Co7dKnXJGxkh4QVlNkBVqVrWphtfm2XZ1A2wapEbJDS/Fjibv12/z1kXtf+5?=
 =?us-ascii?Q?CqbGvTas+VR2tWTa4iDKJ80nSyo+UYeUE3f2tpHWZeNG2sGjU1ks9sc4bsjL?=
 =?us-ascii?Q?+79WYMANad3e4gUT2jCtA+VymBfeWA+dsg/1l84+/7S/PUuoWos67207OftS?=
 =?us-ascii?Q?AxNjpsXjn8dId/SjU4co8QKlIgzQkbtEj3/cmPO+WCiW3FZQT7zZdsJPiMHI?=
 =?us-ascii?Q?eufDGb8LUQcqfO5FLgmr1EmsmO/ZEE807L9qxIWy/YqHa2r/yUosAjhG4h3e?=
 =?us-ascii?Q?ug9lf9UtHemF67ERfm831Zoq+VSfIlSMO9oxjxIkZ2K6VCq3YDu4jR3xjzG1?=
 =?us-ascii?Q?FPQF/VIORGTAAT0JYhWvNaZCmzEXWjy2SQRiQZPMwUcwb4UItxpAjkLExSyM?=
 =?us-ascii?Q?FGUKvsApicmHx+Uzhv82+vp+AviVE0Ay+cpnwg89O8t2WHZ+RBmihAcKTSQE?=
 =?us-ascii?Q?LuGK9xZ8aIAszjPrHnxld1GO2CQoo39Y5MU28TizBlnabZ3LTni2pJBDfKnT?=
 =?us-ascii?Q?7mO9WnP5sW2ujDRipvvmU4ypgIalNjiDlbPyzojQFetolhkXmVj+yW+0b4uD?=
 =?us-ascii?Q?5DpS3sBF9FqOUZLuFNjRKjkFSKbXxqGTRABBuAV1hDIMPhuzo7o9oMTuXhcj?=
 =?us-ascii?Q?SqFZq8hUd19CxV4bO6oUUAZKoMk1ieAL/XTtqarDHHAQ6fGdoZrp6zU/T+I1?=
 =?us-ascii?Q?9nIeYDhDmUaoR3OmGr86WC0r500E2/tfZchBkMhPSvCTlWl3y9CTg1d5fkJi?=
 =?us-ascii?Q?ZJskQBbgAqqmGCcrGfkiAO49z0K+Ae7aLrPhT35/1c3PWq7HklxLEsNwXwgZ?=
 =?us-ascii?Q?HVMWsqNQP5nvWk0D2A04CDM1Y3jglY8jSI71sS/WTl7qHxgMTPHDCwnLZF+I?=
 =?us-ascii?Q?8d3EhTL2pNu6+9R21eg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:32:42.7483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f11884-4ea0-4fe1-2509-08de30f74070
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349

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

The implementation follows the existing ACPI probe path to minimize code
divergence and maintain consistency with Tegra241 support.

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
- Added nvidia,tegra264-smmu to compatible enum for arm-smmu-v3
- Added allOf constraint to restrict nvidia,cmdqv property to
  nvidia,tegra264-smmu only
- Updated SMMU nodes in device tree to use nvidia,tegra264-smmu compatible
  string

Ashish Mhetre (3):
  iommu/arm-smmu-v3: Add device-tree support for CMDQV driver
  dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
  arm64: dts: nvidia: Add nodes for CMDQV

 .../bindings/iommu/arm,smmu-v3.yaml           | 30 +++++++++-
 .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 42 ++++++++++++++
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |  8 +++
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      | 55 +++++++++++++++++--
 drivers/iommu/arm/Kconfig                     |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 +++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++-
 7 files changed, 202 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

