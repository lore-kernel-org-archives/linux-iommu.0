Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9721B90F
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047433; cv=fail; b=kxknU5rlVeV/JiJCGPRftL77S7qO55iz9n+NrOHi1j7lhnqnqtleHrMSvBdtiHrBiR8hA6BrJP+rEz1GCNDez1/W1VL09uva0vkU6u2zp0ITEBgIC++ahuE/dVvKDkKDfe639Iuq4KEU5/QYm98qzckp6q5Rss8Ow6sPIGkhrus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047433; c=relaxed/simple;
	bh=RRTfNcswB6uo308YZqziW2zqZXrNds/HFktgYNndLxI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlWQfX2IklsD6b6O2kienjFGcoVqbG+0SCHKkc6ARGfY0VuPUQxuYPZcD5kBeIhNSHgh7z342zohrdWzUKhEjmK1kEYMQFFODV6hkPMbjXT+1CpEH/4piPRRCGW1aMbvfXXLeMl71eJ+H0FhPiAU6tnfGoIAUs8xDKpTUCeQFpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r9MnlvOI; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r9MnlvOI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctfD3fwJ9hK20NcuLUbc4H+/rinyEp1v80TX+xEX+7u7nsWoTHXI7Sg9UvqlnPVvGud7LxtyGwD6KTR7jSBDaUBXazD3kMPrz4zARzy2yZT2/2MYJevkjaaCERIteFz5GzzNC0unXAuXqX1Raz0xrr07xsLD7/24xWHaOkGdNiWIZf44v2ihBgUe4V8JgUlZt8GpBy4wxnfAZP7aeuRgaJU8RyjC0nxDYDKt+w5tyIu45c9QIXAy89hdDP9lvO4FYPS6VKA8hz2WQaeWKmV5PSPxHCRVFIFkkAUcNSjT28PaKpAJK2u6onF4ZhV3zdOuC3/utKPoqa74iQcPb8TS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJVSe1FA3aBW4ttaHPZN0W4fsyi8zN3m2aLL0wLRH+g=;
 b=jXNURuCrKH0xDRyYmNfWaks/L1xZ8ynq4Ur49lbBWY1TeGD9mibKNEeAVzCBAWPwT04uIZBcC239jCtubfim3d0Le+tPvJdJxX/LSg0JTWrm+Ta9PDliE2O02yIH48SyENfqgFZk9eKGG4DGm4665bD9zORXLkas7aR33QjcNQI47yzS4dZkrDH6jI8Mhk5VuNKhG1E0CX/Hku7B0YrUA3eAq4QrzmxXYr03iqKrB4G1XfULZ0UEvFw4AlQ4Wv7NvKUm4X1qQ5oZJelqw1tzXlKAfGZmuUh0gYLH7RROCtUVOgEOe66nLVwImKxpvpne1e4za2gREdQxpJztK5Nc7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJVSe1FA3aBW4ttaHPZN0W4fsyi8zN3m2aLL0wLRH+g=;
 b=r9MnlvOI/NtmxREwyNwi3PAPdnh0wCjC4RW0elr9ujLfx09wd5hh1bI6bGvFTftaWB2I5iYhGtNAzQ2C9dUSZacVxgcDGsX/eXtJpIaDPsKsYnU4Ba7yq3mOFc2K52438pXNG0P5UhF2BHfSnNiI8KzjMHM4KUwpSjDVBHTEsyQ=
