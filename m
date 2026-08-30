Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E086E359A8B
	for <iommu@lists.linux.dev>; Sun, 30 Aug 2026 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788131956; cv=fail; b=Qx0H+c5w1dsjSm91uJwRHvo1PsBNS9uTNLrJdspR2+z4CgHh10HsodtJcBN/zwlXQ/Qr2NftmJoahuJe150dRjP0huWBdgx5UrX6a/1qIxq8Ve8UMOMwBxULuNdV5hZ44I/r5oJaLJuH39Xy/qbhtYlHQVe97tEAaSuC0QF107U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788131956; c=relaxed/simple;
	bh=bjB3WdK9NNNSopDas3vPjkPGIf9mKGcK0m5v2K+UdaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2plY5x3DoC3pg+yvKVCEVJQgCz13hyUnlhOqVjJePppcWepr2Gnb+1VSBISSWbnuTVS45NZey+O0ZqSHLnEhbkgSjYKGk98e3c8az1SnNmdtsJz/QTJZrP1W+sSVl7cLW6xn7WepO1HvqmhifppOwIKV05tfjhwirxy6vgZEW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OeOhPVxr; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OeOhPVxr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VxsGfVBP+rlMRRAg8MiWgmAr9r/GNLPcRZrzbegpGi6jJfPCT1ojHhzWFg6DJ6GyXt+Q21gjyjPEEsBXuf9WhbLdvg0q0pAfLmdHzzYx2/eTrHCMWqtezDcoxrZqb6xGO1sWnCmEIMpxsGBevNYVodvuWnT0yrLQiFIOrdxRHJOTvQFX9W3gPeeq5N/vCieyZxP0uasv95urWdZXa1X3m0pRTL7+dEN4FGz9WKNCSrYnTKrKGxlq9pZjvntzuob2BZMT7WRw2s0s7e4kmm5x9fz2gi/0rTsvkpJsxZhEpAg+xsj3t0kCwR3UBNWTO4mGOBi2DRZ0zGMe2mNRrXYAuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiHturiQKYVeOgn+v552mtxB4PNvbxESWupKDqh2BlE=;
 b=YhGDFs5D3h7xkt8ZHSqzZHUAO/4NCK5kZBTkcOI6QNSlwAQMVwsergAp7n6PJ0fuIytoj2oPhBXrayjHRjQME0dUBMYmpwq174foe5oHHucg60a8Z2brBxfG+sW89T1orP7G9NM0D+ADtVWqFKBy1rzOmnv4YfawrBK2paCumuOBTARSuoENj6eHE6wK3CUjI+vUV4evJH+sGApGnBB6Fegg3lfMX4K8gl6BRqTobLhIjzpJC/vzcmWm6L59FyH8pkrYK5zWWaiTyutMneg/hCUeYk8KDldqsG4bAheADZwMb90WOKhIKjRzOrYVRc5dgAkQAGMYlV3Tv/xE1yYpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiHturiQKYVeOgn+v552mtxB4PNvbxESWupKDqh2BlE=;
 b=OeOhPVxrXqgj8n5XZ4FjCyuMCQK0j/avk0XEtEQuiNY41ELUjMyUS1dVZdZy05mKBIQipRhjJA06ubExzVHQMeq3FmChaxnVkJYZL3laZZrrxH+x/5MUr2B36F4JR1JX0AOviMVjSDc27S5U80YvLqHiZpe6k+oq27m25WoCZymCF1Wgxrm05PXVNJHE7h8H4qeTeYQ8/AhUxVyqiMTuoHgWs+JG6wgpH+rn2/Ye0Om/r6eMdAbKJHi6tiJmS/tSLJxOTJHANR4UygrH+MmyjOmET80u5zE6XI91lTMQ3p+Y5twxGjVPofjs9DoqFIZK+MXWKuBWGXA7tgcbdyZF3Q==
