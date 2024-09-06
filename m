Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FA1CC89C
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624837; cv=fail; b=cPic3UWbsMkhL7sil3ErvV8XSbK0JzNt1jJC+8aDjKO/Cmt3aKfmz+B/cjm9M9vP7qbxVssmT6FJ5jHNdFDwp/c8vxP/UnDnuNcEeHRNg50vuPu/0/AQBCExCwA8FjEtnxNOTUi2ui0ClbFrspwc3MnZMXje0kSG8NT7RTlrBSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624837; c=relaxed/simple;
	bh=sQD//MGIN9DIxCH4hHz3IbI3zwaR878BDwHyeATcjLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmbLWPQfbjlARqHjIGPK6G+CsDHCYxJgeO8VlEsdS5rIlphMzBCuChkV+uxbi6eBsokw05taSBGuIdkJ2ibP9FnuFsBAVedqWuvFiAbTAtYDDNhD6syLHLtIuEcrabnXZLbSoG8t3LsprNLNo8MnnAob14uEaCiCN4gUNarHX6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lzs5zt8W; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lzs5zt8W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpq0C08U65elI4JdxmQNtBRBXqYc+WZVgKrdHOsZh+NjlmIJlP4Nz12RkYiI6JfdiNXLhVsWWVVA7nTLO1h/VyxYJUwjzGJOLhDCgclB+6KNQfcemDzdKEzuKnIA6nGkWzHtq87QKThrx3aHcoi5VlZODtzlLqxzZqf09Z0wxljU2cPvhZ+dOQ0YWgZ6brmSk03aWhltBjOBTKcKjo/m/83OflfQbP3IBgIQIHhu8FDpOX9R68jsRAS6X6g5ap+5bMgfh3OMdgC0fbbi/STPQAUtfzL6IKM2V+qMhXYzlCW6ASqDUwMC2Avmtthtgfxm1AwS8rQScyb0qG7z9zFvPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk4dtWmW0BNBV2KFOs0JD7FgyxV7jms1oQqkPqIPz40=;
 b=Xb8KSxggOFz89cVpM6TXIMNhQ0gG9aa3oyDSBjjESxNWVS4EhUGEtSIm+ngEPRisw5h0xN6cI1vR0DCSeGLgZS1sp/D3BK6q0Asgg/g7iyzuEkssyyuuy4X+tPxTS3/33jpkBmzdjhL1Lxs+F/JKP+CI2MK8Tdi6CG1tO/HG9vqDa4e0eXcUQse7X276i5a5knaNu6OEta4RLKRd7YKN0dASXwLNWz1Ir+92uueF8QM28S/HDxySeKKAwqA8yWgCkzuZ+BiQNac8a9SBV0CR2jze6nWz4ll2W+lKu8qJmzmAQWHwP6op7l3QfjiVTrBDtRB1blBj1xp7TvYSIy4zOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk4dtWmW0BNBV2KFOs0JD7FgyxV7jms1oQqkPqIPz40=;
 b=lzs5zt8WI3FAcZ9yZlZOWELJO/XI8XpdZLEB2OE4mvSXFDgeBy2T9B7edhMqOA1YWcuLTZv9xRX+cusBcCMe3NG+jL22GxdZ/qmhEcQWcA+YW5WLzFMWZ+nlKzU0F+xy9IGqqkzsQ4LcOEx95Rrd/Ifl6irUXdY8aTfFnwULhlw=
Received: from BL1PR13CA0095.namprd13.prod.outlook.com (2603:10b6:208:2b9::10)
 by LV3PR12MB9258.namprd12.prod.outlook.com (2603:10b6:408:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 12:13:52 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::b8) by BL1PR13CA0095.outlook.office365.com
 (2603:10b6:208:2b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17 via Frontend
 Transport; Fri, 6 Sep 2024 12:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 12:13:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 07:13:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<ubizjak@gmail.com>, <jgg@nvidia.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 3/5] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Fri, 6 Sep 2024 12:13:06 +0000
