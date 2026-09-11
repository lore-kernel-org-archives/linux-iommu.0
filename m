Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4845A29B
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115696; cv=fail; b=KiTQ2TkQprCSNiVMZE9nunFoTmv0RrVEuAuMQwlX+wz9uLQNXskWi20Bycjlj29mCqE+m2oiYtww3x5Pd0CwJ+7B3YepOJDbEgvKV4W2/o2sAE562LS2L1zACOz8xe1UXZvMXyepYiEI6frnlC5Eto/Mps9Py3zk8uv6aFShvwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115696; c=relaxed/simple;
	bh=eySJ9EJEENd87MHT/UsjitLJ2YeAQFYMD4hd2cOBVkQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVLrm/TuzzGOuqdrnk06cmtgVa6zeyh5+22piGSu33C6nWnzHH5ZR5vlMEAJTN75kXeQgM59nkMNXSrL2A3td57znqIB5X0FaLN0fm/Jvp5LRcXaZ53sC+VinearsdVKFZ/kXSZyf9AjJ7E06aZ6tw77j4G5lS4hGrAA8AFXSnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FM+5GeJX; arc=fail smtp.client-ip=52.101.62.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FM+5GeJX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ofgy0gQjEqOeh7xGwgJLcuVuD8t5w+vcfdfpxsmaAjcElKmK62pxD247Zgm4uIPA6LaYIuX07/NFJDwHjTFMpAZT70qmAzE48PkwTgpzuiBXiOpar6pMibGRREwYynXNJhnPC5gRVQ+3KHs2Kg7qOfp6XuBDuAkJ4upVYjBJTVq53tH+ERSDc80nsR/FcBHoa3rGxIbB9swk1g1mqhO5WcKKegH9izDxtjILxuBlLx+4vpqqYCRHqOvL9Wu05JtYigMEktHp1jVFQjZAEMbKLu2+ZsVbdQVRD81ci+L88k0Q+jgDHKSTfUcSxRELBipCrJVQbp9XhVKTnQ8UtPRqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USqQoOqPnJfCh3JeQSCwRiVlCZvMAfws75tm9eWzDWo=;
 b=mowogzei+YH0mgGQy8yYrlqbQZ+az2Sd0fRoaoDh1fIpIpEFVfxhlckQS9vpqWUvn9SrPHmK3VNwZ4Mo1mDMO8HQgkyfwTSB9sOazAhJRWKs2QRrkTLFfswcBHMXsf2PJFpUZxeKMwF0hcprnXHevM02z5BAgy/a8lJNhkEL0b1NXangQVdBeE3hpbgMVHtt0gEJ725JdugcN6UDeRR6pcnb162ZGbAeuHcTvQ3SeMjlu9buxUEjdFVSsWy5/U3BbRoyyiOBo+0CMIiBo2nJbNAOaF8R+O0vRp+BiCIAVBlA5jhGwUviG+6jI/NLQCLAWDXgPOuOdN4BBVd2G2ZBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USqQoOqPnJfCh3JeQSCwRiVlCZvMAfws75tm9eWzDWo=;
 b=FM+5GeJX1FnK3o2IC94goLjERJPS6t9lyCha8icpgluVEoYzEPHD8VBKoGc24AHGfElqqH99y+abD/QL1sS/gGO0ddd+SBBdhBgQ85bF5I4m/EedxryYXu0sAczgWr5R5hvwyW5rVuOUE8ccL1wzDXfwMurNfCYrKUjH9uDyFzI=
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by PH6PR12MB902451.namprd12.prod.outlook.com (2603:10b6:510:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:34:48 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::60) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:34:46 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:34:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/4] iommu/amd: Remove redundant check in irq_remapping_select()
Date: Fri, 11 Sep 2026 08:33:51 +0000
Message-ID: <20260911083353.4812-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>
References: <20260911083353.4812-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|PH6PR12MB902451:EE_
X-MS-Office365-Filtering-Correlation-Id: a6212c66-e3cf-41d1-2464-08df0fdf8961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	wMed6FsyWlgNj4/QS4ksnQ3oQmYEVDTcstsAUlJGRXkV5lvxqnz/9Grt0Wh32zsIDSTyks6HuHaBV0XNzgJV38ktlLwF6lbe/dQsE1E+I4ivhWHDCW8B7RWyTdPpshQvm1svUnNQNijL2WX1EkdwjG3lc711pVT35XiU53L5CAr8BECeWRRKyZdp6iSmsZF7IMi3k7xYXTsceeNRz4HSoONArBtxUS+9se4Y48Y6KXEp0aOwzZEzFCpFj5UcYIhfvKSD3DLyxfp58RM6/MacLx+9VP6JawEZYljPR0ZrlBvQtW0R5lfDKHtUtXW4fKQmG9ZZLhAsFV5OsxZegaL1gC//c1H81iniodwymZDbvvFj0iH9p/LlW1piFat9Wv4eHBcq5IY+h3xUopeSNrdWZKllBYEsufQ4Z/XIDFGZwzSEjAoFgMqZBxJBUubc9Ljp81STbnq5yMm6/YNDTpWwdDTkFHPUn6QscoZJC5ynKQmX5o4riFhYWO4LPNrwOtwpYDjX2sOMRCfDI0JAzo3rVfUoMdil1TMyYzWWLmvLv7pRuBCVV1A4nYePeqXvHxdT6VLDQNf2iSy0vki1CA2OcWaeF5FAUjfhIXUZvulGzevaGp4sJLJhUAVaZxKvF7L+0q7ekMhfPGNAeXiAQX9DdC2v0KSex+McxUlE/0gvxT+1FVGgPx/yI0FD53BWuzupphXCG4h6GKwDquGBGqzrBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9ZbcAwdUXcxqTBLDtvAbAe0gSI7jMgwQ3F6LWfeQxEcWLRbf8ZfPSLprC/l36Y7W67a2aN+HkH3dGyevZGur3hH2g7e6/IwEaRA5zr/SALanH6p5wZep5WCiNMPy4Ejyj/niOlWPtMTZeM4OG9TN8gMhDBc8jYEsFDGgf89JW4NI/M9BwO1wYFqikahXqrLpeTWR2rf3smGERpkKrUAUAM66te0tSPoMlP4di+rQYHaTD8XzJI2HWEWig8Y4dDIkNqUkWOTJ0yHeJ2zxMxe3FW+71TJYXQZ3xobpmoR9kRlUhL0kEMIEZg1qfMNoKPLG/jZ+7Ol1ivXBjstnt/QtJ2BgFiGClO44UzfhisNi+SjvWVybRIQ7/SEwgi87pL9fLA2lTyNOvkP9Z1xYc5zymn/IkIOX4Z2L3wovqePYdqtxEfuqb7+z8ayfe3DmFaqV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:34:46.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6212c66-e3cf-41d1-2464-08df0fdf8961
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB902451

