Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4FC1CF2AE
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879275; cv=fail; b=OXhQeWjt82s13iGzJMWaoh05l9cpbGASOM8Ehr6Oj9dNwltMB2GtozolTOcPuyDbODNMsofvMD3ZS6T9lkMWDg9ayJwMmfm75MF0OvCSWbBxB+F7LHR0tXMmN+9k9PF9y7JsQ0Zgnk69o0NcGIAfFj92o0/YTS9uexKP78EfONw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879275; c=relaxed/simple;
	bh=Qhv7QEZi41ShZsAlkUuArsp3a9hukc/P+4M0HegnXfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8bLfeiROO3iycXe5XK58BZZlIb+3HCTvBsjXiOQD4TJuFL2y3q9o0kjwPXudobgBpysiEFcqtrj/dwcqDxg/eMJh7fkn8M/MVwP1R96KI20MFVs1lGazaPmIesjz9z/cTgv21sLbjEh7viWAHn1VYiEXhiy6bBDyNLRkH7CISE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cjCN+kN7; arc=fail smtp.client-ip=40.107.212.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cjCN+kN7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6b7rIpwqMMQJJYKK2RFErxBPu1o09VcMEi0i8csmTE7GiNxcqb+fwIr2Nmc2JuuO67bybv/yfdX4en3LKXZuftnckx3u9e4ITnpGiJiHF49pvweXiAHVjDfQfziONzL+1Aq3a1rReII/jlrWoeBWHQCXyo6rGSuIpaDQFwG110VteWBoA8BYjmKQ4JuOFeTvovbmpYafc0p7+5mw/HIdtNWkXghaE78oKYE7k4DoqM9qV7LYXTg+2IN9QKcZ2Q90qxb59Hi9QL1mcxa60/Fp52hu4CH3g0CxmCQZXv5XQYu7z+4myWINGhEsBXK4F99SNw6wnXlTucVUAdYFZgMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfXIwCE677pqTAdMsfVZ19CO4SLVAyEkB8ZT7mdz8Qg=;
 b=nlnfFQCDQ79BuE/KHEWCCW+YgSFDh4BP4ZWNs0QXc35iJSW+j96T2DxOsSKucDcEN0/NwUInsPNCLU6ZGIitEk8ptv+436ZvBJsVuTLZVYdJQW49AjC35pxb5WKAm1d0KQSIo0hhTAaiLcYXzcTCfgUkb8uIMSC0F+6qfIT9V5j/i0l72Bd0G/nLSasLyHfKAPfjL2Guensdw7MuQNEarABom/rHvmzr0FwpT76ejc3JhCGH65CYlilD15ge/b6dYj7RqOpUAaLmgUs53S2x+YwGJKp/Y/+bTYUdirv6OxuxB5pUdG0uilRQikJ1M8spqdQaYv7y82r+ukFDvRmBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfXIwCE677pqTAdMsfVZ19CO4SLVAyEkB8ZT7mdz8Qg=;
 b=cjCN+kN7JfIDnb5DL/ltyl5kiTVM85erkrb4zgi2HmLWP6SponuO8EQZNfpgVGwwT0u3xYDH55xv9lXDJSlIU0q3nMk9/skisWpM7w5XlM6rXPwBGdRBLdxGXKQKAKjpjScYkcofzPiED5ypjV2DBF1gK0W7YH2zJItwMRnbKN8=
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by MN2PR12MB4224.namprd12.prod.outlook.com (2603:10b6:208:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 07:47:48 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::69) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 07:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:47:47 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:47:44 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Wed, 6 Nov 2024 13:16:32 +0530
Message-ID: <20241106074639.2039-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
References: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|MN2PR12MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6bd462-ad36-4ad4-d4c2-08dcfe374e79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3lBCF0uR45yz40GW2ngQuE0GNzx1oszHfc8IeP+CvPLkW3x9BjFpBCifqpZ?=
 =?us-ascii?Q?r8tkZcxVT0xO9w66lc+CWIG0tqmjQ2AOwVx6SwhzBhor/2xVtozhFlFESMMA?=
 =?us-ascii?Q?bD+QmcJyG8NiMuT1vmEo+sg4pzmnL57QRUldsjikqBKXr/JpUo7O9g3KIWyo?=
 =?us-ascii?Q?bsyLlXf1t/rg5Me9QGYGZZxZWZPrEk7yz+04L4MCMUSvfAmDzcdnSRUpOU1C?=
 =?us-ascii?Q?TlSfC4dIF3SAd8ogg10pamoKn/zp7wEP2/e52Vat14Mo2eCXYFBiz5UC29Nk?=
 =?us-ascii?Q?P8E2ARfORXv0BWDeyc3NWbGzl35AFf2aEubWW/2w85lkPnUByZwYS2voJDGn?=
 =?us-ascii?Q?rIa74I8x27lHd4ck4jiMjbfxXjt9AwowUilmwQcwnhWMW76MqG4Si9Wd9CBV?=
 =?us-ascii?Q?qgy+1uo2QK6rZR54Jv2/vxbd3KUB5JnNUxXDlN1DxPNmvva/wtgNGCRURS7w?=
 =?us-ascii?Q?eGcO1wGfbhqvZxMLdSWpKBi3bAT/NqOu9c7unZ4iSMmZmpmKnJt9Qyft5gLW?=
 =?us-ascii?Q?pcl0jlEN2RIGWyKe6GLdpOsmLVWjXrbp6hDduFbflmNoxRj1YsZ4mysglxlP?=
 =?us-ascii?Q?SoropsZpd/yZmSQtNgWDkTwhypv1q7dqAKn9C9ylfAeXV4cy9K1mScDt73vn?=
 =?us-ascii?Q?39HM1AxYAh0jNiW6QXMlHGFkEyEHG6toFmMIsvwNTuhnorlPVhY+tQf/ri7D?=
 =?us-ascii?Q?Dw6dWxCfLNTFXfBx/N6ZIfxJFrGNcWplXiJchA/7rAfZS817hv+CjWaCoNxL?=
 =?us-ascii?Q?NdPsZQlLsqf3S4s2HDPtILGGXJBOxfxYgvi7SvNEWMhuhk3yb1jYT6iK3Bqy?=
 =?us-ascii?Q?uAzopu9lBYZl2Lssse8x9w8XwXn0ZxytQu8V39ARV2dpm07GRGvJSj66oIMg?=
 =?us-ascii?Q?unXFd96ZJz7rGDykB6CHpgXFrvY5WnHNZjRl/0u4AgP4n61dV5w5X+kz+b88?=
 =?us-ascii?Q?93WfoafxrHbB5eyUKXde6TrjHouHvx1AgsDV6VBpULEsHdVCwjM+kw/Me0p8?=
 =?us-ascii?Q?WETU6RBbOZ4iGy0KgH94diXNXnw2WVZRWY8usU4VxuxodZ7WJc4dAkvV5Rbg?=
 =?us-ascii?Q?EACkF8pq11QvfZSi7l/M8X5jN4TJEeGBBkRSs4zDo+KBLco1N0Xvh/VIFtyC?=
 =?us-ascii?Q?n/5ey8vFVlEa50G9CEbzrABi2LHOOwQ4FDPcI/63TIVN6RmFjm7tveB2j8dB?=
 =?us-ascii?Q?CaZ396wfrfWiCN3xXt/Zhtwc+NAiI6AHSgTqAw3YBWzlYV/EqMFtCO5x2a1J?=
 =?us-ascii?Q?Jb3xjKccmYkEiN+wX2ITmg7K+qS8jFHSb2X44HJMy/+M00Ex/yNb1/NYK6L7?=
 =?us-ascii?Q?4wdL54UUCTKq1M8E5ncriFk8Y8LqYQqvtkuhZqSttp9ErN1u0oJJwMOmSiSx?=
 =?us-ascii?Q?e7KLkylJkRDz2/btccDmsdsOqODtpW5cKoa1UGlmJ++bGSiOKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:47:47.0375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6bd462-ad36-4ad4-d4c2-08dcfe374e79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4224

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
index 6386fa4556d9..68821b62730c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -29,9 +29,9 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
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
index 43131c3a2172..d78dc96bbec3 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3377,7 +3377,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
  */
 static int __init amd_iommu_init(void)
 {
-	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -3391,8 +3390,8 @@ static int __init amd_iommu_init(void)
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

