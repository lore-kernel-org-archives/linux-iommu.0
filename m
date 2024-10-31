Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4083B194A54
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366222; cv=fail; b=hktFH8Yau62UlbckwyoRnpaUOW+RnLjC7+fDlvp4U2mZP2D4+AdiiFQjdCypN4kkW6XtmSiZo0M/2uZxI7cHWf/Jocy1fttTvMJN0kCHuNvx43YKkrXzFflkG0b6O7mSXtAribZ+PEvaCZTXu5O+C/pNmpysaCKVpJrQqxuiuOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366222; c=relaxed/simple;
	bh=GFV0gf3C2Xs7lDJc/FjV2EOmZKS7y8SCgRwF4Ecq/e4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEgn7zq2D6lag0oypEA+C4k0jPPAc80oNEDA34vcBBLC26TGpBxEfhT9GwOJyepc4gVbjU/po7hHFAfl5cEKaPQR49IBm/AMmGI7EO7AYcsJNdbXHZOjniPGBmp9NJrgB4URUHwJ4B1djEjsubBJrae0GtnjTBmmSK7PxLVnDcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X1G4Jqis; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X1G4Jqis"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjcszuk8l7igHuYhROOdk3ZB1+9AzA6IDAmnzx8aUJqLGRFPowTd7Uo4xO9fcjTfDW4mVl7zXivYqsQRvdImTzp1fe9fqByi8Uct3Ly9T4YxhoKmVyhIvEXSLbPJYhuqKJtxFbhh4VMEFi6dDQsqdEgkXjhAv7+MGz3HwfA6DxU7f03sW1bg2QdxzEVD9NTHYPG6ij1qUe9ZEVOmi77Y9DCRb+1oJpt7GBzbaOZ8HHmDe9RXnggHzBSLL769RiC6WcCFKA4xGy4bmGhgm7wdWZGnRApD6sS0G8Im8YL163Sziq45pUNMS9ziUy2iMi5FmJbbkOu5GeiM+WsDFpFNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBLsczqGu+oRKvDYx35SP7mmGs5cch3vbDfk7SGpLiE=;
 b=cnRo3OE1iYfscIqncObVs9cJ4aeE1gl3NJ7gpB5+lL3LFmn4qtfolHtEwLSYoOmlFHbFyg/wbEXu+yb6h2/XfFcK5tyx/N84I45sIwzRhZi5kB1IrPKW+kvT/bO95C+J7r2vSpY5f64onm8ov0C0om9eioQ+jQmd28j61IGWDC/E8aAFfC0Bb/476aSVot7nWKbqWLdYTdIE4kyBJRBh7N8C4kYTGfsUkA46/Ba88JPSHIBsD01BgVv9Vq9+7EZQ911jcjgCghxhiNuof4vTAYa0jUUIhQRy4ChQiL20sIEJYRzt8K8pvL1xH9pa4dng12xVPHiSDZWgAnSaNJfkAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBLsczqGu+oRKvDYx35SP7mmGs5cch3vbDfk7SGpLiE=;
 b=X1G4Jqis0Ia+YEAk1rP8ZBb6pQjA+IlO+6Lam8AtO1OyMmkMEeX2ywvb5IezbZyF96r57zNK0yOeD2h54rblnIsOhSWXNpvsmMf1Hj6XQW/dRlBrIdNwyphPtYeMAYbgEQDcAnSZTc7CQDrO4pKg4PfIQKH0N64DqN+v0YfjqeE=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 09:16:57 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::be) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 09:16:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:16:57 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:16:52 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 04/10] iommu/amd: Introduce struct ivhd_dte_flags to store persistent DTE flags
