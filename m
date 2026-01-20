Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57423B8BAF
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899931; cv=fail; b=uapgR5e+1Z+JQ1vy24O+f2ue0kF3SCirw4sZ8L+cO9znJdhMAkMVy/qQ9EOuFBKiswF3N4qY9aR7NVLl1f5+by1bVBVFz6EZp6vi0BxDB5ml2KMAxDX3oKDX5V+vqbO+Se+x0T6Jr9RjC87M6XgNU/nyi+VSF0JjRP/6OGYjHp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899931; c=relaxed/simple;
	bh=7+Tf+9GPmN9KFOVDZKziYe3BOeE54gB0aDh+aPzcb4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQWhgrM8dRpB6q9odZ9CMtiXe8jBgvV/JP1tm0cqBFoO79ybyqq2U0at1gsPqmNAd1QrifFYj3b4TWuFOOPrXFZtoS37z+mTJYiw0dqvHkWNQg9m7h7euGs8I3MprGkduvuJWuVtSq46NNCGZTW0v2FzMXWh23ZwwrVnvz5nZpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eU0ruGOP; arc=fail smtp.client-ip=52.101.52.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eU0ruGOP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWZlyUqVNjGdNSJk3CjkDZsaRCwPKPDYryIjyZ7zSO4PKvnFlZ3cSMw2LuzSljVIDw8V6wFBmQQvFkZ6p8o1C562rqyuMbCgFPHE0S0arYH1R0vLAsUB/GQz1pZKUpkVSyyofgOj3Kut323xMIqE5DdOdcCB4FvUObcaSGu2/BZfkm5Uf0F4pxPzaz9nebPSX+eQk80ZR9Khur2HfMXBgP36Qak1pJtQgja/JcUSZhcMpGQkX9lrwjeAx137KYN/m/A+SF5iKEpjKQbtn2aca1JKo2aFcXOTbnrXj2BGbiz+yt5ymRJfcWJN1ZGuX7f4X4vETa8VjwlD3cR68U0H8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJSPWyKLipwmI6zlg4A1koEio+qf2NLfB2iJGEtll7k=;
 b=B3D4IPHIlR9WUQ3XGssWzxK2X/XKepiNNgdIG9WOdTGUfFmtIbNbCnqZ9WRygDZQM7phJV1edkAWZOyF8Ug7Rz1UlkTOUCA20BC1D5ttv9Srq8dMuyYp6BPbFQCsyJknCykKRrZszqzQNkKQcbWO25nqMtANERPTRguGMlbWrEftenKIpwXMfbCHK2n8pX/jKOORC692XlSFQeY/GaO1++3p2JZb2NLZ7ur950lt0v/wwhzZifnkysbng490/jsaqEnrVS9SCfKYIVRbm3XFAyCaIM3aqiYzduGYdHCL44Lijvorp9SfUQREvopxAUK8BngdckTy4+ahKntwmb5S9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJSPWyKLipwmI6zlg4A1koEio+qf2NLfB2iJGEtll7k=;
 b=eU0ruGOPQuJ/0HLhVWDVAXHcM+vMTXMqGFCJDjd0yhghn2a904b3B0nHWYnsPBWJzSIqjLTM2tdYql6HlSjQcEI84Ae2hG+x1a3hcnM8wekdNqK8twyJlS3YEL4Cl9eQ7FAyeGOx0RrUO1WRBvq7lc0NwXj30xtJKyx0gPQa0pM=
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 09:05:24 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::bd) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.8 via Frontend Transport; Tue,
 20 Jan 2026 09:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 09:05:23 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 03:05:20 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <Srikanth.Aithal@amd.com>
