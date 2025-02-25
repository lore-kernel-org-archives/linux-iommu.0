Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D411E26159E
	for <iommu@lists.linux.dev>; Tue, 25 Feb 2025 10:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480912; cv=fail; b=seZurUZWALZ1bKqCQYF5fTN9tMUkacNEXNeTVwd1schnCkGU5Y0ili6R93k03Fj2DeQ7eqxDaK3gOhNKsXvVCBgcNjiwcUdO8XCpUZmTAsDqEq+r95cdjiQ/FMqkW5N5spoZEhM8Q1yHHmGB0LTOCGaE/HgrLoELkZnaB8XRBz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480912; c=relaxed/simple;
	bh=RJGZ81Oyf4XPUyK+btY2tEv5XyFiJzpGReGpPJy32A0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8GSlAKJnMuhHlHynKgIF9TmU1c0E6PlGvQoiVGqe763elmtrhqyqi+nBImz5u3W16kajl0ElDIYupGIZvAuP3VHYT/ZnjQlsoN1s9yMSjn2r1T0fO4IpwJtSmGPRHusQyMMVmxM9s4V+OGRsoAHw2okQ8qGak0ZvL98M6XIr0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NtuLbx5A; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NtuLbx5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZJKFZi7HSfBwhrNbUbIAmcy5ikkm9a8xai1WoY1YQtKlr0gBIJgiabPhHOqRuYrbaX+6UdUQg8OogaThIBbJiJiAuB5SErAoo+SRABNclSdVgbBqZ7ks9B6W5KPIbKSIwnkgfjFtTlBxfgwRrXh590CQi6AOFy30x+YsZFF5kdCjUkdVfrRH7RrLe/ct+o31rKy4OGRybS2MGf3vU11VHoY7nfT4WOQycuZkawre9IiNpw7F8ublzI2rxwqjEO5HW+RSQtCMAKkgft00/cZeON6vUipVktLyHUK5/pKWiYgPan0DHjPaRW4kFgOHp0q+xr1mrOwuFvgB4pH3Ra/BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjmeV0JjHZLhf2jRAckkHOdzsOr3LX6qeBMJs047Ajc=;
 b=ryifclA7lKaiI55XI1mTsY/S6QoTXWzxIB9gsBjFNjkQhEww+LDw2FY8sYfbfjiRygBMvZg+w4mqy1oeXNu12v9shYC6zR0V75udaTWtcT83A/yE9/a8pX2re6czutNM/Cobco85+shyul2kG7GC0w12tnIh41A0ZrhjGOxQ6Zw/MMkQay2Gc9cyk9G0bSziTVlFQpb6SgturoNU+ey9Zf+Uaq2xtWXz+Yv5TKxNSmtPGenABgk8KHqLKqQYDDtvIbmYajzowfKjDhY/GYNVmfXILIx/xiX8GXbj51jWDE5j2DLx9ohTNBB51lW2/BBx7QwGhejlbDCxWMkaQ3aVJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjmeV0JjHZLhf2jRAckkHOdzsOr3LX6qeBMJs047Ajc=;
 b=NtuLbx5ASbg1fSCDMx5a43Za8i3bQUi9IaFYwoJOv59dA7mNxKeLWuZfR+JJFUtwY+QywtF0rLDkNm78lS1AWbCXEGlMCqvUAaTqxRhuw1TMbDUnyB0zesyG3RAGG6idv9bd85w1frSxHbdndjLoc9Zfe69tkmYh36RVEzJD5L0=
Received: from PH8PR02CA0054.namprd02.prod.outlook.com (2603:10b6:510:2da::14)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.18; Tue, 25 Feb 2025 10:55:07 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::13) by PH8PR02CA0054.outlook.office365.com
 (2603:10b6:510:2da::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 10:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 10:55:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 04:55:02 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/7] iommu/amd: Remove outdated comment
