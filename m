Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9E2222C0
	for <iommu@lists.linux.dev>; Fri, 30 May 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748600776; cv=fail; b=hh6SYdIxQ17PThcaJVApeF6J289f5uZKSc5oxa2slGMWJl+YJx8QPX6GBHOq680aHW1Wx/ULuFS87TaSGNFwu8XAJSvxcSv1tKnMss/RBXK+JXObhpINEGu1g0HSjUc9cQf/CGcYCWDGeikhj/YluJaNYyyFurfRo7S5yIY1y5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748600776; c=relaxed/simple;
	bh=9HjgAeeB0bLVv0AklJos0Ma4Jqmg1pEOVJSp+mDSYrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tqbg2mBlrZxiuSH9iB/uvx0DbLOpk75HIgqvuUi3kgFvsAKdvyGwyEOZTAskMmvOjLBOnC7xkbJiXJeFwzbqvg+75fSkhAsDgaqD7J6UdARR2auYGEWtH3/tw00AzLzvfx9gGUrqmNsl0MHqvYs/nyQhQXAUs75uvX42a4L31aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2e57KUod; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2e57KUod"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkvJwlb7CAt067dZe/YkZkXToSolZosZFp2h3Iw6bksC00AIzbtpUGPSTZmmggScl+bE8BQql2wSWC3bb6NZItpw9hdgafzZfE6CHwCIbSRBiu8ezPLTny7mkoV3DTQ3bMOxEyuO/ud7gigkQdpWXCNkjqJI4lb3nde6U92eJeMe5ALpgKLU57OG9fJIHRc/2kcSb5mBg5FVd0YOORq3Ogqhyp3v/M9E2brL0Pq9R/1TWX6n0efBzyBLJoDxi+eii0BmMwRjAzAfWWkpr5ISbVrhuVlJjQ67/2Ft1fze4mICUDbRmKcdmhswOOxm4HP0oCi2X5e4/A5Wwa7mbLUykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXk8fIQS4YclrY+UZmEYdDxJfKDGreWu1ja+iLDW8rE=;
 b=bZyh+TtRWq18Zzj9qrdzBBGbLeHajfdFGHo04jkNp+LYxF1lfg+ipOU+iHxy3nja2O7iY6/dhwg7+kFirYGbazyjekfTjDFpcF9OKn1My/GNqaVNPWMavSYc74JhQbTz4SVNi8iM7EUCawEU3XDZFfQoqU4Rmco/PQiQy5ei0p+QIL1GQUikVYylP+nkMsw013ygQbmzj9fmqP9B7WiEFHiLYlLrNpNx1T+vAxi2bluKFUR80Uj0LIMbqc+D9Wew2E8/wCQiF4kUr6X20OjCZG+69dXqeisIF0uB8xYItLaNzlmxmN4wfj8xFlcdykAJuavHuLQsVtQlFNxB8MVHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXk8fIQS4YclrY+UZmEYdDxJfKDGreWu1ja+iLDW8rE=;
 b=2e57KUodtNpAf3JSUEdRzXkMdaoEACl2NpIPvPvZaUjsKODeTtFzujToyhhPTzj43rNvQztcGIJCAD7jYIHqRoW+ItGvpGn9tGMy2BwJmh1wpilURmiG4q5cSofqSdEmKS7wbUGaVwNpCAjHrIE4SOF2rd5FRYJn0Kd2SKeSMWE=
