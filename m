Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB413A40C
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 04:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274507; cv=fail; b=tKs8+7p5CLyvlNWy6qDHz6viNk5jlX8sDOFN2lK4GQXHmydL3o4wNaY40BAlYAUszGV5Ac/CTFwQByYKWiS3b+837OzAJuigA1mPppZXwtPgLPYyMgasIudcj7O6RamgXQE5VUdHwU6ydzXbEu/3nU9NHGsPEioGoJkysMOtU4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274507; c=relaxed/simple;
	bh=eOXA4F/b2Eev34tu7u0fjoTg4Y00fZMQW4WtpFOhxto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QgUKaIOVQDLMQK9SOp65rb5FnJ4IACEF3LkA5rMJ8yPduyRJ+T6IbhOZaylLXlo0jbxJ4NJIzQqVs5V7eWhHkrtmapoN4hO+BZPhvqwvCY/ji7x9IGBAh2i5/YaU/2t8mpsfGrz0wNkygXaU2kvPVKz8KC1IsYmtyBzY3Nqe7Xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GX5lj0yh; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GX5lj0yh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wOvMaa/rvnnC9Q+krDTB1zKPiH5v7RDfnipWtJBM5m5pidXhXgD1TZjeQe7GHJ/e578bskYVraXNGAS1HqcWrr6WVN2tFqQ+XoRwrpNchY4kjhAFHQ1HH5O7zdy5izARRi16AbpJKoHh+c5jHvtPS68hrWUo4F0XOZhLcR3oFrCgwzs35no1f9sYnx+h3LSR+z4m7Kv/TeoJpHp49Owk2U3WmcL15EXIwesMGjDzxiIuvYrutSbl2UZ7Ka5ePMnBoaZ8nKYedhoo87erVMT0m5tkaPcEjCUmZT5mtAUuzstSZpt81Tz9DYGlOccUAXv5fkU/Sjqjt2/W3fC23cY5NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZf3+QOnlSReo0Pvb5i2i4P9ALO5gVk7fvIq/C7nies=;
 b=AT1oCzddBfLZ3k500pw9kQWspJsdO8TbBqb3CCaT+V6Ef9ZE7++F48mih0ocOtCUVdVGXlh/+5kB5NKcTEiGQGo85R9bbCm+cqV0+LPIqNe5J0BaWTNElCnDjOOE9jnrxqnsBaJx086YwMrSfwTEacMWqUxdCWmexgY++ZZaKyZm0hsBNcSwWUWYZvvPvvTRAw0anVtT5w4FYlRZlOdX1WQ5gw3yxlqVTXJ/srAPFxxB9teD9kItiPYUwqNmqFJbl4QutWxIHS9dUQxTn5bQAJIWGgRTl2iVeq1zNU5Jg97WTrJLFUi3FPgsbtTsvkkFXrlVlRT5XgUBFyuWrTuOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZf3+QOnlSReo0Pvb5i2i4P9ALO5gVk7fvIq/C7nies=;
 b=GX5lj0yhNg7Rhkybfn1h26E1uAqRTNTkNpi9k7mBYuFtTCSfxdxAuhZmMEJUsK7epGq9BZjT82WQg4PhAnMThssBsSXO0c+526FiCIAEYMaDlF3d8wEdeZR57j6lNLIQG32AboiKsbHFoqXb09kyXWLZzqvUy2hleImESaXUwY4=
