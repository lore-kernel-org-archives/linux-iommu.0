Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D852C18BC3B
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384079; cv=fail; b=oSc74awXHojFEVkeZOXsVbJ8Bky9+4cAIDlo5opP2OYdPzt5LjHVT9KWkOojbMbc41Im+mDUx2WoqCe/bh7l0WFd7e/cyHyuqgQTrqefAhIC59ZB9Lwj7nwruGPu9b5zAAnLRTNCXiReHw0eDe/tn3cqvC/mMfYWQq+1bGz641s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384079; c=relaxed/simple;
	bh=Qhv7QEZi41ShZsAlkUuArsp3a9hukc/P+4M0HegnXfw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o92zbaaoUGBO4F85+kCnCnxXPeV4KO75V9M5Gg4TU6WEY3kxqQQ5rKCuHrf0sougFKFhds6XAy/7vdXNcNGlIsKDQ/W5kw/a+soX5inp/YCN7XgjaR3/9Gbsx7p3bLmYkcXHfk02VG+qOoyRd4Zcz2IbtNQ3P/nuDacOjeRxv04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEy6ArH5; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEy6ArH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQzGEwfkzmWONY1TchMJ4vdBhFUZOOxxk0xqBnEBC1xKIqoCdehTMAQS6e/x2W6UnLNUfM3obysgMZl+2lpM3UB0bi6+3x7pz4kOXnbYJLDIMXCWnu1kQYFPSaNL2ELBucyPWRT0wXc5ACgi17lwrkvbybmJfT1ygo5DN1sqgY6j+ywIsedBi6I6lJjwkjekJ80tW3yrugQNyEsTvMTNlIY5pKGcXlXAFzLIyt5zH44lTH/Tcgm2KqOxI8NocJgXUcH7Lrpb7zxHM2byqKWEaKowvp2xk9GFaLc4Mh+wNsXOPo5bZPzKmY9Idb2PFOdmAZ4/9ML8VVVvs14OIdswvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfXIwCE677pqTAdMsfVZ19CO4SLVAyEkB8ZT7mdz8Qg=;
 b=ovqD//fe4VSZ5S554MHYax7+VQs3gIf4SKagKvkGANkgveTfmub+NMAKe5zL5czh1417jMI86Yomuyphow3cpHssTViOlMlUM/CnacoLZs1G5vP4r8fdanWj4UThtvbH/bc+fpSANzUiL/tbM3fS6wc9KxLaJYDJ6q4z3PJb632HHbazimVwmV8jhix6UiPSPHZCnBTbnTUJAba9yfhKLkTjXYy3CXTHgR7J+QL6AjKR4ERcmbTTJJU1sweUW0/V6hl6hnh/kpOEGu4+acsUNAVFwB0sjp7JzcLV0xJVykKfUSbBwcVBKxG9sCy1FztxaZIGcfR6ga/NgX2fZk7uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfXIwCE677pqTAdMsfVZ19CO4SLVAyEkB8ZT7mdz8Qg=;
 b=FEy6ArH56Ae0NGP9utWRIQ1LdJPkW27WM521jQ10uc88tv5VRIQHj6xQomfL7ZtOg8ydkqOb+7/+iTODqcGMCkN35WF6pLGoYV+zPnZOC6+/8bJDDDRGLvSlM30Saoo3pak5ipvRY3eLr1KAtlMChL24EptR6XmSGGaDHHEoOzo=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 10:41:12 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::d0) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:41:11 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:41:07 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Tue, 8 Oct 2024 16:10:28 +0530
