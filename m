Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA92C22370D
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286286; cv=fail; b=QPo+LPcE8JTNHZxZ3EaLACJaM1TOQX/g/BM2HDUi7A/8tnj+jX+WstL+Op040C7GNuB+f5ajYvsQa0B+YrvYji22kQd9hl2kl/ihVoNu6p0YDjm6LtvYK/4QbjRHm9F2fnBGEKv7wOejjpG6/J9xYssbtY1FTOHzuWhiDqs0HFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286286; c=relaxed/simple;
	bh=ytpUdtV4vpK9hhp+O3Vv6xz4ohXkvYGlKVcDNSqoHIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tTPuDEu1oVQcnpFdkAqC6t5vxNTI9gmqqszBX5nEmSDM1Uc2H3Asi0qt9Ss7wVTU6MO8AU8JPnAao3wDcW7Tzcb7wcojhLZ4jrGw7zPOaX0UAEKK0ZwBXQDp7VotzMdckgfNQ6ubkvtr4Mnt2Kwl7zLx05uFRRKVcRSZmFttYFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cl/DE0vm; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cl/DE0vm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1EsRLs37MF0ioQfbUXcw9RjoDt6gRolbz0lU5NI6HHIhwJ3yPq1m06kN3RE50x0k4yjLTudJrc6EhDWduoQMGiE3HwZhhLV/DSsC+WiO6JrIMgz2Wd5mZ+Qp3mC+U1KdEjiTS8brJ4e5vePTyDBFHXoRaIEkyk4hxZieySngo2KfzkwbGTO52Xwh62SeNxk6Yo+QS+NvS3TySWTuOUNnFoOt5ZiXTB0hlJHe3lpCJvtqdUkHzPYzdYWONnJqgvroLaL5UrpINk7/GOn3CF2+cADzNWLq/cXgdsK7euVcaijUw4zO8uH+1Q9EGV+re3iJ2jZGriH6ResAqXQp6+noA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkGP5cr6dq54GVjVTgSLUm28RtPeQfLy0sS3t3Le2Jw=;
 b=Xvz/LWZND5yu06b0HH3krb0BLE3Ka8hTJA0++H6FFO66f50Kd7vw/lSY28y8mOuUqHDFWsyvlmCOS5UVLs8Q46j3JPEFK7HD4wKRYqPhupKCIsdGyl+qjvD5QQXTS5cIOo5rGOoI+Z6RRzRrU75aoLMssRO3FCQz+YNBuKdWCfeB4I7KUlaJ3HUOh6FCQMUTXHSpUO62Gs+nWkKX9TqoirAk6EVjp08fwr/7a53Lvg+LnLzQp/yUF+4Iia11jRgA6gYw9qdycbachXcmZ1RSJvUGLm+52v02PggN65bYKw1XX1T6kXoHTs0hG2rI9T7LzKm6oKwvOA+NhtZrDqqgeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkGP5cr6dq54GVjVTgSLUm28RtPeQfLy0sS3t3Le2Jw=;
 b=Cl/DE0vmTTOWhyV3JzeVP4+RLBoDvHu7nU8iqSIm/5nZ3opcIEF1g2k0NAtRi9AfZNCXloKyE+NTvSzvj6c/FxNPlFEt0J/rGStLx7sQBoz9iv5TBcZVWo5yQzyi4cjTcpMcGCvLtr39pz8bPCV2DeRifWL78tR0iXzdncyuFlM=
