Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C41779B1
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384157; cv=fail; b=LDCaptzEmP/cF9PSXvAUplaTudy/kMAEBI7TeEAXj8US2t0A4ly476FGpzMSytnhuKv9y4dJ8Ow80iftcuPPcUB2G3OW9hJr9HSXmMa+2DF45U4lFrfNJZDLEiiyhplw1r3fphuoL4MZFjlPAemjZr4d3ZUCbv/dRdQExS25+C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384157; c=relaxed/simple;
	bh=AZz6sIM1HfIK/YEUMYuEpsQePTn+atWhD69ew0E1Gng=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pOiatEft5kfbI5RMqdtKlsWW9qM4WxZ9h+tnvc39s8NPEkjZbToxYA/4y6AP5F69HHLFvU8eZJcA0OgWhFVdaTA1DWDhbgdUs0+lMV967+wf6cQFIUxev8IaLpfpHmd9PKARQbjJvYfUWwODqGpEMnQnwbAblzAW7S1tjVGlXLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CpIaq47c; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CpIaq47c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWRh8F6jMeH9dIiXwuPp5c3yKRM4Iqv3SOVOd3bWbld2iYqJLpAGdOQ7FqjREQsUXoXGcsqSbDOgDcJAvM65FPPheS0/YBCVcFBm9lK71R4apdVQWquf6sBe0nbvnOewKAMi19/l1AvsAChdowBe8xTunMUEXI2ozOTD4IF/2NmqXrEA/+Mcjwmrcwvz2z4hw6GDk8eeEiGpy7QuS+O1vkmRBr8eGWyS3GyScurJc3UsSjBVhlUq3Y40YHrsA0hbpfXcPBP5UyKbJYwVP2pm6Ia8P9c8ospyOPYCZV4/B0K8MBvyAcC+lsX25ubkRJVzzERw/aZLeOxXdvEP80mDpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU/lfrk1qOMQJUdlQdyvi52e+jTkIFe7EgM9UG6PYho=;
 b=vBnbI0tAJ3KiuLasz+KR1/UUV9nZyoNUUvnu/OeiWoVHoc5jqXeWh4hLG0lZQrXSDG469A67mu4bG5ERY1DI0YngRDnywxJXWr7H8YV3GPbVAcy2pLB4GffwJZrKJDqpqnjA5rgXMBpxhWh0t/m9jP5fyePHrjqpopOuM6caqnMMo0ttkDMLcp7nXKaYRnU+vJRky0VKl5vz/maY14UD5rFD70zBg5xYvxRE1CxZs8KAzgW7EAGJ8F0RiNG6pjhbkx7IfOvpAOPtVfvZ+1DBdSzpD2hahXKl8m7hntx4FPe73BceIJHr41fNEGXrKra6eaHiytbN/2nO3mEqr69YpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU/lfrk1qOMQJUdlQdyvi52e+jTkIFe7EgM9UG6PYho=;
 b=CpIaq47ch2ll0DJwEvCwBTSWnS1IW3hIC3cXKAQ2K4YkisiBySxmFe8oJbzURHcAGqs41NsUD2vi8zXoaiGxPgTsQUpbtgOWIfRL0W6npjTvPYYuXpVgha0YVpcawp7GnCnW26w6F2pOMT734pCvjh4fnVM8Y9vvK7HXGKgF0Oo=
Received: from DM6PR06CA0100.namprd06.prod.outlook.com (2603:10b6:5:336::33)
 by DS0PR12MB7874.namprd12.prod.outlook.com (2603:10b6:8:141::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:42:29 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::10) by DM6PR06CA0100.outlook.office365.com
 (2603:10b6:5:336::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:42:29 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:42:26 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 6/8] iommu/amd: Add debugfs support to dump device table
