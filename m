Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A71CC8A7
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478222; cv=fail; b=k8Y57d62H3vFG9bR8Zw52M4NEajF1cW7B4GVDabIcrpUNShOzy4RM3iZHOmKLKFWZcz/Zrp3xnxf1gagEWPmNyybvazfzqTeZICAcox9M9N1Hi7GET/2k7+saEjwI7a14Dtsl2U/LLdDlEvNUxIfNcM0UzS3GjNuB2ba+yq3s9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478222; c=relaxed/simple;
	bh=jpHJ2al8FOn0Z+Q1yy1S00HSe4XZce36Tt1fSG4E2bE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8piOnGjnwroYO1oAqIG9bBBg6mp8qDxNw0tzIZJeGtPXj8KRybJjnkCfw3h22/YptWgy5F+qCbz4ZoVw1/abJxlKl1c1P8YshUWvoNktK1wB1rhc/HakA6ktwvK9l6dcscCPtoK7RxrCkRIuX3NUXc1yH+rwwT+2VghRdPpIUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k37Qd30S; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k37Qd30S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybS4N7dODfz9Vzm/JrV2OzEcoZCza6IXQKq84hJ6sSap2ksqM2vW9nVbwb2uYPBkBmTUOzuw2HKtA93gyxm9zH2/wWhICOY5YQmgTx/f/Ay9BA11wtyM5TQL8liCADdxTtvSK66Kcfyhkq/MWAx8upehoyb0n+uNDCx3TALRmDVDl1vcYVeEkhTP99MrXQpRFlDyv4NYV8OvPWaEKwosEgXEy0BqkK34RsK8UuvVXNPNmBO89LCnQXF+In2hkrTEvArz7B2NztdqY29napUP3Fc0WeiYaU6ZCPoytSZXmiRO13jxDO2/0u9RwM0jNWwHNNy99eoqRdl6oZDqg57MnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=vX5wSgAcFYKqJNwqFSXnhOXviNg/7AsJCqb1AfjQeyhKyN91U+rYMqNkaHOwTJNBFhazqzp+mLmSmGJB9P6bf35i1FbP3YTgtCI/pKDP9Ad4EvmSkpAtnaFfX9XrRy5UyU6A/Ha4n/NNUVYLyqD2P9BHtWNR+mOIg+zeqQmQQ2ANT2IDCy7bt7p2h7cywirA532W7ZIcbdd5AUDhisc7iQzHH75VPU1hyCHI2UEWPCAkDApZpSplKkMuhyKspqV2AswnZ4C8jANkM6mlP1R68sJm+YYP0heg7YbniiTzJhl61RcBSYSTof4ojtFGCoHAEKdBYdVmqn2XZ9cTjon7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjXHdjGcX4/L11iyd2wCJPLWf1/5/zh9tSHEiecH+R4=;
 b=k37Qd30SYxZQ3Bjq4t60CrVJvOck2lJ4syfbt3SkryuAWXDRO29o8QMXGaKPuaQVYGH4CIItq1L+bFEXXeUO0e15T8PUrr9yxZkZsxUwaLtMGSmdjBCptKjpHaAAycDENjmtug0p8JhGU1cbkdP8s/pwhlAnS5ZZsxss41MdVR0=
Received: from SA1P222CA0046.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::14)
 by LV2PR12MB5775.namprd12.prod.outlook.com (2603:10b6:408:179::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 16:23:37 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2d0:cafe::af) by SA1P222CA0046.outlook.office365.com
 (2603:10b6:806:2d0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 16:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 16:23:37 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 11:23:33 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v9 04/10] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Fri, 1 Nov 2024 16:22:58 +0000
