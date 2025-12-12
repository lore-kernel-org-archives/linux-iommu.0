Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D521D00A
	for <iommu@lists.linux.dev>; Fri, 12 Dec 2025 06:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519708; cv=fail; b=WUJNnrCzdaHEAQha9ReC0cfZ7nLfydm6TnLDl7nSvp7PToVen8Rq9aotaFOMNYGoyaxXzbaG2iCy+ilkO6CWRr7QcZykjPPA1R0sssUF1JF9vRP/d2+UPjyikPH6ejGGYXv5Am4bx+ArN9jwlA6ofah+xymmcRFcD7ApJB34zDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519708; c=relaxed/simple;
	bh=9wmrQjoWWrXRURNMcnYEMqJOaYY5qYcU8NQevb1v7tc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MF7L1L5K8skSr2DjEN9nTS+EcwlVwdb/mTAL/4dybto+3AG9uV4rfEUEFKzgXom3AP3WXZftHHlYgh+WNpRDkfbv9aoRVza3Z5BqrtnCmOKTCNW6NFPd/ac99px6thLHXpOTo5JlSrv3mDNv2QbkDgAEXjQJLEKZRZHNozsy2YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yl40OPPo; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yl40OPPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwhg90rnVopWOXyrEK8fVUpL5KM/iYja32FyAWI7o/k/gbF/QRaakCxFYADA2njf+L2c6Ymtrp22AXblLpxx/FxmaQSLv5DxtFDvNT0Skpaf/93Ggnb6SGxnLjfWgKzvZisD4rLtFTyLW8V7KL9QbRr2XJUseJTmwwTruAqPgzX8gkDdDS3Q5TGzGqTTsQ1nwWN9dqsci+3YdxLjxHorzlR2BEg+x1hoQJpINyS+SEyfJhjLn7a53D7u4+pta2G+HnR4Pyws4oezZqKE0ssQcQWriR1Zns1e07tvRRupdw5SuJdN6JjVmugNk2S8LLZkJUZdDOzOh8s/0X9bfNquyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3bQexVRQ3bHEI888o5yLnVbZ96jvRxPaoBj33jsOdo=;
 b=TVfu020i7ucGeBg38H0e5Ju5Qv00PEOyO+BXqDC6me5VTY03Qy8dgScF18gDReE6HhQN5/7jKEpXt54lNnzMlTHsFJb9dCLcE2YHTyHcKFNXA8ilcPNaJehLaarjQcf7rKKcM+1zE4gW/N6AmodvCaETsAMODAdEl6C9G7ua7YgsKbDJFnqSw7RwPU+VTNN6q3p/NCAZ1ACrKf9URXJq10+GWgA7GZb24R5J61nfzvPkVeDW8dKGxKAGQsgNOVON6uBrEWVlh8ome1WF2dK2h2/oAYNmLqzuMmQjB/vWBwpewebqfdIQEZo24ZDg1HvmzDo9edC5TqXcoUkAgzs5aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3bQexVRQ3bHEI888o5yLnVbZ96jvRxPaoBj33jsOdo=;
 b=Yl40OPPooClD45jxuyJ8jEMPvswFDVWprdr9f4T24LfFZX8o8xW2qJnZJNKEOyE/hj06Nd/NgLt0s5vUbzD5XyOSyu4usLgGjAyuNsgTHP6EVNZ/hvCyBkwEjhRFMVRPAZBWvO0wSf9fdx3Cgn+CWoCxRCq9Ov1+ELmDDWjsHgDypWXVdOucxWInW9vtIpffBjxn2OXzFaqhNHrleV7OBWVpqo5z+MPVS7OmhrVns3tD4qwQAIB5wyPJxf0A2l1L6gH8EB4fd3kIL2Lp780iKpHgZHy4MTuAvQ3vapotOqBcBs4j/TD3fkR70WEowzeTrLyB994jdPwQbErsD6t0jw==
Received: from SJ0PR13CA0016.namprd13.prod.outlook.com (2603:10b6:a03:2c0::21)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.11; Fri, 12 Dec 2025 06:08:19 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4c) by SJ0PR13CA0016.outlook.office365.com
 (2603:10b6:a03:2c0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.5 via Frontend Transport; Fri,
 12 Dec 2025 06:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 06:08:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:06 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Dec
 2025 22:08:05 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Thu, 11 Dec 2025 22:08:05 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V6 0/4] Add device tree support for NVIDIA Tegra CMDQV
