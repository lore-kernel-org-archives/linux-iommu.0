Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012037.outbound.protection.outlook.com [40.107.200.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2523279DB3
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095868; cv=fail; b=gHN3aMdLVBq+lpDGBxJa3mUI9IVWLpcYRL/31DiWsSTH2O4Ki/xcHSfjx61AJdA+oPdwAQ+zREWOZTCxykW6qqnAfgIt5vNckjadEOypNvFDVafkf1V/x8xm+MaYyRkECUPwWDV3HmLo5rB2fj/bmCkeMsZhCEI7OqLtzFKp/0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095868; c=relaxed/simple;
	bh=HZsQwxVIr7NOAyKfqUY413gHb1HpCKViLclen/YvecI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YT+b82yIp99sb6Z3XXQuPb9G+mvwAaK0toxVBKD/LKvd+Q7QUxuKj5FgxxM3Z7E5sYZ6Vt3rM2ZwRDzb/JKUasVoEmmX5m6vtduVNiXsbxMze8Ja/8RzXW6Xkbg14DN0KmhgKzzv7AW6i6ivJdDRfgQbNgrNuxN8OtqBhJtiyA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0J22z0v8; arc=fail smtp.client-ip=40.107.200.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0J22z0v8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfVjvQCeIZVY/WiHwgll1w5EuoRTsZnBrmzy4d17EDaH8dnWaxpWeOJowvzBsGbWsQezgq/d/lgil+Uh5FoJnRQ5fG/8dQkLi/MLbcIdjfs+TSNSnpGDz3jEWhgskA8EhxPXvW2SMJINolMqTAYtNg4UinqOq/kkq2WNX1wXcUg9zYRkePZd5Jwo0y9hBxIbystMfcbvb9bygdPL+5xcLeHdswm+0/Prvj3R4z0DZ/XxHB1t+UwYbIzB44Y/+1fKNmOmkXjaiWyMG11EvnOYmMAS0wlalv7QjkjUQsWb4Rafnz8kJCN23nGoNXYJg5KixUdNPoBbT8WS0HyayB4Cbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43tuPZPpBv7iF+Hxvhf1GLhxSwTlwwfklUzawTgG+qE=;
 b=dZrm1rO63iCyzS3TtMsIf79F7RJk29IalyjB6FM8zsv4HxnbvhV34RhMl7dwDSUKVWBUxhDqQE5xWxkCtuJq2t5GQLfgHUySGnpaq8zZVwtf3warCguHxDc1UQTHVrzNlJrHM4tXy4fshTGQ3/VNnNh+xBursPqjgr1P9pn4pVmqEHAKfsgD8hb03heDU/asnQU2jcaaN7JxiuEEfnj3VOZLnz3oHk9xmC4LcZ4jXkvNE5UFMgRZ8M8CzVc5V43gd99estNipIzANy7BZ2I5CSo3rus8avwyxKUCMsI/42Zo9Gzy6VdDB/Royz0FjN4aXtOf4uQSj+KGyE9hrjLxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43tuPZPpBv7iF+Hxvhf1GLhxSwTlwwfklUzawTgG+qE=;
 b=0J22z0v8J8ri7o3rQEi68xoISItM8knXDL31+VyW3a7olYTbSd23T/Itpxbi5HC4hsvhbpALJILU8HwL2Pb6D7wCfRmNBZlrlZ0e5YWKJIZg6hFmqBBNK64ChjUOYV0AKUCProbi9LCDxnv/m9BGZKlSjLwFztJkDxjVxDCT0yc=
Received: from PH7PR17CA0043.namprd17.prod.outlook.com (2603:10b6:510:323::9)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:30:57 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:510:323:cafe::47) by PH7PR17CA0043.outlook.office365.com
 (2603:10b6:510:323::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 15:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Thu, 22 Jan 2026 15:30:57 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 09:30:52 -0600
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <Srikanth.Aithal@amd.com>,
	<jacob.pan@linux.microsoft.com>
Subject: [PATCH v2] iommu/amd: serialize sequence allocation under concurrent TLB invalidations
Date: Thu, 22 Jan 2026 15:30:38 +0000
Message-ID: <c20ac675bae8565ca6307eae65efe8b71345e62d.1769054653.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 9259e045-eae3-4709-b709-08de59cb3d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bx6wdrXZyTFsw7TNax7M5YN/14boHcLZHffdahJeYmU/Dar1jRDDFoIESvz+?=
 =?us-ascii?Q?ZIRmMWy5obBtl+zoVZYWxHmay1n7ye+YkOj79G25KLbwiIiHAXDkh/DqggV+?=
 =?us-ascii?Q?rdKLaZFMPSJtvbOwcXc8HU6SSZS4NrKJurqsNGbFqaT+yghJklbVm4oHF5bD?=
 =?us-ascii?Q?1jhJkqQtTzD5WsCr94tKf5z25KPHLg3ayaN0zANFfkTnhFuAITtW3cqEf6os?=
 =?us-ascii?Q?iRFPdf9xipNrVjhruvoVc4VgIhQvvSt5cAB1iLVIsP93aNzbcAuW89xoJuEl?=
 =?us-ascii?Q?VL92gBqbJNiguY0Pt1UWQJeicmIk/i70D8RwXV8qa0mvRmSROTfBEoiXlNsD?=
 =?us-ascii?Q?rh4Ivo9NS6IayA3gUxM35xzs37gjyp4OwguUX/TRvoo/+OB3VE8OjsmUDzzr?=
 =?us-ascii?Q?ijVSoM+OLbwNVcIFzhOSkAJU9+voSdPPilgyS3REpKKquIM3dubRoZeDgeox?=
 =?us-ascii?Q?y3fgcWLJYnH+JSDZQq4sybi3VuxoYEhm3PXbB6FRHq9O9PqPHw+kVu6exCiC?=
 =?us-ascii?Q?pf0WVbgb5rw+GOf2GOw+ubhOLVRkXJ90fJ8JP2V8llR7WhqOZ6c4tjnEZGIo?=
 =?us-ascii?Q?xVEWocZfyjAxcQHevJsY7y+2KxpkPGcnP6oCAN74Wtzl5R51J+AtVL9itHWH?=
 =?us-ascii?Q?hmwhcZ8dksAqJzsUuhcN+ySeLrMD6RJu1Qi7ceHAW78pIJ+vDAaqSWskiuUW?=
 =?us-ascii?Q?z3qBOPPVqSwcyd4wlIs+axtDayAR7kA4Nde8WPVwl5/tM0qongBMWNA2aEMG?=
 =?us-ascii?Q?96WgUACPpHmnMzRghv82UfDMBksmo4p4rGfZwG5oZGGmYiNZQt79t0atD+qz?=
 =?us-ascii?Q?HPi5GO5YLytnkCZLxtK8rWivizJUOGTMWqaLz+xVn2XINpFJ5Z/wLsYSuoRR?=
 =?us-ascii?Q?yoAaohNT6kz1RR7mBtefDk8wso6hEB3CmGBJoOcC0EZBWAjtphm19EftSCLy?=
 =?us-ascii?Q?RIjxxCbE/zTker+TPOX07p4JXsbI8drTqpK9HbQw0YLQulHNbQUiH0mpvUFE?=
 =?us-ascii?Q?yPQXUHLyIdjaSW3cyrgIsBib/e2sx5XTx72inlNf8JdkUWA2OrBNevDm5/pT?=
 =?us-ascii?Q?U4vkJ/I/e8p6uUN9Jqqq95c7S69A9dNxtI44x3xgAq4bvlXEiGZu/b3cf99p?=
 =?us-ascii?Q?frczyqmoC6pAuK6r9TBGXWquBaE3Vm2ew3s3PFhYf8CKtoB6mLg8YVLEEFjw?=
 =?us-ascii?Q?M+ttcICLLh+BkVrdtmmIUnXkVzijccFphFsmQ/FkMKxtt/cw1qqNiFQkPGDR?=
 =?us-ascii?Q?zw9qda/IxHcuzpoQm6v+LUfNTLbBfKdayzxk5r24Bl2/WcLo/WOA/mFgP5Y5?=
 =?us-ascii?Q?9xinMN7RkigMfJF4AG6NgRaArXRSGPkmOmpAxP43HXIOhyGpQatJpUdv+ii4?=
 =?us-ascii?Q?5T0rxGIuUz7dz7sPTx6Imb7A5sm2jXhWfDaQxSYX67Ear3uxc3gPaIbfgCGk?=
 =?us-ascii?Q?fmWEJJZheuPy4rmPa5QshOk+87NNFjCBJSznIaSS0lWURYyZy5Mxx/Szratl?=
 =?us-ascii?Q?aoLc6qA1Qcz/DRsz7apE+vF+oyhnG4i28SfX9pZTJu6JOPsorZgeS/Bx7c6B?=
 =?us-ascii?Q?U3H9c0fYHEb+Nuf/EJRx3E45vXu91yNYOqzg4WOI4YLcV49ddesbCd0lucR6?=
 =?us-ascii?Q?E0Nb7MfG8JTraN8mPTuOdd443780uQ7iVd2jm9SV4UMandM4lFyA8ZS9Eqe6?=
 =?us-ascii?Q?mqZ2uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:30:57.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9259e045-eae3-4709-b709-08de59cb3d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

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
v2: Convert cmd_sem_val to non-atomic.

 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/init.c            |  2 +-
 drivers/iommu/amd/iommu.c           | 18 ++++++++++++------
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 320733e7d8b4..3b09da3ffb74 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -706,7 +706,7 @@ struct amd_iommu {
 
 	u32 flags;
 	volatile u64 *cmd_sem;
-	atomic64_t cmd_sem_val;
+	u64 cmd_sem_val;
 	/*
 	 * Track physical address to directly use it in build_completion_wait()
 	 * and avoid adding any special checks and handling for kdump.
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 384c90b4f90a..1b637826d67b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1877,7 +1877,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	iommu->pci_seg = pci_seg;
 
 	raw_spin_lock_init(&iommu->lock);
-	atomic64_set(&iommu->cmd_sem_val, 0);
+	iommu->cmd_sem_val = 0;
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d7f457338de7..5f2c40e61c78 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1422,6 +1422,12 @@ static int iommu_queue_command(struct amd_iommu *iommu, struct iommu_cmd *cmd)
 	return iommu_queue_command_sync(iommu, cmd, true);
 }
 
+static u64 get_cmdsem_val(struct amd_iommu *iommu)
+{
+	lockdep_assert_held(&iommu->lock);
+	return ++iommu->cmd_sem_val;
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

