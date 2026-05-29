Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010032.outbound.protection.outlook.com [52.101.85.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE293E51F9
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063750; cv=fail; b=TLTuc9FwvpGtxUV6pdb8W8vacgcrQmkyDCfSRRIl2nQJkivyCc2PLh+9zZCB9ibCkI3uadzhuCC3d2mqMl8mYyNVvR8W/AiL5S/HvMFNEpI3NwEucUcfJjOnEsLduaYjQOH7IX1Ktbqh2cqfY6jWT9/Q1b+hHWCUUfhFHy/IULk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063750; c=relaxed/simple;
	bh=J1fV7lXbkQ5qc7C/d53JNXOdTv0FtPMNVJblLdsbseI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SxZcdq76Zhptj2wg32buRJd0DEna55RpFuTuyFmvSkigqBOkzyUn2Sc8v2KsEuzI+tm4Ychd+U71pvFHKSQrQQTQ/uHFDW529KSWJl2g3d/kmJNgyhsk87Pq8pFI/wQdl5OUu/JOGA/kQ2h/1lomrVI/MzfPsI2z8TpmDEUOQeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1fjeeoy; arc=fail smtp.client-ip=52.101.85.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1fjeeoy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTUTQcj7Q9C1dmRlBEbAavkH2U6PoRkJc3w+EiLTGuzyRZZjFiYxj87Yu13BAgCrVqQHP3JD6HmDDAH7A8gun56KjbLWAG2j5DXGBkN/omaL5RPsOUq4nUw/su+o6bHVUOMPkdH3Jx5C5fSf7Tw2xHwwqo3XcS0HLtXYzIrtS1z7Qg9nhNtwex4Gle9pP4OkhYb5ZlcfQhPQ8zBJO34Rx9d7rmpn3ph8pOOPUtlVM1ppljMZqGLVyCHB7ujiTkX+4arMKrqwrvs2FWcf4PiA2yBWcfUJXqND6GwI/OjOJll2gsFgRbrNTU2fYL4OcbSaQ7siEgl1IlKUHcLVGbfJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnKifKw+AREww6zaBGI+7BGh+8x1NlndAjc79Hb/YQM=;
 b=nielHTdXlulc8mLFaB9LwaT0yfSJpWC9dvfae069unGlBw+pCu7fmg28OXdC0WWKRDxLbDayno9qrH2wip1UMqc/09+zga1xf/p2FTD7KLfJd/AEueqDkZ5BP1i31jpV4+wtRl/mlYoGJUeC8ymQG2FrOae/UmGCRRyn7TSLAiETdD37/guQGp1VBdy6jHsKgI6/GwHD6FO2+76yUVnX0zfC1wbXupMVH6NnhVJdFly5ih0zySBuq4oW2JhAZeTQH9tgrpJoapmGAQd07ejkxXVAcbofR9BCp3IzzV69E1k+DPVTAilrmrjqFAlGadz1X1ldESmZp35xMiaIugPC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnKifKw+AREww6zaBGI+7BGh+8x1NlndAjc79Hb/YQM=;
 b=Q1fjeeoyGApIVxMuhMMs7L46X1ZtHN7oYRHjkrOqZ4P9VJQDUJTyPVAKOH2ryE8j/G1XXmvaB2Flv5MzCNBZp5ZKf/A49oCvU9QiIzFf32iUCncsQRJPHT2HR4y1oXvsICPw4AWFqSs6GEvycb3jt/JKCcMP8dvFZ+AdvO7dhaluv1l5w2coJlwvZQ3LrY9mI2Zo0JfHzawjOsI1Y51zj7RIO/Ks3eEZFwl0ZVajZz2SO/jfF1L6F2t2o0E6D+qPd0TI3LzmZPA/aoElUYIt40r4dTHoowV8xUgrEzGXX+OJJhEabpt+JNAM1vnI0/Rv/tMH80lF8zk2MXSL6aA56Q==
Received: from SJ0PR13CA0110.namprd13.prod.outlook.com (2603:10b6:a03:2c5::25)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 14:09:03 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::5a) by SJ0PR13CA0110.outlook.office365.com
 (2603:10b6:a03:2c5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 14:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 14:09:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 07:08:34 -0700
Received: from build-amhetre-focal-20250829.internal (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 29 May 2026 07:08:34 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <nicolinc@nvidia.com>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH v2 1/2] iommu/arm-smmu-v3: Detect Tegra264 erratum
Date: Fri, 29 May 2026 14:08:29 +0000
Message-ID: <20260529140830.629738-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260529140830.629738-1-amhetre@nvidia.com>
References: <20260529140830.629738-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: ee50be12-2690-4b48-a2a2-08debd8bd652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|56012099006|3023799007|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1efl94domCmYfllWTUX50TROdzv5HnylBMkJrqO0Cj5N3gNT5WNC30+s+tz9f4+6/bDkaq63QtIZGxEYhq9rTEJ68CHYeJPXW1817A/rCTO8kIpKLXXQPUThl0eAUhR/ZzDQhpk0+Yy1svEEt3hVMZwronQUdGgb/cmBMMUqz0OexJmLzB3Srz3VENSF0OrfbtVpKHlnkXynidSH0b6Z+mcjOHhu6Ij9URD05EpWAMmfl6LtciI5OAVndEfkB9Kx0D4aIWadWY5pddtclcvDwGJ6Sti4KoMpyda/sFVwilxaqjReB/+t1PqtOeYoofHJkQTm5wOf9R/YCglyW8DRclOsB+Db1YQonZmfKU5sPZG8UExVWnDs7NRgT6gnEDXPzlbQXtJlYNZwozavmbVRdxfrGg5sg7NshIKOyDsihGzNB/+GiE6MrI8nTAwkQXXauj7oqbigpDMtzQAGipDRosBiQ/P/BV0tcQyU01otfF38vc2xVAbCh63nz27rlYiZAonxOevxhTqCU4p3LQEM4pTXJN94iG6eZkRsCjqiMIzO6StMB4CZYwSkJBc1QK1mIs1CIOFzqPqU6PdWRmPMv7OhQllm+42z9pulFVnrA3hFLcGS0iQmllG5+cVy8taJjlHKcgJm3To0p09hsxSMcL0Zx9UTjQFPtrzMEyH6eCWpeG4DHNpsGThF2dsC1w4ozqPkuYJWuQFfVzyfF4pdxYx6pxr7YOsiWoq1DbpyUww=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099006)(3023799007)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6yX/UDQ4z3m4iOQRKzaAI9iDq/Ku1dywud0QYQDnh3WIT0xhqwSIPNFEvj5pckP1HxGOtM/sHX6HT9Ct7QtYCiLT0Ks4dMkfQOQMIKwGgU+O/36/reF4yGEE3xsVmWt2qZZAO26dcY5mP5TCYzNdeNRbEInumKff6H11Z+PzYo4GE1gtE0jPWNT9ziGtyZ8FJn1bQcExkMKIMiheWhMBIN8gATltEZ7oDmeNWlLFo92qN4romomt+pHOx3ISYdXBGD2OaXgmvhIGFVxPvExfvE4vdrWbBEVkaEfZStHuO6T70NTW/rfsVASVEpULueyt7v9Q4EdKWRRq8jm7cFCOYZXPMiWdECrTIXXy9KP4+9I+W/E+yhTD01jn+bB8vl4aUbPqCxfEFeXHuiPkfAEfwnEYXqNjqiz83Li5p8yK98nXrONQE6BKQV1CmoDyKxw3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 14:09:02.5915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee50be12-2690-4b48-a2a2-08debd8bd652
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496

