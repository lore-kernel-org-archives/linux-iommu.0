Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A981DE889
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055142; cv=fail; b=g3kAj1y8N1vDyV/5mHX4kz8zs1JqMvofwhI3Vqohg84rMjFZz0WLaNkkiSbne+JrNIs+KyJfe7+KZU0RaInSIfnHFm6XvzHUatfxMIn5WhDIiENnFja/X135G2CrZQYPuNlQjK3hLPTjDlUime4shZrWOxwC34YPiA/kkKl7qjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055142; c=relaxed/simple;
	bh=pdxaG6WNxVTSVRGxvLjrkoeOLxNURNPsBx7Gy8QmDQM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qrab8Dn1xadDYzyUlg1auEudoPnrNtz0IdyeS/4a+zhaQdPSfby4AfRcEHbbhmw8X1+LJTdG/vvFIMNZP3Q9FpAzOupTX2VX37hsbrIcc6RtNLoOLD5pzmKmgbCZpPfyzPjmJsLnqihdsXoDnRJt4KvK83Mbr1oq1C2UBxkq6mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qCbb7Tes; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qCbb7Tes"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QBmZm6ye6Gl+911aGJC8oVZuJGLRaZXDmRQuK/d3lJRYaYvNGtyGAETTBG53fqVeTqmrArLsf1j1SX+J19PisGGZOW15S7oiPzkNQlSJ4Fe5Y/nO1PpL2CalH1sWvQDqVOua+3ytJQmTZOVIJPMbbYiaTchFxqkFzGBwD/jIVdrQQCHipX7zmMnwjQPohOlatPCAWBbFHCwOOjuy1axcXjC+7LDsN2G56bzLX7yG5wdVLdi3PaUKN3CI6a94pZXukEEr++mH5AgRtW40dhQMLdWcdsiTQnq+Duh024wZCFxibt62R2s6Ml1xB/+vmGGrKuc17sukZ/5Jau0/juizgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aft8R2XJZrN/Vig+tFYoNFWGv3qJYhRLGJFn3V62ZdI=;
 b=ScoruPvNrwExJpa2LaEQYPEeYR2WxYXqqFDUArUHxo59yArEMXB8L/b73LQBL12Kab5CeJZR/A0pzxlNxh9/IKls1byM5yMWDFLFx3FwPTa1P/3X/YBNv8PBKPgcq8mzCDiKmMWvL3isGiVSpXbBi7Wj7O5d+SSeGXnLEc/iFQdhkBt/wkSOMCKLXKwZbF10ESYba3y3x9ecwgXS3m5jhcOXALenlte2asMvrpDREgWOSUIF4vOSyeSKbkfLtsPSh6lGwtM+3M50bgxGzMJD4/3/hj4s6OteDIaLn3CxcWAziOQWEulhLEnmQtaUQ2UK47yiH23gmpcG0iGU2JUZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aft8R2XJZrN/Vig+tFYoNFWGv3qJYhRLGJFn3V62ZdI=;
 b=qCbb7Tesm7v1PLZwQphOIGPs/UST0JoWPTLika5VXMvD6m9pvkt3htDLdmrvvKfU+RqVGwQYsVkOKnPP1Dx7/IgkjEHtNeEk555fRKDDtU6BkLGMeN8yUuHBHDqENnRNForZV0w+1Rhe7Jjhcbz+sj4oDTUibOkp1Eee4cMjR0g=
Received: from BY3PR10CA0028.namprd10.prod.outlook.com (2603:10b6:a03:255::33)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.33; Wed, 4 Jun 2025 16:38:56 +0000
Received: from CO1PEPF000075F3.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::2f) by BY3PR10CA0028.outlook.office365.com
 (2603:10b6:a03:255::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 16:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F3.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:38:56 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:38:52 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 6/8] iommu/amd: Add debugfs support to dump device table