Received: from SN6PR16CA0053.namprd16.prod.outlook.com (2603:10b6:805:ca::30)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Fri, 30 May
 2025 10:26:08 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:805:ca:cafe::86) by SN6PR16CA0053.outlook.office365.com
 (2603:10b6:805:ca::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 30 May 2025 10:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 10:26:07 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 05:26:04 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <joao.m.martins@oracle.com>,
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] iommu/amd: Add HATDis feature support
Date: Fri, 30 May 2025 10:25:39 +0000
Message-ID: <3f7c062894a0513822d34cf07a2e24417bf2a408.1748599144.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1748599144.git.Ankit.Soni@amd.com>
References: <cover.1748599144.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe8547f-5119-4a7f-a305-08dd9f6463d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2AkjLCryg6acdomol/ldBoxPH+Vxw6US+yf9DHqVLrdAYVABCvl0DcyKoDMN?=
 =?us-ascii?Q?oCuNFbHOyVnO0OZve/dP7zbPMEuYbNFg87NnPCclSJwCUBu7+5rwQoHSa1AZ?=
 =?us-ascii?Q?WAhoLPfdOZf1BcGesNia0KFiZZTO/sUK6tcQhHzvlRrfAnY23NZTiHQbFrhc?=
 =?us-ascii?Q?EX+iqT9YKb8qGbQ7Aff+9Z7F0jWAVeVKeUaNL1C5N0J5mxkWFVOrYMHeZJgC?=
 =?us-ascii?Q?gR+RxKo3kiVB3JPCEgkD/HnL8YEbv1pi35uk/FDC2fLMKqwMl/c4/VNW9Xcj?=
 =?us-ascii?Q?s6BDTcR2lsWeRmWmk+we13IE3Nd/JGVSRAQF8MwTP12ZIHvW967aDbwn6Uhd?=
 =?us-ascii?Q?UlQJoXf9Gz0oekklqBY+CsKe8dnfOmcJ2lG0pGzL+Q6dkieDaUqQTkovWOVW?=
 =?us-ascii?Q?8lIeKhlyvFFZfV0pnZrHYKSKDnP+ZOCDe4AVl9k3Bh6IvQsPOWzYJJ3IoK3c?=
 =?us-ascii?Q?EuDkXGTipreKamqqpC1IqGCG0o41no85mQCB0QeG6KZ37ngDyWuS8XKH6OWi?=
 =?us-ascii?Q?FStztjZf7Kxyv9zRcfID/iEL23nFla+r4Qi/CK6hDpVzNAoEJvYK+OP92U/U?=
 =?us-ascii?Q?pnmY7wMEO78U8bQ0gnN2Fg6P9VX9R465qdOO5RxMo1aHeHkmoCtc0lzGDsyX?=
 =?us-ascii?Q?0wkQqZnfYk0QhAnWWdDocIPP2d/v/CT2eT+vgiaxpzrc/Z7mGZo4BSMBW3pA?=
 =?us-ascii?Q?027eMJNhaNMW2SYY1L7QZhmIaEavW3BmDW6ldr02l2L3MbCOMnTqZwTUqQYa?=
 =?us-ascii?Q?Aj5mJVMkAzwGSgWP8U5uEZPenulLgKF7CZ+Esu/denGV71pqHLG+rlB1xx5s?=
 =?us-ascii?Q?HRNP9LvsuV8ZiymqaiA1MJReWVLjjLn93r/9WjORPLId79q99juzLIkhK8zO?=
 =?us-ascii?Q?pRn3bzTXGs3tqiH1r85uRAGewkiLN1YTEow9jQ/J5g71ZAbEFgaQm51q2MLE?=
 =?us-ascii?Q?DLMWV6Gty1+FG8JBAkcN0qA8i2d3I3w1q6gdFrQigfqEGbgoap9XKq4UFukj?=
 =?us-ascii?Q?b/Qp30D4YmQmogDbIB36aZqQHum2B92f7aEI0lZMo+FckHpjia44lxfEUDkh?=
 =?us-ascii?Q?pemLrwKe39VvprM17AATYbqqI7NOiklEDZJLMmrY88h0x9dddt7VaDRV622K?=
 =?us-ascii?Q?wKnEjnvw3JD9E9WlHAjgrdAz5o9NUP1AhTB+OgDSD4B6MaoAgcHZlmYFgh5v?=
 =?us-ascii?Q?lKapNUeaeMMFa3X0Y0ogevGhbaoaFDMoEVKR+X8McsaJAu7ZnkWatXyzwW3w?=
 =?us-ascii?Q?vxr0xVmNuY4UGhBPHR41rda5PiYjyL9MjmT93rql7G3bVLgpSfzq4TcTcL2J?=
 =?us-ascii?Q?AHBwtDrMwRvGUDB6N9TycevA4HCs53NUgsAsCc29oNJNZ1doT2jBt/SL6hxG?=
 =?us-ascii?Q?YyNlek3EqMKGj2LL97OqmujnWup9cFc0KUrbr6yyQJeZf7xjIb/fqXTzxCsr?=
 =?us-ascii?Q?hSoFMFBT3d8SXsan9ClIN6gODYax1secZ8q0ZcLcQT/5rSfanUnwnTaW1r8u?=
 =?us-ascii?Q?zJa/RxZzGgxof7uO0+k6MgBRXWSOibWYRTMWNNvp9xQtPBs8jFh/lgkTnQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 10:26:07.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe8547f-5119-4a7f-a305-08dd9f6463d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

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
 drivers/iommu/amd/init.c            | 31 ++++++++++++++++++++++++-----
 drivers/iommu/amd/iommu.c           | 13 ++++++++++++
 4 files changed, 45 insertions(+), 6 deletions(-)

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
index 14aa0d77df26..aa28cddd3337 100644
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
@@ -2106,10 +2114,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	amd_iommu_erratum_746_workaround(iommu);
 	amd_iommu_ats_write_check_workaround(iommu);
 
-	ret = iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
-			       amd_iommu_groups, "ivhd%d", iommu->index);
-	if (ret)
-		return ret;
+	if (amd_iommu_pgtable != PD_MODE_NONE) {
+		ret = iommu_device_sysfs_add(&iommu->iommu, &iommu->dev->dev,
+					     amd_iommu_groups, "ivhd%d", iommu->index);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Allocate per IOMMU IOPF queue here so that in attach device path,
@@ -2582,7 +2592,7 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 	u32 devid;
 	struct dev_table_entry *dev_table = pci_seg->dev_table;
 
-	if (dev_table == NULL)
+	if (!dev_table || amd_iommu_pgtable == PD_MODE_NONE)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
@@ -3095,6 +3105,17 @@ static int __init early_amd_iommu_init(void)
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
index f34209b08b4c..4e9a57377b8c 100644
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