Subject: [PATCH] iommu/amd: serialize sequence allocation under concurrent TLB invalidations
Date: Tue, 20 Jan 2026 09:05:07 +0000
Message-ID: <abcfda19c05becb988ede3a1a0ba6d87161943bf.1768899638.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2d35d3-7982-4d5b-ebca-08de58030bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?roD5rkLow9m1Sjo3pHId0fCjjqj1M0K4AIY9aIyZVdQRpQpk+7Rh9J927Ekj?=
 =?us-ascii?Q?6O7KNwakehxKNo1fwP/WRFqF6+HFdBlhK9JYDECufEEeWKsDfY6/q3BWkGHd?=
 =?us-ascii?Q?pRiYTQ/EVPv9UPnZ43/aRkyWZOKultCF/hle26MT6UUm39OfRLcDbEdBluLY?=
 =?us-ascii?Q?bQGgTSAJo4qfR3+b+/ZLV/2+IPOh4L/DUncRTjJcUM6yXXmGyH+WVA0JWWDo?=
 =?us-ascii?Q?ZkqiU41MNo8iT+T+YRwuLwEfR8HUr/fqUZE6HRFjUnEgZTg695fvkoU83/Zv?=
 =?us-ascii?Q?uHakRR7a614tRwxyEBR7CGLL+DHGFRtFRPAASScL4FaJGBrwAu22bCJ3ZU0W?=
 =?us-ascii?Q?kOPeLVOhQxxzaNCZQTi5vW1iVl02XQt9rDORGwmKhQJOqGZes3tqNxgWuUnS?=
 =?us-ascii?Q?vlXrfA9anXr3EAUlJ0hXfqtho6Vn6wV+tSO4DxNL2sc2azxyWGiFwoxOD7ac?=
 =?us-ascii?Q?TzT2JuHzfRD4fiNNOcuUOSJaXcfGo/YyZm0LWplbqe2A4gUohK77OiAXhhQ3?=
 =?us-ascii?Q?YLcu5cqurUkv//Km+0RkzGnxEf/Fgeya2kTh608pCk5W+WzFIfh7+vPOVYhT?=
 =?us-ascii?Q?4exs9uY9R0NiEwP9LcfZ12E5zN9k2xGO6/LrdvzSaHHGfuPyCAT70EUAL81H?=
 =?us-ascii?Q?K+r7q5FHLR7cG8qlZz3OguAJ53qnUmcPagzdeA/qFeDrwkj3XgtFYM/2X2+l?=
 =?us-ascii?Q?XrtMCFqTNItssseZynlDy9bvRM3GhIOOaXLaCQeoGC1FdTziI01pnROjMp66?=
 =?us-ascii?Q?n0cglmre/UA26CTbiNFMSKpCyRiY0pYJC1w3Oh7Z57bQVkWnK5Xz8u7KC/9A?=
 =?us-ascii?Q?PDQ40lsGfEBpWDi6CVZLkYrbnqOylKP1zBBqybpLx0QoHG3NtRixAndCDdI6?=
 =?us-ascii?Q?ePFPxb7MzD5Jmk2GGzfJnm3o6lZUhlyWMsddZ9E6Y7VWCRAo2ONXRrqJ9dOG?=
 =?us-ascii?Q?sGs5nHbSAcP/EAAnfbFfcFyPP6DRtgoyrj2gdR5fh3/Jik5zxQzDbOPwmDjK?=
 =?us-ascii?Q?TOLryLvBOqRbyJC95MrUPunDTXvjAjGKiWkFpefmIzFMvEHKM/FNclOeC6pm?=
 =?us-ascii?Q?8/9plFRvMQ7VxGMzVEM/e9fKeJ3gWT9xga5ebk7pD++Zqr5tLaALpqX7eixU?=
 =?us-ascii?Q?dEHUN3evlPwoZKMNWRmwX6B8P8t9ML3CmaOr8yauLVFkRkHMdeSq9+iNFvGk?=
 =?us-ascii?Q?c1H83PDkTwJ4xC5XNG9/vLDlmsAt/uy5GvbgWQOtbeo9Ct0gaYyeM/l01n0/?=
 =?us-ascii?Q?GlDtbYpEv7hl0kL16hjTzgoMyGY0I/MxVA+iJOGDXrbStmIKUEUfIvUpKvYJ?=
 =?us-ascii?Q?7uKugyJX7vDURsK0MAOYq40TGyfNd30QJdyowXF8FLY/eocTB7Y/aPfpDWiF?=
 =?us-ascii?Q?8WD0PJy3AnviEvwae3vbP0iXa9Lfc1JHK/bYOSGqJknkX7aHUMUdWZW/sefW?=
 =?us-ascii?Q?FnKXA0sqX7I8j8hgwEOncWNFkr6E/PfY2xikrrB4GyJGvwDZ4G3cg3GAgw1f?=
 =?us-ascii?Q?HGsO8O0ot3uDXKKQJNYsaKZQ8MaIIAFN7mGfY6t+9EodR2RMh5svyTPhH7UZ?=
 =?us-ascii?Q?LRpqASqD1xmF/aZxn5dPYsPzz+GFUzyufIVLZIykExrnnplDoHiJBbz6CL1y?=
 =?us-ascii?Q?wfSCP2s7sLLxC8lehAjMJ00E8yXam2ufdOFm4+mXJ8yFmB0pZYZKK6vmglWX?=
 =?us-ascii?Q?NUlmEA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:05:23.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2d35d3-7982-4d5b-ebca-08de58030bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1

With concurrent TLB invalidations, completion wait randomly gets timed out
because cmd_sem_val was incremented outside the IOMMU spinlock, allowing
CMD_COMPL_WAIT commands to be queued out of sequence and breaking the
ordering assumption in wait_on_sem().
Move the cmd_sem_val increment under iommu->lock so completion sequence
allocation is serialized with command queuing.
And remove the unnecessary return.

Fixes: d2a0cac10597 ("iommu/amd: move wait_on_sem() out of spinlock")

Tested-by: Srikanth Aithal <sraithal@amd.com>
Reported-by: Srikanth Aithal <sraithal@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d7f457338de7..593fb879b7b0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1422,6 +1422,12 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 	return iommu_queue_command_sync(iommu, cmd, true);
 }
 
+static u64 get_cmdsem_val(struct amd_iommu *iommu)
+{
+	lockdep_assert_held(&iommu->lock);
+	return atomic64_inc_return(&iommu->cmd_sem_val);
+}
+
 /*
  * This function queues a completion wait command into the command
  * buffer of an IOMMU
@@ -1436,11 +1442,11 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	if (!iommu->need_sync)
 		return 0;
 
-	data = atomic64_inc_return(&iommu->cmd_sem_val);
-	build_completion_wait(&cmd, iommu, data);
-
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
+	data = get_cmdsem_val(iommu);
+	build_completion_wait(&cmd, iommu, data);
+
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 
@@ -3119,10 +3125,11 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 		return;
 
 	build_inv_irt(&cmd, devid);
-	data = atomic64_inc_return(&iommu->cmd_sem_val);
-	build_completion_wait(&cmd2, iommu, data);
 
 	raw_spin_lock_irqsave(&iommu->lock, flags);
+	data = get_cmdsem_val(iommu);
+	build_completion_wait(&cmd2, iommu, data);
+
 	ret = __iommu_queue_command_sync(iommu, &cmd, true);
 	if (ret)
 		goto out_err;
@@ -3136,7 +3143,6 @@ static void iommu_flush_irt_and_complete(struct amd_iommu *iommu, u16 devid)
 
 out_err:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-	return;
 }
 
 static inline u8 iommu_get_int_tablen(struct iommu_dev_data *dev_data)
-- 
2.43.0

