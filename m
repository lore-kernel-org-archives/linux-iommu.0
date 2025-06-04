Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF3E1DED51
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055122; cv=fail; b=i2qzCl+uKtvT10uoHnEsVayCdB0mnf7P5sUXSAvis5U096/KcDJOg5L63MULJRoh4xrhlSJjOpj8cP+uEHu3EzVT2zs8JXNClSQM5zmYDt4TSYJy+gu3R5z82wj1hJX3GpZrWq1bsefYGJnbcJy9G+deNN0c+Gr9l9kAIas1zA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055122; c=relaxed/simple;
	bh=QBWQMCp1ot/oUC+9LlM3uip373Cfb/f4BsQV3mezTH0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7a8rzQ/AZ9GV5AHE4iKcVvx6vAa0EQJ6nZbC8h5CAclwChyMcNGyEIgkHQvTk7rMRPH0Ox0OK5kXW/e9DxoxCzs6TQ7Yj67px5SbtKKe2Znmo32XybM1dC1sHZRQnTUy44sCBtwMuRLThwn6Ynup+RENGlwMPLnQxiC5KTy70g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gO8Dc16j; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gO8Dc16j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnsbKckVVwpFVBQDPFMnkFGUA9/rGVxsvHRcdylF5R/xJTHeln/BKPDmIld//YEe3MtUrEX4A0uoNFufmK5ZmrDqCbhSL5pBY6OeqgkbH6xy1z9xcfot4VJOU8F+A3NM0/hgQBsaLKWOIt2IEHZI/mYY4WQjmZXZOozgK/C3hGn7JA6FjoxDb+BFRdNoXW7k21hIjxHmGkFwXf9xK28wU6EfEl3bQs6roPdoTJLmbou6JPoXFdRKu2Nr7YW6TqA4vAVwcRInvYKSwfiJ/YX7koAvSg+zuQE3b5l2dWf+jdL+t1DI/jXsbEFxOuFeobqAfd6zxK+2vpwZK8cGqE4P7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hcv8uK3Ii7YTtqii8MIgRit6IlZvaw4k09ONJ0OtYcc=;
 b=vqb0wQM6Q85gLIvu7Ziifior1z949yliqLQ6q1LzOqyYHOcac7h3w3EMKnDitna2n8BveGTnAAKGuCeRTMJBhSI86/C94QZZfdXDh5erLXUI55DXRrDUztM+HJ1KSCUYfMOgPuMKhkWu1GFYnIG/9lhyGkiFrZV8RHvnVERHSJC/V+uDxsLAcA3HrJh2uR1n2MMDRKnM5LclU9TgOSqa6GUB74Mz0m4/DSIy5EWkTErIo5bWcapW/kQwC10fXYaZVuVm0o4+a09rkYotdUKToqbaPh6f1GFovURpCYKKeSmPx+xb5x4+cO6zypnHArOYPZVpa3AdoBnxDEJ4BtYaGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hcv8uK3Ii7YTtqii8MIgRit6IlZvaw4k09ONJ0OtYcc=;
 b=gO8Dc16jizEgSURW+nJLQqdILbQzuN96YvXPcFB3BWYnA20/1ajvV+7C65yhEN+ShPVAqla+rAIRMgBU0Uv5NPaVLiubjmg5NyT5s9afeiZ7dWszJ0TVBh2ee6oden4R4/aPyTjyf2rRpCVOiQQUYQ0GDA4XgdlVRr1kbgVtWws=
Received: from BY3PR04CA0021.namprd04.prod.outlook.com (2603:10b6:a03:217::26)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Wed, 4 Jun
 2025 16:38:37 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::ed) by BY3PR04CA0021.outlook.office365.com
 (2603:10b6:a03:217::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 4 Jun 2025 16:38:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:38:36 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:38:33 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 5/8] iommu/amd: Add support for device id user input
