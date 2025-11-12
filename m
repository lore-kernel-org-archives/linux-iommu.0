Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB32DCBF7
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762982062; cv=fail; b=G6VBjhylI0dsuCg9foJN+SfA+pJTlzuCqonk3QU75UICMC7B3d0xUqiMDuJtEBpIKY1ifAxxAh2P5VvJRZs8e7WaeQ5tbhIlE0wkKZL1ZMSsswTZZIWHa/cXYGoZ27wZheAOV97MWNwFQisanSWuBaL8B8Z1wawTxl8D4hWGZyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762982062; c=relaxed/simple;
	bh=sdYzJ8YLtMFJFMrLaZQaL7fnGkmDwpGluwf5JiaSD3o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpenpWSWB4jM15DEsIdAOSwsz3fBMs7O1NCvaPOt1793JvPmkphUjAIfzW9KD7DXyvwoUFGmjnP8S6V1/h3wmwI9eiYCHx3DtPwTTnP364PZH8ThwsdXH5jHsBbGYOsKoDcAmS1TW53RnsgX/aJbNYQmRSs5PjIwErv0S5i34f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qNL/slCP; arc=fail smtp.client-ip=52.101.46.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qNL/slCP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmeml/MPrWqVzFQMCU+I+/QiVneW0Whp4RamcBI78py3CJVbheJDv6S5Tlc0X2CKgyRc3lHTAxfdC9AwCKgmMArHCBQ8udCH5fh/ByYtR96ZJb5R/xK2LX2bePBpNk5VX4q9h5wWsXDEsfIeWwUzQlRNPPZKOl4EjsKTwJGrRcGYndu/uY0A2DHEbJWkeNWJeyDvOxDHMkK9xMgSvm0Krg2f/l3/QfxJdiBkZdLLZexZ86Ho+Fw618LDG2Fk7y34LehoYGlCtqRejfOsq7pLD96fJHDmQ5sPQZJt9uL3rPedJ7UG/u7M11zB2Mpiyfks8wFI+B1t/CHi8X27oIa+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28gKj/7c0YNaNX2BY3OWEkWUjuJccSOUyAahqOymQlw=;
 b=w1qbrUWcuHRehK/TAmxg03yQ06f1IEtwwTkXfZu0teq4rbrwQhO/66ypZhnEpwz7ShEygwBeR2+mj7j4QcUMQNr+jngBo0DoQcNHXjlHgp1TZudH+ZNUw7cK6PxHieUYvyfhrb2EFqIU3lHDblUtTRKk32g9UbkrdNa9JEp+F+/Qnk2zmmT9TqXDqQnbAYpDqZlYhj43srMy234G14E+MYjGvkzNGKHKHbmOGfaZ0I4Nr92Qtowj7hMRcW3zXzv3Wppw5/MeXHsTHbPOKvN6c9Ag1QusgbWOFe6lKzRLlq/Kp9XG/tUHLOh/sojVGs7yqlB35WqPMZLjDXFoc3y28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28gKj/7c0YNaNX2BY3OWEkWUjuJccSOUyAahqOymQlw=;
 b=qNL/slCPWlJ64chWK+1DTGg0eHamWh6Z3Nqp2Q8MCV3p2SD/wJy6Rvv26Ba6ij58RALrNIGaEQfqwRaFwXuzMw44zfQJtSrgjfnlgk+rVfCYixgRPQHiMd6LRyGNMGPDPMl+XVaurcfFeXYd/hL1b8irvZ9tFy3QTt0ysyRi5zw=
Received: from SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::11)
 by IA0PR12MB8327.namprd12.prod.outlook.com (2603:10b6:208:40e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 21:14:11 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::16) by SA1P222CA0165.outlook.office365.com
 (2603:10b6:806:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 21:14:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 21:14:10 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 13:14:06 -0800
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <suravee.suthikulpanit@amd.com>, <Vasant.Hegde@amd.com>,
	<Santosh.Shukla@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH v5] iommu/amd: Enhance "Completion-wait Time-out" error message
