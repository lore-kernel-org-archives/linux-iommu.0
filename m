Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6D1DDA0C
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055159; cv=fail; b=WDZ1rzsbq2/JlDXe/rTDrpwxKvW2XPqXbe4NU89FPXngXMT3/ezulQF8X/177kdiabaHsIQUoiWzrhh+k9NjuK6SX1QorPs5lQ3eCfWxd1mLBfgfV2hRwk4GZGoUZ4YD0zLEHJMtZPURI3qPIn/m6bHApUhT65NfLT0C3HTJTlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055159; c=relaxed/simple;
	bh=DI1qbokCFjN2vslZAawGheSEy/KilKMdmcx2h7mHXnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OH28ThYtS9J5xHbDoPlVDmf1Ub46ZsDSwxfgAcOGKG4QJSOXemuAND0dt+bXuKerpKphJmuwo8kwf216sfofBMIevJIYvcfek/0Q7gldqLBO9Fj+MEtizWxjLGzJFcl8bSKdJaQ6i+rAsxf57AT5BzjFRD/GPaerRUQ6nFQIvuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P/rMQhik; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P/rMQhik"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL2NBycdUiM7UjJVd43lsMC9FfV+vipXJkpc3DqJttmdVvmbEwZB95iivRHGJKD4HX12f23HQ9xD5hIqFNTyMUqaEbAoTUmDppypSw4uQ2XfQUJIV9ShI8YNCqI/I80W5kHlKj/1SknSmgAC9np6UIVCukhr3Vr12FM8dyYhRQ/JgBV+FIjkI+15nDZTJ03SwwCn7N8diyN8GJ3RAxnJ5n0P78HGkf+Ok6mp19p2CKvNme9cwUJe2wJ1+4C9lBBGym1ZSn4RvAQI4a1oS0QpR3YvMHl6UUJHWx+W4V7EolnFUaB2QJiTD+HH/fASma6AAMMqC88h8mZPY0htdigTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/P9hlaLL0C1c9sksHAa4tLqUAiPpMZms7trreQPvmyQ=;
 b=nH2gIXjftDoEhVC58Nhh9/KcCRcRCgtKdSLGmIX/JEmduqFhzz6d1Cehn5HIg5VbWCYjwPVg8+J5QHGsrcxEL0VWcWEOMB90LOCxBBFTBdrft3rfkhOAhNlIH4FTGJDYKVDD5YbWqbvz45PMrHmX+X2fw9D5whTsdK6l/Dwhv1yWqV9UJFD5jD9Jbe1fDqpRmo1XqJXG9hVGM3dzOm03J4Hydp3LQwGGzpVdBfNNHzRNE6s7OuOxWXb4Oroflh0w05Q+GHSB4D3sodfHYLmNZy4xiycPmsf67ILsRrBAvYUDsA0HzT7llhA6/fLknAtFUQpjv5aXJwJ5eiccpOhSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P9hlaLL0C1c9sksHAa4tLqUAiPpMZms7trreQPvmyQ=;
 b=P/rMQhikC4dq2TeMUdZxkk8gVgchJW9KtyPQLZ1IaAFBpMgqpjABmSVynyNInVA8RsqcowDNG9pnvSSxUHaBubJEBe2qdOClErBPXMnZTj6aWKJ0o8GbQqNptFokR7rPgu+as99nQm25V98cDWsibP0SEwpvPamtm7d4AoLp52M=
