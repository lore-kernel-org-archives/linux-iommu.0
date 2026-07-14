Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97037755A
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025749; cv=fail; b=OkKZgip3Ea1MJeb81tAa+fnABQAQTFAjcn1UBgHQRlc89vAIyaHAY9PoNV1//FMkgzDq/+t51gvD/P8CtVZVl4GPihZB+bH6pgi0OpyiZaKIeuMHikvghQzZepbrQEKkveSh0YNuzWv7Vkw1F/vIvxDCpH4MduS8s0owXdlrm8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025749; c=relaxed/simple;
	bh=JSDbnU9kJpFB1YJGmTMwleWaFr9WuC9Lq717aJ28khg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bXhZlPqIlCx1UUOdhG2vLHU03DQ6gpBm/Mazn3ZpsIxHa5SAhowFLD1Hv5/KQ99omRcWo00nA9I5N0zSMAFSyzlCEmEm/CGMArDyJJESYWqrrCTm3sSk6zXAdwWrF00MdLHnJiDTiX0NJPBMuHMoQdsT/IWsDWumYPpD4yo4loM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZ5Pzt/4; arc=fail smtp.client-ip=52.101.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZ5Pzt/4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEeVzn7X6ZieUdznMyNUT4MEav4IEM+WEsWIno1nKE583bNzT4ULbw4MvqL5nblSU3lvKm3gv4ZxLiBHfHJppzxoGMwsgQAWwfRjist16VtD39BJ3ovglP8Weqn5UAZXujOTaL0WLcfZjy51WtIVL2IGhPrqx3bIwOQEhF/4E5gSNuuEpgel/KMfHgXDbujSBMYZHinFhuBdgUr9FYI8jPNpO2AF/LPdP6jQRBQCzAH/8FjrxHzMURTJ4VxlxV6NT46RPjikGm+DVSDqrFj4p5ZP9rTWFBhYPX9QGxAJfnURsOoGv8znyBMPaaDyMV5WdRPl7l435rNJj52XZQcZmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX8Ps1nSoWVPD4sbNJgNE/gi+podk2pBJxA9U+ir+5k=;
 b=rwY9QuXM1C/AUzMD8D+hMw4IfQzh6MTQdmVBVYOQYxP+nd4k5gvqWpT5SJRJXNsNCzvwbhRNtnGpJu4tPYfOTvCZpmSNmDdXHLuopohgOUfteNkP5IiKjhHaOXKK5xXE501tNFvwzclUuiCWjRqyHFIPd7rdye72iELPU7rjkIyN7kB6G9O3dyetJlp4hQvvSdKRxayfSd0jbW6Vgj0PsZ/tUNcridiP50ronPYBkxoMnFUpbGjtD9YWuIGdB9dC89k06LXknho+YupaYMJmesoqP8Xn84zTrQL4pVrB9rLD89p4quhe6PSwSqq3OMWk4L34jBeFvX6hAq3kUcU0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX8Ps1nSoWVPD4sbNJgNE/gi+podk2pBJxA9U+ir+5k=;
 b=mZ5Pzt/4C05JKbrbo09rfqLAGxrdefV3uHFZPyZ5Np6WQfJqh2pHjk3CaE5eJde2P63C02n1vUeJwpWugt1V5rDG9DeyZOKFSM4xJiG1DQGj28/z1Tz85ZLKhZ8+QOhT5lDop7FAEyVg5wKSSkQsl87a8JfCgjY/UXiilRnOiePoa0FyvYjBFDiXeNca1+MhgclhaNw28ZssPejISA+oEIQbCdLHr4lBceAGmkz9irk/v2lFrw05Ia94/Ea5diZCeLsZ+ImITWuPyrFRqVh3Eho35YFe19v89jbmvZh8Le+E7BzGK4xvLC1xyLXGpIYuIUSKJLDD/LfKMWxXfpXJkQ==
