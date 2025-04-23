Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC220268684
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391047; cv=fail; b=syAg6HFaIiZCyrVXO4lpQcPOh+VD/M7VfzTs7yi5BdhCaw0D7Zv59jdDjdtrE1s9p63eWtgq/B4zBZqRXjesH9yXEuiZPYRkLqz3kqDyfznjWc95WqjgOPJuP+OzQUUPWzWWEFLrPKHcyKLMPoGVa8AybOWlgLkeMFMvl6VwAuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391047; c=relaxed/simple;
	bh=9NOpn8AI7yYrbf9di1YfrFXDbGP7f7KtMEGOkp09aJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY1arQy9atvNAMu0wGkAtwXfksqiFKgs7a/+tAuE9Ga7nxmA3vpZmYMaI15WwpCFr5F30gZcnqC/11jOVDfExMaqPBDjWUfOiIRCKKggdHQHgl9oKFt6h7IaSZyD7jmUUklK7TL+Ptss5WFRYnZM7jZl95PZn81QDvLCsPEW7d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AP+3yWtZ; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AP+3yWtZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qa3YOvPZub3scIZx7uQiUBGz6/ruXLqMs2ZkCGuedIvTgLWDjmNIILdkYpZiIlsTniH0/CwFiKeeJPhtpr9C9j7EIKV3U8CezJ+Vojo+qNyFX3z0nIqw06GPrTOb3eoOKxl3XUEZ+FRr3FKglNDtgx/PHDzr1AeQtsRzhzkStc8LbwoWmjqG9rN02VPTcgYbFKBsti5JF6OQyeJzqvkE2LA67PDSmst4rfIA8EqQh7jsHRbZVm6tZOTKLkkEAh1K7E1mYtEFs8aBJmU9cULArC3kw5y8IrQJ5PfzWkMqyOdcHY6URBR3kddND+vYU1BvE7Sc/pRrfl1rRgm0Vq0Zng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgl9wq2Z0sQ1jt/ttNu1qEAKgbK+V2h2Qw6KTg1nom4=;
 b=CbQjordVeySBraquL7IYFi8yJ++y0mBLO793TD8wJFvcWI0T5AtsNS1X0GmMYVJ4yY9PYYuClbkp+w5LpAdVpoXet13ESPgP6qwlzb16HjbOMGSZ12kj1/9bGMVtEogZJk5rud9u4LFOBGhogp++DDLETq9nwC2zHCkBclMNi1nxQyEYycachqIOAcQahU5xDPDvvUgH9CpLFTDT5XApwPKRnHxLiVibyTwZmHQdH20VwgHvaRCVOE2rsLesR/mutx/vDXw6OpHaOgpxs10QCt2vZhfbPl1yVMOn7gejRDin0PN5G47m42WpxxbCiIfnn9Vj9HKu37bsKQrYzklOAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cgl9wq2Z0sQ1jt/ttNu1qEAKgbK+V2h2Qw6KTg1nom4=;
 b=AP+3yWtZm8c7vlZxbrPkkRtrJLEW+KI3yk1ClJkbrTpRk8pH/YP9oiLMnxSEz4WAkeY912SOCwJttgOvW+e54IcaBgRGEyBr6upi+kIRuNXrPoh3oHnbExL8ZRma2jbqNO5hnTyb5qHGucj58370BLlWZqak+uIWbWhzFzMICic=
Received: from DS7PR03CA0203.namprd03.prod.outlook.com (2603:10b6:5:3b6::28)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 06:50:39 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::c2) by DS7PR03CA0203.outlook.office365.com
 (2603:10b6:5:3b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 06:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 06:50:38 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 01:50:35 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] iommu/amd: Add HATDis feature support
