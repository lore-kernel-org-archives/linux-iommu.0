Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E251DED7C
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055104; cv=fail; b=T0ji1bR0Afg2DYeS3RAQ9QUH8YoBD/XiqyCIFS9RY+7oOwWB9EeU7zzkSDQ5tkCO3GVK3OdX7NL5fo1gB4jhnBRmXMJ1iWkbucc5TuXYmsLsWnUB/pQOXhx6tAGPCz/gfbu0Hhq9gAThzhkUK/h8XrHJZp/CjcF9LvKslgdHzq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055104; c=relaxed/simple;
	bh=rrrnIEHbzW1N9olh+46U9BKwE4kwgdbLwZLynlGszNk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/VH2ENk7Q1kbwcF0yKkNXAmSTAdd6R1SDyj2rdzpeHsGw3PU+qjPtuEOgtHllW4vKl05LW/vANbH8diH05fPAyBdmdvhS+geye+LUAwBNPc4eXr9ibJgjhgoedUcJz1hTnMwmQBIxJOnq9zI6cGYareyE3//DmO5hldKu7Iuek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W0u2/1P0; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W0u2/1P0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cl2boWwWghTVh4m/mHruAWF/oynzOPz7KFcbttAg7KJ3ojQPjqG9Sq7JOcEaMlvsq/a14tvgAkS2eBEZ426lCrEp5EFY7AGwohCkPQMdg193keeA4P2Ol0XT0wmamMO8TctQn5z7NfFeb3a39B42j5EjW6LKGVQew+ooEaOTWoEDjUsk/NDA2ukVS4IglSd5qFkxxJzxs3ntlhQ4VxCMkOAr4PZ75fKf9Zh+ueBREO6omoP3CH4E3dvASFZQcsetH9f5qN8jDB/LJiQDy/q7kiaZH9KmwzEvB9DXz0D+aa6sLpGz4MUGRR01dLKlZICw4XOnRfGwcFvNptJDxipy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ymOvmTvCjIy5d7nKTYWHEAEeHpSUjjhMIDYfyBbbHI=;
 b=nBZBhCkB3UjwVj4zJ32/Xgwu4lPiWbBTjcDH3Aa1sEQEkGONANiVLVC0DqvhPdf8WVlj7z380cWLEfimddZ9bYDc0p/YZA5+EkGhXLfUO2LS+jTWfWpQkbERoNUYEkpZ/f5b1f1THEEl4XcFZJsbtBuIa2dhA8dAYofm9sDop/z/c/lukv4+qDS9BciQyoEskCkM1cMZ6Kibs1qhQYZGQa724Rs4h5rYRdOQ/DeeSF/L7FpHWSJXq53uCDt1WvVguGUnoN8sSMs64/OOvA3fekPo+hSnczrJ4hoBQ6+0o3fi0SyYriXEGENU5i0zuU0PmOOLmfLwKOrmDrnCSyc9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ymOvmTvCjIy5d7nKTYWHEAEeHpSUjjhMIDYfyBbbHI=;
 b=W0u2/1P0tKlVREoku0inKm9twZ+W8G3dctUqDccMu8MvKjApkJQYEZ16qNKPzNhm202L+giZ9Uv0khX6IOXZDrmDHdNkn9jW4tV9x3Opln6RmUDZo7VDbr8Dw4vsKk2PBibfJmvJDCbCF/fzP80x+alkXYbNPLGI7cmd2AnT1Vw=