Received: from PH8PR20CA0020.namprd20.prod.outlook.com (2603:10b6:510:23c::21)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 10:42:19 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::25) by PH8PR20CA0020.outlook.office365.com
 (2603:10b6:510:23c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 10:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 10:42:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 03:42:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 03:42:05 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 14 Jul 2026 03:42:05 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<nicolinc@nvidia.com>, <jgg@ziepe.ca>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-tegra@vger.kernel.org>, Ashish Mhetre <amhetre@nvidia.com>
Subject: [PATCH v7 3/3] iommu/arm-smmu-v3: Enable CFGI/TLBI-repeat workaround on Tegra264
Date: Tue, 14 Jul 2026 10:42:02 +0000
Message-ID: <20260714104202.1664187-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714104202.1664187-1-amhetre@nvidia.com>
References: <20260714104202.1664187-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ad6f6f0-01af-43ab-3c15-08dee1949464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|23010399003|376014|22082099003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	fyVGmdU9mXTuV2b1ZzAlAbb4EN1nNrg6O3s9lQbk/70PmuR60cOhOlBWRSBq/W4q3WUr4cNh66dul3mHCs3ShLWRxqBbfvSEKh2Xr8oE27TH9mt7otRBKxdBTxi+yPlkv8w5/OVHTn4+eee5dCuAVODO7H6CDKuWsgFbRVEe7W2UYx/5sg5m2HNM5wg1cXn/9+uzDLJPOe3tbDphPEU2xpDECIpH9a/C3DkkdFqrUPDaUoXUZDQJBWZoBj7f5bYDxxeRrT94VtZIygOKOiEov96zW8cqxKtMpRZ6vHPK3LcXFz/vqge0h/B+Ry9R+aGikA++yjxnCm5eorowC0VNL8LUnWJI6ZHPELiOa0Tz2oAcTr0n+jU0f6RbGH24q9a8O6r+kQ5a7isWz1/ElIm4AT924H7fJw1wQb0a9iMvSZEvDLJZjpQM3bszrO+oO+aa7TofluQ3xxMJ9Ks56KEr1O8Au78dZaRKdTJJhnhAii3nCfNebcAIadjbVNmwRooAbvRkmodHHg+QbosWZTxR4XiOEtp7wvPJNV0c0WS8wReicZuS5b4gs7Go/VXt+mxOfRSeFMMAHcRsoLisxCOmavntDmAPJHigLhIctqKaC0aBQdwWi8CuzHIshlxp8u8s2pZ5NVsxW8dcsvQJLYFjl0qaFfP9tBnlClZ8FA091uRo6t8Zpk09u8GE+Xg66OuDG5bBjhUMydosqFcvvcuHYA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(23010399003)(376014)(22082099003)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BodR9fJNDY8dt+JhSskKJ+5tWIaowoW15x22Y2FxbUYsHb6qY7Z82Em7EuNXgopC/r7K5xeM4jDPquICymACCUnqNCeE4T2tfc7g+r2TdyxOeDK+4ry0f5FpW35fMkZ2DabSHTPzJYdfF9PwYgWTZlhUVwv/oqNNzcS90K6690INLnowN78uRgeh2Omeh6WG9g2AK1EQjdgg+mWCU2eoXci8DZ6CxkT0MQX9bILb83znzUlhW1mZPwNK2SjiVcu9kMfmtn77dBNnPQW/kmrD36am5bEK2g7/kcHX0UOSe9rinl3DvOn9Q3pe14S9Ukw1osz0srY8jeMqzrTn0dQaE76IMl2Fz2YZRyQH3PiIfNpXnvOnia+mxhRsidpDPUnYYFdBxgrNjWxzEvGucO+f/Vi7XNLSfyTiLjpJSs7vON0iMA2IFJzKj75BL6hGOtK+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 10:42:19.2907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad6f6f0-01af-43ab-3c15-08dee1949464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651

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

Note that since guest-level VCMDQs issue commands directly to the
hardware, a guest kernel enabling the CMDQV feature on Tegra264 must
apply this workaround as well.

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
index 9c49e6412053..a04dea34479c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5357,8 +5357,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
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

