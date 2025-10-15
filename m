Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9703F306486
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557407; cv=fail; b=demtcAnqtcA9W8r9Z7MsOFKHZGzUIUD7o476CE56cQK4YmDAavd5nQbPzb6MYHV0W/td6ZdjZXkhnaAJtDfOjnHefu7nJeK+4Pd/T5aNpbismWgNN2wH9SC5aSWuO0DmRDES/Xnzr0IZcy51atFWHAJBvtNEsxAAD2v6Mt4Ctwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557407; c=relaxed/simple;
	bh=bl9IEwTIppFoEihuKPuVbkAYKHU8Jwkgj5JTimSpaGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QQGIubSwmdmDYdiu6VNQN412PPf/rO/nCQFJg0btcVYOvAHq6HwuFUIMUgRP4EeD4ChaYfp9dwY646VpQY+DRJBirXTzIUKNYZ630HU1P2FPhnu7z3UEsIbb66UI5ClAeS7sVlt9Tkx6s1AwEu6JP2yFXPbQGPI2qXqVpQHJVNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X7kptX8V; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7kptX8V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ6eLahi61mAnRCBTSGEhbcbtrMJyERc6JyyCz7tPXPlfQL0HgzA53ymM3jQtYkfHzcInNrc1fJ1HOyiAYm2FdOEO7/1qvjjwmr1dKqHCpGYeNcbeElpT1Mit6JmSuNcvDMTnETsd7q+rxSFifhe4Wkm/POZGbcvLg2I0LrI7WGOgxVD5S7lxdGZcF5J7Mx1qvo77QWzBUP/ZCGPWnFA+RP+Xt1XE4tLm4pZZGpicIOtJfyi7if7WFAPAaiA/9bpGL1AQxPkshb6b0nTBlhwfvK/6sDShT5FJIl91FIaGpaSNl+avv5ZdN+LjmAMdRHj+un6TVrSkGzp1rv3vDAboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4g0VVzLyXGV0fvnY7szZTrctHrqCHmUf0gj0rCNkJ0=;
 b=mvyBUmmUF/oIVR74zNd0t0FnXMeWn9IJyq3QpUTt5rUg20nnjR32ZdqBcvs7OG+Va04qbkC5iKVad923IlU+7y7n81s5FOHbEJ8+7xaPMSF4viQXtMx/fEdPM70mgpCNUnpHUT8/tR13nkIlobGx81s7EGmiKEDOTZkqrRbXfo9eWj1GG7rj4GUZhEVPd4XEMeO39fXrxPlujXyCkRWTiYJHOioIGNZdV/wOcYEiCrsmrAjNGZ2R8KO9XCuh6AK+aBKqGLwv8kdiMvjLoaqNh0MEku0D6VNHH5gCv9ig3ZAh3r+o+X0u0zrheaRXDAFBfdVROqbzb2ZH9TV3fpXeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4g0VVzLyXGV0fvnY7szZTrctHrqCHmUf0gj0rCNkJ0=;
 b=X7kptX8Vo147SIep5zPP9o7zgvAkzBniUtIMOVFuGWV11HTEhnpGDifq7w3gO97ougrp9ba3DD+x8VZeE4GXFVwnh4rUTUITHzrsXL23susCD2WRwfvXkPfNZuMBguSYZ2pEAZ3kQ0r/eRENLXumLdMdG21MbfmDln72NkIN+MtEiMwVU1KzrPLxaZ8zxNjAQFgd7zps3mjaHOqsPRyCLSB5p7ZbaxThX+hqTew21i5rvxxOZkd6p4E3L/2zGJ83Zh7qjOo5jwSWIlsHOSchZ0QozBtE8yGOMOt/otWZ/dQGuZwmi2KnHMFXXb667mlAd1k5pPJNgnfKQBARd0djNA==
