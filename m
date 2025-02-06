Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2DF1FC0EC
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821707; cv=fail; b=VLcjgSD3vAHaUaqfbfsVRdyP49HKJvMDpP4bNu1cZIjWoVSQ6FdIKDxb/29LPRHOO7FC9iQSeg9KwFIPkadHOVGp7L0UW9eat/hBjgpK9SWBfUz685G4kDEdw4pFph3iMvYRa61AbcJA8E3mN40wzb3zwQoQ5Z2TAmowCszgkJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821707; c=relaxed/simple;
	bh=+2Oj2WljxARDcqaHJDTFo8k8KG2o7dWwnGu+UHLRFds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DqzINlGzvH1nqsjxmYv0ShYdudluFjx7uO32GAtbi6HdbmhL2octug7h+qCk88iVr7c3oEqZuArW1UwrZtFO5J3CturqIY6K3wVGwsDb1+8C9oHO7Mb2fQQKxA3fdFFr49l0Y1j0T19M5dRj0tQKi8QFCW9HGaqt09tx53YehSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SOecljlX; arc=fail smtp.client-ip=40.107.96.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SOecljlX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTGzFUeNPWItCiLZtgIHnkMfrOeM0ssft94oEnYNv+Da/j2qGgujcr1s8t4uPjQnJos4YSwLwC3kHV3NGWOTPu+SpZVWPSufaGEQB/HH505vFLPImdEYyjcgvPjnHoIz7RQXrvnM6w3PujxIFY90xPBsZNUAg8MKl1+XB3em+qU/zFr+ToAllTHNGOOxL7AijisPdqMfo6OpgRgEd1LpDzSeTAYKRclHrexdwPhwpnONOEs6/rzgD9QbC8L96Yl2+XfmiZ6qBJLe653sVfZ/0QH7pw2Us03ozIXkSkJHAE6vtXoCUQhu/rvz+lgDNeqeklr4VG+bRqQvYuhJXX246Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lE21/pFsffd/cBb9sIsdD8AMiQRvePlEj6ZfYzaiBp4=;
 b=Kh4MvlKzpMxZYt8daqOnmNH2EpCelv48iwwiuyR1/uTTma7Lg/vFA8R7jUK2+lK5NUww8gu+Sp49Za2jGUvpBVocmmX9GZrRpxYP/KTIQChAN3lUgQq8c85Np38DvhloJNjycgZuZszrHZilvMo29v2nBRXimjUs492JfAKrSAxiXO8uTZo5y0VZGRpvWDqf+6dJpenzEUjAmAF4iuR6+mAUey12tiQq5ZVePMEkGeyaGGJfH+bQh000MxJOz+WK9/fb7MWNZ9K4QQhEH3/T0Zbprmo+Xf0LmfPf+u5qKGWdX5AhfJAS19QxALUmPsOTIIF5n87frJxBtgHrPXgUag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE21/pFsffd/cBb9sIsdD8AMiQRvePlEj6ZfYzaiBp4=;
 b=SOecljlXb2u9xBHwq0VsMes7mTVE1qLwOak3or0AMLPWAzvbK2n/b+9KXYtzp2TmP0R+v3Bl0/6Ikm33qH9dK/moNWSoNvaT843dXBxl7340aef82efrWDn5phe+fEO56FLsFMGrOZLTRhtRrgqwnvr02meqaU4aAheJnyexfR4=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by SJ2PR12MB7846.namprd12.prod.outlook.com (2603:10b6:a03:4c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 06:01:36 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::ef) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 06:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:01:36 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:01:32 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Thu, 6 Feb 2025 11:29:59 +0530
