Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702B2E64A
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821643; cv=fail; b=H9YCNFkyvHbohhn2U0SBqT1ZPtJ2e88z8v5PyQt9iwkZzA3170dJwJ+TR2Mi+G3Clwe3ieTPlhC26+zUo7Pss9qycLO7DYi17T9JFxHD5nX9OO3T3m7S8n9m89yObs7sIZtRwGkXrNh9uUGgkFn5Qvhb8e4S1HEP4b90FJAs5oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821643; c=relaxed/simple;
	bh=KGmbP4LQcfd3n93DpkN166NaZkhJgh6bNr5xHhE7g8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amh4PtnLw9XV1f7p4dSy9B7GKLpeP0mQJVQPE+aP9woOV3Az8ruLn54aHsWU4CC8eb06vb15YvR0Bxs5fJFpuuH0Dus7DP+DLyMM6TbywRO6QCOucGOj34BC9ryf//t6HlBe5CrKyEML0pPmTwuoClegHnoMLFT9VOAHFfux6U4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Q1W16/k; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Q1W16/k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxENmA2auA1cZzCBHLeHP2EZ1AeEAqcWVy6PYWSplkqWcn40pLos3fxGdXl6Snjfr7uH04fsD1e706azL9iJWTq1cG9Cu0VPr1ZnBx9jZxNg2DMLeSeLbmnWfTISme5yzuJEb8MxeL0RVlX235pDTnwmkD3kjilAz7rvBQeGfJp4Rws5BJPpr2EMuzU5zYtdl6OqjeqvWtOGU5WiWTejh730mfeM1df32wuUPfgg5pde2kDY9VRglkntgCav5E0kPQnfjgk+zDmgy9PSRzd/hgiEr51TkDcytZ8v8TzeOEjQ2pKOzKd0u91sxS/kN8vz6tHy1tFLdo/Urti2GupXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyLdTkBdlX4x/DALVmF5YkI0wAi3LbsIJcF15XqCTto=;
 b=HoqSOE+fkRLTUPbiXfCZmGemHf5X5wqr0A4iLlkGQExsmPdLEqZbbFzpPoEcUlEfs47TFV2uWB9YC9M68bQohqSRkyt2P2XH413qtjK1dw3leuZ+efP/vJpVuhplpVT7tnAJzHmXvUKOf+9CYu1wuuolztsy0q9XAArjK6OEn5TPE7vj+Jmfelw7WGOUsbppNkM/OzV1SfVDVc18DKDbgEIus1580Xyxp8rP5aEKP4DgtAWwCtJNB9wrwZVFvNWoleJtxEgvxUIBhw/cHf1N83Bu2XT2YZc4xI+6Rusx7h+m67hh2sNVaCZwrG+x/JBfSy1sLa+8dClEDI3ClFRklw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyLdTkBdlX4x/DALVmF5YkI0wAi3LbsIJcF15XqCTto=;
 b=1Q1W16/kwFCksbaXoarHRnZXSK3Q7bfG6nx6Fi9ptPF5um04xx/7vGQyP7svIthcUstWycpD4KEWmNzXjbGEgr1f/chwo3Yj/DGj4GX9pdqsROBBDGqhTzUaCmCtnm9s+M8b1S+MNFPalThMKLozbi369+ukcu1VcZyE4gq9GzI=
