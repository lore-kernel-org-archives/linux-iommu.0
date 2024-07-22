Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB816D313
	for <iommu@lists.linux.dev>; Mon, 22 Jul 2024 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649375; cv=fail; b=fpgvxQTJGZfs+IYnRd3RfWuNQCafQC1FWFQWiXIkA+gETSkz4y5950G7alJPawvSVYkyD+KOtkGdKtwkTh1k47Vgm+jfclnT+1+gIgF5jrdfxDw/Kt/iWJd7qI+YRITeSrhgyCe7g5eqMs4hNsXlgdCfPH4lIiX4ua/fCjxdFJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649375; c=relaxed/simple;
	bh=lnYRGkYb1q+BKwsOtsjIr3TVjg5x8zOXcPamrOYs1iU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QnUwgKNqYCNQ34ZYkZ/XndmSOqhtAJNK7Za2ktwpe5hYYjncKfc0W1kuTk8/r2MPF4BEEDOssc8jnM8S5klWQNc6cULX7p2JwmHWo1DtNRZpIrceVoM5nHmS60Er2mpwBPp80gqxVpgktCBXfemtrWNhrPryZ3grvWETnNcOU5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=F1P9xS8d; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="F1P9xS8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA9+Ae+tBkqx4Pdyf3foZSuCfry7hjwd/byfapytzydTURcrab/OnKbUxZlsiAaXcz4cDTbLsroPy8euSImaL/yy9pbLKtbWamDVK1cZYjeMhp8boeMCQQ2/YnBubWl+6W0U+iB1Hryjp6PEmK/YgT+hINi1TrQQ56ZpATgpA8MTm8JulWY6UDFdQhFbJtW87yMWQNQCt/S5OlJUoWfsPknAxSoGwK+rVQmS1lY2BR+sZNDy1yMoX00FjM6F+xcwgbC8J02NxdhJSo1JZmEYEqHmvIwfIGMJtEdmdIDy8rZgjRctFP32EncWHBxBI9yHh9OqZaqiCUbgW5isbRJolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN/T23azQPZ6Bc7uGCChMnJzI7UNyiaTeCgEwHYC1Cg=;
 b=kOlhUsqY3YBtdAyNANXH6/ezfEXu2RaAZNKUFf7B9EX6C4YPLk/MCloH1U4+6yVLexQA6mW1NVxnBoV7jmMdPfWhPMcqQAyUGAQWEHIWRK43+4kAhLMV32ITHizFemrVjXjpqOEEo3LryBAsUQYYZmIyCj2KEH53J21Nt+BVd3dIoV3v0mcjzG5sRqDUfMl067wSoEHDp8vHwVoKBJNksnb2O0jO5R2yprFA/KWpZtJAUwUfR/m3kN6V9C/XamOpcKvtI9uUA99za+ZIyqQxsNq+szzBaTQ91Baenusx12C8Hp9POF0M/iht6hR/4HTamyWc5yFyqp7UoWigdZviWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN/T23azQPZ6Bc7uGCChMnJzI7UNyiaTeCgEwHYC1Cg=;
 b=F1P9xS8dYg3Qx1O6avPEi75BI+aAoByPG33BGN92Geo4Q3+J/aITBosL+bexnX8he4Lk54swMMAalk2V32gjzcrnJBkEiC/kV1UKGiBF3sWAN4ggm/c1TzO8YKLnNH9Kqmr4t/1Q4xVhTlKbhP0588EgilO6ipKD0kCOpXiHSmk=