Date: Thu, 31 Oct 2024 09:16:18 +0000
Message-ID: <20241031091624.4895-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be938aa-45db-4164-cb54-08dcf98cc4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PfqVob1zFwgiQ+/DGRrJjSCQNqIL3d4pEMJ1/sobQUJvrEsekJf/4aS/7eb4?=
 =?us-ascii?Q?3j45SJHKUvlIS8cyGY+btJgMAXoAQkKjbJWGoLfHS5pafdnl7uep0LzUnRxr?=
 =?us-ascii?Q?u8OH0rRWX7D2tRezNPMDl3VnF7hX3hV//vuswqOarTfwlUMsUBDD8O3qN1LR?=
 =?us-ascii?Q?1zzWwxxUesujhaA/6uIMnJJR7fdVosu2qHBE3CQ3+kpHOQOXZwlchbrVgzZF?=
 =?us-ascii?Q?QPQ/FYWP9nIosnnF8kbpeGmOzG9LdGTLOPhYOdUh5ldhXzLxohSslJImeBq3?=
 =?us-ascii?Q?oYl5fOJ1fg1kyDo4jidLe7xEapK3XAw5XA/adrslOcGVIdsuu17MYgFEj3wB?=
 =?us-ascii?Q?E42hYmd8MKaTYSM2WeSoFVZr5WRtkNB8dCzMulgJ/FzJeWXKzHgtiJzuog4L?=
 =?us-ascii?Q?NhPDHx1uGPLPDZdk2v2IJtbgMeHWOXn5Ej2fBRfnlZKRwFM2ER/F/9HIXcbT?=
 =?us-ascii?Q?SR2H2vzs7YwpGUZo3CUVlTvgfEhPOqK9bRmkU1nzIwlseGopvDj6uXOYSnpb?=
 =?us-ascii?Q?bn0goXmXmBwuxSnjdLuyQ3HKfi6xu2Lo9HVehSlROwD7G8jxPvsqwcU7dUUf?=
 =?us-ascii?Q?dSzh/w2nmBjd0lDlOswjGrTEMPBrUbw+2wL6ixK3HbGuUvQ3BfBWT2R/zNRG?=
 =?us-ascii?Q?L6VuCfhedfReF385ZmKIip5JKNvhevP0v8+rvjHRFuTf2/7ZZOuBRPS+gl1+?=
 =?us-ascii?Q?wi5e6HHdPO2BGad0LXb8NSkWNN+Zrndd4sbdZA9T+mKsV6moQ0Qt3QBV7Tmv?=
 =?us-ascii?Q?uJ5gyPm7nfYMhOfRCkXKwh+/YYyq+Ig3npG87TICwOY9vuSf437vrOjbZRO3?=
 =?us-ascii?Q?wboWX64pyanurt1bJx20MCjXqJv+TaSwuwtX5FsrtvJ0B366CUeAoDcK026l?=
 =?us-ascii?Q?nA6NANMOPiSP4OsnbKUJeT9m05O4zQ0eXLdXTusL+5LEGyvaQHoBwBV7P0Ib?=
 =?us-ascii?Q?OYfh7IbOrmj+rm3MtNK5g7YAroCrebIECveLTeGBJfVg37DIPvQ5gqVTNhc5?=
 =?us-ascii?Q?aJxLC+8LlTcmLZ5ONTp0JjQmIaBVZ17ji4pFz2VwKQof2Onf4rlrJmuW0EMJ?=
 =?us-ascii?Q?vIIEQF78uK7mnIveEX4aRd/DCZXjda0Lx5njbAI8yKbAEiEYkLhGrgSZVSvK?=
 =?us-ascii?Q?mnbWiOLkBfv62HtR34Y68SYNSJznqRtre61U2YFfSy2Bd8nS769QAYVsgGWM?=
 =?us-ascii?Q?PL57Zv25tiqZhF4HDIAnK+1RfRpNQZ1GcldJjF2nJtKlwnNtFF8Ps60tVuwP?=
 =?us-ascii?Q?TsDg72MVxGHsCYvPDU2m5QuEgezNogiP++kP7db9WG/KbEheK+8+tFCQYhsC?=
 =?us-ascii?Q?sUn0c7yhgYwpYT8JCKBS/mmjqxX7EsNDXGmQ/f4KB45eiwdcoGyLw/akB9oB?=
 =?us-ascii?Q?Co9lIYoQ3ZXA81/SKWnJ2fJdNkm/+zqsMoeEbC/dUvmWy0RlUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:16:57.0698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be938aa-45db-4164-cb54-08dcf98cc4cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

During early initialization, the driver parses IVRS IVHD block to get list
of downstream devices along with their DTE flags (i.e INITPass, EIntPass,
NMIPass, SysMgt, Lint0Pass, Lint1Pass). This information is currently
store in the device DTE, and needs to be preserved when clearing
and configuring each DTE, which makes it difficult to manage.

Introduce struct ivhd_dte_flags to store IVHD DTE settings for a device or
range of devices, which are stored in the amd_ivhd_dev_flags_list during
initial IVHD parsing.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  15 ++++
 drivers/iommu/amd/init.c            | 110 ++++++++++++++++++++--------
 2 files changed, 96 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index dadc65808951..7e055a226794 100644
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
@@ -885,6 +890,16 @@ struct dev_table_entry {
 	u64 data[4];
 };
 
+/*
+ * Structure to sture persistent DTE flags from IVHD
+ */
+struct ivhd_dte_flags {
+	struct list_head list;
+	u16 devid_first;
+	u16 devid_last;
+	struct dev_table_entry dte;
+};
+
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8868838139df..98b4b116d557 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -174,8 +174,8 @@ bool amd_iommu_snp_en;
 EXPORT_SYMBOL(amd_iommu_snp_en);
 
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
-LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
-					   system */
+LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the system */
+LIST_HEAD(amd_ivhd_dev_flags_list);	/* list of all IVHD device entry settings */
 
 /* Array to assign indices to IOMMUs*/
 struct amd_iommu *amd_iommus[MAX_IOMMUS];
@@ -993,6 +993,14 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
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
@@ -1140,6 +1148,17 @@ static bool copy_device_table(void)
 	return true;
 }
 
+static bool search_ivhd_dte_flags(u16 first, u16 last)
+{
+	struct ivhd_dte_flags *e;
+
+	for_each_ivhd_dte_flags(e) {
+		if ((e->devid_first == first) && (e->devid_last == last))
+			return true;
+	}
+	return false;
+}
+
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
 {
 	int sysmgt;
@@ -1155,27 +1174,65 @@ void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
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
+		if (search_ivhd_dte_flags(first, last))
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
@@ -1336,9 +1393,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 		case IVHD_DEV_ALL:
 
 			DUMP_printk("  DEV_ALL\t\t\tsetting: %#02x\n", e->flags);
-
-			for (dev_i = 0; dev_i <= pci_seg->last_bdf; ++dev_i)
-				set_dev_entry_from_acpi(iommu, dev_i, e->flags, 0);
+			set_dev_entry_from_acpi_range(iommu, 0, pci_seg->last_bdf, e->flags, 0);
 			break;
 		case IVHD_DEV_SELECT:
 
@@ -1432,14 +1487,11 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
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