Received: from SJ0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:a03:39e::13)
 by SN7PR12MB7226.namprd12.prod.outlook.com (2603:10b6:806:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:15:01 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e) by SJ0PR03CA0278.outlook.office365.com
 (2603:10b6:a03:39e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:15:01 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:14:44 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Mon, 7 Oct 2024 04:13:50 +0000
Message-ID: <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|SN7PR12MB7226:EE_
X-MS-Office365-Filtering-Correlation-Id: 743b9111-ee36-490a-ae87-08dce6869d29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o/LBflCCatT2Lfjx+DjnLMkrIwtd7DXesG9fDYnKANrmWk6bU0CFtD3f7R9b?=
 =?us-ascii?Q?1kCL+hhmQG3Rm4bd8Fd3Mlt6UPBqM1601yy8gV/DT3tgfzT+cAu/SHcYGguI?=
 =?us-ascii?Q?hflRmzvVUyO8vGJUIwyNJlVfRgF8yfwRjD5IroYiEdNjqN0ZGqBM3RA/ePw2?=
 =?us-ascii?Q?YtmFQO+v5a0kYpxI8fhhq9o0DkhHmBhgWO4D/zlaGDurbdIriKcT1e6I1MQ7?=
 =?us-ascii?Q?lJqPJxFo6hJlAZqfG59/OFOXugitBqrbGWt3BdclXYujjNMRnAdAhQGedw6H?=
 =?us-ascii?Q?UeOPLE9RQL8YUZzwE2/gQesLYkJzcET+HHMRqy/zu8L47gjPz3yPEKzX9N8z?=
 =?us-ascii?Q?Uy6ziuFQ+lCJY/J3AXCmU60kTgS9FgSjWXcipYHIfZYWpjlJrDRXCmqAoZxQ?=
 =?us-ascii?Q?EwKE6ybua3LLasWA6R8SeJmNm0mTQxZTHOCRrTnVUwKsfaCd0paSFn+1taUo?=
 =?us-ascii?Q?w1IqTbpDsTb6o20Zeo2BtA208Y32Je6x1bCSDjLmmIu31kFlca+Or9CtBvXt?=
 =?us-ascii?Q?YfAb3+t2yRykXeEe72EFxIGV4h9kAE9gL9jSO88pF+Es7+bXi51GZJ3HKVBW?=
 =?us-ascii?Q?zt5ay142gc40PQhZ3HYliJDdACmOApfkGtJmsTr+rNI4c88ZZRTRZnMdaiyY?=
 =?us-ascii?Q?OMrrwgGVVaVGDYOrIjoMvZEahRA1CNp6f03QOorLemQ/WFsPw8/hXDaRzkOx?=
 =?us-ascii?Q?DvTs/tLEbyNzUZRISUGjru6dwLIN+fgiIWYbxdl45Z7rGDQ4veao6jEWRrW5?=
 =?us-ascii?Q?ldhYoIP76TFb7BTwrsFjJWhrVNXon19Eomw5nZx73tmS/kixM/lYhX8rKpFV?=
 =?us-ascii?Q?yDlTWh7GcjZ4trZwsneu21QLtD7+8GJvwrnTTzf+q+GQURnAdbjwpoerrCLX?=
 =?us-ascii?Q?owi9POa8+qnVHudOxWn39Fj8kB16Lyolg5uM+oYtAPjtGP9A+9DNdGeUiZ17?=
 =?us-ascii?Q?iizlFbDCzdcDfuX4RN5GzzAZgF4Wv4YfEPLoY0figMpyDcVZOYL353hUAEut?=
 =?us-ascii?Q?QPyA4QBkKuJmAjVhGcFLNf+LS10/vtqatHMkdYbDta3h/6Np9eMfVRQm7H5J?=
 =?us-ascii?Q?EEg0Qe9LfJDr9zJPu+t0pTXtuEcMHHrFmDjsVc3hVg8DWHAcrZ2QEvmr4PBu?=
 =?us-ascii?Q?eYkx4LmFZjc6VdKbEtYORP3TtbA9PzxpkQuVa1yn2fle+UZxbiBWpi1lnbhm?=
 =?us-ascii?Q?oOpRMcen4rgrgYKQiyjF5QyaQHBUJaeacoOdQf4J2S61QYQVwcfcJWLaDRa7?=
 =?us-ascii?Q?az2FO4D/9JPL92yL/AQe5DkuGRvDPFpeJvrLXz+dGpnBOJ9mb+BhxDrufb8s?=
 =?us-ascii?Q?77CPTaWvSGhjIjD05yKgHjYdGqAwl8WjcU9Wn3f7zMhJezVBGiWWofsyzwVw?=
 =?us-ascii?Q?rwfB6upsvAmurxjt7FXOdj9nRckn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:15:01.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 743b9111-ee36-490a-ae87-08dce6869d29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7226

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |   2 +
 drivers/iommu/amd/iommu.c           | 132 ++++++++++++++++------------
 2 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 91f802be7898..74aca19725cc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -427,6 +427,8 @@
 #define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
+#define DTE_SYSMGT_MASK		GENMASK_ULL(41, 40)
+
 #define GCR3_VALID		0x01ULL
 
 /* DTE[128:179] | DTE[184:191] */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index deb19af48a3e..6fa2f5bb5156 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1956,90 +1956,114 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void make_clear_dte(struct amd_iommu *iommu, struct dev_table_entry *dte,
+			   struct dev_table_entry *new)
+{
+	new->data[0] = DTE_FLAG_V;
+
+	/* Apply erratum 63 */
+	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
+		new->data[0] |= BIT_ULL(DEV_ENTRY_IW);
+
+	if (!amd_iommu_snp_en)
+		new->data[0] |= DTE_FLAG_TV;
+
+	/* Need to preserve interrupt remapping information in DTE[128:255] */
+	new->data128[1] = dte->data128[1];
+
+	/* Mask out old values for GuestPagingMode */
+	new->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+}
+
+/*
+ * Note:
+ * The old value for GCR3 table and GPT have been cleared from caller.
+ */
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dev_table_entry *target)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u64 tmp, gcr3;
+
+	if (!gcr3_info->gcr3_tbl)
+		return;
+
+	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
+		 __func__, dev_data->devid, gcr3_info->glx,
+		 (unsigned long long)gcr3_info->gcr3_tbl);
+
+	tmp = gcr3_info->glx;
+	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+	target->data[0] |= DTE_FLAG_GV;
+
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->data[0] |= tmp;
+	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
+	target->data[1] |= tmp;
+
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->data[2] |= ((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
-	u64 pte_root = 0;
-	u64 flags = 0;
-	u32 old_domid;
-	u16 devid = dev_data->devid;
 	u16 domid;
+	u32 old_domid;
+	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	make_clear_dte(iommu, dte, &new);
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.data[0] = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.data[0] |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
 	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
-
-	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+		new.data[0] |= DTE_FLAG_TV;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.data[0] |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
+		new.data[0] |= DTE_FLAG_HAD;
 
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
-
-		tmp = DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
-		flags    &= ~tmp;
-
-		/* Encode GCR3 table into DTE */
-		tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-		pte_root |= tmp;
-
-		tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-		flags    |= tmp;
-
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
-
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+	else
+		new.data[1] &= ~DTE_FLAG_IOTLB;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	old_domid = dte->data[1] & DEV_DOMID_MASK;
+	new.data[1] &= ~DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

