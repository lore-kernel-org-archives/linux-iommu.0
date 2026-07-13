Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010045.outbound.protection.outlook.com [52.101.56.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBE3128B8
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941366; cv=fail; b=LuRoVzHT53N27SmZxDqmGNRYgMOgOdovmNd/e//SupjjZx1d3r18N8/f23HaTXKa5qdvg+S174G9QZ0QtaavtiqJcCh/6lMSAkU9Pir8ENdQAKjJ+4P/smwP7ESFX/276J1pRRx8pkrQLTevpUkU2pJ3jMjiC0GDT7DhHo4+u5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941366; c=relaxed/simple;
	bh=gjnyFFfw6qQDRhK/bKNg57EATq1NFgP4v4M4TfLEDaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UQUyAQYFtvVMpC8vMVzDhBUyVBCqsj9yNzPAK76aqjJ4wObwfiBUVnt++HHNvojPoN8XjXXYXPANXZnjEqPpBfmpFeC+gRYOiyLyKGmTs+BlCZpMNu8r4GVWGQKYNWfBI0SiB7p60p37ofEomVvF8YxueTy0+RkVDzH73Ixsl+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G6gCu3jV; arc=fail smtp.client-ip=52.101.56.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G6gCu3jV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CJHomzB6EbYYx9Jyj3PWV/sB7GEjwjK4ZcuZ6D0HLTkSICqWkdhdFqet0uk7BxW9PcmCuK/FYK2nsidARTSfd5QTEHezm2CA1bb7bD2CuE3x3Yeuk7e2dBJ6Fqwry3dYWphqMJi2VLzU3owAHqCQndPHI9hO3hmWxylai9y1i0me0ZFQsGTFikRkpRDFcM4dK0A7ybUbn6tNPAzETcZ7fr4Qxcfzplns09a/B9hKGUWk26aKuLEgxqouGNMvleVlUIvXPJqKaZuR5e6TbT/bk6rMQPjM0CjR1uii1X2Gk5SYUBYTCQYhoHzQ4HvLtHnO4PXiFPpID4YSG2VCTrjuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNiHliC5DBzLRTTWC79TwL28DGiL3qTQG9RAf5fyaME=;
 b=B8asbR4yi1Jsv+LPPybgUCO59UWGHI30A93JOJ4/3xPe3dkynFMn0tY6l1A18grhEQrpK5PiFS9jyWHUSwUMUTG64ookq1avydX2JjusuTuSI9zaw/pidQeovTUR5O393kgcr3Mfr4CqYZxVu0RGdeng30QufwR322nCmxUNX0bbY5JifPoF4dfDXSykCFdq8TlBSXDWM5nzyOo0opRDmWWiLB3mZE3CZYSdHra8QHvXZxOlIh7WSa08BsQ6v92zd7UiOG/xK5LCrGil4cZlImf2rwxUXCfCyR2T54GJyz47l2ZYn1crsgbmWMJJB5SXVnieogahb81ZIwHopQSOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNiHliC5DBzLRTTWC79TwL28DGiL3qTQG9RAf5fyaME=;
 b=G6gCu3jVwTtEMmUqXDZNBvhnbg+ZAkY0ixPB5W+VmS1Wcpe/8RDq4SF9Q1Jlsv8F04tsF5rE4WTRsXqpvMqDQg735DgfPSuauRqLB3quyxX76OIJcWvnQoecPclJpgwIjSye6kzXxjMSHNh7E+Pw5RYqCnzuZI9omMs08t9Wenb+N9+0cR2VFIGaeiyA5tyKq1CHzd9X9I4u5lRURa3+q6w/HjPeqVdfQ/W3tANlkz+WF2Vec69eS1bKfFX+HoqZhkv7DdSVwESaInXluy8jfjK0hIokfKJABN2fX/NWjizAFSpTtdhUv1z2MbI8RzRpuPO+i4ZlzWbcfIK2lhmGzw==
Received: from DS1P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::10) by
 IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:16:01 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:8:44b:cafe::67) by DS1P222CA0024.outlook.office365.com
 (2603:10b6:8:44b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend
 Transport; Mon, 13 Jul 2026 11:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:16:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:48 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:48 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 13 Jul 2026 04:15:47 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v6 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
Date: Mon, 13 Jul 2026 11:15:42 +0000
Message-ID: <20260713111543.1462161-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260713111543.1462161-1-amhetre@nvidia.com>
References: <20260713111543.1462161-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: 70311b79-38d1-4c4d-2032-08dee0d01ef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0KbKJJfj18USgi13nX9i6HuqGRUMUqSs3zL6r53YiC6hLo0KgYxFG3TVQ8TQ+SidBawVHnBkhiNlGoFIhnRc1q703e33QtT4PXq1GiPBR/j/lsFY4nhn28hN8zlH6RSdp7R6rgX7eS/Iy0RloJn4CmgZU1eYMMPSZ3uM8zkwE43m2b/rD9Uyd0rvhsaLYO4g3hyYkTPPGHIy5FfQgeGJPz79C307IsYZYD++Lnl6ljLrSFoFX9C4ttnEBcDnSke9it6nzZD+i3EQB9QP+8USHoSiigD3oDDLdElsz0W2wXt/yx17TBfHJwGj1FVyCuoZQz3JkHVwHay+FCcBAZZiPK0RyB6qD1q3nNSb51WdErTstn0TdfW5NOScNmxcxJnWWGR/g/G/g3792nMrijR4RfFgoIREwaBsSLNstMGRj7j11i9Z3/QJNvqhDiBkPW4gN1yosBS38laMiXa0uVhQZXNqwDG7/+i1SnoqaFCeghv/DAVP36JMUdx0nqEx4PT467srAzM36fI3ss4felc/WxfKOQbflVSWMurv/YY325if4BujUU2J/yrL2tIyr08VF08chxaRTq7FX1GkiSpPRxLm/p5q2BYiejrz/2VrH7GjQ0AVjSvaRvjJP7JQaO+P5tSHeu1608o2DGtW1lXdjkSd6/0+s7y114BOes8dMdgSaN7bx8ok9TS7aDVTKgFXZVMo/BPgqyprJ1ClSGeuwg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YTB9f4uzslQZG5aMSxPCo4Lg45loVSDe/ufeHhaTUDBQVj1o6zJQJq6rV1rg8u0LZ2oIxb6z1ITL9Nof1KG21yJFCqSIb5hE8JtOTi1X0uV4jvAyaA9nnf2fvCvtqaQ7amtGvfb8Mw/E264zqOfWUlGrFHKsGrnuOCiQFek26qSIejY4GLB4gRPDWTzGA9bHuJkrIks2riT+7Ccc++wlguNK+sB08yepvbNHXNaxe5lwCWEATjeny8dmy9W6GWbqGdQDc2TXTwRuOnIq9hbM/f9ZYhJUEkgoxjDtBDmgms9qe6G6Qw9NDo38MTX2psijnUdCSeElbHK2c6u/my0T7IaF7aa9QU1NMYI0vtwISnBsJGLhcBL0khDN0Yxmc2Z0b/Q53V56a7NY4Y0oR5MHxxbq5VEalO0AVZxQ1LgO0+gW4UKxHCiL0UOBUZMYfMhf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:16:00.8823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70311b79-38d1-4c4d-2032-08dee0d01ef2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788

Nvidia Tegra264 SMMU is affected by an erratum where a TLB entry can
survive an invalidation that races with concurrent traffic targeting
the same entry. The hardware-recommended software workaround is to
issue every CFGI/TLBI command (each followed by CMD_SYNC) twice, and
that infrastructure is already in place behind
arm_smmu_erratum_repeat_tlbi_cfgi_key.

Neither IDR nor IIDR flags this Tegra264-specific bug, so hardware
detection is not possible. Tegra264 is device-tree-only (no ACPI/IORT
support) and already has a dedicated "nvidia,tegra264-smmu" compatible,
so DT-probe is the only viable detection path.

Enable the workaround on instances matching the existing
"nvidia,tegra264-smmu" compatible by calling static_branch_enable() on
arm_smmu_erratum_repeat_tlbi_cfgi_key. Document the erratum in
Documentation/arch/arm64/silicon-errata.rst.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 014aa1c215a1..076b3947d259 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -312,6 +312,8 @@ stable kernels.
 |                |                 | T241-MPAM-4,    |                             |
 |                |                 | T241-MPAM-6     |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T264 SMMU       | T264-SMMU-3     | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index eb8374cfce2a..b97bbf7943ac 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5353,8 +5353,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		static_branch_enable(&arm_smmu_erratum_repeat_tlbi_cfgi_key);
+	}
 
 	return ret;
 }
-- 
2.50.1

