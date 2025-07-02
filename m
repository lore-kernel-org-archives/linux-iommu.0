Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCE24A04D
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449231; cv=fail; b=gZMsPDeuqSMnLtbnqOHegvm58FjwoWNCqBjvMoZ2sCkeRlNy5Zput3RHM/ytf1UPKIajTyBqwJbx766eXPHcTBHiqRreOnxmV1/x2DSJt5oPopGbhtxrg3vaEv18MPSLyaRyBLZs/TxbsBpwGBfAumndOvDGBSn9GijlH61vEbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449231; c=relaxed/simple;
	bh=trT0wySx3c9Gz6vcjfnYRjScU7CBv3ZgPw8CR4Cy75M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FX80vl9kOS4nSkdQ9acXj2jQZ+5KF3QK8GYLKJfw/bJPTv0V/V6FgXewcsd/Z1OH0Y472q0sOv+IMULmOch/0vdl5YowC8++cQ2XEHJ76DDzl7YrDTrPH/961JHO/xgATPeLOf91cSsAe09//KRNADvPsIB2C5xYfrilqkjhsms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mWQ2RP0g; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mWQ2RP0g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtn0/timyvXvSDdPaSmDUYVQXesonvxKHE+RvEvJq2ZaEZtTxhp3UKMebo76fkanN2z9f4nYtSTD73GWTT1hQcQMQh9yoide/zTlh0LGuC3fleZlDZuufqSxnjT85SrBDWZgrZofW/34XqpYov3Rfq3djsltoc8z4bUhwk+XGvxelln3RIZFxU239gd4fM0nU/baA/qxLA6T0gji5B4sd7y/PFZe5xRUgFmdu4JUa05ryCeZNokCBN4YSKiK13ys7oWmfUF9GFG+LgRl3701CKJ/g/lAT21hpzvI0Dg3hEO7+Ab9k3srMd9lids5nLVtYxwWuaCM7f/6FAbXi6gKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZhDb0XTQeVeJ1NBmnOqF8I7MmsXuXuhZdS+PQkCEdA=;
 b=UHirHWCYm0n6wkEtIJhFGrldggH7HEZF6CIOy/Cy/xa6xkEVpKv/gLTeskH4+HVf1dQxZjSuubkkVSZ2B4t8+tQchzTqEtK1rbD6Hi86Iief+8Tzp71A9BZosV9UtpwpcebeaTRxPvb3cd1xeAW5o5IWxCOw33AQJmbIH1Cg6DShSfSVD15PxbY2HSo7bU44ZZTViYRC4YD1D4Xqdq1RXzfOHWVmbDzVt+7oeOQWZrU/0ovL6QVTTmcuT8o+gV3Vnh+uHUICASgS13YLKd2MCBPNadqS7DeJBYlMQDR0ZLZpO2P5KvB3jOZFFVdYmgfmHL5w7ezyna8nfMNkFucbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZhDb0XTQeVeJ1NBmnOqF8I7MmsXuXuhZdS+PQkCEdA=;
 b=mWQ2RP0gDllfiga6ebnSpgPTObCwPelM/xHIkfLW1ky1dwKW5Ec660gntq0clE4RG2GvTvMWalsPdSHXd/chR0/GQLs2+HNIn1FkRPrhXc7Z9hFa/VGP5nPQUgKsJpCszhicUw5hnCmElOArL8VSdSmPEkWGxyR4H5yGN53YvTw=
