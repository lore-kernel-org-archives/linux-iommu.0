Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091982550A4
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 08:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329852; cv=fail; b=m84WORxH8nI9t1LVpYw4+HT4fhf2aUKbRTucxABVzSAf3HqA2yDEj7j/xhWTNaHxtsOXqR4QMMuyyFl37S1Fd+LUYde2nb3yaP6ZSuFwy2oiwAneyjfsxhD5ySJZQnHZtjMYGah5so7ua6suCPbj3syusPu1k1lVPuIoAz9UD7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329852; c=relaxed/simple;
	bh=g4JZY5eg/zvMp2jFdCQXBpdTEeTy4ytYIrc/ajXH9Os=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O/TzyKrff8LOBNqx7eQispMhWrhPTJfS8KEjnEPWlLQnsArcDTrrwr7JzhL0+QTH9ogXy3Q76Nmywllb9kwMXHb2M8cq67ceJ52Itfb+bGnJ8SNtoanGtLPURHKigEI2DVVCGnFRLS6x522WFuJ4okZIt/UuuHq5RmJDBZiPnz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wUpCQN3Q; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wUpCQN3Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRxHgkrtiNMBDXgBCDkMVq7ff0mZ9gY/nTE7d5/63cIb0cQGN0X23UdSHpffUgB5tOrm8KAhYU9GflIBD4D2VVhDNu1TAbtvFAphBYQr4+MKBC1g2i+4iN+d6BpNGwQ5tbS/PxWKsxJcs+WjcgM5u7hME2JQ6KFgspXR1Swif22qWm3+k3YhkpMmpsccpK2pHZRhLSz1QAt7XghZ9EcSlOak93kX5SrVZXxuyuCXbLAwGbIEOauAGyJv/zgSFz8Xe4f1MkvC5RRPGCCfvAJggeVvnQroOdFrwrp5hh5rYcAno/M3aP0hfX4Cu1Et0ryGYitN1bbXHAGq9We9pqAZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Sh4F5Vzmw3mN8KNMNVIvMABRMbI5kip2QjltPI3iiQ=;
 b=h2oW53APc3Lp42OVBdbdUkJpCEj9wDGx9OasA1vFHcIgyTFG0jME2wXEqu15O16ErfGFhD6XUzFtp6jMnRDXo/+y/mMNVRUh8dbYLlPaNalCMIZROljchv4lHMQDjA58TiUNlHjpTUS1rxfpBBTiSAJbpRjxqGrUzWQQE3SzbphfVo6CKxGtINuv5gngBOjrvNuPHfl1SiMg+GL+UhFHl1d5M8WSfwYRNu/G4uKDIRQoLuy5iepgGz3eFMGAnpweVVvAHywcTNVkIIcKV6hSVDjNncxR1BmIdsOjKrFyhkcB06cvhGmvUpBzOdHMfgKmgwbHPj/MTBarvHxAScaGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Sh4F5Vzmw3mN8KNMNVIvMABRMbI5kip2QjltPI3iiQ=;
 b=wUpCQN3QED0bzFxfhQ4ySIhaT41d8Inr9duswUPjdHyjU6D5iNl3Hj1a68uBJos/W/jWfwWoU88LwN+P3Tj2EL6ljemfoNaJHC5LkE/uBBYXTEwth9+o9bY+o9QV0QVBo+bbfM1wMGoL4L5uRg0XqkRg9vKTKvwKmxy1SwSyDic=
