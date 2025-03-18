Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177BFD528
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 06:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742279556; cv=fail; b=CfacMXA4h+tnG01S1/euvs0sBWABq8/sbuNeFcNLI6tV8JvOBab5o05ALV2iZFyBVj5YTwS52panXpkjH+L+T6BidBmi7rJofLyrSlSzf98CGqJZ5YLGJYAl/OhsFL1QRNW+GWq2MFOCQMdTV0T/HZeS4MLEjsTQfSduF+92/gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742279556; c=relaxed/simple;
	bh=vU28hgFnVYGFJcAY3dfxyazQT+VtddY5vobmGTrQIg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgTItxQvIBIaNIr6anYrFE38HYP6fXINEd5NMjXKgkW/QHwTwvr2FjJVZavDPZpQJnYbV0B5DS3ttDi+D9oIKUg0xPcjycmaffoJX9bAr+JRGkoBRCRziaoE71braCJZsbWOs2gPGSwlmy2KXmlGcSyO2Yvo5dn4ietxL63fzD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V5+sBr3F; arc=fail smtp.client-ip=40.107.96.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V5+sBr3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZ7bxv9fCiS0sKgGLpfipg0dRFass4qSKHBwWnA9PR45ANcUarcwZTLNIQi5q8QfqDgCcGj3P47BOoUgjnXmI83+Ef6feryoelbubQzmK7LHuaLgaVsTtzDUnDnjQboR8kGrXQaewRonpbf0c0iDx8k5Y8bgwaOCRULnwYmwm0CJR854k8EEGja0ld7v8XuEZD1Kl/YdbMP6dDE/bzs1WmD+/S59tl0ZB9JiGtnwbxeRAMnTi/I8G5CEll2MzbfT2wgE1gQ8zvAXBznb2LEIxJmspmpiAfOtsFQ+nAkRmlkNjRCwyX5H8gQmPQ3a+XBLAuhLQpMN/87qD1JAiJIYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RY/nm1edqYrytZhoBDPCRd6cF1BXkNsJ4/P7JbGqOI=;
 b=HqVn/muA5HvgbbjMXhglqdl/WFMFhjDJWUAqU7lXNsdjZy1F27dG1b0E69Fn8p7Cr7cktPwSHFlsRHuwCmmw3cBLs50bkzkiDPHXMPGOtVSUC+CIbHWOBuKiIZGGTJMcmgIKtCKc/sgo0H32JA59PpO8QyuIcw1EVc/lSOCbqi+qhakfaBTzkxkW39KeNOPp34xi1Oq0IicqqgPF8NsoJ8s/N9peudxOTt5Fcm5TZbq0AGRIsRMvFPqlCqZc0WCvsj6qwn0NCNKpfpFNNnY0l4/E1dc/ZfRtR0YvyBwhjkX1uuxnAahAg3JfJDE/ZAqu6owV+tallL0URBBjwz49Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RY/nm1edqYrytZhoBDPCRd6cF1BXkNsJ4/P7JbGqOI=;
 b=V5+sBr3Fhn0Vyqvf/6QecPhFsnlUdwfORl8x6JSqc76CGRYUesWGeU2zveLEBROK8rJ+LUfGNrtc2tApumXwesxjBlEGUfF3/9xdZPRdupvpsDV5xruOLC4nC9bU4i6gv29eS/eGEZDtehRbHDFG89fS2JBNGAAPdBjubN3r9G0=