Message-ID: <20241101162304.4688-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
References: <20241101162304.4688-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|LV2PR12MB5775:EE_
X-MS-Office365-Filtering-Correlation-Id: fd261420-818b-40a1-44da-08dcfa918a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+PBsVwFLE706jnL+Wj46TWDgsVUXAnKNwbRIMhXRAJZnKOJ4CgTcSPKAzoP4?=
 =?us-ascii?Q?tkC01YK1ItNhnZree1WhPbOl3rWAB8BVYaVJKRhUT8jIUE9vFvzKoyUwRdd/?=
 =?us-ascii?Q?L1KEkqf4w+u3z7o2MNZXqE89xmoKxgA1xpMXA1fXyxOblMoLOzOStlLOJsnl?=
 =?us-ascii?Q?lkGQUSXeS7knqsQgOVguRtQCfbMjb57Ip0DZ7SqHMFh/0N8PbG7ToK/WhypB?=
 =?us-ascii?Q?64GCHEVWzGupCFhV/bw2m37cq2abmbzbizE+KXh1LB32T0HdhJ1rKSaUU0CZ?=
 =?us-ascii?Q?C1n0lx3A5lObra3MPHFIjWQrieulSwDzYJgewf7G+jA3q5xpJPVsfMit6uGG?=
 =?us-ascii?Q?vAXK2oODsY2RUolqmOWrcyBkw9npwqqcnk7EfMgDfFZqQvvYhxcyA1V5wJSk?=
 =?us-ascii?Q?/qdI6jzU9h5CeRVixTR8sgD0CSLNnV5rXU/y1Pyx2ntCWVi95PvDJB9NOMnV?=
 =?us-ascii?Q?QqxxCtVox+TlPK7JiYbPE1s1K2+KRDfdFJ/ZKEAFf18BoXhOvIVnfUCG2Nkz?=
 =?us-ascii?Q?dPGReyefV+v2bD9Km/DW1/9jP3MkHoH6rd6yqDnpFj45VL/S/HuT/x0/yXtd?=
 =?us-ascii?Q?DGZjvQScDFEKkcBW10fsh5PMquIC1sRQ6uAh6MvTVcRC00RA25mxxDkDqAvC?=
 =?us-ascii?Q?fRjELsO1wrBKsz44pdxOa344nK6hzNdwjpBNPxPEz2PN9tZnHKBjwuAV6ztq?=
 =?us-ascii?Q?bkXa6mw1A1PeU7NlVQaRg7RlklFz6SZmMH/AvF6B1kD8Fmo//QdEm60uUw3f?=
 =?us-ascii?Q?RYmlaf4w6B0Ul5RjAs4UZBnZJebJgOHWJPSUGsvSfBJOypqTopYsza9XrhVQ?=
 =?us-ascii?Q?CijydkVveO155XrZqTMLZUawfd/QxjohiCUuSCvFKb9vjcy+BJybShBsgWS9?=
 =?us-ascii?Q?rmWqsz4JMNYJllL04CwPtDaWN114llYrkrGZEJ63Im2tPavVtujhoVZWOQSA?=
 =?us-ascii?Q?+BHEo6m38+3UfYJ+8O6VJ2BfYf/+m1X0rkWDdNOTwD0S84wqjUvPTAGKRJka?=
 =?us-ascii?Q?XZ5lRMmPtiyPWrS8oz7gNnCD5iMlbzq0hx6nbn+g98P/4+D1W1sKnpAOMN2y?=
 =?us-ascii?Q?tb34PNoMMnkylWjk1ACi9qicMWdD7Yq8wpTmc+ymMX1F/lkTJKQ+rD5nHeP3?=
 =?us-ascii?Q?6SCZqm+lzWftxNmrEQX7FrAjCNB/MbXQljh1DGZssV8/rohWPGtGLYxiGzDs?=
 =?us-ascii?Q?ABBpf2e9aJjhGA8W4Hwdo9UhYiyH5NJ5GcPXmlaB+v1xPmMMfl1isHoBGJSV?=
 =?us-ascii?Q?yQdgcw7O8KluHfpi7sNgplo+TbaKY6Q2EyJMBCZoe08UgNBY6VgIvWEx96l4?=
 =?us-ascii?Q?rcCj9973Fxn3duDwVc+D981SQmFfuUXi6N0fBwFbRrmCYFGAT7luKM4IROLh?=
 =?us-ascii?Q?/SZ1C41uvSiMO/71MoVIco123rqOleQpttGpCp6aMUp/ChRLJA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 16:23:37.2510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd261420-818b-40a1-44da-08dcfa918a10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5775

