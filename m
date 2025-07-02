Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DB238171
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449179; cv=fail; b=OV8dpf2FNAHQOEQA/eyVCVp0HGj3SmqXxXf9YT/1Vn4VXb7yc5lJiwA62U0/0VgEkaURTTAgsl8dyAIohI57HLdjzAdVpgYYra2AMFsGArZmMFqPxKF/GcP2ZYDkvZyt+iPEsQYousHDOnmpZMAv760+W89hRke1tG+OFidPgqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449179; c=relaxed/simple;
	bh=20HICtSFNB/nT9MdHUqSLnWyCWqO7TStMuuS82Zn7GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvzBAsW29ooCuSDr+y/a0I71hdvjl5weY+AaBJ99/6tVYBKONghHpJMTcrLGHy2l1GNfYcOiyn4H/1CIN0H/tkpffdrdVChsDOMWR4oHaaZVVYV9ch/ZuA+P5a9PTr5clZxWMTte6bOhMUcSNNs76BIFUDRMuTI8ti9TEj9NVc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SbGrHsk2; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SbGrHsk2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgO7M3uD73cRv2IhYNYcjXnVEBwSfEzH3YLnnSTKUTwJmabutSFck3yDCZctbf4vr5UaREOrMP/UA2sRvaQUfM0Ur2auBGsD7JvMIWfx0WIyWavc7uDcQs/3V46JSmCrmDgUipQl4drB1qrjctM0mPft7NOoVJv5tYytxgDljAcvZAGAx1NWk713osX4HUj3uLZufMC7tAZ1i83VVu7M4KZ898qjU53VGz30MkiDdRr6Q+QEkK0ZucGDx25kqPXpbkUcF+jcCl9R7OZs/NMMyFhtn4kdm00G4r/UWVNxy/VwVRrT66YPI83dKnDhsOi5LetOFPXz1l0CC6tuJjuwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48zE8wo7lxVapE0nwX84rQwsG4CzDwY270U9lbaFf+w=;
 b=agEn8mEUVqTWHGJq+obq/1XOYv/zB1Vo2RLEjSswHqgOiiakN6yKNJyUlBdrHZsj/uzcJVU9aAoMNB6eYs0Fi4tvykFo1JjF+Uj7oGetM4DiI6Vg98UrLEjWmtwWWZoX2GgiSaPISzweb3hhDcun8JgwDPHMW1iUKxKpVDo4XZyWo7MfXszNSvQ/u3+ObKsHs11u4Xd1An/oAS2+jk/E7MG04Crl18snhSBZL3/tSqt+ZhXVmyLncrn6IOGk/U4Kn4yL66zQE/8BOXZan6VP3AGo1gfsXDk3c39o+e158eNT0NOkiHg9lo4eTDoBdWSbZPytZu1IEJNEt+uZvIqmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48zE8wo7lxVapE0nwX84rQwsG4CzDwY270U9lbaFf+w=;
 b=SbGrHsk29lpLRwpuy6W1Ld3TZD21xXFsE7Nmbc64w3WbvwZMH0CvqRaMdowt7skDnhM/TFtAWBs1AKDVJJdnzSogs61D0kBdYpXTH+BYTryEmuiUE6+Lelsi5vpDZ/3PxZOF6urRmr4UeOX7/KmMQK/P6L2o4JGYGVhcEkCHDI4=
Received: from CH2PR08CA0025.namprd08.prod.outlook.com (2603:10b6:610:5a::35)
 by BN5PR12MB9540.namprd12.prod.outlook.com (2603:10b6:408:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Wed, 2 Jul
 2025 09:39:32 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::3a) by CH2PR08CA0025.outlook.office365.com
 (2603:10b6:610:5a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.20 via Frontend Transport; Wed,
 2 Jul 2025 09:39:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:39:32 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:39:28 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 4/8] iommu/amd: Add debugfs support to dump IOMMU command buffer
