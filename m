Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A50157A46
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738821720; cv=fail; b=thilluRshvh+bdu9figF9yrP/sJlB2Dg+EDHZDS6no370h2ge83jnSfIER7y7oKC4UABQB6sPIyrE9Kj6aqlO6Z4lT9z42t34/JN+Vam1+gPFgwxndJIYXtytLvoFPPjp9AnEa06HqG6uDRAfJw4xv9Vr41rLR9TMsAyi9NJ3lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738821720; c=relaxed/simple;
	bh=3nRU2n0xOCsINA+4oPV21gOq2tNrfyvRmIxXuBfKOn4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjtPJvuFn+B9xaQP6tobW1CAlez3gLgon+BTKnNzC3hBfYipXKUQR+xjlJKGK0UOy9SrFrJbLaszRTyvUmOibcNmLrt3sePSBzFOhTbLnJJFpGQnvJ2HYBjB1lej0DNgUAvwZ/O6bR+puT4ejlQSo4mAZGRhlrAh0+YBFdTBsHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5aITHWfX; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5aITHWfX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtOrV7yxVPUp3zWDzssrTM8DMZsOel4sexmjyzlbE/mcJszXGztJPOwO4FLm8JIdChxW+83EBjpENTHFcfIBGH6d87zQe8qF5xBXHAcI139ZcD7RLyz1mRo7m8jpuZc0kXp49o3toA5p+SME5QIT8dsw2/MGBwi5y/umZc0+8dFm5D+rSZ4W+nKg4FJD7zwZsZNUrwSKjyyr/yVPtOTjWNRKLSk41VMBaOB5Gr5TAgU27/AQN1k/hO1Ku2QrwujrtEYGSVxjDU8XMpuGiF6cyWQ4ULaVIzI/Q7JU3ejJGZX40bzEJfV/8WvtzNv2OtUViet2H3axIzPQq+8178Y9wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nh3MbAyOyC305gTn6FCpp5rC+eq0/NCQp6jmpeersx8=;
 b=dbaqM/9THAYQRQfXgImqAfIrHalmNsIwC1G8FNif5eVa0qL6KNqJtRiIxHQQDOzU2aSo1X7qABMY3W4Xl5NQtmKe/LrtX5z8kG76fzY/7A47EmGzdX72g3LBjqy5cfLqmguJpVBInmLQURHpfUbpa3duxLe7NdoJ8RdMdAidUXsky4C4flz+y0YP4VzbmtrA4ZaljSCyRmzJtyqbDfkySSyOf4mmQKlKfmpbLDB5CtTCT43hOt6jxaewY+AWQeV+ptOXu/0atvGhTl/SzEMUlObUlkaho/yXqX0bHaqRrfaJx0y8WUjnOWlIy5qEW6oCUaFDZFITdhe55plwrHzH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nh3MbAyOyC305gTn6FCpp5rC+eq0/NCQp6jmpeersx8=;
 b=5aITHWfXjIuhMz81vVmNomkmKjnavyHJ0tZJ+DK/g1DGwcg0UBfOBehMCryEyUEuC9sogzwcwsbidOouOuMFkuurD+Dw9e7hl8ViubLBpvSmvkUwt17MhujT7r+EcurUCdC1adAuiZOJSdm0S0yGnhJHY1pTI+14Eakno2PkXYg=
Received: from BN0PR04CA0204.namprd04.prod.outlook.com (2603:10b6:408:e9::29)
 by SJ2PR12MB8062.namprd12.prod.outlook.com (2603:10b6:a03:4c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 06:01:53 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e9:cafe::ba) by BN0PR04CA0204.outlook.office365.com
 (2603:10b6:408:e9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.28 via Frontend Transport; Thu,
 6 Feb 2025 06:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Thu, 6 Feb 2025 06:01:52 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Feb
 2025 00:01:49 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v3 5/8] iommu/amd: Add support for device id user input