Received: from PH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::26)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 06:32:27 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::cf) by PH0P220CA0015.outlook.office365.com
 (2603:10b6:510:d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Tue,
 18 Mar 2025 06:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 06:32:27 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Mar
 2025 01:32:24 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <vasant.hegde@amd.com>, <sarunkod@amd.com>
Subject: [PATCH v2 3/4] iommu/amd: Rename DTE_INTTABLEN* and MAX_IRQS_PER_TABLE macro
Date: Tue, 18 Mar 2025 12:01:22 +0530
Message-ID: <20250318063123.2556-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318063123.2556-1-sarunkod@amd.com>
References: <20250318063123.2556-1-sarunkod@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 635d880d-80d5-42a6-1709-08dd65e6a707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9YWOHvsoV6GTy+n/O7AY/LkOBStkM8NYQz+jwXNc0UZEjxsuQge0rM1L5k2T?=
 =?us-ascii?Q?mDxZl93luUnmzoGWmtLtEJujFe6mF+SCJh/9hImOzuQfCRjV9UJn7a86Z0uM?=
 =?us-ascii?Q?528P38istBoCUCW6UJpzQuCu2IB1XgSLfTapZGREFmtvHowPlkfGC0RpApfW?=
 =?us-ascii?Q?t/zES0MlEy/UTqaEsKxHwZeQ/kq5yvYgwlUbPHf8MP+h1fZBCBXcoaBZ3PD/?=
 =?us-ascii?Q?2kNOHS8QApIBKFQa/sQlE7671EupeUybG06Ee2cXwMXPAixafLvi+r0FyBhf?=
 =?us-ascii?Q?yQdRElBluX2xhU9LNA+XHGk4zXUz6AlAob6cel22vqHqvA8NEcwaR3VO1eCY?=
 =?us-ascii?Q?Dlg61UJORofOFa9uSoTfWr5ADTTURMKHC7tIaO2V2XomJo9rASok7EVymyQm?=
 =?us-ascii?Q?3p0Fsnn8CA7eFFcr1xApauBzOP7vCX2b1CDS1rb1CtYY9Kp5dWI1KR2bgRuP?=
 =?us-ascii?Q?kHQlwMvNPrZNlrIU9K3UMjnJDl4VXIeE+4r1QMc8ZITqagl8PYyC27fi3Qzg?=
 =?us-ascii?Q?KWGOkcE5Jtn1fXTuaZArlQneK4mpcQtspQnQZMKi1LzHnGQX4zEQX4VV1JKI?=
 =?us-ascii?Q?Ffeh7Imxwg58UhQe4YuRMpxbcqdnL9mmJ8nCpeYyJ3X4pcV8FY6GsZjTR1Oc?=
 =?us-ascii?Q?LbYSXj4NziTLffVTeYAe9hNVwhdw81+MeH22VICAj1I5/YmVnbtJDywwWkNj?=
 =?us-ascii?Q?RhPanjzCZLO0EjFckFiwCxeSgMiwaj6WZypcorChJIFLQRrSqMH8g9eU6fGN?=
 =?us-ascii?Q?v3gHEtrj6QsBHKD5Y1K5oXB5ad7u/mZa8+Q+9iM3rGpt0olgBAtr2thZ6m3a?=
 =?us-ascii?Q?ZpMPRhENmjoNrjeD81Oxq4S7COvc4qFBrkRX0ggP9T/V5/lzVnTznf2cma51?=
 =?us-ascii?Q?Nk+Qj3XjUHuXoazFPj65TIX7veYi+JGaKKZSc46N/iKFssnwa7ikh0AbrNZz?=
 =?us-ascii?Q?364As6fLrZi6TKUdxZTCPNzuwcqLa1WQM8Co0BNk061CAgO1TDdLVWuQnsBu?=
 =?us-ascii?Q?F+ag9ym9ZEWg6luP6AJZSx0b2jzIkDjXZvc5lKEB25vku+biDHGbPXCdjViF?=
 =?us-ascii?Q?0atsmYfJxc/S/70b8b/TZEWsJDc2EFhth1plQP4oh6J50Rkd9QCtVFTp9P6Z?=
 =?us-ascii?Q?+nxKwBcKxanfNqwd24mBhNTuHhtMVrvIMR0VXAeMbAIRE1el6hCAIP9GmGgZ?=
 =?us-ascii?Q?0EHMyGOLzMkF3FEZN5emGRjnsa/7/ggUPOKfnfaO5v71r6T1KmepgIyve4hf?=
 =?us-ascii?Q?R3DPb4K7EAoY6k6FBHVytTi2UAcQpH62BIRIUFp0kY6dj8JN8qb3B8zi+bLY?=
 =?us-ascii?Q?iYvF/I7Nya2qlrgpEk+zE/hvSZGq8wTT0FIMm1QkSloWnWHdblUOJZHOFIqG?=
 =?us-ascii?Q?sM2YvW5OI6Luw/IZs0+WOV/+C3s4MT1Ih+ME9U5xnEnqK++mE/+FHzJ0PdSG?=
 =?us-ascii?Q?yDuBJ17gHYSARDUtmQ6m4mkdbvxWTR/uyBZomVLrCkO3FrLKtUHcj4gouW3P?=
 =?us-ascii?Q?WOP46jKeX527NbM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 06:32:27.4215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 635d880d-80d5-42a6-1709-08dd65e6a707
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

AMD iommu can support both 512 and 2K interrupts on newer platform. Hence
add suffix "512" to the existing macros.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 +++---
 drivers/iommu/amd/init.c            | 2 +-
 drivers/iommu/amd/iommu.c           | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a1e2b8317d11..2efb47dba270 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -313,10 +313,10 @@
  * AMD IOMMU hardware only support 512 IRTEs despite
  * the architectural limitation of 2048 entries.
  */
-#define DTE_INTTABLEN_VALUE     9ULL
-#define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
 #define DTE_INTTABLEN_MASK      (0xfULL << 1)
-#define MAX_IRQS_PER_TABLE      (1 << DTE_INTTABLEN_VALUE)
+#define DTE_INTTABLEN_VALUE_512 9ULL
+#define DTE_INTTABLEN_512       (DTE_INTTABLEN_VALUE_512 << 1)
+#define MAX_IRQS_PER_TABLE_512  BIT(DTE_INTTABLEN_VALUE_512)
 
 #define PAGE_MODE_NONE    0x00
 #define PAGE_MODE_1_LEVEL 0x01
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0fbe92a0b48a..9a311c627090 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1061,7 +1061,7 @@ static bool __copy_device_table(struct amd_iommu *iommu)
 		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
 		if (irq_v && (int_ctl || int_tab_len)) {
 			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
-			    (int_tab_len != DTE_INTTABLEN)) {
+			    (int_tab_len != DTE_INTTABLEN_512)) {
 				pr_err("Wrong old irq remapping flag: %#x\n", devid);
 				memunmap(old_devtb);
 				return false;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0960b95656e6..bc06cf060f35 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3093,7 +3093,7 @@ static void set_dte_irq_entry(struct amd_iommu *iommu, u16 devid,
 	new &= ~DTE_IRQ_PHYS_ADDR_MASK;
 	new |= iommu_virt_to_phys(table->table);
 	new |= DTE_IRQ_REMAP_INTCTL;
-	new |= DTE_INTTABLEN;
+	new |= DTE_INTTABLEN_512;
 	new |= DTE_IRQ_REMAP_ENABLE;
 	WRITE_ONCE(dte->data[2], new);
 
@@ -3180,7 +3180,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
 	struct irq_remap_table *new_table = NULL;
 	struct amd_iommu_pci_seg *pci_seg;
 	unsigned long flags;
-	int order = get_order(get_irq_table_size(MAX_IRQS_PER_TABLE));
+	int order = get_order(get_irq_table_size(MAX_IRQS_PER_TABLE_512));
 	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	u16 alias;
 
@@ -3259,7 +3259,7 @@ static int alloc_irq_index(struct amd_iommu *iommu, u16 devid, int count,
 
 	/* Scan table for free entries */
 	for (index = ALIGN(table->min_index, alignment), c = 0;
-	     index < MAX_IRQS_PER_TABLE;) {
+	     index < MAX_IRQS_PER_TABLE_512;) {
 		if (!iommu->irte_ops->is_allocated(table, index)) {
 			c += 1;
 		} else {
-- 
2.34.1

