Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA52E15D5DE
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084357; cv=fail; b=PYK8zr6piYZhy17Fpn8lNU+yX9KJwwCsQmRXJyTRHAxuCoCwN256yIuE2wV8Hb5FEKbAHyv3FV3O1TPNwdkcGoIIbLGssFMjH+agpE2OKI/Vn0rrsaX8eFKctvikYvktbexAO0hqTy3ZDG37En3dYHmJztOEVKjrNghiQbrSmVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084357; c=relaxed/simple;
	bh=1Otj7xl27xsQttpdXzono2azKXYU81XLFEtIBlSU8vM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RwBpkejOGy0q0iY4aWoaGWC5ZEHH1bG7cDE24J2ZWZsy9ESToSfg3eq9wDqK3L0MzXjld0PV2Flwtbvn5g6rA5Z1xFEae1fheqyLX+vjETccIiuA90466968+tnoUivL8vamhZ+E3QX8Xjc9o2QX19zPeGAiLUfdHbTLfFRnNr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AwXX7JFA; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AwXX7JFA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaBHuvDoeyOlNUVtDu2KYs+P5zMPGOfLFyXKec4de+oWlE6E7tLi37if+D6GOZ/5p/tCPVsHTDqlpVgO2c4sijDkQSnIzlEuHKqEdLnXDK3LV3YAuDAuhZmIuQGX6y2ZQ/lBxXQN/z6AmI4HlvcdbzV1cWgzKejMW40u2VtD7OYqcGNsueP7ZIZ2NljNfnrL+BhsaAPxk5TRcqCGlu7/Boea+CZm0nuYQG5Oeu+PcZNayST4H4n/ZDv4Ls51KdQal70w6XYllY7rMME5oSI/pQlE0t3rtCAfEEbKKeAl84yCB7g6nyeO+fXLY08jbKfL5pR7EIV5HOjGq4fiiRu8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Np5wsfh0M1LG2Y7nPISFJIR6gUMnQG0/KS5q3YL7rr0=;
 b=UFQzKQRSeHw3Hnp4ePp/Mkms3b4H7WJurVVrJi1sGyyNo2cKfnb1qVurXFpWB5fkK1lH8prNEQ5FUuEpmspVMWK2BZwduhUQE5E1FVf/H2bVM/ahPvG9IHDNzypsCUkw3kLG91tTgUuOKYMZlYlcsKSYib4Rm4sbhgm6OStxBA6/883qmWXNdaL79YXh3cF65a/ZIT8Jif+P8m/o5Xxc8B3Ldrsv+WW56+HiDsyEMjYsUdBoqE79DS1C+u/VR3x7M8KOuChBhwFHGABG5Cb7SkJyGDl/ZAql3lyFBRXn8TDmkGlavv+tGGsNGjImL99+DBG2X2HRX64jtoz3C2/J4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Np5wsfh0M1LG2Y7nPISFJIR6gUMnQG0/KS5q3YL7rr0=;
 b=AwXX7JFAbFMeUoaCwFY6St39g35spPc5PnnRpO1MT/QFbs/AWZ7Zjaefpzw4wQBgmiX5sb0q6bqfCA2b15Lc2+1Rt20NtSV+5R97UlJjN+E0ugFR87/MnNJ1TCrAO8q1/9DpFjpGaGXK84gYn33UN5KdFLP2l17n2Y7m4zMX/MU=