Received: from SJ0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:2c0::27)
 by SJ5PPF28EF61683.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Wed, 15 Oct
 2025 19:43:21 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ac) by SJ0PR13CA0022.outlook.office365.com
 (2603:10b6:a03:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Wed,
 15 Oct 2025 19:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 19:43:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 15 Oct
 2025 12:43:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 12:43:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 12:43:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<balbirs@nvidia.com>, <miko.lenczewski@arm.com>, <peterz@infradead.org>,
	<kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Wed, 15 Oct 2025 12:42:47 -0700
Message-ID: <a4febbb5533127a20f61796e1afc21bc4a132203.1760555863.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760555863.git.nicolinc@nvidia.com>
References: <cover.1760555863.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ5PPF28EF61683:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a9bff2f-970f-4028-e4df-08de0c231915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jbd5bmYe0iIHZ5sjeF2TAXoqMapziwaVQ1iJZlSCfLfojug1+T89+qhwg7+Q?=
 =?us-ascii?Q?jdvlkSu3aUt4TcLWMYcjRnx5UFSMExuxKSDvOkZKkWKo+jCadW2deeCRX1o9?=
 =?us-ascii?Q?4Zyn2BK+/bXhLJcNTP/7IzPWjlw0AK9aorCKCy5mRGOUKeAT0pw4o2dLGX1t?=
 =?us-ascii?Q?HdfQk9f0xi1KYSBLyicDGhcINUQTT7sQfweR5P22qHJrMei9piBhldU+Jmr4?=
 =?us-ascii?Q?ctAoRFXvJLzr1yX2i9M2UVFBmP0SM0QYwS4p/9QyRF/L1erL7b4WP+baCpbv?=
 =?us-ascii?Q?uNwDzXvo+uLOJxuUksqEkqh9GgFVcpSC8kJg10kh1G4D4lLUNG74qLgRxT/a?=
 =?us-ascii?Q?xMUIMZ07JIAKGaAL+HZN/q+5k0mSfsLLP9YS+77WBVOw9nQcWRTwMZFozhU+?=
 =?us-ascii?Q?kLalymuhTP1BTl3xuP+ByFl6/ur1NmhADG/QAiBB9HNv7+Cn0guN/sIG8Phl?=
 =?us-ascii?Q?QV/TPs4jPu2jcWbxdZNJ9KMvTZ9SjIvCrP+yDkJKejHH2RfdanBG5EUUCwRW?=
 =?us-ascii?Q?AcDvYXtBhd0LzfCOSzb5UhsW16hnZXJpQdjTphc3dqRHdHh6Byc+jiq98VKG?=
 =?us-ascii?Q?BJsrLd97dzoU6sluAf1lk6gO5JBWpQP+Crjr4+m96nIHJkXcfGPJ/mjYXO7O?=
 =?us-ascii?Q?6UbUahsl6S1T+ovP8grwCBlYRl+bIMJeDZ0eLEHSz/pXltKmEiVS9vK/fzUL?=
 =?us-ascii?Q?WNzganACXRYkTABDVUAdEPeoeA+7RMAwt5Qm0B8TmDX+JXIrLAvjsodaOMtA?=
 =?us-ascii?Q?Otn1LREanI0mKrfVL+v3Ia/lpmN2UCgWP90b4wcd30dDCIrc04H4bfLdSHOI?=
 =?us-ascii?Q?nCilisTOuVLxQWyjj1Qp0SD1neQOR4JHyP8KWRPla6+vPixcK/aJGec5DIwH?=
 =?us-ascii?Q?nNGg+fstvpQ0CN6ZO4oaSWWfR6DOjvZccv81+KHGTRf7ftAhfoU3wIF4vC1W?=
 =?us-ascii?Q?g+do/aP7vZI8XuKspgF0M7V74wK9LBjTkixWkSxt4cwTFWAL1T2rhtIq1Ush?=
 =?us-ascii?Q?1qiYrKolTU298DkiJztNl2uAyc1FbobxYa31KJuaNZTDaCxfa8kcjTq/hwIk?=
 =?us-ascii?Q?o2LUpjsweh6Vt7xld0O9C+zrQavaBFBKwehrfqnzFrsQFyrusLtgG4HjHRQD?=
 =?us-ascii?Q?GUfas1Cl8AELBgRD/020XDPncCVlwkLLB/tCXUHpoELSIoJnAmsY5X7nc7eP?=
 =?us-ascii?Q?QxqjvUlBPJQ5+Of6vqE3fRow2GI2TTBFDHBVvYBwWBqyokAXXtdgWjsgZ68y?=
 =?us-ascii?Q?vytJehN8W2nsaVDCkAMC61ENFe8Wigh055aawBHhXdcP4MS+ppM06miH0uY4?=
 =?us-ascii?Q?UpVOjJNvbm3L9bao0EdZA8T1fnmbdo8QHZTVRrcCZIJDQMhB9O2ao7cKCMey?=
 =?us-ascii?Q?XrYCssykcV3BmqUu4xDSIpyThqkUUwHfuj8YtxBTs9Z9MV/rknLk3XyKLvc7?=
 =?us-ascii?Q?SuLr9v0jlxjcmL+UUIx7j9ZTmjoKoPkwTMCDHqL0lMv/p6ogkzLdj4q9NxPp?=
 =?us-ascii?Q?Kw1agvZRtUIa8bDIfNakB2jEsqg9oPR8F8TNyCvsfN/E7qSCM1NurWYhRd2Z?=
 =?us-ascii?Q?oc+cr+9xrGD7STWMd18=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 19:43:21.5989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9bff2f-970f-4028-e4df-08de0c231915
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF28EF61683

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5c0b38595d209..96a23ca633cb6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -954,6 +954,11 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
+{
+	kfree(smmu_domain);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6097f1f540d87..fc601b494e0af 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -365,6 +365,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 err_asid:
 	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0312bb79f1247..00d43080efaa8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,7 +2492,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3353,7 +3353,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

