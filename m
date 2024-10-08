Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD61922C7
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384124; cv=fail; b=M2NLhPgv8SYphE3o+wF/VPJSs2nazMvqjdWghaqIqstR4mh+qtHa2ygeSpYYjx6NPgQG8LVcJbL0tTUB7qasjpP724BaXQwtFc7ZxSWUlpUQifUu4LzqNZQvZVTMvLWTP+yGltZUViAGaK2SlzM6IUo745sBFmMdD9v0zkFsXh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384124; c=relaxed/simple;
	bh=P908lYJ5ZhJbVbEIS87z17gqxHlP2tQzjb8Tz5mKBkY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vAbwIwN7YEkZaOp4wWhGOnSW1avChrG8k196V0KrEqoTCnm354Af0rk6HWxzoQNZgUVA2v7+RZBOjnz3oybEZ39cd5IbXqHUYYThjq3b6Q/12BrRt1o65PLHWiBxc066DRyqkHXaEvvNbAlF6tMwo9GSE4gT3dy5VFQ6zYMZlDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FXpl3U95; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FXpl3U95"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Swn7wpPQt4+5svBiuG41Fb4DqZx2VVOzhILekEd/PRcfOqVFUctV+97k+WP4chxT6O1kTyWJBhIXnc/md02U1cXFwKnLRtHgq4nbdF8ga8v6gU2cSZNVaBhphIxh7QZ46hhFp+/PQOUm0B+eNuSMG3kdePqD6ElPZsNlpI7EPUByDlzV4tlromS2E+AmNhs0CsdAivydhQCcs2VkwMt42BmsM0argbpsp3AkGvrBSGolCwtVC2TqlO7KQ5/JCXibnBkIDkYTR9V/JYY/pE3D3Ui1WBusVc87i+OYGUtUl4egGqQpPjeFSYaljga1aCD3healanTSmzV998dY22FhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8lOdyG2v68Y9ck7VWGqKEIFPxT5yDVtLG1HEYnyoKg=;
 b=wfQcsrefKb8hPu8WDFmNMJL4yWO7o6YXckPXs9cjMsFAtxCSeK6OdpgnSxYJUBAwtIjM1yb8Vxbh/S3jWUWS4ftJiCjyA09ZqaRPaeSUCtKejT42As0IsMHJs/sE70vZj11Bdb2AWCWWTMoHg9aqK+trty+WShp6IAoUCziFSIliizz+c7WhXxPMJhw34LMaVmwXVXCpSSXqav+Wr4XUTYb2DL9Sext3p+pde0+BNr9CYC08HEUp7I7CbNcU6OC0SDIOake4Rd1ufHyRoSKZ2cVCHwdFbsiKv+vCTSDZDhETstJW734Eg2hE77YXAzyQDmy4Kadd6qLXFWSeSsxX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8lOdyG2v68Y9ck7VWGqKEIFPxT5yDVtLG1HEYnyoKg=;
 b=FXpl3U95YHvkSePNFisZdSr7/ZO7a/YOPUFZXaMsxyLKwNHMjZtva+aggiA5kAr6ibk03bLXdP4HN2eeAbASlGqqSbBWTtnYGQyqGP6tgXJirXl86t/0w8ueYJPNyJhgKzFEeKuOaDTRDLnT3GFNPwY17Q0KU+N1jE+LjM/n654=
