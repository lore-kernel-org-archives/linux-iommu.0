Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2074.outbound.protection.outlook.com [40.107.101.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5880213D53D
	for <iommu@lists.linux.dev>; Wed, 28 Aug 2024 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843507; cv=fail; b=gspEEnDrNoOVtzbu+1uYdLfiebYpmnMJnC1/j1M1WAoq4jge3TkDF1dM3Zw9R4OXmH5DfKInsC+qv9vsg6OETzI8s0ETdXMmlemOcunbRIFRkWtFJujNQogG7bLmDzCWhBLLq7c138x+kSX00Lonfv4QS76qYOvcKTVw45bxc1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843507; c=relaxed/simple;
	bh=rvdQt+VNrSjk7nfSKn4VePJvUCzDNzaZ5RTTwEWT3m8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q686Jt4er2VG6BrEdeyyG6u5TOJ6QfRP+maM0oxpDf/kHE/4lCMSKm68/xrb6iV2rR/xnmglUn+4Xp2LjQmiA6iDZw5MNA92p12aEDhKML1fUVhaeXNrhuUchJjq38oYarYtkG3kDs7AsIR54BRK8oy5tDFyPKJyExZUX2+o+Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zNtLopsm; arc=fail smtp.client-ip=40.107.101.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zNtLopsm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSMQfBby0HMLKTccrX5ZLBnKmfbK/sge7I5oj7whzWYbBuj8vxZUdsYzCAw4Ze2twMc9TN7cDHCk/7wt2Rs48gmWw4y5pfCDFCLj0sNE6JAYO9W3SR+iHnIY2QO/rWqb/COJEXffLb9bwQLeUolIUfQdMldcHwUXicE4Nor61E/ZOL63aDo8g6bteETGZzEGs+kAliwXv57ae7G1QoKapPnXDGzzngYA6ftak3c9gYL1882cyl9yXWgXYjk0VJ+NONwSWJA2TyyFRg1NnDyOc/kYe8/3CqX/wLQCamJBF2wSRHzSFb5r/avMgTqB+Jxfr/gOKIL1l4Bh+7MZ1z6ZJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvd+wUu02IjaqcclMn+IH7hHft7f3phAms28E+J0ytM=;
 b=F46zhgGAVFWixZ+D5PTf6QYL/QOphiBjiD/XUp90hpDK9hGC7708Ha5KfbMdHd+qR8eq4SC9CfQMEcigcjJXllWBmBrYh0mulrdvaCHj3BamT7dgpWOYoWao+g1ikGpxeT9RRRLpAsxBYRGDKgcYsXbENqyn4MEk0p3FjT3DIa6hxQN8r11oF7wwGoJutt0jg+iPCFtXdLr3Iq/fpD3yBXJ4CTPB0/YLjvJkO/uBqY4raWCDjVp5LPbPQZqpOe1bM80f6OlmZjr9OstbR2VkyZQxAVOZyqUurjKyS1aP8LAAm9aGJvm9wTbejrk5cIjtkZucx73VcxwEq2QukcsDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvd+wUu02IjaqcclMn+IH7hHft7f3phAms28E+J0ytM=;
 b=zNtLopsmCPfdoD1HzkAm5qks6hjJ5qtmilmDm4cSBIZAj+QkZCwnsiaFt8aDBiiuRl2m0F8pScspj37Fgwlq/aluDx8rYvfJh/KDcGVbIVenFiAQKqF1ptKKL/xWSpU/JzdhlGiUrSG3GALzHHfGdvmDr5PGBArcTV0/Fy8z07U=
Received: from SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26)
 by DS0PR12MB9273.namprd12.prod.outlook.com (2603:10b6:8:193::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 11:11:43 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::42) by SJ0PR03CA0171.outlook.office365.com
 (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 28 Aug 2024 11:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 28 Aug 2024 11:11:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 Aug
 2024 06:11:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/8] iommu/amd: Remove unused DTE_GCR3_INDEX_* macros
