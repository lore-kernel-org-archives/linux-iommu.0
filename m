Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA262147FD
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615151; cv=fail; b=dZmIooKLLolicPaEr5mYMSzCPQAfHXdBSxZUVf1bu5KzJShblyObAXKK6s2CiqPfnkUiZZiZ6ltqyYqsf4cp8P2d9O03vfJ9nMZ5K8hKA8nVWhI4WNR53NviINwYHE5ZGb8qlV+/zs+bBnrFc2LzgDGWXMLC7Bd1ULZj9aNXKCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615151; c=relaxed/simple;
	bh=obTaGv4NL1yfhXeGgwfKmlV6OwXi1EBavDUirU2sB9E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9/iouIwgafcOAYbcHLxXSmooODM9tv81VAppe6PElkKfKBxw8OHwMUCCtBT9feorrwsUBKA8/KK0JJ41H62EL6kiwkMY8r7uOhNxmvhM8am73r87HziguQQmGwcoGomHXWwCTae8ZH2Ez7vxxNnmR3UehFudmUvG+R9gepU8NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0xe3Vy9N; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0xe3Vy9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aM12p0Haht+rdQWC+B4B4+9LsF+k2/fU3V95kZz1EGu81Q4mH9YYu9mm5Juw5DClVeo0Ec1kuCmtAT/0+8sfe3X4OmY4jASiJgPydxjl4ZApjEYduB8I/wfLwCWYPtaLb7Fa1nHTis6BB289aCgKIyZ3WgJrzH9PAFTcP8wGKE9Gs2gfPygjJQx0U9LYMmvKE0CQD53+jM4M+rFNJkoqSAdeCEhp7nXDOuYNs7L459XW7cUlOKhqw3YFI8t0iKzR3z1C7OFHb9o8ixHWT+CO9jq7OoyXa4kenvOWVJvJ06AuROFSB0ndg50eAlx+JV8JsNJThUpDP835nxHi29o/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hcDXRTrTyupuG6qLmwZ4aAUmos3RPLIPxlwXbS5XP4=;
 b=x5DgBizoY9mHv92GkBpFrrbdo1wxGJxfQoGhDeYOoat9NPHsW8QEMU7hmbcebosyN4JsDzMOxdOi1CvWQrTmNWXAUM3wbSTsnQBN3rIGtX/3EtjvILoDSatusiA1QzerGR5BueYT5d/K92PLnKlnB8ppt/SIQKta8w+lzXLZeD0C8Vu/CBveV9ZqbsXaxlZHyMeoc74VrGRcdWcXCKxJMRNSPNXstxX3Hqx8iQYwQo/Uq6hXelm5G3h5lHGUgr6YQMwoPw8yWQA9j0EqNuafJ0yt48gH0dz1dzlRWDUQANQIfMF8l0Ph9hs0eAcY5EfxNqxnAmEtDEglWpX4wKDhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hcDXRTrTyupuG6qLmwZ4aAUmos3RPLIPxlwXbS5XP4=;
 b=0xe3Vy9N9u6cCSAhOUkAWJ+UQOTNtvy1F+9hMiph11K79M3S92ehvg3mOsUXxaB/vHd+sA2/svAmSWfj2jCAZosw9Wvd9rwXLNBx/MVZ9kHEZBTFD9oCfcXFekYst05C5T3htSydgGpaX61tMOT1pJVIizWnsHw5oBadegbMY/M=
Received: from CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 10:52:25 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::a5) by CH0PR13CA0015.outlook.office365.com
 (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.13 via Frontend Transport; Wed,
 7 May 2025 10:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 10:52:24 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 05:52:20 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] iommu/amd: Add HATDis feature support
