Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9F31A056
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764600003; cv=fail; b=hebU9H/Bfw2nWXXnuaFwo3pDeZRD03JkK9G4TGMIbuHE3RVeLDD3piCYLEHnzOfO87dO10LhPjGlLkur0e/q1YTxXsl0wRmurXtWhcxnWSKZg8bnkQKy2sgi8FvJ5G+5zhXTbW8mAsk5XFJptpstnhIefxXDiB6/0wj6KKJ/CPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764600003; c=relaxed/simple;
	bh=MMxE+LAUGdIgQLyekPzU1mynVJYbjpKFf0s9zFCU19w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VJ3NY4RN+4umqmZJRf+4jnmuOBtm1EIhHw7YqxleOVZrOM01YavkiJLWxcGzncp2ewYYd65bmb/RjMiDM5pXizjo9tOJV9jCHhnsadxLA5KT628GMUIMTHgyPXv4p0IYBDSya6c0FSSZAz4kqxSG5tVQs3PA2c5aI/5dV2FIlrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s/d0VPnZ; arc=fail smtp.client-ip=52.101.85.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s/d0VPnZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9nFW5cX0xWPESuydU57vmyhHcOr4t9bvQA+o5c5SQXuQEgxJj3rxyZDhBuoZp7BIwTeF52DNW3PztmfUZS6JLotgvuN175Ts9DN9dMMIzvZDfnc9LOEuetiFp4xRzi2yFtCHmP7ML9gX6Sxoy2lluQ33Gul68DNygT5rxTvWl2adLTimaMtnKBRTVLDgvYHTx79dL4lHK4oq15ne4sdeFEgCjwdyEtOksj1w7vS0J85Ld/Ba9fB9O+jFEKFQJMOkJCmuHVgMToehTWaYCql97xwdGonyJLbmLIJyIS6oO9FbnVwoLXZBGaS8wKThe1q/Jg6e4ygx/ITmxalvkwVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhpqDMtbXoPC1tfeKoR8/urjFRPfwZZf/g84yKVBkZI=;
 b=LRZr+VK3dNRpQMFzceDnF+k1EP+S0/HEERmqU7gMbxrQ/bByD/HmKMb4hfqXtbWRqvXVZogZoL4Do1As3eElqVejtADV+lFexHKftmrKLgcJiC0qMBg9kqE0G4tHnxu4Unh775d6NnDY33v5fJU4evL4OTy8zJl9BA0ws7UkgThAWCOWRHKwwmLSW2QQdsGk/I8u4BUqwAvKnaMo5lpNPT5TgTZayYlPtYeTISbBRQ1DIK7fjJfYV+KLwkXmHPpIwlWpxxBHI3hkIWHVpJtyiK0zoqaZjm+dIMEZY3UBUBgN1IVHPsiVkmNL3fqMj9fZgKazAb8fihPI3s5vRqPv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhpqDMtbXoPC1tfeKoR8/urjFRPfwZZf/g84yKVBkZI=;
 b=s/d0VPnZtJ3itJzvfatFZPpwGwYS5boY01jZrW4aAaZaPVA67g5m6qrU3MStlOoY/UNKEiciVgZa+dgnrbr5UqtNsvL+WbfDPllTU8zMxz37yb4XpJhK5rkolrQdJ2BiqH0GK+mj6NwfFw80tdaMeKc1VsiBkLTPowS9OK9Q5so=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 14:39:57 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::b3) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 14:39:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 14:39:57 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 08:39:54 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] iommu/amd: move wait_on_sem() out of spinlock
