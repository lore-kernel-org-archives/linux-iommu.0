Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A2627E7
	for <iommu@lists.linux.dev>; Wed,  4 Jun 2025 06:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749017643; cv=fail; b=p9K+I/d4cNskG3XuWUfg8ZnY95YkvsBfQhnTGvJ8S13dWHCPVtoPYINhna+tLdIppX4O66pRypmfqVZo1WvclIEd9z2RFz3F5Qex7CVOh9RDym3221EUfUs+hN+5ZOdTwK/XCt0H/uJhRjuNKJDkP0+lHjwq879MtERj3UNW+kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749017643; c=relaxed/simple;
	bh=DPsbCFUmI85mXbxYb8Ecxl455+7kTPPjYPmsvv/5fjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDuYeCvtGvH/daOe1g0B77stAP9kPTGfLzqfb+bLBRJA6CeYzlZ/LLJrZhXoCpEWJgKoIv0G2ydFATAeww8sOHOKl8i2w7/sjAMu2jRlC2LBv4iGU54a0Vr/rQAp6OAvXZ8tmXQ3a1FKX65DTmsHm5Dnr9WIalL+aUzJ/6a7SpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zw+Qdg56; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zw+Qdg56"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C905KMaRzPN9vWqS9hAiFnTUJ+nOy5G8nkkUqph+67uGcikz+WwGvDLOfGlg2MhCnFwCwXao49+LXrVvlkkwLRvqHobyKC+MYzWv6GoEPQkSmLePIoxaMrVnPoowKs/cxUM5NhPBtfug+l0J3jpqEHiQJZnXKEsiURAkl/o7DW59Qy8JC4WHdRmwNyZsATgXDwUDLncg+zaFZ56pCTavX7QS2rdlxc3Cbj3PfcBTR0seqrP+FbvBa5p8wCmcZlgUa1uz5ST4Sgi0Y8h3K5fwgaAcUMnbdEi3ns7qmhTo62A0+hDtX0lFVtfEZeYgSf5NXw8GOt5be+aqUs29/xIqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFqQEOa67a5nBgD7nEh54Z3M8V3xKMg2mNvVGSK0q4w=;
 b=Ivpc09QIumLfmPmPYBd+Gp2PhOdhKJbAUeBepb3n6ZedZqtDq9YG2HvfZfHEzKzCpnm3F+saDQf3XUQe1rbMT55YXynVFEY7ZVO+FyKHHp4zOKut7/zcvu40B+kYKRfYWgArBBt7oJJvtEWxD4mjfvzmEwmUCTcV2+WSndK056re4PgBa+iLrvjNI8Ln+H4GyhS9SQKShaEP//5m09ycr7YFyPSOP7ztqEPSCZjuWUNg2reo7ggAO5P+bz9IC8bPbLZTn5oyOT1mkJUKJ2hsJpKHmOTGe6F4IpXgRKkeqkS7A8nmgbPPfTJQ9p2aKwS+nWlce8hc3EwLo0vYrWfYRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFqQEOa67a5nBgD7nEh54Z3M8V3xKMg2mNvVGSK0q4w=;
 b=Zw+Qdg56Ifhlp4B0sqL9vlSshn2BCc+gkCvq5up7BPEdscwM4zjKd6cGRBSGPVTITKZHZQWHguTQJUKM57k5DeICoqOSRu3OWlJOzmUq+I49tH2IGCa2YbUTQK7dPNHB3Gl+F1f75eIX089d9jUZNzIBxsaPghY7RGlhRGiWEcc=
Received: from BN9P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::10)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 4 Jun
 2025 06:13:57 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::9f) by BN9P222CA0005.outlook.office365.com
 (2603:10b6:408:10c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 4 Jun 2025 06:13:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 06:13:57 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 01:13:54 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/2] iommu/amd: Add HATDis feature support