Tegra264 SMMU is affected by erratum where a TLB entry can survive an
invalidation that races with concurrent traffic targeting the same
entry. The hardware-recommended software workaround is to issue every
CFGI/TLBI command (each followed by CMD_SYNC) twice. The second issue is
guaranteed to evict the entry. ATC_INV is not affected and must not be
doubled.

The erratum is not flagged by any SMMUv3 IDR/IIDR register, so it cannot
be detected from hardware register. Tegra264 boots from device tree only
and has no ACPI/IORT support, so detection is through device tree only.

Add the ARM_SMMU_OPT_TLBI_TWICE option and set it on instances matching
the existing "nvidia,tegra264-smmu" compatible. No callers consume the
option yet, next patch wires the workaround into the CMDQ issue paths.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 4 +++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9be589d14a3b..88296c0a5337 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5229,8 +5229,10 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev,
 	if (of_dma_is_coherent(dev->of_node))
 		smmu->features |= ARM_SMMU_FEAT_COHERENCY;
 
-	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu"))
+	if (of_device_is_compatible(dev->of_node, "nvidia,tegra264-smmu")) {
 		tegra_cmdqv_dt_probe(dev->of_node, smmu);
+		smmu->options |= ARM_SMMU_OPT_TLBI_TWICE;
+	}
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 16353596e08a..08d1abaf31ae 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -928,6 +928,14 @@ struct arm_smmu_device {
 #define ARM_SMMU_OPT_MSIPOLL		(1 << 2)
 #define ARM_SMMU_OPT_CMDQ_FORCE_SYNC	(1 << 3)
 #define ARM_SMMU_OPT_TEGRA241_CMDQV	(1 << 4)
+/*
+ * Tegra264 erratum: a TLB entry can survive an invalidation that races
+ * with concurrent traffic targeting the same entry. The software
+ * workaround is to issue every CFGI/TLBI command twice, each followed
+ * by CMD_SYNC. The second issue is guaranteed to evict the entry.
+ * ATC_INV commands are not affected and must not be doubled.
+ */
+#define ARM_SMMU_OPT_TLBI_TWICE		(1 << 5)
 	u32				options;
 
 	struct arm_smmu_cmdq		cmdq;
-- 
2.50.1