Received: from CH2PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:5a::12)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 2 Jul
 2025 09:40:23 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::b2) by CH2PR08CA0002.outlook.office365.com
 (2603:10b6:610:5a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 09:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:40:23 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:40:19 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Wed, 2 Jul 2025 15:08:03 +0530
Message-ID: <20250702093804.849-8-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dd3531-4704-4d20-6b9f-08ddb94c77a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yYJrdxMiTxZ9CFa5V3Ef+ayTFCFlUm2ErjoOCCzBwx3EDh70tRmsya690uSB?=
 =?us-ascii?Q?TNUTEZu26oAtuzHxzv2wnvGMJYfB0wjIw7qU/Ji5zI7987EDCJG+brhh7kgh?=
 =?us-ascii?Q?UfpIsPVflaosDb9FOziBNnwhC8PgeWOZ/95gdm35hHix7KGrgXzDe7V93Odu?=
 =?us-ascii?Q?NfEVrM4lEa8B417k2xABxR9XfWthFzLZTvglLJJOuGX5Zr1nXO8EzCGEzUv3?=
 =?us-ascii?Q?dtA9K+dKIe0ac1MtJjpVucVEbb7YcW2cAtkj3HVVxF0ahY1lSm4LEfKhJN86?=
 =?us-ascii?Q?aIjxafJsU3EenlY3UIeqmIdZGKyvzuRwMHYFKfTPjBIqA+DgNlpmGs+6jVco?=
 =?us-ascii?Q?cVGRPR5FaugrOkhOylTQgbV4kfMj/oSHnX3B9/a4v55yo8ydn7HJZeblSI2i?=
 =?us-ascii?Q?Wv+SMUH2E5uSLggNie1uVI5PC5ozWISFZLoXxMWzFbDHTxzufhvCuCJClP9A?=
 =?us-ascii?Q?oEWNtOoEvw/xVPwOVbS8+WFNb14gCoO/dMOOts+1tmNbe2+hRWTUoFj5LvQm?=
 =?us-ascii?Q?VF3VNNY8gxdEiNqRmC8ck93Qm3s7L/zZsb9ZdRmyikI4kgOO7zbnOGIaej45?=
 =?us-ascii?Q?AM6dqUbBJJEZi0Yg2FMb8JPqvMIvppJsDs9XlInpn/SV3HtDzgK1b2c8LXjE?=
 =?us-ascii?Q?V0irGwtPevx2DfhfVtQs9R88+D3+eTS1rkX9l/3wyTrkZ58HF5buT8HMp3Cd?=
 =?us-ascii?Q?at1soBHfFhxkRjT5fQaxzgR9SasHxCVJ2y2C8yIvMv88ReU8bjTvZAAYe+GH?=
 =?us-ascii?Q?ulFY76CWLpbl8ZOpgQQVGzP8Nv3Q0b6dtCPebrpBspEONW8x6OpWhmbBeeRa?=
 =?us-ascii?Q?NiqA8Hgurk/668LwYGWEMHI6KHYd6TWBuxcPuWdnIB4X7OmXbgVPPyK6K0D8?=
 =?us-ascii?Q?Yc1l6JBzWaoqNh6yRoDxrwdFZic6IyYMNF3WYsm7Chj/Nah9ZZsyEY8nTx64?=
 =?us-ascii?Q?IU411kEcgcQ2YLMhseEK1rXuoHYQeLhQzlXVvXhSmqVaYN8SoFl9sOaTMki7?=
 =?us-ascii?Q?lQu/3VYucsdajtgEuQmCgh10J0pVCkDFwEGKQNEJD9eJkc/Ix4gqUjKp/WKC?=
 =?us-ascii?Q?HNPpVofjQbA7nvWi8aWIv5/E1wnRgIGCTvd50Cqzin0xiz7rlD3ZE6xjRnW7?=
 =?us-ascii?Q?Uvp49RNglty6Al4CxjtkDtKBXW0reXhS9Nq+KpGHi+g4eTphS35S4QaIt/Av?=
 =?us-ascii?Q?egpuUzVza4aydkNtajH0sXLltxRyf2xMN2xb7yjNG6sK2fRJFTsVlCnd9mYS?=
 =?us-ascii?Q?AQB3vlNHEHPu3JvfRXGgKXgQShQARWlqoV6NQWY0Q/VF/1dVSnbZ/O0AJVlW?=
 =?us-ascii?Q?g3zXs/XofZZs+UBfZVRuBI9vL3GqsdTLrgubgpKDgDiGuCjFZKHVmXHt/8M1?=
 =?us-ascii?Q?KResZ1cDczG9Ux66kT52KNAECRsiCXzm1aLg57ghfl/0YH6++xilxBwlVuBX?=
 =?us-ascii?Q?ARnYABvOudD/GwRZxeIoVB2Rx1wD4VWrqVwP94LGjzP+RiUOG0ERq58DFy/v?=
 =?us-ascii?Q?fUnJID8bP4g5JhtnsGaxtnQF1BFD02ng8L7w?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:40:23.1807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dd3531-4704-4d20-6b9f-08ddb94c77a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155

In cases where we have an issue in the device interrupt path with IOMMU
interrupt remapping enabled, dumping valid IRT table entries for the device
is very useful and good input for debugging the issue.

eg.
-> To dump irte entries for a particular device
   #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/irqtbl | less

   or

   #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/irqtbl | less

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 108 ++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index b01eea2fbe03..10fa217a7119 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -255,6 +256,111 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
 
+static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
+{
+	struct irte_ga *ptr, *irte;
+	int index;
+
+	for (index = 0; index < int_tab_len; index++) {
+		ptr = (struct irte_ga *)table->table;
+		irte = &ptr[index];
+
+		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+		    !irte->lo.fields_vapic.valid)
+			continue;
+		else if (!irte->lo.fields_remap.valid)
+			continue;
+		seq_printf(m, "IRT[%04d] %016llx %016llx\n", index, irte->hi.val, irte->lo.val);
+	}
+}
+
+static void dump_32_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
+{
+	union irte *ptr, *irte;
+	int index;
+
+	for (index = 0; index < int_tab_len; index++) {
+		ptr = (union irte *)table->table;
+		irte = &ptr[index];
+
+		if (!irte->fields.valid)
+			continue;
+		seq_printf(m, "IRT[%04d] %08x\n", index, irte->val);
+	}
+}
+
+static void dump_irte(struct seq_file *m, u16 devid, struct amd_iommu_pci_seg *pci_seg)
+{
+	struct dev_table_entry *dev_table;
+	struct irq_remap_table *table;
+	struct amd_iommu *iommu;
+	unsigned long flags;
+	u16 int_tab_len;
+
+	table = pci_seg->irq_lookup_table[devid];
+	if (!table) {
+		seq_printf(m, "IRQ lookup table not set for %04x:%02x:%02x:%x\n",
+			   pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
+		return;
+	}
+
+	iommu = pci_seg->rlookup_table[devid];
+	if (!iommu)
+		return;
+
+	dev_table = get_dev_table(iommu);
+	if (!dev_table) {
+		seq_puts(m, "Device table not found");
+		return;
+	}
+
+	int_tab_len = dev_table[devid].data[2] & DTE_INTTABLEN_MASK;
+	if (int_tab_len != DTE_INTTABLEN_512 && int_tab_len != DTE_INTTABLEN_2K) {
+		seq_puts(m, "The device's DTE contains an invalid IRT length value.");
+		return;
+	}
+
+	seq_printf(m, "DeviceId %04x:%02x:%02x.%x\n", pci_seg->id, PCI_BUS_NUM(devid),
+		   PCI_SLOT(devid), PCI_FUNC(devid));
+
+	raw_spin_lock_irqsave(&table->lock, flags);
+	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		dump_128_irte(m, table, BIT(int_tab_len >> 1));
+	else
+		dump_32_irte(m, table, BIT(int_tab_len >> 1));
+	seq_puts(m, "\n");
+	raw_spin_unlock_irqrestore(&table->lock, flags);
+}
+
+static int iommu_irqtbl_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+	u16 devid, seg;
+
+	if (!irq_remapping_enabled) {
+		seq_puts(m, "Interrupt remapping is disabled\n");
+		return 0;
+	}
+
+	if (sbdf < 0) {
+		seq_puts(m, "Enter a valid device ID to 'devid' file\n");
+		return 0;
+	}
+
+	seg = PCI_SBDF_TO_SEGID(sbdf);
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id != seg)
+			continue;
+		dump_irte(m, devid, pci_seg);
+		break;
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_irqtbl);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -281,4 +387,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