Date: Wed, 4 Jun 2025 06:13:24 +0000
Message-ID: <8109b208f87b80e400c2abd24a2e44fcbc0763a5.1749016436.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1749016436.git.Ankit.Soni@amd.com>
References: <cover.1749016436.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: beff859e-f4f2-4484-8296-08dda32efd8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SGYjfleedQ4BiU6lKDf785nb+Q0uHI0cS7BxQEasQmU/m7pKTuv0D6L47yIM?=
 =?us-ascii?Q?7x+5yaS3bJ0/V8g2npXgabLh2qU7WEUOVMas6N6ywceSnJO+A6y6zxHC3rA/?=
 =?us-ascii?Q?hwJKhPQdW3tzl40pHX8MQUBn5l/NP6fqCDcRlviJmfHVnD4I1e9xXWbAXBE2?=
 =?us-ascii?Q?lcZoF7Hm0uSIoC+ftp6AqsFWJHrjRdsR98p48DkHorDg7S17m/mCr2ZTG9jE?=
 =?us-ascii?Q?6i54PvK8pNDXlPgLZ5vMvaSft8eoA4rzz89eAqgnmfvbm1MC9BX/adeFVydl?=
 =?us-ascii?Q?w5NoX84zmv2z2dnlv/sCHuKgFMwaa5xW42M9wgB45pQOP6dMD7zHDQIgjJ+6?=
 =?us-ascii?Q?3QMx03ACZOwmYlLRNbolog+FdBfgzx2j7TM4FRyS72mbx2xDoOz0im5pXij5?=
 =?us-ascii?Q?Pxo4dghV10qLK91kyLq6kJpU0vm6s/dYyxw2Yl4Kwp4ffEt5y8a/PLe4FdyV?=
 =?us-ascii?Q?EjqdgJEmwVwElksfmnEl2nVYdfDyGnEpupl7biJMVmP0CQnTmTdbr1JzLNyM?=
 =?us-ascii?Q?a7Y784z0sP7KWA23/o4Oj5nt2/pQywObLT1honb/lyxAp8XsOQGlV17L84nU?=
 =?us-ascii?Q?lpP1x7gEZcVH9IwoqzjIpGn7NwAwhG56isxCqoU/eP+dJSsfFuyP00kpSU8E?=
 =?us-ascii?Q?fZTJZsj6YPyVzvn4e5+l7i8XQ7LIKZVK1uqoQpJDmLU2KgctFSwqJ5TLW8UH?=
 =?us-ascii?Q?b791Zmu4RvgtcCZDvsmJ7pvEsvRjC0cPFkRQEagWlEvXl9pKHEzdPO/FAD9i?=
 =?us-ascii?Q?lA3NZAzsniGbljD0TN5juBGaFjuo0yxvje7lxJAjRKXXSdrugTNiD9vuNi5J?=
 =?us-ascii?Q?0oEMsmufzNbjhz/UB17J4uoLnkc49/Ee5RQyXR/pbsliVIm4Hiu7EGsiFI4s?=
 =?us-ascii?Q?Srs4b9KS6TzFCPfMQzvcRO/67hO7MPfYG32x//UqHhKks5wS04kuV10oZugP?=
 =?us-ascii?Q?9LFl12CIZxGL0UaaWMfMC6jYnwkTT/P9X+aryYPxbQDfqD8Jon81eG6YmC4N?=
 =?us-ascii?Q?mx4P0WcgmvEV/Imfy60p2ssKPearh5tthdt38PgzUz/LuM3rKQumXSGwbNT1?=
 =?us-ascii?Q?ujJASkTCzFJAHeXwdQSrERbeWZkwnNMiwFlCnT8iUTjbawXh8UPSNKbYKmwZ?=
 =?us-ascii?Q?B88bNY8bGjxmWtfoPJxOfQRN7gawSl9dfOeF7O+rfBxblqlaHncO+ToVFgCM?=
 =?us-ascii?Q?RozaHO+pO/ECKJUjdV1FGum6Hr6WdH+y1ZoNmKBoPpsBzcuwJc1S+Ez9dIEJ?=
 =?us-ascii?Q?p0tGUBAGTehaRPuWHXcDkldRIZ+2QfUXwvNo1mMBiv19q/6U3YXsXiQHYBOe?=
 =?us-ascii?Q?Abo2Yt4pGD7G2ZErxE58KoHu+TdZloB6tI0+b0GjQpgUQMhTQrHh5xJ2j4cx?=
 =?us-ascii?Q?okHbQMW0Of+p7GuWZBtguOEtewyk5IntLRGilWwiMbwha5VVovFC0xoLaSsC?=
 =?us-ascii?Q?p4ii3TWmaxDnHtbggyhnRy0AmNvcl2BGc3k0/nzg+T+v1EnsMAq/j9rh775c?=
 =?us-ascii?Q?IQETt58E2p+m14An6ow0IcY9saVUGwCpcABlRU7MmE61JUUIaFWn6wkiew?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 06:13:57.3719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beff859e-f4f2-4484-8296-08dda32efd8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153