Received: from BY5PR13CA0034.namprd13.prod.outlook.com (2603:10b6:a03:180::47)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 16:39:15 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::68) by BY5PR13CA0034.outlook.office365.com
 (2603:10b6:a03:180::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Wed,
 4 Jun 2025 16:39:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:39:13 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:39:10 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Wed, 4 Jun 2025 22:06:46 +0530
Message-ID: <20250604163647.1439-8-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: c30e7867-06a7-4d8b-e6ff-08dda386573d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?301IBOs4VHeqH4+plNYBXTPcKi9eJQAb1o7DaMKKOInPMLNzi8BaTpOwu05L?=
 =?us-ascii?Q?lSiL4sTNb4FVOAq7uxasy7XyyNfUM/srLpu5m2t0w5sce80PJXzFG8cP+aQ1?=
 =?us-ascii?Q?LSnVzDMdmPcVkcxDIy5N8qJoo6VR/thKHzStjd/xZVFevHeHo6zE+wsyCvnv?=
 =?us-ascii?Q?ld88eerBw2cgqicSNVeH7JL69lmvZEe3rKYjNjnwU5tNkOSomaZ4ektjgVwM?=
 =?us-ascii?Q?MA1DHE9xn1VlZf7WBO0q7TX4Lg1rnTHAzz7cqmCAlwIN/GN2VS7k8iRlsP4a?=
 =?us-ascii?Q?rGdMJHjVLNdxvt6xyD+gHzmONBm+sSXmhfOYQvbnvxosTiDeVdDUWn0km20B?=
 =?us-ascii?Q?6MzxnH1CrcLVdaCRTmKZQgumQXHp7/hzHg9jV0x+IWcjcGBcCBe50U/Yfbk9?=
 =?us-ascii?Q?hna0UmtMykw3X1iG5qtuO9VELz1xZA3KmYaZIw9lgaY9guEpw8hqavyqzK7R?=
 =?us-ascii?Q?hXb/Y6Ru90D/2Qg5N3m/ovmWkw1BerKXQUYfxOaUcfCrDaZrlO7aJ9zjL+o9?=
 =?us-ascii?Q?WSrNHjojzANXcYkXUGVBaw0eVn1rUyJJLLjFmwViGPZb/U2Vbyq+IdnaxCpD?=
 =?us-ascii?Q?Opp6sN1Qx3y1emvD2Oqe9x/NVqt05Y91z0dcWeWYHwbO4xoOBxdJ9ApjtkaR?=
 =?us-ascii?Q?rp6pJum5T2j4PHrColQFn763yo6JxOT0i5Nsa00rbFOfXxxiO6R1XpcvC5M/?=
 =?us-ascii?Q?g5kPqoxHnVDFSjNn14v3V/jUlmH0uwC4svnRq3XDij67A/pjmd6QkNtlFGFM?=
 =?us-ascii?Q?88WJYw4aE7trza0KF2Q2tuW4dBP+c154EZD0HOUJUplhM5QnuGex3g+zwZH0?=
 =?us-ascii?Q?nN9P+jhCrHBDGjznBpDF4JM/cUJCbLwo2PtTLqqcRjH4im53dBw5Z0SgoXS/?=
 =?us-ascii?Q?X9ydtGMIJsQGpmqT2CnEyG6m7Wkdq7ribNgaartid5WyuuHSNbokoM31hclg?=
 =?us-ascii?Q?EeeIkZSz0bDxTHErNsStk1KwSN98J8OfYf1m88BdXNP5Gir3xe4QHEtwIhUF?=
 =?us-ascii?Q?O9U18AetlKDDCVFxLxyJP+wEpo+Zaym3CfswUl/TO64q4sahQ9/F7cxhlMdP?=
 =?us-ascii?Q?rjpYx8M89Sb4wFOWpBlvwqVUjD1luZTPn4AnjMROKg4u3sDVrc2Z1qp0l4/0?=
 =?us-ascii?Q?tdYbobc/l2eyvSV0ggJqBuy2tuvC8fCrfI1OCUNDrNCVoT9Sn8akpBpO0R9b?=
 =?us-ascii?Q?EZUlxZ/sDfBj0FBAkZkkETgWH3jwaL5QoT55WR/riJIL1vM+O8qtiXE6LWDj?=
 =?us-ascii?Q?VG+lTXX/VdJuJxKPlIYYdu0/vkVMTwhyO0zHNGfZZ8PiXIIpxmF3oM38wC9A?=
 =?us-ascii?Q?dspaf4/p6EA7cNqD8ZxOI5USaboAtBhyQi8t7vIdWX/EV+gcDqS3TsPeNt2O?=
 =?us-ascii?Q?nm3pAo9Ld7UM44qPSMbhursJoc9J/9hh0Ql0xllb0Zl54ymsDMlodNl0i14Y?=
 =?us-ascii?Q?uAWAIpYoFw9SQVLa3IsoE7afv8s2BU4OS6dZu503tZqeokAYo/W+/suz03C4?=
 =?us-ascii?Q?l5yXsXVUb+FF1FOQ0U6VbjmwYrjZICnpyz3M?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:39:13.9632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c30e7867-06a7-4d8b-e6ff-08dda386573d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242

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
index 38d3cab5fd8d..7a056ebcc7c3 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -254,6 +255,111 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
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
@@ -280,4 +386,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