Date: Thu, 6 Feb 2025 11:30:00 +0530
Message-ID: <20250206060003.685-6-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SJ2PR12MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: e480b350-33f6-44cb-b9f1-08dd4673c0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alDy4IW3hNaGftrYEMO1BKuEyhNyYgwONhiLx4ote6VClHtwQdrFZtok2Wx4?=
 =?us-ascii?Q?XkgsHuQWtzA87WA+RU/G63dsDd7CPi4HY6gI/XnEtJA6dWxISt/lFpazOQZ2?=
 =?us-ascii?Q?i0GsByIHuBMcTxaNQIDz1Jxy4q3sHE7dimEfBIuJNE4rmnnqDX3EZ+02ZaeP?=
 =?us-ascii?Q?27y+wy/WB3/tPwQF26CJhesmwlWQunmda2GrK3aaxEL/nVh0Plg1Q4eU/MCP?=
 =?us-ascii?Q?KTr0TIjY9lBp5WndDdeLSWZnLePNjuvQ3gMCEnI3MDnLGr28b4CDaMTBYpuR?=
 =?us-ascii?Q?RKltJaYXHDbA7xKDS3z1bqnxCnzkcUCikDxnznXDXZVxrAiYHc/U6XiDMBvj?=
 =?us-ascii?Q?4TheUKS4SyHEZHdtEtFCHqzgJhHKrQ2URLzMHbXvqrV/YiCdzMbIMzl9sAJT?=
 =?us-ascii?Q?6N6qMqFiukre11pFTmo3PhoF8FqNaXXrTjjbQah4gdHAll1ZvVzu4gMfX/fw?=
 =?us-ascii?Q?dDg6pzNavBhrHLlHr2canLVgj7MEHzfRcmHX9URriuVTigSbFU2FtNKCXm5i?=
 =?us-ascii?Q?KLhEDmSxReVJ+vAizbzNs/mXGI1PYIWsqcJNTZtxLLN6oEteKd/K7zFqRWwu?=
 =?us-ascii?Q?n6SAaME4KkEZ2utVOmH6MPJoHP9jkMllgHnhrJwGBKpjTdFFFPblm/hal6tm?=
 =?us-ascii?Q?rl1APw5dCGs8fNkqI6SStNoFZI3KOekxFImKT3Im+AIJrxWrAbOtzsXr5Jkh?=
 =?us-ascii?Q?454BJIqa024Rz+CyGuvpt3SD1tVEP5AJHKXneKppNO5Z25ZST5qG9+9C43yO?=
 =?us-ascii?Q?Ike7ETeml9aYFSwaxRZhECWrnZ45sU6feUlVkmllV2U9K5P++mpmzHMeozCN?=
 =?us-ascii?Q?SRbqsR28Nv5zCtu27Gua5f45ASOMdrppND9Br5Wmry8lDNGPSqb0E8a37qRF?=
 =?us-ascii?Q?yVpbX3+p16D4/dQZW4+O6d+/EY+vpHBLoVq8nL6bjZGO3SW3+WixXhPBxi/x?=
 =?us-ascii?Q?ovFNOiAAg8dAGcaSDwN8H2jgxMaimjhsJOsQP9MP6el7Akqlqkkiud4at7uQ?=
 =?us-ascii?Q?OSizQCAwf/K9G+nNG58GZIwTQ+UtlCBQ2Aoyp+CEw6scanDFo2GsNaKdAMel?=
 =?us-ascii?Q?UbrfHgLBjcYn5J8d8MZDwE0rOk0682IUt+KCiCm4ygRRSZdC4E4lDbL6/PMh?=
 =?us-ascii?Q?tfpW5hZSuHpj4XjV95PLnb2ZfhYTQ9PLo5vPLGy3X+BCrGG/peityGOxQbyJ?=
 =?us-ascii?Q?X9P1JzmdwqzmPh7fiveArzIpH3+kyui7r9bBTDs2mF0kBCmyn18zSmtvv/IV?=
 =?us-ascii?Q?QHU+epZWOFo90XL4NY3zk9WYbiy2gJgxjmckvq+/O9OBPii7bx5tpH8dPsPa?=
 =?us-ascii?Q?dB/0ax+p1jvx308JFXBai6shdLdJp8CjXvLN+OIx/xX9N/lbriqCR9VkXges?=
 =?us-ascii?Q?sG/8KROYgEbPzh2711E7cQRDStUer/JzX5r4brA8/GGUvUOjpNCFGraOae+A?=
 =?us-ascii?Q?DrPzX73jyZTVm1qZA1F3HJVfNdsJ0Bw2GstN0nPqi9MokYHEYpwVPrVamCgL?=
 =?us-ascii?Q?w8rZDdPUVgoU794=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 06:01:52.5262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e480b350-33f6-44cb-b9f1-08dd4673c0c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8062

Device id user input is needed for dumping IOMMU data structures like
device table, IRT etc in AMD IOMMU debugfs.

eg.
1. # echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

2. # echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
   # cat /sys/kernel/debug/iommu/amd/devid
   Output : 0000:01:00.0

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/debugfs.c | 78 +++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index bf718e7258c5..f292b93f9318 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -16,9 +16,11 @@ static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
 #define	OFS_IN_SZ	8
+#define	DEVID_IN_SZ	16
 
 static int mmio_offset = -1;
 static int cap_offset = -1;
+static int sbdf = -1;
 
 static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
@@ -127,6 +129,80 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
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
@@ -145,4 +221,6 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

