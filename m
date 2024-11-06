Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF232192B6D
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879497; cv=fail; b=Cx+0vS9oFAEZhIIXe0HqAqS0lHe4OrRYP4oBPJn52nHuF9+IcLkXCqGDQXhNqTSYkXUB1OjFeTDmE51y0gjvSd8RdBzm0ZU1rDWbDGDoje7gjwk0GvnoEHjDt5urVr1RPRedBx5IUgTV5wGj4uc4I7GhOphfpHHAfxqCh6xIRAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879497; c=relaxed/simple;
	bh=/LDZyGGxEELIJZQm7PbfxUb4DWbeld4CFr5E9aG3AEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3jmHMLwQHplcSIKmXiTheH2Q5LDsYrzk7jRi1zeYvnsS8q1HZaA8EL2d+tEhs5kkehWLKnJtChbRcckUJVIDwuNzc698pHaNEFt3USA5on+WqDVNwhrOQyYhe25QR+xrNPR9/JtgRnlc+cgNq4NhTnbgxBkaTj1dpNE5Sd/h8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MCnJ1Ueu; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MCnJ1Ueu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exms6EvIKAxW5Tux2BvbZEmgOuD9jAviwcar6r9vl+9M/aRS1++KKiL1bpsqwXpAhQ3xuGxdWifjYaicsZhD9J7s9q2W1Kuhd0t9lNdOxKHxVDPEwqbnkyi1926j5GJYYWMi39jK0iyofdN9oC61EEcIx8De1kUQ+5/mS+01K/pUT3x7ZzIZSmY4O1op8mAlgiS4rXRWKnplvOmg/Sa417kQ6sWls6tk6+Y0UPGIu5qkwuijehN6toinMExNG7s8fyU2eoakXxoYp5bDFe2194sneTkwawknrP3IRcncgnAQGqKGwT0xI0WbYnl1ZNzRIcvxvb+uB6YkZd4UDO0hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVlORpGaMUil+yRrsDcvB3yKWK4DNSB2t7wEeFQ1fPY=;
 b=ly3NIBeDSKpPIq7adYEyKPRj9EOorE2er4U764K2L2W/I1LlINZ0Ghit2t+kN4Zx8N+jps1xXMH2qqu30vgJvE55g53XO+HErgCZvp9ChqYd6Ahdlc4a9PfL5DdpaiVuiVr2eEG5RGfoZAVK1yJeMlfCGqr6JhNQFLznvCBwMAdVVuW0SkUHvOdcqhpGiUGI0tSThteWI8JuUBEK3gpUQee4jR7CLNH3DDm1S67F7VnJBAmCD+2masiNPJ9k5vNR5t4gu5FcufCvNr1B1C80z34JWAKDQ7d5bRHqZmDD44HDcLWZCleogDOQeywHkLmhbX97SSzaBRGGOrPgAeyURg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVlORpGaMUil+yRrsDcvB3yKWK4DNSB2t7wEeFQ1fPY=;
 b=MCnJ1UeuIv6NJgYYHjsXTgPf4IG+cAkBOIYpoLXA/poEVgPV4Piq2EKUnFNlJv4F9mbDjAUCYDlhzSK0sKwqvhD3tmsKTpzkSvWRn+XeHH73h9f/JrPtlJnmtSWGpvOd5i+JLFBKRINLfjAyfDAEjWvrlyC4gevcr7PO7J0p1CU=