Date: Wed, 4 Jun 2025 22:06:44 +0530
Message-ID: <20250604163647.1439-6-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: facfb49c-3c0b-4840-7902-08dda3864135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0RqMEbKHaQ4N7lF3dVQLvt51QO28vEvXyGqcO7Rq33CzGVFZIHbX9Xc42S4l?=
 =?us-ascii?Q?N5LKRX/9XIkGezphNE/Y3fgmzTzZgV3wf4MUClQhl72ONowWnd5NpkIk3ECu?=
 =?us-ascii?Q?QmyhJ1nj1SywxwmgpYTQAIQ6vHRVI9FyPFPNkjUAX0L4JgL1RJ9nvQZOChIw?=
 =?us-ascii?Q?L6wX6SIS7a6kkom4rQ0c1i3xLeBZ7nkzNfBdb9owNDImgs2PRizfQ/3a/T6b?=
 =?us-ascii?Q?SLjpjpEmOuy8nN1hzOkVyOUEak2g21AUcCKHkGXo4VE8w06I25icAanmNn3V?=
 =?us-ascii?Q?HFYMOSdOE81YBn7a03Ib96puWRUQrtsCgHvpLvzNw2dAgGZZ5s4FMvMmeOln?=
 =?us-ascii?Q?fCtPChc+vDrLrdmcOT6rY+rrKXnO+CjlyxmfzBfgR7cKiuLe7NkLMbNLrqva?=
 =?us-ascii?Q?h10RES7PS5UFQdYrA+emJXgB0VKudImgu9rwi9t7lokEwg39OfL2fc7pEnVJ?=
 =?us-ascii?Q?IRXRTUTM1seDRdmpyYhaBHC8W8CyPmG3fX/x3hpRNDDo4gkk/dueQjwILd3N?=
 =?us-ascii?Q?kzVVOYzN3i/hLi5AV/vihyPGrY5RydY+o0q1gatkWArFs6FXHxThcYfrogcW?=
 =?us-ascii?Q?+TVGrwPz8069oiSxCJ+Gg16V7dQRtISwHNKjXTRfBC22m1enJ5Bq4kRp8aCv?=
 =?us-ascii?Q?RSnZYKiel+eoJEi8RZjLJWwuS0FHK1nZAdvj36APD3/w06gEgGjADwsnZWFA?=
 =?us-ascii?Q?VQv5oCTEZzBaz9hVf0EjncGkJFAXCpFTNCkW22R6io07PGnGrghTw3MPTQUB?=
 =?us-ascii?Q?k3/Uegu4xGMjDE6BLeqBaU/46uYcUsbbjKHYoKzXSUEIm4Elv8azpkcoXHBb?=
 =?us-ascii?Q?b2Di5CzqRFjZf+e3o/UXGLEUUiBB3BmKWT2wKvhMyTxc9N9T+fzkLjfOiJVO?=
 =?us-ascii?Q?DMJwlMZVJqSKtcNzHHMYJjCMFp0AeTerWoo7O5glqmGXz6vdLCQIRgZO43qC?=
 =?us-ascii?Q?Gg1IjQN4PCGNwqSKzbljcYIoQ+77zRmwa1MRch4t1iRouWF9l2G8bWHW0rXD?=
 =?us-ascii?Q?xX3Z+9wfkmH00pIs72H5GU8hlTncB7Nn0Pn1azLmD1p1yGH5+wbuirfY1eKs?=
 =?us-ascii?Q?f1dleHs4eUSryX3qiwdjBFmCAutTcRzUAZXQ3Vff6ebtUwalkMqZAV2kbwRF?=
 =?us-ascii?Q?3spVDyDIQtIH52lQmKAwnljOcKi6kQSGyCRPT8d+dkJC30QZOVeLOuLJ/Tlj?=
 =?us-ascii?Q?vvjQHgbD71BrwjXUFX5QtkCEsU6/G/nlTk1qAJHd3zfC3UnX7asmA8QZ3tL2?=
 =?us-ascii?Q?3SSqw0TJvq5AfPtoFZBcVyLEG84y3jkDcW33w4bg4ht3kdUZ3/rYjjYYH0x1?=
 =?us-ascii?Q?y8WkGhQAlFPsoGQUwMba5pVtQuiBJrKz4/XInfo0HbB1Gkyuwzj8fc5Tuk4r?=
 =?us-ascii?Q?c0f9Yey67HS7Q3NBnqobzmcwnr/8VNp6UJL1Ae3oM06EOeyn0JkFTrxNyidE?=
 =?us-ascii?Q?V62Tlv59Po8ftJMwAiy8Bk3XJqFshpXmPU0ckP2OeNfDkSgCYNRjis0m1OeT?=
 =?us-ascii?Q?+0L2LEUoSatcSsG5ixFrcGELB9VtV+ns1RmT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:38:36.9974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facfb49c-3c0b-4840-7902-08dda3864135
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171

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
index 61fde9ebfcfa..8b57ab4ab809 100644
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