Date: Mon, 1 Dec 2025 14:39:40 +0000
Message-ID: <60d2601b17c7008834fe393e75990371cdac74b5.1764591214.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a91075-b2fd-4772-314b-08de30e77fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NyxNhZuhUI/sarGDODfi3BcBjQ0tQBAgI4jVLA+P4uVb61wlUM7xJqWOlhln?=
 =?us-ascii?Q?xEiQ/InbDHBl+c+KDbKQfdHZ1tVGCWdHUVneexGlVz75dMej0TZX3QccpjY8?=
 =?us-ascii?Q?WLVhhhKT5wIQH4aNGmu9168Pxhco6TTPKizZADRMO/uUgKn9PLre76jVNXnM?=
 =?us-ascii?Q?jkzn5KDXqB9ncO4AztG7rSsxNziMMG7eSiz00ptUmpNPAVjLFXviAaxDoa9e?=
 =?us-ascii?Q?5BYJYqkQQ1kmSS6vT6FW8z65TYb2GWIi1wtbOdwZsMTZe1cK32q6drKD1dCx?=
 =?us-ascii?Q?r260FI3Rsn7mGmd5eKKZuZ+crGTfRiMU3AQRXCNMri0u/OaG4KsScQSWxQJF?=
 =?us-ascii?Q?uIW2mN4lvD9YAmYYBOXu0YI+sOvyF5LJGujGH+V6g3/d2VzsvG2l2r7/h/mO?=
 =?us-ascii?Q?Tu4dJfGvaqMz3skbXtxYVhc3nWyPeCZqQQrv8FeZisL/gthxP313gbOpE8A9?=
 =?us-ascii?Q?qvgHXXNdHQuU5Tdu6D2G5ITae/OgpUY6/kDjbJ5847d8mcBZuY0x39sRhSqg?=
 =?us-ascii?Q?HJVpqrfM1z3m98rObxABK5Eb7kCxxE1HX1N3/pPEGVqYfbyhkGMey35QK+68?=
 =?us-ascii?Q?JiGhQDbilDbUTjzpFkT6InYulkDwg1RQntFs266uJoFkbXl372yp42yLQavQ?=
 =?us-ascii?Q?IP9bx5neg6mmxQ5Z0cZ5Tsh6Kc/mtMZ8E9PJ+yZC2nbkAI7vozD5OilN0hrn?=
 =?us-ascii?Q?+Z20HPlTCIZ8rwa2zOKchOEZENnQAcz/NGFqxG+B/7ENok28X5FZEJAeEoOR?=
 =?us-ascii?Q?dltCLSjwNVO2C3To5P/DJ6dVX9thCZFzR1sjFZ6d8Les/uRJ/mIB5UH9r8Xv?=
 =?us-ascii?Q?Pbm06IbbyU/54Sj4Gl6VvPaSEb1cuE2GFqYPx004Acx+R54IdQoQ+OC7Nu4E?=
 =?us-ascii?Q?EEfH8WRECXj2SH+99tuc+gHaeA1MWWWQpHSFALljYz/I0m4CK/8zbeUnvyoE?=
 =?us-ascii?Q?5GOov81xZL5iSuO7Vnr8i7X80eD9ec1kZFvyPX6H0qEPELmaw8hBG/PAbkor?=
 =?us-ascii?Q?NHrDvYU/w1a7ZVjxLNlahqXyi3380iaK1wq6O/VbKpeQd8ma56Z/IV2NTfxm?=
 =?us-ascii?Q?xjAhWNBd0HBLKPCw+1QSZEhtbdZenO9seHgfLHhwhZCmhLIfbyYC6fk/rhPg?=
 =?us-ascii?Q?ZVveB5re2+DbmcoTzi+IBp8Y75vPhqDa2R0Yooa11aXn6FwEk91L5q2LoaMz?=
 =?us-ascii?Q?F9JevEjYWJFDX+5yau5nVdcS+sseMV46lfoa+zUQykABfWjCjPmPH2UjvyDV?=
 =?us-ascii?Q?NWaMbyaLJnbgZp8ODTILOr7MqGpA1XmJM80EL7wuxZ/0sXgTyxZ9lLPcq/sg?=
 =?us-ascii?Q?5YSLmUAY4E9U643aWnFu/WHr8IJwgA2K5EJ1CPcUWhXJ4eAbMFiQVdOO3KqA?=
 =?us-ascii?Q?/8PvyM091/3ytzyySPlOnyWevG5D14mH1I0ZYVDVYS2dk7aqUkc9zUWh3hK+?=
 =?us-ascii?Q?N5gsq2vNQwIJBMvLzF19WZscIce7Ujb82z5sn/ytfWPMaG3MNkM5mO4Quu08?=
 =?us-ascii?Q?y4rcFrXSPg/rlltrkorI71MNEO52cmJfVMiV1SLrDNSSWAbvRbKlCn4SlQeQ?=
 =?us-ascii?Q?o+j1BrEZNiXnZTL/8ag=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 14:39:57.0685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a91075-b2fd-4772-314b-08de30e77fb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601

With iommu.strict=1, the existing completion wait path can cause soft
lockups under stressed environment, as wait_on_sem() busy-waits under the
spinlock with interrupts disabled.

Move the completion wait in iommu_completion_wait() out of the spinlock.
wait_on_sem() only polls the hardware-updated cmd_sem and does not require
iommu->lock, so holding the lock during the busy wait unnecessarily
increases contention and extends the time with interrupts disabled.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/iommu.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..3ef188b39bf8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1161,7 +1161,12 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
 
-	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
+	/*
+	 * cmd_sem holds a monotonically non-decreasing completion sequence
+	 * number.
+	 */
+	while ((__s64)(READ_ONCE(*iommu->cmd_sem) - data) < 0 &&
+	       i < LOOP_TIMEOUT) {
 		udelay(1);
 		i += 1;
 	}
@@ -1406,14 +1411,13 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = wait_on_sem(iommu, data);
 
-out_unlock:
-	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-
 	return ret;
 }
 
@@ -3094,13 +3098,18 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 	ret = __iommu_queue_command_sync(iommu, &cmd, true);
 	if (ret)
-		goto out;
+		goto out_err;
 	ret = __iommu_queue_command_sync(iommu, &cmd2, false);
 	if (ret)
-		goto out;
+		goto out_err;
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+
 	wait_on_sem(iommu, data);
-out:
+	return;
+
+out_err:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return;
 }
 
 static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
-- 
2.43.0

