Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010015.outbound.protection.outlook.com [52.101.193.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57612D12F5
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764055041; cv=fail; b=rLBNbEvdPBklJXPOZ6ExLB7Qp7wt/0+y8ROuj43Yah+6ximt+KTkfCEjWSFvqTiiX4hT2BjRIZqwTjOslbjolbhj+dYs5b5frZ9fUu3i0b6HTYXoQ1JlIEMYZ5tE/VnD7Suo5Wmsy1NpOZU1Qs+mHSGWPU57Lx1B2oMQ8eAh/RI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764055041; c=relaxed/simple;
	bh=ZpemyflQUjDTEBV5jmPRTfjFZe/QwksJAESn4W46NNM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ty3w3QIxtlJKkIbUAmARRokrhokaX5fOzOSZTHf0MpMI1BQ7vD6mymL0xfLftiEcEEhDSHkONbxWPIptibvDpJDP1OwHggkaJy1jASTNC3tMP+9ZYi+NLpN+1Zv+Mp7z2rH8nEE64crDpV/MJPRrXnuybJbMpjj4qaisY/XNPE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBQSmT8/; arc=fail smtp.client-ip=52.101.193.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBQSmT8/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtFSWU9Km+EexUD+5s2sLtAYHtgeWFtxSNQAOBMEMNQxQQuchyqRMLI1xve+TG+gm+d0hndPM69TkMy9/VnGpP1Y3WnO23u7FTwY+YEvKSkb+6g8h7NFFZ/+1nU4GRiHxiX2z41OpsqxUVcVOdomN70y7cZgPdtDa3x/hdSR3OE0hg+rQXgPx2/QwoA1qdPiw6XeAh+U+mAtkt/bnC5M9+XEgU1B9F2cC0Mk3y+kFGEgKuYoNVG44+EAH9t9AYoIKfyhQ+TK1XVFEpDA/eDIqBYBJ4RvXYk7rVsk2EtVuHoblMIJtNHi1L6dRmC80X+QNp0/67kfAWrlD/B0dZXVsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dte3k3gEPPZ6Jf/tkZoosO+03MgE+RPBUlzpYFEiLmQ=;
 b=PsdYB2kOOWO3gaX5b8+23kWqHtbgwCIkyHELAyHcRw3Zu6OkDxzmWie2iFp2dEdMTikIAXDAkG6lfpLwCkF6qoNDpyRiaF1nHr2Ar/it5J2An+k15DcDCSjOv9icYG6PRX/TeFBw/tsFcrVFZeXaog0R7tgTCvis7t4kIw4a/50dvLkKIbCCA1BqTGl3FE0tnMZlabj4Tt6fPvyad2rYETJmSOZgQF5cp6GATMlE9boywj/W0De1ncCniaEUiVYFpNUiFyhY1V0G1KZV75QhkeyppMmOEqXlbf7r5gzWyiUx0s91QOtSjJ2qEhaIDA3DW0Dhp02zYGLqN+qAMEKlxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dte3k3gEPPZ6Jf/tkZoosO+03MgE+RPBUlzpYFEiLmQ=;
 b=pBQSmT8/A5/WDRfQBG1k9zFrnLLFfv0WXuHFUyNaCAk/Ez2MvdUPXcQYHcI5Quc5RvCFFKu0NfkhZh5krAARIkUu0Sd4LLfpt7BSpY1EzSyiDySgDv4Nn/5B88boP4uv4ji6tcvdBM6mX7VJSXscgaDNf5iRA3atijsE0CBBF0CR1HFlMgscJcnJLtB0czuTUWmf1wdr7mGPOKw3X3QJWa9y5tMG4Qn/yhtLT9YImGDZZNl751Yy4PjoNfLVjzFhKLjy4wXwN4ce7SsZ+YS7XLTEpm2NAYJhRabqEt68HwAjue6HLhwiubnpv3FiV+FxpvUifrPMwJezM4gHLWWI5A==
Received: from BN9PR03CA0596.namprd03.prod.outlook.com (2603:10b6:408:10d::31)
 by SA5PPF9D25F0C6D.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 07:17:13 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:408:10d:cafe::63) by BN9PR03CA0596.outlook.office365.com
 (2603:10b6:408:10d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.18 via Frontend Transport; Tue,
 25 Nov 2025 07:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Tue, 25 Nov 2025 07:17:13 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 23:17:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 23:17:05 -0800
Received: from build-amhetre-focal-20250825.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Mon, 24 Nov 2025 23:17:05 -0800
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolinc@nvidia.com>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <vdumpa@nvidia.com>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2 0/3] Add device tree support for NVIDIA Tegra CMDQV
Date: Tue, 25 Nov 2025 07:16:56 +0000
Message-ID: <20251125071659.3048659-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|SA5PPF9D25F0C6D:EE_
X-MS-Office365-Filtering-Correlation-Id: dd44da85-535d-4e6a-f8e6-08de2bf2a7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NO+ynzoLGAy9dkkXbwwaur6R0jF//V+DU3qzqXQyDHODmHuJh0E6L0b4UseN?=
 =?us-ascii?Q?40fI97nUErkNL9pLvmngAKlbVsFl7XpOKYs9WgQLbzPmaala2Kk2w8dup8De?=
 =?us-ascii?Q?s/4DhgrQtNF1r2rjYDIgcpljO+nocrq+rZGzrYWNzqaM+mfp/kTJUvb7D0W3?=
 =?us-ascii?Q?R/4gZznpAUYwOCAiiCiarzMD7odcVX5UmjkK0tBj/TU6+x664y8WeaVKLU1I?=
 =?us-ascii?Q?faBVZHDs5iwpsj9l2I9aqNgzokiaxv3Afk21K8EXPpdA202Ft6cJgXMGJVln?=
 =?us-ascii?Q?3/fCZYVjaCHtwqQuZVpM0EzLp4DhYMXR5HmlPxnIOv5h0xi2+k+Vf14XRNAC?=
 =?us-ascii?Q?i4iKbS/W6jLutOUqmpuelqlfU5WCuNspf90J+FEcnMtREdoz2r/thbo2oKmG?=
 =?us-ascii?Q?va3n5N6j3EXVLd5TuKn+vDmHPLomWYaPHfBlP3jdgSfYt9QPId9R+8aA+5wu?=
 =?us-ascii?Q?HV6jeZ/GC8PUygA6dMFMFM7QDSNpMlde+/TQeA/jERFA0cKwYQho7yEG/cky?=
 =?us-ascii?Q?4HHHxCgyusrcrxxBNSfHKWwsK53JquehYtloF6ZWjz3uioSk1ph+MnQ76v5o?=
 =?us-ascii?Q?SkOwCnzlIUz7L1yl2N9gPPs+CQ/QxVRldE3PTs6HFrPTqmITpLvb4QIDYVwV?=
 =?us-ascii?Q?ohX5D2LJAx8KPK0fyYCUrn085sfek/m1xamAKEVgrzWKmolFYk83Zc7mUVAb?=
 =?us-ascii?Q?0Ix6ONTZUVv1QEraIX/AnLlDGiz0uk6ZdAQd8X1uOufeUEnflAyLoII6/oUf?=
 =?us-ascii?Q?u1/wVWokQ6wpPsyhafyIwY3HqOwydu20R/yFpjiDz34GZuM8Ek8NHhupS5BQ?=
 =?us-ascii?Q?uM3O9XXmkwF+WcWKCoTkwgp24iSmar+/me++xrelO6/7XDSVVTCP+71u4I/I?=
 =?us-ascii?Q?DTL2h0wsca1JI9Vku9BmOrWgIC3/J/0Hmqdv3VEEyBE6jopfgJ/gmGQUuWE1?=
 =?us-ascii?Q?Uz+Zak5V6RCpeRmaCBhNsH+oMUjDhn/NkxkW/OsC2mwGT3+pnM9S1RG9+gex?=
 =?us-ascii?Q?/UBHPllLJjrGfeLYD4H3YAPStXaFs4FNJmXiLvP/+J2rLFbeVjrfA4KrfzDQ?=
 =?us-ascii?Q?QbY3SM6DaTrcvBmrEtxtYAwjAcDkYDBUFanV0emmaJmRQi6cpwC2tcNAlyEp?=
 =?us-ascii?Q?+kwHqIJ40U6s5z6rvdGuxPDn/hzFX2rCxX7nXECfN5Gjj/e5b1ypFdYL4Htb?=
 =?us-ascii?Q?xba25Xpt6ctUO7v+YRH8VHYOBFYIdj+DXNxxpQYEp26yF4XxRA3T6ikOTQFN?=
 =?us-ascii?Q?LM9L884hcRUp9JTB06gHdbbTLfXD6GRaeSpnyNIVkz5YRWyxLDLA/ST3dhQr?=
 =?us-ascii?Q?r86zecXAzIEg0FkwgaagYp76pXf9d6XU4voaLTwuGFH2yzhxI4z/9NP9nOfp?=
 =?us-ascii?Q?l6ZCALRBrGcQkJSYn0rHGbe1y/mWG+xM7Xur+OAH5kVIh2eXjwnlPL2xJbDf?=
 =?us-ascii?Q?GGaczV3SldUV2jolxKy2URQTLUIltyecEkIgFY2VmJG2g/IdqmM/8aFGfLQv?=
 =?us-ascii?Q?Jf3Jy+3bV9RBsP/g351OreqtVQxJXRf2UgPxGjTLWXCmvjUwrDYnoTrKtdVF?=
 =?us-ascii?Q?TjQZoZHs7IseciV2X/k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:17:13.2087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd44da85-535d-4e6a-f8e6-08de2bf2a7fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF9D25F0C6D

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

Changes from V1:
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
 drivers/iommu/arm/Kconfig                     |  2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 32 +++++++++++
 .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 43 ++++++++++++++-
 7 files changed, 203 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/nvidia,tegra264-cmdqv.yaml

-- 
2.25.1

