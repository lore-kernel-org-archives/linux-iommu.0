Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815515ADAF
	for <iommu@lists.linux.dev>; Mon, 16 Sep 2024 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726507137; cv=fail; b=QA/NsaYxISAtHjLtCfgNZO45ptwFpnF6yuBNWsTQMJtwMl5Ay0hvCp7kGOWFuCGMbSNBKvKxr5kv54Vo7gufEmfC8Sd1XZBGJ38NQKd/aCw/AQ6g25F9ncTbNuMOZfOxJTOqRXLimoc9NK/rDPRwWvEOXRG/UZHdejl6NiI9wN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726507137; c=relaxed/simple;
	bh=lBG5nv5dXJxp4+mm3F5Z5R0IeJuDDRuvRUue5lugTvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpZKBLOhNFRNy+qof58qMk7RGePUgwdtcl//LXgCqB6SiJm09yrpjicEvVAyqPsaYlXZCjApr9mGOW7L4AFTL7m5R0RUS83TgzsgPL7uczXdg45zILo42J27ef6Ep6emmQYtX652AwUzqHRPGMwEMgkWj/lAeXLiqxyb9wVyyiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YvfTonTZ; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YvfTonTZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h16iQQ2rKUFrVxjJO07l6YQGUmVAeVpkQotPH55nJAqM+38wr8jj5iyR4eU4RYEJD2GxQbqfCcSzNOASRYwCNEF95UudJuLtxYXzoJgVcwl41aGGwHyWohks2UNRbXcMBDbASHPnErKr5htKcn6bCmNtVmSTZVf3e4T/QwrLcnSNteW2IGR00b+LjGzbloIzbjIZt3b/eZcs03HoGhnSHGkSlzhMweDHz13x9/Es3S++zdqDxUb21HoXdHS0bpSsIihn0sOgwIsUUCEUhciAwId/AN9yTmlgSqL+TkwACvy7wPBAMF2e0IC7PHUFyH3iuzszH1OQS7Y5vASB5IWFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwHUomeIAedLsmsRqoWtjxl5qDnhh8DUgivQYgI3BNE=;
 b=gUPJq8+unfA2odqm1k0HLWztD0AOe+pGOdsiDgnEUtaBOuaL65tWhR3YTbYFfV23O0G86MOUb6w8YW0twMooOjTDtVmAAOASXMCnFVZ0DorCJgvm9UQQKk1Y9o5bWiIUoCqevcMY2bxdBkZXa6hxhY3gTPseLOnHI1TibMEsgLTUwFtCTOKBTtiQM0r58XQg4bcS6/Z9/esur7Ot+tSXKPLVQeVl36rCKmdipwYVg51K4HdDraRffh9/6kisVAJ6eRjaOdp4+hEywwi9zIeSWytuqZLpx+ASoZbGkgSw8NK0yWx6njB3mw3YvIzbTLM95WNjkaoU5RxHkm/pb1SiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwHUomeIAedLsmsRqoWtjxl5qDnhh8DUgivQYgI3BNE=;
 b=YvfTonTZpZ1DFP50uzjxI8i5l+w99aI3g8XiyVZwb1RRdwCzmUVQX7ccWJIyvMdvPTFZ3DlOkKU5j76X+iQXZL745hcDpyiVzhbpsXXoO8KsjhmzCDvC87scQD2nEpCcqolywLElcoCcfkGiU5ReROAgWQP7lBGNZe1xGPEK4Fw=
