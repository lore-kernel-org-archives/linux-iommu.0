Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E051C1C231E
	for <iommu@lists.linux.dev>; Tue,  8 Oct 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384139; cv=fail; b=s2yb3u6BN7BAiK/zF/5gRFU8Nlll7IlTJpuyng1w+pRtHqqLzVuVaCXJ+SGs//UmM9stGgQEzaXuYgD8IQzpq7a5moTTBmC9eEOpJfpmzMovpvRKj/DkjESaMp0Iq1Pfn9i30RgNm3nTKC1TYDDuGwH+dn5pXMOIhfKZB/+Pb9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384139; c=relaxed/simple;
	bh=R5sACtTfc3xjf9fUazcku1s8S4SmKl7gSHOALD4uPhI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJUjUFBPmF9zvp2bR01JUU2wrLRp2zg0qLwauWSJk7JOd/eb3yh/90/S1ebQ20ziruopze6BBmsGd/GlvUSFuJWpsUPITc+kX8VWBDq3LXWIiy0dnsSgY44qoXWu2Heva5eVtzNu8pclgkrrNQD3kWV7///41AoACqGk4voKkMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=whyQ5Qda; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="whyQ5Qda"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zl2henaa2PlJLTv4gkJQVfg1zJ2xUqCrIFpav1dQw/ra2y3IjtgKNClkzQDsbqrIR0laUOLXBGRDpim8C0bpASu/93idUnNnhP1VKZovETanEKU8ZoALUsJbpAb+RzgZ2katS0HjxVZeDNu5qGN+CSWlCiA7o6NG3FS3lFTvuyuqcXbKLCp2L9qbDqdoVno+a+FtVS0/cV6fxEyQpAvrohdrKFYY20vkXCitua/j6Nk58nQSv4VTznW1ykS/xO4PpWfx2207+XKKbHvOoWp/SrNzEpWlrq4CA4aC7zy5Xr/4BnKEKOoC14f0xgaYV57ffHFJtuuhUiiMBVdSOwShEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEneQU3cFe9Fvlm4Xx6FokQZBVy7XvnoECN3LKjXdNc=;
 b=nbq5UMwCBtVecCl/Q37EyQEXTQnggISO7Dl1uYC/YT4ElJeQcNpk3FaaUTXAqzk3LfQhDmKj1F6x6wKbuiJ8wIEhHs9TRhAfJi1lWLLRi2wys737rZH1K/H8LJg04xendYqbv2NLRsLV0PDq+TBl6jibmU5dWqYqVX2YgZW9jNysdvcAcM5gn3sy/jnubrsKFa0e0k98ewBVia8viVkEVdFp8TBmBxvXdaFGPVnRJD4nkiOFU3zm4LKbolX4AEkOiy0S2jwzLxIihgiMo3hNoKDbNrNYE/LNqQFHLJU3u9u38uJwadd1n3OGztVOumZ/eV5U2EtTGpgv0ho6iB9j2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEneQU3cFe9Fvlm4Xx6FokQZBVy7XvnoECN3LKjXdNc=;
 b=whyQ5Qda/D4PKRWi7w8NLh76puASTwX2K6e0XRfEsjQEEJIzjVvkCIVuI4+zyk9JsBNISMUxFudHOhPqcHoifR3eQrYgSMsUPkh5MtjYa7kIYBQj2T6n6RQn5MHKPh4sMjrE20UwRAChtI7WjQsmUoPiIUBSVMDEXLoQUf1+TF4=
