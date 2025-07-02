Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07AF24888F
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449212; cv=fail; b=tVd8aBj/GGjtFPngj/sLKrnIcYXFC2/zN/vN6JWCwhZ3sL+Lsoz2qB1wuKXP4R6JDgpsuuw6muA83i5FOCLjAZSMqWvfiRA/hOUGorHwWnPio48ZoLblaycRmIVTLJXpB7JjR3+izI+vijnkAzpsMzL35OP/H64CChuTT6nEF88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449212; c=relaxed/simple;
	bh=RdtYvz9pPTonZ5I1AMDt1i2KfMemwjq+v2B2ImEL2es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQ7DlUq1hF1jKJykULxMqEW/Fogn3h9QRvNoGNxiJr9KmXCxt+3JGgXoKN8bEVW83KtTGna7yg1cP5vvmNEUSoCUsWNzIiw1EjD3THU3wvYAkFyhnTrVpQ+vTygGSL56ebd9mVPY30d1PX5NuX+lVPmnnhceWfv+QqEzz12twOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrgcPzks; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wrgcPzks"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDw/O0uxeyoeCzqqGHt+figSyObyOluuIWJB1e/HyJnX+EOzkPoJ3ZN5kzuMBebBZpeaL/FVKXpNnai/8W+dtRQnw3bbucXsrg88eloxurvlwBHT+oeFbusbjr1zCjPBCyT+ycaKtuW+W2GURPd5G+8NtGKTJvCWUW01dekyZtdzm5rVLxtpTJUoxwE5yD2f//G/wbOGhix/RJkYK2sj9WlO+Q37geJimLXG0AiD3sdYgUp61tAGw4nJf/FxT4TrRr/04dlUxyEMiQM5knfkYr2e3zccwu1iKqtB4QpiL58+RVzYJgG8pkA1SVqIuB23v2uFbi74SDA3G4e9nPkmig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWzxPBQ4zynQzoEzkb0ulLEZlP4hyoDtdAK4JqAMPc8=;
 b=Q7A41ZP6XKZZpFc+1jNJ0RtEWevOIQRd8hK3k/pyk9TokuCzQnKi0s+3Sf79jtcGvrF9UMbNWGfSHG8o9tBP3LBOFlvEWCD+hBBc0VVmkNCvYAaRFWRBt04fsRVNMWnqEUzS1qN5EjSYPkILuZtqRI746vK6oq3t9+YqCRcaSx/jmRGS1y1FIH6hy0NjAjawEs/YPGcwE/eDCyD4xE4cezCafEyYmHF2CZL65n5ZgPImOb/afbpnm+NIoLcMzJ1gl2BoE3Z7pqeBEbD18Co1+SaCP0nek3DjuhLVWaEaXfRKPoj8VcW1RLCU9e1xIf//1ycokJiXzQhThAiI8AWm/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWzxPBQ4zynQzoEzkb0ulLEZlP4hyoDtdAK4JqAMPc8=;
 b=wrgcPzksJkqVae9KAsuOtjPEYUWCpjLKrK7v1PiDhWhu5Byh5F2lmiBaX5ojN8FRSEr2XsYkcaSSywVfB62CGF+mVku0DqPGjn1IU2wCUnHFtGf5pxhAtxT+m4E/vDLMbMts1Iv7YlSDSzCz1kHzTDrMlMJWjqPYkLOyTJqzl/U=
Received: from CH0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::18)
 by DS0PR12MB7770.namprd12.prod.outlook.com (2603:10b6:8:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Wed, 2 Jul
 2025 09:40:06 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::11) by CH0P221CA0016.outlook.office365.com
 (2603:10b6:610:11c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 09:40:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Wed, 2 Jul 2025 09:40:06 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:40:02 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 6/8] iommu/amd: Add debugfs support to dump device table
