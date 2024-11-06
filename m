Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF251D1302
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879652; cv=fail; b=sJhIy+hkp+EUr20/axUv2KPuVU5P003/AqNDhcIJaimgng25wRoBs5OywihErd3Ya4lZMiHEVouGYuK8gscKBS/0miS9D0puO2GFogu3xWnQrp3ZPdtbrjLVxyW9v7sHhNDkjjBuijiZHzUJ/K1LCWbSYbj0l7QgW9wUzzi0mmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879652; c=relaxed/simple;
	bh=KTZDJjT7C9WUQu8RtXEYMJI1AY0DlkgbawuzN7ENRrk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qQX5q2VTbxDulUDE/8HhR1OQxk68z8PspKjMQITRUpNV539HJNqhO0W+lcrIowuYSImS87kWg9dOKPmMdxytDdwJaHL+Xfw1fgXzmk6ANFlRHChbPR6ttO7hclISdvqKjrTeELTyFonVgJRWUjGqatJwAOJP2vlZJH7Yj9amg20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=joqn2CJZ; arc=fail smtp.client-ip=40.107.237.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="joqn2CJZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0g19x72WBxUFgdp7QpNbfryjBgqJwEkw0elmNv6ClcLq5G3ZdJcsVG0O2P/umcZQpptOGQZWzjsRtmZM9GshJny/iGLazGvarvbR5C0uXeIhlL/+Fi6LtRj4CXxRriDsvpSkqx9VJiV1Zjbpy8uYW45uF39r2WHxVN9rKfcV0fG0vCn34+ImK7NpAnMoICBBE2IZV0A1LkQMncDYEZ7TmU+EycpUcTA0oZgsf4SI8hUCRiurN+lzDWYo95lCi95eL8eJ/B7LvEQNgWeJ9pm1AW33v+mhCHvkjmh9F+dkZbbvCnLOKOXPcpNILiO/JI07QgtCUZYMfIafn94diNfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIZlCUmTgeonMtf5MUFALfDH76g0hNzaNZpFiAGUtAw=;
 b=msTVVfRp63kJaWlLHV12kLLmPk7cdtCe9SgnKgQu5pCqs/zYFFyujltsZz3htF7/rXAEMqTAEcCeoyto3JDXgJ2E22+n/wCQJlEPLyXo6Ho3P3OrGopf/culhDO7sOY/E3RIagzPFsAnfYwzxC/BRsEXBJpzDYxdAzYFc9SMyc6Iy/tmMmg1Kojfqb/kY/K1RcLzIKp7uchYHsR561pPZQ5+R1FUzdUKZBEceNOEmuHhAt5nIAXJEC+9JQwzdXbJIWL6jLWYKWUBkKjzAVaA8lCNlX4PjSpgU6bqSkfu+HTcPCp9crOIUac8VRVrHWikv/GXcLM2bIK2SudFovg4zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIZlCUmTgeonMtf5MUFALfDH76g0hNzaNZpFiAGUtAw=;
 b=joqn2CJZ7ivUJ42zl+Y1iwoEYtIF0/tJnYfMej4Zr2csm8jMl3XeOqQE19tVkJWnzHmobVE2io6sTX97QSb6gjD9LAgotuKcjpYmLBWT9qibxLwGull0cMv7lVOUv5IrnDdpJLzO1d8Qa+zqtl+PPo+M2NSsUQEsBC2xE8keqD0=
