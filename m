Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C902192E5
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047348; cv=fail; b=KXUYYGRrOoQrDeDR5xQqefjpRp3dIGHraFi2TWBk6TdXHvAHfMBrq0+ULm6JUQsrj2o5Hiata6t+NOxVj4XQvXpbuA2uEgAXxWdQl1NMbEI1WAK7ItM8zjLpNYFgk8hHj18eIMh+ckYfLgXafcS5MkAifi0mWC+WsIk+o4msS3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047348; c=relaxed/simple;
	bh=Zx+SwE+6gfjMLtLVYeqS4hJqRy2G00r/od68F0v0mfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5HboroCPh8NbQWLswFdQwHn3kMy7/2EYxTLBR8fgnHdSKZgpa1pUtFtwlMUZI+jfDl+OQiC/2aLJE2C8i39evEvK5sV7ZVUDF8JhOQ4QzesEnwJ5pamVEI3LyehQk97YRuV0NxcvgO27FpQCNNhE6lVxtPtlu81LqOqFLC/osk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jMVnqDFp; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMVnqDFp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6osD694ynST6liruCNtU2puwo9DAIlDDu4/O8I1J8DeXSsz6stEqgZImzPaBh+yhIMSsCpSVeS96BtkRdvvAA1EEX89EgIUyfK2yqAR/JfjZ96WTxZz0UbOvtSxt5ZXchnE0LQM3o01ENCG3noXKgUN2Ln2PCDQe+uNXhE8+7/olUCQop/bC/w3e5+n5IGcKkshccfv4/zM6z8hkbGPzrnwfP3VwnMnSnuloaoaQeLfofO2B3fFpljFhvb/WvNUPc3XMIFlY1SNU0rSTaFgh0GtzNwpwgZASsbixYuZIIucpskJVeV9YgBm8QymvHzYocEdwxEkHJiOF3FNcyXNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwnZNSnUKqMfdvu8tbCKNFW30/ADzfza6vUeMDNe6uI=;
 b=zWBgl3TUUDyp48B3QFu2sYBDtmicTNzqrB9M4/zMCB8rhkNw6XFMEaA1LlY1YQJowF3LZNgqMBN0WJ/Dc2UDMoDsQiXG4F9usys1+42Ji8y6q0BLerAguq705MTk0tvuBkzmDRxlqQTpZrGzCzxNNLOABQNrsfMuavC4SnwuMIEQYdo8/JhbC6d9JBrpJEapeh/+APMetLLpq2VlcIMh8o5EYDAW7SuUb3V1t5RoC/lN6vCqJZYuj2tCL+gp97iLI7qIqhGgZlyre9TkMrwBW+LSjo8/y4AvvQdooL/59xJ/Q9Uh1soA97fBljdRl/beLkgDlhxypPq1ic9kA2zIqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwnZNSnUKqMfdvu8tbCKNFW30/ADzfza6vUeMDNe6uI=;
 b=jMVnqDFpVG5z8tnALjJqtq2S3PrpAxW13gPPnaOcnM3KB2T+7ZeeGUr6mkRbnZ6boOhXq4zmgdYhknf7kK3/C/c2YP4y0C8bceyhws1GNgQOfHtUB6a/H5ftRiiG1E38EmDdx1H0C+u/X6j9NAaOaQluHV2ElYpXyqOrqBSSqaI=
Received: from DS7PR07CA0013.namprd07.prod.outlook.com (2603:10b6:5:3af::19)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Mon, 7 Apr
 2025 17:35:43 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::6) by DS7PR07CA0013.outlook.office365.com
 (2603:10b6:5:3af::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:35:42 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:35:38 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 1/8] iommu/amd: Refactor AMD IOMMU debugfs initial setup
