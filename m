Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A2F1FAC52
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821781; cv=fail; b=Bpoew36lkV7QWCKtn4CkAFN/xobQxtqme79/C/TrHIONp247jE7Fndbc+CNLq+O0k8oPp4ZQUtxo0yACpMGV9xqo09SkDOr5fYWeQIACl3NQVYo7B3SquarWkarew4aCnkr6bMSvGlQSO8Z9cZtgDjuPQZL7k15j3VBbD/qMWvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821781; c=relaxed/simple;
	bh=n5Zrv0milPp3aa01C1CUZnOp+ICRVwWtzJ7oMxUTlZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRqsVb942pIsgzbYWqLHurQPbjEEAFMYmPN3uXZ1VxKhyuIUdD2AYkxx8lePJZyaQPlHsC4aqfsShhSDDSa9e24uQpnaKad6RPu/695eJBDFf7L8Qx34So4kP7u3H68nDj5B1IQf/tuMfFTEUrvhTMI8PObwsN8D9Q8bs8GyeMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eSIKr47c; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eSIKr47c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AyIr8j7oZvgRKF61PHdj/pyLZuryiUExCouiRvCiXakxJ2nh3R02nGyIqf3xWlLXjOe7WAbTfRRrhP3Tib6Mki/al3uGk3QvAavyQsCMlp1SGrMgFVXRTqDQkPRFGWirLVfJEn0hJ68eBAMwXAwL2Vi5qOyYwoh0fBB/p2zZxcjfmXjfQ/A9syTDZQVTnRVobxZ9lCD1ubjnNfXR/QenjM39UQ4Mnfc7bzOQFNeL7FDb4DFnhcBhUBVIfQjIunzHGnpM7l9G7+xqV+rEHfcPMyi/8h10zAAo8BYBuocPUGGV3BNeeA7pvoDdS8Z4SxmAMHtWPIprf1c4grQgxJq9TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eImmYU/fKpRDnyPqWtkYkLhgmPMCfUMMjSqNiAi1jhE=;
 b=RCwzx6Cab5YEgnc3riy9218SKctWQt+el2lsGGfpeO+d5m2L+Hk4cUKAtH+LfiH5lcBjemTLuHfLnRFJFs6FmnbO2Hjoq1Rac2NkQsijmtglAHkEMooS0fcx1Ft3Hn53jCrbEuUYCNDOArvJEGpZe6N7ovVMiJZAX1XZJgDtphCUBfICQZE7XwRrtd7TKgyeOq3DThU0DCuF9YRdvX+pQIvpwpXnsgyBaeZVToLvk7BDV8NllTwr6xFauqV07+awu7dCsh7QtbLiyFzzz8k1FDRtT9nd5eYpMEwy+pxj1uHpnHfjwFe2NjD9MsU+TJ5yPVnO9ZGP1BPQeiRvR+3vtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eImmYU/fKpRDnyPqWtkYkLhgmPMCfUMMjSqNiAi1jhE=;
 b=eSIKr47cp+WzRf6AJzqGC2k6pdCIBnwV3R0GS0Aibn5KCrjwt0XytjupWKjGGsMdlp/LgMXJ7/gRtKqzUZQ4715T9oq2MlmUVm+pwPJInPZopbxNBlBCwHFCTllyOWP2nfmta0ygphGbIx6UCiYJDP/pPstjo2C9JbDmwbwC/ww=
