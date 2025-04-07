Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA921A422
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047455; cv=fail; b=KoHtu6SHQLxEag4+rzAJLf9DOgi92ZSPYAivvzkgwjTy2Ef6oUZdaJpCE77Ck+dWatjfixAdqYiSdNJscPwYYH9UN5ouM4+cx48PGSW+MJqmZVgpxfHtRfQwyyLvMcS+MHnSWuyVWT1I2Wdk/yStYtrJSM4SYDaffo8kBP3+KrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047455; c=relaxed/simple;
	bh=+0i3YpBKTfuwrtN5d+rugmf+VXSHhp3ILJslTMHtAEQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU94wEGuI1hG5TeJbQDHpuQDwQimjISb8aAnNoHjf3db8tgxM2KHG1jUzcjE5dyZjh1spaviZv18Kbp8N6+1w9uBjQGu3CzHq5qciJLw6fg40aEI3g0ETHtjDra3wxIhprCzP2J4Am8dI01U3EJKJtWG8fk3+QgbGtHF1Ojv420=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NcfbNi5V; arc=fail smtp.client-ip=40.107.101.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NcfbNi5V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODf8HB56rB001TgeIUD8EKqhR+22079JWLFtw1kOBT7SciQj/6Og71YeHy/dliXhD5iEo6LKyn9A1A/n3ukdq67vCUIer3zfTZVHw3GldBIwdJ9+uIJYsi4EQGt4I24yx7lc+PpstOAv/j0lrPIQ88t9VUwj3iBH0PD7bbX1KGij1AzE6kpkvixbaHsr1siOnzoazhUXhq9W0o92YJeM8aab2Q0yny1qICC/Bs52HFzlFhYe1H6ytHTvsMbRcncVkFqYodjDwfbC3z2sfAx93w1VRfJjQLaSrgEZ+eTr6aMG7QYQOKMTbVcA5DGarjbd8+sQio8oMfUPtnHbJY3rbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5f47os6PrEWRFAlGDBjLLnq2lXW2s6cZ10C9YsXPcE=;
 b=SZB0u59PBtE47z5b5yfd8aZCtU1Wr1q0lhAuoDyArxtemRi5/7xa2cYNhKkCD468g2Qfc+lRncnzwVVHKg9K3mhhUWF3OuRUfyHVmWAMPoj0+I0LZGP6Z0OxubdX4239jCXM3vRvgHgHZeMgsB7/vnELLoIQuWSoUgF0BCJiWxVx348erWA3pyCZcTT69JCLC+JQEHJ6r1zfbCwvYgKDFQCyxKYrPd5PVywWyN1FlIMBdDxHGdSnveblbTXG9Ums0awZDAF0YIErEyn84GvDmOknRorhvAMMtjSXD5hevfOcrwHtOi7TJFO9TLk75R1Zl/NNF6omH/+euED+KmveVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5f47os6PrEWRFAlGDBjLLnq2lXW2s6cZ10C9YsXPcE=;
 b=NcfbNi5VgJcfYF6vd2ZF4i43NxGFRftrUF3+Vijk38TJhOpp8Yvr2KKT4Sc8N3lkXveckyD8KA6OAlX/pASnu8Cmyx7WBxgiW9zGdQasuWdyw0qRX6kVOrcvMV3h3pM4jN0S4IIttD23TBW0qVkgEOTuvQxI4JWzH/6di2UmfAE=
Received: from DM6PR01CA0017.prod.exchangelabs.com (2603:10b6:5:296::22) by
 DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.33; Mon, 7 Apr 2025 17:37:28 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::e4) by DM6PR01CA0017.outlook.office365.com
 (2603:10b6:5:296::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.34 via Frontend Transport; Mon,
 7 Apr 2025 17:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:37:27 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:37:23 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 6/8] iommu/amd: Add debugfs support to dump device table
