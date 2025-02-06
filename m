Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A709A481DD
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821766; cv=fail; b=qd+cysPNZGINWqqWzfc4D0PWiGxXp4pw5fvE7JGkAPfY3Xv45Dq9TYnj1QuYSgcWq0RV6lyLEZ/HKXTARkAioq+jnWmtVGIcJt7jtvD0T/Ofe7T2SS9BahjFCfso1tV2ac9lvMf7b45wtt8RBOqQSzrXNp+PX/tbw8TZptfUH48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821766; c=relaxed/simple;
	bh=H1+UHwAmoiKlWFHZWhCHuYeSoSOF3Ai5vtefPPQ8XrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD5HIpDEjyCgeV4hW9CtPcE0+qtqOnnAIzNUL7vgQnawM+SWVCNodb3XRttH/aqGGSpO/bE/1pXj/GcX9vTFjx3gwY7X3tEbQVSwwbQDMUjoeHfwtNy8Uo07k0PD1YwWv6m4pSr2jmMJDCtEkyQwwqkiEl+Rvd6ZaZoGZQZtQ0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dx9pbTcy; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dx9pbTcy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFqc+y9C1RdtOkK8WipBbiYqWJIYzDqv7weqbKGc2jtYIZPvPczvs6InHV0z0hYMp9zqxiCRWbgvYoHCRsOygij9zUpSKrWL3Wus7RtkTRnriqbvtLHMrZnW2Z1wLM+uRh+5BzFAmOEgongm3p16/TaVa81Ia9reWXUkw7urLVrobW5KXgBQMD3p7iKWd9wcMMHelzJzmKOw0KwiytIZkFew5vKgm4MVPYvxoko+hb5Ky39JfbA+6QMiNwvp8dQgEl5wTilf9t9dMDdDCcQ4wJzNAhwguPvf+8NfOeguU/XskyM8RMve7C9SY4+cwq6GvybAyF9My6CFOIu7SoQCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+YOFO0IJJM2pxHYcfVjQS/kfQtiqPwowPEFuW/++BU=;
 b=zIBjV+2sHKKcNMo4HSFQV24Fe02yOtvpZUL2nkIJFoRWDkTYbiG2SLBE1Z1UH2hdcKwnGVcUfCvXV/3fdHLhbBAlMnw5VV7/KBQcOoBV6fR/iWy2jehAM3eQcPBXpXujT33qLwiqYVU77ZQH25Hzyt/47SW1khvqI/oMIKP918KT2hbByi39bQnl/5cWlotGD4p938K7djPu7GcBrWdp8rbwCO1A5A/Ioh157TTAe4r7l75AF7XFYnYpGYNZdrNLaEaawJYQJNKUC/U0N8/tpIJotDceoTYiflwxCc58psXUPoW0xaXJ+qZoq5undmS5CjQ231M3s3OTnoCu/BY2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+YOFO0IJJM2pxHYcfVjQS/kfQtiqPwowPEFuW/++BU=;
 b=dx9pbTcyc0FOtXR7kyZfkfweM6LI+gGJc1KfOMORkdCR0/QOP2zkKrk6srUKsDIL1jDr0rXIp3bFZT4iIdH4lTKgR5LNk0twxgY/Uiw9A5/IvN3N1sm1nwfrZyoTcjZS1EO3wB29mHXfJSIJdS+L32zpVaTEQijpXx9Z7I5dFHU=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Thu, 6 Feb
 2025 06:02:41 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::89) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Thu,
 6 Feb 2025 06:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:02:41 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:02:10 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 6/8] iommu/amd: Add debugfs support to dump device table