Message-ID: <20241008104035.4008-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
References: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c6c7f2-1c73-45f8-3392-08dce785b9c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZdD0G5izMbRniJQBgUw+7FUf6ddhDuFr53snbNgyp43aW+1l3S4nlIpBiutb?=
 =?us-ascii?Q?R09+Mjb4LIhclC/dc3fQRqKW2FQ4UKCwh5+kB9PTU3T6nQnuLcgXIY+9QwAC?=
 =?us-ascii?Q?QcOZdrt+jJFWI8OIvnuzzvMv3xuORkQfNF9itQFYqaJo4aoS0hsp0IMtTH3Z?=
 =?us-ascii?Q?KUexO8n0eePbRGQEcn7pDsPa6/hxe+0cjNeRLjZbwn8Zs4Nq+lKwireCOO7y?=
 =?us-ascii?Q?A05Lj0E+Taed0m/mjlxCUZRa607hjKpvwkpyq2FxYGfhIrt1snAPQu2+clHb?=
 =?us-ascii?Q?1eeLg02789a6VZ+Il3RnfecoUpGDzXbr6OTO/Zq3C8KT8lHolfznrvkrrMV+?=
 =?us-ascii?Q?W7OWZoGV9ywGdiLKLJfQPgOMVqjM7h5Q1sVgs9Cqp6OvEmgWWnguw98Iky6K?=
 =?us-ascii?Q?06zOeyTXov54lJWvPtsx7rmrJtHbmuxZAIA7l1ZMpJVOj+kBvmROa2p9aCPy?=
 =?us-ascii?Q?xzGpSPs++xhc/8JgThuAxHWHrcfVFb2lMl2foxYEKnRhhvGOuZ/HBXNNiLdB?=
 =?us-ascii?Q?RLrz/JwHNHxDzbQC/okXdJn88QsJZkeldQBl40mfpEY16Fl7/9Y0WDz/1/NC?=
 =?us-ascii?Q?yM/ra3syIOJugdmwpWeflXjQZwQD0ptS8c0jOs3PAOS7ygnf3XrkRouXTte2?=
 =?us-ascii?Q?yuxZ3m56gb9oZMdeNcz5xIErVTH0h9z4E+r3PbFU9rQwV0RQJI9oOqijJOEE?=
 =?us-ascii?Q?I4E8tOBxQo9Uh+0w1s0hKLwoi7sW8hqw8kqecffs3InFOaDnjm+gd/iM7DWV?=
 =?us-ascii?Q?2syAbmcKVZC8fWCTmHEQCs54KurZbmIn3DW858czOGsEb5xxbocSKZQ+w/PW?=
 =?us-ascii?Q?AWmgBy6sPK+C2ruwlHAv0e/YXdG6eE+bu1OxzSVZTreWmfB8IoXzgGNVSPOi?=
 =?us-ascii?Q?D6l0ap1I8clR9x/pPakDS0I4L4fdmHanP2Vq7bvYjqnUADADCB2jZI01CcRy?=
 =?us-ascii?Q?89yGcthH4WdoQOJh2uoHWd7iSpbX9qXu375xLAs8dyCylE1IQxZGgMMAIAIb?=
 =?us-ascii?Q?bhz/pre3oAV/rucL+JxC5Y9zypYUfXCNP8uBnxY06tvTMQUZI464AJvdQHDZ?=
 =?us-ascii?Q?xCUlYleSxPJFqDKA/brZv7KWdb+ALSwQF7nptzgwXLYri5bV1vdlysAVczcS?=
 =?us-ascii?Q?YeqMHip7zfYM2gzoXx/Cte/eCoh3wqZcGLDlVLCsjj9cLZvkCJbRzFlxF8Ys?=
 =?us-ascii?Q?9FhlRG321Nc8aLIXHB/47XdEB3hl6+mK2w3+TAWkUaIW6nNaqnyaT+9M2In5?=
 =?us-ascii?Q?pf+oGgGVtfM7VKaFgUB87QK1HW4XqL9ZIF/1pCjJWNXSIGw/tG/XfKUCrk5x?=
 =?us-ascii?Q?UCE+riwDXh5SddY0le7PLH8DkgfcxpngUH3F8yDc/0Zq5qh2MF1lnfsEC0e0?=
 =?us-ascii?Q?cZIiGcsFua1o8TU/tTFYiEyxwwgM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:41:11.1687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c6c7f2-1c73-45f8-3392-08dce785b9c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

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