Date: Tue, 8 Oct 2024 16:10:33 +0530
Message-ID: <20241008104035.4008-7-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b3f7c1-4f62-434b-5319-08dce785e880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUUJ/auUQ7HaXzdsykvkvvKHOW5o/Ywjs3fa8XQtaoFwZs+Pa38qDV50EMAa?=
 =?us-ascii?Q?FeUnVppjTOf+32ZJGv0OsBLb/QcZoIZiYo2XAQjRPfAUguVs241M7/2CJ8LH?=
 =?us-ascii?Q?YsKDkR0bNo5eZfCSkZ3a3GcRbaQd/OknL9gapEAbjqM2CVMMoi7OW+F133It?=
 =?us-ascii?Q?jh+2SLX1SD5/+1JVlhRm1WrKXho5b5LIrPsivro+KKBE6qCK6w2N1R+8jvMB?=
 =?us-ascii?Q?mpGDaGSCqLBAoih+cXV5Gh1D9D0i9utx1n7/Mi6vjE5Nm8m0PqQBVhsqyIQc?=
 =?us-ascii?Q?Y3h8MLcYyr7JX135NJ/W4QEhpNOGQDQvFz0lls6EWkn/vmyzksJbv04PoOX7?=
 =?us-ascii?Q?cIp2PHOvQoqAWJHvANQfUkpAS63wQ7sNURJecfbEbFOHY38muLiYCbIB43CN?=
 =?us-ascii?Q?z/1qD7Kd+bwFfZxKNoj42n4uUuzvHMECBlDMmaGV4MbNluFnCJuHU6p4lVAm?=
 =?us-ascii?Q?VqfBxB0cOpuBncuTPSF6dSn9Xr0DU38mBtLhkqGxSS5kpGI6Gns+Fe6uKrNo?=
 =?us-ascii?Q?WHBSKdJsE9MfepxdS3cDCtua+N4WMMg7NPsVfYyQWbzcIt+xhsGzi5L5bSBz?=
 =?us-ascii?Q?p4PkCj0EcTsmnedn0+73qv8+BJmmmKHmcTIZpcWGajrDu/Gc3kN5FDQKzmb1?=
 =?us-ascii?Q?N6G9OUDuGadqMwrbySKNvH/0C5sYEgvn9VmiOTEFMhgm2Road47GcywefOCC?=
 =?us-ascii?Q?hDRRTnDv23GRewS0wUnT4EYzJNRmpmFx5nWsmBwe6DvwZKC5aZ7mp1qTXdSV?=
 =?us-ascii?Q?rdT5xMw/Nn/avXqrBsDQUo6/W8pxiFLgEIGfnSdKqabApY3M+EOd1FDIZQK+?=
 =?us-ascii?Q?RYIKWd8LjuATmPh1xiFnYrw0PuN60n1TUQ/5CeWE7R8EOVj8qGaCnCC8cAMT?=
 =?us-ascii?Q?Zags2omdZLndY5kVKNYG72+6B/l+zxUf+gmeNscLItz4fts0j8VWNr2ItWaO?=
 =?us-ascii?Q?Tho3rT8jy8HJcYdG/bx4LBZb8MPhsnccrLZvfuYcGkDnZbkUizYBI8emF2Y5?=
 =?us-ascii?Q?GStz/Ux8l8dcyP/v7GqUic3Wu+0qj7D2DX1vRJYQ/PfdpPEJdyUm3s0XAqjb?=
 =?us-ascii?Q?Nqd1BtKrp6OfWdThPVILP0dIiNJdzSKDbqKmAs4A3bvvXk/Mtu+ZSn3z24wf?=
 =?us-ascii?Q?vbUQH8/lHNN940ENL8pTwlOc4Vw50qe4xwsrkPBWiH/eOTXd+r+oryH3Wukp?=
 =?us-ascii?Q?FRKfnoxWlS6bpyZkRCYb+nGFrOWv0cGBkVwvdTYzsB9NbhnLnSvXrujzKanS?=
 =?us-ascii?Q?wRO4sv/9x3vqT54/3Gr6ShYrgPSM6GUb0iv21SY5ph+qyvSaqdzKYfyC++bn?=
 =?us-ascii?Q?PWw10RRtuTXEWUFv2+m2720rRl4KXGRat+o2PSjWDoaoCivww/Vnrvu1N60k?=
 =?us-ascii?Q?aoC6XuA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:42:29.5439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b3f7c1-4f62-434b-5319-08dce785e880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7874

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
index 0d11250c1a00..61a541019432 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -268,6 +268,53 @@ static int devid_show(struct seq_file *m, void *unused)
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
@@ -292,4 +339,6 @@ void amd_iommu_debugfs_setup(void)
 	}
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