Received: from BL0PR1501CA0035.namprd15.prod.outlook.com
 (2603:10b6:207:17::48) by DS0PR12MB7875.namprd12.prod.outlook.com
 (2603:10b6:8:14d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 08:04:03 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:207:17:cafe::f4) by BL0PR1501CA0035.outlook.office365.com
 (2603:10b6:207:17::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 08:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:04:02 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 5 Nov
 2025 00:03:59 -0800
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4] iommu/amd: Enhance "Completion-wait Time-out" error message
Date: Wed, 5 Nov 2025 13:33:42 +0530
Message-ID: <20251105080342.820-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: 52374e68-a65d-4bfc-73d1-08de1c41e256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dH1u7LHcSoB7eehyJlHS4PahXoDDMiveeACrOj4fefkoQLf/ryHuqKIYDjYA?=
 =?us-ascii?Q?Mt3J40/Hp1a85Td0O56gvnuZ2Sq0DiRkXjPaq/I+0mv1v5rEdsOFfmL3KJng?=
 =?us-ascii?Q?fmWfA/dzGYMXpzzEMudaZ0sIzlADqKLurWeapGFdhVCO2sTRm4JVE39cHFaB?=
 =?us-ascii?Q?/Ch7qKZhwlwHr9sxyCeFzb03pypg8bl7Dg29oE/CMDPs9pjc+qzGPbjFx5Xh?=
 =?us-ascii?Q?jxrkyNCwAnuOksnAznw7kIFJcp468zLSUT6HAuyorc2NYmEsLoRPe1WHW7Ll?=
 =?us-ascii?Q?C2J2qOfTnb1kVkzWIgo3uvwzl7V3fqKsoWYbvTOBpBK3AJL2nq25Q4l4m7Ui?=
 =?us-ascii?Q?CKWPrqnLZ89rnTQ8Sx4sEQ2RXFsrB1PxsLO61E1tSmwEA0q8mpW6QwbsgpwS?=
 =?us-ascii?Q?JjKr5QJ7C0slEDtegO/OhFvYjxyIjjLpVjYRKtAi+bsEtgFMx2b0tEOzHBoY?=
 =?us-ascii?Q?tlCE7cY8ig28RujP8FxeC6WE5ndD/lUgbvfsBrDniAiSwPIl9L0eurPvkClM?=
 =?us-ascii?Q?6fjmZIV7lpmyjxvx7DnGT06TeINcDbsPdJ0qvJYlwdcKywlBMVMzQm76RA0e?=
 =?us-ascii?Q?vqUfGzQgX3fzoyekV4aaHAx78y80fC1ms0h4eM61cSbU9GDnVIXTUAsteTu2?=
 =?us-ascii?Q?IMscii+U4KQJeFuBPCp2DzummGUZZhbKS90eZa2t/9kmouT4PwS6sttqTPx4?=
 =?us-ascii?Q?PU8neFTbqvhJvyuk52+BejKJCLIWQd+GCq9BU0SV8l6dXfRBOnKy6JveDS0C?=
 =?us-ascii?Q?FAx87hwsVR67kgGzh7kpxbPkStpTF365vZhEZ1cWVPZJezzzBnxuW9c92zlF?=
 =?us-ascii?Q?6HySPlEkLhcvjzDC+N+sWJLcCjGjtuzccGShF5zG8OI4Rgaa4PXWTJoGEJup?=
 =?us-ascii?Q?XePTgtVpRYRpeAfCj9ur5A7sT8DfZKytAysp6YOxTdfNMI/jFO58D9Z1LSNq?=
 =?us-ascii?Q?p7enTWpIv5qVik6GPB14p87WLLO56EOAovQtMGEX678bZYfyjM22kj18MBEH?=
 =?us-ascii?Q?5mSezvUgGh6jc7d94iSzYxvn0laa5kRmQOGn/j2Hyvec1od5QAps4XUUeejZ?=
 =?us-ascii?Q?pX7WWSZU+qeSYL55DunxtUUy6bOPcHLrE3KLFnF6l7OqmaPr5zP7x7VqKruk?=
 =?us-ascii?Q?33AGlzRmhyyC1DmQcKsFKk3drSmCCwufqbZXCSPvi65bok5NGOdZ0yoq+yBu?=
 =?us-ascii?Q?uOJYkg3CDM6uI3LVm5di3Rfw07+tPwkXvGTXB8kKLtwatlI3MELGrB/73Fgk?=
 =?us-ascii?Q?KxxAUYiz4At807Af7A7JgsMlAgaCArvo1sTOqJzvXwEskuCZugz8+VLaROim?=
 =?us-ascii?Q?0eYCtxMIlGM7mrds5Yj3CXVEEJc2uVQoIQP6/q2Npi1cwPv6Nb0JQKQ2PyZ2?=
 =?us-ascii?Q?t/2I3aASrzn2exZ1Zmd/k+rlAOeRLxxMBt2aDLOJaQKC7ASi6zHN/bs0PIoq?=
 =?us-ascii?Q?pz0DTD9oj/j7B8awLcG4qrQ7DcvlmdiuP4Jlq8z7nCOFT1ziM3AKG/pSSQP3?=
 =?us-ascii?Q?izna2zjlxgP99mFF6pYy6C/ZkIL5kN/kgq4DzH2tACXawKrNjU+RmdcfTy3B?=
 =?us-ascii?Q?kKkCcr81gquLhB5Wxyg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:04:02.8512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52374e68-a65d-4bfc-73d1-08de1c41e256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7875

Current IOMMU driver prints "Completion-wait Time-out" error message with
insufficient information to further debug the issue.

Enhancing the error message as following:
1. Log IOMMU PCI device ID in the error message.
2. With "amd_iommu_dump=1" kernel command line option, dump entire
   command buffer entries including Head and Tail offset.

Dump the entire command buffer only on the first 'Completion-wait Time-out'
to avoid dmesg spam.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
Changes since v3:
-> Dump the entire command buffer only on the first 'Completion-wait Time-out'
   when amd_iommu_dump=1, instead of dumping it on every occurrence.

 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/iommu.c           | 28 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 95f63c5f6159..7576814f944d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -247,6 +247,10 @@
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
+#define MMIO_CMD_HEAD_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_HEAD(x) FIELD_GET(MMIO_CMD_HEAD_MASK, (x))
+#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..abce078d2323 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1156,6 +1156,25 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
  *
  ****************************************************************************/
 
+static void dump_command_buffer(struct amd_iommu *iommu)
+{
+	struct iommu_cmd *cmd;
+	int head, tail, i;
+
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+
+	pr_err("CMD Buffer head=%d tail=%d\n", (int)(MMIO_CMD_BUFFER_HEAD(head)),
+	       (int)(MMIO_CMD_BUFFER_TAIL(tail)));
+
+	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
+		pr_err("%3d: %08x %08x %08x %08x\n", i, cmd->data[0], cmd->data[1], cmd->data[2],
+		       cmd->data[3]);
+	}
+}
+
+
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
@@ -1166,7 +1185,14 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("Completion-Wait loop timed out\n");
+
+		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
+
+		if (amd_iommu_dump)
+			DO_ONCE_LITE(dump_command_buffer, iommu);
+
 		return -EIO;
 	}
 
-- 
2.25.1

