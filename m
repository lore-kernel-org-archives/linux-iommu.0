Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748F523957D
	for <iommu@lists.linux.dev>; Mon, 17 Mar 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742212867; cv=fail; b=rpv35tQz/yiW4iWqglgx/H34Wy0Q7gTaOWyXgClU2v/9XboQh1cSCG7iLX+mdMjpDioLAMNtr6Q81Z4shJfo5nSAmwgbFkeSv5FSqCUeEU+X7N0Ak11+X9ZxDECPL1gqFYIudsrEmsv9lNDRy0mg33eX1pxWwNKJJxlUP9rJKXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742212867; c=relaxed/simple;
	bh=gT1mY+bhoxftH4E/xcFmAnhuE19b4bzQGfGg5gqavWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqBTKRfausVMhVUJx+epfJtskcRQwDxrn3h4ko4cTDl2hWMlHtp1eY7r8TdNoHFzzTIH4aZDWLhFowlyzgkaRS2GDGrO7RP+mCh7IK9bPH0yxBN/9X6eNWC/iPBAdK0Rhb+OFQMkYGvVGKWKpQcVJFYuedQg4/JlqljAGZtvh3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QCqPcVhh; arc=fail smtp.client-ip=40.107.100.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QCqPcVhh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfD3CRol9KsP1P/CCvS8iSC1VFJg8AcQq7Hfk04wnq9eOi5Q58KQxsE+ksAtdZ6YPTWYCE9gltg/z3wG636x3DXXQxu01hQGtHmOE0Re49rZNHOwlt/fjPmGfr+pqXUPP8HwWSl/pi/lZE/PNpxAuTTKXg6koG9l3LTGphT2gbRzDPMuxf6uTrbpH1/rsvLOAPPkM0YyKeM6Dfm0oDXoQiqGvqcLRsC8PCH7+fqK03CygoJcp81nwCaVovn8dIS/NrsvU1cj+SMmiPYAeZTncBKwYejnG5nw8JJBbIWywyuT9C/UJiL/TiGQJ94J2pmW4sqlO+hHsfluvTrWtZy72Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ciu51LbvC71e3bxSv88ZtfZHXvaDj/euvivOp2Tx7mM=;
 b=fu/5EXoYzfROW6xVE0LjqdVqDX88oBUwXCBDj1I8yHPrSW56gbysmjgYLQsvvyRznHQrTvYxDGgqU2pT4nrioZw3WepLP17UwtYpg3+YbuOUqjtnRiba33G0Ku6wPAMDGv50YGJn4bfgGsAMmnjcj9y3AnqhU/C2/gaIbz5tQXvPM8Ffxpe9jWKJqh+jQKpwFWbyltXzeYAlmq4Qw2pMQZIoRfPoFCSQ5gjiPYBOTZlo1Kjjn4ZNfIfKnOq6Vtv4tJPdKhD/y84t+NFpFKY0EMzYm85dNwuJBruuvEZN5uOGtXttUlFya77TpgyISjtHLkDOdKB6+AQpGZg5iSIQ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ciu51LbvC71e3bxSv88ZtfZHXvaDj/euvivOp2Tx7mM=;
 b=QCqPcVhh+FdfconW1GFwIMnv0fLMyw46maFMZ7WNQdXZ5Lu3CfWcsNLSntvjAXAUrLxHdn6kXAFM/qcDXET1GVz1VvIXCPpZ7T99gRRVw/CZMBVERJvp6jNT91fH4IVS4CkSWd28PEdhwSRaxwyN4kRVhbYMaFaiNcIC5vVfxxU=