Date: Wed, 28 Aug 2024 11:10:24 +0000
Message-ID: <20240828111029.5429-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828111029.5429-1-vasant.hegde@amd.com>
References: <20240828111029.5429-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS0PR12MB9273:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f06b51-bee3-455d-ee1e-08dcc75232aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IsrRxKFnQ86ZaecpA0B2jX4jE3o3Wa58l2X5UgBGWc4NjCvt8QIDBeEJNPxi?=
 =?us-ascii?Q?/zYu39CVQz0Rm9mELRyiWDdgU+kKFW3mUF+YGq18Zv4rmJTw8sv4Kbp9d0fj?=
 =?us-ascii?Q?OekH1640yh+TVikcK2f+R9eaZasleLe4Yvq24mBkddlYe0zlaufv8SK83sEU?=
 =?us-ascii?Q?sLg15/PzYSpuP1LvVHbeTbIvKzxTyFoaDUJc6uLPMVRonoJhxul7pmv29WzA?=
 =?us-ascii?Q?23xCyfYOWSXhLeiPvD26ruMTuaRfz2ev6U0udWiR4eFrd2S2Yog6flX6QOgg?=
 =?us-ascii?Q?JXxTg8ODyMkzNijT1BweGBICzLrr/v1cOLV8i84D6BGZacHE+D0c1KryRJF5?=
 =?us-ascii?Q?W/qYzeIqFYuipreUZD9J4a2OSjiLHiqI7RdbEFQ6LCZ197u1IKAE81kbnGpP?=
 =?us-ascii?Q?8vVQ9mjWX5r4hbCom8JBpME+IAQkjpfSBRsHoeYTu8aVtDzGX27PRNU+BeuC?=
 =?us-ascii?Q?/kdTS82lyRsKV5kxC033WD7w2aoNhC0VOGtvdlwBmeMCpTeGdghhuw/t2+Fb?=
 =?us-ascii?Q?ycPdSDob/gYFqLEvFsiZxB0z6mMfGJnW29bjvEJKZn8XuJRfWVi+a8xDgkz4?=
 =?us-ascii?Q?qtccGiA5WIGnG409CRqe3hoA3pti+Krb/FnUZnGJuozByoTf8q4xdOAi9Lpr?=
 =?us-ascii?Q?+6ji1bt6ail6tneZj3cqsT3W1kKUv2ewvyGgUZGjvuoL1PcrIUmq0gCXlCkz?=
 =?us-ascii?Q?EzMa+pikOhu/497mou+K+maunAytfih/IkQgyPBkdV+P59NKY212SDI1jGSE?=
 =?us-ascii?Q?UGKTjlovIbrBMLEN/EM5gyiyzdQAuaFD62w8Ty6Xk6BauWvpbCsgpftA/e3P?=
 =?us-ascii?Q?kkR6BWh2RDEHGzZoWREmMnImjlEhkTCJ/JmBLCdqsPHmni+uR9qkRrejguoS?=
 =?us-ascii?Q?M9DTifTcxVSspMOwLKYRI/jFiY2exCCPI5ki4B1QfV+EJR8WNt6Op1zAIyEY?=
 =?us-ascii?Q?N+Sg6kizFT/9VeWA04UcKetoiGwG3YgpxM7Mz/4rp0pnx5DEmFCsicZ85vS+?=
 =?us-ascii?Q?xWIOyRT4jJGXniMo8FwBz4NEG6p5cVqDTVRlBT4jqKwWt/R6q4dEcK+S0R98?=
 =?us-ascii?Q?RihOBYiTjxyrejbgRjs2DaU/XTC0Dp6T33b9oj66WYlYiTT3Un42axdLBmRQ?=
 =?us-ascii?Q?FY0qoBT4iF/DdIHEyTEUmwZzhh74Ry/xDhPVAH18Oey9xo3a8xpz/Dnpfjlr?=
 =?us-ascii?Q?nQ+if7bPGn/BGdnPAEX4frduJSpLTgH8FZu7fFFGxFc67xbRN1c4cSuBXgc3?=
 =?us-ascii?Q?18E860JrVr75s5pjGNbzAq/KZILKArzLhcuIGXlhhIXohiQFKvjkduAMh2v5?=
 =?us-ascii?Q?8RYdajJ1oZYfyT7nXMhHuNePsecAiPnzBQWLLVB+IZCVbqIsj6krNLYEUbZ5?=
 =?us-ascii?Q?YaaGHYQ2qHioSd3QdVC29jhl304a/u6JBUt7d78KR7gBqygyg1Zg02F9tIrA?=
 =?us-ascii?Q?ToeLZzNSX2O4BcoJaQZJPsKdWY7uUsM1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 11:11:42.9513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f06b51-bee3-455d-ee1e-08dcc75232aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9273

It was added in commit 52815b75682e ("iommu/amd: Add support for
IOMMUv2 domain mode"), but never used it. Hence remove these unused
macros.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9f9a598eb82..c7432296bb90 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -415,10 +415,6 @@
 #define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
 #define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
 
-#define DTE_GCR3_INDEX_A	0
-#define DTE_GCR3_INDEX_B	1
-#define DTE_GCR3_INDEX_C	1
-
 #define DTE_GCR3_SHIFT_A	58
 #define DTE_GCR3_SHIFT_B	16
 #define DTE_GCR3_SHIFT_C	43
-- 
2.31.1

