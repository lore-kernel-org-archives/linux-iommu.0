Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2056.outbound.protection.outlook.com [40.107.100.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C623815F
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212884; cv=fail; b=Vht+JxTmosAN/0WmoZyLPA+PsCkjxuMaypH0wij81kkOOduiVzaXN7ey5G2tKiYKEMBrk7+c+62h40tSOZ4UqyHwpZTekx28BOehXCe95CxQvpEaU8eUpyNRmJIWeO8WTGGNfqaSprFYGT2rSQcnw7aT+cqTL7np/85v9td2skM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212884; c=relaxed/simple;
	bh=umGu3UBN9kEkL+cU+n7rMMAPrWUIQffkXneg9hIzbsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avzno2jOdEGPbOw+crtXmo83YG4gVHox21RqRkBmSpvPlYw2eBot2xr4mt8/InvvhMmvdxZd2aLyKMn3HQTIfkLWgFQewOKi63C/Cata610qcNaSqdg4G6xpnj8lfUNTUdVgk2wzoy8D0LiS/NIqVyIvglKTEdxvLkfdvaKKIAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mp5rOok2; arc=fail smtp.client-ip=40.107.100.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mp5rOok2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr8joY6vV/MGx4W9EeFsdWszr/+FwZeRLmT+FoAtshK4/fZSvQQSZV5bj7AZAYTN+R2ISN/BU2Nn6x5EHgMUDWAtUAW9ecpjo3jUM/5hDEP48ise7TDGEf3DAPSUAghCvO1ACdrSCMCBWg+9f7N4VhSXHMsPEyrvYIIYqA1gssXZD3vf2Eo5/LBl9/wW9EgFFKWxNsOolQSsQM926lGd/mpA+1705MtpZPzR1v+jmm9IyiNYE11O/KZD8QN9o6dWWKLWwFJYo7HMcPX/DEsI3Q5QOivuYu87GmK3ADHgCMd08l9cBm4t3HzfUunNm5ZoW5M+9+C1Lf0DvL77vAbGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxpzuF+tMjCbBCrmiMsVjftxo9tmT6wt+a6WVRX+d8w=;
 b=DDliUCNh+TtRNITFg826sv0F4HFKPFUbwrcuXTY6xfgPsiw8VAePdtk4jsRqh4tRg6IltMbXXy6kM3JTiulmRpAbyldKgU8uTI+WbpK+GtlH3JvRrJPWPgN5GeYvqzyVCcYmxOjOG5Y4OAc+PtJPR7hXvcp3jNuOSQfvFmM3RutDXshDKvaIstLPSD7ROYkr2wWxUObd3a5Uuo+Q95AhA+Q8Nk1B37epS6Mx5t5GReU7CMkU9mQiBnhcKVQfr+yjJYh6Ne/6wWIxNHWKa+vKH5EmNC4XoJjg41OwRKHRjHUome0C3IjHT/nfI/fAhiAUuK2fN3igfElrXxQMZ7xRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxpzuF+tMjCbBCrmiMsVjftxo9tmT6wt+a6WVRX+d8w=;
 b=mp5rOok2vrJENu5NRq9hmiwcJ7aRh7L+BWqGvR/QzkfkY2KQ7URDdmXabZrAhkGkQ+ETTp+CFg+qsMnQ16r788/LQEIjHLjCtjj1aNhcGzH7iRG+/obQgIeIqQyU1jT+0nHhlKviOc4/dJWD8mR6dFo8jhyWoELzAUDn8rEQiIw=
Received: from BYAPR11CA0104.namprd11.prod.outlook.com (2603:10b6:a03:f4::45)
 by DM4PR12MB6639.namprd12.prod.outlook.com (2603:10b6:8:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 12:01:18 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::e) by BYAPR11CA0104.outlook.office365.com
 (2603:10b6:a03:f4::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 12:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:01:17 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:01:14 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 7/8] iommu/amd: Add debugfs support to dump IRT Table
Date: Mon, 17 Mar 2025 17:28:29 +0530
Message-ID: <20250317115830.3416-8-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DM4PR12MB6639:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea322e8-3ed5-46c3-d4b6-08dd654b6ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+UvkQZCn4XP6CzKeao6mTOEMbh3qF0fp7Mpg00GbBfLgZE7GUDxkL7mW3Lv?=
 =?us-ascii?Q?msZLvxn6BlAzoAtOWSW9Gri7fj4jVwxgFYWs37omnEvVBhCS4XqUNbUpVAkv?=
 =?us-ascii?Q?cA1BHxGAvXziCuxUxlSuOCe33dzeTCOUfLXSvyCpvgs53n9MfU0LOwRGCqJE?=
 =?us-ascii?Q?Btm7IwsrY12QkOnyRpq/0w80Wlatv5Yeamf8i1hkqqEgAIZAfdpSiyU5QCFT?=
 =?us-ascii?Q?nvZ8BV3gpK9hUaOWGbcgnib013Ca2ZxXBpAslnU4TAD7K1NotsYyO+eM3RGb?=
 =?us-ascii?Q?Tv8/F0ibytKHAk3AdQJQjLAN/ul670X8FNwGRgJ+s7cogYT0PHPFz9r2s8Qd?=
 =?us-ascii?Q?2OQJPcBlJ4I7sNP9SBJ48e8VanWusADa9sSW6ATJzfoa9FOsCadjD1VGrMW6?=
 =?us-ascii?Q?3nnyp+jsTUaAGbySBLIrf1UcXLXu3GgaSkPIXNkJwPy6W7q1XITQKTmv6nEi?=
 =?us-ascii?Q?s+0o/Jr5YX/cEfsrti3SMeySu/fvz2OnD8HLOf8vWQhI9f3p1v6jirLsETVY?=
 =?us-ascii?Q?GVcZlrKO2Nw9Isf0xVZaFqM1GMr8cOSfq75E4aRo9DtuWG1LWBxp6r6cOXa7?=
 =?us-ascii?Q?zotrWU0z3kA5NQbMF8ru9Ag3yAdV7NBs3AvE5CI11andQ9O+CtUYZFI7sE4B?=
 =?us-ascii?Q?nyhlXaQXAFeuYfsXAdWs0eMA/iAL8guYqTxn80WjP8j5POM4sGRRBe0IZTXq?=
 =?us-ascii?Q?8OMAO8Q+hNEsbZ1nPfaG5znMaPwuuXYji1Fv+ylKSFSaUFdeGnpuM/qeSOQE?=
 =?us-ascii?Q?1PSIGsZ6rmqJxi5wqxSnGu3e0SHosOdqwKgzyfh9vIIpMghi6dsBJ62/qlgK?=
 =?us-ascii?Q?lZG/IimiikAonKDRrcJAFrclKE0Evojw/0FlYHmMmAKg0uPRm6ZaBIMltvCF?=
 =?us-ascii?Q?2ZLu6026rLrcYxIUHtfvBhx46Q7zR+/Cdfr7+6fHg4k4x+EGa98uL6lB5WZZ?=
 =?us-ascii?Q?jWNxpkaT9xAvtvf9V6wUspiX3pwePp+u58Kf3ROojglguNd8QCRURRVCCWff?=
 =?us-ascii?Q?iBmb/KWLzpWTWJ2aBPwOlg8fr15qW8sfu/RlOT7+BVrhBVdrMjKOyULTXz8Q?=
 =?us-ascii?Q?2xUHNh3Cm5TAp90zhZ7QKbcA0oEr42yzk1cjSsz9HeWX2nvRvbzipMJy4rAG?=
 =?us-ascii?Q?n4tl4N5BPd/9vQ/cOOCziQ534VPxgIppXAjOghzogLC6CL7QisAfioVvZ3ag?=
 =?us-ascii?Q?Yhwmp8fhb2L8PR0HrP+2J0FanVe1GJQYIxsgMgv+jibEgJuhI8GM3Lg1AlUH?=
 =?us-ascii?Q?GNuxdPcYkGWorlZLijoF3VRDiuNsaMkgILSSmbtxmFwGP1F6QlcaTxGP1s1l?=
 =?us-ascii?Q?3/JYJ6fPeWI9eOPfRZbQr8qKIcmOgaTJxRmUq5w+C9i6kTvOYjUQjJ0LRHvi?=
 =?us-ascii?Q?UJ1zEYKNi6Wtwb71/xWT7gQd2HENmQ6aXdOx7guyBXgterBNgBFHUWYxqcR4?=
 =?us-ascii?Q?JnP1w8uaO7PKg463M2XK15mjy6vb0lu/jIngjxLpRZcKy6Nu/lI5cRUPMaDD?=
 =?us-ascii?Q?ewfYInq9XS06B1k=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:01:17.8764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea322e8-3ed5-46c3-d4b6-08dd654b6ce1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6639

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
 drivers/iommu/amd/debugfs.c | 89 +++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 4ea50e5625fa..cd74a10109dc 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -11,6 +11,7 @@
 #include <linux/pci.h>
 
 #include "amd_iommu.h"
+#include "../irq_remapping.h"
 
 static struct dentry *amd_iommu_debugfs;
 
@@ -254,6 +255,92 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
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
+		seq_printf(m, "IRT[%04d] %016llx %016llx\n", index, irte->hi.val, irte->lo.val);
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
@@ -276,4 +363,6 @@ void amd_iommu_debugfs_setup(void)
 			    &devid_fops);
 	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
 			    &iommu_devtbl_fops);
+	debugfs_create_file("irqtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_irqtbl_fops);
 }
-- 
2.25.1

