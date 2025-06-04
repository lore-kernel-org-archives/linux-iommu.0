Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E631DFDBB
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 16:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749055069; cv=fail; b=JmqXkRaKqQDHJTLqni9ccj5KNqkYvHwxPp6GrQmP/M59pTKD8FRvX4cae88vYsk5piA799IUSnR+IfPRPa1sCpU8B9yOjo1K1f16YAFY9MvmCP6ghT8yQwTSf6j8KOOcbRLdN4Pt4Xqke2leYtcgxVWeTFdfTJP9cP40Byv5TOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749055069; c=relaxed/simple;
	bh=pGoGo8qdMgfBXhSZZJS1qql96kplezBM5B3Td4ya3/c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZnzAgdazDyvHToCJtDNpvaBezpIUPMSoo0LBiuTa65hjP3cx7P17YdYfhYHt3BIHCM+dQejNXE7U8DkT5EmUDAhoXcv6v//CKwi5GpbpBr9fS8mqaLWD1cDhXwF5OpeUIdz94So008510w7bc8Tmw3BSsuXulAJCtIiWlFWPLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ez07Df/1; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ez07Df/1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyBMZq+lciCqzBMpZHicOu3lhmyusMbchBk6V93I8XVoIY0Ck5465NFBzBVQwBf5oIy4sSGM2LWEIaFfhUKx6YLF15h3ssbEvOiG75lBBbrWqGwfppSiFFjlyP1eYB8ojo5o2ooG4haJ4uoKSk4ut/Hjdk7I1nEptxBBmXJcorHt9wWVLuZ8lsEnZqsQvVw1mn+IUtp6fyIETMzyBXGinx4RnA9dAMEKfN9OACsYN/1sPXbQMWXEO+TPajlMx6gxUi1NbRNOd5Il3Cqlc4UyP+aFlArCSEv3EHA5Y+LEoorf0+mX50pQdnifOfM0JE2tojkbUE1a7mrpBoC1X1KmrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDRtWsOMfTLYOdkGwHoz9iy3Hy08VEGzNf+TXQ6E2L0=;
 b=w4yT6ciqIXhO8dmU6gGmoC+1odkZUBJLMBNYZlDaibr1DXkwHwFGgp0lz67+zIBOF6UrPD0AtKzujOjI88KiNrzcWz3odU4oy2I3xyTAmyNes+KdY3daWGw+2QMP+uFzKkjFjweKwAhL/smFLZjDpyHZrh69xOZWAwCjb2/ydG9mloGMfFRBpK5gVZlSOsW4R635FZSEOHLt/HxXfV4i1yF7jJclmKPlyRpPSRTTcAS7I/BoQJ9cU3mlbSB0O47NAB55mBP3qNUuze9+poD56Ch8L1oPJ6td/Xv0XI/uEokfrzI8aVagN1OL22I0b9ee5qoFPaYpgRLJG77PuG7dWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDRtWsOMfTLYOdkGwHoz9iy3Hy08VEGzNf+TXQ6E2L0=;
 b=ez07Df/1BaW+2j43Ov+Pw279hZxN1vMCdYUfU51eUw1vq7Ur7UGEnJJfevdc+oHlwkxPDSgCkpLKgssmNqA5QDB+wjYM5ARMx5U0qWX3KWlw67ngBDqS3Wrhr+72k+zZcB7t/rJSad+Dan/Eh/qWyzhuzQGmdMpaS8VkyWpQWA0=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by SA5PPFF3CB57EDE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8eb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 4 Jun
 2025 16:37:45 +0000
Received: from CO1PEPF000075F4.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::57) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Wed,
 4 Jun 2025 16:37:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F4.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 16:37:44 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 11:37:39 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <Vasant.Hegde@amd.com>,
	<dheerajkumar.srivastava@amd.com>