Received: from PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::19)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:41:59 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::d5) by PH7P221CA0006.outlook.office365.com
 (2603:10b6:510:32a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:41:59 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:41:54 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Tue, 8 Oct 2024 16:10:31 +0530
Message-ID: <20241008104035.4008-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
References: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae8c16b-f579-408b-3ef4-08dce785d677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Eg+jI8jLv8gG4P2sQgKwCzBCmui1fnhtXTMNU1QVG4ZncnbIXPrLxrbwf/d?=
 =?us-ascii?Q?xbOCOqqZ+uIQCpmUUYTiK2cbyPji7SHFJcF7Gh/tGJkGv8G3ZrpP35mMBy8X?=
 =?us-ascii?Q?w5z/M1sQGiv0ogrtpkGu3SiVOtJwfzCI2mTPgUjRLu3vMkAPS77MfGmlImbh?=
 =?us-ascii?Q?sXtQScNkEt1Kyg+KHqUKJG9lyvwOe6s64IdLuLTmTqA0ycymlCusCV4rXKu7?=
 =?us-ascii?Q?49kiJo3HL6hNSu63vkkwx+ZSUYjaOH6BKVdEvKLRXyO8D3hHmqiZQsuoA1v6?=
 =?us-ascii?Q?Njw08EQymJobrdGukLQoONh5s7iR4Et817mE3wY9nm0L9z2kizgDe/C1gRZh?=
 =?us-ascii?Q?ATryAGGfOmGXox9NIEtYurdzcx9o0QKWFKHC237YTaRQnhKgScFcgNV2jc6Q?=
 =?us-ascii?Q?kZYHfwu5x9WX0nJUMi0NTygKOJogdaR6s+KkOK+8mRMdgZRxZyiRNpsjzsrF?=
 =?us-ascii?Q?SzMkulSS1GI7P8K6dqQW2FEBu5eu/6dEH2PnLhsuzLVzYGiouZpzfY3m3uqO?=
 =?us-ascii?Q?EtLlrb6nyMM1w84Szne2ZZ46z/D+O1Gx6a54i4t6hami0t/o1YgVkUnO0Db6?=
 =?us-ascii?Q?A1JF5gMsIPXRqk3GJoCakpQJa1En2Bp+bO/z1v4qLNxYeMB4XMpZIjbMNAnk?=
 =?us-ascii?Q?RDgHPh4UeIpUpWLGBi8FBSxY+Z15FA7x2Ygwhcc6Obwq3mi1DzENjSmOPAQt?=
 =?us-ascii?Q?pVcOU+w5yO4BvpVGRRjORbeKYrCTDa7yfkWOFMo/+hopenInqBA6pl3Nnzc6?=
 =?us-ascii?Q?YFnjeyjYXb5oQc+lsSAF2Bys7Jaub/0meiSt34o+zJquSJW48YmOvjujN1L/?=
 =?us-ascii?Q?O8zeacfAo0Wqj4D6CoBF1E1WMcQKo33G8dtFxWCw6Q33BOfqPCmrK+Wulv7L?=
 =?us-ascii?Q?Oz+MDxmCOT6L0ydE3DYWVtp0ZQvSAbtG8iq4BqOOBotIPdehYxKDh5QM8tjT?=
 =?us-ascii?Q?D2D5ubA/atUYTtLY81vdBPTOIzybD6SD4kjaXHg+Np2+dH/iC3U+aJG8zNaH?=
 =?us-ascii?Q?raUYX9h+2XCFeSlyZmRWE5mhrYID07FLtKZ0doAhutC/T5eqGfYTZPdHpbd3?=
 =?us-ascii?Q?dXAYj4EfmvU+3rN6KWNsN1UgdCxqwIWBAws76kz2qmvjUds8FdS3Y5Fwutbm?=
 =?us-ascii?Q?rUkSLABl5GdTTht3UlBP49BMo6LCoS3rGPBnkOJv1XC13VZPCRVdFTsqejb+?=
 =?us-ascii?Q?gaTjTXxZiCKnOKm6Zjx1d2K5Mzw0J95rZm0hCE2C+7q96byUHlORUMEtXwDy?=
 =?us-ascii?Q?v7ikx782IJNKUSwZfj+XD9/E8LOxDfhzXmZXviGez66LKEEx27HSf5PXjDUb?=
 =?us-ascii?Q?SKkTbm2qlkrdO9fOUW6CgMf2terd17Pp1eZ+s5TTg5g/RE1GFFvEo8pAvR4n?=
 =?us-ascii?Q?ihLt8yNvUz1bNXEHp6YOrThxcFC3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:41:59.2698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae8c16b-f579-408b-3ef4-08dce785d677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916

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
 drivers/iommu/amd/debugfs.c         | 27 +++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  7 -------
 3 files changed, 34 insertions(+), 7 deletions(-)

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
index c3ef15e7b918..69d2b01bc0e4 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -159,6 +159,31 @@ static int iommu_capability_dump_show(struct seq_file *m, void *unused)
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
+
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+	seq_printf(m, "CMD Buffer Head pointer register:0x%08x Tail pointer register:0x%08x\n",
+		   head, tail);
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
@@ -178,5 +203,7 @@ void amd_iommu_debugfs_setup(void)
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