Received: from CH2PR17CA0003.namprd17.prod.outlook.com (2603:10b6:610:53::13)
 by DS0PR12MB7928.namprd12.prod.outlook.com (2603:10b6:8:14c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Mon, 7 Apr
 2025 17:37:05 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::3e) by CH2PR17CA0003.outlook.office365.com
 (2603:10b6:610:53::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Mon,
 7 Apr 2025 17:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 7 Apr 2025 17:37:05 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Apr
 2025 12:37:01 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <Vasant.Hegde@amd.com>, Dheeraj Kumar Srivastava
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v5 5/8] iommu/amd: Add support for device id user input
Date: Mon, 7 Apr 2025 23:04:57 +0530
Message-ID: <20250407173500.1827-6-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|DS0PR12MB7928:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e564a7-b012-432b-a98c-08dd75fad07b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?geyT77MdOVbCju00lgeTjeWukMADcVaWg6Lwex+vbbnUYGAvCm+ac7u2gz5t?=
 =?us-ascii?Q?C80H89ko79+YhL58BFm8dsGchQwrk1ZpxVsOEbTrYFSP6M4edJNtyy+x7yRC?=
 =?us-ascii?Q?o+B54M80vx6U7V47CJmHwHmoBBL49gj/QiQrhasmYAYfq3SZOw97aVknKqIO?=
 =?us-ascii?Q?MFoUbiO99oBcQb7/obj4XP6gu4OeroFivEeAp2JoDUS5hLTfQMeErR9UzQMG?=
 =?us-ascii?Q?OZTeMKRW+sW2QSNn3zRbK0bzntz8pc7dps776x/Gzd3F3O5/egWs/p03OpWc?=
 =?us-ascii?Q?JRHOTO4n6N+W76KdqXgWCz7qzBcsckifR7a7nZe++CbnzUrXHq3g5mEKJNtD?=
 =?us-ascii?Q?7THrNZIAyWFGKmswv4RmoP7O45C1x1mQZmeP9uKIKx+5f6XS9fu5XFGptQth?=
 =?us-ascii?Q?JOpwIPMqVz9e9DLNpx3FpZb9KqXSRwNjhMWCLQErn9Ay8H60nsq3jkWmTFj2?=
 =?us-ascii?Q?xmTu9kyn8EqSlpzURXs8ApvPTZiVMAyqzvZJJ47UwPMTrmVgbMPY+B1pLnQw?=
 =?us-ascii?Q?+m3xbDEWQr6CdSnsRPvEKcwqzVMHqJNBCU75SjgVcO1/N3x+MT92Sv5TKl8X?=
 =?us-ascii?Q?qq88BFz2pJ32fV/TfU3sG0v4oohWhh3xqVX5rALgQaKIOurD6OdpCRcHYI6R?=
 =?us-ascii?Q?lSaGKoUADuB9LjTe7xdd0GuDgz+cWgsWOm0p5dwHY1kAHnairQ602dV8sxGx?=
 =?us-ascii?Q?wcIUeq6vy0Y7WjWns3RUaV3QrtjdSbMbM3W7j27xvr+LKnoPwuYSb78piH2N?=
 =?us-ascii?Q?QWYdOinEiRqoJAu4njhQw3ai9uWDTKjIQg44igHVbg/K888s+HIxTithZN1e?=
 =?us-ascii?Q?cLPMMbnhOtvxfCL7LAGC7dfBphjUXI6kkdrhp3eXfkx7pVVkiMJWWFGAjw/m?=
 =?us-ascii?Q?ODklef6lBKBn3DQIwCXF1/MasK+efulHn7EN+OCyCH22QxjPBCLwo8P8QQz3?=
 =?us-ascii?Q?grVakkKPzagqwlneJOxSfcgs7u9n0tluuyxCGaTsnjq5GKchXLRZcfxGW7p2?=
 =?us-ascii?Q?EtYsaACMmX3mXCJQDuCnNxRr0ZfkWeM+slC1R/SzUU6fd4aT+gFEpY8k7kGI?=
 =?us-ascii?Q?RE9DzEPvv78R7sPEPU1QOu/WBnXBcPgyUampo4au+qcPtqSRqJNzqmXD2R1k?=
 =?us-ascii?Q?7szQs7BatRJoUv4/lG8spaeYYPwpTRpkjCiE5KmFcZCXyk4HISD5yb/EAiq1?=
 =?us-ascii?Q?p5V8PALdumq9Gt86jXh99buaDkV9ghYaFaaMbZ49ovrfi/2XCiNvOaIUkDNk?=
 =?us-ascii?Q?p4tRYGJWhvqOknos8KYYdrZkoO266Ui6j+qKx85RhMeav/HxyQy0V4e+v5XD?=
 =?us-ascii?Q?QIPOUz8j7fY68b5XSmwjOU7Xc/VwAWa+4/Aea68Okjg6zUXCYxf9y1QeYNhs?=
 =?us-ascii?Q?aR8JX+6TqsmKI5S9HbgCR+7XszvAL83vmqiQiNpWSlu5Rea5gqgZoe3fw4wN?=
 =?us-ascii?Q?uHdLe56bWvTjrJ0matZhFSDSsjnY8ZBeH7SyZGDxtnFdPBMTpWEK1Nsfw1S+?=
 =?us-ascii?Q?/sfIoNjXmq3noDL/MQS359fs1FKKIjOCPm4G?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:37:05.5736
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e564a7-b012-432b-a98c-08dd75fad07b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7928

