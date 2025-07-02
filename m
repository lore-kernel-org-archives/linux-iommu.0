Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1993247297
	for <iommu@lists.linux.dev>; Wed,  2 Jul 2025 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449195; cv=fail; b=ihn9N5epiEnNGG5/S0PFHA5XbEG4ZG2rv8ooCAL4gy70sjXimaNf6jc/1EdRLZi4JGuXSSrrh1bFGZKZ3gXEmt9T8XKp3DlUS80xbJgFJTX8T41paHpTKVFFutkg2hBFO2kuJaNDaPrhj/3vGPKNoqya9ooUk4RDq+819x1qWts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449195; c=relaxed/simple;
	bh=1WPMB7LMk0kFyH6SxGtaYqfrS5+Y4s1gDOkgi1jTAss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ems32izL5MPM1MKyg3jPYRu7Zoem6oD6QkuVOrxLqenlCLzfyHedtXMlRmqh+NUrzMZYDXdBacbPu13/NxfnlWH45847One5u/EXsnaPDi/Nf/d2nJlCUGdCV9VIJr5wDllbl02ytGMikkTRLQdSJpx2ExZ6QgKZDsVfT7jK/7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ittI9HxK; arc=fail smtp.client-ip=40.107.93.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ittI9HxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrmiw/M2SYY7gn25yEmffUsAlbEkZJUfZ7Clos7r7KiSb5bsAnB02jPpL4n0ko/1Kk3av1VF+Idzi7AKlQvAsazWsREjsgTQr6F9zjoRDnkf6yJWw4nDtFD+jFY/fLo30tS7Qqm+SG0Clo4E+Dy6dRWs0bl4WNtEuWwsVtJiRpfbWdQ8YwresIWR8E3ss/qBE5roYtI4+EUhhkPAM6kBvFAK4zOaDEdUH1qPanwNGO8YeyBkrPDbNuvxaHSVAiy+pPntpOzwO8HxFZb8lJups5ntIxRAO3tuHx7bC30xqQ2lLCTYIYU6Q8jboHOo7NpQQJC1sDrpBDORWYixFq7i5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhM4eMZ9f/YKDhOKm+KaJd9WqQB/H1VcG+Sz/c0ki3c=;
 b=uhQlcal1wMnUsSNJ1CyXmSUMd7XdKrxpfj37fsB1WVy4JnYmVN3oxK2zaxiXGfRR+H0CFnctKHI6ByQVvKbcbKBXSVkW/Jamp4R2mraFN0JCWrvEUpnPKENWUSTjCg7F/7dI7UwvjLyyg+/6T2LCqC6Gzfj+NnzMMncVuXlcXX1qYc5cR38fCHVuWQpS/Ym4jWdGNpeQTv+DlasSoWhfKWZ1F3fP36g7/d1Xaqo+caaklAybtaO2cC3XyzjTANA+QOw9cGndUGiydxDahdIwmzRcfB3er6BrdmqelLWcoaCPV4xFNMqdcukSIClPct/YmHoOq9sdl1lPRdldNhE59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhM4eMZ9f/YKDhOKm+KaJd9WqQB/H1VcG+Sz/c0ki3c=;
 b=ittI9HxKifgkHa90e6tcf8BEW9FdPT5KQrl5mrF8FsmrcypyIG4ekNbQLYGViFiaUDrHDNFfsuxSzs2O+ucHM489tTfXNXO7M1SxofVRYpLwu6Yp13031iXzghSnaz2oBgXxMr4sBkfw/iNnf9EQMzaqZY03fRrW10bnSKNucZA=
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by SA5PPFF1E6547B5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 2 Jul
 2025 09:39:50 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::a1) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Wed,
 2 Jul 2025 09:39:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 2 Jul 2025 09:39:49 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 04:39:45 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>
