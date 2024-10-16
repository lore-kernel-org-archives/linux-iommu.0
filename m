Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A43318BC34
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055920; cv=fail; b=rkqfFJEoP/ypVMG8ZHtVHrcqd2V5VYg7xTGY973R/JWdENdhFsXg6SWALrm3RC0GqmGTY1tM21uFurm6NXmTFKO3ZgHSBrnMRr6vfQV+Ky0f8kNCm85USooQd+gBEYLtMBmRjte0ZaZa27RuYHCV3sU3hWd5UR0i06zXbItMDXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055920; c=relaxed/simple;
	bh=6NQidau1wUmALEXAAFDOpbGuUegul8175Iy5iFgxB4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEGR5FENoHI1DPMr7DeWh5CxszDX54yphJBt2kWbBDPbbucIt73F7CyVZsSGPYa0GNv5pTbeVJoao7pfslTWC5fXfKO75/4dGYtITm4gDtjkzXEdWAJh52TA5tU7YVKYyF8nObGGgz8eFmqEnkG6BsohmA/gGUlHxa97xNZIjlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CVj6/kly; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CVj6/kly"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQKIUDkXQM6+sXz7FB0D8jp9aMHQ2LsuwKD+NxtmZySV5wMe9F87K1FtNkYibvZQERfnhiq3Hflcc+03JIbCdJoeBIKoMLd3v2wBYFd9WnZuMGzZ3dyED6Wz/hgvxlJwZKb9dgsM44WRSy72jxEiPk+6LH+f+QeOOuR2L78iw0hkIPqsDSkqQuR4xukcPs3OETMsoN/1qi7s0qXzig/L/V7xpvGpqi8myonC7ODXKZ9Po2MG0a86PbopF/kwPWJU7io8FR7H0GYa3OvGkI++5bC5TX9cbRwfwZCv1uDQW7tTM1A3y8vRIE0a/cI7OTLJSyETUmYOhI/6/4sDdRclLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MhsnrGDPM/QMogm+fTmuoSEcIFZiPIiyIUZ6+fGoudw=;
 b=P6VzLaSts/BPE00wxDTLAGoV9oj+Myr9z+xSEFXD3PBkXPeZ0s7SPR6mh14JXj2Q/0287IuPisGt4RYimifjdqEH3Nwe5P0oqQZ1S2tS3bfDAGzRAEo2oZlPluSks+jCm6HSDA4I2N5HN03fXIcbp6+CZNrVXwan4gfkzrEuqxDNU4kGZDNJt7HOX1mXTnYIkSg3kNEAYL+ofsfc6qK+IbhwMdDyLOfgBu3Qoko7HHONHCJXhX5QY3XSZ2fkxpwFhjxZ583yl3VDrlJTCwU1D1asSwmj89BURTUtRpKoo+qTHhzpETQryrwuF5RZK9ujhkuXxQosLUnyG58GR7QP6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MhsnrGDPM/QMogm+fTmuoSEcIFZiPIiyIUZ6+fGoudw=;
 b=CVj6/klyfVUTEHiJlHj5dBj4GmEhKxmqAXcl3mu2E+wB+LOLH8UriXdU3Bp7laQFc1e7mxBBOpVM9+ltQFqkPrv5GvH2arT0ToXd0ruE6eXJ0Uwso6lMZOiF8AxCSSBOuK2K9GiVj6tPaBRFOePhK8R+bP0V+VxTQMfRNg1e98s=
