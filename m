Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374451DDA0C
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055050; cv=fail; b=hpFZAsTzgtW8FbonRN+bFVeqM8d/zD1UMdIjwdzjq1adUDnvY27ROkB8ZfFxLHR6FwVdAOuz6l85ziX8GiujJcmCneNOXhQJZ1NIJe2Yz+5FQwj22qkWWWAcQ13gwTBqVJg6zjovpz6Yxs6fi1L7hqkSqGQFD5wXlCLV2viyLXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055050; c=relaxed/simple;
	bh=fZcOoid2iiMnOEkU4yDbi1eIaGDGbcPoDrcrQGoNCIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJU6hOnUj8YfaoeZ4ZrKO/QZNiY0nzwz1J2WQxrO14sM6vzVOg6ZF/2cYshqTyKC18NOiVSolt+isWcx07crTBq8hwFLxMLs/hJSalFB8x0lxkwFgy95k8/qFyY9uXkL56HexRF1K4MPEXRl7X6KyiogyMKhw2DD2zhJjJumtD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zOuPMEKw; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zOuPMEKw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ko/ctveeBVJKCUcVHJgoSYVcuhGWv8Mauupz/SvQt1AxAWTCYutZ88513LIPeu3ShPNlFQ+Y8ih1AxldekOMVFeerm/YLa3g1MqA1EBmO4Gri1INmwp/tr3gJOmAzdxWpoF/XItwGA1nVg7gpkRNxlA/Wz7LYdKcFnK8pbQOK3/MDWpcBFLbD0723806O9uMFWpZRl2cYbQwlHUgd+mdprO8dacevtCGcBmA2XpVCkMFaOXtodlCzh8/AJ8je9jW4j8Llcoh7th0oDmehedtari3Eya4YEzg7wHKZxl9A+x7h9zBHqjRP+T0+n1YWCo9ASeRFE3U8htUoFxtNP8fQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/22qpuEXc2iSpGELsQIKflWqo39wLrEdAbW5wTRVTI=;
 b=oMKhzCIg5xfDDL4AP77SRplF5IcGzJc8UOOkgRCegIu8+QOeNK21XLeDwcYuL6g84uWryY1DyHlGrwyBfIg0+5tt2U0EK4NTLZg8zHiBIiJg6RmiilRaCbOqsl8VsiM1i0QJ/Iu2MJRiOap4WcbYrZl4Vse47t8LhTQVUehOZSlymNgYhRfr5jxvqCH2Vi02oxsUNQ5O5W8Au3/ZM75gDb7y+OtYaZufGc/8QkoqF6n1O6DSNPmQtSDLMa4TQFYqfUf4yo45MOFm6aOIgf/eoJygHxD9xBXgj6H+UJX+slpavr3t3mJ4ZvnnaOBbtaDf2ZMZiqsbzDo8qzV6IrI8CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/22qpuEXc2iSpGELsQIKflWqo39wLrEdAbW5wTRVTI=;
 b=zOuPMEKwCA4GQX9zZGbgjQAJjXrQQOFy07swz10cLzgGo9HIBq+qxoAhIMYWEHh3WUagyMBtsJyTPbc8NTg5ISG1XnswfcFFahNAfEzHxsGpnUG0ZQaEJ4r+F6O7DdpHFhSa/9QFd2FaDs2QUM6O8xIxgv21Du76oLYg6TjVkVY=