During early initialization, the driver parses IVRS IVHD block to get list
of downstream devices along with their DTE flags (i.e INITPass, EIntPass,
NMIPass, SysMgt, Lint0Pass, Lint1Pass). This information is currently
store in the device DTE, and needs to be preserved when clearing
and configuring each DTE, which makes it difficult to manage.

Introduce struct ivhd_dte_flags to store IVHD DTE settings for a device or
range of devices, which are stored in the amd_ivhd_dev_flags_list during
initial IVHD parsing.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  16 ++++
 drivers/iommu/amd/init.c            | 113 +++++++++++++++++++++-------
 2 files changed, 100 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index af87b1d094c1..ae5f1e031722 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -220,6 +220,8 @@
 #define DEV_ENTRY_EX            0x67
 #define DEV_ENTRY_SYSMGT1       0x68
 #define DEV_ENTRY_SYSMGT2       0x69
+#define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
+
 #define DEV_ENTRY_IRQ_TBL_EN	0x80
 #define DEV_ENTRY_INIT_PASS     0xb8
 #define DEV_ENTRY_EINT_PASS     0xb9
@@ -516,6 +518,9 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
 	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
+#define for_each_ivhd_dte_flags(entry) \
+	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
+
 struct amd_iommu;
 struct iommu_domain;
 struct irq_domain;
@@ -884,6 +889,17 @@ struct dev_table_entry {
 	u64 data[4];
 };
 
+/*
+ * Structure to sture persistent DTE flags from IVHD
+ */
+struct ivhd_dte_flags {
+	struct list_head list;
+	u16 segid;
+	u16 devid_first;
+	u16 devid_last;
+	struct dev_table_entry dte;
+};
+
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c1607b29ebf4..015c9b045685 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -174,8 +174,8 @@ bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
-LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
-					   system */
+LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the system */
+LIST_HEAD(amd_ivhd_dev_flags_list);	/* list of all IVHD device entry settings */
 
 /* Number of IOMMUs present in the system */
 static int amd_iommus_present;
@@ -984,6 +984,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
 }
 
 /* sets a specific bit in the device table entry. */