Received: from SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::16)
 by BY5PR12MB4275.namprd12.prod.outlook.com (2603:10b6:a03:20a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 05:18:35 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::6f) by SA1P222CA0012.outlook.office365.com
 (2603:10b6:806:22c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 05:18:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:18:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:18:30 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit DTE helpers
Date: Wed, 16 Oct 2024 05:17:52 +0000
Message-ID: <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|BY5PR12MB4275:EE_
X-MS-Office365-Filtering-Correlation-Id: 55791d10-2374-4c20-7780-08dceda1fc05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LHVEDWdYeMy6XwtR1gp5Uay4/ihkkgXsxR42H720cuQAJpEwYsg80605oq8d?=
 =?us-ascii?Q?AkbJMSex2ldBSK1snIJBsku1X3gt2dvkZtvqTJe56vRDwypfUQVdRDMA2fI4?=
 =?us-ascii?Q?+9LdJ30wgNguVHAug3h+eJxSjn18hLcSIef6q9w8DrwphAi7jrBnexNPAow6?=
 =?us-ascii?Q?CcKSRIvn5t7xMM5g9YxUZZYKl9p4pgaqyLIpwZJm+a6z7sjVpHuos4PQU2/Q?=
 =?us-ascii?Q?YM8KbpYwQz855SQDDzTsyVsMHR3KKXO+mNB9SzDImwsmC89jUqt2WNqj2HKK?=
 =?us-ascii?Q?43Ww0+4FC+pHiJvaXSCweYGzSUZxWL998pSaLWL30y0jAJgcPMSb/51iEEMs?=
 =?us-ascii?Q?bcEOb5wpaauAtYrHstb6PBsMy32IfDvOI8Jdy8XtNoK5TxKEwOm0UWGjLbmG?=
 =?us-ascii?Q?SjbuSSszRcEo7wl7GAIfhenBN5XRGyfS2t4V0LFh6gDH86Q3YWmkcN6Pphfd?=
 =?us-ascii?Q?Z39e+8gpabXnymBPlODgLC5v05rRt4u/+LlC98q2bd8OvpgxMgLkNXBadydZ?=
 =?us-ascii?Q?IOBIUoRwNApysbq2LTjur1ZZ6TCtSxI9L9mbyrT6NTHq7u6WHsBitZVbFK5I?=
 =?us-ascii?Q?hN6jo1E9hya1PZO4VykgVfw9lLczu0LrIRZOWsKBIflxXF92qOiWARIXZMse?=
 =?us-ascii?Q?luz9fQP+RQMj0GxgmhifmC1MFmZ7KvXLzBxqfT7o2sAlZboHravHhMbE/k4c?=
 =?us-ascii?Q?hy4Kuw+CnlOw/80yh4aIW6eQqosGXMvG6UW+r4LQ8Q3oFFcy7ORLz8ADzsA5?=
 =?us-ascii?Q?fXjMZ8VHjlm2ei9+78Fze6ck0jUWY4iJlFKMQSc0OxueTj7rsX513LfL3xZ6?=
 =?us-ascii?Q?Ntifsz26Qk1M2fs80UV19+qZjPQlHx4/XdPns0K8ImPREEFTblwWl0cU1aRa?=
 =?us-ascii?Q?aMKd2xbt6aniCo0Bay0BoGaQcQQmWTyQdxjz8WJM366SvrMXiFCzz8TwpAUL?=
 =?us-ascii?Q?bw9NSPmDSKrsJArG3taE+l7APvIzeBC8RfAEsKOaQxYmNFoU0bm3OPV1F60+?=
 =?us-ascii?Q?I3FrAHSNHdRJi2OtMwHRpoUXTSAxMGaPvB0FJjGWg6/QkYbuZsSQZIRtVmrF?=
 =?us-ascii?Q?kfTxhx3fXxg+36K2E07QMSXTX5wS3fKnryKOnBR4BmtrOkvK9JtsfFpoYeoB?=
 =?us-ascii?Q?eLH1w1L3CzjIj/hMTtf5SVvljX8M1J7iBXOYo+EMW/DcypGAKZSpIDXD9Zsd?=
 =?us-ascii?Q?63kyMGeEIAgYH15wDu0gt8wLXZZ7ZpPUl1RIcs34I/107nd0HEv0osRTdbiq?=
 =?us-ascii?Q?IMkL10gdVYlszI6wh5dkgsxGZSPAm776N1sN/Lj1HWruQPg6Ea5sEnLP74g2?=
 =?us-ascii?Q?bsZ6JjI2mEqEgBLhyh1xbkbJmcF5baqm8AElZngws90Qm9P+xpxtess7mFrI?=
 =?us-ascii?Q?iL5w+V0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:18:35.2564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55791d10-2374-4c20-7780-08dceda1fc05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4275

Also, the set_dte_entry() is used to program several DTE fields (e.g.
stage1 table, stage2 table, domain id, and etc.), which is difficult
to keep track with current implementation.

Therefore, separate logic for clearing DTE (i.e. make_clear_dte) and
another function for setting up the GCR3 Table Root Pointer, GIOV, GV,
GLX, and GuestPagingMode into another function set_dte_gcr3_table().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 126 ++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 28516d89168a..1e61201baf92 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1954,90 +1954,110 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
 	return ret;
 }
 
+static void make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *ptr,
+			   struct dev_table_entry *new)
+{
+	/* All existing DTE must have V bit set */
+	new->data128[0] = DTE_FLAG_V;
+	new->data128[1] = 0;
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
 
+	make_clear_dte(dev_data, dte, &new);
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
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+	else
+		new.data[1] &= ~DTE_FLAG_IOTLB;
 
-		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-		flags    |= tmp;
+	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
+	new.data[1] &= ~DEV_DOMID_MASK;
+	new.data[1] |= domid;
 
-		if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL) {
-			dev_table[devid].data[2] |=
-				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
-		}
-
-		/* GIOV is supported with V2 page table mode only */
-		if (pdom_is_v2_pgtbl_mode(domain))
-			pte_root |= DTE_FLAG_GIOV;
-	}
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	new.data128[0] |= dev_data->dte_cache.data128[0];
+	new.data128[1] |= dev_data->dte_cache.data128[1];
 
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