CC: <dheerajkumar.srivastava@amd.com>
Subject: [PATCH v7 5/8] iommu/amd: Add support for device id user input
Date: Wed, 2 Jul 2025 15:08:01 +0530
Message-ID: <20250702093804.849-6-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SA5PPFF1E6547B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 4783f976-0abf-4c1f-53c3-08ddb94c63b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emqzZOFoF+djQaHljgiOrXAAuN3scx2QqCO3vLih619BVtHl4k1T3e9KDUX5?=
 =?us-ascii?Q?yHIpBX7G32OK2obWF2gPSYwVdEJoET8tKZlDmLQ3H4EcX2gEt8943Sttm2+O?=
 =?us-ascii?Q?WSzHVQQV7GaEjc72A96+Lr/R1jI7Mp0LgIuEm4lLjHKCbkr6N1NNjms8K9RN?=
 =?us-ascii?Q?9/OPpG5MfSIH+5JFu+pes8wTsGu+z5Ht8gdP+UxUff8dWo4TT6yLC3xHlVTX?=
 =?us-ascii?Q?hXXf0RRJS82fQoeWWTuaLVr0T2advn4BJv8TllaC/JOHm4E5dC07BCJQzsKm?=
 =?us-ascii?Q?OD23hcTeN+MbdDZcGNpurP1f3QaH8Kfno2vMXW3yEuBZnkhYpRHtuEvL8ti1?=
 =?us-ascii?Q?3aXfK1aQlnuN5OR2jy1AUdm5CN9zDnXMF3ps1a5CI2CW2V3BsRJxyprd30Fa?=
 =?us-ascii?Q?+0NoO/xHR2CgDpYSXrk7PKSOd5UE+m3AgoDppXplFZ1CuXxptaQT9Mo7PDDq?=
 =?us-ascii?Q?BeIiffCizq2kScXyfnmnaPps/21NlY4BdXmMBlcJ+Hxsn3rvwFFCQ8VgizQO?=
 =?us-ascii?Q?34gbGmIBM3dxRAknRqsQyLHtZQCzM11kLpOqqJPa+prnuhGR1L7d8h34EDEO?=
 =?us-ascii?Q?z7BanUDvIvv7rY8w6PpFp8T2c9ToVVBRHTOuZZGRQdDeivieos+T6DtH3oZq?=
 =?us-ascii?Q?/djeehfOddCSntv6YZQ2dSeDvTFtA/We+WL83D9sQFd6jaIKRSmjYDdRUYV2?=
 =?us-ascii?Q?LvbZ8Ma6W2vXgPu4RoYfbnJyN9cCTbOzMIx5zbXn3TBIU7HMasQzsBJi0VeA?=
 =?us-ascii?Q?5+eWKxspVEx51ISpz9c/WlZ4zKjhC4AV2EzMC0podnhG6ef6f5vNWSANteYD?=
 =?us-ascii?Q?BNhvjW0mmkCPJt33SrSjGGpKwHgz6lcTV62TVnPS6NNXbF1YLbNmljlueYoP?=
 =?us-ascii?Q?S9S7X7J9Bh9VBLH3FcldfwhbAZOZf06/U2f28FL0MrsD+qXzCch8x2lrGgZy?=
 =?us-ascii?Q?qIujzXrun9RKZVEZc0FWNXlSGDuYiSo+LqTbnxVrfhOP1DjeRHlk0R8u3VEA?=
 =?us-ascii?Q?EVTipNU/zBRt1LLp+DqxrBGXAtepOGjdSgeWIK7FisxfYidmDl3LUQYpQEk7?=
 =?us-ascii?Q?epvNSj358EAh7/FgKOifHOVNJPvGtswVBovmjWBV67adoQZvMDqVXx9nH/ET?=
 =?us-ascii?Q?AWnX2jbJ/ULH3Jl+hZXodLHZIxLjv1keSGdVAvgf/2u5TCBttsBaSURiB1DW?=
 =?us-ascii?Q?r5mo57op+5svcytfJPEpfriy6IKo9LAP49ehQA2aFUoKHjCsXDjt64t3IQsi?=
 =?us-ascii?Q?HtXqKoTUKk6F9wYuqAuJhDBqc3+yWldhkA5Z3pF3syMNqKAkevBGPt8GOs5R?=
 =?us-ascii?Q?pj/BN6LYnEQAV6KRNMkbH7jVaJkfFYcFlkJDB4gy0QJo4NeGkoKDyZZPPy90?=
 =?us-ascii?Q?AwGS0No5nHvEniNMtUrCwHxK4a1+p2GmLIpZjpVN6EejXNIPrrWGLhxr1Wnu?=
 =?us-ascii?Q?sKKYIWkhN77G7qPL7z4g1gz/p3vm4bIzwc+xCRR+H/UPD5jN+MKnsHeamoNf?=
 =?us-ascii?Q?UNG/W2MHEfXx8yho/HjxxQSYekOtDJfgC0Kq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:39:49.7084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4783f976-0abf-4c1f-53c3-08ddb94c63b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF1E6547B5

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
index e78f6b217a7b..065b150bba15 100644
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
@@ -131,6 +134,80 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
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
+		seq_printf(m, "%04x:%02x:%02x.%x\n", PCI_SBDF_TO_SEGID(sbdf),
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
@@ -152,4 +229,7 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