Received: from SJ0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:a03:39c::21)
 by BN7PPF0D942FA9A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 4 Jun
 2025 16:37:26 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::8f) by SJ0PR03CA0346.outlook.office365.com
 (2603:10b6:a03:39c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Wed,
 4 Jun 2025 16:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:37:25 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:37:22 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
CC: Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Wed, 4 Jun 2025 22:06:40 +0530
Message-ID: <20250604163647.1439-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|BN7PPF0D942FA9A:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f021166-cdb8-414c-eab7-08dda3861694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uv6o2H2QLnBIU3LM+yb29J7Wf6Vg4lqcrk0qTECn07g0WHYw+gn2IaMx6K1I?=
 =?us-ascii?Q?7ZHDjAR2Z+FaLKmJ8i9vgpWUTNrvGM/M3GKTDbbE0bTElQZYffO1GN8z9CxG?=
 =?us-ascii?Q?ZJOrHG4Q96EdxzHChQcEj4WOCuf3ClU/HpdBw7Ska45xATfvxT9yFOTKTg64?=
 =?us-ascii?Q?69OiR2Wvq9YAq7qmrpkKUDdSzC/krC3tAu/pWp32obU7UUCQF3KmEl36LaKz?=
 =?us-ascii?Q?44Lfwr8Opx3eCr7Pi7dRI1fzK9EET2fBqPsEdsHHtejVWATEVy4Vp+ff3vjZ?=
 =?us-ascii?Q?K/eNpgrFoTjYlzwIDh+w03oJulWvDouILoMT0PmkEUBgUEh6Q6tKwOTXLqhO?=
 =?us-ascii?Q?86D5Mh4J4jlmQFrzSm49Betl6pD0MGojOi54YjXzqUYbvfJNsbtT2J67AL8o?=
 =?us-ascii?Q?l6hsO++jOExiOwYB7YckkP/WODoN2wU6PyX3DdXMrMNsUe43QG5Sf6THjcKe?=
 =?us-ascii?Q?7JHBbG2LeZ50qvydFA9Zuz7klSdwy29pqiPvowQSiHBZmC73sLJoHUjbN2aQ?=
 =?us-ascii?Q?rQaysWOF2MLc1hog5q7oK0OI49goGcOZAGZR2PwtnrFKSrkgzFMLHsjuzvR6?=
 =?us-ascii?Q?EGgng9jbe1becyvVg9bP+OnB4wYwVjZ32DpUxAbyzW9J6HlzFg5DNn5nfjQG?=
 =?us-ascii?Q?LX8CuBqYix3w9RrSoj5U/uZgr6bxXqtrK12dsTiqjDzNvZ1Uenita8fqOR5X?=
 =?us-ascii?Q?LCdO6tpAcf//kK+tt9eYNEJXk0ftD8WfJ3NT7AnJ0Fsn4VEflP6/dAIPPOoD?=
 =?us-ascii?Q?fSiLaGIqufZR6aOJjvHXHSFRC+76z6162GQ4DiyYa88O3LUnonB+VMRkizED?=
 =?us-ascii?Q?PPlVTYVv2ElgMgqhhDfZGuUTTnPEOHZNy8PxV7Z0Bc7wszmI6SRF0zxViibG?=
 =?us-ascii?Q?zSkz3a/V6th2Go/Ll0NlihwvSgUIGriC3EVcHzKxJ0xFSAyQ4GsJXu+y4DOt?=
 =?us-ascii?Q?Wx2LlyG4L0Ew/4ocKO7PUDzZ8X7R6EteXAur0BwVkRW9ZNbPV5Mpl+9ufgSf?=
 =?us-ascii?Q?G01pkHNDeJTh+AkL74Q8F3bYeV+Oc6mxJpM/T7ClK0K9PDIpP48q5lqZxWKz?=
 =?us-ascii?Q?kgKfGNkiMUKX9z54oMuzrBmJKo0yrYWRObuH+SawtEX+U1A/tIzzbdNVxhV3?=
 =?us-ascii?Q?4FYr7FqfAcCHMYqaOEfDYuod1B51A8dpZjzRNORkMhhDuah2flNqDQZtJYgQ?=
 =?us-ascii?Q?w7Eay3icK7MYFYmdeHOiVl/cc8Ope/NzK64Vo2d7WWApneTx14UcF2I0De01?=
 =?us-ascii?Q?PFIGMqm18GufLhqBbGkl9iwCmquPj6WSvbB2j0+phNIEIqp1rp6d9utesg+P?=
 =?us-ascii?Q?kearl01AbsdzZLWrN9T7M7FuqzNqAvs6KmFF8h7K96sck8d8vEWNlqP7mrMK?=
 =?us-ascii?Q?5E/r2yFMmCCp9JS5c3vEWhgV17cDzluxoskgG4oEZj4qcJ19ItXCH3JLPJK0?=
 =?us-ascii?Q?AY9bEHWA9tISiE9biOsLzW+Cx9uP5/4BO0ZQW7OPV/J6QQeRLD/VPxuup70e?=
 =?us-ascii?Q?6ghwAgHd7F3KDgZHhlwSMbD3YpUAsTyYb0hE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:37:25.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f021166-cdb8-414c-eab7-08dda3861694
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D942FA9A

Rearrange initial setup of AMD IOMMU debugfs to segregate per IOMMU
setup and setup which is common for all IOMMUs. This ensures that common
debugfs paths (introduced in subsequent patches) are created only once
instead of being created for each IOMMU.

With the change, there is no need to use lock as amd_iommu_debugfs_setup()
will be called only once during AMD IOMMU initialization. So remove lock
acquisition in amd_iommu_debugfs_setup().

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ++--
 drivers/iommu/amd/debugfs.c   | 16 +++++++---------
 drivers/iommu/amd/init.c      |  5 ++---
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 220c598b7e14..70873bb78b3c 100644
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
index 14aa0d77df26..ecc6c246f87e 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3387,7 +3387,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
  */
 static int __init amd_iommu_init(void)
 {
-	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -3401,8 +3400,8 @@ static int __init amd_iommu_init(void)
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

