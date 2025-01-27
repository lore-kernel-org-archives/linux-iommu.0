Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C31D540
	for <iommu@lists.linux.dev>; Mon, 27 Jan 2025 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737971084; cv=fail; b=uIHhqqGmhNQrOSKOMWdWQFYX+bea/EGwmOzlHPRz25yOlKWRG+zgki1PJ5LBnhXVqcKvkXQG+Y/140dwfFA4wbCj17rh0K71lBY3hkTLEO3ipsTvCMxFAc5CAbhOJRDO9tsaIIyI8WSM2IIGLUr5JZ1q2Dj2yPR9hby6i8gki/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737971084; c=relaxed/simple;
	bh=L4QcH0F3f5gS1dGXwj3Au9wYn7bE9xT5tA3Hof6mBjs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAa6doJcEa0CISE/XsuBfK5IS9TZu22wvAtQbI2a0ImSIRbo7BYnyNethQP+4/GViBGysAxH1ppzGY/64tcG8up9FL04vymNps5Kd4IO5SlPHeHCiti1FEM5nBlNex3AowVD19BmIsGNckCMcuf/ENjkse+LbFmRjuuGNg9pX9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TkjUKlO1; arc=fail smtp.client-ip=40.107.100.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TkjUKlO1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfW9uL6Em6zU0IHTsOhNQjlAQpUTKRZG7A72CquGMmh36AsHHrpo1mclB/o9FOP4m0JySVxrBadb6sbJdZvL01no+eK0g7i6n0kpptNccETSfNU7jcFUtnW5zUKyTtzZpU6nfiTBQeVIKgQ0OJy2IbrHj6MHMB50qKvnB0hvmNxhoXuYBwxz42uINQD13/CHM/0TJkejAoWvyNqHgEzIesPC6BlWpqjlrkNQmNc5VLYP7eS8piPO4wQjbK12xfDA5Xw7oID1x70DpyeGoM2DvMAS180/ZPoymgrA1LUWOfFzkXCnRjSkElpMXtDrAVemcdLyIVE+tD06uiE6Ike0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G42qLWQPI9RcrrIGE/1FONfqq2fUt96GtpzE/SDGWns=;
 b=e3KbtDlVs4rH0XVW0DdHKWoxW3ZJBYlYHezxwYD3v/ohsD23Y13ItLwv6GZ9+Fho7HIOBB4B5CdC80957xHYCrxNeFRPxX1tnUoUhT/BpSX2E5toIgP5w9WxcVJoG/QEPcjTUrlZcOD2Obj4+7JX9/1b8fTw5dC//sOAHs+6Fp0milcWBQowKnmvGG+UZCbr9LC9AEpFzoBv0QEIPFpINggmWu032YQhzvRC7XGefzxNeXQ3k7TUYOdr2DQJYShyWLDggQ8j6jdJm/Z1UYYz48TBP+nljeCFi1TKKt+sZ4GRjYwQuVcfVypur8z66r6xd4ZsbJWlt1IkDtIuNkcslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G42qLWQPI9RcrrIGE/1FONfqq2fUt96GtpzE/SDGWns=;
 b=TkjUKlO11QPBHaxcs7po51kqCPrIacki8PguDehu1AvP3GgJDehr6uv8us5Btq6vJAyIpFafmKQ95ME5h5SztRsnxvycN+sNqb46E/0T4Wd4Bl2HCJS63R3qfi0t1qEMNUvgXTxx6IjYmo61hypZnIDKPLWJEBqKtLAAVdCjDgY=