Current AMD IOMMU assumes Host Address Translation (HAT) is always
supported, and Linux kernel enables this capability by default. However,
in case of emulated and virtualized IOMMU, this might not be the case.
For example,current QEMU-emulated AMD vIOMMU does not support host
translation for VFIO pass-through device, but the interrupt remapping
support is required for x2APIC (i.e. kvm-msi-ext-dest-id is also not
supported by the guest OS). This would require the guest kernel to boot
with guest kernel option iommu=pt to by-pass the initialization of
host (v1) table.

The AMD I/O Virtualization Technology (IOMMU) Specification Rev 3.10 [1]
introduces a new flag 'HATDis' in the IVHD 11h IOMMU attributes to indicate
that HAT is not supported on a particular IOMMU instance.

Therefore, modifies the AMD IOMMU driver to detect the new HATDis
attributes, and disable host translation and switch to use guest
translation if it is available. Otherwise, the driver will disable DMA
translation.

[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  6 +++++-
 drivers/iommu/amd/init.c            | 31 +++++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           | 13 ++++++++++++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 29a8864381c3..fddfad4a9009 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -43,6 +43,7 @@ extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
+extern bool amd_iommu_hatdis;
 
 /* Protection domain ops */
 void amd_iommu_init_identity_domain(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ccbab3a4811a..69291cef73f7 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -460,6 +460,9 @@
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
 
+/* IOMMU HATDIS for IVHD type 11h and 40h */
+#define IOMMU_IVHD_ATTR_HATDIS_SHIFT	0
+
 /* IOMMU Extended Feature Register (EFR) */
 #define IOMMU_EFR_XTSUP_SHIFT	2
 #define IOMMU_EFR_GASUP_SHIFT	7
@@ -558,7 +561,8 @@ struct amd_io_pgtable {
 };
 
 enum protection_domain_mode {
-	PD_MODE_V1 = 1,
+	PD_MODE_NONE,
+	PD_MODE_V1,
 	PD_MODE_V2,
 };
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c06b62f87b9b..5dda0f6d2492 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
 u64 amd_iommu_efr;
 u64 amd_iommu_efr2;
 
+/* Host (v1) page table is not supported*/
+bool amd_iommu_hatdis;
+
 /* SNP is enabled on the system? */
 bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
@@ -1792,6 +1795,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
+		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
+			pr_warn_once("Host Address Translation is not supported.\n");
+			amd_iommu_hatdis = true;
+		}
+
 		early_iommu_features_init(iommu, h);
 
 		break;
@@ -2115,7 +2123,15 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 			return ret;
 	}
 
-	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
+	ret = iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
+	if (ret || amd_iommu_pgtable == PD_MODE_NONE) {
+		/*
+		 * Remove sysfs if DMA translation is not supported by the
+		 * IOMMU. Do not return an error to enable IRQ remapping
+		 * in state_next(), DTE[V, TV] must eventually be set to 0.
+		 */
+		iommu_device_sysfs_remove(&iommu->iommu);
+	}
 
 	return pci_enable_device(iommu->dev);
 }
@@ -2576,7 +2592,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	u32 devid;
 	struct dev_table_entry *dev_table = pci_seg->dev_table;
 
-	if (dev_table == NULL)
+	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
@@ -3087,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
 		}
 	}
 
+	if (amd_iommu_hatdis) {
+		/*
+		 * Host (v1) page table is not available. Attempt to use
+		 * Guest (v2) page table.
+		 */
+		if (amd_iommu_v2_pgtbl_supported())
+			amd_iommu_pgtable = PD_MODE_V2;
+		else
+			amd_iommu_pgtable = PD_MODE_NONE;
+	}
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3117d99cf83d..8a9babd6dfa7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2424,6 +2424,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 					     pci_max_pasids(to_pci_dev(dev)));
 	}
 
+	if (amd_iommu_pgtable == PD_MODE_NONE) {
+		pr_warn_once("%s: DMA translation not supported by iommu.\n",
+			     __func__);
+		iommu_dev = ERR_PTR(-ENODEV);
+		goto out_err;
+	}
+
 out_err:
 
 	iommu_completion_wait(iommu);
@@ -2511,6 +2518,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	case PD_MODE_V2:
 		fmt = AMD_IOMMU_V2;
 		break;
+	case PD_MODE_NONE:
+		WARN_ON_ONCE(1);
+		return -EPERM;
 	}
 
 	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
@@ -2532,6 +2542,9 @@ static inline u64 dma_max_address(enum protection_domain_mode pgtable)
 
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
+	if (amd_iommu_hatdis)
+		return false;
+
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-- 
2.43.0

