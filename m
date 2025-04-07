Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07EC254AF8
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047478; cv=fail; b=EwEUhoZvFJ8HdeWrYNbIkCXsdnK3ShQf5mG4zwLEWSrVvWv2m3qnHoL8gNBGwmV97BDziSO2PZKQOD8eMUhd44fMHbdS9a8Fp14ijvFOtL9IHBaHnG4+GewIF9vsvq2TjJmLCXXsaL820k1ogpgUKVf0uIose0/JHAcwSBEPWek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047478; c=relaxed/simple;
	bh=xVC0gIPFZfLufNcFjH8feOpxsKSS5xhQLcaoV/Nb+x4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaYaZvWMRwpxPW0TalPmYo5nvBC9CZGYJ3MFEEmCLR2WnMdOoKeYEJJopdYuYwPdnZKjMacBRW6+3h3ai2rvUPPraSquF2M/1PM5h2kStKpHS5CkUR7dJR4eYVt6BhveCwb26zLIdZ6kHhl2YcpAC6oK1VA6q49aKIU3yF7Oim0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=clyd+Dfr; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="clyd+Dfr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TgEtIiXEOk4ibT/fChy2c332bFAXoZyX3kigzjK8EAyb9mzN8UA84CSIRURlBYPC0TVvHFzfPSDaKuEjjAdNt5pD9K1yJBDyfJF0WkVv4WDsFzuhoLefeIFo3H8r4GcAsupMAawGmETu06VxC/rdPyIzRkiXxXM4KJxS7GEHXlkrvWBict/Qb6rEpijRdxBHw7osQRak7cASztlPGshPLIMVDNonS/jBI661FSmPuFkzvCmj5dWRzSn3kSA/0Tz1miDDg7ypjIRGAgCDLWYyrgR5CY50fTvjnisjkOWUtE2vYD+hfq1h02qK7PzI+YKgfrgckJO0l5yHyK4EC7NAQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94L5ChOv/kjO5MtcGHXSO9b2GQdVb14lxHIMDekMo3c=;
 b=ECov+IFzjKcIm+dwJKMOQtNH4dg9s5ddR2IXXWmWdHnTbLSsO+euqOrDKkTv08EHJklN9w6wyNcxYMTbBJ2Ob5sLBVBC1m6QXjXdBVD5rrwje+mB4S8dKloS3hOL75GAGtdxwLm8d0xo0xGmaUIVm6HE9Hs+YsZ0AJEssx+d7Gzd4AM5aMNj0EfKmLZ124N3TweBzNMHivku+RQEEhX8GISPQecNrjMN0IXB82PpPz0z6bZBqIs7RKTEaMeUIx8cQvKACHLqydi8CibCyigY+Uue8Qxt+QlPDrh6GeVIHONg5DKXeFrAcxSuf4SA9jytYsykTbGzDuCNUU2p93KVcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94L5ChOv/kjO5MtcGHXSO9b2GQdVb14lxHIMDekMo3c=;
 b=clyd+Dfrnh7XRFvo6Wqe3iQiWosW8nE0Qxs9GaNLCyzP8/ZTJn+mjpFjHZ9JNRieAbP2Co98U1znH2kTKeTRiMOBzHPpUkzynNdDuncRX7MRNGSa6lufMJujW1oWvbqezEl5dJeKFzNvGoB/CtGdSNdzFToNWzh2zjkPR2P4zaU=