Received: from BYAPR11CA0097.namprd11.prod.outlook.com (2603:10b6:a03:f4::38)
 by DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 12:00:59 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::99) by BYAPR11CA0097.outlook.office365.com
 (2603:10b6:a03:f4::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Mon,
 17 Mar 2025 12:00:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 12:00:58 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Mar
 2025 07:00:54 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, "Dheeraj Kumar
 Srivastava" <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v4 6/8] iommu/amd: Add debugfs support to dump device table
Date: Mon, 17 Mar 2025 17:28:28 +0530
Message-ID: <20250317115830.3416-7-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS7PR12MB5741:EE_
X-MS-Office365-Filtering-Correlation-Id: 05060a0d-a99b-4207-e39e-08dd654b614b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bLHS8uTs9qW1aYAVxLoIBS3VDDMEyM95XWOlNYOuey8Xcg3U8BStH5N1Hwos?=
 =?us-ascii?Q?+c6hea2NAEq05Qb9uE+tt12OqpeyXBwmsqKXIJfZh81jvWPfiOiAe+FApBDr?=
 =?us-ascii?Q?VSL+6OsA7kyUYuMpG4qvddwoWVisil2onrRz7B3gu2sZm2pn2LMKex4cqDeI?=
 =?us-ascii?Q?gfdGzyclBGh4JR10z+6rj/Yc38L5Uucy/MVS6BYDmAUfvHOJRrthK2/iTn0e?=
 =?us-ascii?Q?MXa/L+ICp6nmZquZ/SNPqC3CKDWLKlzm4u+yQZm2tcGADOOyJjUQsR4n0LKL?=
 =?us-ascii?Q?baWvxqB8ionvRZjcfM0iLZtUzJKy/W2tkZ027uGc3WuvqP5naXQH/Gk5ifRv?=
 =?us-ascii?Q?YQ+uT8JBTz1MwS502eRlsIHRZkk024baB3C4XgXkgxH/W7whckN0r0ShmHMs?=
 =?us-ascii?Q?bpo9CDq2t+maE27pn/mM8ieaAhSoyyLM4jghXENo1htYseQJBUwth0V4XL4y?=
 =?us-ascii?Q?4zITvvi9bxDmRY2zKKli/vQDBU0W1UCi6quGbb5ZZxW6vfWKHjHOf2gbp82o?=
 =?us-ascii?Q?i981l12GsEBOsAE1ai877LuJ65FBRM5d+FYFNOgN+m83DxzFIqpgxkG9TOHl?=
 =?us-ascii?Q?85VeK1XAIpGyUvpTpgsxZiohoL1aki6vlLLdChSUCQiYFSgLv8qbwV0LKRQx?=
 =?us-ascii?Q?bgRGQZas2LXE38jvNXlRa0YOFn518y29qyiEBTL3YGUdgh6Z3TG67W8r3FNl?=
 =?us-ascii?Q?DevPN7DpWGtZvrUwcbATIBvw2vpjo6LnfpzercgKtMHcbTqJSO3zKk1UOiM0?=
 =?us-ascii?Q?qGU/kX0v4RkMSoS8TYo1aPwlRIq+EXeAPgkmxm6oB96Tvhd+zHEUTrB5K2Mq?=
 =?us-ascii?Q?9/KzQOs1ZzH8uTrwn6aXo053YdAAtzHNocYLPxQRqxddJINbwHEEP4ha9d8/?=
 =?us-ascii?Q?KpEY6ERD7TQy/znl3EVk66tdq/5xuNX/CcRAN92TdBMJwK9lC6WeLNOqFI3R?=
 =?us-ascii?Q?IQXgF2G6+8RoJ0Cw4gEoCHLbVXcLcHk9vugf3bP6GN6xWOemeEMMM0DUQQjR?=
 =?us-ascii?Q?NTJE0i2lWK4l7CaEqPorsBQ3ocZtLKrDqGQHquKglbU3t90T7ybe0kNu6blb?=
 =?us-ascii?Q?8Z6Br+nbf4EWFphYrz10kiTsO7h4bCA5J/Swqf/e2LVF3KOKeHRIUmgxF/cV?=
 =?us-ascii?Q?ACCKchSAFMQblqvsOfhWzdNgn4cKYK7xpD16TEzcfnHxt7bWiDE4CLAj6opH?=
 =?us-ascii?Q?Ik+jqnJbSfqESyrWZwjXaYwNgIgxdythoBmm7VRZTle+AZIhdOHwvqg92/gq?=
 =?us-ascii?Q?hr7/EJa/Evm2GK74twnrvJw2AhoZsMKe98mHSry0wUoc3c+iV0iVLQjM/KOJ?=
 =?us-ascii?Q?8iMb1pWnJoEVKaH1ocEQuMgxCyuhlWxmr9slpBzKrzd+xAAv+G/q0gNDcHyH?=
 =?us-ascii?Q?bg0Fc/m5U7qIVQPR7ZmG/oFvjfezGPiclI1LDAjkO5SWECAHEfEICZQhBYFz?=
 =?us-ascii?Q?pP9npXpGMHNHv5xyBsmAEgENTza9XPIkla7k3a6jCtf4c+eNTXvtO4CEwYEJ?=
 =?us-ascii?Q?VNS3CM756c82uVc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 12:00:58.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05060a0d-a99b-4207-e39e-08dd654b614b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5741

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
index de030801e236..4ea50e5625fa 100644
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
@@ -227,4 +274,6 @@ void amd_iommu_debugfs_setup(void)
 	}
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

