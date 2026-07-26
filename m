Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011006.outbound.protection.outlook.com [52.101.52.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC312F2914
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785053963; cv=fail; b=DxTtCg+A3lYS8VFkNCjqmhYwdDw4CANRx8RNxOuAyVeUrg9P/TRegQias88fv/XyTMuKVoJr7ZHhlGh28MERV4vfz8P0qA+eyp7sqNV94p8vNRWJrJdfTYfkq+mH05XAByItA0v6kaz6mABgwC7u/Y9Fsy11NtWyyeMG6DdI8vA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785053963; c=relaxed/simple;
	bh=39hkl8Xxsoo1kK7U0R347yjszBsYuKokMFxOvxQ6hlI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y93o3EfXm0ROtXiY9WOHEL4YJcOIyZpl1RzNNqfphScZ2cP1godIFwiOzK4ps7KE/ew8IYJOsP+obm/D1fv5JXlWRPoPYLCt4kws4v2kWvJd6tE5ZZ1srqeOnD0cNnHSsBYeC9Af27/moe7AJzirUtsQKCDxPc77ESZfSMNxsus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RVc8r1FW; arc=fail smtp.client-ip=52.101.52.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RVc8r1FW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2T7rSCESau4GZ6CQlvG2vUV09enRNsPc+neHIxU4OGvbzciBWezr2AGi4qc/CvqN7UUWjaJdmTo3Mzc8DiE+AnB/04CluupUgRdTPcTjzlH8cvsyIgX/IB9yhiXIUG7U+j15PLdULNJNfli0wp/+VBeG9KYKKu4fWzOpsXgAqJlFNy/wq+KIrKOJkJ0Vv/VbUTYGLB5AEhsILb6sdivoNoTUx60WUIf0b7jYgi3PnOeZPokwkcei3vGcZtKkylV/11WI4d4WMrnIz0JrIdU6xV0lGV+odWKO/qlHF8AvH8SY9/L0ItMnC5JpJw3YNuaaBckSe0KdaYTf+5JdCUfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhcisO7S3xKhd+qFgL/qsAiWRfy3FqHpdtLCLP6nuMk=;
 b=iwxqbLZy7IleTCMizM8p9/uC7zEbS8lKhU/gwcOMtKsrPO4UnVzqfOfrBnI3puIrTGGUdKarszXNjB6VxvJfNAZTWTqdAv2DVObVJX86KVajFhKIc4nRjfMWgIB9/sAiUktgRqok6nka+1WtIsvBVXLDaw5Zyp7vf9febuYqYAzaG9o6jLxR/l9zYD+C0aYh8hhGrBZyHNFxCex5m/Vu8elYbpol3xlu8/E3fD8OPkC1hkiHXiEwugNm2VNc9Wd1tNvEsi4UtzLMMYqt9DwOaRgd6lkaKab+AcyRSMe2BTnFPyRMr9Si57B1OKL6FpNa891Ilf3IGznFaXRrF1VxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhcisO7S3xKhd+qFgL/qsAiWRfy3FqHpdtLCLP6nuMk=;
 b=RVc8r1FWl1YNGx+MdlMUapksMV5ZvcFDNJOTdK3PdVBEXin5bhn9juq/hasMS1HGR7LJ+kwHoqa4o75tENvGNkcdI8eZK/NW6eAbqhyKNihb1xtksci4l3f66cuC4ykyCP3skr4g0pNt4UWvc3VW7iZoebY/Tb9bVqqZooML43btVcW9RKo1LnWseQ7dI74idmh1Yhg+BvPhhY5obi6xZRscVjy9/FGD2z+A4sO9ayZROTxlWjkQmkJJTBaoFogsRItpz4D/Imq/XVBhBDpLhxzD7UFxbDHwr6pLxva9MJWj1pc+hthxN/IspzJAYzdDJU71oCxea5rwSrKztiU0hg==
Received: from MW4PR04CA0197.namprd04.prod.outlook.com (2603:10b6:303:86::22)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 08:19:15 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:86:cafe::a) by MW4PR04CA0197.outlook.office365.com
 (2603:10b6:303:86::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Sun,
 26 Jul 2026 08:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Sun, 26 Jul 2026 08:19:14 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 26 Jul
 2026 01:19:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 26 Jul 2026 01:19:07 -0700
Received: from build-amhetre-focal-20260716.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 26 Jul 2026 01:19:07 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v9 4/4] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
Date: Sun, 26 Jul 2026 08:19:04 +0000
Message-ID: <20260726081904.1408859-5-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726081904.1408859-1-amhetre@nvidia.com>
References: <20260726081904.1408859-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: b0be5588-513e-46ad-0040-08deeaee9475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|82310400026|1800799024|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	w7JG+EvpFxIcxH9vOJxdZq3Bdy02VtGM9BpO5jzC/+4LBl3d4gzERz/4uJgvh7H7hseMUZbj889ysjKbGE8CLnGcmw1vwn3MaNkwthPX8FetAbusj6TaCu3GV6JwxYo/YGJcVAnR64D8VUAKcl5pH4OQrC4rFg2QMO85/QLH1+pOwfXGWZZNLa9X8qzMQNLq0isDxsp+BkuxeISg7kSCDLoVuO3EsGjeHhQG3+twLQYU31OWzNCT9ra5iXHQ83u0l09mM4rJYw37z77+zFjs1LxasI+f9z7zb3j7rkiQ1lfMsm6vSZ9an7D7pfyvl3rdHr04b5qWoknlZDuDA+d+MXNUEU0dsHprkxHtKX32clGj2jASObZL0ons8IVm/HFmOSMjdl2GRulp0NGG1OfZaKsy0eQOrNnP9aOR58/7UUv50+J1Cwq8EZ9zKDpuuKMVVsYse5bEgpDni0dC/dQ5vjcWM8/TuRzUQ9tPgwW8QtjTqQjZwh+JsUeEiYGOl49+DFd4jyLKQH0DFIq1hfVB4vQJnxpM1q1E+uYb+jiKRtSRp7mbPMulCBGGLkZaiy474cYtC31xENeFMs24jlvs3byg9Iu7WkDV/NjaY7zdRnY367oi9LiaiYzeb1T+28zuICKIA0lvkxXBCh+aAbAOu2yznAtrl9OkvPLeMqh6Byw97pRI5GuEWWOITyvtOBqg0I4mJALbJr05JCIFwrWfUQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(82310400026)(1800799024)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XtN0WlXc5cY9hdIODN9RkF7q64PGSRAuQmBVnuqeeD8uzX+JVPZ4VROa2yWhJ85T+bmOWJfPRCVp6npQz6RF2gYzzwYvg9Czp3J0L+9Ji/S6BeXf++tuCBEbFL5tACrPfiAOGUtYhL1O9MngOyZRLZUFO3XowRNhZETesaZBb9D4wFrrvivtHcNNVZfx+t7z0CvTwMK3kYicyKocJOuEAcBc6kRp2+kEbTgw5VCweLcO25wLfxCY7T6y6q1vN+PsTEghgeQZs0s7i4KV2U+4HT055PBRmzIq8KK0XGX4CWzWKhHxk9pWwpybdPC8ZWhUl5KXP2HyYj+POK8WsJzwdBz9AeP0mPTqqrTVIaDpLV3se7eWdB+xJ7AIx+6UXpzmxY2kgmOUrn0bhnDoh/rTND15n4SNP2kT3YE9vU/XPFqr6UCtS5ycJA4IvCUuUUef
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 08:19:14.5989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0be5588-513e-46ad-0040-08deeaee9475
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

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

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 2 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 868bd9eed9a6..36c7b6c8b4e3 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -318,6 +318,8 @@ stable kernels.
 |                |                 | T241-MPAM-4,    |                             |
 |                |                 | T241-MPAM-6     |                             |
 +----------------+-----------------+-----------------+-----------------------------+
+| NVIDIA         | T264 SMMU       | T264-SMMU-3     | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f9f2f47e0ffc..2096470a2477 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5391,8 +5391,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
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