Received: from BN9P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::18)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 06:00:38 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:10c:cafe::89) by BN9P222CA0013.outlook.office365.com
 (2603:10b6:408:10c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.21 via Frontend Transport; Thu,
 6 Feb 2025 06:00:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.2 via Frontend Transport; Thu, 6 Feb 2025 06:00:37 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:00:34 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Thu, 6 Feb 2025 11:29:56 +0530
Message-ID: <20250206060003.685-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ec9b09-6521-4830-886a-08dd4673944f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NNhDm/OgS2x6vQltmOtxAda+1Z6ZPmyq7U87epFIBCnyBRHLW04HdTfTdpuj?=
 =?us-ascii?Q?HSBCgU4s0eXK5W/zcVOSc+eKBYPoNt3SsY3VPaDW03p/9gnhED7evFpp1H3y?=
 =?us-ascii?Q?WaAIVa8f2asR61dBPLokLDKz6kURZHwh7YHcnNMlQpsnkpHppAgzpPJhxuat?=
 =?us-ascii?Q?e8HOnrk8d6SV9GhHXW4IlrI0fBAWTyN3frFfI9wM4mcezoEbzfbmIz0LO27N?=
 =?us-ascii?Q?o/P0xFb1+bo+2ykreNDr8/TK8Z7YAE7hZtNuptsM+8GjyHuVVfls1J2RR5Sp?=
 =?us-ascii?Q?M9s7/Z7lLNMl0rbY0FqMN0YYtzgz+4VI3fZ5jsQEojod6V9MYWtKfKk/VxwX?=
 =?us-ascii?Q?XVd665lqY0mHcTB9fo7yNd5he1fpjFA5JVrtM1RQiT6wo42J+pX2LrnLczBa?=
 =?us-ascii?Q?jZeojUIMoCqjMttbI+mcwxV/UZYL+S28HGaPt0yCpTsVOCYbpu8oMDBWkd7n?=
 =?us-ascii?Q?K/46weZRV52VJo6M+oqwNJ6c6e63gnjN7UUvgo/Eps6uGv6FWZ9TEPQ3b5QA?=
 =?us-ascii?Q?y3dE9AgOS/br5wu2iI8ZTSz4/4LlxdVOuArZqRBXPVrU4/MxOAWei45CiLLB?=
 =?us-ascii?Q?uP1MRz7wBL6z9yXl8o2cTxn0ojiqo/fHQo4UxliU1Liygncwr4Ktis7UZhuU?=
 =?us-ascii?Q?F2zxQRi0a3S2m7b7X5p6Uh3sBxT7bJT9CFZUkPIvI9sx66/fBzOYTWrhu2jH?=
 =?us-ascii?Q?LzaTzbqPG7f6o4wlaqXWAnuJC+k0mjpUhfp6dOwTTSStSsIbO85CUPFL1ukF?=
 =?us-ascii?Q?G17IwMm6X/NRmKM78N5UEwj2OySqRLBmEnRKAEsEPkZsNtUTtAtv0bcklEuD?=
 =?us-ascii?Q?uqJEgVM+3Y5oV4DbYvLTIS621+ZqmFQFCQJzV3hUf0EKHyKQ04bSDykgkUL+?=
 =?us-ascii?Q?0EKbRLPQRy70F5xG5c3eakVWA6zokBC5v/PiuwdWEYjCEOLu3qKmtKI+QxXR?=
 =?us-ascii?Q?5S6H9FLDyqb+UeMf/fH+YseLKldXUn+q4rgWLdcoR1qwm1Lh0ngkgvJs4ele?=
 =?us-ascii?Q?ntyj6W982y4+i/GnYGu1xN7v7Xfcu1vd/aWImzO8NzxJpw5gqx9cRGleJm2G?=
 =?us-ascii?Q?N1GK3iZQtk6A7SjsI26G2PI3UI4cig8SL70/97BVYCvDfwdT/ef1sz/tCUmr?=
 =?us-ascii?Q?fcnDtSc2ZqUaNnRVgJtH5UpK/fTRdC4xRSsufsZkrCybTBGrMBt4ENPz9dzH?=
 =?us-ascii?Q?y0vZCfThoP41lOLXwqnbgBPMroO8NancCkswjk8LBSHilxFPI9Xxiv7fzqg3?=
 =?us-ascii?Q?SeebOc3mgM0njjDrDttqd0q8wYopjTqFHtblqduFs/XVoVQfgkik/uDeUlqh?=
 =?us-ascii?Q?sb5NBEQJTxfEAk6pemcscldmTf7AsTCkIWiOz2AtUbMjkBwgPFi3yAHSj/nz?=
 =?us-ascii?Q?FY/if8czn/i0H7Yj+cxWMFcp5BwHP92kxcAsRFZ2slmKTMQfj5dj50FNKA33?=
 =?us-ascii?Q?KsTrYzUbKuUf1RqT16FIEnRQkRMGegtq1XaTnpIRQaFeU8IUDaK2TF4fobWW?=
 =?us-ascii?Q?BlrVQGRGHwjRpoM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:00:37.9277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ec9b09-6521-4830-886a-08dd4673944f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989

Rearrange initial setup of AMD IOMMU debugfs to segregate per IOMMU
setup and setup which is common for all IOMMUs. This ensures that common
debugfs paths (introduced in subsequent patches) are created only once
instead of being created for each IOMMU.

With the change, there is no need to use lock as amd_iommu_debugfs_setup()
will be called only once during AMD IOMMU initialization. So remove lock
acquisition in amd_iommu_debugfs_setup().

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++--
 drivers/iommu/amd/debugfs.c   | 16 +++++++---------
 drivers/iommu/amd/init.c      |  5 ++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 68debf5ee2d7..58308ed12d83 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -28,9 +28,9 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
 				  gfp_t gfp, size_t size);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
-void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
+void amd_iommu_debugfs_setup(void);
 #else
-static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
+static inline void amd_iommu_debugfs_setup(void) {}
 #endif
 
 /* Needed for interrupt remapping */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 545372fcc72f..ff9520e002be 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -13,20 +13,18 @@
 #include "amd_iommu.h"
 
 static struct dentry *amd_iommu_debugfs;
-static DEFINE_MUTEX(amd_iommu_debugfs_lock);
 
 #define	MAX_NAME_LEN	20
 
-void amd_iommu_debugfs_setup(struct amd_iommu *iommu)
+void amd_iommu_debugfs_setup(void)
 {
+	struct amd_iommu *iommu;
 	char name[MAX_NAME_LEN + 1];
 
-	mutex_lock(&amd_iommu_debugfs_lock);
-	if (!amd_iommu_debugfs)
-		amd_iommu_debugfs = debugfs_create_dir("amd",
-						       iommu_debugfs_dir);
-	mutex_unlock(&amd_iommu_debugfs_lock);
+	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
 
-	snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
-	iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+	for_each_iommu(iommu) {
+		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
+		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+	}
 }
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c5cd92edada0..1f0d422bfcbf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3375,7 +3375,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
  */
 static int __init amd_iommu_init(void)
 {
-	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -3389,8 +3388,8 @@ static int __init amd_iommu_init(void)
 	}
 #endif
 
-	for_each_iommu(iommu)
-		amd_iommu_debugfs_setup(iommu);
+	if (!ret)
+		amd_iommu_debugfs_setup();
 
 	return ret;
 }
-- 
2.25.1