Received: from DS7P220CA0089.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::7) by
 MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 23:18:53 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:8:25a:cafe::53) by DS7P220CA0089.outlook.office365.com
 (2603:10b6:8:25a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Sun,
 30 Aug 2026 23:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Sun, 30 Aug 2026 23:18:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 16:18:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 30 Aug 2026 16:18:42 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Sun, 30 Aug 2026 16:18:42 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kevin.tian@intel.com>,
	<smostafa@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <jamien@nvidia.com>,
	<kas@kernel.org>
Subject: [PATCH v10 13/13] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Sun, 30 Aug 2026 16:18:14 -0700
Message-ID: <7529b88bc52e8f3f3e9ee1ca283ac2258ec6b1f0.1788130528.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788130528.git.nicolinc@nvidia.com>
References: <cover.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 46eef3d9-c7d8-4447-c6be-08df06ed0ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tW/oN+oJ1JrtHIvADU7XMoYNwYPS3rlx/KLonQzuoG7I95+y37BO3w3ygXvQDopzTcWdg/a7Q9MVAYhb4gNWx6I0/5YhbnlxT/sn+KY8bjpd1JbNw29LY4TWHvyds5bKpOlAei3lza76Y2/NbOFLQpQ6gumxCpHop8OsJLlHRLFLYve9CMma1jhqYDjXNjtFsSDjFIr/Eq9VbIs8jxjEKH0EIsYoRyelsvhg5vSpU2jLK/7/LkmJKxMfBHa6Sh2Akv7C9nFRAjLTvQ8mfCFAIVvsoZcoPYe/xVeOxZ4+7yj7iiV8Zk/D0S1h5PA5pOqqaleWBYJC7ixGgR4mZsOojJmhSXqTpoqJOTG7PqdaD+pqYr2c9aahfXWSbFgJjw1sx3beopkn2N8pl0VT0uDy98plEabdtAIBlOhhgxFiwPc6Ew6Yp+EpWugfcALzkUCdz7ypuFPL4rhBFoywbJro1552C/tIciz3cv9J80nXs1dnKEfHlc8JLIoX8lBLfnFN0Hf67Ic/RdnFpy923tUxfY/4zBb8Ddt6Zren6sc7/GN+eP2IDJ9lmQb7V5rSktQC8zNt+pM36HMVtHoTh7csSCJC3TV0Zf2XCmdJKREz2e3XUql6i316F5dMMiWQl3GKxa7Qv4Yu9sE6PYrJ2nmXLWnFyVs7Sxscbxs+DeEsycgeqt55GoJB+aOMBfsbm/idBnV6Yb1zrP8haLINTJn7Xw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	12m77SdNnvEMpgSlHk69v2165ggY7nUDyDcFjdAEasQcWMdhQY/ImS3UzJ+3DsopYatoyL9TdJy3+iSF6OGgT5fuzxhMhLau9Y9KAmXprI8/HWuvXZHsc/1M7BzKPh4xiTCPJ9FC2c62Y3LgCYh9yDBw7Hh/41FvfUSY6vYdCYak6AFBf3XapyGGKoCIdywwzCq/Hfb/u6E8bmO6JRezFGQVH1iCbn9n15xbznkCJH9D7lVlHICvKE6ONX1zuoJObgO11Y3JTnwDQpzc4tdragw9zIwjhLyCEU5LV+7mqbP+/tm2vT+W8j/UXMKep0yciJcravudsgKqDE7qG4/FSgnTSvBCugyreg729sp+CSLXjp4hShXAiW833zR21rfSWTT16J4WHFvrMU6SqSQZuLey9rClS71ApnV9GvFg6GjBINSHjsdPz/O1d3K7a+na
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 23:18:53.2965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46eef3d9-c7d8-4447-c6be-08df06ed0ebf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3f2ebdb99e8f7..e0f16f8d13842 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1290,6 +1290,7 @@ int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
 bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1309,6 +1310,10 @@ arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 {
 	return false;
 }
+
+static inline void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
index 5bc938901b65d..e7c7927b1ff79 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kdump.c
@@ -256,3 +256,30 @@ bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 
 	return false;
 }
+
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 525cdc2e7d495..2c5befcf64456 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5367,6 +5367,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_kdump_probe(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