Received: from BN9PR03CA0519.namprd03.prod.outlook.com (2603:10b6:408:131::14)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 11:56:10 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:131:cafe::76) by BN9PR03CA0519.outlook.office365.com
 (2603:10b6:408:131::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 22 Jul 2024 11:56:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 22 Jul 2024 11:56:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 22 Jul
 2024 06:56:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu: Add support to change domain to blocked domain via sysfs
Date: Mon, 22 Jul 2024 11:55:53 +0000
Message-ID: <20240722115553.6005-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d72c2e-d5a0-4c9a-3959-08dcaa4546e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RG8z5J77SiyVT88calnu+V6ppLPyAHzK7TO3wpzBlVJCnykO+AQa6KQTcX4J?=
 =?us-ascii?Q?9+1uXL/XZeazUbI9ZDafvxE70uKxSK2CLQGJ4k8QePErr9CLD2H1KmNA4Iho?=
 =?us-ascii?Q?LCHJZSjywWSbzgWdldRUm2d1jZ0OiWhomJALtgtS5UASOMFcz33+2mbCaau5?=
 =?us-ascii?Q?34HvHH75Mu94Co6SLQfLwGojY1jckLM7WBhXO8/fCnsTdePFPaf24TrsCMkS?=
 =?us-ascii?Q?k1FV6CO2UiZyGvZbGpS/5VCTrBqkXkvh3btaPzG6hTjZDd7baxmMK2phJ6hc?=
 =?us-ascii?Q?TEoNwRHJ0PWCVCgjCN7dalMLbvw91GhvG4Ne2jIk+FecGc6XFYrO3siLEEgP?=
 =?us-ascii?Q?ONnNBy6iZhYTHxYEc2gGZYKMadsWfjFeJVsDsvM2RZA9bUs1bVFMiOS3uqQ1?=
 =?us-ascii?Q?yOaGhdqW0IhW/VBS0s/lYxB2aOgM0SZULKqfCBImA7RfVIK1463N1KfNA8tz?=
 =?us-ascii?Q?f8KfaMyGLWinpvVQGA2Z1Vn2IbyKjDaDsVQViGBPsx/gGjSgBFJ0FWn3//Hs?=
 =?us-ascii?Q?kkvIuiXkA3r4Y01FPYoy3Pev6rbC0uHrz2r9RAgROkcUanp5oRM2xjWJ3dA5?=
 =?us-ascii?Q?Wrv4JoC0PuK6By9u61JaBv056IIVLsWcDrMYyTvkEojBF25sWWdsN0A3WDSC?=
 =?us-ascii?Q?vfYzAmJF7MVC+7enuWI0k0AFf3DtFpdHRzTuQ6zudA7rJEmE5j95E6RoPIFv?=
 =?us-ascii?Q?sSntPfhXAV2CwexpVcHLDVC4te0MdXRa4anBsypzrI5RslGrY09K/yBnO+Rz?=
 =?us-ascii?Q?H4FVPlLnYXFZSmZ4zTXB2ttdOAfWwB6pJeW8KZI/gkVd2e7Gv/fY13K0eZ3J?=
 =?us-ascii?Q?5dZUUPc/mKyunHzKY0ocguRA9kS7mMwTV7we802DG18nGDe8ZnrRo6mqK1S5?=
 =?us-ascii?Q?sl63rRIKCoJ+HteCdKVs0V5FmnhTyPBpH3tQDz0xuAmWkaj112iXjooGKZyr?=
 =?us-ascii?Q?SKSc7NWRubSOnzeZB2nmy8DDpR4WhcmKKEPLQliJSpyVO/G1VHk65MLOZlW6?=
 =?us-ascii?Q?4gQS7P7w4QRTymm4IEpQJMP+g2IYrjCoM7etKB6/C8Q02rfsr9GqQtCl774N?=
 =?us-ascii?Q?hKjdaOE6lT87HrjlWD2yFfqGKGIjEd4xlNQmOu5facF9i48unbMB/Tc643dj?=
 =?us-ascii?Q?tGTXJq11ok/hnTwtI2DZQgChazjVM6qXCc0IRFpH3ywQXIUgdgUF0kYP5Vr8?=
 =?us-ascii?Q?hMzfXZ0AJAHwm5VZhlHWcECa7vL+59dMaq5nnaSMx/HG8ye6LHFkYYPVWRDE?=
 =?us-ascii?Q?XDv8yCx/+bBIXth1TDW0FpTy6IF3cPrdz5Cezj1w5cdwb+i/c6T8O05AxfAf?=
 =?us-ascii?Q?2YFsWWx9pirtZ2kQkwcj6BM2OX9dFm4vs0vbelBQKd7LjIyANTVlXmd48oL2?=
 =?us-ascii?Q?KOjDfE9MndxqvzPNp5zDg7fc5780fccviSZ4+rwAYyNVi1KCMg8hzGqkMTfb?=
 =?us-ascii?Q?AAvZ2idiQn5mx74nsDA1s/EKzrK0p0NY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:56:09.7839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d72c2e-d5a0-4c9a-3959-08dcaa4546e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105

Add support to change default domain to 'blocked' domain. This is useful
for debugging.

iommu_group_show_type() has support to display 'blocked' domain type.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 2 ++
 include/linux/iommu.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..5fd6afd9090f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3041,6 +3041,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 		req_type = IOMMU_DOMAIN_DMA;
 	else if (sysfs_streq(buf, "DMA-FQ"))
 		req_type = IOMMU_DOMAIN_DMA_FQ;
+	else if (sysfs_streq(buf, "blocked"))
+		req_type = IOMMU_DOMAIN_BLOCKED;
 	else if (sysfs_streq(buf, "auto"))
 		req_type = 0;
 	else
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17b3f36ad843..2741c35a6788 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -169,6 +169,7 @@ struct iommu_domain_geometry {
 
 #define __IOMMU_DOMAIN_NESTED	(1U << 6)  /* User-managed address space nested
 					      on a stage-2 translation        */
+#define __IOMMU_DOMAIN_BLOCKED	(1U << 7)  /* Blocked domain */
 
 #define IOMMU_DOMAIN_ALLOC_FLAGS ~__IOMMU_DOMAIN_DMA_FQ
 /*
@@ -189,7 +190,7 @@ struct iommu_domain_geometry {
  *	IOMMU_DOMAIN_PLATFORM	- Legacy domain for drivers that do their own
  *				  dma_api stuff. Do not use in new drivers.
  */
-#define IOMMU_DOMAIN_BLOCKED	(0U)
+#define IOMMU_DOMAIN_BLOCKED	(__IOMMU_DOMAIN_BLOCKED)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
 #define IOMMU_DOMAIN_UNMANAGED	(__IOMMU_DOMAIN_PAGING)
 #define IOMMU_DOMAIN_DMA	(__IOMMU_DOMAIN_PAGING |	\
-- 
2.31.1

