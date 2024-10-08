Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57C1C1AB8
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384172; cv=fail; b=TSXF9rxKIil1yrvi6pJ/hNcDkAistqqelvU9Tv97xhPe8mOXNs+nNuB6/rvHPvjaI8L6HQzs1ouIyiMlK+wBQq7x6tX9BRvE14D4LCSHsEm5mWLQ7MA/GSOqdx2+DqCR3NnedJRKL6KyBGAKdFMRZ1tiivVtrlTkQa+L+fuJ6Fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384172; c=relaxed/simple;
	bh=By29/aBchl0Omd2fP/uNxXb0Fk/hTLe9TNjD9AJoycE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZqeDBRrvFFgp3bAop8aFpyVS1g5Gs0bE75qUu/pXaF0bFXQ/Geku6ZhKbogYwkSJDcITYHp0CQ7QvNWZJDI8rvUg/Ak8M9jflCMPYNSCTZNIhTmv3hyCEWnyaeaGSXu/iZf6bx26ytP8CwGcuFItkUT5ZFAoN8n/W1oFG3Dazk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xvq3JNZ4; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xvq3JNZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wztEWzpkPD+UQxPgmGQQZM4Sp46xPQf+lMQyyBrk1dnB/AW1/hak4JFggFbTt3HSuqxw53yedDbmxZJcGs4bLT5tyMLHLTz1VB+rhVkXXVnaXUC3c6ox5pvQ2GLZw1wcKJFq+1rHRaMxWqQbBrGOPxJWTrrxgaUeKqVD3L9o7DR7U7VbVmBrzBswRl5lpp9XPIAvpwBiVZvoKr6khlSSUeXfi+te0jytr88g9RfqZHOxO+Wh7YimHSBASO2FGwgHWrGHqAqOBStihSDkI09COIqqVOh7QjEsNcRcCZxSdeMJnM2hHbk2p0pzPkw2dHPq9lp3MBTCU/+g9Nn7vFEU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=urAr2jzwzruzfGbFAr7563ijJJqB4VGK8SGWrSPO48k=;
 b=H4SIgSs+wOsc9KODrWh4R8+3jSPPV3CRg5MNaqX+m9npnYm316vCAg/En3fQOROhsPt4rbIiUhMqE2i5Y6lzQJQruXqK5Yo8zCBIu2GhLvbx6dDAcPtnjjycCSuhQGYkqoBRbUYWtszyKd8qt0WAb/FXrv+A1hXYEAj44y6/oXifyPVQnfsBIntWcmN8o8d9jckNbp3IXVZ5/qENsl0plUeGJErRWn0qkABcdukl/zCuZ61UbjQDkT9G/mVQYOdTByxfV0Kyvv287+T41ZkIWN1HcDmLGrRpuZL+/YsOOLzf6GaYgq9SUYxJtxsrwgEibcPs/ODlU9g2w7f5NPm4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=urAr2jzwzruzfGbFAr7563ijJJqB4VGK8SGWrSPO48k=;
 b=xvq3JNZ42ItNenW572c8uNZzR7Dr4ALgZRYeS4K/jLfdGJbzI5HX+7sMr4E8H9hXTNFW2M1+jp8tOW56nofwHbx9GicRgIyhQbz/6v7niV2JZrhaaTK0FUKhYJQySVDF4nH22EBTlPCyXlDVZ24hLNYGei4tRlR9f0MwNbv+4mI=