Received: from SA1P222CA0092.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::12)
 by PH7PR12MB7938.namprd12.prod.outlook.com (2603:10b6:510:276::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:19:09 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::c) by SA1P222CA0092.outlook.office365.com
 (2603:10b6:806:35e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 16:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 16:19:09 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 11:19:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Modify set_dte_entry() to use 128-bit cmpxchg operation
Date: Mon, 19 Aug 2024 16:18:39 +0000
Message-ID: <20240819161839.4657-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH7PR12MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: a0651e1f-0f94-4903-10ea-08dcc06aa7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bpMQpaaHZjfGe6oIUdcojNgV3urvBW6WQX3ibUg5LGR+q7KIqHZA+sT00v05?=
 =?us-ascii?Q?iYzuMRb5HXiNDdPsLE/lcjPrjy/3NmXEOo1uOVsplFtyZRfVporPjY2Or0mi?=
 =?us-ascii?Q?NRn6s1/EhoNS+PBPgs+MnOD3OgGnq06x7adiIYmmPuBP6dMFxqKZLqfW4BRU?=
 =?us-ascii?Q?vFz3+d8WWft6kA5/fg6M3FjloYj1ApVGbArfEN4yxajBcEExIgWe5zRWxJuc?=
 =?us-ascii?Q?1HPIRxl9N86JXk5aapBS1oqXo22zjWgBZ4srr+6veqjmi4rWPhXQGim1uwb0?=
 =?us-ascii?Q?aNJK26+iZ/9P/cGySu/HVTxT13jNXEZXinLfvOcpgLN7Z7EEZo6LfTr4YK0W?=
 =?us-ascii?Q?eeiJRZ0uRpyJp8PN9kVlIPUxcGGNpOFwrTC6yaFmqrnyP5WR42+tivxaIf10?=
 =?us-ascii?Q?3MGt9Js2Nwo175crAXe5Ahcu3TOxyjVsFZkdaYBsCa2IDtOAlTy4FbVu1l9O?=
 =?us-ascii?Q?a180xxwfGUgq25uuQmZtoBibyqlLSn/QEQy3nqLe2aB0ukd6epHHtzz6YCKe?=
 =?us-ascii?Q?uw52pVYteYxAeOBFep2I2EWX2rV2jpUnAJnnLNv/tHIRuAk1bhc3bh1N6qkV?=
 =?us-ascii?Q?D7u5rJKuFyZvLOgS1sEveYH8MuJMk4DYZXkeSeQkyRVCkxsRwt8/YUUpvQwl?=
 =?us-ascii?Q?TVxPHYkv/ryv+vqnPlloLdasN9ZM7uUNvJ4QV1O5DQAJ7uO9P36kSGDCeHfv?=
 =?us-ascii?Q?rHG9Jvgpqyat2PsGgBq1uiLcHpyD8bVEfyGJOba1lNZFxtpi5oz/G0nBPvQW?=
 =?us-ascii?Q?rNAwTz29wq5wce/zUmdgAe7yXN2sQLqF/G/6sOPoopzkYkGs99mHSWqYw+IY?=
 =?us-ascii?Q?0xnd3a7gGkhPvhKnXO/aE0Tx1vyH8HzAB5/zj44aprw2GOGtHO4xD8on9kt7?=
 =?us-ascii?Q?6vnVRSYVhnlLQ48c8F7lgMLHyea/ELCARr1rxX8fB6iM4fHeyO5Z13DT+2y1?=
 =?us-ascii?Q?fwUtNrtSfl1q7nMDEHQbOojhMsAe5xXIqX8KLLwBJXhxQVSi1TrFZgB2w/DV?=
 =?us-ascii?Q?0Y6Jwn4C04bA1ww+Y/7frvdCcUM9M+/jn0FRBbd+T+HD6yu96honaVQB+bt9?=
 =?us-ascii?Q?gcJE9UnxGb3xsl2eRFof/nJxvTKLF8+qfQ5EMkf6nFxRWwIJP/J/ibgORGA6?=
 =?us-ascii?Q?XMseQsDnyWEQyz0S1DQYMcMDSXkVrEhLor8rO+pclpOtit/H0P/QMZbVLFvE?=
 =?us-ascii?Q?V+CTbKMz1NCCKW/GxmJxzX0N2si/PNvrMVWOO2J/k2g6SNrmlB9FbJ1e9dNZ?=
 =?us-ascii?Q?iz/lmQdqSnhmrFRxd97LblTv2UcmFPZUDYmMcsjJcLqhVF+A4EzegLwZloaS?=
 =?us-ascii?Q?0jvPie9CX+I4zjLFqnfo39a3iEX1/plgRWc8JPNc89Tds4ai+zo1hbDRouP7?=
 =?us-ascii?Q?Gb6CVaK/rc67fxKxbu7uAi4VbGP8NXiIODDeXG2S4AmC6wYVbEb6Ofugs2HO?=
 =?us-ascii?Q?c+0OG7P3ORzdC/Qol+xqRFTYWvxbS5J0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:19:09.0600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0651e1f-0f94-4903-10ea-08dcc06aa7a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7938

The current implementation does not follow the 128-bit write
requirement to update DTE as specified in the AMD I/O Virtualization
Techonology (IOMMU) Specification.

In addition, the function is used to program several DTE fields
(e.g. stage1 table, stage2 table, domain id, and etc.), which is
difficult to keep track with current implementation.

Therefore, introduce new a new dte256_t data type and a helper function
update_dte_256(), which uses two try_cmpxchg128 operations to update
256-bit DTE.

Also, separate logic for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another helper function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  17 ++++
 drivers/iommu/amd/iommu.c           | 143 +++++++++++++++++-----------
 2 files changed, 107 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c9f9a598eb82..295138447476 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -886,6 +886,23 @@ struct dev_table_entry {
 	u64 data[4];
 };
 
+struct dte256 {
+	union {
+		struct {
+			u64 lo;
+			u64 hi;
+		};
+		u128 data;
+	} qw_lo;
+	union {
+		struct {
+			u64 lo;
+			u64 hi;
+		};
+		u128 data;
+	} qw_hi;
+};
+
 /*
  * One entry for unity mappings parsed out of the ACPI table.
  */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87c5385ce3f2..189f65af45fe 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1851,90 +1851,127 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void set_dte_gcr3_table(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data,
+			       struct dte256 *target)
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
+	target->qw_lo.lo |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->qw_lo.lo |= DTE_FLAG_GIOV;
+	target->qw_lo.lo |= DTE_FLAG_GV;
+
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	target->qw_lo.lo &= ~tmp;
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	target->qw_lo.hi &= ~tmp;
+
+	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+
+	/* Encode GCR3 table into DTE */
+	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
+	target->qw_lo.lo |= tmp;
+	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
+	target->qw_lo.hi |= tmp;
+
+	/* Mask out old values for GuestPagingMode */
+	target->qw_hi.lo &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
+	/* Guest page table can only support 4 and 5 levels  */
+	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
+		target->qw_hi.lo |= ((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
+}
+
+static void update_dte256(struct amd_iommu *iommu, u16 devid, struct dte256 *new)
+{
+	struct dev_table_entry *dev_table = get_dev_table(iommu);
+	struct dte256 *ptr = (struct dte256 *)&dev_table[devid];
+	struct dte256 old = {
+		.qw_lo.data = ptr->qw_lo.data,
+		.qw_hi.data = ptr->qw_hi.data,
+	};
+
+	/* Update qw_lo */
+	if (!try_cmpxchg128(&ptr->qw_lo.data, &old.qw_lo.data, new->qw_lo.data))
+		goto err_out;
+
+	/* Update qw_hi */
+	if (!try_cmpxchg128(&ptr->qw_hi.data, &old.qw_hi.data, new->qw_hi.data)) {
+		/* Restore qw_lo */
+		try_cmpxchg128(&ptr->qw_lo.data, &new->qw_lo.data, old.qw_lo.data);
+		goto err_out;
+	}
+	return;
+err_out:
+	pr_err("%s: Failed to update DTE for devid %#x\n", __func__, devid);
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
+	struct dte256 new = { .qw_lo.data = 0, .qw_hi.data = 0 };
+	u16 devid = dev_data->devid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	u32 old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 
-	if (gcr3_info && gcr3_info->gcr3_tbl)
+	if (gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
 	else
 		domid = domain->id;
 
+	/*
+	 * Need to get the current value in dte[1,2] because they contain
+	 * interrupt-remapping settings, which has been programmed earlier.
+	 */
+	new.qw_lo.hi = dev_table[devid].data[1];
+	new.qw_hi.lo = dev_table[devid].data[2];
+	new.qw_hi.hi = dev_table[devid].data[3];
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
-		pte_root = iommu_virt_to_phys(domain->iop.root);
+		new.qw_lo.lo = iommu_virt_to_phys(domain->iop.root);
 
-	pte_root |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
+	new.qw_lo.lo |= (domain->iop.mode & DEV_ENTRY_MODE_MASK)
 		    << DEV_ENTRY_MODE_SHIFT;
 
-	pte_root |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
+	new.qw_lo.lo |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_V;
 
 	/*
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
 	if (!amd_iommu_snp_en || (domid != 0))
-		pte_root |= DTE_FLAG_TV;
-
-	flags = dev_table[devid].data[1];
+		new.qw_lo.lo |= DTE_FLAG_TV;
 
 	if (dev_data->ats_enabled)
-		flags |= DTE_FLAG_IOTLB;
+		new.qw_lo.hi |= DTE_FLAG_IOTLB;
 
 	if (dev_data->ppr)
-		pte_root |= 1ULL << DEV_ENTRY_PPR;
+		new.qw_lo.lo |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
-		pte_root |= DTE_FLAG_HAD;
-
-	if (gcr3_info && gcr3_info->gcr3_tbl) {
-		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
-		u64 glx  = gcr3_info->glx;
-		u64 tmp;
+		new.qw_lo.lo |= DTE_FLAG_HAD;
 
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
-
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	new.qw_lo.hi &= ~DEV_DOMID_MASK;
+	new.qw_lo.hi |= domid;
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	update_dte256(iommu, devid, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

