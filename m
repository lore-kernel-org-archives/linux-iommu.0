Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699F2472BA
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449127; cv=fail; b=fa30I/3ACySVxmOHbkkwullGeyIl70BDcbXesrdM3plbHCpMarbcGPO7fO9ohREIhCTYiXK7xmWuPFhpg0QK+/TjCG1aEv4CmtZn/DFOz/X24/bfETHxAJuPdHyLcBcTnSSsJKxprwW33MzgD9n81ZvaeA+1/lg48oGCJVWrLUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449127; c=relaxed/simple;
	bh=fZcOoid2iiMnOEkU4yDbi1eIaGDGbcPoDrcrQGoNCIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHXni05sFua2gK7+VSDYXPiHFmgBIFIzRQaplEbFxwnQV/5pTPb8QOXGnDOoGQnMZjcSDCeqBERGJZe50MEjCBybFnctiyJB14G2/wqUIT1PJL5nqwRwO/EakizYRaNDYwYeHCjtQQhvVbui7NKeGWUxPlJFm54U0/SKkm+Dq8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NvDsdOrz; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NvDsdOrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=renPQZJ/e98jxVxFedCVjVSwlVCOb9S1PwOgzJkC+sx65RLb0YIRLdu5r7ZWbGcTfbqzwPU6AInfZYTi5hK3WSDmns0lr08mv7CPwC9Oi09hRjdFLsf7wuyaWLGpuojStrlE4LGF0+nNllRqeFEVRnHDxFa0sHesWx2UrR/o2hF1UBH4H6QeIqDPDxcx2a3/0RnxNM/S9wATK1ugIQOE/FLblcTzQiVum+lcGf3SJoJh8GTZ0UShcof3B8kT0uCeUX6a7yMzf+hOf4QdDkjF5gRQ+mv6bV44aMgLPx1omOqmV6Vh4VsVbTK6ecM/ZTNDuAgGmlobBhWwLy2BNJSEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/22qpuEXc2iSpGELsQIKflWqo39wLrEdAbW5wTRVTI=;
 b=FP+maqyojHZ2hqAW0pudb6MgKSGQ08paZRsI1/u0Ytqrs4/SiOc4tFCixY2ximiAoLBCFxE9CX2FBrAPTiZ1p43onlIZGlPY+Kv8j3OK0GAMXDKjhwbOzHCCvJBRdTX1Yw74jZM2EmP/a7CVNmGLQqJgymXkDuS/lKqy7TOa4W5NwcwbgNtS5Nwi0TRuakkRdHeTgTQ6OlattJtXAtCtwEG+TrnYKua6wm50r58tvii4ZJUjHr62PTRT1FBGvhKMDHC+QxDQMd/+Xe4ZE8yspn5H0/MT6EPeX0C9LCfmUTYNCudwvynV+62PVBDokh++j3ulqfKR3653gIWt7weWdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/22qpuEXc2iSpGELsQIKflWqo39wLrEdAbW5wTRVTI=;
 b=NvDsdOrzHixOe6Q/83ClQN61wUjThh2Iv4cOcJlrBuQwrq+ZJ4jKUJ58XFO9+vRQV6feIcWXcCyTYq4OCK40vMh6vprTFZ7HV87CkeS5foaLK+pp569pYemyhlX/Q8jmlLk+fn4YYwNYrREjdxchvpIdFLlzTdQOyhMsUecofz0=