The amd_iommu_irq_remap flag is already validated during irq remapping
domain creation (before calling amd_iommu_create_irq_domain()). The
duplicate check in irq_remapping_select() is unnecessary and can be
removed.

Additionally, mark amd_iommu_irq_remap as static.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 2 +-
 drivers/iommu/amd/iommu.c           | 3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3dbe20023456..bce5027388b9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -434,9 +434,6 @@ struct irq_remap_table {
 	u32 *table;
 };
 
-/* Interrupt remapping feature used? */
-extern bool amd_iommu_irq_remap;
-
 extern const struct iommu_ops amd_iommu_ops;
 
 /* IVRS indicates that pre-boot remapping was enabled */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index edcc187b8f14..8a410d4aa370 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,7 +152,7 @@ struct ivmd_header {
 } __attribute__((packed));
 
 bool amd_iommu_dump;
-bool amd_iommu_irq_remap __read_mostly;
+static bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
 /* Virtual address size */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9f9afec68969..5bb7d8cb506e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3977,9 +3977,6 @@ static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 	struct amd_iommu *iommu;
 	int devid = -1;
 
-	if (!amd_iommu_irq_remap)
-		return 0;
-
 	if (x86_fwspec_is_ioapic(fwspec))
 		devid = get_ioapic_devid(fwspec->param[0]);
 	else if (x86_fwspec_is_hpet(fwspec))
-- 
2.31.1