Received: from CH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:610:32::17)
 by CH3PR12MB7547.namprd12.prod.outlook.com (2603:10b6:610:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:11:18 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::e3) by CH0PR07CA0012.outlook.office365.com
 (2603:10b6:610:32::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Fri,
 24 Oct 2025 06:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 24 Oct 2025 06:11:17 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 23 Oct
 2025 23:11:14 -0700
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v2] iommu/amd: Enhance "Completion-wait Time-out" error message
Date: Fri, 24 Oct 2025 11:40:41 +0530
Message-ID: <20251024061041.707-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH3PR12MB7547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1847124c-d16a-4ceb-705d-08de12c4251e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHnk5zc1WHqEQwchyH0mAvfc+dA4+6MMdeph/G4y0UtHKYFdLdMqWVj0pfSV?=
 =?us-ascii?Q?NClRb4a/QRQo5xwBGhrFJVyYwa3jdeTJyQP7zHlzt3N0jDZ3bXN1D+qkYcp4?=
 =?us-ascii?Q?M8nyBtfDjgd6X135H1h5jBXuz0r0P9SbNQeiArC3t4oolw4VjdCjX5JQCd1X?=
 =?us-ascii?Q?4/Em9TcVUNxiNIvVeJg/RLNliIO3LFhlPeCHSGHetvV8xCJ3tU0lIb96tTxQ?=
 =?us-ascii?Q?y6OMFjPGF4vFUU5ystk79RJWrJdN/dK9zmhkY4E4hR7dtefPNEoHIP6/NpJR?=
 =?us-ascii?Q?iUvOqiGGgKuKXcf065GuW5SK80481+tO3bM1IK45Gccd1WD/JC3wpMTpzCDY?=
 =?us-ascii?Q?TiZkpM32i4MveqSU4Z0oNpvI7cuyM85pDBC2gczjWFPCKukCLvzM+66RsEo9?=
 =?us-ascii?Q?Ya6ZQS1qrrEbMi7s46VtUbSoBbaqTlDq0YrOoQEGoSqD2pCGi//tUv41lsT5?=
 =?us-ascii?Q?QDumiSX8dINQ+XAbHg2qj+5m6cZeEG68zi1XmmKfFT/KdnrtARWGGNMWb2MK?=
 =?us-ascii?Q?Cfho3TQ0QHcriXLYEZ8xij6699WozM7OqLng1VxQf5NP1Cu9sNtMMVFWKpTC?=
 =?us-ascii?Q?mjyBY6gNz7iDf7k7RFXsHHx3gP28Y3yyUIhUBBRX2V6QltLa9KkvKS0pJrtd?=
 =?us-ascii?Q?SXZex8Lyx2s09QMr0G+2ECKfoAcG1fAkTwjMh3SLGece9CEyEowZIWC6roOm?=
 =?us-ascii?Q?oz3j1/WNMvQwHqvjIRNPBh0pryznfW0aEVjVrinrDUgltjJ1BizDo7/4Td6F?=
 =?us-ascii?Q?VoXIOgwFAbJiyM0dJfK7vAvH8kYw/nHyf+vYEjmBZluogv955fLgJK+z+DUB?=
 =?us-ascii?Q?faQsX0QWOkSy/h3z940P3yxAF2A56cS8bB5AWt2P+oO4AOWInMSzzMRGXa52?=
 =?us-ascii?Q?SB/rr7FYL4q6yu2es8GJoyIFbLP2KkhQDhywDaiB8uKjJ1+tDYXNlNgLh7WC?=
 =?us-ascii?Q?F8acd292egRTihWIOKoHvWZsvnMBgWosbtCmsuRQtRytLa3OUiPLIIsvGhJ1?=
 =?us-ascii?Q?L5XIN95daUnyVxVG2gSLgqmBtzg4IHYSpRN4FbleByibcEK6gn01YKp3T34g?=
 =?us-ascii?Q?kHQg+n8uJDuQMQsMpKluAWrGk9GTUfOMuypUGcuAeQIl8qRF+qmAiEQa327b?=
 =?us-ascii?Q?uKkz8JhB2InI2csXGNjMcifuExWiyHPC/F6KBJZbqChUJng72Zvz4/31JPhf?=
 =?us-ascii?Q?31Xz+xSnB7Fnp3VUuUFfm8DCz9iiz7Qk8g5tz1/La6DmoVsuzOzPOjkRCAwO?=
 =?us-ascii?Q?QiTXN8ZtSWsbZJ7+GnLOW4/uilvmTrdPGzPo+lEMVLSUgtmcO+GBRoRHvPGo?=
 =?us-ascii?Q?IS0yjWQndL7tNSZWtN7vYXmrE/LqAkhf7zwHC9/CHLpnZliu3EvIKJbwQlAZ?=
 =?us-ascii?Q?NoPi8/PNIFPHRV8PQ2CM5hB2TgJ39ClhAQii8uHmN603XWqKvpZWCp6drok5?=
 =?us-ascii?Q?SdWn8ZPCUeaRPyriYTMn1TKZFKrvqo9FPK9eM2riMtJsgSzZWfYB58/lTQ3m?=
 =?us-ascii?Q?jcYU86s9isbV32pzGAdPjp7bJ6R4h4sT2crBbPT19He4G7oaDgRUpoYiApKu?=
 =?us-ascii?Q?E0Exor0pFEzFDPz3HSo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:11:17.8091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1847124c-d16a-4ceb-705d-08de12c4251e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7547

Current IOMMU driver prints "Completion-wait Time-out" error message with
insufficient information to further debug the issue.

Enhancing the error message as following:
1. Log IOMMU PCI device ID in the error message.
2. Also dump the command immediately preceding the COMPLETION_WAIT
   command to identify what the IOMMU is waiting for.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
Changes since v1:
-> Remove the code that dumps the entire command buffer on each
   completion wait timeout when amd_iommu_dump=1. [Suravee and Vasant]

 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/iommu.c           | 18 +++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 95f63c5f6159..d495e5e4a9a2 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -247,6 +247,8 @@
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
+#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)
+#define MMIO_CMD_BUFFER_TAIL(x)	FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..89f7f6b01cad 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1158,6 +1158,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
 
 static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
+	struct iommu_cmd *cmd;
 	int i = 0;
 
 	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
@@ -1166,7 +1167,22 @@ static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 	}
 
 	if (i == LOOP_TIMEOUT) {
-		pr_alert("Completion-Wait loop timed out\n");
+		int head, tail;
+
+		head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+		tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+
+		pr_alert("IOMMU %04x:%02x:%02x.%01x: Completion-Wait loop timed out\n",
+			 iommu->pci_seg->id, PCI_BUS_NUM(iommu->devid),
+			 PCI_SLOT(iommu->devid), PCI_FUNC(iommu->devid));
+		/*
+		 * On command buffer completion timeout, step back by 2 commands
+		 * to locate the actual command that is causing the issue.
+		 */
+		tail = (MMIO_CMD_BUFFER_TAIL(tail) - 2) & (CMD_BUFFER_ENTRIES - 1);
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + tail * sizeof(*cmd));
+		dump_command(iommu_virt_to_phys(cmd));
+
 		return -EIO;
 	}
 
-- 
2.25.1

