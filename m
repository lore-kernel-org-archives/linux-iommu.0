Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011016.outbound.protection.outlook.com [52.101.57.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E5A3E5A03
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 14:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063750; cv=fail; b=YhQQEvcPcVH8zOOShFb1AX8F3y9Xejp8AkGy5mz840c0/2BUGI1kKc/cuXV35eo1MYhZV+Nz1MHjiL8f3HIuB9ileYAQjO7mg0RnPff3k+9h0RabN+vScHsH5PKywpdHx1MuDBP5/uRH/sYDXFhUBE5paeFqh76PvK69fdIK15g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063750; c=relaxed/simple;
	bh=/DkXUd3tjGYMPL0BwKNs/c39RGnYZ6QriOZuqnoXF4Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OJyaeoq13yQCb7lYdmIdLiCntgKa0ZaoFXaUkSbdRLdX4UmPCQ1aIBaFQczL55xzSziAePouQqdk50x91ZoPJfO6BXXRo+SP2kk7v6h6eNN4vlH324rzJ24EZX1sXZjn0gxQBZEMeHoA1Xqx73FrApzfHT7mX1g6QOWfAEH8V9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LLwnI20b; arc=fail smtp.client-ip=52.101.57.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLwnI20b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UtoNwKadthDtYKR033ArsXx961J+VNbGwkPuannIs1SMJNiA8E70gx/J9GCMBY1PlJ0LAlRzhUI8ZuxUQBvpT7B5yZvYdiP7zX7Ni9tbowcdxolqDBX7zlA4dr/+nCnOy+8EBGDK58Ml7ZS1nKoIyLv4m72NIYvUFEJi1OAJFRu34tUbG3tNdUg/lb+1FtDMKwp2Rdl7YQdc8ME+7Lenc2zJTbZ2mUBTCqYiXiec1tKMDrUT6GfOcLM53ndn0NIr39WAPghR6a2leFuILTETBuafrk8JEAn7sxrrdjfuankk/nhJAQokzGjH/QoHJHq0LMO9fDBzwmHEDGOhH6g6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRfskvUuBsi9NMGZ2E+RN86NGBzP+3qCCnStcv1GXcI=;
 b=YGDmxQyCuBW4c1OMaglIBsV1IV7pmsgh+h9NY064ikEkjXPpyihFJuh64JR+11hsk/opf6TnGjqJm1tYFu9U6GElgyCYug4KahQLlv9UpyCsNgxLWaMUfxnwcJcsF6cB0B7qleU1491PaKXZfUpIMOOrMOhF6WWPJKaXMDbxEclBQJESTpv+JeyfT2xd52D+KimUip2Ad/eOAALXVTKlcKwGBwy5z/OEJ2Ip3d/uM0XB0PsPcKcJ8clC9eEtUKB5IkgRT/4ZaS1MOFw6ARKsxwEAsRwedZsl24yU1OGO9qM8sK/TGj0YgixBxRk1SdMR79KWY25TKmorCCoFVTELxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRfskvUuBsi9NMGZ2E+RN86NGBzP+3qCCnStcv1GXcI=;
 b=LLwnI20b0NINd1l3JR6KoNIItdlMWj2iVMyRRXqbg5RqRtXGefw2sLeouZzDsbgPGdgthCm6jRAf/XUFrK0mB5pl/1MF8ZcPEPra5jgDD9rG3mBxCwejjIamW/reyFfX7H7J0ariyuXPZfqCK5NZmuzZWHJYa7MtKhy0UQ13X1mKwaqVdc23CsJfXJZh9JY6qY5fhY0tepVW9WTJMl7OLaZKGSDXq+GqwY2R3jGI8twsPPtXi5eIBtwLnFxZnDaKJiIu5axBjAmXy4cozF/wTV1MGGhbgCtDc/jPTRzjP00CYRheOuN5hSUayzJyGLkt+5B2mxAcfIDDh96Tu9Izqw==
Received: from BY3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:a03:254::30)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 14:09:01 +0000
Received: from CO1PEPF00012E63.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::13) by BY3PR05CA0025.outlook.office365.com
 (2603:10b6:a03:254::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 14:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E63.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 14:09:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:33 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:32 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 29 May 2026 07:08:32 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v2 0/2] iommu/arm-smmu-v3: Tegra264 invalidation workaround