Date: Wed, 7 May 2025 10:51:47 +0000
Message-ID: <a03c8eb9e998445eba8b18a40c53469eeef18a9a.1746613368.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746613368.git.Ankit.Soni@amd.com>
References: <cover.1746613368.git.Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 112194ad-ab12-4714-67d7-08dd8d554053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaL2CAl+tHqfdjh9aoHyMB4ny95619ms2Immv1DbJmcw2d5u7/HeWC4Mp8R9?=
 =?us-ascii?Q?6T3lakNdd0e3ysah76/8b8RIroiKFDF4cN4WSqhLUgLe69vFrKOP6WBCl1dB?=
 =?us-ascii?Q?Hh8Ih5SagJnLjaXdhCA0zF5g7QA5HfWXTM4BD9m88KR2Z1/nIpZOUqQTuML+?=
 =?us-ascii?Q?q8ejFCkS6nHRziITYOJ7bTTV8Rt5vxi9MHk7G1we67HzeuY0IH/KSTVmLRR8?=
 =?us-ascii?Q?Ld7uIHiNCecH8qhTbUWvNPEOlXwrkUZsGpE+rBmjQih3mB/BQKUeubf4DSsT?=
 =?us-ascii?Q?gZTY/LEwg3ZWQJ5qHBgG446R+R84wKFheYZ7NMtLCn5MNbOaqPTWE5ZoIJHv?=
 =?us-ascii?Q?1+XwLfBVpuBocpsVS2RBbZ6ZVA0b0Xiu9khRrTgVazkO666ikLVTPr1V+7uU?=
 =?us-ascii?Q?/jl4AjBHHOMzv7HnRD0UJydnjAZSdw9jxyhRAlCnb2aaxC0Bv59qXO1osug8?=
 =?us-ascii?Q?FPDU740C6622vmVRfG06rD9ONtxvB+fO5ReorWBF+aonq77nYTy9XcE/h8d7?=
 =?us-ascii?Q?Mze/vW85fyH2ZM5lQWAjow3gmiRyF2HfjDJ0kTuAHcIz7yvY3kqivwHSgnnB?=
 =?us-ascii?Q?YQSYA6vqtp9N+MFA2KPZB1NeJnI7MXFFxmCuyFtrrfBzkn0xCyNJ0npj1btp?=
 =?us-ascii?Q?3wRZniSd8wMYRIrBHxUwC6EgdqoKUfdLe2SC0rUsVfpVkFPY1HWVlpkoE+Co?=
 =?us-ascii?Q?cggPoOXv+ZCFh7Lt2WQHoXMwZFBgD5LDCGMLPnkP164hdcM86TKaj7LLYL1f?=
 =?us-ascii?Q?SHK/SofvE7QrV+BYcJZfxU6B42FWiv15EjA0RwpndZbXPewZ4v3Ja/jUcln6?=
 =?us-ascii?Q?Wi7+Wzajsdp7IrcMrTz6jhvbA7f5Mb6JM6PdVTfwXEb6piCF+NRmg4eVFaLV?=
 =?us-ascii?Q?3BWSetGQykfrX0Bwg6ktTL6fR3k+3QXtbyq3rTsot1LY94P3I4+t2nKa+ads?=
 =?us-ascii?Q?aTCFPDfT2uSo5bJ7uaL3C3cwF94kXXVAZ8rNRT3EX5WvXcnkJdu/LtL+kXKl?=
 =?us-ascii?Q?PDb4Zfk6VqEJ/TV3FjwQfoq71UYsAFTmOB/fL1wksx4nAqpwWLd8+dKGp2UI?=
 =?us-ascii?Q?2SES/UJL1mLRCkcymmgct4s4kFxi9NAnIaKYYWiSWtjDXcaPl2JSjbOhoMGL?=
 =?us-ascii?Q?0U1UhFLlclt4KydMOq4j9J5tYxvCsISkX4jvJliWN2qIwGxSmKPB1vxZkEUI?=
 =?us-ascii?Q?wCJL1dJh7CW+ih3uld2vVfbY+4L20g+X6DCE/InR3rMGKEXFIccvlNR7Noob?=
 =?us-ascii?Q?dHCijZ3bVip6fzpGwQhbiJosWkAGWDCT6OcMK5n4vJWe3++YzmfrSxW/Kv14?=
 =?us-ascii?Q?lik7SIWZxlY9Z+OztZI/YqMMiPvYAee0TCwILgwzYd3Rr4Tmuo8K3Px0Z9IM?=
 =?us-ascii?Q?jfbqRlGrg7VtRMNKzxGBMPf993sNM5GPeSuI7BeZEmp5a9P+Yz4BUrYy6RE7?=
 =?us-ascii?Q?CvdqKfdi/IuGdbLuEBK7/8HeWqNa7gV/+BiObv7D5C84fh/HWnJi69HS3taL?=
 =?us-ascii?Q?kGE0SVaYFhKs7814cePR7D2Vi5kz2tONN5nV7q68TbJ71ILIyWsQujlzOg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 10:52:24.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112194ad-ab12-4714-67d7-08dd8d554053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

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
 drivers/iommu/amd/init.c            | 21 ++++++++++++++++++++-
 drivers/iommu/amd/iommu.c           | 13 +++++++++++++
 4 files changed, 39 insertions(+), 2 deletions(-)

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
index 14aa0d77df26..cfda9f89fe1d 100644
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