Received: from CH2PR17CA0012.namprd17.prod.outlook.com (2603:10b6:610:53::22)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 17:37:48 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::53) by CH2PR17CA0012.outlook.office365.com
 (2603:10b6:610:53::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:37:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:37:47 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:37:43 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Mon, 7 Apr 2025 23:04:59 +0530
Message-ID: <20250407173500.1827-8-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
References: <20250407173500.1827-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660d668-a65b-47d4-2923-08dd75fae989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jw/yt1zFERIEMyYAzbuq33DvSEWlFYvvWAfhCUqmN11chShas8IIEihRMWVa?=
 =?us-ascii?Q?/WPage5rkKp9nzmvMGJ/Yh/fBqGqjrRyuq1J1UVPsnbXhEAfjcCd6oZkJXSr?=
 =?us-ascii?Q?zZ/PI2FQapYHLnonQRPXrswCgW5Rse1qwCrqEKGKlh5EzgF/vNEwB19wp+gK?=
 =?us-ascii?Q?O+Je5Rb+i6F5F+KjvjYOK6etqA8qfk3Ptj/x0GJJDKE8DzpMcM6zFeHFLUbb?=
 =?us-ascii?Q?HEeHCdo04r5+6zIw7hRnILDLGr0j/8r3e4IuZffE34HpYKh3AKwyCGIEO5Sk?=
 =?us-ascii?Q?6ZCIqOVgNPdIkA0OChNjbg5nEVnLxA4LoGx8dPJCQ+QwV9F8pudOlkQMJ2Du?=
 =?us-ascii?Q?dt31LQE1ok0pcbdq7aF5KRS7pqgmkKwhlBRpiEYy9Z61osDBqMDPWjwGk9QL?=
 =?us-ascii?Q?zFW1lYkkf/VAdrtAWq6JSvRsQbGDtQ4FSdKu5OUav9r2Wo9i3zKlh43gjYT4?=
 =?us-ascii?Q?9Or4Syl+GOYItcp93GmtAG5qmRrSOVC2CFqRGBEEmtYVIY0yx11PPQ1aVd/L?=
 =?us-ascii?Q?VOQAy1WE6d1asivK7f6QHYbL680acfY0qCWjnrb3d3FjPa/cVKc0W9cGXp0L?=
 =?us-ascii?Q?lN8MyQ5rbWTVYGuJU9+vIHKc9BfmCsyZC4R9p9LeGpvm/JlHUrsETfMmShHt?=
 =?us-ascii?Q?8kp5LgfdurGOMLB0/Y5WfPQll7jqSx0+URqyXllBKwqnnoQpwLZhU5rkgeDc?=
 =?us-ascii?Q?9h4Xxk0ycZn2Pexk7gPOEJA/oDUsgdrmLEJF2Aw27Y67eB/oxCCWz1HQpUrO?=
 =?us-ascii?Q?R/H8v58vfBxZCd3XubZdN18GkDUdXiO4GeJHucIobBcs9eH5/VgLwHj4PuPR?=
 =?us-ascii?Q?4SCwFVAaL8kufc3QW1mWjWn3a7IcGmFVAjzcuvyJUXiud045BjLfOeMqcKW1?=
 =?us-ascii?Q?yXqnR3f3X0uzyNSOO/W8Uf8ZWamoCKVI+1YeOCv72Eeen1KEM21u36IgWrUw?=
 =?us-ascii?Q?o14wbYw/8iwIUeoFPERVJk3bZlu7jNv9HDiZqadhS8J0iERZW8xdkCJRupQy?=
 =?us-ascii?Q?hGFRQBAZE//jXTy/xq+ScHLgIbQxdNFd9BgWAJwq0/lrZmMlHfx5d90kAOQ8?=
 =?us-ascii?Q?ayeRbxXKYRP0AIqmkAwReYks6H8yuYpCiCMxzuirlpVBc1Kkmka4jANxaUsy?=
 =?us-ascii?Q?UGK4lTIlxHKV4tp3vDxTeTe7oHAv2PMsuXMZC9gyUH1ODltuJ86Z+6QP/+Be?=
 =?us-ascii?Q?epNBMPLYX+PsmN03DE+EJz07NyTDerGmm+MofyN2C8J6DLLTbC6GjER+AT8/?=
 =?us-ascii?Q?BjoTdZkUfJ6UJVIkXqDe46Tda5EGEhD38AOi+T7aRU56iAB4xNWm69zD0h0z?=
 =?us-ascii?Q?XSU+Z0/Al9E0u8L0pOaShAkIiJtCg2NDzNqeXwbxfe8EOp4oYK7Tad1Y5QFq?=
 =?us-ascii?Q?7dE6IX8LM5k8yBeKH7KWyMkEimonqceRK1GhZ5zZh9thdSAlUaeQb49mpOZQ?=
 =?us-ascii?Q?+/8WFFZLkyr4no2doyTQW2CyEcthhHfU5ztqqPdgaRHGsKQUKm0W3JCnIPCh?=
 =?us-ascii?Q?3daa6cPn6KhsP6U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:37:47.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660d668-a65b-47d4-2923-08dd75fae989
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142

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
 drivers/iommu/amd/debugfs.c | 106 ++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index c6ff47561afb..28fe546e0bc0 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -254,6 +255,109 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
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
+	int_tab_len = 1 << ((dev_table[devid].data[2] >> 1) & 0xfULL);
+	if (int_tab_len > 2048)
+		return;
+
+	seq_printf(m, "DeviceId %04x:%02x:%02x:%x\n", pci_seg->id, PCI_BUS_NUM(devid),
+		   PCI_SLOT(devid), PCI_FUNC(devid));
+
+	raw_spin_lock_irqsave(&table->lock, flags);
+	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
+		dump_128_irte(m, table, int_tab_len);
+	else
+		dump_32_irte(m, table, int_tab_len);
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
@@ -280,4 +384,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