Date: Fri, 29 May 2026 14:08:28 +0000
Message-ID: <20260529140830.629738-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E63:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aef67b7-8da4-4b1f-0e7c-08debd8bd558
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|6133799003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MFFFGSWLDU1qjukCWARQCgC8z8FQop3Ygkjl8TVXS+4yfS4fhsXTZVCPrCb0no80HE0u6jzgWw8UejbhhxGKcH3zyBaJOaU6ULakAO0qOx3ppsSd4w+6MfZNBmryvIo663AlWtb8OdWI21fSb7g7WXk9TheQ/F+opXx1CuiP5VNK8Vu7xEv9kbTUW16qx0q9BYDSC9OW/u4wGI750FIN7Uh+GiDbJfM2GaEMVrk2icP78RRmw40PCkKyFnEAn5EjYyCWouOHFM0JtRstb9uJG8sCgec6XZgQ+Y2sZ+Pvbl61DIIW4I2wKjQcWK8gwKb/gzjAKGVzYuMDJKZYRcY6Db28+qVix11chZLTruW0z3Sn69eemqCu0c5CmSZtAEJo+eIZPMiCDSMB4QqAmqNsKYs8quNNQj5lnIX+SmZ79Bpw+bJuwnROQfzTCvO09GnYhcGa2aEYTa0m4F5Cd9qGf5yjNDdwaDWrwqA3EbTdLLlMVgK2762UApn0KF5Ysdmf+XLQ9AoY/gwrUkKjbk88+6qQk9t8HbmYPn9VvtfbtQf3f3VhqkWSMw65RgfxyPHSEFrDA+kQEky86rt69+FU6eqOIyoq9QolIZg6hgZp95H5pG6yFDY4cvB8g3FonZqaAaZNdJ0EP2zBmJCsK3RX/zvq+VRca6uBRabpkEEHPI+7Pfwoz2henofagbTGBzrz5FA/X9VH4hKnICZJKmFYJ0aGx40vp3NNewk2xDwPuYI=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(6133799003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dFCCAmBjK/q9SH9v9vIwp0BI4YPVHtiyk7+j8FJ2PB/AjKWLBlmKcpWC3Ihn6iioWllWHbRbWwsP97w+5wccMAnKx9D15uDtv0LeeAuMVXWp6GFkrYRUIblkO11zGHQIju31rr37a98dY8FqBgCGeSpxtOVL82F/llO7VyOE3oP0idJTZ7u7gB+19wRikd4Bi+smz4NE55EeZ9Oh54TvJ6l+igCx4c7rRiFaG4fd9s9dstuS2njQej+QgZZh5b8ECueGOk2mJkWOn26wb1Sst5r3in6pzZXHDA1/1JjKa/ljfZxC78mxUFbWV173d5UpPdC9msO4vBgAgR03E4KwcyzLpIC1AtHObzRm5TW62hdbEkuBTkJzq65QHMxGuNQXV+WFHQwjcIR55Kp4KNzN8hWNFAEymG5STVLkBbz//RnSPLHsi9h4sDOl/ck8a/RM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 14:09:00.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aef67b7-8da4-4b1f-0e7c-08debd8bd558
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

Nvidia Tegra264 SMMUs are affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice. The
second issue must execute only after the first issue's CMD_SYNC has
completed, giving the sequence:

    TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC

ATC_INV is not affected and must not be doubled.

This series implements the workaround by hooking the duplication into
the single chokepoint that every synchronous submission flows through,
arm_smmu_cmdq_issue_cmdlist().

Patch 1 detects affected instances using the existing
"nvidia,tegra264-smmu" compatible string and exposes the condition
via a new ARM_SMMU_OPT_TLBI_TWICE option bit.

Patch 2 wires the option into the CMDQ submission path: when @sync is
true and the cmdlist carries a CFGI/TLBI opcode, the same cmdlist is
re-issued a second time. The batch capacity-rollover path is also
adjusted to force a SYNC on chunks that carry CFGI/TLBI commands so
each flushed chunk is correctly doubled.

The series is based on Jason Gunthorpe's "Remove SMMUv3
struct arm_smmu_cmdq_ent" series [1], specifically commit 13428b0bf794
("iommu/arm-smmu-v3: Directly encode TLBI commands") which is the
final patch of that series in linux-next.

[1] https://lore.kernel.org/all/177919957385.1012282.14787407041669291032.b4-ty@kernel.org/

Changes since v1:
- Patch 1: Add IIDR/IDR/ACPI rationale to the commit message, explaining
  why the erratum is detected from the device tree compatible string
  rather than from a HW register or ACPI/IORT.
- Rebased onto the publicly accessible base 13428b0bf794 (final commit
  of Jason's series in linux-next) so that the base-commit is resolvable
  on lore.kernel.org.
- Patch 2: Picked up Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>.
- No code changes since v1.


Ashish Mhetre (2):
  iommu/arm-smmu-v3: Detect Tegra264 erratum
  iommu/arm-smmu-v3: Issue CFGI/TLBI twice on Tegra264

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 70 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  8 +++
 2 files changed, 72 insertions(+), 6 deletions(-)


base-commit: 13428b0bf7947098daf9a1db14a74d33eb1b5079
-- 
2.50.1