Received: from CH2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:610:38::36)
 by LV5PR12MB9754.namprd12.prod.outlook.com (2603:10b6:408:305::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 2 Jul
 2025 09:38:42 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::6b) by CH2PR05CA0059.outlook.office365.com
 (2603:10b6:610:38::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.18 via Frontend Transport; Wed,
 2 Jul 2025 09:38:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:38:41 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:38:37 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v7 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Wed, 2 Jul 2025 15:07:57 +0530
Message-ID: <20250702093804.849-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|LV5PR12MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f2bde5-29ff-46cb-eb9a-08ddb94c3b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfL7xv56Rl9pVwPCtkzfYnsSGh8gp7nYf70ewJZoSEKTJbno2V2al0TW5Avh?=
 =?us-ascii?Q?zfXl3knW/tZq25BSF5eg1/nXtRJSShUTpa0DRwBJGMANYeP2ovHJJMpWOY0F?=
 =?us-ascii?Q?WC86WIxF3Syalrk/TylP9OgOsY+RprCx7tKEypwDquOWVh/TbUi2AJEvAIrF?=
 =?us-ascii?Q?CWUhI0T6BZj7njOHUw26xm2iYvWQjzTQbSKxdfK9w7Tvy7E6hm80ro9hvWx6?=
 =?us-ascii?Q?5hvF/gHO09+56rqYqeZZIxtPQQQZqTAcAxtb5TB5KelEiX9MtslbJi5svmNm?=
 =?us-ascii?Q?M003Oxg1EdDUWdgvpnNjuWGfLTrh+cFDTsv/UVAmBhfpEMM/IJXehPPuFFum?=
 =?us-ascii?Q?4PbRqCRqn1zR6S/7P8g3lmfAjsxcc5rSbrze65/aEHqc4BFq1bXolf2ZbaEg?=
 =?us-ascii?Q?8BvPB1shmL4BJI/LZrlwKgN3LIn/6xjLr5z+MB2L1edPFv92rJh3vQ1mECI0?=
 =?us-ascii?Q?wleNdBYBNJihTaPyO4qIZSReRMbPmdR4zQAPmoN95FpD+y2v7v/KpkhVpmip?=
 =?us-ascii?Q?wOpQDGNnVpKFeh9sW9doOHyazhsB2PGmyIWrQs4XRJ4fsnmX4twR1SS7nDW9?=
 =?us-ascii?Q?HKLymAUiZoxtlhCX1UH+Va+ysk5vsZ0lBynvVBEboxKQH/SVNYIo0HCucgsE?=
 =?us-ascii?Q?/aWpnkX3EadkmWTveArTAAwZq/VXRyurDa2SXBPJZjzFtAweu63tvmIi1Aab?=
 =?us-ascii?Q?Z8ba5OVEY3XC0lnZwALSPgG/NAF1jo0Ay/BV6Sudl+bRNcxK6SJ1hz6L1Q0F?=
 =?us-ascii?Q?WvJ4jmqdmJuNE7kTV2b6Hrso5pxRZT3GegKhycmBo+r4TzLCi58tSSw/LlQA?=
 =?us-ascii?Q?z3+QS0pLIyyd50xpqrQV6qgomEPeHcxrC42nvNzag5hNyms3+120FDDMGiZW?=
 =?us-ascii?Q?WdFgHYkxNSYmuCbY2crL2S5BehhwEvzqRvFewhMNv06VWGcO3rWx9YeM9tXv?=
 =?us-ascii?Q?gDv5NIFdPwMmDHZJSyIn8+VKZNL+e8d0t58nfZaWx+q1c+f3T4bGPM4DaiXD?=
 =?us-ascii?Q?jO3HQ3FnIXGUR4EWpiSb6RV8rT1OF4ybQAbRN39NV19c/fbWzl0eNF4hdHKL?=
 =?us-ascii?Q?csUpUsX+EnV9/3WTRO1bt88ZGU3796HnNlPvYRE1oTXlUho9nPv0KTDDbaik?=
 =?us-ascii?Q?ClD2Z4kmi4QglJx92XEEQC3/GDgKy2ZHTxCFzL8QLz4izWxbU8xhSdoUcuyP?=
 =?us-ascii?Q?gVSO3dwB7GrbBzVe3GnRHXbYBWxLwt65AD4CNBsLz8jBKwKUGLSqs2G6wM+S?=
 =?us-ascii?Q?898OPEmlns1IvP0C/iz9HfaDbxnpP7QDgH/q2+MGb9lHFEpV+pc+hOFqfjvA?=
 =?us-ascii?Q?xVzJne413hikbJQ0OQ8JAm2dZLNKdNWBhDK2Fpwa81fXNnqfo0es2D/qs3QN?=
 =?us-ascii?Q?viKL23HWtqmUx5TZZrouy5N8GqgQpphfpJXTgWvoAd7U/D7CgdYVSqeI11q/?=
 =?us-ascii?Q?UspcQZHJMj1n3TTC2iovgktpDEB9+xyyjC9vCaEa1CqFvumEx5lx1Rni577+?=
 =?us-ascii?Q?4rieJIOxTCHO+fWivMDVUqVSuy+WPxcB/uX2?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:38:41.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f2bde5-29ff-46cb-eb9a-08ddb94c3b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9754

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

