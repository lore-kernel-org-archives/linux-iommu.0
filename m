Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757421D174E
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879498; cv=fail; b=UZ5zYWV2wtwMrlIwjy2EB+8dMMtlWXLsmc3FThCKwhVPS4V9EDdnx6JnTylLdDonxeGGx4uQbGdNDTHNqqw3uM9ctVQSBLaOm8csbr6Z0zU/kPkrF0fMQ9DTmkCEsvLUuAQmqZzJY1Pn2ztbH/kaUjPBk0B4+DF+ubcGfAXx9U8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879498; c=relaxed/simple;
	bh=nxgnb9yCQ1RXJXxl34G2WP+nDz/AAFmusQ0gskGE0wI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNj45RebAA49IV4IU+kty8A21uUdkQS6OGJ/z9fzaQYW5kRyfA7r9A99mZaqnwTFguuHTBm7rq9/fKrr8rGhM6IvHgk5Sg+ss6xSWbXlVSkpCVyooQNdbDThBpPMeO0cUVQajcT9ifb4N9mHwbJX+uErtlKlvomNLBzWY7SZKAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VfeTIWoT; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VfeTIWoT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlYRvM4/JcU79idJ6IUaZfEXuBWWqGgnYgvtHKz2ZCE5e6AJE3LfTqnbpZ6I9cMAZUjaHdKEBSQ/1PRUBXnv/PnWyd4RWyUUGEOcglRaVX70b0Sb/USYhVcX7zHlNue2RDLdViOK8ReuB7cRvXGx/DiOCCTN21iA4vsafNv3VJxF1f8LQzbZqcnoYz8eURTUULo1bGdjzgIedQ3I9sW8qjF1695hwNRUWTy+ViMNibjwsP2b+r+YbZoUKwPzxZGSIzF/BUd4tnm5MyXCVLOAgPhrhbm++4tQ3OEEb46KCesDiDmjDu7cbZ2vSD6xCDseO5ygRlIiQNC/of+tqt03Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APxTADBWUXFYxjwQGcAyGrl2qCnfeGqLMX+IP5aAPAk=;
 b=uJMkBc70ZoixNhsrtgI1woRTdw5zH+KXhuZVvYhfe2A8QgIvLE02u3qRLRQHcyLalKsBF2gmpmbjD+cYycmbBEvulOlogUboX6jExHDfesRhSZ/EEMo6F1hSj2L5LKfeoeG+uvlfNk0dbcE1IW++M7Vk/2aHoRk8V0Qn1RfP+C4DooyLxEGR8TdguLWRHxPDKrZ6+i7we6pNZXy70pQYN8jj1/tPZ5ahs5Po47zXRMlA9QuqZtFQ0DBdNMajW47n3VP5xutFUyicmKAN7UzuBSJxcw8TcFO7fCia/jRxBlfBzV+LB9HLMhcd2CAhbvqhDqQc53tw1B/CJNK61wbKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APxTADBWUXFYxjwQGcAyGrl2qCnfeGqLMX+IP5aAPAk=;
 b=VfeTIWoTD21BsH/n77kQlwykSymOYpnWTJ8CPUyPk4KCUvI2fKR566yrko4cHVnPEdKnnrpGDhaE4lABhgQiQxMDfGORZ8yBwRRt1WeszeaGzblGFBJkZD0MWIb6S+twYf2Dueu/Li86uPXqXSlOvIK1BBfBMxeBmMUUezO18y0=
Received: from BL1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:208:256::28)
 by IA0PR12MB8280.namprd12.prod.outlook.com (2603:10b6:208:3df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 07:51:33 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::61) by BL1PR13CA0023.outlook.office365.com
 (2603:10b6:208:256::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Wed, 6 Nov 2024 07:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:51:33 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:51:30 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 6/8] iommu/amd: Add debugfs support to dump device table
