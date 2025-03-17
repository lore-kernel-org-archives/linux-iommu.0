Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4723A58D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212757; cv=fail; b=hp44K9I6KYdjUGjeBSsxN6zXEj4cN7LpCUs+8LAfaFfiaqlts0kl7Ibm3u99N+50R1pc+XewrEdJSLBLSjtqr3sVyBNt3y2x36TSr0T1xTndrR6FTD6yljyP7r7LlU8eB386qnSAEDc2a9F2/nnvOkzWrw51gEnVeEuneISmRKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212757; c=relaxed/simple;
	bh=Zx+SwE+6gfjMLtLVYeqS4hJqRy2G00r/od68F0v0mfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0IEiriFGps8iREDUdoZOSV9D8cI+9zL3rzIhW8stU76zjjHtenC1x2YZqRecs1PPb8TN1lKjY0+h8A+IIiPKT6d5/VfrZZ2Mu5OGx7M2Ihitf6//EVAutDCZGRa5AET7CDqUCZc1ujlzYXSqlh6wI3qlQMsd8Rcy4KM4zH29co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W4m77QZB; arc=fail smtp.client-ip=40.107.244.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W4m77QZB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ualjbPo7SI6joxNVA51PG6gyKctYBhaWRZp4whu404iuj99VsxYxokIOtfvOdKbikCvrQftd8GvEXzXcIU4Qbi9BQ2bDenIOuxH2FB2Ekateys7UaMMXkcDi3AWfqnTnNAW5NkXFxNNYcDzN7n31boi+nsmOj4UKwtUf7PTuQnowTbzhWONgxhvv1wN8TQ1e71izwMxZmy4g0KEbTT2sNJ0H2eWDUn6J0SQVWtS07IpOVfkPNo2yaGz4WlwlJ2JLMYdzWwRtBWraZ4Je8i/DZxqWqxt4QzjdBMa7ThnQe8da/J98pUuhmBn7iUtmj42Wk2IizwE01gxsDw07zhMhGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwnZNSnUKqMfdvu8tbCKNFW30/ADzfza6vUeMDNe6uI=;
 b=RR3dGzta8QdenX7FK+WMcd4To3RVqNAs4eGvYdGfofepQfMK5hxm7eiBoSrIsfFXVtVes+KL4+3cY122tTZV7pw/OuNsGgIy+6w3o9IhBU4DOAIAr83MlUh7zilslxh5QNAxd9zAa3GtVFtUuZd/Tf5MTWpIR1FSa2k6v7bS870tU/K/UQhfCzhxL/JV0HAnpapOFM4/COkG1LYnaKm8buK7lZvWYp4QlcejskjKI2b5fdmxr8Sh/g/bWMtBqlvPTn54ot2olJ3tcyfkUb1DsEwK6lU1Q8MtIFFo022Dithw4+JUewnZ4NtQeXfGvKlBjdU3eXvYWYjQzgHA6i4zMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwnZNSnUKqMfdvu8tbCKNFW30/ADzfza6vUeMDNe6uI=;
 b=W4m77QZBRs6ZMim0S8BbPpg+wIjxXUc+Q1xEIwWq7c7sOQGK95VpSqhZ8QO+OkNtFCIhwePIy5ltHzRonBkCkfcEsyepE06vy8/PN19OcRLeAAd10NZbEjL49fqlB3Rr5uW3oQVgmq0ajfponvoW0F5QLVt7obkPiJhGpJfNSuE=