Date: Tue, 25 Feb 2025 10:53:42 +0000
Message-ID: <20250225105345.52143-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225105345.52143-1-vasant.hegde@amd.com>
References: <20250225105345.52143-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: f0173baf-df97-45b3-4acb-08dd558add9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYTP7eG02h5L4gqO29mM7U89cSYeFraN5FAwf6E5+f67aZcE6m8wBDAX860J?=
 =?us-ascii?Q?2vuXCUnGD3e7HQDJQqkKnUF+k59OOro+BHxc0tFptWqRq3PfQ5WnK61R2Xg2?=
 =?us-ascii?Q?HlRKvrN3g/Y4eEpnp7H6o3nUNCfcIosxQWbE6KGizcY/Y9Z2qLOE2hwu9mK0?=
 =?us-ascii?Q?uCFLtOZ+M7MDJHiOz1XGMm+hYiqptikh01ZSRX61E6gupJW6k5yphBNIkrgv?=
 =?us-ascii?Q?A5eBC9l97MFOy3QHoOd720M1a2Lyxtm8Pc/IX8zHvWIEjfncO77ySgZKIRIo?=
 =?us-ascii?Q?G5NbvLMTGmu+qRpsVEreEyoWmS6Pc8NHz96l4PjKEYu9N9cgvsecXQfkjyIP?=
 =?us-ascii?Q?6Afk+zUsJprUQnl81ZGfhe40B1bmfv67g0hP4UAmq4CbKw2G73wCC3FugNIp?=
 =?us-ascii?Q?gH36zD8TMZxXNpUrwrFRcoBJfVd54qwBLfh1dVllUR7GspLIAw2HwI06zu/A?=
 =?us-ascii?Q?sCMlYJum/ekFnWJ881CqTreGZIxLoJE9BdTG5ZJeHdUU8d2x5VVCin49N4A6?=
 =?us-ascii?Q?NAO8v56FldnvTJYcYMGzPKYftQTT5bxDvlkFCWUxt+zUt2jxljjwIwxynGjI?=
 =?us-ascii?Q?mS7J+BbFkU2rkq9C//MTQwYNVjJ//3L4BmOX3FncT4/DIw7jYkyhtO55TkmZ?=
 =?us-ascii?Q?oUw46Afl1VRdR9kM97Q42yG8rTVWRp/Ejo/cJ6zlWE39sn0YN4w1hhseoW7M?=
 =?us-ascii?Q?JUUK0YPqwMX5VjxYtOLjMwZ8J/PyklnS2Jgedo9esNgOolXfaIxMxuj3pBtP?=
 =?us-ascii?Q?f38yQdIH6WwIJwJTTSGMVI3MdWyDLlAHTBoTVj8nvhE2aVAIAUQ37UH+CR3d?=
 =?us-ascii?Q?prhYZp2M+6KnyVVdjvWiLx0vYdln5btgHzCTZ1+2eL/+rgX5JKeWXMVMydjH?=
 =?us-ascii?Q?pKfay0DWgj7+ONYzaFyYFY1X6JbtBvzJOm9Yf9skzehCJJc/3xdZHK3SuM1f?=
 =?us-ascii?Q?0GuI0QmtSdOu6RJY7jx3Bm0wRbQQA07YxnMfMTIj4zV2xnNUxJCoFNitKg9E?=
 =?us-ascii?Q?HltJ49l7qBbOQdtaxj2RtWuHc7gsTKrM4Bppm/bvRBXdMVWe7YsAkucqXGB0?=
 =?us-ascii?Q?RVyF4cP/mDJ2kUNy2cvgl0DSMGRkcYgjyHiWtUg3KMNR/lCA0T/RQfSg9Ytb?=
 =?us-ascii?Q?8nenym0tcqQ8+xVjYQXGgBSFtD3aCqg4AE0ukS7Dat1P7cAQ4qCKlfTF9ELB?=
 =?us-ascii?Q?VmbPRIHCPWlwl51ZLQHhmuU7REZuLAyhDvE84i8pa5xhjqIaVXk3rFlTMraL?=
 =?us-ascii?Q?zJMMMZbXL6ERmmbTcGay7Duir6lneFGsWohtPgArfYhsrfFFSmzkkQIVT/mW?=
 =?us-ascii?Q?rGJMVqlSKz7q78IMtS5GmqknsYj1PHslg24NfurHfkyfN/FdFaSjC3l8bc9c?=
 =?us-ascii?Q?xtjjCZSUr4M+CU83a7vnrmcg6PS63Au7gyQQIHjxhemQot+egnSpFMh2CKaw?=
 =?us-ascii?Q?a2aknbyFpSdtGBMUED5s8S5M83FZgyFlAXjIRxfat5RUlbwl4IElzu/rIP8/?=
 =?us-ascii?Q?pRtZiV8euHubZSI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 10:55:06.8060
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0173baf-df97-45b3-4acb-08dd558add9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559

Remove outdated comment.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index f3399087859f..26cf562dde11 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -47,13 +47,6 @@ static u64 *first_pte_l7(u64 *pte, unsigned long *page_size,
 	return fpte;
 }
 
-/****************************************************************************
- *
- * The functions below are used the create the page table mappings for
- * unity mapped regions.
- *
- ****************************************************************************/
-
 static void free_pt_page(u64 *pt, struct list_head *freelist)
 {
 	struct page *p = virt_to_page(pt);
-- 
2.31.1

