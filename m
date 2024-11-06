Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C371D1302
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879437; cv=fail; b=a1i+9DzoVy89+V6g6w/IpX2Bzwrl5Bi9BwVUzBy/OZektVrzaOWFfI6Fwe30b/bc2GJ6VN3xpzSjy9Jv9PcVuiBRDrdX0m/l7ts9ZPtH55xuUProPCEsGKj8QmYL6vvHUBvLWmuzIiPLbWcyKiI5byugN37CdEzgEiTIKYmp2mg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879437; c=relaxed/simple;
	bh=qMsHQ37gVCNsoHAb8W+RedTFXV/HyVp1USok4xZS1Pc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9GSlvvtrseMYNxadOF9+DTRpWoq20mWHDTi4Zq4l8zxSKV1sRa6ibFUTsWXqE/+3+7ZNf4qz/p3wY8vlpBQVsejN4yDDHiFA6EZMbX79U5YGtcFdUvGriCg/YU6Ls0mW5lsU54SFHXni9ZnxbpnbAEE9LEP3f0rDQ4KxOAR2y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qB9+99x7; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qB9+99x7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4nWjto0upwY/SXp4Xb7XktEYCCuGLPbZvTk9VI+OfrbL+cZd9HHDqk4o+u8tEPiXvTF3lhIbkYyAvn8fBKuJoHkX34fA/I86NOEUuhTDT1UUvyRvo++lAcqL0CadylD/+dnEpJ2XwygeiOxL59AyAlS7PJdxEDZ8anl+JlobTXPKn81Y3Y12B/7/hIECGCpdzZFSLG/abABbIU/QjZyU5OOwthkha/+wqcZCBPAfhMUYq+QCSP14aA9c+PEytTqgAixxd8WkO+QN9gv1L9c3ZeELtRlsxhBY3+dIdf9lfYbjw+XEcJrv9WbL1jrcYNmMEYzaMYmUe3ItY8MvfUitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcDFi2rcHi7bfboOa5cidGxOzLO+zzqDN1TYuxgUSTw=;
 b=emATzknFp0hsBcRcJbqT3jbBPqb9q/qg6taQd94NThdMpM/pddj1L3qPBJTWqB5LLNvjXgKfhGo8XOGSyJzwj9wDHjC7iMRlCew6RwOgcsbEWp1xfVlgNIVwukPcq8t5Dbr4z5Z+ox53IX7qt/2WJYOsOfhh13rYGkM5Fz9/zFDaIqrHngm2tJzRjKyqZAYNqms/r+J8C2Sf8eqz20zl9hfLOGusEfxZVGM60iOaLmSoZfZA+qjld7pSqgJ8cVZEycbgi+4OxY5CdYrHAPhFo+tpJDjhefKFEYzB/fKoNtImz5v+xQYFbyQbW49dUqhHSb6ekV5nhu+6iZnJNmd4sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcDFi2rcHi7bfboOa5cidGxOzLO+zzqDN1TYuxgUSTw=;
 b=qB9+99x7guRdVmgaEwwZov6/FJ3IxWmumTO1XTP0G1v38ZxtZp8ZQioj3OjgvplsgoWlVZYKyKNQL2woPR1Fy5f+VE+DOJe6836HGqu0cPt9Jw/ESPrGuiJh7akt+ZvP4Yypuh8d8l5cOFikFQil3XYj8pd9oChEPG3uvwVlG/o=