Date: Mon, 7 Apr 2025 23:04:58 +0530
Message-ID: <20250407173500.1827-7-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: ee3e6725-9ec3-46e0-ccc6-08dd75faddb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kz2uvEipWCwpS9lhZzzuY70mZV18z65i4YaeX5LtRIb52nJKsa0f0rpk2wS7?=
 =?us-ascii?Q?bpSLZmiIFBD4VPALnzqs+CY3hswLsZUu9Hk7GF68K8AuoYXwPqsKmbtepewr?=
 =?us-ascii?Q?qbefqO6dH1RJXWMxYjZAeCCpweLJml1zabQci8RnktFH4MM64WpaP7aEw1EZ?=
 =?us-ascii?Q?YIncHM7fqeDsA78hZpTYtV1shq2CtML1berCCXq5d6Xh8N+XPJildtu5RQJg?=
 =?us-ascii?Q?SEUi1PCPZxUkNn4Mp+iNcAiCBHW2XGp2fWvjDS4W1aCbut4OUYjSx8rrf4OS?=
 =?us-ascii?Q?MDz0U1+wOG7t8jl4ENbRdL3duHlPqgelzWT7IazxpcWYk3ywk1PXhHJb92WP?=
 =?us-ascii?Q?v1qUB1YdIZ1U8I/xOk01IJdgoqZXLDQN3+hxhoRbSd34WgLcPYuIb6ffVDQb?=
 =?us-ascii?Q?SShLWP5Sr6REgGyYr2rWDD5g4qzKLnVHZ4ZTzU4b9Sr7ufhL6UJOdz+gwGsZ?=
 =?us-ascii?Q?pv6719mkrguwYvLXl3m/82OuTaLLwiLdeSpBe98TazU0sJsEHtRewHGMTGlm?=
 =?us-ascii?Q?MkN6SyUqH/N/isVxSFKNEESPyjjyESJc1RL9ZJOh2H0LOojU/w4RzTWxvcwC?=
 =?us-ascii?Q?790yagOhWyxTmkFBVJzk6Fo8ary34KFwxtf6gbhpPqlKcoFGYIciddgb410I?=
 =?us-ascii?Q?Rm0JDklcI5VOuW6VdOZx4AYMdB0AA3SPoE/Ql7Z1WCpi55ohWb2vtrc8OueY?=
 =?us-ascii?Q?VY/NKo40h1F2Hz37MwyTOGxdwrh8Uv6s2zMZBP6bY8bovbu++9ltkhKloeZD?=
 =?us-ascii?Q?D8NcgmrBTJtrEsu+EU4DVeRggDEjB7VKqBBadM0QotEewtVPJmDHw3GytEEI?=
 =?us-ascii?Q?hMnW0f32V3wWAf4mnLufSqPyRRjyePqHv/M89o/8iQFayKObL7oSqaxxVvw/?=
 =?us-ascii?Q?9Ik5ExH/L3zmgy8GwG8/o/4k3ZphSV5xEmmTHJWABv9DM+IOBVpIBLWxotfb?=
 =?us-ascii?Q?6AIFEX3zZ43Emkd0vDZw1ZpcTUU8+G1loKphzAW6Cb4O0akjQ3g0lqG7z+eW?=
 =?us-ascii?Q?OAmD9/Y+2ltTT1fQotSYqA7ggN+7Vt/aMHi0U3CNiXW3aXC8f+/yXQ6LJ/xy?=
 =?us-ascii?Q?Hwy+1VsRUr2Mm/TCq8C/hdT+vbzfaqKsht2z4SDGlTVrJ3CMqAthcTI/xQt8?=
 =?us-ascii?Q?exItz6NGRKeHf+a+jesbYSiwmz7grXFqUHgK+I+/EgwujQ6/umhnJ5DgAz4/?=
 =?us-ascii?Q?rcbQcB8cafyqaJMXR931QWI2papH88RHKDscLUjKVszwC7EhIlj8DxQVNHnW?=
 =?us-ascii?Q?1dYmTQqs945VaYod4p8lv95C/APhhA16o6whWAcUHE4NZC6jp7dYhwFLZ8jD?=
 =?us-ascii?Q?3/f44VbiOsaSLOtg9vvaGW7S3kLa6hnQR/pcFyYJPKc50SQl8E9nV36DZzKI?=
 =?us-ascii?Q?Fxl2Onuj5N3vrtExtbvLIuIl+Z/WrTnRgvzX4+NxKM++3g4B+WDG/2ZvpmQ4?=
 =?us-ascii?Q?LOqhZzrbqUxkMnAv2O1DMl6R7Vd9MvdwIxTu0nz5SbIjEoLg4yLLZPPHGGUc?=
 =?us-ascii?Q?qulCl47Nky801yI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:37:27.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee3e6725-9ec3-46e0-ccc6-08dd75faddb4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

IOMMU uses device table data structure to get per-device information for
DMA remapping, interrupt remapping, and other functionalities. It's a
valuable data structure to visualize for debugging issues related to
IOMMU.

eg.
-> To dump device table entry for a particular device
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
index 5b474945aa0e..c6ff47561afb 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -207,6 +207,53 @@ static int devid_show(struct seq_file *m, void *unused)
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
@@ -231,4 +278,6 @@ void amd_iommu_debugfs_setup(void)
 
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