Date: Wed, 6 Nov 2024 13:16:37 +0530
Message-ID: <20241106074639.2039-7-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA0PR12MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bd80049-e89b-4c8d-1e62-08dcfe37d572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbjjDDyoJhD4PIBT7W+UlvTZJpFlpSxVewDz9VabTqCVKx77STEW9ddMQHDg?=
 =?us-ascii?Q?ODt6PwdckR/StrfUhTOGGYHT1kXMBlO6VHwqqdAzKoTfn/6POd2OoMsKekDZ?=
 =?us-ascii?Q?PWftpFJldQ5jSFu2qZqUUiscusxFe65owkCx8lGNw71DqtXBJFd/p+ZOYLeI?=
 =?us-ascii?Q?QQLrP+lS6QvkMMbJ61x/LVEqKeFYI2dwKJPH8pYPGy6HoR6AXb1EPxkZywlB?=
 =?us-ascii?Q?s/0ffWsxVQl9qnEN7YLrDWBTkCPjo2MNQcpMT7+d+fwFchPTywi7kjCeOYtk?=
 =?us-ascii?Q?LOHcWjhuxq1piQxBzJWMw1cErXwf1hup2iJlIEIvKWtMY6l6JifAFODwMk8F?=
 =?us-ascii?Q?K0BPWw0Y2EOUMlBpnlYVC70LMCtRQ913c34bPYkyGf8GkvYb5J2QduVmXyOS?=
 =?us-ascii?Q?mhXQRDOJ/4gAJiIJSVJVzPCaXeyxmQZx81l0f2BX7ovMiHUgINRaqVwID553?=
 =?us-ascii?Q?fdcWram3qEtXLwu2V5THMrTU5G6JRjni3Yb/qcKjUw7lQZr1folBTPzBMxWk?=
 =?us-ascii?Q?+46Zzn7mJ4dKEeONIWcwm3OQqrvJYo9+FI4hbYXOpGqJFLWI5W8IO9xqEW6P?=
 =?us-ascii?Q?UIAWLXBamMxBLFVhCQ72T9cbPcht24r7I0yFg/opveLTU/9khxLd7ixQw7Wg?=
 =?us-ascii?Q?tEskDSMFMeMnKCUkbi/R6XmKI+pmq2nLT395hIJGgqyIspcxlNxkP7iDCANX?=
 =?us-ascii?Q?DqnXAvUCf7VGxOGPj9uoDHVgAXOBeKiDU5EgiI3/u33OMhC7Cx39y52yyCak?=
 =?us-ascii?Q?X5v2WKvNJUlnMTE4whMe45/CAnsSZgPt+AL/f7JWdlAeMeWbp5eDQrowwA/A?=
 =?us-ascii?Q?wbeQhF5MdYbtr+DIvJ/fhsgm0fW7bRJ3ue5zRGPfZ6tVBsI7QbBtLL7h9hBS?=
 =?us-ascii?Q?Fsm3Wfsr3LcDyhqybvg5dV9W5OkVDKSyS11MEi+VPGpICAUpVjOpmJV9oy6g?=
 =?us-ascii?Q?eubEyfq1Q7ttB54Xl9oXw2mdX/wVVdXtm++9pa5bf2YO5oRFUEAQnqx2wvyn?=
 =?us-ascii?Q?NOPb8HCRVvM5DHoUkFaguzEJHzhZUueFkelgnmDfUAXP9FhRuiLg3OyEluIC?=
 =?us-ascii?Q?f/7DmccC2QxIyg9Dw/7HxwoCsO5xcCuny/PV9YDLjvEdmCjSUF3sG9YR0K1p?=
 =?us-ascii?Q?xXypJz5wnx1QgzmeMU4RwiknYTUZtxLHRJW2B5Ov/NmJhNppXcUkUMFVWISn?=
 =?us-ascii?Q?XuqooQpEYiNzy+zxaVEl3LbAwTJQS7vFb6US+vOugV7Azw7WqVNwPZn91mFL?=
 =?us-ascii?Q?22vUlVbX3lRA4i2Q5hzMyKlxry/I/9BkcOoaLDsVxKiGbZv8wVMrRohH2ZcG?=
 =?us-ascii?Q?IbHW4uGkYNgprX83c4uolhvEgIz2PWBQTC6tTVSIyFdjlXqrfDV7XtKekqxD?=
 =?us-ascii?Q?lKyRxbAwv2p4HSymwLojv+S7OCZHB5JvcoLHF9Ebl6URktcpNg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:51:33.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bd80049-e89b-4c8d-1e62-08dcfe37d572
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8280

IOMMU uses device table data structure to get per-device information for
DMA remapping, interrupt remapping, and other functionalities. It's a
valuable data structure to visualize for debugging issues related to
IOMMU.

eg.
To dump device table entry for a particular device
   #echo 0000:c4:00.0 > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/devtbl

   or
   #echo c4:00.0 > /sys/kernel/debug/iommu/amd/devid
   #cat /sys/kernel/debug/iommu/amd/devtbl

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 74c88a80c6d0..bba65848ef60 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -225,6 +225,53 @@ static int devid_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_STORE_ATTRIBUTE(devid);
 
+static void dump_dte(struct seq_file *m, struct amd_iommu_pci_seg *pci_seg, u16 devid)
+{
+	struct dev_table_entry *dev_table;
+	struct amd_iommu *iommu;
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
+	seq_printf(m, "%-12s %16s %16s %16s %16s iommu\n", "DeviceId",
+		   "QWORD[3]", "QWORD[2]", "QWORD[1]", "QWORD[0]");
+	seq_printf(m, "%04x:%02x:%02x:%x ", pci_seg->id, PCI_BUS_NUM(devid),
+		   PCI_SLOT(devid), PCI_FUNC(devid));
+	for (int i = 3; i >= 0; --i)
+		seq_printf(m, "%016llx ", dev_table[devid].data[i]);
+	seq_printf(m, "iommu%d\n", iommu->index);
+}
+
+static int iommu_devtbl_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+	u16 seg, devid;
+
+	if (sbdf < 0) {
+		seq_puts(m, "Please provide valid device id input\n");
+		return 0;
+	}
+	seg = PCI_SBDF_TO_SEGID(sbdf);
+	devid = PCI_SBDF_TO_DEVID(sbdf);
+
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id != seg)
+			continue;
+		dump_dte(m, pci_seg, devid);
+		break;
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -249,4 +296,6 @@ void amd_iommu_debugfs_setup(void)
 	}
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