Date: Fri, 12 Dec 2025 06:07:59 +0000
Message-ID: <20251212060803.1712637-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 38413148-8db6-4dca-3a3c-08de3944d8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nPtS7ulKJLF4HqKG9EESALWNxJjRT7zRrvJKzp5BZOxBjlNereU7mAYo9vmK?=
 =?us-ascii?Q?dO93BbtNlc+lCTBgV5vFlbBsraxy6x0VJ+b6ga7zmrkMPKdQGubY1YFuJ6wg?=
 =?us-ascii?Q?gQYswcOg7OvA6ukN9OU/vMp/Z4X2jSIX/hRSwEWCwxy07bHmp5fJ9KihsniZ?=
 =?us-ascii?Q?eq1y28KkNthGX+PV259Yqtsavvb9AXZp173o4W0O/KdP2qvbiFl3ckMvLmW4?=
 =?us-ascii?Q?eey/JcWFteO3HnlyRWq6ba6w2Cl1GBHtRA6saGcum5GgbCfxV+YcKEDcGnAN?=
 =?us-ascii?Q?QnP2Wr08h6evIaEXByyBmXNnf3vSPsZsp+ZBTNZcoo4b67CXnpMDdc3pHEJm?=
 =?us-ascii?Q?WiTitiEqK392nrFW/EL6RLX4gFdXK7JTUkwOry4eYGqLhEn8gX3KVRJ9eOM5?=
 =?us-ascii?Q?ZYYR+587mS0bCbw79JzHTZS1ZVGhpk5ouISDeKvVgqmd/RWKdEwoIEJ7xOdG?=
 =?us-ascii?Q?n8hpba2g6W9yOcRADOpNVvntLe75hVrv35eE1MQWWnjOFaqd0n5f1RCuFkZb?=
 =?us-ascii?Q?jSAiv86B+0xLX13RWTG9bU/RnUjKmkSlXmTeehjZwZWG6t1ZwLuhGHbyDZ+2?=
 =?us-ascii?Q?3VhDJf0JPklg6Zr0yRfM0BzwA+vzNfu+ImdAWb88XXqgahE+zrSmCyBONxID?=
 =?us-ascii?Q?/RjEnqvDQvFRMHufGWukVTL2wHAdy7irL8e4k971coW/ImTVlVICShFRuD/L?=
 =?us-ascii?Q?N9f5SZoyJGiSpyWZDR9Ih+bEDgjHGsdppkJjuPEfS55rdI/YWTxkg/OipwbS?=
 =?us-ascii?Q?5hF9mJTM6B59AW0t81NCU3e2jps50mRHMpeDqnzpDn8FwX38EjU7u8bvbOOP?=
 =?us-ascii?Q?Kfs0hxoH2395VlAhksj6TU2TrxOhCykrW7Lub0kIqZmEj5/kTv6Z2FVNoQVi?=
 =?us-ascii?Q?eTOqRf2nVGH5JNuKEkKjEdGmVTXOFQGMz6RokTHjec5L7JnIsPzKKxd3xBJy?=
 =?us-ascii?Q?qsxsN6LbS7RJcqj+SPpAV/LFzN5zWrd4lPVw4jJNkqsae/DVXHcrVAMZlUf1?=
 =?us-ascii?Q?1ZoJ1X3zIdxvERdUP1cb+HSwKDJnsTsPIniimhpD5DQrEPFJKJmBQKwTbguo?=
 =?us-ascii?Q?VDWHQotw7Xdp7Lgpr3JJt/K1Tb/iJCET0rBgvR6OsNFH3iUEWVMYPV5g6KGk?=
 =?us-ascii?Q?uGxHrNoUN6c9wQrxvwLzqU8AQjxLUUTb1cyF65YiQ6/CrR2dyxxvVyEoLqyT?=
 =?us-ascii?Q?wr+k54EvgQkgfrB6kcmaoYXsS3dMxJNonagd3zoX8SHlY9lLHkX037uQOBdm?=
 =?us-ascii?Q?PHmJAjohjuun6RMSWhS1wJv+IRjCV8qoOxLpLI71J520WTPeuoa9v5ua9FCh?=
 =?us-ascii?Q?NbT8ftaugbSLblkl3E6DWduNr3UYV+aFXfCZs7MY8J8PZG1ld1XPvcqmoJp5?=
 =?us-ascii?Q?wNlWsLgMO6tJ4z8u48b5dEohD/4+jajfR/6A+uITiYOMmQNKH+cGQvrBu64G?=
 =?us-ascii?Q?xuH94FJaXmYlNGm5ppTjpwVTIRmlWy4iGltGsOCPTD74rINYIMKbdSvQtgnJ?=
 =?us-ascii?Q?QNv7zTwxh8UzaVJgoCb4R9CHuhO23kKir45lsCMEvSsGOP8/ZG4q2xHqeHtj?=
 =?us-ascii?Q?PCzz3U3OwCwlwLIU6CQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 06:08:18.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38413148-8db6-4dca-3a3c-08de3944d8ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285

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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 34 +++++++-
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 84 +++----------------
 7 files changed, 168 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