Dumping IOMMU data structures like device table, IRT, etc., for all devices
on the system will be a lot of data dumped in a file. Also, user may want
to dump and analyze these data structures just for one or few devices. So
dumping IOMMU data structures like device table, IRT etc for all devices
is not a good approach.

Add "device id" user input to be used for dumping IOMMU data structures
like device table, IRT etc in AMD IOMMU debugfs.

eg.
1. # echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

2. # echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 61fde9ebfcfa..5b474945aa0e 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -16,6 +16,9 @@ static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
 #define	OFS_IN_SZ	8
+#define	DEVID_IN_SZ	16
+
+static int sbdf = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -130,6 +133,80 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
 
+static ssize_t devid_write(struct file *filp, const char __user *ubuf,
+			   size_t cnt, loff_t *ppos)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+	int seg, bus, slot, func;
+	struct amd_iommu *iommu;
+	char *srcid_ptr;
+	u16 devid;
+	int i;
+
+	sbdf = -1;
+
+	if (cnt >= DEVID_IN_SZ)
+		return -EINVAL;
+
+	srcid_ptr = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(srcid_ptr))
+		return PTR_ERR(srcid_ptr);
+
+	i = sscanf(srcid_ptr, "%x:%x:%x.%x", &seg, &bus, &slot, &func);
+	if (i != 4) {
+		i = sscanf(srcid_ptr, "%x:%x.%x", &bus, &slot, &func);
+		if (i != 3) {
+			kfree(srcid_ptr);
+			return -EINVAL;
+		}
+		seg = 0;
+	}
+
+	devid = PCI_DEVID(bus, PCI_DEVFN(slot, func));
+
+	/* Check if user device id input is a valid input */
+	for_each_pci_segment(pci_seg) {
+		if (pci_seg->id != seg)
+			continue;
+		if (devid > pci_seg->last_bdf) {
+			kfree(srcid_ptr);
+			return -EINVAL;
+		}
+		iommu = pci_seg->rlookup_table[devid];
+		if (!iommu) {
+			kfree(srcid_ptr);
+			return -ENODEV;
+		}
+		break;
+	}
+
+	if (pci_seg->id != seg) {
+		kfree(srcid_ptr);
+		return -EINVAL;
+	}
+
+	sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
+
+	kfree(srcid_ptr);
+
+	return cnt;
+}
+
+static int devid_show(struct seq_file *m, void *unused)
+{
+	u16 devid;
+
+	if (sbdf >= 0) {
+		devid = PCI_SBDF_TO_DEVID(sbdf);
+		seq_printf(m, "%04x:%02x:%02x:%x\n", PCI_SBDF_TO_SEGID(sbdf),
+			   PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
+	} else
+		seq_puts(m, "No or Invalid input provided\n");
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(devid);
+
 void amd_iommu_debugfs_setup(void)
 {
 	struct amd_iommu *iommu;
@@ -151,4 +228,7 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