Date: Wed, 2 Jul 2025 15:08:00 +0530
Message-ID: <20250702093804.849-5-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|BN5PR12MB9540:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c3e046-061e-41ee-9cd1-08ddb94c597d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMXnvc2qrZw7bJI5vugHPvKydtZEmubokyncaNHw8OTsnRpNi2tgWTyhbTki?=
 =?us-ascii?Q?FcnNLaRbSYnpJwNQQc3o7vlB/XoLU8fcVD+DwaIzkZ7UhI4AU5wQuXwEuiFN?=
 =?us-ascii?Q?VUK/E6x4CtMxlcdDq/H3StIlNFCG59IvSCdvBihvGzufoSY9rCWdu9CPEC7C?=
 =?us-ascii?Q?SMrS7VoeAwSDhAh0Zc5UNyxZHsYA4AdkIKQnj8ue33XLXUJ8MYgg9JmpebNW?=
 =?us-ascii?Q?dpZgd14j8RrbbAxP84wBzd9zSSo0BfBCYSuTqY2Y+MTXcNkoz1UrtkcBWrVd?=
 =?us-ascii?Q?WmmJpV96uxGvVmQIw60PfuQ5y/sdpfy9huqnkL9Un/RRYsppLie17vMX0xVl?=
 =?us-ascii?Q?tVbhmCclZF7wGMj38sLygqO+wGEBj1ZWBJS1DvDeVxBz6cBNC8hYVvFYLevC?=
 =?us-ascii?Q?PSYxUYZWLLIShUcpe9Iy71X0/4FNnDahImV3syek5VzONxaXsnw4UmsTrsLn?=
 =?us-ascii?Q?0J+Pz0xd8ZSw1pxhwdaQi4PlmC+RzmaMi3ZKX252dDJfiF1eRumbL6uPaRr/?=
 =?us-ascii?Q?f9pL5Lx3I1/u8NzBqsVkiF8pf1uE7PTPzaoZHcsB99DFEywUrCYfkqU+4Sm/?=
 =?us-ascii?Q?URRS3hILNrETI8Q+Ga6ef09tEO4XHi+4eTBbNSkeJKqrO4uuHepirRAGshz8?=
 =?us-ascii?Q?gZO1A1yiuThOBjRQZR8oktTXT5Uai0Kh1Ftvk39ZRBxwtJ7RH+gpH667vU+9?=
 =?us-ascii?Q?10IV4AXGRVj1anFKdYd6jOctYCUg5RFKUftndtmhzlYdxj2NslbEWtLzknR2?=
 =?us-ascii?Q?U4fgZmX9dnwv2JixFRtFIn5QEAsTkD/J+IIjBlFm4huOOUuOlO3GJsbGntPX?=
 =?us-ascii?Q?Sb62r9GdckcnoevGNND1x+ITFvuOtNDcd/dJXnDT/iK2HvXHn2uLxPc58gCu?=
 =?us-ascii?Q?R+8sco/EzXkY5USTXQbTq2HN+qun+1PKSwaY3EOFRpR/djQOKLLagKyXwOFY?=
 =?us-ascii?Q?7UWhg4TyzM03SVjLeniRCPMyn3bIV6yazribPLyZx2e5f0A2KaGa+1ON9CGT?=
 =?us-ascii?Q?Wwh1rlYWkfJqob636lGpq8LUBNy0ogp7XmUSnx/jHWbaEiN1AEjsw7WLn19G?=
 =?us-ascii?Q?axI3udYQaMPqeqYFaZ26EHbFN5XbnDC3J1+CfUD8UUXO9uuqqf7iFFMuvN5y?=
 =?us-ascii?Q?033xWbeHVD3Ry4Ot/AdyyoV/2mN8530KqQlM7xYVnPVIMWGlvieONziuFANR?=
 =?us-ascii?Q?glh9c3G4xtuCETd6+y+zuvuSd+RJhzs+qmiKXe6+YFVZ+SUb0m5bVuzRq2Ny?=
 =?us-ascii?Q?actJ4xD/E1SZNEZRbNQRaliQiv5UVXGjX8iCtZE2W9uFO7X/iyxW3roMDaER?=
 =?us-ascii?Q?QsVlAhUeg17+k5uhflfgNA++jWzWTvVTPHFGD/ng13X3SsX3ZwNKV7oMPOy1?=
 =?us-ascii?Q?iS1c1fgKyrKgNUZA+0H7qC5MiU9dzPRVv9LzBb7kapC6a6gRlUqn7XT4Vmdw?=
 =?us-ascii?Q?kXRTPurf/c5GfSgtBK0gfOFFJjgkxSAn1GyKV8WSPj2Keoo3Bi3uBurY7EP+?=
 =?us-ascii?Q?yWxazMalh/chPyp79FLQeK2hdQuL4RIbuIR/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:39:32.6024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c3e046-061e-41ee-9cd1-08ddb94c597d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9540

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
index 01edab37c25c..38bd765acaf9 100644
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
index f843e184a62b..e78f6b217a7b 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -107,6 +107,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
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
@@ -125,5 +149,7 @@ void amd_iommu_debugfs_setup(void)
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