Received: from LV3P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::34)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.27; Wed, 6 Nov
 2024 07:54:07 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::6f) by LV3P220CA0013.outlook.office365.com
 (2603:10b6:408:234::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 07:54:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:54:07 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:52:15 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Wed, 6 Nov 2024 13:16:38 +0530
Message-ID: <20241106074639.2039-8-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
References: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e701ba0-330d-4749-2225-08dcfe3830f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FzLypvNvP9wPYa3hWSbC6w5GJwZlh7BmWbeJwKLdx8ZKS6YDtnVZhpVpmM7M?=
 =?us-ascii?Q?xgtKudm3dK2z89i8U6hsbaQLj2IeC0snF6mp8M3vHCqPWawPv+v/kbRSSvBh?=
 =?us-ascii?Q?8B95NyDrOdBaFt4CV3aNzriFc/Ro4OP1U314qUaLM0E8DaSGalAJmZckjs7g?=
 =?us-ascii?Q?K4mfDq399uEgIf9NyZjue8wmZzoTjlKIWJLs5JloOhdVQnLnAkzl/oC9ro+S?=
 =?us-ascii?Q?jt4Xfi/eTMZqKQ6lIZiRCfMhPIor50Q8jDB2zPlwc7MFm1F4h/lEFY8FLTeL?=
 =?us-ascii?Q?qG/S3jp0koGs8VKPUbuc2CuRIJQ0d9hgi9lLfEGZ1PQ2Z1nBVTduxtmo/OuB?=
 =?us-ascii?Q?1yvnj45tweMbLJXaZjOdiHxjrBMhQY4L/UzRbtFfJnzTQ5QxyK1n604x6OTY?=
 =?us-ascii?Q?clvbJW31KQ+2aUZTb7GTa67mnEh2yGhlbLa3z/gqZhjrWTSnec8Pp1MZk0uM?=
 =?us-ascii?Q?bKT1ljn7G2uoXGSvcRRoEVQP1oDsw5iplINB7tXfKmUO2CvRIfklvwbAgqPr?=
 =?us-ascii?Q?r7aSRiDOq0uJ6t6sUO87DKHzADxPdo2rZK6U0JbRsVPG+0sLSpAS6kAAD00t?=
 =?us-ascii?Q?j0M3wQbXXwyFtl4FAEOodrZE1P+IHhXC3wNScd2KMPA2rlps6jWFHFu85xj4?=
 =?us-ascii?Q?BaI5WQ4ByMX3ONZ9FnR1pKJ9rEIseON1smGOeuMp+/M22Jbc7xYKSBa5iFY9?=
 =?us-ascii?Q?uPeGpN8v2bb+Vb773bPXOZjEFxLqe1i4yDGTjz0CH2mNBILQ6e+5gsQ1snRj?=
 =?us-ascii?Q?4p6duFChrdGHYV6kd88ppXPrFG/4yHeS5q1JKzT3f6bM8I3Ic2VvIRJcA2Qd?=
 =?us-ascii?Q?XD5POxtOMbAY5cbdAV3aN+uXsQ3DAtm8LLCvkgv5fUDpDGi87VGt8w8N9uWI?=
 =?us-ascii?Q?B8jEU4VoBGZ2xDa4k5vva6yG8VNAYvoIhcf168noPkfT8RyGp0BuV5eApLaB?=
 =?us-ascii?Q?WjuTj4yfAuCQ3oS8BZzftSbJPPBA6hs3no7yyGqD533NrYSRYJMcKvh/jwte?=
 =?us-ascii?Q?MqjlSRSgZSgtajRNVgEFS8uMASmQr0bIPZshdBO3/0GdU9geI9NnzcOKUu7n?=
 =?us-ascii?Q?As2pyg9gjWR0QWB7mWMugaBuh47c9FZpi2ElSi5ZxKVvSgpzjA1ch+9wWSGD?=
 =?us-ascii?Q?VOVZNiNCKQsPqlIcyKLGGqqhcdLxoSJhf2io4Peb4QpALKqDLTd3B9n0JtJ6?=
 =?us-ascii?Q?ova9MJWJ196S+xfFJxTNLsR2jvWeGKCmInZkb09iCUQ+IZ5zh8cNlO8Z0Yq6?=
 =?us-ascii?Q?8M1B2PPK5BDJCUHrsKREnxHqdBGhQuFC3TgQ6l7qkAZGTK5RHHBxIQ1DTe1g?=
 =?us-ascii?Q?w3seQNWVgx0V+lSOWN1iNSCech4LZvDLsdvC4c7pB7uXYGIFNc+Dsqd8zrv4?=
 =?us-ascii?Q?Iz9cJcYxO9dxTPebyVkue/ts4QP3lM21uSuQkcUpmLtqm+ThjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:54:07.1734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e701ba0-330d-4749-2225-08dcfe3830f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763

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
index bba65848ef60..3da3385a7d5d 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -272,6 +273,92 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
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
@@ -298,4 +385,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