+static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
+{
+	int i = (bit >> 6) & 0x03;
+	int _bit = bit & 0x3f;
+
+	dte->data[i] |= (1UL << _bit);
+}
+
 static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
 				u16 devid, u8 bit)
 {
@@ -1136,6 +1144,19 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool search_ivhd_dte_flags(u16 segid, u16 first, u16 last)
+{
+	struct ivhd_dte_flags *e;
+
+	for_each_ivhd_dte_flags(e) {
+		if ((e->segid == segid) &&
+		    (e->devid_first == first) &&
+		    (e->devid_last == last))
+			return true;
+	}
+	return false;
+}
+
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
@@ -1151,27 +1172,66 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
  */
-static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
-					   u16 devid, u32 flags, u32 ext_flags)
+static void __init
+set_dev_entry_from_acpi_range(struct amd_iommu *iommu, u16 first, u16 last,
+			      u32 flags, u32 ext_flags)
 {
-	if (flags & ACPI_DEVFLAG_INITPASS)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_INIT_PASS);
-	if (flags & ACPI_DEVFLAG_EXTINT)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_EINT_PASS);
-	if (flags & ACPI_DEVFLAG_NMI)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_NMI_PASS);
-	if (flags & ACPI_DEVFLAG_SYSMGT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1);
-	if (flags & ACPI_DEVFLAG_SYSMGT2)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2);
-	if (flags & ACPI_DEVFLAG_LINT0)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT0_PASS);
-	if (flags & ACPI_DEVFLAG_LINT1)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_LINT1_PASS);
+	int i;
+	struct dev_table_entry dte = {};
+
+	/* Parse IVHD DTE setting flags and store information */
+	if (flags) {
+		struct ivhd_dte_flags *d;
 
-	amd_iommu_apply_erratum_63(iommu, devid);
+		if (search_ivhd_dte_flags(iommu->pci_seg->id, first, last))
+			return;
 
-	amd_iommu_set_rlookup_table(iommu, devid);
+		d = kzalloc(sizeof(struct ivhd_dte_flags), GFP_KERNEL);
+		if (!d)
+			return;
+
+		pr_debug("%s: devid range %#x:%#x\n", __func__, first, last);
+
+		if (flags & ACPI_DEVFLAG_INITPASS)
+			set_dte_bit(&dte, DEV_ENTRY_INIT_PASS);
+		if (flags & ACPI_DEVFLAG_EXTINT)
+			set_dte_bit(&dte, DEV_ENTRY_EINT_PASS);
+		if (flags & ACPI_DEVFLAG_NMI)
+			set_dte_bit(&dte, DEV_ENTRY_NMI_PASS);
+		if (flags & ACPI_DEVFLAG_SYSMGT1)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT1);
+		if (flags & ACPI_DEVFLAG_SYSMGT2)
+			set_dte_bit(&dte, DEV_ENTRY_SYSMGT2);
+		if (flags & ACPI_DEVFLAG_LINT0)
+			set_dte_bit(&dte, DEV_ENTRY_LINT0_PASS);
+		if (flags & ACPI_DEVFLAG_LINT1)
+			set_dte_bit(&dte, DEV_ENTRY_LINT1_PASS);
+
+		/* Apply erratum 63, which needs info in initial_dte */
+		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, dte.data[1]) == 0x1)
+			dte.data[0] |= DTE_FLAG_IW;
+
+		memcpy(&d->dte, &dte, sizeof(dte));
+		d->segid = iommu->pci_seg->id;
+		d->devid_first = first;
+		d->devid_last = last;
+		list_add_tail(&d->list, &amd_ivhd_dev_flags_list);
+	}
+
+	for (i = first; i <= last; i++)  {
+		if (flags) {
+			struct dev_table_entry *dev_table = get_dev_table(iommu);
+
+			memcpy(&dev_table[i], &dte, sizeof(dte));
+		}
+		amd_iommu_set_rlookup_table(iommu, i);
+	}
+}
+
+static void __init set_dev_entry_from_acpi(struct amd_iommu *iommu,
+					   u16 devid, u32 flags, u32 ext_flags)
+{
+	set_dev_entry_from_acpi_range(iommu, devid, devid, flags, ext_flags);
 }
 
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line)
@@ -1332,9 +1392,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALL:
 
 			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
-
-			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
-				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
+			set_dev_entry_from_acpi_range(iommu, 0, pci_seg->last_bdf, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
@@ -1428,14 +1486,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 			devid = e->devid;
 			for (dev_i = devid_start; dev_i <= devid; ++dev_i) {
-				if (alias) {
+				if (alias)
 					pci_seg->alias_table[dev_i] = devid_to;
-					set_dev_entry_from_acpi(iommu,
-						devid_to, flags, ext_flags);
-				}
-				set_dev_entry_from_acpi(iommu, dev_i,
-							flags, ext_flags);
 			}
+			set_dev_entry_from_acpi_range(iommu, devid_start, devid, flags, ext_flags);
+			set_dev_entry_from_acpi(iommu, devid_to, flags, ext_flags);
 			break;
 		case IVHD_DEV_SPECIAL: {
 			u8 handle, type;
-- 
2.34.1