Date: Wed, 4 Jun 2025 22:06:45 +0530
Message-ID: <20250604163647.1439-7-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F3:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f0f5e6-6036-4275-5610-08dda3864ca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ik9xrM0j5tV5R4gf16Gn95Rld7Hgcxyox2YLH2FlfeCSs5ymlJ4RojhNe7Ke?=
 =?us-ascii?Q?F9VnfEsk9maZiburvarWwNFGRl4M2dSC0uonkZcCSCo941V/hT3R8OWydgHS?=
 =?us-ascii?Q?Z3zG3TTvbso5yzQCTOO600uPPMxOfxg8gzbJlHU7m9EEIE1xVMR4KOgt7L++?=
 =?us-ascii?Q?q7KPdIsGCMLfll1QJtq85J30x4up1QXXFBMKcoZN8B3BRp6lftq7glUX9yPs?=
 =?us-ascii?Q?57JE7souwoz7rcgTrNQ/HqJyIxKxsFAIt7SHgmBwMLvsJ7GZoMwDYVPGPeR2?=
 =?us-ascii?Q?+Hw/8cmyKIHIK/yNYAlzBoX9vA3FQ2/uvzbGKhQhW2yk/QLj7CrM5RXFA2Jx?=
 =?us-ascii?Q?ICrDKWjjSzh4kMcm/P0UTKrxPlYprPIcrwiFw0Yy3bkAP0LuW74e5Em6nqLP?=
 =?us-ascii?Q?nlXGMUF9c/qbNMJ/Rh1fy6wiZGUyJj3Qvp6BWj17fLb7XngDYlz8zj7q5gvh?=
 =?us-ascii?Q?Z1fR/AffHCHJuxetBmN9SicdfBb6AMB4LBWjvpbI+GPZsqaWFx93sqUYVFML?=
 =?us-ascii?Q?KV8uXjqfMxhxhye3KxF/Ms+9vbOjkOXhuADIp7U6fijAKiWUR+JWbbOF9No2?=
 =?us-ascii?Q?WoDlCinHK11pBAXAa8ODUqt/T/FcmyXH7cphk+hkCqSZvjvY3QTf32xyMwpQ?=
 =?us-ascii?Q?LMjwq7lj0bliTYgeg3ozwcErn9xEEfaIc42ErAOPgQE9H/eAd6VBEgCzfULU?=
 =?us-ascii?Q?RltCk4XDh9tYERG7tOCFmgIT1rwvdOEzCuhG0t2lMakYbEUGZIvVBXwkByN5?=
 =?us-ascii?Q?sToKM9OS+CJFqTd/OUpKzbBtBYII76cUc/ECzut/RIoU30shvKe4Dnw0D/O1?=
 =?us-ascii?Q?5CU9njsZKXhvcvI1KtTrL0oeOxFDrLCjcEtpD0GVBLnbB4BXXUqHuL8LzT1Y?=
 =?us-ascii?Q?CDRVYs7CzoRf2dmKVrZJ9O4Hc54NX1qGPu8WsLtxUbUXIQJdKKjD0Z5D2XB3?=
 =?us-ascii?Q?boG+v5/nD8uLAyR+6iBsGigf/Eps4H8PLjYJBywpIXqFcNelnZNSIz6S9vmO?=
 =?us-ascii?Q?SENooHptPkF7dt6cHnLPxYAl4/s3twZs5E3hSZK4EyfFS61mK0KmR45uyy+D?=
 =?us-ascii?Q?JSZ5M8B5JrlcLsGAQdONh8f6UI9S5biG1Y6ZpYNXqu8Qy+PcrcZ070kE7STv?=
 =?us-ascii?Q?2I025tcIqaZYJ8o+ANoWm5aVjI/Rg3wr4JJ1j9NVHCqLRR3+hOzaVpvqx8pV?=
 =?us-ascii?Q?7Sa0fPnCFlaXcdWuYzEJ6lVPVVVzbSCwXRAu1foXuXIiH6yxyfPWZnaa0M12?=
 =?us-ascii?Q?C7TVKlIUMt+Gt1slH48XKjuo/P7U96M74YlK+CbWCzjrd2ctW4dD/4KDIqD5?=
 =?us-ascii?Q?+wYxX4GpLGFJ/ib4R5YMvc0djAUqJWgK7Wghh4TQyDC4AF4/beNqWlrLhvm8?=
 =?us-ascii?Q?q4crgZ0TcoQiu/J+L6IXqAZuD2uH0pUADxDrCUjKNRxKHiY6vuaZY7+LTa7r?=
 =?us-ascii?Q?TXwuPpR5AJOUxFhOQKQW/bdXZbVT1Oj9AgaM0GpnlV/HnHnpAd5fWnvYHU84?=
 =?us-ascii?Q?iD5Ja/rwduIwos0ovLMVCrSrkFA9OM0i9lnV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:38:56.2005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f0f5e6-6036-4275-5610-08dda3864ca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910

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
index 8b57ab4ab809..38d3cab5fd8d 100644
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
+	seq_printf(m, "%04x:%02x:%02x.%x ", pci_seg->id, PCI_BUS_NUM(devid),
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