Message-ID: <20240906121308.5013-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
References: <20240906121308.5013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|LV3PR12MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 364cd834-5fcc-4f7b-0991-08dcce6d5f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ev3RTPo8tUUiC7egH8aQP4Fu8jtaqD3/RRnfB2t0ykKaJhIWGrEoup+uxN0v?=
 =?us-ascii?Q?Drlo6AD1GvKBDDoFTr5JTDDIgdBwVJFe0mW1Sr/9eDN2SZXBtVXgJrSKt3bx?=
 =?us-ascii?Q?2nfuoGuNtx6F+oVoM7FBtIyx5KE6ZihlPb3OcLGqPNoY+GbUXv1a7QtZMmCk?=
 =?us-ascii?Q?hyNL9FsQKc/aDZ/AUQ8U1EdvMccxqr12zf9ysxBPm/VhvDn1Qgtr0hMge3ve?=
 =?us-ascii?Q?xQgVlS7KpNflMR+LHm+Y9nL5nTSKrW8R2hT2tMrhHarRDs+tG5BJnnQOHCuD?=
 =?us-ascii?Q?M63lEdSjvRT32n9V/moI0SK7cDtBButHzc0ulF91a3ovuGVTX1c0AHPS/7Qb?=
 =?us-ascii?Q?9yIQrv/4HrdWDt7kHzUsev9SGMCrsYl1LUg7LzksUlyK5L6J+/72fS56gt6D?=
 =?us-ascii?Q?bll5PViDRIl2wUq0KJIB34tLwqbEPq118dUbCerR5j0fuA/zwSXtqHWGWuLN?=
 =?us-ascii?Q?JSZaouMEmRH1TNng0/XJdgNHvn3d3HnAjGt+GK0wjyKXFj9QAhdpLXSYvRNM?=
 =?us-ascii?Q?zrf7fA+Dh6xtHiBIFnByywha7Vx7O8M/J8LqfuXkNbJ1FDV31fp6FaeuRlW+?=
 =?us-ascii?Q?sbLmm4DTJOQWwltrkJuE2XRnL7QxPBsUbrRPW7MEfhx+svjTJC0XaA3Fehd4?=
 =?us-ascii?Q?zf9M4sjGrEa9fuiCl8gN3UCwvgHm5scctr0kh5F4O8gA3ggby7RdQm1Lu5Yi?=
 =?us-ascii?Q?L9wYcQBxYYCCHnRgvybwRECiZMAFCKt1+CSl2qWNShotCliS9m4wtY3PcjrW?=
 =?us-ascii?Q?DleYVTF0igWvPsdNHdJuKLkQWAy1MqY/7EP/BXum5XmqCOHTdx7pE1KMWwxD?=
 =?us-ascii?Q?F53FAIN6hjXgHT08ONxSzhpGxrUFdk5VFwVPETDN3G+bqN6XWmDLQzQsRCcq?=
 =?us-ascii?Q?KCQsrW+iYau2tDI7zPnLTode2iwUbjm4Lt6oXSuubSilD9aLKKmUnZ9zFVqz?=
 =?us-ascii?Q?M3tmjDoYUoR66a3Edcin0BBQ0rmym1DYlFhyyyvU/0ODR9/Yv+aQ4TVd2Q2h?=
 =?us-ascii?Q?ujWfkhSXnKFa0Le+X5JTFD2Q0h6qxbr4vtu1uNRxU3QHRboBlVA+mJKRw+K/?=
 =?us-ascii?Q?Yr+H65ANxjI+FkZTaYexwVT+kYBY96UeoWe1yjy9YfwQC6KlwmBfZZxGfoyb?=
 =?us-ascii?Q?0OUGDzn+VAlx2PzmeYoQWaxr5zT2t9ETsUYv8zlTqoymoJQ/QV6Kx/WtZhFr?=
 =?us-ascii?Q?VI2Ygiv4+dJhZJm9f8vWVCA9Jk8wx9lmAFgUQzgPttknyEw01bJo06FhrBjv?=
 =?us-ascii?Q?Fq6B4NN8SDm3fJYRCDQX0xt5LTEtte69bqkBTdfI2evRz6lUwZiuovklpBGK?=
 =?us-ascii?Q?86j5irFaKRwD5C1+xUqD1HstufTOWtYUvtLHvCLKLop6nIGK+X2lvPuTrseO?=
 =?us-ascii?Q?S01wB18Ow72zHA4eufO9GZr82kF9xLGL3WaibvXgOfHeBLNLZ+/ZIm2GKl1Z?=
 =?us-ascii?Q?fQvtfVEsLrSPV90xMzOHrlgfXSotho+Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 12:13:52.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364cd834-5fcc-4f7b-0991-08dcce6d5f3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9258

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for setting up the GCR3 Table Root Pointer,
GIOV, GV, GLX, and GuestPagingMode into another helper function
set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 123 ++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b994e7837306..f18ae6c077f4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1913,16 +1913,56 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
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
+	/* First mask out possible old values for GCR3 table */
+	tmp = DTE_GCR3_VAL_A(~0ULL) << DTE_GCR3_SHIFT_A;
+	target->data[0] &= ~tmp;
+	tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
+	tmp |= DTE_GCR3_VAL_C(~0ULL) << DTE_GCR3_SHIFT_C;
+	target->data[1] &= ~tmp;
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
+	/* Mask out old values for GuestPagingMode */
+	target->data[2] &= ~(0x3ULL << DTE_GPT_LEVEL_SHIFT);
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
+	struct dev_table_entry new;
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
@@ -1930,73 +1970,50 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	else
 		domid = domain->id;
 
+
+	spin_lock(&dev_data->dte_lock);
+	/*
+	 * Need to preserve the certain fields in DTE because it contains
+	 * interrupt-remapping and other settings, which might be
+	 * programmed earlier by other code.
+	 */
+	get_dte256(iommu, dev_data, &new);
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
-
-		pte_root |= DTE_FLAG_GV;
-		pte_root |= (glx & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-
-		/* First mask out possible old values for GCR3 table */
-		tmp = DTE_GCR3_VAL_B(~0ULL) << DTE_GCR3_SHIFT_B;
-		flags    &= ~tmp;
+		new.data[0] |= DTE_FLAG_HAD;
 
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
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+	else
+		new.data[1] &= ~DTE_FLAG_IOTLB;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	old_domid = new.data[1] & DEV_DOMID_MASK;
+	new.data[1] &= ~DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	flags &= ~DEV_DOMID_MASK;
-	flags |= domid;
+	update_dte256(iommu, dev_data, &new);
 
-	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
-	dev_table[devid].data[1]  = flags;
-	dev_table[devid].data[0]  = pte_root;
+	spin_unlock(&dev_data->dte_lock);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
-- 
2.34.1