Received: from BN8PR07CA0019.namprd07.prod.outlook.com (2603:10b6:408:ac::32)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 06:02:57 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::26) by BN8PR07CA0019.outlook.office365.com
 (2603:10b6:408:ac::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 06:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:02:56 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:02:53 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Thu, 6 Feb 2025 11:30:02 +0530
Message-ID: <20250206060003.685-8-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: a13f6bd0-ead4-4fe6-4e66-08dd4673e6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K7J8cSvu0ek/L4wnHxhqreNGglcr7wQFZxNMac8uBjNKpeyf62fTfAd51+EJ?=
 =?us-ascii?Q?EZ8G+bSxM8ejcTX/6BnAot4PYqs4mtnNUVVcdD4oJFx7lpAHNoYvAdkcKx5P?=
 =?us-ascii?Q?myXSuWIszivtp1J0GdFGobybJK1auqulWsGIsPgEf/T5YnxwZnTaWE2BnDay?=
 =?us-ascii?Q?oj3yS8ndKuToasGXVKZ2v7XZJUgW1E1yrjqKKMoJFlstFnSsKugDGtWnmwIw?=
 =?us-ascii?Q?Px1XO4T9OZrvs+qHm565dOaC9Jy5zqJ9d7lDnPxnWuYjwSAhgGeaSIzkG6E0?=
 =?us-ascii?Q?fZw5+qsAjl7pztNEcEpcCgomjTBartVhpGteNb30kp2BDbDALzqjpV4rWhN0?=
 =?us-ascii?Q?yKaQsb210a0fkjk0DUkJakxidTmmO0mf3scM8N66d78YpC4vouhUyRVRN1ES?=
 =?us-ascii?Q?mmIGJakhCvIfBvJM0jHTw/EWeYBhsUJGrGZ97oWiAvEXQSudCALkIu8vfzY/?=
 =?us-ascii?Q?zflYOgwBSICGcZg/FwoC/0IF+CN3FLygY1Ie3Ad4Cfx3Azkul/NLklyyTJXT?=
 =?us-ascii?Q?5up/zesgXhNMd+InhqStyfLL7n2wPNYtNGeHbBQtB4ih94yrBIpXJaCC4508?=
 =?us-ascii?Q?QbCGwYiE1I/nGpRpmPK35BdtFYXKr5wb9KYm6ppdTN6FL5TI0GI2/SX7X8t9?=
 =?us-ascii?Q?IOg9nJwd+4JD7qzKL3HFOPhdYKHGjTBQ3WtpfJufYg/EspBRjG3B4F4wfwOF?=
 =?us-ascii?Q?Ziouv/qNYID1Kwtr72awMT9awdybORjC62fnbX/4HYK5dNIVHQUmaucaqMHI?=
 =?us-ascii?Q?x9dOu/A+OYMD/5G+mGLHpK9UlxDkOqjvpIFngIqAWb5CRFuAJYa7V3KQHyMp?=
 =?us-ascii?Q?vRGHgqQuSgNP40yv45LvmDBtpF9tZaAz1yBA0gaPH/dEV/regUKsr6dGuhYy?=
 =?us-ascii?Q?swvE8b2Sh9Ee0Yy577OOp0sYo8wMx5+0GuHNlh10HRRInM3tv/T7q6n90DF0?=
 =?us-ascii?Q?qPx7nkUZymGuHpZzbJPdkERVqxoBhDqNsKW75s/7unSs5XlWF3rCvXqUqg/A?=
 =?us-ascii?Q?11CXQdvaTxhthYgbByxjOHP6JZQQ8ijk7NWpYoKXPfkVBOau83HH6VRhNkIZ?=
 =?us-ascii?Q?qtpQBOEtk5z84qxod/rbfCBu8t/RSHXN0SAHJY/Ad62uq4nu7POsld54Vvpr?=
 =?us-ascii?Q?FKvEeM8b0vlg85EYQATNSSa22PHKdMI0SUZUDOO8NVIiFBJgihZFaFIkTw+X?=
 =?us-ascii?Q?0rUtpu4aj+YzE/ovHoBCqL2TJjZvLz8ay0Fo9820OnJBaSzNavbkLx10ZKDI?=
 =?us-ascii?Q?ptPjBY0OvW1TUgC34ARIUAxcXKphWPpfCYqxlPYjECpBk6LjBsCuz8Z5eBjC?=
 =?us-ascii?Q?nFMqN0KUt3CHaCnSb+f5iLM/Pkp4OaiaUUfQNMvEs6Y/p+PVO4PUuam189u3?=
 =?us-ascii?Q?pFoIZAimfywAqFc2Cy3M5pq5UMBSWvJH3/xq2twLKvLwINLb5KTX+n54IeZv?=
 =?us-ascii?Q?qR358X531L4g5pzp5fNVw0K9RKG1iEURLm/HEu0dEB2UjJ5P4MJ36Z4bMBhn?=
 =?us-ascii?Q?JiDz3/wU981IPog=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:02:56.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a13f6bd0-ead4-4fe6-4e66-08dd4673e6ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706

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
index 1377795814d1..0aff1d616108 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -250,6 +251,92 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
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
@@ -272,4 +359,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