Date: Wed, 23 Apr 2025 06:50:02 +0000
Message-ID: <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745389415.git.Ankit.Soni@amd.com>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: e022233b-7238-404f-340c-08dd82332834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbzjOLE3iG8EsElc2wsbojkr/ARWeYvWVdfGgrp03fYkdGLYLmDXR31sqo7P?=
 =?us-ascii?Q?aFPw5OoyKKVc+vqOkrr8rpwLc1xGZA0RO5bI0e5nodpR+ngEsowiv4gX8gMi?=
 =?us-ascii?Q?NBUIqSf7pZrqnzK9ZKTn/uI3bvihfWUkoPIA3ZiudFehr69rtaRVenKvdfin?=
 =?us-ascii?Q?xz75qt72mZGud/68lHEnmPe1jmQJ/xoLRAi2f1U+vJz3/FpZBmCGo3tWSBvD?=
 =?us-ascii?Q?utOapwSfSNvBj7vkbGlD3ztQxQKn9r63A27cNA0FglrOFn2N5tQFLWJFUup4?=
 =?us-ascii?Q?vibrsjXy/1EDZlcjO9dR8tQqkatsG0TpUAQmMntKKszsVn4MouFMtzxo0upE?=
 =?us-ascii?Q?QB3MjE/TfzUkcFxsKrd091ubeqNZ25lulgubC5apz20z8HY8g3SLVx5IRCbw?=
 =?us-ascii?Q?PIC95PfHuTQnDPCbYdbx6KSZa4b5f/Q27XZ7DOWYSfxcWBoissGju1ztIpxZ?=
 =?us-ascii?Q?J5zcsiUn52lc03cyjf9YOP6CxYK/AIyuWk26bRc8ZWvlo2YyffDovL7sTC+y?=
 =?us-ascii?Q?PNGTGUMdHH0B2H7Ysr8SWe+66Va9i3tRRNLDoNUDBCI2xY2SVFBcybtwp0+N?=
 =?us-ascii?Q?/yw52AgLABuVtDxLPjsIdaxsF1mEzwbMi+SMsRDvfPSIbPX2F6FFJp7Pklow?=
 =?us-ascii?Q?syV53zC/FojAHhBrlFRlcpfvey2LJINfwl4abjgbeUpmJ3yWEf/zqp2RXGV1?=
 =?us-ascii?Q?bWSRziufjW3hfjSAZjMu7dv5e26UpeXyMscA/bTc3CyVxGlZA/sxNzqxqDFn?=
 =?us-ascii?Q?fzSfgHDNcPNrihEgX8Q5pjKGVq6bTlERFSUEYtyLPpq/zHS0porEjl7WpHQK?=
 =?us-ascii?Q?JSGT2AqK/CYAhsa6j2Zoo9k3Xh9rd93QhSp53StMTmrh1SQ/7eHVBfVDAA+w?=
 =?us-ascii?Q?tRFjBkewZ2bGcVrNyT7wISpEXSrzDnjZrygaMrdWsCaL2HH/xhtVVihtiUOY?=
 =?us-ascii?Q?fkBWVr4+Lp+vBmXg3yxpPo/wtbX/r3D+2fLCG9/8T0DFyu2c6UcVh+HUaWMO?=
 =?us-ascii?Q?jthED7qSrNz16uPFr2lBDTDLuy5LlyF5rY9V743cDMgyuSizk5RoqZlC4eED?=
 =?us-ascii?Q?/edSQcJ8JhokCOdAoLqssSpreGy+W5Q2ZVGaLBEB8Xzrj4oRIAY2zoU84P7h?=
 =?us-ascii?Q?6dx6+TrO9DzXTUVG4+/MoZqDjxO87/wNSo5Ie61NnugV52/+VU/PJv1izmYr?=
 =?us-ascii?Q?/lYlGQHX/FjXxsWGsV3wSEsuNRWRXhd4Sz4KAoTOEjJ6//XOVofv6F4EVD8x?=
 =?us-ascii?Q?LAu3lasulCmnKHGX3YsSTW+71KjB2hWklv45T2cXlM/utS5hiPT+vnqboFuY?=
 =?us-ascii?Q?+dIJomSY9L+UnKDRTYIP/JTYQC/MbDmibvhgoML3UFH7nldM5vHpn4PoXZ5S?=
 =?us-ascii?Q?+zCfpGlNTYwtocC6BkbbHl47L9eTkWgn7+f0uGY7TOGDVJ6HQHcfGg1wd0WN?=
 =?us-ascii?Q?hKgI3xc7pR8zg6NON9u9z/y+eP0oTBW+iNEc7pvWjREusI1O34EIlx6vQVC2?=
 =?us-ascii?Q?GdC4+Z6DoL/TTEx5Ad4HCsTs8dwuyVymcqsc/hcwfsDSvcD99PJHg4giRg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 06:50:38.5150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e022233b-7238-404f-340c-08dd82332834
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

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
 drivers/iommu/amd/init.c            | 23 +++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           | 13 +++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 220c598b7e14..bb14c4800dd0 100644
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
index 5089b58e528a..284ff4309660 100644
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
index dd9e26b7b718..f71b236c2af2 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -151,7 +151,7 @@ struct ivmd_header {
 bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
-enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
+enum protection_domain_mode amd_iommu_pgtable = PD_MODE_NONE;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -168,6 +168,9 @@ static int amd_iommu_target_ivhd_type;
 u64 amd_iommu_efr;
 u64 amd_iommu_efr2;
 
+/* dma translation not supported*/
+bool amd_iommu_hatdis;
+
 /* SNP is enabled on the system? */
 bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
@@ -1798,6 +1801,11 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
 			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 
+		if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
+			pr_warn_once("Host Address Translation is not supported.\n");
+			amd_iommu_hatdis = true;
+		}
+
 		early_iommu_features_init(iommu, h);
 
 		break;
@@ -2582,7 +2590,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	u32 devid;
 	struct dev_table_entry *dev_table = pci_seg->dev_table;
 
-	if (dev_table == NULL)
+	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
@@ -3095,6 +3103,17 @@ static int __init early_amd_iommu_init(void)
 		}
 	}
 
+	if (amd_iommu_hatdis) {
+		if (amd_iommu_v2_pgtbl_supported())
+			amd_iommu_pgtable = PD_MODE_V2;
+	} else if (amd_iommu_pgtable == PD_MODE_NONE)
+		/*
+		 * If v1 page table is supported (i.e., amd_iommu_hatdis == 0)
+		 * and page table type is not specified in command line, then
+		 * use v1 page table.
+		 */
+		amd_iommu_pgtable = PD_MODE_V1;
+
 	/* Disable any previously enabled IOMMUs */
 	if (!is_kdump_kernel() || amd_iommu_disabled)
 		disable_iommus();
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be8761bbef0f..0ebc264726da 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2393,6 +2393,13 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
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
@@ -2480,6 +2487,9 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
 	case PD_MODE_V2:
 		fmt = AMD_IOMMU_V2;
 		break;
+	case PD_MODE_NONE:
+		WARN_ON_ONCE(1);
+		return -EPERM;
 	}
 
 	domain->iop.pgtbl.cfg.amd.nid = dev_to_node(dev);
@@ -2501,6 +2511,9 @@ static inline u64 dma_max_address(enum protection_domain_mode pgtable)
 
 static bool amd_iommu_hd_support(struct amd_iommu *iommu)
 {
+	if (amd_iommu_hatdis)
+		return false;
+
 	return iommu && (iommu->features & FEATURE_HDSUP);
 }
 
-- 
2.43.0