Received: from CH5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610:1f0::12)
 by LV3PR12MB9267.namprd12.prod.outlook.com (2603:10b6:408:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.22; Mon, 16 Sep
 2024 17:18:52 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::53) by CH5PR05CA0007.outlook.office365.com
 (2603:10b6:610:1f0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15 via Frontend
 Transport; Mon, 16 Sep 2024 17:18:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 16 Sep 2024 17:18:52 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Sep
 2024 12:18:40 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Mon, 16 Sep 2024 17:18:02 +0000
Message-ID: <20240916171805.324292-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
References: <20240916171805.324292-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|LV3PR12MB9267:EE_
X-MS-Office365-Filtering-Correlation-Id: 541d8675-2775-4c95-adb3-08dcd673a2e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yQdxJMw5gqvVKmZdmYLYG+V+pk+vT9iJwyIkA9rjuzH9JetsqB1I4/AzsAtc?=
 =?us-ascii?Q?5aIQBV2YEW13Az3dbrJ9xW9oJV+hp9BLlhtHWnxqLSDKelzcSoQ2TKDR7Fh2?=
 =?us-ascii?Q?qsTwdFXR79ghY90CVXJnL+oiUeBw4uglM+qFMIBl3OY9F8BqfPQrYHf6sOcl?=
 =?us-ascii?Q?rWhWY8pxMv76xeqKHetGA1hnfimPOgs1Lms1+PhdUgCN4BGg93Zv05m0JWm0?=
 =?us-ascii?Q?i4gagG0xgJTqO+HBZryeEh0T/XlkJrVl6r5niwVmVhsiEb7yX0wDlK1Z1q4T?=
 =?us-ascii?Q?iK6/9uIp1XFs9n0WSifcj374YNODV7zPIxEReV9BCrvYYxNERR/qgve3t8a0?=
 =?us-ascii?Q?4TiHu1PZNs2O03BFFzlrVzC8BBy70Jrv1SLAqmOrwOmJVtY8Z6Gq0ABnbWj5?=
 =?us-ascii?Q?oqbmvlx9F/mwbVWZoDl6FGxp9qWq+6HlczyCr7T3XLf1lEknf2+sB7prg9bZ?=
 =?us-ascii?Q?TM74s2+V8y21n2OdyG6D6tBUADSPC+ccrzG/vwScZrpcxglGMbV3kbmTnETc?=
 =?us-ascii?Q?58Ld3zpV8RdQl9sRL/TWDjPa65JSfFAW1BAzq288cMLHjIq8ZEFVmkdxOnnI?=
 =?us-ascii?Q?/zbRf6tl8FVmglitQTTtKme6ewLFlP/yKt8y+X7ssXVoz8mn2C5s8b+AIwwB?=
 =?us-ascii?Q?5xYkbSssUWPE1uhX/AA5r4JXC3mU4EjgtklWSnfauChvHSuyW4s/CjTvkwNJ?=
 =?us-ascii?Q?ary0pup2XtvWSXwv8VZyF8ijL7LmEWDMtIz2CnrubET0b7NZStwc/spJfE8B?=
 =?us-ascii?Q?ZNCI6DsFU7fmw/oRn907SynWfe4Edxg33orit4LxF2UC9kECGHM4AoSb0xSz?=
 =?us-ascii?Q?g2HepUEzT+sxnGtp/zHElFRsc/7cggyDRncPZr7P83hdeQrXeZhL7RjlhpFs?=
 =?us-ascii?Q?Ygl0cMAO/6TfEwdjn9d9iL0OqSMcZdxVEce94r3ZioDgfGQENeV36w6cvNV9?=
 =?us-ascii?Q?92awVft2TZXZoXx4vmFhV9/v7CSAblm0ToAoL+XF+gKkzs4F62ryRJyjXLhJ?=
 =?us-ascii?Q?PXb/XZ1sGb1sl40kKhWqCiEBzjhlPEaaimhZe+RzSYrzmVO/TpwEWA0UNWpj?=
 =?us-ascii?Q?woP53yMuFJF/u9auVyLgsfkq+tOpkxE1zWivzUKqQfLymTvwm1GXi/2GtMtp?=
 =?us-ascii?Q?jVrN+Cw9ljDSuF/aDZ0OygV/g+me4SCNabGCGbEO6h2wGHQJVC4OlcolUAgl?=
 =?us-ascii?Q?oSqedeedgh9T4oEDDV4sLTBt9nG4t0hahBMHxp0oKf5eqdyYpjhwVGPyNXgv?=
 =?us-ascii?Q?yXdB+LctnJmAzU9IW76cxl59MRT04F4GPTMq0DLFaJeCJX/OLO0I3FKuaL9f?=
 =?us-ascii?Q?IUvD7rG9jbX8xOqp6qDh4o1ptn9j/X90pj0mdq6OWoRybtv55cFkZFqdwAiq?=
 =?us-ascii?Q?nv6JwHwYMkZxjMRb3/pRIcV30/CQHhtx9B9wYWlrpjlhZe9R2kuBJp7fMMMS?=
 =?us-ascii?Q?Ra2SpTyDukOYbDVnVl2/Hx1T1T90GjX8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 17:18:52.1334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541d8675-2775-4c95-adb3-08dcd673a2e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9267

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for setting up the GCR3 Table Root Pointer,
GIOV, GV, GLX, and GuestPagingMode into another helper function
set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 117 +++++++++++++++++++++-----------------
 1 file changed, 65 insertions(+), 52 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 48a721d10f06..12f27061680d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1947,17 +1947,58 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
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
+	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	if (gcr3_info && gcr3_info->gcr3_tbl)
 		domid = dev_data->gcr3_info.domid;
@@ -1965,72 +2006,44 @@ static void set_dte_entry(struct amd_iommu *iommu,
 		domid = domain->id;
 
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
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+	else
+		new.data[1] &= ~DTE_FLAG_IOTLB;
 
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
+	old_domid = new.data[1] & DEV_DOMID_MASK;
+	new.data[1] &= ~DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
+	/* Need to preserve DTE[96:106] */
+	new.data[1] |= dte->data[1] & DTE_FLAG_MASK;
 
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	/* Need to preserve interrupt remapping information in DTE[128:255] */
+	new.data128[1] = dte->data128[1];
 
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