Received: from PH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::21)
 by CH3PR12MB8305.namprd12.prod.outlook.com (2603:10b6:610:12e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 11:59:11 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::93) by PH0P220CA0022.outlook.office365.com
 (2603:10b6:510:d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 11:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Mon, 17 Mar 2025 11:59:11 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 06:59:07 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Mon, 17 Mar 2025 17:28:23 +0530
Message-ID: <20250317115830.3416-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|CH3PR12MB8305:EE_
X-MS-Office365-Filtering-Correlation-Id: 7026f82d-34e0-4710-04fc-08dd654b2149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lyITHZY7JvCS8OW8VqdYfJRpD4Ltgur+bbT6AWrQOfPAJHdnn9fWtXyYXNHF?=
 =?us-ascii?Q?1H1+09sUQ+Q13bqgO0qK+vAy5a7fpqAxf1CuhFdcN+2KYlxORq1SJYD6Ymld?=
 =?us-ascii?Q?LSDprIPkOc0MoKP2IHISSKcXUXr4Dl5W9qQPitOt3ZubwcY5VPF7op96+Tbo?=
 =?us-ascii?Q?BJ76BVNTc9bXOmpWTsjhTOdomsQs2FtGU83TMivDb/a73wL487pw3+LeHYne?=
 =?us-ascii?Q?gIdg8WVp+uMyzLvYKlHIN11Jbe801jd2rRqtQ9VqdjZQED59Wgy4TYWkXvRs?=
 =?us-ascii?Q?KjVipdLpjs96JgZQBNOAIqZnmRZVRJsjnTHJd5r5s4nefAjODc1j4yxthsju?=
 =?us-ascii?Q?B7RIYcGOkP3tzkA+TLoNMQZ86gPph4qDCD2YiuKqSJ2DiobJE+n7cUlhCHvc?=
 =?us-ascii?Q?JSBAsyEi7S9s8sKlN1jwTSxx7QwSj+ylSPJDH5go2AjVxB20iRVZTlcI/mKY?=
 =?us-ascii?Q?Pc9FBDYsovu+y152xu3OZPJ1cR5XMWxDvwctIMD9eh0dMi7+Cs6r8/FhRU8K?=
 =?us-ascii?Q?Y84G1CPGULV1alDBSyXKjP6z3YQidOcgBf9xwP5eBqajPAYFQuPl3f5Uk8Z1?=
 =?us-ascii?Q?yq1/LoPoyNZHIYVbyjaYunrKia86w2QhftjkGhBneyNLDaz4n07DhToFturB?=
 =?us-ascii?Q?CsUGDKIO9hqt955P0UCV9Qzc93DxRuKb0n2k1gI3qfMxE0JIAbaILMM70Cqf?=
 =?us-ascii?Q?9CRqQm9XNJtWDL8lf+b+Xz4dI7GkwWcBfzL23J86bbxl+XcfNpOvMJ7AEa6h?=
 =?us-ascii?Q?3XtZwOBBAbUfJXiqJaEHhsf7mI+4SjiAtGw+X5Z+Af0pQOT86jVVHfblhzy4?=
 =?us-ascii?Q?OO6Fp5OGzOOFm52ZVRvRhtezw1Xn7VpE4E8w2N1xEVPbeKD5iZdqBkgiIVYw?=
 =?us-ascii?Q?eJfNnUQcmBrSY0aPNiYkRfnXgluSDpqPQ8eRYfJjbtOvcPbSaVZNTC8oSo69?=
 =?us-ascii?Q?a7TMCdbwxxwrz7cZLkVEdcsNVLL/dWuSNVR5TLLPRX5+EhIu0qZLVm48n8kc?=
 =?us-ascii?Q?9ZeOkI9X+z1hWX0RspwTe9vJ7G2MTJ0x5ir9rwVWTTiaZgimg8MX8W2yf/ab?=
 =?us-ascii?Q?82Hjz8Vsma4u3Ik/WLMIhUc+3rfL7oAA8LcugB3lX3nou2Yn2uhThbWn3teW?=
 =?us-ascii?Q?7Vkrp1sU+a+i6B/qoNuaUaInETJNHlTTABr3vqZ/zO9hLTWmaFeHsZo07uoa?=
 =?us-ascii?Q?ONy+r29VYn3IBZQpY0lgjVKXodD5bCcM2jw9vm460lcLj7LzWWZX1h/Bmkyw?=
 =?us-ascii?Q?PZBGcK/hTFkmP22qsbWVLI6eCVZo5DU1v5Z+3gEhuvS5KW8feG2RJnojP1+9?=
 =?us-ascii?Q?V1loKne5bojXbIWJ+7IK9smZe9LS0i7OGxcOD371vHOTLHkmko9uZ+LSWncV?=
 =?us-ascii?Q?6EZASKtyhyrN+n7F01UX+2Q4eUvq5GSsxSegnpRHLq7172mcTMzWyUMrC4mp?=
 =?us-ascii?Q?c+CCN4U9ojyQlvkc2j3Jy8pPw8I0GWFyROQp67pO3flLbrUVu5KF5+1PyeUS?=
 =?us-ascii?Q?RYgEP1PBvDu7Knw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 11:59:11.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7026f82d-34e0-4710-04fc-08dd654b2149
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8305

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
index cb536d372b12..1bd24c0d5fb5 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3400,7 +3400,6 @@ int amd_iommu_enable_faulting(unsigned int cpu)
  */
 static int __init amd_iommu_init(void)
 {
-	struct amd_iommu *iommu;
 	int ret;
 
 	ret = iommu_go_to_state(IOMMU_INITIALIZED);
@@ -3414,8 +3413,8 @@ static int __init amd_iommu_init(void)
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