Received: from PH8PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:2cf::24)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:42:45 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2cf:cafe::d) by PH8PR07CA0046.outlook.office365.com
 (2603:10b6:510:2cf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:42:45 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:42:41 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Tue, 8 Oct 2024 16:10:34 +0530
Message-ID: <20241008104035.4008-8-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: fb458b2e-67a1-4c9b-3075-08dce785f1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mWYIEJRizPtraL2xYreQxVuibkX/W9973hHOk9mIrVQIbC6DFLCK3UwIYsbn?=
 =?us-ascii?Q?sxmXoQ21pZZm9sBSZTWh7foNFA1ZJDtBE4jG8x/HAyWJ/XnHjT36oAlU7o5N?=
 =?us-ascii?Q?xrsWspd2+fWtKhgKXrZCO3SDfZfXoibI3RIUtmw1oTmRmHiWC8DjXagwFZgx?=
 =?us-ascii?Q?n5/FLyINcaRrR6qBN0VOtT5i6El3QCr5nZ2Ul3M6NKmEYR5q4D+C1o0sM4UW?=
 =?us-ascii?Q?z4G6BJBBffYOE/hjBxEUFgPs4qZTxW/xPn6Z+GFhOC0Wi+3FzUbgWX2doXkZ?=
 =?us-ascii?Q?nde46HyYZtPs6IPX1UFkIzYIlY9JnQbzcE3v7tN0nhanNneJtd9X0Gmz77dg?=
 =?us-ascii?Q?cIWAzLP+5QEAvpveGe3sOmwlUuo6h7rop9895FN2wg+iJPPPHxLSxge/Rnjp?=
 =?us-ascii?Q?hWrcVs14+6iGr07dYVSDwsmX9ZhCBSfB9eq7lQu0Hd/QY5MVNndXAhtrfNk6?=
 =?us-ascii?Q?uqFR54Y+y7Oprn3MVls/36GvUhFND2pB15+s+sBRV+VOMrfGNr5zd0Kq1hW7?=
 =?us-ascii?Q?yDJRjOYFSdnUO1PEphqsknuA+F/1dJ/gAdk8t2a5QS2Qglb7SqkgLBq+DxGl?=
 =?us-ascii?Q?BlbA1EiDljwuSbjkC7W82apmBJUPnNgWHG9i0EC+kVj3+Jr3HQu2rzUlNiAr?=
 =?us-ascii?Q?dVrq1TbXjctHPaDksmDzEKjAPn7Ww8IZAvA59r1ufESya6w5URsMgHj6RFsF?=
 =?us-ascii?Q?Bdd2RPf1fgpY7XZSr3ZAove/wWRtUc4Ch0gR8Kupn9fAdykQDWBzXpJfP5+G?=
 =?us-ascii?Q?PbzjuA3ej9k2s574sPLssl63RQJ0oYYtt/Kt+v7q5TGMtdmG26vOUiCD7H28?=
 =?us-ascii?Q?lMsX/Gfg6295YlE4rxCMbOvldBHx6FYBf0XTBZ0hZeBkN7VaPS2csusWvC35?=
 =?us-ascii?Q?QLQQ3k7dYibz9/LiWavSo3ZwK2jbu291P7asKN1WREtad4EgDyHCOor2INzU?=
 =?us-ascii?Q?Vy+6WAABXu3c2OkznxipQ68FHipwcK0U1urMLYWtZH5OPH8BfTjWgCVj84hn?=
 =?us-ascii?Q?CoORu1jAiG6Us9kCD/2hUuPzJ/KhfEGRuovrNaWGw9DG2nXcvBNMI+b9oHXF?=
 =?us-ascii?Q?64Goae93E00CdQYdbEbfhFrZK83+exDYoo3xJWdUcTM8VR0m0RjgEuIxFL08?=
 =?us-ascii?Q?8ToDYbhc4JOGNhR/vsva/zbFL6IJcwbIZIHfCFzzBoXaCUByk8v/TqBbe7Da?=
 =?us-ascii?Q?6B4EDkGbF9JlbM8hx4c+E2Ua3CB6DlgXvwRMCg1HjdLUJVxV1Rpa/oOpCDOV?=
 =?us-ascii?Q?+lTueDyXGIqpeHt3KEFqeYqO/dctiLz90gsDG46gmplyoFFz9WfU7CXGleQW?=
 =?us-ascii?Q?CAIUALThkOisuIKsTaJBj/tCn12CjJT9T+tyVDAA/f6h4is44UmhmMEdhi+P?=
 =?us-ascii?Q?4AfE+2Jj5jIyz1u+irPtLGSk5hIU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:42:45.3135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb458b2e-67a1-4c9b-3075-08dce785f1e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846

In cases where we have an issue in the device interrupt path with IOMMU
interrupt remapping enabled, dumping valid IRT table entries for the device
is very useful and good input for debugging the issue.

eg.
To dump irte entries for a particular device
   #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/irqtbl | less

   or

   #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/irqtbl | less

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 61a541019432..c61daf921441 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -315,6 +316,92 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
 
+static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table)
+{
+	struct irte_ga *ptr, *irte;
+	int index;
+
+	for (index = 0; index < MAX_IRQS_PER_TABLE; index++) {
+		ptr = (struct irte_ga *)table->table;
+		irte = &ptr[index];
+
+		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
+		    !irte->lo.fields_vapic.valid)
+			continue;
+		else if (!irte->lo.fields_remap.valid)
+			continue;
+		seq_printf(m, "IRT[%04d] %016llx%016llx\n", index, irte->hi.val, irte->lo.val);
+	}
+}
+
+static void dump_32_irte(struct seq_file *m, struct irq_remap_table *table)
+{
+	union irte *ptr, *irte;
+	int index;
+
+	for (index = 0; index < MAX_IRQS_PER_TABLE; index++) {
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
+	struct irq_remap_table *table;
+	unsigned long flags;
+
+	table = pci_seg->irq_lookup_table[devid];
+	if (!table) {
+		seq_printf(m, "IRQ lookup table not set for %04x:%02x:%02x:%x\n",
+			   pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
+		return;
+	}
+
+	seq_printf(m, "DeviceId %04x:%02x:%02x:%x\n", pci_seg->id, PCI_BUS_NUM(devid),
+		   PCI_SLOT(devid), PCI_FUNC(devid));
+
+	raw_spin_lock_irqsave(&table->lock, flags);
+	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		dump_128_irte(m, table);
+	else
+		dump_32_irte(m, table);
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
+		seq_puts(m, "Please provide valid device id input\n");
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
@@ -341,4 +428,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