Received: from SJ0PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:33f::27)
 by SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:44:39 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::e6) by SJ0PR05CA0052.outlook.office365.com
 (2603:10b6:a03:33f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.14 via Frontend Transport; Mon,
 27 Jan 2025 09:44:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 27 Jan 2025 09:44:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 27 Jan
 2025 03:44:36 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Hamish McIntyre-Bhatty <kernel-bugzilla@regd.hamishmb.com>
Subject: [PATCH] iommu/amd: Expicitly enable CNTRL.EPHEn bit in resume path
Date: Mon, 27 Jan 2025 09:44:11 +0000
Message-ID: <20250127094411.5931-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|SA1PR12MB8887:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f7ccb7-827c-416f-bda8-08dd3eb7379e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ryQMB5vIN/msmp5h4V+OmH8U1ijVk/N5HnmS3lZ/KgqlnflaDybODApdzC5?=
 =?us-ascii?Q?9aHKpoqX7PJBtA+vaTAGNvTUXc5AGIBbZtAZff3i76Y6Pjb8L0q7tc/3bkUq?=
 =?us-ascii?Q?W7IXkGNHbHh1d/agHIFD6BGAaxNRf4UaLEqwOUa61Jp9eDd+5s/im7oEDl3D?=
 =?us-ascii?Q?Q/lpglY2JNzYW9akMCKblRLFalmlLRBE+fzXKa90Ai+PIjgFsfD5MJ/Zfd5P?=
 =?us-ascii?Q?eaLemHOx34DEkM1i8bWgqTGkiu+H4uVgvWDIWEU9ODt7qY82wEclYjFpaPIM?=
 =?us-ascii?Q?j50H1LHFt2ccnJjICGr5XkC+ANDYbGVAfdo/pLDreEQY56jHWVGfy2OBOdFN?=
 =?us-ascii?Q?OZTHPWzLwalOKqStB2dxtjwP9kRSSlC6ewrYBhP/HQpA4rNSbP2/WqM6omCU?=
 =?us-ascii?Q?KmbVPUTLArqMvRDXMhCCqkDNC1ix19Zdl/sGkglCY6aJUKeP8bfgMQuqhHkM?=
 =?us-ascii?Q?ocwrORlh/gg2DRrkyadBQ8VQNqUBxiXoH8kqb1ZI9UW6fFPr1X8tqmE/bC2D?=
 =?us-ascii?Q?XEiGnF9txjlChyWdfqI4S9uexNiwV+zFTvTyf/D+PWrDbHv7rmmCWq/zg4BZ?=
 =?us-ascii?Q?AvCtjQi8b6qgNO9mkkMofBSOC4VUQaqOWo9egVaPetUH7L6sK39hgBwwNkFB?=
 =?us-ascii?Q?KKC9utm05t4VhiMx6vDl+vQe2XOSgyyx/iosO+Zosf3M0RPLHfpjHlEJb8uM?=
 =?us-ascii?Q?kbTvao9bq6tJ8brhHKOSpGY2yinRUuEaIlFoXoKSfJUa3qKpQTrZTE3DHaiA?=
 =?us-ascii?Q?Q2vZCDBB2c+d2EDKWbYdoydwIBcHN1Q4ey0XnPjRUP13Kn+NBGZUIXFBzLKT?=
 =?us-ascii?Q?1yn2xhV87D4yYVoAEZ0c4n0gxGqKAThionH6bwj9kC0nzbXPYwFX8xaqty3k?=
 =?us-ascii?Q?2Y3UQdNSfMa7AnIN3wVNpRCotkKyH1jKVkQKRz3LSMQsTpmadvjkQswUBRZS?=
 =?us-ascii?Q?FplLco4q746tRKDCjnujjTI0FScEVY5aUkOM0PRQ9sUSD7CB76sKjNaqFIPF?=
 =?us-ascii?Q?jSS33R6P3s8zejiBh1ohdMamapEZcuJK10wnmua38mxiYJp7ANVYjx3JzK2S?=
 =?us-ascii?Q?Q+3cbC3kp8WB3kgSqBxDVA23NwsMxOJzInzWiwJr0QZRZcEBp4khMg0OanDZ?=
 =?us-ascii?Q?Rmx7fK9CKC3wCMrIzFvUHcEeIpmsp7w/fjg1azsfKXJcr2fi4r+J3z0M5HB2?=
 =?us-ascii?Q?QxRrnSFtQagLChzD03XvNm7JRuoDdaJNFUt5Gww02ic4DjAagEkpNj3wnrPX?=
 =?us-ascii?Q?cbul9wKNqbfVJOf8CjadSxGTpcyS7+80dgXtIgc458lXimhZx5li0bhup/Pz?=
 =?us-ascii?Q?F777rTlZK5v7LP9laUYOBIarhPxg6p+9BXFoPDVecUd+hwt1T9JgOj2gWE84?=
 =?us-ascii?Q?IjyZWMkxR89kogOr2LNSbJqBdzCAZvXFLDbOvzuklRbq0bt9HA7m+ae/niNb?=
 =?us-ascii?Q?uLLE/EZWwaI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:44:38.8003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f7ccb7-827c-416f-bda8-08dd3eb7379e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8887

With recent kernel, AMDGPU failed to resume after suspend on certain laptop.

Sample log:
-----------
Nov 14 11:52:19 Thinkbook kernel: iommu ivhd0: AMD-Vi: Event logged [ILLEGAL_DEV_TABLE_ENTRY device=0000:06:00.0 pasid=0x00000 address=0x135300000 flags=0x0080]
Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[0]: 7d90000000000003
Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[1]: 0000100103fc0009
Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[2]: 2000000117840013
Nov 14 11:52:19 Thinkbook kernel: AMD-Vi: DTE[3]: 0000000000000000

This is because in resume path, CNTRL[EPHEn] is not set. Fix this by
setting CNTRL[EPHEn] to 1 in resume path if EFR[EPHSUP] is set.

Note
  May be better approach is to save the control register in suspend path
  and restore it in resume path instead of trying to set indivisual
  bits. We will have separate patch for that.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219499
Fixes: c4cb2311110 ("iommu/amd: Add support for enable/disable IOPF")
Tested-by: Hamish McIntyre-Bhatty <kernel-bugzilla@regd.hamishmb.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/init.c            | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0bbda60d3cdc..23caea22f8dc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -175,6 +175,7 @@
 #define CONTROL_GAM_EN		25
 #define CONTROL_GALOG_EN	28
 #define CONTROL_GAINT_EN	29
+#define CONTROL_EPH_EN		45
 #define CONTROL_XT_EN		50
 #define CONTROL_INTCAPXT_EN	51
 #define CONTROL_IRTCACHEDIS	59
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c5cd92edada0..438848b0682f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2653,6 +2653,10 @@ static void iommu_init_flags(struct amd_iommu *iommu)
 
 	/* Set IOTLB invalidation timeout to 1s */
 	iommu_set_inv_tlb_timeout(iommu, CTRL_INV_TO_1S);
+
+	/* Enable Enhanced Peripheral Page Request Handling */
+	if (check_feature(FEATURE_EPHSUP))
+		iommu_feature_enable(iommu, CONTROL_EPH_EN);
 }
 
 static void iommu_apply_resume_quirks(struct amd_iommu *iommu)
-- 
2.31.1