Message-ID: <20250206060003.685-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|SJ2PR12MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3af595-7eaa-4fa1-0465-08dd4673b70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x258MOgmZhdbxZMVaHDRO24+Nisvk8zJuG/KGIYOrACn1bB7LfMuEDMhxqIi?=
 =?us-ascii?Q?5mx/7lEWotnxa5Ue2x6d9Ov3+hTVtiyi6zOJ+fdJ487OzjNnzg9M93uHNtGw?=
 =?us-ascii?Q?QcKVDblerai6vNK77KEuvierkB4uwhRfDq7j29UzwUGxihgVQCBDUE4kBmBi?=
 =?us-ascii?Q?aVItuNM/3DkyknTR7xeNv9I28Mz4C9owBgB8QUKyKIhRO7yl/YGBew2GhTvq?=
 =?us-ascii?Q?IqN6xF96XAxNBUpDkHuy+SDGoiBGBV5QAhkKp2OscwzF97/MqXLgEYXXkXwH?=
 =?us-ascii?Q?GfITzW3TSAAg8qG3s/R/yjuXgkD7gC6iBZZnGl8bsQRmWGTRF7R+L6tMtxuK?=
 =?us-ascii?Q?bQXcUocEXA9zkCSGLWewUv/EQr5L1npGbDGryeXOuRmh/XuG8N8cs/DyRiGb?=
 =?us-ascii?Q?AADRXds3I8Vy82oq7DPuJrw8gF9rCuAxOjVGcEgHw0O9zvO5RR/vUZ69A3JK?=
 =?us-ascii?Q?oUXIVSdiTnf0AFfAR5A+IbjZ9cznyzKhIqxBKDHEt5X6rDsCev2KDseZPWK0?=
 =?us-ascii?Q?wPBs67mie+vcGWfBsW5uIUhlLDEUXLpK3ohuBSsCWB2u2R3xCNEBJccf3Ji8?=
 =?us-ascii?Q?VKO5bntpXmdF4QJ4/XAlZBV8nDmwV96plWAHiyC2AHBFWZL8OYuUwmAUyThM?=
 =?us-ascii?Q?ujE4Ul5QROcwCMQbsz4TohEFmFhQgsxb+1HFarPbAP6PY/9/Jag/oeeeWIfJ?=
 =?us-ascii?Q?X1wAJw1wso35BUanl0fhmpp6qwCFslNcqu4Ss5D6Oh7USvuQsgOs6L2WGwlX?=
 =?us-ascii?Q?o5jfCTf0r11L7+jfzQBkr83QJwit1YucE8k4VjXEadNxsnXNp0koFnqGAGUW?=
 =?us-ascii?Q?sepRTC1rlXb1zqnsTgdOmWiDCuP4wiQM0uWmfFtagw9NC7y4oJbdLIVHaFnC?=
 =?us-ascii?Q?cuNTroyVdtwkUcXmptaw0SV1tlArT7rBGr/C0rOSFN0Efx9aP1mUcgZWOcPT?=
 =?us-ascii?Q?UY6GEoUuL0mfi3w0LwA5Sn8s6jn6iRwBcvNojhXgkof1zFlcQLGQhgsa1Xs5?=
 =?us-ascii?Q?rs41xfWqVtWWtnJ/e6k4JGxMFMkKpk/XFSyGvkPjs0AftzlxgTFXvtUohCeW?=
 =?us-ascii?Q?AJjUl5gxlkrFB5sUdn/CeK3KcBTzxpFy8bGpB6FTP/1LFkTA/28YerRTkBlQ?=
 =?us-ascii?Q?r8cP6MRlms9w4NI0W29jw/5l+JI5185yVPvE85tPacwZwTYYzHnyqgKyBhED?=
 =?us-ascii?Q?P9ZWPFrMwmpSAISe6sY37qKwhpk29Q1Jbz8F5MHhRiplgzzxHD00NUywjT0d?=
 =?us-ascii?Q?CrYZDBOvrwbgAT1X309E7uJCsfaWhZSjecmwdnziWb90J7YETW8xvXeamK03?=
 =?us-ascii?Q?2zqsIIvahtCRw+5nZv8KWfY9/WAk/xv6eV0FDJSttt4nF6XFHLYIs/cK1SUX?=
 =?us-ascii?Q?t0LZTHg/LZ9KB0hIebLbawjQWOZ44JL7zE8Ba2ePnoeLw1oYCbg978Xs16k6?=
 =?us-ascii?Q?hNr4SdD2lB0ipDjqoaIs4zxfwV3cY8k7F3jWNmA+uNKd80gTjPskwiFMDDgI?=
 =?us-ascii?Q?+Yux9pMeu1uSaB4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:01:36.1833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3af595-7eaa-4fa1-0465-08dd4673b70b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7846

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
index 0bbda60d3cdc..c4ca6d9c6b51 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -892,6 +892,13 @@ struct dev_table_entry {
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
index dc5fdc905754..bf718e7258c5 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -103,6 +103,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
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
@@ -118,5 +142,7 @@ void amd_iommu_debugfs_setup(void)
 				    &iommu_mmio_fops);
 		debugfs_create_file("capability", 0644, iommu->debugfs, iommu,
 				    &iommu_capability_fops);
+		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
+				    &iommu_cmdbuf_fops);
 	}
 }
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b48a72bd7b23..b23fabea0e8a 100644
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