Received: from BN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:e6::14)
 by MN0PR12MB5715.namprd12.prod.outlook.com (2603:10b6:208:372::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.33; Wed, 6 Nov
 2024 07:50:32 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e6:cafe::6b) by BN0PR03CA0009.outlook.office365.com
 (2603:10b6:408:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29 via Frontend
 Transport; Wed, 6 Nov 2024 07:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:50:31 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:50:28 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Wed, 6 Nov 2024 13:16:35 +0530
Message-ID: <20241106074639.2039-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
References: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB5715:EE_
X-MS-Office365-Filtering-Correlation-Id: e283a586-7720-4e5e-3a93-08dcfe37b09e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KCUEdxQ+P97caq07M4SLKx2JHfVoYdzdEyt1HE6ZUU7LtVPU0YHk0CIZW3ra?=
 =?us-ascii?Q?D22W4hnySsmWUCiYDJO5g4Eb4AUniJHO2vqmTuZYwQdHaIFPOKQhZxMf9Gw6?=
 =?us-ascii?Q?Lrc/OcxE53F5Qd5re6heiQlCGgFX0t+itje7EbaMyNKMsv2ie3Npl0TdBLBb?=
 =?us-ascii?Q?qZ9T3XBCFV3uzPZhkQg6rMo0j0LJomeNyj4NFTHeUCmgGk0Hv5ovFk9fyd+u?=
 =?us-ascii?Q?ps9n5eJSE3GgS7RStE72R3/Q5nAxCoH5Kioptd+U4BAAxLG1zF7GqMjq01VN?=
 =?us-ascii?Q?TA9LrZE9f82u7Jn2pwmkJDwB+BMbzwT2uRN2HGSymjODLaSgxviyMKo+LSyd?=
 =?us-ascii?Q?H3NTwIgZXjDVSoJLD0QLYqkA7Lg872FLQKrxU7VyKPYDhc28Qh58g8HUKHDX?=
 =?us-ascii?Q?TLjmCtUNdFTf4sq8HdJ612j8yuqVSraov/PthI8p2Y8DZhBDwCNz4eIZDMWo?=
 =?us-ascii?Q?oL8vA4Hoq0YzbNDOecGs826PEiDzSp+j6EChIrSLCMjYeNROuYizChMgXkQi?=
 =?us-ascii?Q?W8VF72meUJEd0iG73frse/JK8r8go8nduYMG6pYtNWV0ejj3LLb/YOm55XW7?=
 =?us-ascii?Q?HkboRRd85zXlMmablFbkPzS64xGCSeoUQdXDgmAHifRlLKKjMRh2bxjoln2S?=
 =?us-ascii?Q?T6jUWkEmda6wQ5pfPU+qRRHuALN4emKzw7o8mKJs/ht0jYKo9iaQ/S/J9fyP?=
 =?us-ascii?Q?hByL4pBy4xbGHSi9T7RlJogXgWxCXng6CtwBLKDWEblgLdZsf5qRGgi5Ruze?=
 =?us-ascii?Q?DqiLn+riwnpgXok4TjqlGeFdK40Xt8ZNzOu8jqOqfaLU9vqz4hcP9OPvp0ih?=
 =?us-ascii?Q?TtEzIwnxZzOUoegdip5kfuPKks25zz60zKF6jVwBeES3KTrglB+phUkN96Al?=
 =?us-ascii?Q?H5fluW4TR0YhI/2LJyCmY6AvRL2m67PFbqNVffnilIxcHzBvfv7Jud/hA3C6?=
 =?us-ascii?Q?TjJcW5FOaDaNfWs0D/nRFzEmqo8dtIcZQDdR6zfAPX9OQ31tXIvibThbFZkm?=
 =?us-ascii?Q?7XbPtl7/cDTiAgkIH9wZW8RGitL7yqVCUETtXM2YTSp22jk/GEUxvsUyrnbU?=
 =?us-ascii?Q?yZEbeTtT2FgnVEvfJjXWZ8V7rkeqCmC0CWvtLWOUC7uCN95nv5W6J8ADETiQ?=
 =?us-ascii?Q?qWOvZW2N2tuPcnSbnUt14C8rlJ+t68jPJMt1LjxyvVTXCPyk0L9WehAjg/y+?=
 =?us-ascii?Q?CjGkbIoGmdO1lxrco0WsojLfjjfb2l3ccPv19rae3n7E0xRH82c4ixZqHeEG?=
 =?us-ascii?Q?6jAgHaoewEk0gPM8N51zGCy5sIKQsUuPsLsCwR/duKCyRBzjTyGznJn90Lqz?=
 =?us-ascii?Q?lwd/k4Tb9/LTPcdyiVKmqv+H2eOdlJeXEklllQhXPHSg7ClJsJV2cXIFAktk?=
 =?us-ascii?Q?ECbNoBgQ1kXyZDdglmBl9pHqcEKNvHma+wJg4sgLdkYly79Kbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:50:31.8490
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e283a586-7720-4e5e-3a93-08dcfe37b09e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5715

IOMMU driver sends command to IOMMU hardware via command buffer. In cases
where IOMMU hardware fails to process commands in command buffer, dumping
it is a valuable input to debug the issue.

IOMMU hardware processes command buffer entry at offset equals to the head
pointer. Dumping just the entry at the head pointer may not always be
useful. The current head may not be pointing to the entry of the command
buffer which is causing the issue. IOMMU Hardware may have processed the
entry and updated the head pointer. So dumping the entire command buffer
gives a broad understanding of what hardware was/is doing. The command
buffer dump will have all entries from start to end of the command buffer.
Along with that, it will have a head and tail command buffer pointer
register dump to facilitate where the IOMMU driver and hardware are in
the command buffer for injecting and processing the entries respectively.

Command buffer is a per IOMMU data structure. So dumping on per IOMMU
basis.
eg. To get command buffer dump for iommu<x>
    #cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  7 -------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 601fb4ee6900..876fa671ef91 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -878,6 +878,13 @@ extern struct list_head amd_iommu_list;
  */
 extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
 
+/*
+ * Structure defining one entry in the command buffer
+ */
+struct iommu_cmd {
+	u32 data[4];
+};
+
 /*
  * Structure defining one entry in the device table
  */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 25a4e738d067..1b989d45257f 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -125,6 +125,30 @@ static int iommu_capability_dump_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_capability_dump);
 
+static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	struct iommu_cmd *cmd;
+	unsigned long flag;
+	u32 head, tail;
+	int i;
+
+	raw_spin_lock_irqsave(&iommu->lock, flag);
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	seq_printf(m, "CMD Buffer Head Offset:%d Tail Offset:%d\n",
+		   (head >> 4) & 0x7fff, (tail >> 4) & 0x7fff);
+	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
+		seq_printf(m, "%3d: %08x%08x%08x%08x\n", i, cmd->data[0],
+			   cmd->data[1], cmd->data[2], cmd->data[3]);
+	}
+	raw_spin_unlock_irqrestore(&iommu->lock, flag);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -144,5 +168,7 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_capability_fops);
 		debugfs_create_file("capability_dump", 0444, iommu->debugfs,
 				    iommu, &iommu_capability_dump_fops);
+		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
+				    &iommu_cmdbuf_fops);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..efc2d1ddd7cc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -63,13 +63,6 @@ static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
-/*
- * general struct to manage commands send to an IOMMU
- */
-struct iommu_cmd {
-	u32 data[4];
-};
-
 struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
-- 
2.25.1