Received: from SJ0PR13CA0146.namprd13.prod.outlook.com (2603:10b6:a03:2c6::31)
 by DS4PR12MB9636.namprd12.prod.outlook.com (2603:10b6:8:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 16:38:19 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::44) by SJ0PR13CA0146.outlook.office365.com
 (2603:10b6:a03:2c6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.16 via Frontend Transport; Wed,
 4 Jun 2025 16:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:38:19 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:38:15 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Wed, 4 Jun 2025 22:06:43 +0530
Message-ID: <20250604163647.1439-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS4PR12MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a618fd-8a66-4189-a162-08dda3863689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LQjugXzF17Sb0OQPMwSx2JKd3BVfduySxo3uphCm8YJGOWZ5XJRSyStToK2X?=
 =?us-ascii?Q?JvrqOAZvfAXFkxueXxRMLvlD7oB3PSjw8Te6TYjzbuIf/Us5bulWB/yYUkWL?=
 =?us-ascii?Q?QEV/OYYMgvHfXbZzxfybm+kjt9I1FXlFxHpC/9FIAGd3rym+ASmIqHag7EyE?=
 =?us-ascii?Q?Sb/CrFyveSnAWdC7E3srld04xARgwg/LqnWvueoJN9H33M4/P6fAmh8roQQK?=
 =?us-ascii?Q?2mUXkRpUQvJHiYJg6VaM3LD4VYprozAFlSLb+XpDRo1gTwcZaiFJPAaP8Siy?=
 =?us-ascii?Q?3gyE7HssL+EbFGzAkkQglqBcgAX+sS0klk2In6hO54t7gccCAa5szOaouGHg?=
 =?us-ascii?Q?hr9l5AiA642HGpQGqoY2mUhGbzmCsJjtgdCwaaiIfdomdxxX+GV/bFc5zbrg?=
 =?us-ascii?Q?nIV/w4LzKPVTcJTSlNrWk5c29aezSokZkG9GLqnC9lSqhQhqI4Qcjwy+bKpv?=
 =?us-ascii?Q?MFeMFXInUN++yyhU5kE+GDdIRJxd6KMSYR1o9Mv+ilImAVPz+0dYptzEhlWY?=
 =?us-ascii?Q?Cm4pwHZBI4uBuP7TGUDHjp6zCgmpgpV6qq++IXgdLKJ4hgC+q3B1j5TgyU8o?=
 =?us-ascii?Q?HUYMVnZXhr6Zy20AJ/i5JcW3oRyoI6gDxcS8+INbPvIzy5raW+jNvX61cYi9?=
 =?us-ascii?Q?iW/+nDC4duE+QTVWYLItSeNliH4k9jlXaTNClrHtpVu4ebcqaRJ8gjrbdFqJ?=
 =?us-ascii?Q?BQtpfv+7YDXJuSyw1mK1lxP22kpPR/3NmtYyjwlRY2/ywu/E3koWj/fU2Fwm?=
 =?us-ascii?Q?zb1csOWiQ3UKd95rMvXwAQMtNRu5uOpgA0iXD1GNxd0UK3CnxaYphPE5zsmQ?=
 =?us-ascii?Q?znA4DHnAUwYmPnUVvO/dd3XN8J/Ppzn8ls5hmJ8H6YxqF7IRQnrsUyNy69kj?=
 =?us-ascii?Q?gDhMnecCeS/Ols6/ThMR34NMvWqjB0auQwTG/oSQm41Fmmk6Sia8AaJejy0i?=
 =?us-ascii?Q?fxMXxXq36NDnWjzozPEnYBx2IANtUf5I7nnJGWmwYqnm5AiL2nmrjbE9dZf5?=
 =?us-ascii?Q?3w5fJPL447kVARM6Xn/Hq0OBk9FQvg0hOvjIQwK4pt2npDsjUNSl6poE99gA?=
 =?us-ascii?Q?LW5Y5FYiTUT/8kuDYu6uSVFyP5AdHe5mVpucMcWomfjNTT91qEQ0xUuAYDk0?=
 =?us-ascii?Q?XXpqlrzpgW1YEAvH2OqjI154uNfewk0bBnPxSlIGrmB8G/nRtNYZqrmMHY7c?=
 =?us-ascii?Q?n8oXOP4QoViTV0aD3qff/9z5Tghvy19rj3j8PznZ3LRL+E3Z+Z9y2j1BrknW?=
 =?us-ascii?Q?Wf8wxir9//4DhujhrEtqpV9P2hK7tG2goXJXsLGUAxhMcoEkCUA3XsAAEVof?=
 =?us-ascii?Q?/ItISKNfNW6frFbD6cCC5AFhHiS+IvOQHd3+LcyyZUCV+TbpmKVpjiuHH1SF?=
 =?us-ascii?Q?d1X7uZzdEP1XnlVxzAZbrvcb6qlaE0VTQxv10vrF+ld2+QD8GxFDsXGp/D20?=
 =?us-ascii?Q?dG0HRPBrBSSure/IUsqOYzvkGZGEy7qb+iST13H03I5QuZU/BhPmnIIn8+DZ?=
 =?us-ascii?Q?T1UzZCByqc0W4nMLvPaiMO/iOUCqRcd9T+5j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:38:19.0944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a618fd-8a66-4189-a162-08dda3863689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9636

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
eg.
-> To get command buffer dump for iommu<x> (say, iommu00)
   #cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
 drivers/iommu/amd/iommu.c           |  7 -------
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 22679ca0bc26..2cf6fd676979 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -898,6 +898,13 @@ struct dev_table_entry {
 	};
 };
 
+/*
+ * Structure defining one entry in the command buffer
+ */
+struct iommu_cmd {
+	u32 data[4];
+};
+
 /*
  * Structure to sture persistent DTE flags from IVHD
  */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 5ac12c3fe069..61fde9ebfcfa 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -106,6 +106,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
 
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
+		seq_printf(m, "%3d: %08x %08x %08x %08x\n", i, cmd->data[0],
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
@@ -124,5 +148,7 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_mmio_fops);
 		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
 				    &iommu_capability_fops);
+		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
+				    &iommu_cmdbuf_fops);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f34209b08b4c..522251f60e8e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -62,13 +62,6 @@ static const struct iommu_dirty_ops amd_dirty_ops;
 
 int amd_iommu_max_glx_val = -1;
 
-/*
- * general struct to manage commands send to an IOMMU
- */
-struct iommu_cmd {
-	u32 data[4];
-};
-
 /*
  * AMD IOMMU allows up to 2^16 different protection domains. This is a bitmap
  * to know which ones are already in use.
-- 
2.25.1