Date: Mon, 7 Apr 2025 23:04:53 +0530
Message-ID: <20250407173500.1827-2-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e769811-3864-480d-ea12-08dd75fa9f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4nH+7nAVbgbENFqxpdeq8ot9jPv+ap4HLnOSf7P1YFTyxy6n68128vg5fa1A?=
 =?us-ascii?Q?1J5Je8vR2x8qyO+ebjwqwmvX5VqBoBBxbpFTfqZ85SAXPNQIRlV41QS0/3z7?=
 =?us-ascii?Q?JnVg7hPSwMmuyFcyxDPrkEOKxJTY7MNnzlM4KAcua111JDFX26BNR8cddYXH?=
 =?us-ascii?Q?4kR2X/FPR3ii5LtxGV3O5P75OnbD/d+TKKjq6DTo3lMP3ypHUg2SGL7HV/93?=
 =?us-ascii?Q?oUbLChj46RU7l3ykqqq6uT2rgtDarHuCsfXU7jNfiRr10P1ZLfMwMHT448G4?=
 =?us-ascii?Q?5nPucCgeOJL/11YT3Rb9khlVcuLRiofFxIZ8fvUg4I61wPjQ2OoV7Cadg90r?=
 =?us-ascii?Q?ms5wNeYd1p17GiCF5A60/CIPWSpD9Ue20mjYAEvxjn+D816kC+csuTBb8FGW?=
 =?us-ascii?Q?zA3zyFU+/jQzKkMidygwB8T9Vv21TwhYrLFe5icedsLIxMNQsYZvawbgbu6C?=
 =?us-ascii?Q?UNlVxFyK9q0AOd69EePaPBQ0JXGorHOPcSE9wyYVJhBar45ZQ2L2krUcyrr9?=
 =?us-ascii?Q?+jKb8nna7VtDR9uUSYiM169U4/7Hx1ohNOCPCVpnNP7ICX571aMik9kKKO4m?=
 =?us-ascii?Q?f62If02AemVTvCB1S9hgNCADRh6eF00LTntVDNj83FQfa72V1M++DhcXJDUz?=
 =?us-ascii?Q?24hsJ04iMhCuiCWC9fDkFUeh1j7/F4ObwswYckEXg4rGotVxhhklIIBd223H?=
 =?us-ascii?Q?IiA4mym97Y/CtWJegHHsnVw7iD7cqGYn7UhTrgYeqNl3Dk3LSbAnnb1MOzQQ?=
 =?us-ascii?Q?qIKPewsyMiUMe0tpYIBXwE1ec6l5OahsOs7bQM8c8f69gb+ZDd1igu+iiLh5?=
 =?us-ascii?Q?F9uOAuIEqqCGKaFo5kuRg3xZtQRUFKzX10NHputnHixCW5UkpmZa9GJcAlKO?=
 =?us-ascii?Q?VRpcLmQJwdB5mS14PYzXrqRSqhHbhsMgXR/U8vTvkhy52egpyMls/G1gdaFd?=
 =?us-ascii?Q?qDJd+eCJcuna5+6dw+0j67wvZxRoN4fmxpgtQnxpa5lKzac4z3U7kIDQ7eR4?=
 =?us-ascii?Q?puCQfJnS3scMm0DUVLr2Af/oYILg/olk8oIRC+Rh4AZSbZ7LvgmfMDhOlVDR?=
 =?us-ascii?Q?eOVdxVu3L8U5up8xh7nUF3gmBYpY/jUX/Qt/lzk1XyEztiNxILBt6khqmHNF?=
 =?us-ascii?Q?7V61Ck98iCeWwIEWpA1s2u5T/djFtxWGVZzCcDhLFF5WG0YCfaAqrOD/z+Ca?=
 =?us-ascii?Q?VAZgNUtKLpfcrKIIKgywBsvb7h54l9eL2/tM9Pg5t0oAMX1RFLyMs+Z8O/Al?=
 =?us-ascii?Q?h5EqNsbeTvmdT33YumawrZW4YdSHgju9dV5iEys68h4YpVwhgeryn+iMN+Ku?=
 =?us-ascii?Q?flojbw+75o154o+3ZuYpFL1gJ1uIXbunz3hDyPduckmB+sglH8SKXvinwQLh?=
 =?us-ascii?Q?AkxK4VI42mFyV+MgL1IRMbPcO09BaH26o7KubCU+a+GqQOtCeOv25Z0FD3RY?=
 =?us-ascii?Q?BW9X6v++gX4gi42YaDIsnamsXNLCNX82vRSIFMaySNPIyIc7fzmAZ2SkBJ1S?=
 =?us-ascii?Q?xN/YYddoo20NuXI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:35:42.7943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e769811-3864-480d-ea12-08dd75fa9f26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454

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