Subject: [PATCH v6 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO registers
Date: Wed, 4 Jun 2025 22:06:41 +0530
Message-ID: <20250604163647.1439-3-dheerajkumar.srivastava@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F4:EE_|SA5PPFF3CB57EDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 35173e8a-ddca-4557-0ff8-08dda38621aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y07Tx3PfdflZa+oHKsgipVO8W4Bwr8t1yJO6bJQuS9WE/JnO5IwH0rICFcRo?=
 =?us-ascii?Q?uOPK43U3PoRZfB6SKethQz2+TD3ldEF6j+wxiILEn1xnJcefJVDZK5wxx58O?=
 =?us-ascii?Q?GDk8R0FzrmJAdOaEzlZP7dKCZPyrzjpzMyHtHs+xCIEvq4Q2ugUU/ttUoi+4?=
 =?us-ascii?Q?EasE8fJuUMFl0M+v7Ap13Wrmr2DBX1dl/nL55AP+E+/CYt4/YAZ/cveJ6+rp?=
 =?us-ascii?Q?VgUrY9ZvBbny9Z9ZL1BobfkZGoqbZbbGwPTnujF6zHyjze/upY+lTkExIXrM?=
 =?us-ascii?Q?AHrpb3G6O+r5q+c+dUzLE11RN0VRxyg9Gm9q6SiD0hwE0O609upGMkhd9u00?=
 =?us-ascii?Q?8k2XkCrBu69ZACFLcY2ODTEtXDR8vdhKG/WljlvUIv6qTKVcSAlICc8Y9b90?=
 =?us-ascii?Q?HbPtYfTVXAqX3lfbi0mQOLiJ8n7k20fR1PI0SSO0KKeN7Txp9Gy/rjZE/o0v?=
 =?us-ascii?Q?3CQPquXahMeArBl6TeomBdhDIAo/+riw9Zy5VnzDn4sYHXI+UjeXuaDnwOhu?=
 =?us-ascii?Q?LkVOWUWSp1f3Zd6UC/naUBbWhEEO8rI8TmA1H2jNqyokaTnWqBX9rb0Y5kit?=
 =?us-ascii?Q?GgUEIDuWZRIVK80PF+zfVTObCnBYBT28k1/0+OAA/Obnx1uXabt6O9JWBPXW?=
 =?us-ascii?Q?/fl8R8Be8QSNGbwtI8zB+v6iM2ZRtsZp5+2JXKPcSJ+N6ioMF41pQffZP7HR?=
 =?us-ascii?Q?ABcIhnT+WEiqMGGmxTqbT57rXYi1DdgsZssJA5zjN6J1tlsmKPQngcniKtwa?=
 =?us-ascii?Q?YTI1hXnFv959s0zDQvrap8UAMNSFM+C/8NfnLpPescG008pzt8h3IOLAfp3h?=
 =?us-ascii?Q?dGpP1R1tmoDwiUpupt57rF+PO2d6MuxQXGrETDwm+o6mhQVQc2SOKTFrywVD?=
 =?us-ascii?Q?L6aBnKmnKJ7amexcbawk6UAURE/puC7JkXEhjQwhLR+djxlaf6h1nryT9uw8?=
 =?us-ascii?Q?w4FHL0G1vCZfzoC0Bf/4nGyA8/F1Kmfk+WCGEIUSTi9VZjg/GvTDi4QpCMBn?=
 =?us-ascii?Q?APqcFyf0gwmKUQsu6AIR5Ws2Eq2MtCTvQuYciuTPV2HPaJW4BWFqKMrAT+BX?=
 =?us-ascii?Q?xbFAORAZaZ/bzJzv5sXHvYR/Rz7lpoRwslU2jklmcdW6jJFLn+KS0x8tc6Pp?=
 =?us-ascii?Q?x/wqEr/koFloSGvkiCctJM9zlqJCEJR1qG3H4wiXNciSNn3NNZMw1G2avb2Q?=
 =?us-ascii?Q?O/Ycfpth38jQt2kjTRiWRKJQb6TWakdhK7cNHsWXESwl67S9xeH8ZQRwnvl7?=
 =?us-ascii?Q?4/KmmMFBhisQnaQi3rIa1wphoDsmTjVQbtmwXNmEhDyq0mQrBgY3O5pu2IkU?=
 =?us-ascii?Q?3igRdFCfF0C+IuNjNNbrWtuyy49VnxY7vlWRT0pPwBVLFycMLskyrfSslVnO?=
 =?us-ascii?Q?6Sas5YvLV2dctxEH1UtWv/Wtnm+zoQmIWNVS6SAcVkUJeb7Agb1/F6vaJFJK?=
 =?us-ascii?Q?8FqiZo+k0uUkkHMnHfhXWxFutH56mRDygiVHnf1noVqdiGFH6QtV/GCNxFKD?=
 =?us-ascii?Q?Y+PBryyVe+85wFCF4zCRRFVQwjdy7YAw8MX9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 16:37:44.0755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35173e8a-ddca-4557-0ff8-08dda38621aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFF3CB57EDE

Analyzing IOMMU MMIO registers gives a view of what IOMMU is
configured with on the system and is helpful to debug issues
with IOMMU.

eg.
-> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
   # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
   # cat /sys/kernel/debug/iommu/amd/iommu00/mmio

Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/debugfs.c         | 47 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5089b58e528a..38eca75f6ef1 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -796,6 +796,7 @@ struct amd_iommu {
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
 	struct dentry *debugfs;
+	int mmio_offset;
 #endif
 
 	/* IOPF support */
diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
index ff9520e002be..520377ab6731 100644
--- a/drivers/iommu/amd/debugfs.c
+++ b/drivers/iommu/amd/debugfs.c
@@ -15,6 +15,48 @@
 static struct dentry *amd_iommu_debugfs;
 
 #define	MAX_NAME_LEN	20
+#define	OFS_IN_SZ	8
+
+static ssize_t iommu_mmio_write(struct file *filp, const char __user *ubuf,
+				size_t cnt, loff_t *ppos)
+{
+	struct seq_file *m = filp->private_data;
+	struct amd_iommu *iommu = m->private;
+	int ret;
+
+	iommu->mmio_offset = -1;
+
+	if (cnt > OFS_IN_SZ)
+		return -EINVAL;
+
+	ret = kstrtou32_from_user(ubuf, cnt, 0, &iommu->mmio_offset);
+	if (ret)
+		return ret;
+
+	if (iommu->mmio_offset > iommu->mmio_phys_end - 4) {
+		iommu->mmio_offset = -1;
+		return  -EINVAL;
+	}
+
+	return cnt;
+}
+
+static int iommu_mmio_show(struct seq_file *m, void *unused)
+{
+	struct amd_iommu *iommu = m->private;
+	u64 value;
+
+	if (iommu->mmio_offset < 0) {
+		seq_puts(m, "Please provide mmio register's offset\n");
+		return 0;
+	}
+
+	value = readq(iommu->mmio_base + iommu->mmio_offset);
+	seq_printf(m, "Offset:0x%x Value:0x%016llx\n", iommu->mmio_offset, value);
+
+	return 0;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(iommu_mmio);
 
 void amd_iommu_debugfs_setup(void)
 {
@@ -24,7 +66,12 @@ void amd_iommu_debugfs_setup(void)
 	amd_iommu_debugfs = debugfs_create_dir("amd", iommu_debugfs_dir);
 
 	for_each_iommu(iommu) {
+		iommu->mmio_offset = -1;
+
 		snprintf(name, MAX_NAME_LEN, "iommu%02d", iommu->index);
 		iommu->debugfs = debugfs_create_dir(name, amd_iommu_debugfs);
+
+		debugfs_create_file("mmio", 0644, iommu->debugfs, iommu,
+				    &iommu_mmio_fops);
 	}
 }
-- 
2.25.1