Received: from BN9PR03CA0654.namprd03.prod.outlook.com (2603:10b6:408:13b::29)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Wed, 6 Nov
 2024 07:51:32 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::3d) by BN9PR03CA0654.outlook.office365.com
 (2603:10b6:408:13b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31 via Frontend
 Transport; Wed, 6 Nov 2024 07:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Wed, 6 Nov 2024 07:51:31 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 6 Nov
 2024 01:50:56 -0600
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>
Subject: [PATCH v2 5/8] iommu/amd: Add support for device id user input
Date: Wed, 6 Nov 2024 13:16:36 +0530
Message-ID: <20241106074639.2039-6-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
References: <20241106074639.2039-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: 8455d040-4b24-4b8c-6a3e-08dcfe37d440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HN1BLcZUaZVDyZULG+1F2VYv+v4i6wHJyPy2OelR1d3fM9eLHz5oAqkU517L?=
 =?us-ascii?Q?cT7vgfvad2WizwL+KaxWNZUYpTIhV1D4sdr/7BQkDrq+VRM0njhsXw83JQky?=
 =?us-ascii?Q?WAcFFObtTbbyHc4N/gX9fPpdsJHioI0X2SXb4GWHsv4U1cebdTJFoLeBkpKS?=
 =?us-ascii?Q?33xRYDxjo1PKscyikjBmIgOpQglzp/moEBGe+Nlq+AJnzOSOdICkxMLV72eJ?=
 =?us-ascii?Q?3y9A2lCTB9fphfIUmGlijBNtDsqesf6Kq58g1wT7Hx9SzfmTm9Lmus9K06s/?=
 =?us-ascii?Q?JRs5u2MRi36o25tbnEqcyhBneEcdCr/3iq9LF2xRWz9VvEoe3yOaDXD6+9Tq?=
 =?us-ascii?Q?b/ptNbEXHr4njVktNqcSQSQWZuvgCQtku8b/lOKP6PWNd5Zdbq21MeYSjQZP?=
 =?us-ascii?Q?1dVls93lu2QtjMRKPCD5Dhux2duomSW+WxqI7fUt0ByxTk18yJJ7Vx2mnUdy?=
 =?us-ascii?Q?uQSDmZPGY59YubM+TweEcu0jcQeLCRZY5Of9t6xiRAsT1mBc/lPdf5wC9Uj7?=
 =?us-ascii?Q?zKUB380MNdK+Na2S3EEdysEx7IXRAoaAxCQrzhtlr0k72RPVQ44XGokzdfIg?=
 =?us-ascii?Q?HKpIh6vf3WV6xo3CsqHEFEo2pfe/JnAtqUw1CzyjJSw9568YA8mBlHITtGh/?=
 =?us-ascii?Q?dC/aT3COXD8v5Y+y9U4vR9PqeJGslktoodJ+kFRvRKnGU+w5EebQYFWGdF3B?=
 =?us-ascii?Q?gA8MKudg+OfqcAHWMBlktCI68LcxzpXGNLjuq4Cj7PtGVyxqZBxEKCmpcY3K?=
 =?us-ascii?Q?Mz+OZ92WB1ZqZU7VXRMypZT+e95XEmB9cIj0AFzotH+d2s08UVMBVb66CF/p?=
 =?us-ascii?Q?tOafPBbWL3/CS/SYEkNtjpkTb1AnS5s3qPySGw6LVRNk0wcqEcn/SQMchE69?=
 =?us-ascii?Q?wsy5SuptuQVmAvZYzXC8IQFTCXI/wwvKADSR+/xylauZhD4qWUlkSD0wF/6G?=
 =?us-ascii?Q?iZHJ2V+dE99ZJQtv3CPs7FXAPOyaskGBVP283qGHvVSg2CwfqhwLXr5fQMyB?=
 =?us-ascii?Q?HvS/JYEfPUU2wtoMtlyO2UlOduw+JNDE+z6oZMkib1s3XJB7bPQzuXddl7CV?=
 =?us-ascii?Q?T5VOETfsUpspbnqhvReZqcOtolZ1kqEYGejw8f7uDhOiHsIm9E9+tvZFxF/R?=
 =?us-ascii?Q?H2z/eQkcJ3il6/r3k2+O1GA6tyJ+jG8ad/qv0DmT5EwMbil3ZzlOF3UNhAFi?=
 =?us-ascii?Q?D3EsWIXWHKpA3+MVd/sk/NGwa9Ab4w00glBNB+UR7xoguWEBuYsnuIJUtX5t?=
 =?us-ascii?Q?OUfUfps5tAZmEIx7/YyGMAX2wb3h2yhN8c3AuQmc9DqZWOMtHobpkjqah8dU?=
 =?us-ascii?Q?ehoH5w9ktf7WIzGze6tZ6zma53tvmnZRarY0t82/CArrauADlqroBE/eYAf9?=
 =?us-ascii?Q?y9OkA5xEMjnOA/3YeC+wIsGzS8X9Cj1QVM+fbh9N2xA1EgGNGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 07:51:31.5540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8455d040-4b24-4b8c-6a3e-08dcfe37d440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601

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
index 1b989d45257f..74c88a80c6d0 100644
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
@@ -149,6 +151,80 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
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
@@ -171,4 +247,6 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