Received: from CY8P220CA0040.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::10)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 10:42:14 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:47:cafe::c5) by CY8P220CA0040.outlook.office365.com
 (2603:10b6:930:47::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 10:42:13 +0000
Received: from BLR-L-DHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 05:42:10 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <dheerajkumar.srivastava@amd.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [PATCH 5/8] iommu/amd: Add support for device id user input
Date: Tue, 8 Oct 2024 16:10:32 +0530
Message-ID: <20241008104035.4008-6-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
References: <20241008104035.4008-1-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 200132de-ae45-48bd-8d7d-08dce785def3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eQHsYOo+I5mSF1iqSI2qrhoGWYCD7e8qvBKxZTdQAK3Rd2rhawGdHqcZeP2V?=
 =?us-ascii?Q?GdPmovPxcLNVWQeAgjYN2aOq+BTM+BW0T/6WPQL9XJfvkBVV8DEkFLr5R/hf?=
 =?us-ascii?Q?Jd6zOT5cE/BV810h13riD+KVCdtKK4aLN6z3pFbVR8518YUX/qpAHoXwZAQw?=
 =?us-ascii?Q?RHCa+K8bE490jx/iwDPc0ECfRu3t9P/Qib3f25Y0A4nmhIxRS/ccGKAm8apS?=
 =?us-ascii?Q?E70+T+TWaOTBOC3OvXKayO8rNZ9rXVCKFsYPmWGCaTwpxSvTx86idTwmJAYF?=
 =?us-ascii?Q?jLkh4wQBzkqwW3szapjvD5VudE3rh2T3KfMAqEqEN+Cjtvku2E4CI8hyLbMR?=
 =?us-ascii?Q?a5Pg4qBxcWebAjVbahhmlqKPpq8vUoQNczqd1DQZ9XbLClH/GBW2JVGHfBRd?=
 =?us-ascii?Q?EWqSdE2fkFlGHOTpzWmfnldsftYNDBTnHpLNJBJFSiw3dC7AUAPIIxKkutGD?=
 =?us-ascii?Q?hjy+TmpSjKxM6M6tHJU/edyYYPxDj0cA+Juaj7YoGDyoFUiTRYgqe4kUpDH0?=
 =?us-ascii?Q?naGsT/ESMQS3uD+4krRwixrDlO7dzsZTxpq+MpCebI3UKG6ryrX/INjJYs6R?=
 =?us-ascii?Q?YrZar6aaEU0duYQRiF7oWsar9+kvK9q0j0K5M0O0f8gGk/2X5uBxLsT6nMr3?=
 =?us-ascii?Q?5mfkVx/qjgirs/mZfQ04v2kdqZGwLmsrTUvz6LD64pai9CTjz4LhUsS+t2az?=
 =?us-ascii?Q?NuItB3balo8hiIPH5fi0QhChBQf3DIRGO4oTne4CWlvY0CuHzPLYR3zzsxhh?=
 =?us-ascii?Q?+q00FrRO/UB7J096U007HvUi3j+feAPJUqoTmj6FVuP3xNPRa+m37Gmp1IWj?=
 =?us-ascii?Q?fsLLQkHZXr66Wz9Uf4j9+3wPg5OjojQwRNe81desR0tLQkBxWU36WWLvY+Xm?=
 =?us-ascii?Q?a6y4Kq4RPe8Iu2zgCSQ27od1BhL4MxBf2/pFANF6Flg84t0/mVRHLtcaSuFI?=
 =?us-ascii?Q?WaG/npeWm+SR72zw0FL0aaw0FOpXkXhb6xEwkEnME2rAfc3NJ3toZuWWu1J0?=
 =?us-ascii?Q?xHYe4q1tDGkIqjO37JxdkGezw+rgHebS5xxCf3V+1CmtXmkyv2CXFEIzaXhm?=
 =?us-ascii?Q?0Qn6t3igJSH/ilZIKZzutUTZDWecAanZQx3zLqyLnE8YTQMTydr5BDlErt2m?=
 =?us-ascii?Q?hE6BFla+tgoE8jCaqbH5IYFlJwgTwQ763yozL0cKf5PHFpKueQ1jbVXTDmzA?=
 =?us-ascii?Q?F9FoYU/ABIENT8N68NgwBBYkSkcNfrIe59eqSYXDSd49Uzp8dyZmlrIoQXyF?=
 =?us-ascii?Q?Az9tyE5UFJRTYUIlUbpR4oJdvrG5asO3kerJhV7aVaA2uOE5TIaqoTDi0LWd?=
 =?us-ascii?Q?5V4hssLzZZJvGOro6XpoBn8kSdNoePzKy6Y0QTpl3Q/jSVMPUJ6LjFC4FgS2?=
 =?us-ascii?Q?er3Lol/XqQHq9TXXnXZhJfgcn+KN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 10:42:13.5062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 200132de-ae45-48bd-8d7d-08dce785def3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

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
 drivers/iommu/amd/debugfs.c | 86 +++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index 69d2b01bc0e4..0d11250c1a00 100644
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
@@ -184,6 +186,88 @@ static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(iommu_cmdbuf);
 
+static ssize_t devid_write(struct file *filp, const char __user *ubuf,
+			   size_t cnt, loff_t *ppos)
+{
+	struct amd_iommu_pci_seg *pci_seg;
+	int seg, bus, slot, func;
+	struct amd_iommu *iommu;
+	char *srcid_ptr;
+	int i, ret = cnt;
+	u16 devid;
+
+	if (cnt >= DEVID_IN_SZ) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	srcid_ptr = memdup_user_nul(ubuf, cnt);
+	if (IS_ERR(srcid_ptr)) {
+		ret = PTR_ERR(srcid_ptr);
+		goto err;
+	}
+
+	i = sscanf(srcid_ptr, "%x:%x:%x.%x", &seg, &bus, &slot, &func);
+	if (i != 4) {
+		i = sscanf(srcid_ptr, "%x:%x.%x", &bus, &slot, &func);
+		if (i != 3) {
+			ret = -EINVAL;
+			goto free;
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
+			ret = -EINVAL;
+			goto free;
+		}
+		iommu = pci_seg->rlookup_table[devid];
+		if (!iommu) {
+			ret = -ENODEV;
+			goto free;
+		}
+		break;
+	}
+
+	if (pci_seg->id != seg) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	sbdf = PCI_SEG_DEVID_TO_SBDF(seg, devid);
+
+	kfree(srcid_ptr);
+	*ppos += cnt;
+	return ret;
+
+free:
+	kfree(srcid_ptr);
+err:
+	sbdf = -1;
+	return ret;
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
@@ -206,4 +290,6 @@ void amd_iommu_debugfs_setup(void)
 		debugfs_create_file("cmdbuf", 0444, iommu->debugfs, iommu,
 				    &iommu_cmdbuf_fops);
 	}
+	debugfs_create_file("devid", 0644, amd_iommu_debugfs, NULL,
+			    &devid_fops);
 }
-- 
2.25.1