Date: Wed, 2 Jul 2025 15:08:02 +0530
Message-ID: <20250702093804.849-7-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
References: <20250702093804.849-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|DS0PR12MB7770:EE_
X-MS-Office365-Filtering-Correlation-Id: 3435acf8-2d1f-465c-1fb3-08ddb94c6db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?amxHwDDcSPhYsTk1OWYl/uedlIfWkMz1YSZP/RrXg/60YDr7tI3sd/RfMR58?=
 =?us-ascii?Q?lDEVsbsQVdsYhVhDmmnjxgCxVwqqpk6EqeBSo0wzGUrKEVrxeC6iPoWV0Ps6?=
 =?us-ascii?Q?1+A5K45DkKCcKZMgMUDHibtQz/tJS3XZZP2PWptHs5fCBU/zHomvI2aBCHK6?=
 =?us-ascii?Q?roYh/srdnu4iNPmA6k6j7VEFr2NMscChHvbNIi65GG9zHUIvuOCQvDBmP9NB?=
 =?us-ascii?Q?D8hPXrUaST3TasvxsGatIs69a2fZn68xOII3nQg/e7HYkg8ylh7JMbxCBTdM?=
 =?us-ascii?Q?5PhvwK73ncPGCme7kDCge/6FhkJlhyZxELTPSgX5mGYM0xyLQRJTuDOTTAz9?=
 =?us-ascii?Q?xoqBl/dP3T+yxx/5ucHGQTReu+JqBsKNBCo6s1M6B5LjVQkVFLwE0ir1B5xs?=
 =?us-ascii?Q?lLT74zXRAyUn+f0ryia7w1zU/k1sR/cxumXN2cxTc2vIypR7knE6nxR04+wW?=
 =?us-ascii?Q?nT/MuWFdgstZ5RMOabK1oGWGWKQHDvtmh6d+3FTL/jx5Nwk8EIFP1UUXOYB2?=
 =?us-ascii?Q?OdLB+3SmpkNExqmREUgENQhSyX4PhXJJnz+D5wDPTw4tGQXaCUPkrhfXOulx?=
 =?us-ascii?Q?D/3kRLSjb/E7i+Dl8zwedZQTVmKUbtgB4c/Vfs34QvMIhFuBmn0buyQ1A7Cb?=
 =?us-ascii?Q?xp4UGvtIreAJLA5oM1Ixn+WP7JyBzt8RxQkr/ITOU5VuEVyozcJd5UoxeWM3?=
 =?us-ascii?Q?KSDZVNA8ql5a/I6pGJ2DJq7De4ZkwiPIAr6ecCr1KmNd8Nrb6AO+FsUMSt8A?=
 =?us-ascii?Q?lvJrW178cmXTVSzjMHy4dOSYlDQjDZNq2KdTdnX4aitRwuwn7IrRNVC/0Tfx?=
 =?us-ascii?Q?GGe8anMFnFXnU8iANqt+QoAUX3uHhKeo9T96QFsRoKPDaxQ4ojJFZCEIpT1V?=
 =?us-ascii?Q?N2HjPGwadad+iCxBPrXl4No8pB+326CY4w2rAnSKb2QTYBWEvsl+cEsEOy4d?=
 =?us-ascii?Q?PRjYmvyRXg9JHNKSeYJ+xEsLXSm4IuDoP96mYRMwbb6KZdG2ad5PwZMncob1?=
 =?us-ascii?Q?d5Z1vbC7TB1OXjYAmUw8VV29YzIFvJbgb62Ouvjx9ZiPn1i7qbwXLt1zzrvc?=
 =?us-ascii?Q?XSJtpeFmfWxffQSuAAVqXLYA76/A/wa3QrGAqHBqUBn9/FmvtD2GKs1KgVSf?=
 =?us-ascii?Q?VqexZQWkiIEmRE3KQCr3PCrayG1mg8PQB7wl2+nIaorfgwb8AVSbNSJvWWrI?=
 =?us-ascii?Q?cxpBL3upIC9k7qG3hyeSQ3aEMS+xrsbdox+1Xr0JDHDr54p4iM4+e22Ign6k?=
 =?us-ascii?Q?cgTbJ7myGM+mzZ8IjxcRTW70soK1jXDZAFxyZX3V3/NzVHh0Ka9tYCenh8NO?=
 =?us-ascii?Q?tZFiizMA9YUO1Zsxb0sQNauB6atswU6GZu8R5AkgNPHTN+qB1Oa+nIxBGJR7?=
 =?us-ascii?Q?uoDn2jzO5OH6MHCbz5f0chRbnxA1lhhlYByDw/iMsqyacArOFAd6fRO4JIaL?=
 =?us-ascii?Q?+pB0mWfyiANkkIxwnFpnJXzTjz+4HB5W721thfkoaBhfoqcsZXWv61l58xRG?=
 =?us-ascii?Q?GTZxoGIVxg8ZoPwFiKBpazqu1WZJL7oerSmX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:40:06.4964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3435acf8-2d1f-465c-1fb3-08ddb94c6db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7770

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
index 065b150bba15..b01eea2fbe03 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -208,6 +208,53 @@ static int devid_show(struct seq_file *m, void *unused)
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
+		seq_puts(m, "Enter a valid device ID to 'devid' file\n");
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
@@ -232,4 +279,6 @@ void amd_iommu_debugfs_setup(void)
 
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