Date: Thu, 13 Nov 2025 02:43:50 +0530
Message-ID: <20251112211350.894-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|IA0PR12MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 488d8f33-425a-4285-211c-08de22306c7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DKhtE9G+KIqiD8CgaVNJSQj9iLSHh3JpANwjI1rMak6qnlTvVBPm555ELsj6?=
 =?us-ascii?Q?0l4r+lLHwxDaQFcuTbJ6nGbXj7VxJVyrP6RM0eEbcyeQcrazntWXmQeB+ZMz?=
 =?us-ascii?Q?pVwwelu4C8BgPMLBB8oMu7jouUTZd5Z2z6LvyU2G6kd0UnJlOULCrnE+JfHT?=
 =?us-ascii?Q?hxSa4EAFLelZWPuP60jDPNsnzX+Um+LM3bGGVgsJRCtutqsjy7QjPsoiCzUE?=
 =?us-ascii?Q?sMd0rH9fpUjoQXbP5jPIE3uGMSuU87/FfjWdj9nXKidDNAhujqNeR3RRomgv?=
 =?us-ascii?Q?uAOhJOmVfdsquD80q0RmjNMuZwHtvuJ9DfRUvV2uzRGj6fuuVDwRwMN/JDBC?=
 =?us-ascii?Q?7pQs7V4fn/cDFzHFZ1q6tO9V6eLEQ67RhBfAb+IIEeY607MEQLLolZOCMaJf?=
 =?us-ascii?Q?Gb2BTztdJL9mbAU0n+jszzt6jZKnxFPhLWmvvnJmx0BcVhosHCa2P97/DKp3?=
 =?us-ascii?Q?2/kfIVc9ggArvY0n3TKXxylG3fC/4Y3RjtE422TKsQ4gxeIjfY4n2Lwlu8Ff?=
 =?us-ascii?Q?+D/sLhyb4cIzEhSmdnFj4IUC0r2B+mTVVHSPZ9485/N+F3OkWedcd718jNIi?=
 =?us-ascii?Q?QDJa14fbXol73A5pLeES2MA/9Y02yo6SlRrQdoqKUjvcsYr4CKbSOLTPh4/M?=
 =?us-ascii?Q?L3V1XIJdArhtZAmyO7F/vkRn2t++GgQpzbhs9SEFjd4nx1mVmfYjUwWvED8f?=
 =?us-ascii?Q?KZ1GNV1cDUwX8cgscnOyhZ2eTb2zbsXkyoTQRjJhGFTkaU75dQ4Vj/4WSGsv?=
 =?us-ascii?Q?lqYxbi9RURug6nAapLxNHMKmbCNgQ7jXcd5zbBSci2+7qC/EmMKSitk2gw3t?=
 =?us-ascii?Q?IWjRFA62UCZ6PO7FrEE/llURPugG9GblUNP8AfwnrrRYf/mLd2Efl/TCR1u7?=
 =?us-ascii?Q?J08aTjIdYPqWdaXqKLzSHkCAZaDHcwmupEBaupsxTtnUP9ExMUXbcpZY1FRy?=
 =?us-ascii?Q?JJKr7ABZ8M5EfPpVTXjK0WSbEfY9b2QFIjS9YG3SMLJ+2mowaidsHtQgu6Ff?=
 =?us-ascii?Q?TmCUrus6pyTWn00CZXzLhpOxQNT9yxhk7Cmy/ljfpBRcX5DrKSfLk3EReLjt?=
 =?us-ascii?Q?9pOD5nnlShUhvfEJtD7QQKjEhiiu+lPs+F+X9Km9hEQ+YEFlh8ArLu4Hue+y?=
 =?us-ascii?Q?vHRMc7bLQfcO1DrmhEoeRALrpabpLi8ckgQs8BjikRHx4QpO6a84n2jrE+9u?=
 =?us-ascii?Q?cIVpo4Zu2DAh9gwosoRE0wuX9jY+Du/+OeGnQ21wa+to4iF8wRbnrju0CsiH?=
 =?us-ascii?Q?hUXRmJs+ReV4m0PBfpj/DwtLFktz3bcofL5q9CGoMZIzriJyFRN06s585tQQ?=
 =?us-ascii?Q?Bcx/atCjzpkPCdpnj2ZNxzVZb/7IEOPwo8K+bbLbPPvCGaUjJ9hVddEosfjk?=
 =?us-ascii?Q?2qSCyoVtZzbhbSLKSNRtJ0UIytrer0bohuJ7hAlRYBd6wwsfc87yfhbQmtBg?=
 =?us-ascii?Q?dCr7vo7N6KfH6rcUd17hi1xPk/c03PDo38qpt8e0bhZYPsaFL7XAKEMSY2rf?=
 =?us-ascii?Q?MnHvG2QgX0V64vG1YQkwaGAFqRd6aLLizkCn+YuOdiz9AYLvelEJxFvi3Wlq?=
 =?us-ascii?Q?YiFW1AjNCtKNUgikIRI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 21:14:10.6515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 488d8f33-425a-4285-211c-08de22306c7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8327

Current IOMMU driver prints "Completion-wait Time-out" error message with
insufficient information to further debug the issue.

Enhancing the error message as following:
1. Log IOMMU PCI device ID in the error message.
2. With "amd_iommu_dump=1" kernel command line option, dump entire
   command buffer entries including Head and Tail offset.

Dump the entire command buffer only on the first 'Completion-wait Time-out'
to avoid dmesg spam.

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
Changes since v4:
-> Changed head and tail variables from int to u32 in dump_command_buffer()
   to match readl() return type and updated pr_err() format specifiers from
   %d to %u accordingly for head and tail. (Ankit)

Changes since v3:
-> Dump the entire command buffer only on the first 'Completion-wait Time-out'
   when amd_iommu_dump=1, instead of dumping it on every occurrence.

 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/iommu.c           | 28 +++++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 95f63c5f6159..c20798fc644d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -247,6 +247,10 @@
 #define CMD_BUFFER_ENTRIES 512
 #define MMIO_CMD_SIZE_SHIFT 56
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
+#define MMIO_CMD_HEAD_MASK	GENMASK_ULL(18, 4)	/* Command buffer head ptr field [18:4] */
+#define MMIO_CMD_BUFFER_HEAD(x) FIELD_GET(MMIO_CMD_HEAD_MASK, (x))
+#define MMIO_CMD_TAIL_MASK	GENMASK_ULL(18, 4)	/* Command buffer tail ptr field [18:4] */
+#define MMIO_CMD_BUFFER_TAIL(x) FIELD_GET(MMIO_CMD_TAIL_MASK, (x))
 
 /* constants for event buffer handling */
 #define EVT_BUFFER_SIZE		8192 /* 512 entries */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eb348c63a8d0..c68b0fdc5433 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1156,6 +1156,25 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
  *
  ****************************************************************************/
 
+static void dump_command_buffer(struct amd_iommu *iommu)
+{
+	struct iommu_cmd *cmd;
+	u32 head, tail;
+	int i;
+
+	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
+	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
+
+	pr_err("CMD Buffer head=%llu tail=%llu\n", MMIO_CMD_BUFFER_HEAD(head),
+	       MMIO_CMD_BUFFER_TAIL(tail));
+
+	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
+		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
+		pr_err("%3d: %08x %08x %08x %08x\n", i, cmd->data[0], cmd->data[1], cmd->data[2],
+		       cmd->data[3]);
+	}
+}
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