Date: Thu, 6 Feb 2025 11:30:01 +0530
Message-ID: <20250206060003.685-7-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 374a917d-6740-4ed7-9d17-08dd4673ddac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ePXIF/xHrpmf1MlT85Q8aDE+bIqKPwYfAuEdJ9Z26zBv2CR0NBQ+9z68YaTv?=
 =?us-ascii?Q?VYVMjXNnMVnpDHBb3pbax9vc1rKCikgJZO3BRB3IhtSXtqT9e8CGWfPQUPBb?=
 =?us-ascii?Q?/GjQTr2grYrtDyHWRKXN30iG9ca3F0A44/1j0z4m828Aoj3dBtlu/lrnLHxx?=
 =?us-ascii?Q?CC3Ya0jGLXX4U070fHWnJIbgO22Y84KNRo00MgmVhjG+CDELOAWmMl7AjiVP?=
 =?us-ascii?Q?tLcY83IKafJtanCC3OZPlCkLelFRrdlhknkWZWp4GouGE+IKeGvF0eGqqFol?=
 =?us-ascii?Q?Y7kwoXgCu6GTTLTjNxno2PZvYKpAvHfP58xndy2Mxp4YHDXkjY9p57mbyQGo?=
 =?us-ascii?Q?zzMO9fzqLAYZzgGPhd/RKUEOsNB3X6ZPHUnmbyihp4CgzPWjgBWpIZggGyD/?=
 =?us-ascii?Q?vBD9B15QVsbzVNw67YZ4VAHEpHU8gkQqAKblLwZH3ItD3/mSLxzSgfyc7aXZ?=
 =?us-ascii?Q?fdxzwJ4AvIr3ndaNWPb/movosejbOdI+wsA6nv834VLgpPxCV1grgL//+62Y?=
 =?us-ascii?Q?6PP5a04BC4gc6CioMyXzJ3n8DRKGrxD4pN0kght4jZ5sJeWBXBdUuHtfelpg?=
 =?us-ascii?Q?vNm4/M+0jv31tj7pa2UJOw60TVqGQ79AAw+GsyU+1EBbwAyBGJBbKtARlhjQ?=
 =?us-ascii?Q?hV3BiXZL1Z0czmlxXXTLCcIbUCe4IjSxDc2vKSRXgWGESlr+HYFVzlGcHq82?=
 =?us-ascii?Q?iof7wDfzRnXPVi7GDhxhPbE4BcXm6qj2xafQBB7NLdijKcJM719rkygb55MK?=
 =?us-ascii?Q?fqytwlN1s4J5c8hSC3J/Bw35Dkf88BxEv4IRh2I8JbZ+c05VauiHI6o7IdQM?=
 =?us-ascii?Q?g/esjZAqX2u0Igpl06HDhaxMtHejBS1nBoTvxnjRgA8Et3ahjOu4Akams/bv?=
 =?us-ascii?Q?MnNZN7HWFb3d6PCLs7nG4HECjbPwBycGhLiK4yKJbYuQt9CtM5C8Nys9YhDA?=
 =?us-ascii?Q?q8Z2TldjoBT3QBlMzgZ/jbHMsLA+x39ec8KwkT8gBVqCW2sHC0TUqoVVRgie?=
 =?us-ascii?Q?qJKhzoSTbD3wHp0hJXVLVjMTfNPuO7I/NnsWLt1nQ/IJ8zcGIb6KndDeUWTM?=
 =?us-ascii?Q?vXR7H8bxXDsDaSV6Gv8X3rM0TQPrKtm/1hN//UfZ7vvIQaXkSxUQWI6tjHyI?=
 =?us-ascii?Q?R8kdJ54soi62HJhk6VVBC0di3T2HZWba+rGHY0BCnOaY/0VBwxKDv6rz0f64?=
 =?us-ascii?Q?OazpfyiocjPP3AcEdPOgKBIuGjA0QeF8rXlv1EsXnrvZA5h5An+G+Czjf6Rc?=
 =?us-ascii?Q?ChADQC1k+betIegI417URoLu8+pgwD/l4lhhM2itSrQK8vfZ0APHZwLriDb1?=
 =?us-ascii?Q?sDC4Zk9i+uROZ/D2TaprWgXOmS+5/+zU2lon4Zl2T8zIVStfhuU1cESTHejy?=
 =?us-ascii?Q?Gno1Rc7BKV7Wt5e5b5eMNxKXw42MbcO2G2cJqQ8gRcLQFAQd82HxTVfS7jeK?=
 =?us-ascii?Q?ewBw697JjvROVjKsp+WCdE96IBI9q5XfLm0Mvt9xlmOU7s/l1TEYO8kPnDSj?=
 =?us-ascii?Q?YpgiYaeLtVBfjzM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:02:41.0113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374a917d-6740-4ed7-9d17-08dd4673ddac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

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
index f292b93f9318..1377795814d1 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -203,6 +203,53 @@ static int devid_show(struct seq_file *m, void *unused)
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
@@ -223,4 +270,6 @@ void amd_iommu_debugfs_setup(void)
 	}
 	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
 			    &devid_fops);
+	debugfs_create_file("devtbl", 0444, amd_iommu_debugfs, NULL,
+			    &iommu_devtbl_fops);
 }
-- 
2.25.1

